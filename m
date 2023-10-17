From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 4/5] efivarfs: automatically update super block flag
Date: Tue, 17 Oct 2023 15:55:30 +0300
Message-ID: 
 <CAC_iWj+pVrLoLDeWy9qQnoW_3vWeSm+4gyYs0m+WJTvUmFgiMA@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYPc3ZL7C=t_i_VnYmJMHmgEM50aA=v4ZNC=FVAJgSAY=g@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7502960242939173463=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7502960242939173463==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

[...]

> > >
> > > > Wouldn't it be better to detect that the tee device of the supplicant
> > > > closes and use that to switch the permissions?  I get why we need that
> > > > for the TPM, the entire subsystem needs to send TPM commands *before*
> > > > the supplicant dies.   But this is not needed for the EFI variables
> > > > case, we could just remount the FS as RO the moment the supplicant
> > > > dies.
> > >
> > > As we discussed offline, we should have a unified approach to notify
> > > kernel TEE client drivers. So the approach implemented as part of [0]
> > > should address the needs for fTPM as well as EFI.
> >
> > Ideally yes, we should have a unified approach.  But this is a bit
> > different IMHO. In the majority of the cases, the supplicant goes
> > away,  we lose access to storage and that's the only thing we care
> > about.
>
> What do you think about in-flight secure storage operations while the
> tee-supplicant goes away? They can fail abruptly if the tee-supplicant
> goes away without waiting for them to complete. IMO, the graceful
> handling should be that the tee-supplicant should be alive when the
> dependent devices are being closed.
>
> For an EFI variable store case as well isn't that a possible scenario?

I think it is, but that would involve issuing a write and then killing
the supplicant immediately.
But that would lead to a weird state as well with the graceful exit.
IOW we don't block until the operation is finished, if you want to
shoot yourself in the foot you can start a write and then unbind. That
would lead to a partial EFI variable being written as well no?

>
> > Only the TPM subsystem is 'special' because it has to perform
> > a shutdown of the device as well.  On top of that, I think we should
> > try to avoid the kernel depending on userspace apps as much as
> > possible.
>
> There is only tee-supplicant user-space dependency which has to be
> handled carefully. I am very much up for RPMB fastpath via kernel and
> get rid of this dependency as well.

Yes, that is without a doubt our best solution.  Jens is already
working on that, but the supplicant has an entire ecosystem built
around it.  There might be cases where using the in-kernel replacement
might not be possible.

>
> >  I think it's best if we support both of these and add
> > documentation on why this is happening. Would it be hard to have a
> > combination of both of your patches?
> >
>
> It won't be hard but there can be corner cases as mentioned above.

TBH I am fine with merging it as-is. Both cases aren't ideal so it's
mostly a matter of documenting them properly.  I can update the docs
once we decide what to pull and mention the caveats in detail.
I am mostly interested to see what Jan is thinking since he pointed
out the behavior initially

Thanks
/Ilias
>
> -Sumit
>
> > Thanks
> > /Ilias
> >
> > >
> > > -Sumit
> > >
> > > >
> > > > [0] https://lore.kernel.org/all/20230728134832.326467-1-sumit.garg(a)=
linaro.org/
> > > >
> > > > Regards
> > > > /Ilias
> > > > >
> > > > > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > > > > ---
> > > > >  drivers/firmware/efi/efi.c  |  6 ++++++
> > > > >  drivers/firmware/efi/vars.c |  8 ++++++++
> > > > >  fs/efivarfs/super.c         | 33 +++++++++++++++++++++++++++++++++
> > > > >  include/linux/efi.h         |  8 ++++++++
> > > > >  4 files changed, 55 insertions(+)
> > > > >
> > > > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > > > > index 53ae25bbb6ac..d2eec5ed8e5e 100644
> > > > > --- a/drivers/firmware/efi/efi.c
> > > > > +++ b/drivers/firmware/efi/efi.c
> > > > > @@ -32,6 +32,7 @@
> > > > >  #include <linux/ucs2_string.h>
> > > > >  #include <linux/memblock.h>
> > > > >  #include <linux/security.h>
> > > > > +#include <linux/notifier.h>
> > > > >
> > > > >  #include <asm/early_ioremap.h>
> > > > >
> > > > > @@ -187,6 +188,9 @@ static const struct attribute_group efi_subsys_=
attr_group =3D {
> > > > >         .is_visible =3D efi_attr_is_visible,
> > > > >  };
> > > > >
> > > > > +struct blocking_notifier_head efivar_ops_nh;
> > > > > +EXPORT_SYMBOL_GPL(efivar_ops_nh);
> > > > > +
> > > > >  static struct efivars generic_efivars;
> > > > >  static struct efivar_operations generic_ops;
> > > > >
> > > > > @@ -427,6 +431,8 @@ static int __init efisubsys_init(void)
> > > > >                 platform_device_register_simple("efivars", 0, NULL,=
 0);
