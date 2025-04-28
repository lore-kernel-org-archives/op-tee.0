From: Sumit Garg <sumit.garg@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/2] tee: Sort header includes
Date: Mon, 28 Apr 2025 13:15:45 +0530
Message-ID: <aA8yKYm1zyNfy3ky@sumit-X1>
In-Reply-To: <20250421152238.764659-3-superm1@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7651054995100239433=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7651054995100239433==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, Apr 21, 2025 at 10:22:23AM -0500, Mario Limonciello via OP-TEE wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Various headers have been added over time that are not added alphabetically
> and a private header is used before one of the linux/ headers.
> 
> Resort the list.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/tee/amdtee/core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
> index a44625d076401..fb39d9a19c698 100644
> --- a/drivers/tee/amdtee/core.c
> +++ b/drivers/tee/amdtee/core.c
> @@ -6,18 +6,19 @@
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/errno.h>
> +#include <linux/device.h>
> +#include <linux/firmware.h>
>  #include <linux/io.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
> +#include <linux/psp-tee.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> -#include <linux/device.h>
>  #include <linux/tee_core.h>
>  #include <linux/types.h>
> -#include <linux/mm.h>
>  #include <linux/uaccess.h>
> -#include <linux/firmware.h>
> +
>  #include "amdtee_private.h"
> -#include <linux/psp-tee.h>
>  
>  static struct amdtee_driver_data *drv_data;
>  static DEFINE_MUTEX(session_list_mutex);
> -- 
> 2.43.0
> 

--===============7651054995100239433==--

