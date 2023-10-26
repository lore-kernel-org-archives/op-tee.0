From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH] tee: tstee: Add initial Trusted Services TEE driver
Date: Thu, 26 Oct 2023 12:22:49 +0530
Message-ID: 
 <CAFA6WYMW9oYoJPkGZZzzortNmqAK4DaYU8WL-ciiS7ywsMsBXw@mail.gmail.com>
In-Reply-To: <8DD61032-21F1-45D1-9908-66792540BD5A@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9120430636710611791=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9120430636710611791==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Oct 2023 at 19:22, Balint Dobszay <balint.dobszay@arm.com> wrote:
>
> On 13 Oct 2023, at 14:47, Sumit Garg wrote:
> > On Wed, 27 Sept 2023 at 20:56, Balint Dobszay <balint.dobszay@arm.com> =
wrote:
>
> [snip]
>
> >> diff --git a/drivers/tee/tstee/core.c b/drivers/tee/tstee/core.c
> >> new file mode 100644
> >> index 000000000000..c0194638b7da
> >> --- /dev/null
> >> +++ b/drivers/tee/tstee/core.c
> >> @@ -0,0 +1,473 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (c) 2023, Arm Limited
> >> + */
> >> +
> >> +#define DRIVER_NAME "Arm TSTEE"
> >> +#define pr_fmt(fmt) DRIVER_NAME ": " fmt
> >> +
> >> +#include <linux/arm_ffa.h>
> >> +#include <linux/err.h>
> >> +#include <linux/errno.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/limits.h>
> >> +#include <linux/list.h>
> >> +#include <linux/mm.h>
> >> +#include <linux/module.h>
> >> +#include <linux/scatterlist.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/stat.h>
> >> +#include <linux/tee_drv.h>
> >> +#include <linux/types.h>
> >> +#include <linux/uaccess.h>
> >> +
> >> +#include "tstee_private.h"
> >> +
> >> +#define FFA_INVALID_MEM_HANDLE U64_MAX
> >> +
> >> +static void arg_list_to_ffa_data(const u32 *args, struct ffa_send_direc=
t_data *data)
> >> +{
> >> +       data->data0 =3D args[0];
> >> +       data->data1 =3D args[1];
> >> +       data->data2 =3D args[2];
> >> +       data->data3 =3D args[3];
> >> +       data->data4 =3D args[4];
> >> +}
> >> +
> >> +static void arg_list_from_ffa_data(const struct ffa_send_direct_data *d=
ata, u32 *args)
> >> +{
> >> +       args[0] =3D lower_32_bits(data->data0);
> >> +       args[1] =3D lower_32_bits(data->data1);
> >> +       args[2] =3D lower_32_bits(data->data2);
> >> +       args[3] =3D lower_32_bits(data->data3);
> >> +       args[4] =3D lower_32_bits(data->data4);
> >> +}
> >> +
> >> +static void tstee_get_version(struct tee_device *teedev, struct tee_ioc=
tl_version_data *vers)
> >> +{
> >> +       struct tstee *tstee =3D tee_get_drvdata(teedev);
> >> +       struct tee_ioctl_version_data v =3D {
> >> +               .impl_id =3D TEE_IMPL_ID_TSTEE,
> >> +               .impl_caps =3D tstee->ffa_dev->vm_id,
> >
> > So while exploring the user-space interface, I observed an anomaly
> > here. The ".impl_caps" refers to "Implementation specific
> > capabilities" meant to support backwards compatibility of a particular
> > TEE implementation. But here I observe you are using it instead for
> > endpoint_id. Can you provide the reasoning behind it? Also, do you
> > plan to support multiple endpoints via this driver?
>
> The mapping between Trusted Services SPs and TEE devices is 1:1, i.e.
> each /dev/tee<n> device represents exactly one FF-A endpoint. To answer
> your second question, each instance of the driver represents a single
> endpoint, multiple endpoints are supported by having multiple instances
> of the driver.

I don't follow you here. How multiple instances of "arm_tstee" driver
going to work? Also, I can only see a single FF-A based device:
TS_RPC_UUID being probed here.

Do you have any working example for this?

> Therefore we always return a single endpoint ID in this
> field.
>
> The reason behind the usage of this field is that somehow user space has
> to be able to discover which TEE device represents which FF-A endpoint.
> This is required when a client wants to invoke an SP with a specific
> endpoint ID, e.g. in a system where the SP's endpoint IDs is static and
> known by the client.
>
> I understand this is not a conventional usage of this field, I couldn't
> find a better way to "fit" this information into the ABI. My
> understanding is this solution shouldn't cause any issues for other
> TEEs, since this implementation specific field should only be parsed by
> a client if it has already matched on the TEE implementation ID. Please
> correct me if this assumption is wrong, or if you have any suggestions
> on other ways to expose the endpoint ID to user space.

When you say "each /dev/tee<n> device represents exactly one FF-A
endpoint" then "impl_id" should be sufficient to represent endpoint ID
too. But I am still confused regarding how you are going to support
multiple endpoints?

Looking at this driver TEE_IMPL_ID_TSTEE represents an underlying FF-A
based TS_RPC_UUID device.

-Sumit

--===============9120430636710611791==--

