From: Jan Kiszka <jan.kiszka@siemens.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
Date: Fri, 09 Jun 2023 06:18:40 +0000
Message-ID: <3eb9bf84-4cf0-6cfe-9ad3-f7eef7d775fb@siemens.com>
In-Reply-To: <
 <CAC_iWjJ0uw_p9=6C+U+q8BNQgnDBgbDpcu8s8c80oB25i9y77w@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8793786588741180603=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8793786588741180603==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 08.06.23 21:38, Ilias Apalodimas wrote:
> On Thu, 8 Jun 2023 at 16:52, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Thu, 8 Jun 2023 at 08:22, Ilias Apalodimas
>> <ilias.apalodimas@linaro.org> wrote:
>>>
>>> Hi Jan
>>>
>>>
>>> On Wed, 7 Jun 2023 at 22:46, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 07.06.23 20:17, Ilias Apalodimas wrote:
>>>>> On Wed, 7 Jun 2023 at 20:14, Jan Kiszka <jan.kiszka@siemens.com> wrot=
e:
>>>>>>
>>>>>> On 07.06.23 18:59, Ilias Apalodimas wrote:
>>>>>>> On Wed, 7 Jun 2023 at 19:09, Ilias Apalodimas
>>>>>>> <ilias.apalodimas@linaro.org> wrote:
>>>>>>>>
>>>>>>>> Hi Jan,
>>>>>>>>
>>>>>>>> [...]
>>>>>>>>>>>> No I don't, this will work reliably without the need to remount =
the efivarfs.
>>>>>>>>>>>> As you point out you will still have this dependency if you end =
up
>>>>>>>>>>>> building them as modules and you manage to mount the efivarfs be=
fore
>>>>>>>>>>>> those get inserted.  Does anyone see a reasonable workaround?
>>>>>>>>>>>> Deceiving the kernel and making the bootloader set the RT proper=
ty bit
>>>>>>>>>>>> to force the filesystem being mounted as rw is a nasty hack that=
 we
>>>>>>>>>>>> should avoid.  Maybe adding a kernel command line parameter that=
 says
