From: Ard Biesheuvel <ardb@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
Date: Thu, 08 Jun 2023 15:52:04 +0200
Message-ID: 
 <CAMj1kXGbXdbDr6DbyuziSFuxMgAimjNnkhqy8C-S5AbxdnixuQ@mail.gmail.com>
In-Reply-To: <
 <CAC_iWjKgCJWgKU8tC3Nfn-0CgwGhw89B3JpTgsjkjDDOcWZEdw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1965499902816637752=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1965499902816637752==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Jun 2023 at 08:22, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Jan
>
>
> On Wed, 7 Jun 2023 at 22:46, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >
> > On 07.06.23 20:17, Ilias Apalodimas wrote:
> > > On Wed, 7 Jun 2023 at 20:14, Jan Kiszka <jan.kiszka@siemens.com> wrot=
e:
> > >>
> > >> On 07.06.23 18:59, Ilias Apalodimas wrote:
> > >>> On Wed, 7 Jun 2023 at 19:09, Ilias Apalodimas
> > >>> <ilias.apalodimas@linaro.org> wrote:
> > >>>>
> > >>>> Hi Jan,
> > >>>>
> > >>>> [...]
> > >>>>>>>> No I don't, this will work reliably without the need to remount =
the efivarfs.
> > >>>>>>>> As you point out you will still have this dependency if you end =
up
> > >>>>>>>> building them as modules and you manage to mount the efivarfs be=
fore
> > >>>>>>>> those get inserted.  Does anyone see a reasonable workaround?
> > >>>>>>>> Deceiving the kernel and making the bootloader set the RT proper=
ty bit
> > >>>>>>>> to force the filesystem being mounted as rw is a nasty hack that=
 we
> > >>>>>>>> should avoid.  Maybe adding a kernel command line parameter that=
 says
> > >>>>>>>> "Ignore the RTPROP I know what I am doing"?  I don't particularl=
y love
> > >>>>>>>> this either, but it's not unreasonable.
> > >>>>>>>
> > >>>>>>> In the context of https://github.com/OP-TEE/optee_os/issues/6094,
> > >>>>>>> basically this issue mapped on reboot/shutdown, I would really lo=
ve to
> > >>>>>>> see the unhandy tee-supplicant daemon to be overcome.
> > >>>>>>
> > >>>>>> I have seen this error before and it has been on my todo list. So I
> > >>>>>> have tried to fix it here [1]. Feel free to test it and let me kno=
w if
> > >>>>>> you see any further issues.
> > >>>>>>
> > >>>>>> [1] https://lkml.org/lkml/2023/6/7/927
> > >>>>>>
> > >>>>>
> > >>>>> Ah, nice, will test ASAP!
> > >>>>>
> > >>>>> Meanwhile more food: I managed to build a firmware that was missing
> > >>>>> STMM. But the driver loaded, and I got this:
> > >>>>
> > >>>> Thanks for the testing. I'll try to reproduce it locally and get bac=
k to you
> > >>>
> > >>> Can you provide a bit more info on how that was triggered btw? I would
> > >>> be helpful to know
> > >>>
> > >>> - OP-TEE version
> > >>
> > >> Today's master, 145953d55.
> > >>
> > >>> - was it compiled as a module or built-in?
> > >>
> > >> Sorry, not sure anymore, switching back and forth right now. I think it
> > >> was built-in.
> > >>
> > >>> - was the supplicant running?
> > >>
> > >> Yes.
> > >>
> > >
> > > Ok thanks, that helps.  I guess this also means U-Boot was compiled to
> > > store the variables in a file in the ESP instead of the RPMB right?
> > > Otherwise, I can't see how the device booted in the first place.
> >
> > U-Boot was not configured to perform secure booting in this case. It had
> > RPMB support enabled, just didn't have to use it.
>
> In your initial mail you said you managed to build a firmware without
> StMM.  If U-boot isn't reconfigured accordingly -- iow skip the EFI
> variable storage in an RPMB, the EFI subsystem will fail to start.
>
> In any case, I don't think the ooops you are seeing is not connected
> to this patchset.  Looking at the kernel EFI stub we only set the
> SetVariableRT if the RTPROP table is set accordingly by the firmware.
> U-Boot never sets the EFI_RT_SUPPORTED_SET_VARIABLE property since it
> can't support it.  What you are doing is remount the efivarfs as rw
> and then trying to set a variable, but the callback for it is  NULL.
> I think you'll be able to replicate the same behavior on the kernel
> without even inserting the new module.
>

I have dropped this series from efi/next for now, given that it
obviously has problems in its current state.

The risk of merging this now and fixing it later is that it may cause
regressions for early adopters that rely on the behavior we are
introducing here. Better to get this in shape first.

--===============1965499902816637752==--

