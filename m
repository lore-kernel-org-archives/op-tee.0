From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC PATCH 0/2] introduce op-tee based EFI Runtime Variable Service
Date: Mon, 06 Feb 2023 11:31:46 +0200
Message-ID: <Y+DJAqiKGb/01wgV@hades>
In-Reply-To: <
 <CAFA6WYPLeN5tUY8JA=J9T3XVNfq5jAQ62i=qSk-6eesM-9_K=Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9180916806283065909=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9180916806283065909==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2023 at 12:14:12PM +0530, Sumit Garg wrote:
> On Fri, 3 Feb 2023 at 16:25, Jens Wiklander <jens.wiklander@linaro.org> w=
rote:
> >
> > > > > with its corresponding secure storage TA.
> > > >
> > > > In the current setup we have the following layers in the kernel:
> > > > 1. efivar_operations
> > > > 2. MM
> > > > 3. PTA_STMM
> > > > 4. OP-TEE MSG
> > > >
> > > > and in the secure world:
> > > > S1. internal to StMM
> > > > S2. MM interface to StMM
> > > > S3. PTA_STMM
> > > > S4. OP-TEE MSG
> > > >
> > > > If I understand you correctly you'd like to see this instead:
> > > > Kernel:
> > > > 1. efivar_operations
> > > > 2. PTA_EFIVAR
> > > > 4. OP-TEE MSG
> > > >
> > > > Since we still have the MM interface with StMM we'd have this in the =
secure
> > > > world:
> > > > S1. internal to StMM
> > > > S2. MM interface to StMM
> > > > S3. PTA_EFIVAR
> > > > S4. OP-TEE MSG
> > > >
> > > > At S3 we'd have to convert between EFIVAR and MM messages. The
> > > > difference is that we're moving the EFIVAR <-> MM conversion from the
> > > > non-secure world into the secure world. We're still using OP-TEE
> > > > specific communication at the fourth layer. So we're only moving prob=
lem
> > > > around, I'd rather avoid growing the OP-TEE part in the secure world.
> > > >
> > >
> > > If you look carefully, we are essentially defining an ABI towards the
> > > secure world. The approach in this patch-set adds the MM interface as
> > > a redundant ABI layer which makes it complex to maintain. Now think
> > > about if every TEE implementation would propose such a complex ABI. It
> > > looks like a maintenance nightmare to me.
> > >
> > > The concerns you are highlighting about OP-TEE size, I think those are
> > > implementation details which can be simplified later but once you have
> > > defined an ABI then you are stuck with its maintainability.
> >
> > You have a point, but keep in mind that it's StMM that matters here.
> > StMM uses the MM protocol. It was originially using raw SMCs as a
> > conduit, but with the need for OP-TEE accessing RPMB that's not usable.
> > So instead we use OP-TEE MSG as a conduit. Seen from that perspective
> > we're only resuing something established instead of inventing something
> > new.
>=20
> Aren't we already adding PTA_STMM?

There's a sequence diagram that might help here [0].
The StMM PTA,  is responsible for wrapping the buffer it received from the
NS-world into an MM buffer.

>=20
> Isn't the StMM specific to Arm as you already mentioned it was
> designed to specifically use raw SMCs? So if in future AMD TEE wants
> to implement EFI services, can we suggest they reuse the MM interface?

The MM interface is not exposed as an ABI to the non-secure world.  From
a Linux point of view, it's still a normal SMC invoke command towards OP-TEE.
What's 'special' and part of the ABI, is that the driver prepares the buffer
in a way StMM understands.  Then it gets handed over to OP-TEE, which
encapsulates it in an MM buffer and sends it to StMM.

As Jens already said, you asking to move the 'special stmm buffer' creation=20
into OP-TEE instead of having the linux driver responsible for it.  That way =
we
can define an API for other TEEs, which will make the linux driver simpler.
We would ofc need to define some kind of versioning or service ID in that
API, so every TEE knows what it's supposed to call afterwards (iow an
internal TEE identifier in case we end up with multiple backends handling
EFI variables even in the same TEE).=20

The proposal definitely makes sense,  but we are adding complexity and
knowledge of EFI to the secure world.  Someone still has to prepare a
buffer the way StMM understands it.

>=20
> I am not sure why we need to redirect EFI variables via MM interface
> communication buffers rather than directly using the TEE shared memory
> approach.
>=20
> Ard,
>=20
> Since you have better insights into how EFI runtime services have to
> be implemented, can you share your opinion here? It may be something I
> am missing here.
>=20
> -Sumit
>=20

[0] https://apalos.github.io/Protected%20UEFI%20variables%20with%20U-Boot.htm=
l#Protected%20UEFI%20variables%20with%20U-Boot

Cheers
/Ilias

--===============9180916806283065909==--

