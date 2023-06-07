From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
Date: Wed, 07 Jun 2023 09:34:25 +0300
Message-ID: 
 <CAC_iWjJJ5E9Q1or5yTiDynzv_WAYH-g+N24aRdu9rvcsbWqnrg@mail.gmail.com>
In-Reply-To: <4ff09002-e871-38b9-43ec-227a64bac731@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2446813254437746626=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2446813254437746626==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Jan,

[...]

> >>>>
> > ...
> >>>
> >>> I think we have a probe ordering issue with this driver:
> >>> efivarfs_fill_super() may be called before the TEE bus was probed, thus
> >>> with the default efivar ops still registered. And that means
> >>> efivar_supports_writes() will return false, and the fs declares itself
> >>> as readonly. I've seen systemd mounting it r/o initialling, and you need
> >>> to remount the fs to enable writability.
> >>>
> >>> Is there anything that could be done to re-order things reliably, probe
> >>> the tee bus earlier etc.?
> >>
> >> This driver has a dependency on user-space daemon: tee-supplicant to
> >> be running for RPMB access. So once you start that daemon the
> >> corresponding device will be enumerated on the TEE bus and this driver
> >> probe will be invoked. So I would suggest you to load this daemon very
> >> early in the boot process or better to make it a part of initramfs.
> >>
> >
> > That is not the point, really.
> >
> > If this dependency exists, the code should be aware of that, and made
> > to work correctly in spite of it. Requiring a module to be part of
> > initramfs is not a reasonable fix.
>
> In fact, I've tested a non-modularized build as well, just to exclude
> that issue. The daemon dependency is more likely the problem here.
>
> >
> > IIUC, this also means that the efivar ops are updated while there is
> > already a client. This seems less than ideal as well

As Sumit pointed out, the 'device' won't be available from OP-TEE
until the supplicant is up and running and as a result, the module
_probe() function won't run.  Unfortunately, this isn't something we
can avoid since the supplicant is responsible for the RPMB writes.
The only thing I can think of is moving parts of the supplicant to the
kernel and wiring up the RPC calls for reading/writing data to the
eMMC subsystem.  There was another discussion here [0] requesting the
same thing for different reasons. But unless I am missing something
this won't solve the problem completely either.  You still have a
timing dependency of "when did the RT callbacks change" -- "when was
my efivarfs mounted".

Thanks
/Ilias
>
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>

--===============2446813254437746626==--

