From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/6] crypto: ccp: Add a header for multiple drivers to use
 `__psp_pa`
Date: Wed, 15 Feb 2023 16:43:01 +0530
Message-ID: 
 <CAFA6WYMJosUrE0BzQe6xFOaofZZWGiRBPBqoGk4Cvhm5s30VEQ@mail.gmail.com>
In-Reply-To: <20230209223811.4993-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4172615525624057214=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4172615525624057214==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Feb 2023 at 04:08, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The TEE subdriver for CCP, the amdtee driver and the i2c-designware-amdpsp
> drivers all include `psp-sev.h` even though they don't use SEV
> functionality.
>
> Move the definition of `__psp_pa` into a common header to be included
> by all of these drivers.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/kvm/svm/sev.c                     |  1 +
>  drivers/crypto/ccp/sev-dev.c               |  1 +
>  drivers/crypto/ccp/tee-dev.c               |  2 +-
>  drivers/i2c/busses/i2c-designware-amdpsp.c |  2 +-

>  drivers/tee/amdtee/call.c                  |  2 +-
>  drivers/tee/amdtee/shm_pool.c              |  2 +-

For TEE subsystem bits:

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>  include/linux/psp-sev.h                    |  8 --------
>  include/linux/psp.h                        | 14 ++++++++++++++
>  8 files changed, 20 insertions(+), 12 deletions(-)
>  create mode 100644 include/linux/psp.h
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 86d6897f48068..ee8e9053f4468 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -11,6 +11,7 @@
>  #include <linux/kvm_host.h>
>  #include <linux/kernel.h>
>  #include <linux/highmem.h>
> +#include <linux/psp.h>
>  #include <linux/psp-sev.h>
>  #include <linux/pagemap.h>
>  #include <linux/swap.h>
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index e2f25926eb514..28945ca7c8563 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -24,6 +24,7 @@
>  #include <linux/cpufeature.h>
>  #include <linux/fs.h>
>  #include <linux/fs_struct.h>
> +#include <linux/psp.h>
>
>  #include <asm/smp.h>
>  #include <asm/cacheflush.h>
> diff --git a/drivers/crypto/ccp/tee-dev.c b/drivers/crypto/ccp/tee-dev.c
> index 5c9d47f3be375..f24fc953718a0 100644
> --- a/drivers/crypto/ccp/tee-dev.c
> +++ b/drivers/crypto/ccp/tee-dev.c
> @@ -13,7 +13,7 @@
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/gfp.h>
> -#include <linux/psp-sev.h>
> +#include <linux/psp.h>
>  #include <linux/psp-tee.h>
>
>  #include "psp-dev.h"
> diff --git a/drivers/i2c/busses/i2c-designware-amdpsp.c b/drivers/i2c/busse=
s/i2c-designware-amdpsp.c
> index 8f36167bce624..80f28a1bbbef6 100644
> --- a/drivers/i2c/busses/i2c-designware-amdpsp.c
> +++ b/drivers/i2c/busses/i2c-designware-amdpsp.c
> @@ -4,7 +4,7 @@
>  #include <linux/bits.h>
>  #include <linux/i2c.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> -#include <linux/psp-sev.h>
> +#include <linux/psp.h>
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
>
> diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
> index cec6e70f0ac92..e8cd9aaa34675 100644
> --- a/drivers/tee/amdtee/call.c
> +++ b/drivers/tee/amdtee/call.c
> @@ -8,7 +8,7 @@
>  #include <linux/tee_drv.h>
>  #include <linux/psp-tee.h>
>  #include <linux/slab.h>
> -#include <linux/psp-sev.h>
> +#include <linux/psp.h>
>  #include "amdtee_if.h"
>  #include "amdtee_private.h"
>
> diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_pool.c
> index f87f96a291c99..f0303126f199d 100644
> --- a/drivers/tee/amdtee/shm_pool.c
> +++ b/drivers/tee/amdtee/shm_pool.c
> @@ -5,7 +5,7 @@
>
>  #include <linux/slab.h>
>  #include <linux/tee_drv.h>
> -#include <linux/psp-sev.h>
> +#include <linux/psp.h>
>  #include "amdtee_private.h"
>
>  static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
> diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
> index 1595088c428b4..7fd17e82bab43 100644
> --- a/include/linux/psp-sev.h
> +++ b/include/linux/psp-sev.h
> @@ -14,14 +14,6 @@
>
>  #include <uapi/linux/psp-sev.h>
>
> -#ifdef CONFIG_X86
> -#include <linux/mem_encrypt.h>
> -
> -#define __psp_pa(x)    __sme_pa(x)
> -#else
> -#define __psp_pa(x)    __pa(x)
> -#endif
> -
>  #define SEV_FW_BLOB_MAX_SIZE   0x4000  /* 16KB */
>
>  /**
> diff --git a/include/linux/psp.h b/include/linux/psp.h
> new file mode 100644
> index 0000000000000..202162487ec3b
> --- /dev/null
> +++ b/include/linux/psp.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __PSP_H
> +#define __PSP_H
> +
> +#ifdef CONFIG_X86
> +#include <linux/mem_encrypt.h>
> +
> +#define __psp_pa(x)    __sme_pa(x)
> +#else
> +#define __psp_pa(x)    __pa(x)
> +#endif
> +
> +#endif /* __PSP_H */
> --
> 2.34.1
>

--===============4172615525624057214==--

