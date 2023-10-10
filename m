From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH] tee: tstee: Add initial Trusted Services TEE driver
Date: Tue, 10 Oct 2023 17:39:00 +0200
Message-ID: <C7BB80A2-C671-4197-850D-0502E1051FDB@arm.com>
In-Reply-To: <20231003153041.GA568632@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0502909140044115941=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0502909140044115941==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On 3 Oct 2023, at 17:30, Jens Wiklander wrote:
> On Wed, Sep 27, 2023 at 05:21:46PM +0200, Balint Dobszay wrote:

[snip]

>> diff --git a/drivers/tee/tstee/shm_pool.c b/drivers/tee/tstee/shm_pool.c
>> new file mode 100644
>> index 000000000000..518c10dd0735
>> --- /dev/null
>> +++ b/drivers/tee/tstee/shm_pool.c
>> @@ -0,0 +1,91 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2023, Arm Limited
>> + */
>> +
>> +#include <linux/arm_ffa.h>
>> +#include <linux/device.h>
>> +#include <linux/dma-buf.h>
>> +#include <linux/genalloc.h>
>> +#include <linux/slab.h>
>> +#include <linux/tee_drv.h>
>> +
>> +#include "tstee_private.h"
>> +
>> +static int pool_op_alloc(struct tee_shm_pool *pool __always_unused, struc=
t tee_shm *shm,
>> +			 size_t size, size_t align __always_unused)
>> +{
>> +	unsigned int order, nr_pages, i;
>> +	struct page *page, **pages;
>> +	int rc;
>> +
>> +	if (size =3D=3D 0)
>> +		return -EINVAL;
>> +
>> +	order =3D get_order(size);
>> +	nr_pages =3D 1 << order;
>> +
>> +	page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
>> +	if (!page)
>> +		return -ENOMEM;
>> +
>> +	shm->kaddr =3D page_address(page);
>> +	shm->paddr =3D page_to_phys(page);
>> +	shm->size =3D PAGE_SIZE << order;
>> +
>> +	pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
>> +	if (!pages) {
>> +		rc =3D -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	for (i =3D 0; i < nr_pages; i++)
>> +		pages[i] =3D page + i;
>> +
>> +	rc =3D tstee_shm_register(shm->ctx, shm, pages, nr_pages, (unsigned long=
)shm->kaddr);
>> +	kfree(pages);
>> +	if (rc)
>> +		goto err;
>> +
>> +	return 0;
>> +
>> +err:
>> +	__free_pages(page, order);
>> +	return rc;
>> +}
>> +
>> +static void pool_op_free(struct tee_shm_pool *pool __always_unused, struc=
t tee_shm *shm)
>> +{
>> +	int rc;
>> +
>> +	rc =3D tstee_shm_unregister(shm->ctx, shm);
>> +	if (rc)
>> +		pr_err("shm id 0x%llx unregister rc %d\n", shm->sec_world_id, rc);
>> +
>> +	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
>> +	shm->kaddr =3D NULL;
>> +}
>> +
>> +static void pool_op_destroy_pool(struct tee_shm_pool *pool)
>> +{
>> +	kfree(pool);
>> +}
>
> These pool_op functions look very much like the optee_pool_op functions.
> Compare this with how the pool_ffa_ops is implemented in the OP-TEE
> driver. We should consider factoring out the optee_pool_op functions
> into the TEE subsystem instead so we can avoid reimplementing the same
> thing.

Makes sense, thanks. I'll propose a patch for this in the next version.

Regards,
Balint

--===============0502909140044115941==--

