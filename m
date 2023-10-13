From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v9 6/6] tee: optee: restore efivars ops when tee-supplicant stops
Date: Fri, 13 Oct 2023 13:29:34 +0530
Message-ID: 
 <CAFA6WYMoWn6MgoRp8hD89PwmLeHaO+X1sGB0QOMQDLJtuseP3g@mail.gmail.com>
In-Reply-To: <20231013074540.8980-7-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2695258475333027855=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2695258475333027855==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Kojima-san,

On Fri, 13 Oct 2023 at 13:18, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> When tee-supplicant stops, tee-based EFI variable service
> is no longer available. Restore the efivars generic ops at the
> moment when tee-supplicant stops.

This is a layering violation as evident from below linking error. The
tee-supplicant is internal to how OP-TEE is implemented. I have
already shared a unified way to handle shutdown of supplicant
dependent devices here [1].

[1] https://lore.kernel.org/all/20230728134832.326467-1-sumit.garg(a)linaro.o=
rg/

-Sumit

>
> Linking error occurs if we set CONFIG_OPTEE=3Dy and
> CONFIG_TEE_STMM_EFI=3Dm. Use IS_REACHABLE() guard to call
> tee_stmm_restore_efivars_generic_ops() function.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  drivers/firmware/efi/stmm/tee_stmm_efi.c | 8 +++++++-
>  drivers/tee/optee/supp.c                 | 4 ++++
>  include/linux/efi.h                      | 1 +
>  3 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/ef=
i/stmm/tee_stmm_efi.c
> index edc165bc1bb0..e804b260edaa 100644
> --- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -572,10 +572,16 @@ static int tee_stmm_efi_probe(struct device *dev)
>         return 0;
>  }
>
> -static int tee_stmm_efi_remove(struct device *dev)
> +void tee_stmm_restore_efivars_generic_ops(void)
>  {
>         efivars_unregister(&tee_efivars);
>         efivars_generic_ops_register();
> +}
> +EXPORT_SYMBOL_GPL(tee_stmm_restore_efivars_generic_ops);
> +
> +static int tee_stmm_efi_remove(struct device *dev)
> +{
> +       tee_stmm_restore_efivars_generic_ops();
>
>         return 0;
>  }
> diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
> index 322a543b8c27..d07d4fc4e72e 100644
> --- a/drivers/tee/optee/supp.c
> +++ b/drivers/tee/optee/supp.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2015, Linaro Limited
>   */
>  #include <linux/device.h>
> +#include <linux/efi.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
>  #include "optee_private.h"
> @@ -58,6 +59,9 @@ void optee_supp_release(struct optee_supp *supp)
>                 complete(&req->c);
>         }
>
> +       if (IS_REACHABLE(CONFIG_TEE_STMM_EFI))
> +               tee_stmm_restore_efivars_generic_ops();
> +
>         supp->ctx =3D NULL;
>         supp->req_id =3D -1;
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 489707b9b0b0..9b60893d6299 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1365,5 +1365,6 @@ extern struct blocking_notifier_head efivar_ops_nh;
>
>  void efivars_generic_ops_register(void);
>  void efivars_generic_ops_unregister(void);
> +void tee_stmm_restore_efivars_generic_ops(void);
>
>  #endif /* _LINUX_EFI_H */
> --
> 2.30.2
>

--===============2695258475333027855==--

