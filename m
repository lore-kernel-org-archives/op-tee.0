From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 4/4] efivarfs: automatically update super block flag
Date: Thu, 27 Jul 2023 11:55:08 +0900
Message-ID: 
 <CADQ0-X9Rvo2FZ_1y6t_KxOrLCEf0WN13YXyH9z4Ya15U4xPm_A@mail.gmail.com>
In-Reply-To: <
 <CADQ0-X8f7PrhMbepp_SCA3cvrUuz0+t1+xUdhx5O1yijsvMsYQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1392603138859485166=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1392603138859485166==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Jul 2023 at 13:49, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> Hi Ilias,
>
> On Mon, 24 Jul 2023 at 19:22, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Kojima-san,
> >
> > On Mon, 24 Jul 2023 at 05:53, Masahisa Kojima
> > <masahisa.kojima@linaro.org> wrote:
> > >
> > > Hi Ilias, Jan,
> > >
> > > On Fri, 23 Jun 2023 at 03:56, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Kojima-san, Jan
> > > >
> > > > On Thu, Jun 22, 2023 at 04:58:50PM +0200, Jan Kiszka wrote:
> > > > > On 22.06.23 10:51, Masahisa Kojima wrote:
> > > > > > efivar operation is updated when the tee_stmm_efi module is probe=
d.
> > > > > > tee_stmm_efi module supports SetVariable runtime service,
> > > > > > but user needs to manually remount the efivarfs as RW to enable
> > > > > > the write access if the previous efivar operation does not support
> > > > > > SerVariable and efivarfs is mounted as read-only.
> > > > > >
> > > > > > This commit notifies the update of efivar operation to
> > > > > > efivarfs subsystem, then drops SB_RDONLY flag if the efivar
> > > > > > operation supports SetVariable.
> > > > >
> > > > > But it does not re-add it and prevents further requests to the TA (=
that
> > > > > will only cause panics there) when the daemon terminates, does it?
> > > >
> > > > It doesn't, but I think I got a better way out.  Even what you sugges=
t won't
> > > > solve the problem entirely.  For the sake of context
> > > > - The kernel decides between the RO/RW depending on the SetVariable p=
tr
> > > > - The stmm *module* registers and swaps the RT calls -- and the ptr i=
s now
> > > > valid.  Note here that the module probe function will run only if the
> > > > supplicant is running
> > > > - Once the module is inserted the filesystem will be remounted even w=
ithout
> > > > the supplicant running, which would not trigger an oops, but an hard =
to
> > > > decipher error message from OP-TEE.
> > > >
> > > > So even if we switch the permissions back to RO when the supplicant d=
ies,
> > > > someone can still remount it as RW and trigger the same error.
> > > >
> > > > Which got me thinking and staring the TEE subsystem a bit more.  The
> > > > supplicant is backed by a /dev file, which naturally has .open() and
> > > > .release() callbacks.  Why don't we leave the module perform the init=
ial
> > > > setup -- e.g talk to StMM and make sure it's there, setup the necessa=
ry
> > > > buffers etc and defer the actual swapping of the efivar ops and the
> > > > filesystem permissions there?  I might 'feel' a bit weird, but as I
> > > > mentioned the module probe function only runs if the supplicant is ru=
nning
> > > > anyway
> > >
> > > I think we are discussing two issues.
> > >
> >
> > Yes
> >
> > > 1) efivar ops is not restored when the tee-supplicant daemon terminates.
> > >
> > > The patch[1] sent by Sumit addresses this issue.
> > > Thanks to this patch, 'remove' callback of tee_stmm_efi_driver is called
> > > when the tee-supplicant daemon terminates, then restore the previous ef=
ivar ops
> > > and SB_RDONLY flag if necessary.
> >
> > Ok but that didn't fix the original error Jan reported and I am not
> > sure about the patch status
>
> I think the patch is pending because the fTPM still causes panic when the s=
ystem
> shuts down.
> https://lore.kernel.org/all/452472c5-ef30-ac30-6e4e-954f53b48315(a)siemens.=
com/
>
> This is fTPM specific issue and is unrelated to the tee-based
> SetVariable runtime series itself.
>
> >
> > >
> > > 2) cause panic when someone remounts the efivarfs as RW even if
> > > SetVariable is not supported.
> >
> > Yes, this [0] is fixing that issue
>
> Thank you, I will include this patch in the next submission.
>
> Anyway, the GetVariable() runtime service backed by the U-Boot variable ser=
vice
> does not work from kernel v6.4.0, so I will investigate this issue.

I found that the QueryVariableInfo EFI API is required since this patch[2].
Current U-Boot does not support QueryVariableInfo runtime service.
Anyway this is not directly related to this series.
After efivar ops is replaced by the tee-based one, variable access works fine.

[2] https://lore.kernel.org/all/20230517153812.2010174-1-anisse(a)astier.eu/

Thanks,
Masahisa Kojima

>
> Thanks,
> Masahisa Kojima
>
> >
> > [0] https://lore.kernel.org/linux-efi/20230609094532.562934-1-ilias.apalo=
dimas(a)linaro.org/
> > Thanks
> > /Ilias
> > >
> > > [1] https://lore.kernel.org/all/20230607151435.92654-1-sumit.garg(a)lin=
aro.org/
> > >
> > > Thanks,
> > > Masahisa Kojima
> > >
> > > >
> > > > Cheers
> > > > /Ilias
> > > >
> > > > >
> > > > > Jan
> > > > >
> > > > > --
> > > > > Siemens AG, Technology
> > > > > Competence Center Embedded Linux
> > > > >

--===============1392603138859485166==--

