From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 4/4] efivarfs: automatically update super block flag
Date: Mon, 24 Jul 2023 11:52:56 +0900
Message-ID: 
 <CADQ0-X8TMQoViFW_zFCrOK6yjOqp-X8zQc6c2qsUcWZ5=Suugg@mail.gmail.com>
In-Reply-To: <ZJSZbmUz583pszny@hera>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5772399542132705205=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5772399542132705205==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilias, Jan,

On Fri, 23 Jun 2023 at 03:56, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Kojima-san, Jan
>
> On Thu, Jun 22, 2023 at 04:58:50PM +0200, Jan Kiszka wrote:
> > On 22.06.23 10:51, Masahisa Kojima wrote:
> > > efivar operation is updated when the tee_stmm_efi module is probed.
> > > tee_stmm_efi module supports SetVariable runtime service,
> > > but user needs to manually remount the efivarfs as RW to enable
> > > the write access if the previous efivar operation does not support
> > > SerVariable and efivarfs is mounted as read-only.
> > >
> > > This commit notifies the update of efivar operation to
> > > efivarfs subsystem, then drops SB_RDONLY flag if the efivar
> > > operation supports SetVariable.
> >
> > But it does not re-add it and prevents further requests to the TA (that
> > will only cause panics there) when the daemon terminates, does it?
>
> It doesn't, but I think I got a better way out.  Even what you suggest won't
> solve the problem entirely.  For the sake of context
> - The kernel decides between the RO/RW depending on the SetVariable ptr
> - The stmm *module* registers and swaps the RT calls -- and the ptr is now
> valid.  Note here that the module probe function will run only if the
> supplicant is running
> - Once the module is inserted the filesystem will be remounted even without
> the supplicant running, which would not trigger an oops, but an hard to
> decipher error message from OP-TEE.
>
> So even if we switch the permissions back to RO when the supplicant dies,
> someone can still remount it as RW and trigger the same error.
>
> Which got me thinking and staring the TEE subsystem a bit more.  The
> supplicant is backed by a /dev file, which naturally has .open() and
> .release() callbacks.  Why don't we leave the module perform the initial
> setup -- e.g talk to StMM and make sure it's there, setup the necessary
> buffers etc and defer the actual swapping of the efivar ops and the
> filesystem permissions there?  I might 'feel' a bit weird, but as I
> mentioned the module probe function only runs if the supplicant is running
> anyway

I think we are discussing two issues.

1) efivar ops is not restored when the tee-supplicant daemon terminates.

The patch[1] sent by Sumit addresses this issue.
Thanks to this patch, 'remove' callback of tee_stmm_efi_driver is called
when the tee-supplicant daemon terminates, then restore the previous efivar o=
ps
and SB_RDONLY flag if necessary.

2) cause panic when someone remounts the efivarfs as RW even if
SetVariable is not supported.

[1] https://lore.kernel.org/all/20230607151435.92654-1-sumit.garg(a)linaro.or=
g/

Thanks,
Masahisa Kojima

>
> Cheers
> /Ilias
>
> >
> > Jan
> >
> > --
> > Siemens AG, Technology
> > Competence Center Embedded Linux
> >

--===============5772399542132705205==--

