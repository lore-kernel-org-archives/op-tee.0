From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 4/6] efivarfs: automatically update super block flag
Date: Tue, 12 Dec 2023 09:13:01 +0200
Message-ID: 
 <CAC_iWjJOJ-x7CUJvN4tYx2UF=yY4gp3QPjt+7uP79tO+2AZ0-w@mail.gmail.com>
In-Reply-To: <
 <CADQ0-X8DJk02oKabzQcMwqKFjr6A6LDWaQDCndKybC6D=9M7vg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4060358364242644831=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4060358364242644831==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Ard,

On Tue, 12 Dec 2023 at 07:39, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> Hi Ard,
>
> On Mon, 11 Dec 2023 at 19:02, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 13 Oct 2023 at 09:47, Masahisa Kojima
> > <masahisa.kojima@linaro.org> wrote:
> > >
> > > efivar operation is updated when the tee_stmm_efi module is probed.
> > > tee_stmm_efi module supports SetVariable runtime service,
> > > but user needs to manually remount the efivarfs as RW to enable
> > > the write access if the previous efivar operation does not support
> > > SerVariable and efivarfs is mounted as read-only.
> > >
> > > This commit notifies the update of efivar operation to
> > > efivarfs subsystem, then drops SB_RDONLY flag if the efivar
> > > operation supports SetVariable.
> > >
> > > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> >
> > Unfortunately, I have identified a problem with this approach.
> >
> > There are cases where there are multiple instances of struct
> > superblock are associated with the efivarfs file system [0].
> >
> > So I reworked the patch a little - please take the time to double
> > check that I did not make any mistakes here.
> >
> > [0] https://lore.kernel.org/linux-efi/20231208163925.3225018-8-ardb(a)goo=
gle.com/T/#u
>
> I think you are referring to this patch[1]?
> The modification should be OK, also I have tested it works as expected.
>
> Thank you very much for fixing this.

Same results here (as we discussed yesterday on IRC). Code looks sane
and the automatic remounting correctly sets the mountpoint as RW

