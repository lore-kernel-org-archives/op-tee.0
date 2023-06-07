From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
Date: Wed, 07 Jun 2023 11:25:40 +0300
Message-ID: 
 <CAC_iWj+E7-XK6dCeSn4205K0O3EZCLxCaC+adu-14ST6sdudfA@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYNFYB1LiOFB_iwTsdD5PmnDdSbtDSH2J4FVFPx3uik8rQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4170878390649514258=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4170878390649514258==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

On Wed, 7 Jun 2023 at 10:25, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Ilias,
>
> On Wed, 7 Jun 2023 at 12:05, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Jan,
> >
> > [...]
> >
> > > >>>>
> > > > ...
> > > >>>
> > > >>> I think we have a probe ordering issue with this driver:
> > > >>> efivarfs_fill_super() may be called before the TEE bus was probed, =
thus
> > > >>> with the default efivar ops still registered. And that means
> > > >>> efivar_supports_writes() will return false, and the fs declares its=
elf
> > > >>> as readonly. I've seen systemd mounting it r/o initialling, and you=
 need
> > > >>> to remount the fs to enable writability.
> > > >>>
> > > >>> Is there anything that could be done to re-order things reliably, p=
robe
> > > >>> the tee bus earlier etc.?
> > > >>
> > > >> This driver has a dependency on user-space daemon: tee-supplicant to
> > > >> be running for RPMB access. So once you start that daemon the
> > > >> corresponding device will be enumerated on the TEE bus and this driv=
er
> > > >> probe will be invoked. So I would suggest you to load this daemon ve=
ry
> > > >> early in the boot process or better to make it a part of initramfs.
> > > >>
> > > >
> > > > That is not the point, really.
> > > >
> > > > If this dependency exists, the code should be aware of that, and made
> > > > to work correctly in spite of it. Requiring a module to be part of
> > > > initramfs is not a reasonable fix.
> > >
> > > In fact, I've tested a non-modularized build as well, just to exclude
> > > that issue. The daemon dependency is more likely the problem here.
> > >
> > > >
> > > > IIUC, this also means that the efivar ops are updated while there is
> > > > already a client. This seems less than ideal as well
> >
> > As Sumit pointed out, the 'device' won't be available from OP-TEE
> > until the supplicant is up and running and as a result, the module
> > _probe() function won't run.  Unfortunately, this isn't something we
> > can avoid since the supplicant is responsible for the RPMB writes.
> > The only thing I can think of is moving parts of the supplicant to the
> > kernel and wiring up the RPC calls for reading/writing data to the
> > eMMC subsystem.  There was another discussion here [0] requesting the
> > same thing for different reasons. But unless I am missing something
> > this won't solve the problem completely either.  You still have a
> > timing dependency of "when did the RT callbacks change" -- "when was
> > my efivarfs mounted".
>
> With the RPMB writes wired through the kernel [1], the only dependency
> left is when do you load the tee-stmm-efi driver to have real EFI
> runtime variables support. IMO, tee-stmm-efi driver should be built-in
> to support systems without initramfs. The distro installers may choose
> to bundle it in initramfs. Do you still see a timing dependency with
> this approach?

No I don't, this will work reliably without the need to remount the efivarfs.
As you point out you will still have this dependency if you end up
building them as modules and you manage to mount the efivarfs before
those get inserted.  Does anyone see a reasonable workaround?
Deceiving the kernel and making the bootloader set the RT property bit
to force the filesystem being mounted as rw is a nasty hack that we
should avoid.  Maybe adding a kernel command line parameter that says
"Ignore the RTPROP I know what I am doing"?  I don't particularly love
this either, but it's not unreasonable.

Thanks
/Ilias
>
> [1] Of Course here we need the eMMC and TEE/OPTEE drivers to be built-in to=
o.
>
> -Sumit
>
> >
> > Thanks
> > /Ilias
> > >
> > > Jan
> > >
> > > --
> > > Siemens AG, Technology
> > > Competence Center Embedded Linux
> > >

--===============4170878390649514258==--

