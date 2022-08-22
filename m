From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: fix compiler warning in tee_shm_register()
Date: Mon, 22 Aug 2022 14:09:32 +0530
Message-ID: 
 <CAFA6WYMytTKk_Z5u=6cd6JWCGp==jA9jDhC+oBboeZODGa+EOQ@mail.gmail.com>
In-Reply-To: <20220822082846.3558520-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1076512715534142958=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1076512715534142958==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Aug 2022 at 13:58, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Include <linux/uaccess.h> to avoid the warning:
>    drivers/tee/tee_shm.c: In function 'tee_shm_register':
> >> drivers/tee/tee_shm.c:242:14: error: implicit declaration of function 'a=
ccess_ok' [-Werror=3Dimplicit-function-declaration]
>      242 |         if (!access_ok((void __user *)addr, length))
>          |              ^~~~~~~~~
>    cc1: some warnings being treated as errors
>
> Fixes: 573ae4f13f63 ("tee: add overflow check in register_shm_helper()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_shm.c | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 1175f3a46859..27295bda3e0b 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -9,6 +9,7 @@
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/tee_drv.h>
> +#include <linux/uaccess.h>
>  #include <linux/uio.h>
>  #include "tee_private.h"
>
> --
> 2.31.1
>

--===============1076512715534142958==--