Thanks!
/Ilias
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/fs/efivarfs?id=3D94f7f6182c72ba642c1f20111681f9cc8621c95f
>
> Thanks,
> Masahisa Kojima
>
> >
> >
> > > ---
> > >  drivers/firmware/efi/efi.c  |  6 ++++++
> > >  drivers/firmware/efi/vars.c |  8 ++++++++
> > >  fs/efivarfs/super.c         | 33 +++++++++++++++++++++++++++++++++
> > >  include/linux/efi.h         |  8 ++++++++
> > >  4 files changed, 55 insertions(+)
> > >
> > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > > index 53ae25bbb6ac..d2eec5ed8e5e 100644
> > > --- a/drivers/firmware/efi/efi.c
> > > +++ b/drivers/firmware/efi/efi.c
> > > @@ -32,6 +32,7 @@
> > >  #include <linux/ucs2_string.h>
> > >  #include <linux/memblock.h>
> > >  #include <linux/security.h>
> > > +#include <linux/notifier.h>
> > >
> > >  #include <asm/early_ioremap.h>
> > >
> > > @@ -187,6 +188,9 @@ static const struct attribute_group efi_subsys_attr=
_group =3D {
> > >         .is_visible =3D efi_attr_is_visible,
> > >  };
> > >
> > > +struct blocking_notifier_head efivar_ops_nh;
> > > +EXPORT_SYMBOL_GPL(efivar_ops_nh);
> > > +
> > >  static struct efivars generic_efivars;
> > >  static struct efivar_operations generic_ops;
> > >
> > > @@ -427,6 +431,8 @@ static int __init efisubsys_init(void)
> > >                 platform_device_register_simple("efivars", 0, NULL, 0);
> > >         }
> > >
> > > +       BLOCKING_INIT_NOTIFIER_HEAD(&efivar_ops_nh);
> > > +
> > >         error =3D sysfs_create_group(efi_kobj, &efi_subsys_attr_group);
> > >         if (error) {
> > >                 pr_err("efi: Sysfs attribute export failed with error %=
d.\n",
> > > diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> > > index e9dc7116daf1..f654e6f6af87 100644
> > > --- a/drivers/firmware/efi/vars.c
> > > +++ b/drivers/firmware/efi/vars.c
> > > @@ -63,6 +63,7 @@ int efivars_register(struct efivars *efivars,
> > >                      const struct efivar_operations *ops)
> > >  {
> > >         int rv;
> > > +       int event;
> > >
> > >         if (down_interruptible(&efivars_lock))
> > >                 return -EINTR;
> > > @@ -77,6 +78,13 @@ int efivars_register(struct efivars *efivars,
> > >
> > >         __efivars =3D efivars;
> > >
> > > +       if (efivar_supports_writes())
> > > +               event =3D EFIVAR_OPS_RDWR;
> > > +       else
> > > +               event =3D EFIVAR_OPS_RDONLY;
> > > +
> > > +       blocking_notifier_call_chain(&efivar_ops_nh, event, NULL);
> > > +
> > >         pr_info("Registered efivars operations\n");
> > >         rv =3D 0;
> > >  out:
> > > diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> > > index e028fafa04f3..0f6e4d223aea 100644
> > > --- a/fs/efivarfs/super.c
> > > +++ b/fs/efivarfs/super.c
> > > @@ -14,11 +14,36 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/magic.h>
> > >  #include <linux/statfs.h>
> > > +#include <linux/notifier.h>
> > >
> > >  #include "internal.h"
> > >
> > >  LIST_HEAD(efivarfs_list);
> > >
> > > +struct efivarfs_info {
> > > +       struct super_block *sb;
> > > +       struct notifier_block nb;
> > > +};
> > > +
> > > +static struct efivarfs_info info;
> > > +
> > > +static int efivarfs_ops_notifier(struct notifier_block *nb, unsigned l=
ong event,
> > > +                                void *data)
> > > +{
> > > +       switch (event) {
> > > +       case EFIVAR_OPS_RDONLY:
> > > +               info.sb->s_flags |=3D SB_RDONLY;
> > > +               break;
> > > +       case EFIVAR_OPS_RDWR:
> > > +               info.sb->s_flags &=3D ~SB_RDONLY;
> > > +               break;
> > > +       default:
> > > +               return NOTIFY_DONE;
> > > +       }
> > > +
> > > +       return NOTIFY_OK;
> > > +}
> > > +
> > >  static void efivarfs_evict_inode(struct inode *inode)
> > >  {
> > >         clear_inode(inode);
> > > @@ -255,6 +280,12 @@ static int efivarfs_fill_super(struct super_block =
*sb, struct fs_context *fc)
> > >         if (!root)
> > >                 return -ENOMEM;
> > >
> > > +       info.sb =3D sb;
> > > +       info.nb.notifier_call =3D efivarfs_ops_notifier;
> > > +       err =3D blocking_notifier_chain_register(&efivar_ops_nh, &info.=
nb);
> > > +       if (err)
> > > +               return err;
> > > +
> > >         INIT_LIST_HEAD(&efivarfs_list);
> > >
> > >         err =3D efivar_init(efivarfs_callback, (void *)sb, true, &efiva=
rfs_list);
> > > @@ -281,6 +312,8 @@ static int efivarfs_init_fs_context(struct fs_conte=
xt *fc)
> > >
> > >  static void efivarfs_kill_sb(struct super_block *sb)
> > >  {
> > > +       blocking_notifier_chain_unregister(&efivar_ops_nh, &info.nb);
> > > +       info.sb =3D NULL;
> > >         kill_litter_super(sb);
> > >
> > >         if (!efivar_is_available())
> > > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > > index 4776a3dd9a72..489707b9b0b0 100644
> > > --- a/include/linux/efi.h
> > > +++ b/include/linux/efi.h
> > > @@ -1355,6 +1355,14 @@ bool efi_config_table_is_usable(const efi_guid_t=
 *guid, unsigned long table)
> > >
> > >  umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *at=
tr, int n);
> > >
> > > +/*
> > > + * efivar ops event type
> > > + */
> > > +#define EFIVAR_OPS_RDONLY 0
> > > +#define EFIVAR_OPS_RDWR 1
> > > +
> > > +extern struct blocking_notifier_head efivar_ops_nh;
> > > +
> > >  void efivars_generic_ops_register(void);
> > >  void efivars_generic_ops_unregister(void);
> > >
> > > --
> > > 2.30.2
> > >

--===============4060358364242644831==--

