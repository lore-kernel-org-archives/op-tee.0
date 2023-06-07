From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
Date: Wed, 07 Jun 2023 20:48:38 +0530
Message-ID: 
 <CAFA6WYPCDRjFzsUMU=SNzEt88nT7Fcm1eOFL8z4HiQO+=2JeVA@mail.gmail.com>
In-Reply-To: <76da826f-b608-6add-5401-6de818b180e3@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5648036664360137320=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5648036664360137320==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Jun 2023 at 18:10, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 07.06.23 10:25, Ilias Apalodimas wrote:
> > Hi Sumit,
> >
> > On Wed, 7 Jun 2023 at 10:25, Sumit Garg <sumit.garg@linaro.org> wrote:
> >>
> >> Hi Ilias,
> >>
> >> On Wed, 7 Jun 2023 at 12:05, Ilias Apalodimas
> >> <ilias.apalodimas@linaro.org> wrote:
> >>>
> >>> Hi Jan,
> >>>
> >>> [...]
> >>>
> >>>>>>>>
> >>>>> ...
> >>>>>>>
> >>>>>>> I think we have a probe ordering issue with this driver:
> >>>>>>> efivarfs_fill_super() may be called before the TEE bus was probed, =
thus
> >>>>>>> with the default efivar ops still registered. And that means
> >>>>>>> efivar_supports_writes() will return false, and the fs declares its=
elf
> >>>>>>> as readonly. I've seen systemd mounting it r/o initialling, and you=
 need
> >>>>>>> to remount the fs to enable writability.
> >>>>>>>
> >>>>>>> Is there anything that could be done to re-order things reliably, p=
robe
> >>>>>>> the tee bus earlier etc.?
> >>>>>>
> >>>>>> This driver has a dependency on user-space daemon: tee-supplicant to
> >>>>>> be running for RPMB access. So once you start that daemon the
> >>>>>> corresponding device will be enumerated on the TEE bus and this driv=
er
> >>>>>> probe will be invoked. So I would suggest you to load this daemon ve=
ry
> >>>>>> early in the boot process or better to make it a part of initramfs.
> >>>>>>
> >>>>>
> >>>>> That is not the point, really.
> >>>>>
> >>>>> If this dependency exists, the code should be aware of that, and made
> >>>>> to work correctly in spite of it. Requiring a module to be part of
> >>>>> initramfs is not a reasonable fix.
> >>>>
> >>>> In fact, I've tested a non-modularized build as well, just to exclude
> >>>> that issue. The daemon dependency is more likely the problem here.
> >>>>
> >>>>>
> >>>>> IIUC, this also means that the efivar ops are updated while there is
> >>>>> already a client. This seems less than ideal as well
> >>>
> >>> As Sumit pointed out, the 'device' won't be available from OP-TEE
> >>> until the supplicant is up and running and as a result, the module
> >>> _probe() function won't run.  Unfortunately, this isn't something we
> >>> can avoid since the supplicant is responsible for the RPMB writes.
> >>> The only thing I can think of is moving parts of the supplicant to the
> >>> kernel and wiring up the RPC calls for reading/writing data to the
> >>> eMMC subsystem.  There was another discussion here [0] requesting the
> >>> same thing for different reasons. But unless I am missing something
> >>> this won't solve the problem completely either.  You still have a
> >>> timing dependency of "when did the RT callbacks change" -- "when was
> >>> my efivarfs mounted".
> >>
> >> With the RPMB writes wired through the kernel [1], the only dependency
> >> left is when do you load the tee-stmm-efi driver to have real EFI
> >> runtime variables support. IMO, tee-stmm-efi driver should be built-in
> >> to support systems without initramfs. The distro installers may choose
> >> to bundle it in initramfs. Do you still see a timing dependency with
> >> this approach?
> >
> > No I don't, this will work reliably without the need to remount the efiva=
rfs.
> > As you point out you will still have this dependency if you end up
> > building them as modules and you manage to mount the efivarfs before
> > those get inserted.  Does anyone see a reasonable workaround?
> > Deceiving the kernel and making the bootloader set the RT property bit
> > to force the filesystem being mounted as rw is a nasty hack that we
> > should avoid.  Maybe adding a kernel command line parameter that says
> > "Ignore the RTPROP I know what I am doing"?  I don't particularly love
> > this either, but it's not unreasonable.
>
> In the context of https://github.com/OP-TEE/optee_os/issues/6094,
> basically this issue mapped on reboot/shutdown, I would really love to
> see the unhandy tee-supplicant daemon to be overcome.

I have seen this error before and it has been on my todo list. So I
have tried to fix it here [1]. Feel free to test it and let me know if
you see any further issues.

[1] https://lkml.org/lkml/2023/6/7/927

-Sumit

>
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>

--===============5648036664360137320==--

