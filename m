From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 4/5] efivarfs: automatically update super block flag
Date: Wed, 11 Oct 2023 10:00:20 -0700
Message-ID: 
 <CAC_iWjL3YpZb4ryko1DR9CM1x+VTV8mfnN=AwBR4F09Agc0vRQ@mail.gmail.com>
In-Reply-To: <20230807025343.1939-5-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8951583007768182212=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8951583007768182212==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Kojima-san
Apologies for the late reply, I just found some to test this.

On Sun, 6 Aug 2023 at 19:55, Masahisa Kojima <masahisa.kojima@linaro.org> w=
rote:
>
> efivar operation is updated when the tee_stmm_efi module is probed.
> tee_stmm_efi module supports SetVariable runtime service,
> but user needs to manually remount the efivarfs as RW to enable
> the write access if the previous efivar operation does not support
> SerVariable and efivarfs is mounted as read-only.
>
> This commit notifies the update of efivar operation to
> efivarfs subsystem, then drops SB_RDONLY flag if the efivar
> operation supports SetVariable.

The RO->RW transition works fine and I did manage to test basic stuff
like setting up efibootmgr options.  IIUC the RW->RO should be covered
by this patchset [0] ?
Wouldn't it be better to detect that the tee device of the supplicant
closes and use that to switch the permissions?  I get why we need that
for the TPM, the entire subsystem needs to send TPM commands *before*
the supplicant dies.   But this is not needed for the EFI variables
case, we could just remount the FS as RO the moment the supplicant
dies.

[0] https://lore.kernel.org/all/20230728134832.326467-1-sumit.garg(a)linaro.o=
rg/

Regards
/Ilias
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  drivers/firmware/efi/efi.c  |  6 ++++++
>  drivers/firmware/efi/vars.c |  8 ++++++++
>  fs/efivarfs/super.c         | 33 +++++++++++++++++++++++++++++++++
>  include/linux/efi.h         |  8 ++++++++
>  4 files changed, 55 insertions(+)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 53ae25bbb6ac..d2eec5ed8e5e 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -32,6 +32,7 @@
>  #include <linux/ucs2_string.h>
>  #include <linux/memblock.h>
>  #include <linux/security.h>
> +#include <linux/notifier.h>
>
>  #include <asm/early_ioremap.h>
>
> @@ -187,6 +188,9 @@ static const struct attribute_group efi_subsys_attr_gro=
up =3D {
>         .is_visible =3D efi_attr_is_visible,
>  };
>
> +struct blocking_notifier_head efivar_ops_nh;
> +EXPORT_SYMBOL_GPL(efivar_ops_nh);
> +
>  static struct efivars generic_efivars;
>  static struct efivar_operations generic_ops;
>
> @@ -427,6 +431,8 @@ static int __init efisubsys_init(void)
>                 platform_device_register_simple("efivars", 0, NULL, 0);
>         }
>
> +       BLOCKING_INIT_NOTIFIER_HEAD(&efivar_ops_nh);
> +
>         error =3D sysfs_create_group(efi_kobj, &efi_subsys_attr_group);
>         if (error) {
>                 pr_err("efi: Sysfs attribute export failed with error %d.\n=
",
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index e9dc7116daf1..f654e6f6af87 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -63,6 +63,7 @@ int efivars_register(struct efivars *efivars,
>                      const struct efivar_operations *ops)
>  {
>         int rv;
> +       int event;
>
>         if (down_interruptible(&efivars_lock))
>                 return -EINTR;
> @@ -77,6 +78,13 @@ int efivars_register(struct efivars *efivars,
>
>         __efivars =3D efivars;
>
> +       if (efivar_supports_writes())
> +               event =3D EFIVAR_OPS_RDWR;
> +       else
> +               event =3D EFIVAR_OPS_RDONLY;
> +
> +       blocking_notifier_call_chain(&efivar_ops_nh, event, NULL);
> +
>         pr_info("Registered efivars operations\n");
>         rv =3D 0;
>  out:
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index e028fafa04f3..0f6e4d223aea 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -14,11 +14,36 @@
>  #include <linux/slab.h>
>  #include <linux/magic.h>
>  #include <linux/statfs.h>
> +#include <linux/notifier.h>
>
>  #include "internal.h"
>
>  LIST_HEAD(efivarfs_list);
>
> +struct efivarfs_info {
> +       struct super_block *sb;
> +       struct notifier_block nb;
> +};
> +
> +static struct efivarfs_info info;
> +
> +static int efivarfs_ops_notifier(struct notifier_block *nb, unsigned long =
event,
> +                                void *data)
> +{
> +       switch (event) {
> +       case EFIVAR_OPS_RDONLY:
> +               info.sb->s_flags |=3D SB_RDONLY;
> +               break;
> +       case EFIVAR_OPS_RDWR:
> +               info.sb->s_flags &=3D ~SB_RDONLY;
> +               break;
> +       default:
> +               return NOTIFY_DONE;
> +       }
> +
> +       return NOTIFY_OK;
> +}
> +
>  static void efivarfs_evict_inode(struct inode *inode)
>  {
>         clear_inode(inode);
> @@ -255,6 +280,12 @@ static int efivarfs_fill_super(struct super_block *sb,=
 struct fs_context *fc)
>         if (!root)
>                 return -ENOMEM;
>
> +       info.sb =3D sb;
> +       info.nb.notifier_call =3D efivarfs_ops_notifier;
> +       err =3D blocking_notifier_chain_register(&efivar_ops_nh, &info.nb);
> +       if (err)
> +               return err;
> +
>         INIT_LIST_HEAD(&efivarfs_list);
>
>         err =3D efivar_init(efivarfs_callback, (void *)sb, true, &efivarfs_=
list);
> @@ -281,6 +312,8 @@ static int efivarfs_init_fs_context(struct fs_context *=
fc)
>
>  static void efivarfs_kill_sb(struct super_block *sb)
>  {
> +       blocking_notifier_chain_unregister(&efivar_ops_nh, &info.nb);
> +       info.sb =3D NULL;
>         kill_litter_super(sb);
>
>         if (!efivar_is_available())
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 603bba2d6437..17cd628b5c42 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1365,6 +1365,14 @@ bool efi_config_table_is_usable(const efi_guid_t *gu=
id, unsigned long table)
>
>  umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, =
int n);
>
> +/*
> + * efivar ops event type
> + */
> +#define EFIVAR_OPS_RDONLY 0
> +#define EFIVAR_OPS_RDWR 1
> +
> +extern struct blocking_notifier_head efivar_ops_nh;
> +
>  void efivars_generic_ops_register(void);
>  void efivars_generic_ops_unregister(void);
>
> --
> 2.30.2
>

--===============8951583007768182212==--

