From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC PATCH 0/2] introduce op-tee based EFI Runtime Variable Service
Date: Mon, 06 Feb 2023 12:14:12 +0530
Message-ID: 
 <CAFA6WYPLeN5tUY8JA=J9T3XVNfq5jAQ62i=qSk-6eesM-9_K=Q@mail.gmail.com>
In-Reply-To: <Y9zoMJcbrKIvbDdh@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3363646874911473093=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3363646874911473093==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Feb 2023 at 16:25, Jens Wiklander <jens.wiklander@linaro.org> wro=
te:
>
> On Fri, Feb 03, 2023 at 03:03:34PM +0530, Sumit Garg wrote:
> > Hi Jens,
> >
> > On Fri, 3 Feb 2023 at 13:59, Jens Wiklander <jens.wiklander@linaro.org>=
 wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Thu, Feb 02, 2023 at 05:35:49PM +0530, Sumit Garg wrote:
> > > > Hi Masahisa,
> > > >
> > > > On Thu, 26 Jan 2023 at 18:52, Masahisa Kojima
> > > > <masahisa.kojima@linaro.org> wrote:
> > > > >
> > > > > This RFC series introduces the op-tee based EFI Runtime Variable
> > > > > Service.
> > > > >
> > > > > The eMMC device is typically owned by the non-secure world(linux in
> > > > > this case). There is an existing solution utilizing eMMC RPMB parti=
tion
> > > > > for EFI Variables, it is implemented by interacting with
> > > > > OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> > > > > and tee-supplicant. The last piece is the tee-based variable access
> > > > > driver to interact with OP-TEE and StandaloneMM.
> > > > >
> > > >
> > > > After an overall look at the APIs, following are some initial comment=
s:
> > > > - Is there any reason to have the edk2 specific StandaloneMM stack in
> > > > Linux to communicate with OP-TEE pseudo TA?
> > > > - I think the OP-TEE pseudo TA should be able to expose a rather
> > > > generic invoke commands such as:
> > > >      TEE_EFI_GET_VARIABLE
> > > >      TEE_EFI_GET_NEXT_VARIABLE
> > > >      TEE_EFI_SET_VARIABLE
> > > >   So it should no longer be tied to StMM stack and other TEE
> > > > implementations can re-use the abstracted interface to communicate
> > > > with its corresponding secure storage TA.
> > >
> > > In the current setup we have the following layers in the kernel:
> > > 1. efivar_operations
> > > 2. MM
> > > 3. PTA_STMM
> > > 4. OP-TEE MSG
> > >
> > > and in the secure world:
> > > S1. internal to StMM
> > > S2. MM interface to StMM
> > > S3. PTA_STMM
> > > S4. OP-TEE MSG
> > >
> > > If I understand you correctly you'd like to see this instead:
> > > Kernel:
> > > 1. efivar_operations
> > > 2. PTA_EFIVAR
> > > 4. OP-TEE MSG
> > >
> > > Since we still have the MM interface with StMM we'd have this in the se=
cure
> > > world:
> > > S1. internal to StMM
> > > S2. MM interface to StMM
> > > S3. PTA_EFIVAR
> > > S4. OP-TEE MSG
> > >
> > > At S3 we'd have to convert between EFIVAR and MM messages. The
> > > difference is that we're moving the EFIVAR <-> MM conversion from the
> > > non-secure world into the secure world. We're still using OP-TEE
> > > specific communication at the fourth layer. So we're only moving problem
> > > around, I'd rather avoid growing the OP-TEE part in the secure world.
> > >
> >
> > If you look carefully, we are essentially defining an ABI towards the
> > secure world. The approach in this patch-set adds the MM interface as
> > a redundant ABI layer which makes it complex to maintain. Now think
> > about if every TEE implementation would propose such a complex ABI. It
> > looks like a maintenance nightmare to me.
> >
> > The concerns you are highlighting about OP-TEE size, I think those are
> > implementation details which can be simplified later but once you have
> > defined an ABI then you are stuck with its maintainability.
>
> You have a point, but keep in mind that it's StMM that matters here.
> StMM uses the MM protocol. It was originially using raw SMCs as a
> conduit, but with the need for OP-TEE accessing RPMB that's not usable.
> So instead we use OP-TEE MSG as a conduit. Seen from that perspective
> we're only resuing something established instead of inventing something
> new.

Aren't we already adding PTA_STMM?

Isn't the StMM specific to Arm as you already mentioned it was
designed to specifically use raw SMCs? So if in future AMD TEE wants
to implement EFI services, can we suggest they reuse the MM interface?

I am not sure why we need to redirect EFI variables via MM interface
communication buffers rather than directly using the TEE shared memory
approach.

Ard,

Since you have better insights into how EFI runtime services have to
be implemented, can you share your opinion here? It may be something I
am missing here.

-Sumit

>
> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > > Cheers,
> > > Jens
> > >
> > > >
> > > > -Sumit
> > > >
> > > > > Masahisa Kojima (2):
> > > > >   efi: expose efivar generic ops register function
> > > > >   tee: Add op-tee helper functions for variable access
> > > > >
> > > > >  drivers/firmware/efi/efi.c           |  12 +
> > > > >  drivers/tee/optee/Kconfig            |  10 +
> > > > >  drivers/tee/optee/Makefile           |   1 +
> > > > >  drivers/tee/optee/mm_communication.h | 249 +++++++++++
> > > > >  drivers/tee/optee/optee_private.h    |   5 +-
> > > > >  drivers/tee/optee/optee_stmm_efi.c   | 598 +++++++++++++++++++++++=
++++
> > > > >  drivers/tee/tee_core.c               |  23 ++
> > > > >  include/linux/efi.h                  |   4 +
> > > > >  include/linux/tee_drv.h              |  23 ++
> > > > >  9 files changed, 924 insertions(+), 1 deletion(-)
> > > > >  create mode 100644 drivers/tee/optee/mm_communication.h
> > > > >  create mode 100644 drivers/tee/optee/optee_stmm_efi.c
> > > > >
> > > > > --
> > > > > 2.30.2
> > > > >

--===============3363646874911473093==--

