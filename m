From: Ard Biesheuvel <ardb@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC PATCH 0/2] introduce op-tee based EFI Runtime Variable Service
Date: Mon, 06 Feb 2023 10:22:28 +0100
Message-ID: 
 <CAMj1kXGg3wwhJFRjAGEP2fDLcbHpiuHuiaW2y+oVgjwULqVTZg@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYPLeN5tUY8JA=J9T3XVNfq5jAQ62i=qSk-6eesM-9_K=Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8408169447343870993=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8408169447343870993==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Feb 2023 at 07:44, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Fri, 3 Feb 2023 at 16:25, Jens Wiklander <jens.wiklander@linaro.org> w=
rote:
> >
..
> > StMM uses the MM protocol. It was originially using raw SMCs as a
> > conduit, but with the need for OP-TEE accessing RPMB that's not usable.
> > So instead we use OP-TEE MSG as a conduit. Seen from that perspective
> > we're only resuing something established instead of inventing something
> > new.
>
> Aren't we already adding PTA_STMM?
>
> Isn't the StMM specific to Arm as you already mentioned it was
> designed to specifically use raw SMCs? So if in future AMD TEE wants
> to implement EFI services, can we suggest they reuse the MM interface?
>
> I am not sure why we need to redirect EFI variables via MM interface
> communication buffers rather than directly using the TEE shared memory
> approach.
>
> Ard,
>
> Since you have better insights into how EFI runtime services have to
> be implemented, can you share your opinion here? It may be something I
> am missing here.
>

Hello Sumit,

I'm not sure I understand what you are asking me here. Allow me to
reiterate, apologies if I am stating the obvious:

The EFI spec describes how the OS should expose the EFI runtime
services, but this is difficult to implement when access to the
underlying storage requires arbitration between accesses by the OS
itself and accesses made by the firmware.

On systems where this issue is absent, the EFI runtime service
implementation for the variable services are very thin wrappers around
calls into standalone MM, which are not standardized, but are also not
ARM specific (standalone MM is being used on other architectures as
well, and 'classic' SMM uses the same protocol but dispatches the call
into the secure/SMM world in a different way)

On systems where arbitration is needed, the standalone MM payload
needs to call back up into the OS to request access to the flash
storage. OP-TEE is a suitable vehicle for this, as it already does the
same thing for other reasons, and is already set up to dispatch SMC
calls that are taken to S-EL1.

All of his is uncharted territory as far as the EFI spec is concerned,
as it occurs inside the StMM pseudo-API call, which itself normally
occurs inside the EFI runtime service call. Given that we cannot use
the latter (as the firmware does not provide a working get/setvariable
at OS runtime [0]), we need to provide some plumbing to call the StMM
pseudo-API directly, and expose it as an alternative efivars
implementation. (Note that this should mean that other implementations
of the StMM pseudo-API that do not require this arbitration may
potentially be accessed in the same way, although I don't see a reason
to use it like that.)

If I am understanding you correctly, your question is whether OP-TEE
should expose the StMM pseudo-API in the usual way as well, and make
the OS rely on the usual discovery mechanisms etc to bind to it?

If that is indeed your question: what purpose would that serve,
exactly? In principle, the OS piece that implements efivars on top of
the StMM pseudo-API should not be specific to any TEE implementation
or API, and I think the fact that OP-TEE is the provider in this case
is an implementation detail.

If you feel that OP-TEE should not expose this interface directly to
begin with, and rely on some marshalling layer to expose the StMM
pseudo-API on top of its ordinary exposed API, that is really an
OP-TEE internal matter (which I think is what you discussed with Jens
up in the thread?) Since StMM calls are defined in terms of SMC
instructions + arguments, this would require more code inside OP-TEE
to translate access to an API that it already exposes directly as
well, so I'm not sure what the gain would be.

The thing to remember is that, even though the wrappers are very thin,
it is fundamentally the StMM API that is being exposed, not the EFI
runtime services API, and so whether or not a use case may materialize
that wants to expose a different API via efivars is out of scope here,
even if they are roughly shaped like get/setvariable.



--=20
Ard.


[0] It is permitted for implementations of, e.g., Get/SetTime or
ResetSystem to use Get/SetVariable internally, and this is quite
clearly broken if the EFI variable services cannot be used. However,
firmware implementations would presumably avoid that situation.

--===============8408169447343870993==--

