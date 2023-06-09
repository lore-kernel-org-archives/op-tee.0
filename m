From: Jan Kiszka <jan.kiszka@siemens.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
Date: Fri, 09 Jun 2023 06:40:09 +0000
Message-ID: <da7d3871-3b2f-1172-62a8-70f6856e4968@siemens.com>
In-Reply-To: <
 <CAC_iWjLdmmQ4+BVt_mOP5Ht9jDHQqoVV+-ATR-nDrmG37raGjQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4305774220558122324=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4305774220558122324==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 09.06.23 08:34, Ilias Apalodimas wrote:
> Hi Jan,
>=20
> [...]
>=20
>>> --- a/drivers/firmware/efi/vars.c
>>> +++ b/drivers/firmware/efi/vars.c
>>> @@ -123,7 +123,7 @@ EXPORT_SYMBOL_GPL(efivars_unregister);
>>>
>>>  bool efivar_supports_writes(void)
>>>  {
>>> -       return __efivars && __efivars->ops->set_variable;
>>> +       return __efivars && __efivars->ops->set_variable !=3D set_variabl=
e_int;
>>>  }
>>>  EXPORT_SYMBOL_GPL(efivar_supports_writes);
>>>
>>> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
>>> index e028fafa04f3..e40b5c4c5106 100644
>>> --- a/fs/efivarfs/super.c
>>> +++ b/fs/efivarfs/super.c
>>> @@ -242,9 +242,6 @@ static int efivarfs_fill_super(struct super_block
>>> *sb, struct fs_context *fc)
>>>         sb->s_d_op              =3D &efivarfs_d_ops;
>>>         sb->s_time_gran         =3D 1;
>>>
>>> -       if (!efivar_supports_writes())
>>> -               sb->s_flags |=3D SB_RDONLY;
>>> -
>>>         inode =3D efivarfs_get_inode(sb, NULL, S_IFDIR | 0755, 0, true);
>>>         if (!inode)
>>>                 return -ENOMEM;
>>> diff --git a/include/linux/efi.h b/include/linux/efi.h
>>> index 58d1c271d3b0..ec0ac6ef50a3 100644
>>> --- a/include/linux/efi.h
>>> +++ b/include/linux/efi.h
>>> @@ -1084,6 +1084,10 @@ int efivars_register(struct efivars *efivars,
>>>                      const struct efivar_operations *ops);
>>>  int efivars_unregister(struct efivars *efivars);
>>>
>>> +efi_status_t set_variable_int(efi_char16_t *name, efi_guid_t *vendor,
>>> +                             u32 attributes, unsigned long data_size,
>>> +                             void *data);
>>> +
>>>  void efivars_generic_ops_register(void);
>>>  void efivars_generic_ops_unregister(void);
>>>
>>> Thanks
>>> /Ilias
>>
>> As just written in my other reply: The root cause is the dependency on
>> tee-supplicant daemon. That needs to be resolved, and then also r/w
>> mounting will just work.
>=20
> That's partially true.  If we solve the dependency your problem will
> go away only if everything gets compiled as built in.  But if you have
> them as modules there's still a chance you mount the efivarfs before
> installing all the modules.  In that case, you'll end up with the same
> problem no?

Obviously, this will need proper probing of the TA services in the
proper order so that the STMM driver is pulled in before efivarfs gets used.

>=20
> That's why I think this patch (or a variation of it) is useful.  It
> solves the kernel panic you are seeing if you remount the efivarfs as
> RW and It unifies the way the kernel responds to userspace no matter
> what the firmware does with its setvariableRT service.

I'm not against fixes crashes, but the r/w issue is a different thing IMHO.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


--===============4305774220558122324==--

