From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC PATCH 0/2] introduce op-tee based EFI Runtime Variable Service
Date: Thu, 02 Feb 2023 15:19:42 +0200
Message-ID: <Y9u4bih4jZlg3Kb6@hera>
In-Reply-To: <
 <CAFA6WYMdTxkcFkSux7F3fwxx2OqHP9UzqbWxdGnxuzjNU75PxA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0052347641512223775=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0052347641512223775==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, Feb 02, 2023 at 05:35:49PM +0530, Sumit Garg wrote:
> Hi Masahisa,
>
> On Thu, 26 Jan 2023 at 18:52, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > This RFC series introduces the op-tee based EFI Runtime Variable
> > Service.
> >
> > The eMMC device is typically owned by the non-secure world(linux in
> > this case). There is an existing solution utilizing eMMC RPMB partition
> > for EFI Variables, it is implemented by interacting with
> > OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> > and tee-supplicant. The last piece is the tee-based variable access
> > driver to interact with OP-TEE and StandaloneMM.
> >
>
> After an overall look at the APIs, following are some initial comments:
> - Is there any reason to have the edk2 specific StandaloneMM stack in
> Linux to communicate with OP-TEE pseudo TA?

The problem is StMM is not a pseudo-TA and pretending to be one
is not easy.  It looks like one, but due to the internal ABI, it's compiled
and launched differently within OP-TEE.  We could still add this but...

> - I think the OP-TEE pseudo TA should be able to expose a rather
> generic invoke commands such as:
>      TEE_EFI_GET_VARIABLE
>      TEE_EFI_GET_NEXT_VARIABLE
>      TEE_EFI_SET_VARIABLE
>   So it should no longer be tied to StMM stack and other TEE
> implementations can re-use the abstracted interface to communicate
> with its corresponding secure storage TA.

I talked about this with Jens, but there's an assumption here that every
TEE from that point onward will implement this.  But without a standard
describing this, I don't see how we can convince others.  The current code
puts the responsibility back to the tee/core subsystem, so any vendor can
provide his own callbacks

Regards
/Ilias
>
> -Sumit
>
> > Masahisa Kojima (2):
> >   efi: expose efivar generic ops register function
> >   tee: Add op-tee helper functions for variable access
> >
> >  drivers/firmware/efi/efi.c           |  12 +
> >  drivers/tee/optee/Kconfig            |  10 +
> >  drivers/tee/optee/Makefile           |   1 +
> >  drivers/tee/optee/mm_communication.h | 249 +++++++++++
> >  drivers/tee/optee/optee_private.h    |   5 +-
> >  drivers/tee/optee/optee_stmm_efi.c   | 598 +++++++++++++++++++++++++++
> >  drivers/tee/tee_core.c               |  23 ++
> >  include/linux/efi.h                  |   4 +
> >  include/linux/tee_drv.h              |  23 ++
> >  9 files changed, 924 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/tee/optee/mm_communication.h
> >  create mode 100644 drivers/tee/optee/optee_stmm_efi.c
> >
> > --
> > 2.30.2
> >

--===============0052347641512223775==--