> > > > >         }
> > > > >
> > > > > +       BLOCKING_INIT_NOTIFIER_HEAD(&efivar_ops_nh);
> > > > > +
> > > > >         error =3D sysfs_create_group(efi_kobj, &efi_subsys_attr_gro=
up);
> > > > >         if (error) {
> > > > >                 pr_err("efi: Sysfs attribute export failed with err=
or %d.\n",
> > > > > diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/var=
s.c
> > > > > index e9dc7116daf1..f654e6f6af87 100644
> > > > > --- a/drivers/firmware/efi/vars.c
> > > > > +++ b/drivers/firmware/efi/vars.c
> > > > > @@ -63,6 +63,7 @@ int efivars_register(struct efivars *efivars,
> > > > >                      const struct efivar_operations *ops)
> > > > >  {
> > > > >         int rv;
> > > > > +       int event;
> > > > >
> > > > >         if (down_interruptible(&efivars_lock))
> > > > >                 return -EINTR;
> > > > > @@ -77,6 +78,13 @@ int efivars_register(struct efivars *efivars,
> > > > >
> > > > >         __efivars =3D efivars;
> > > > >
> > > > > +       if (efivar_supports_writes())
> > > > > +               event =3D EFIVAR_OPS_RDWR;
> > > > > +       else
> > > > > +               event =3D EFIVAR_OPS_RDONLY;
> > > > > +
> > > > > +       blocking_notifier_call_chain(&efivar_ops_nh, event, NULL);
> > > > > +
> > > > >         pr_info("Registered efivars operations\n");
> > > > >         rv =3D 0;
> > > > >  out:
> > > > > diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> > > > > index e028fafa04f3..0f6e4d223aea 100644
> > > > > --- a/fs/efivarfs/super.c
> > > > > +++ b/fs/efivarfs/super.c
> > > > > @@ -14,11 +14,36 @@
> > > > >  #include <linux/slab.h>
> > > > >  #include <linux/magic.h>
> > > > >  #include <linux/statfs.h>
> > > > > +#include <linux/notifier.h>
> > > > >
> > > > >  #include "internal.h"
> > > > >
> > > > >  LIST_HEAD(efivarfs_list);
> > > > >
> > > > > +struct efivarfs_info {
> > > > > +       struct super_block *sb;
> > > > > +       struct notifier_block nb;
> > > > > +};
> > > > > +
> > > > > +static struct efivarfs_info info;
> > > > > +
> > > > > +static int efivarfs_ops_notifier(struct notifier_block *nb, unsign=
ed long event,
> > > > > +                                void *data)
> > > > > +{
> > > > > +       switch (event) {
> > > > > +       case EFIVAR_OPS_RDONLY:
> > > > > +               info.sb->s_flags |=3D SB_RDONLY;
> > > > > +               break;
> > > > > +       case EFIVAR_OPS_RDWR:
> > > > > +               info.sb->s_flags &=3D ~SB_RDONLY;
> > > > > +               break;
> > > > > +       default:
> > > > > +               return NOTIFY_DONE;
> > > > > +       }
> > > > > +
> > > > > +       return NOTIFY_OK;
> > > > > +}
> > > > > +
> > > > >  static void efivarfs_evict_inode(struct inode *inode)
> > > > >  {
> > > > >         clear_inode(inode);
> > > > > @@ -255,6 +280,12 @@ static int efivarfs_fill_super(struct super_bl=
ock *sb, struct fs_context *fc)
> > > > >         if (!root)
> > > > >                 return -ENOMEM;
> > > > >
> > > > > +       info.sb =3D sb;
> > > > > +       info.nb.notifier_call =3D efivarfs_ops_notifier;
> > > > > +       err =3D blocking_notifier_chain_register(&efivar_ops_nh, &i=
nfo.nb);
> > > > > +       if (err)
> > > > > +               return err;
> > > > > +
> > > > >         INIT_LIST_HEAD(&efivarfs_list);
> > > > >
> > > > >         err =3D efivar_init(efivarfs_callback, (void *)sb, true, &e=
fivarfs_list);
> > > > > @@ -281,6 +312,8 @@ static int efivarfs_init_fs_context(struct fs_c=
ontext *fc)
> > > > >
> > > > >  static void efivarfs_kill_sb(struct super_block *sb)
> > > > >  {
> > > > > +       blocking_notifier_chain_unregister(&efivar_ops_nh, &info.nb=
);
> > > > > +       info.sb =3D NULL;
> > > > >         kill_litter_super(sb);
> > > > >
> > > > >         if (!efivar_is_available())
> > > > > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > > > > index 603bba2d6437..17cd628b5c42 100644
> > > > > --- a/include/linux/efi.h
> > > > > +++ b/include/linux/efi.h
> > > > > @@ -1365,6 +1365,14 @@ bool efi_config_table_is_usable(const efi_gu=
id_t *guid, unsigned long table)
> > > > >
> > > > >  umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute=
 *attr, int n);
> > > > >
> > > > > +/*
> > > > > + * efivar ops event type
> > > > > + */
> > > > > +#define EFIVAR_OPS_RDONLY 0
> > > > > +#define EFIVAR_OPS_RDWR 1
> > > > > +
> > > > > +extern struct blocking_notifier_head efivar_ops_nh;
> > > > > +
> > > > >  void efivars_generic_ops_register(void);
> > > > >  void efivars_generic_ops_unregister(void);
> > > > >
> > > > > --
> > > > > 2.30.2
> > > > >

--===============7502960242939173463==--