>>>>>>>>>>>> "Ignore the RTPROP I know what I am doing"?  I don't particularl=
y love
>>>>>>>>>>>> this either, but it's not unreasonable.
>>>>>>>>>>>
>>>>>>>>>>> In the context of https://github.com/OP-TEE/optee_os/issues/6094,
>>>>>>>>>>> basically this issue mapped on reboot/shutdown, I would really lo=
ve to
>>>>>>>>>>> see the unhandy tee-supplicant daemon to be overcome.
>>>>>>>>>>
>>>>>>>>>> I have seen this error before and it has been on my todo list. So I
>>>>>>>>>> have tried to fix it here [1]. Feel free to test it and let me kno=
w if
>>>>>>>>>> you see any further issues.
>>>>>>>>>>
>>>>>>>>>> [1] https://lkml.org/lkml/2023/6/7/927
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Ah, nice, will test ASAP!
>>>>>>>>>
>>>>>>>>> Meanwhile more food: I managed to build a firmware that was missing
>>>>>>>>> STMM. But the driver loaded, and I got this:
>>>>>>>>
>>>>>>>> Thanks for the testing. I'll try to reproduce it locally and get bac=
k to you
>>>>>>>
>>>>>>> Can you provide a bit more info on how that was triggered btw? I would
>>>>>>> be helpful to know
>>>>>>>
>>>>>>> - OP-TEE version
>>>>>>
>>>>>> Today's master, 145953d55.
>>>>>>
>>>>>>> - was it compiled as a module or built-in?
>>>>>>
>>>>>> Sorry, not sure anymore, switching back and forth right now. I think it
>>>>>> was built-in.
>>>>>>
>>>>>>> - was the supplicant running?
>>>>>>
>>>>>> Yes.
>>>>>>
>>>>>
>>>>> Ok thanks, that helps.  I guess this also means U-Boot was compiled to
>>>>> store the variables in a file in the ESP instead of the RPMB right?
>>>>> Otherwise, I can't see how the device booted in the first place.
>>>>
>>>> U-Boot was not configured to perform secure booting in this case. It had
>>>> RPMB support enabled, just didn't have to use it.
>>>
>>> In your initial mail you said you managed to build a firmware without
>>> StMM.  If U-boot isn't reconfigured accordingly -- iow skip the EFI
>>> variable storage in an RPMB, the EFI subsystem will fail to start.
>>>
>>> In any case, I don't think the ooops you are seeing is not connected
>>> to this patchset.  Looking at the kernel EFI stub we only set the
>>> SetVariableRT if the RTPROP table is set accordingly by the firmware.
>>> U-Boot never sets the EFI_RT_SUPPORTED_SET_VARIABLE property since it
>>> can't support it.  What you are doing is remount the efivarfs as rw
>>> and then trying to set a variable, but the callback for it is  NULL.
>>> I think you'll be able to replicate the same behavior on the kernel
>>> without even inserting the new module.
>>>
>>
>> I have dropped this series from efi/next for now, given that it
>> obviously has problems in its current state.
>>
>> The risk of merging this now and fixing it later is that it may cause
>> regressions for early adopters that rely on the behavior we are
>> introducing here. Better to get this in shape first.
>=20
> The ooops Jan was seeing is reproducible in the current code with
> $ sudo mount -o remount,rw /sys/firmware/efi/efivars
> $ sudo efi-updatevar -f PK.auth PK
>=20
> So the only real problem we are discussing here is users having to
> remount the efivarfs once the module is inserted and the supplicant is
> running right?  We could do something along the lines of the patch
> below. That would solve both of the problems.
>=20
> However, the patch changes the way efivarfs is mounted -- it's now
> always mounted as RW.  What I am worried about is userspace tools that
> rely on this.  I know fwupd uses it and looks for a RO mounted
> efivarfs on it's initial checking, but since userspace apps are
> already dealing with firmware that exposes SetVariableRT but always
> returns EFI_UNSUPPORTED this should be safe ?(famous last words)
>=20
> Jan can you please apply this and see if it solves your problem?
>=20
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 4cc8d0e7d0fd..37accd9e885c 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -206,6 +206,13 @@ static bool generic_ops_supported(void)
>         return true;
>  }
>=20
> +efi_status_t set_variable_int(efi_char16_t *name, efi_guid_t *vendor,
> +                             u32 attributes, unsigned long data_size,
> +                             void *data)
> +{
> +       return EFI_UNSUPPORTED;
> +}
> +
>  static int generic_ops_register(void)
>  {
>         if (!generic_ops_supported())
> @@ -219,6 +226,9 @@ static int generic_ops_register(void)
>         if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)) {
>                 generic_ops.set_variable =3D efi.set_variable;
>                 generic_ops.set_variable_nonblocking =3D
> efi.set_variable_nonblocking;
> +       } else {
> +               generic_ops.set_variable =3D set_variable_int;
> +               generic_ops.set_variable_nonblocking =3D set_variable_int;
>         }
>         return efivars_register(&generic_efivars, &generic_ops);
>  }
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index e9dc7116daf1..c75eff3f409d 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -123,7 +123,7 @@ EXPORT_SYMBOL_GPL(efivars_unregister);
>=20
>  bool efivar_supports_writes(void)
>  {
> -       return __efivars && __efivars->ops->set_variable;
> +       return __efivars && __efivars->ops->set_variable !=3D set_variable_=
int;
>  }
>  EXPORT_SYMBOL_GPL(efivar_supports_writes);
>=20
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index e028fafa04f3..e40b5c4c5106 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -242,9 +242,6 @@ static int efivarfs_fill_super(struct super_block
> *sb, struct fs_context *fc)
>         sb->s_d_op              =3D &efivarfs_d_ops;
>         sb->s_time_gran         =3D 1;
>=20
> -       if (!efivar_supports_writes())
> -               sb->s_flags |=3D SB_RDONLY;
> -
>         inode =3D efivarfs_get_inode(sb, NULL, S_IFDIR | 0755, 0, true);
>         if (!inode)
>                 return -ENOMEM;
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 58d1c271d3b0..ec0ac6ef50a3 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1084,6 +1084,10 @@ int efivars_register(struct efivars *efivars,
>                      const struct efivar_operations *ops);
>  int efivars_unregister(struct efivars *efivars);
>=20
> +efi_status_t set_variable_int(efi_char16_t *name, efi_guid_t *vendor,
> +                             u32 attributes, unsigned long data_size,
> +                             void *data);
> +
>  void efivars_generic_ops_register(void);
>  void efivars_generic_ops_unregister(void);
>=20
> apalos(a)hades:~/work/linux-next>;
> apalos(a)hades:~/work/linux-next>git diff
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 4cc8d0e7d0fd..37accd9e885c 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -206,6 +206,13 @@ static bool generic_ops_supported(void)
>         return true;
>  }
>=20
> +efi_status_t set_variable_int(efi_char16_t *name, efi_guid_t *vendor,
> +                             u32 attributes, unsigned long data_size,
> +                             void *data)
> +{
> +       return EFI_UNSUPPORTED;
> +}
> +
>  static int generic_ops_register(void)
>  {
>         if (!generic_ops_supported())
> @@ -219,6 +226,9 @@ static int generic_ops_register(void)
>         if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)) {
>                 generic_ops.set_variable =3D efi.set_variable;
>                 generic_ops.set_variable_nonblocking =3D
> efi.set_variable_nonblocking;
> +       } else {
> +               generic_ops.set_variable =3D set_variable_int;
> +               generic_ops.set_variable_nonblocking =3D set_variable_int;
>         }
>         return efivars_register(&generic_efivars, &generic_ops);
>  }
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index e9dc7116daf1..c75eff3f409d 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -123,7 +123,7 @@ EXPORT_SYMBOL_GPL(efivars_unregister);
>=20
>  bool efivar_supports_writes(void)
>  {
> -       return __efivars && __efivars->ops->set_variable;
> +       return __efivars && __efivars->ops->set_variable !=3D set_variable_=
int;
>  }
>  EXPORT_SYMBOL_GPL(efivar_supports_writes);
>=20
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index e028fafa04f3..e40b5c4c5106 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -242,9 +242,6 @@ static int efivarfs_fill_super(struct super_block
> *sb, struct fs_context *fc)
>         sb->s_d_op              =3D &efivarfs_d_ops;
>         sb->s_time_gran         =3D 1;
>=20
> -       if (!efivar_supports_writes())
> -               sb->s_flags |=3D SB_RDONLY;
> -
>         inode =3D efivarfs_get_inode(sb, NULL, S_IFDIR | 0755, 0, true);
>         if (!inode)
>                 return -ENOMEM;
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 58d1c271d3b0..ec0ac6ef50a3 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1084,6 +1084,10 @@ int efivars_register(struct efivars *efivars,
>                      const struct efivar_operations *ops);
>  int efivars_unregister(struct efivars *efivars);
>=20
> +efi_status_t set_variable_int(efi_char16_t *name, efi_guid_t *vendor,
> +                             u32 attributes, unsigned long data_size,
> +                             void *data);
> +
>  void efivars_generic_ops_register(void);
>  void efivars_generic_ops_unregister(void);
>=20
> Thanks
> /Ilias

As just written in my other reply: The root cause is the dependency on
tee-supplicant daemon. That needs to be resolved, and then also r/w
mounting will just work.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


--===============8793786588741180603==--

