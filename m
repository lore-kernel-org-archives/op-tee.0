From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 3/5] efi: Add tee-based EFI variable driver
Date: Tue, 08 Aug 2023 10:43:23 +0100
Message-ID: <20230808104323.000016d3@Huawei.com>
In-Reply-To: <20230807025343.1939-4-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1242417881917037813=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1242417881917037813==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon,  7 Aug 2023 11:53:40 +0900
Masahisa Kojima <masahisa.kojima@linaro.org> wrote:

> When the flash is not owned by the non-secure world, accessing the EFI
> variables is straightforward and done via EFI Runtime Variable Services.
> In this case, critical variables for system integrity and security
> are normally stored in the dedicated secure storage and only accessible
> from the secure world.
>=20
> On the other hand, the small embedded devices don't have the special
> dedicated secure storage. The eMMC device with an RPMB partition is
> becoming more common, we can use an RPMB partition to store the
> EFI Variables.
>=20
> The eMMC device is typically owned by the non-secure world(linux in
> this case). There is an existing solution utilizing eMMC RPMB partition
> for EFI Variables, it is implemented by interacting with
> TEE(OP-TEE in this case), StandaloneMM(as EFI Variable Service Pseudo TA),
> eMMC driver and tee-supplicant. The last piece is the tee-based
> variable access driver to interact with TEE and StandaloneMM.
>=20
> So let's add the kernel functions needed.
>=20
> This feature is implemented as a kernel module.
> StMM PTA has TA_FLAG_DEVICE_ENUM_SUPP flag when registered to OP-TEE
> so that this tee_stmm_efi module is probed after tee-supplicant starts,
> since "SetVariable" EFI Runtime Variable Service requires to
> interact with tee-supplicant.
>=20
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
> Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>

I'm going to point out some stuff in here about the use of globals
etc which wouldn't be acceptable in many subsystems.  However, it's
up to the relevant maintainers on whether they want that stuff cleaned
up or not.

Other than that, this looks fine to me, but I'm reluctant to give an RB
with those globals in place.

Jonathan

> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/ef=
i/stmm/tee_stmm_efi.c
> new file mode 100644
> index 000000000000..e03475966dc1
> --- /dev/null
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -0,0 +1,612 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  EFI variable service via TEE
> + *
> + *  Copyright (C) 2022 Linaro
> + */
> +
> +#include <linux/efi.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/tee.h>
> +#include <linux/tee_drv.h>
> +#include <linux/ucs2_string.h>
> +#include "mm_communication.h"
> +
> +static struct efivars tee_efivars;
> +static struct efivar_operations tee_efivar_ops;

Hmm. Globals.  Never a good thing to see in a driver, but from a quick
look it seems the various efi callbacks take no useful parameters
that would let us do the usual embedded structure and container_of
tricks.  So whilst I'd like to see that fixed, it's not my subsystem
and it would be a non trivial amount of work.

> +
> +static size_t max_buffer_size; /* comm + var + func + data */
> +static size_t max_payload_size; /* func + data */
> +
> +struct tee_stmm_efi_private {
> +	struct tee_context *ctx;
> +	u32 session;
> +	struct device *dev;
> +};
> +
> +static struct tee_stmm_efi_private pvt_data;

...
> +
> +static int tee_stmm_efi_probe(struct device *dev)
> +{
> +	struct tee_ioctl_open_session_arg sess_arg;
> +	efi_status_t ret;
> +	int rc;
> +
> +	/* Open context with TEE driver */

My natural aversion to comments as things that bit rot applies here.
Fairly obvious this opens the context from the function name, so not
sure the comment adds anything.

> +	pvt_data.ctx =3D tee_client_open_context(NULL, tee_ctx_match, NULL, NULL);
> +	if (IS_ERR(pvt_data.ctx))
> +		return -ENODEV;


--===============1242417881917037813==--

