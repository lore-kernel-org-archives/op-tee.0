From: Marc Zyngier <maz@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 1/6] docs: staging/tee.rst: add a section on OP-TEE
 notifications
Date: Wed, 04 Aug 2021 15:39:17 +0100
Message-ID: <87lf5hw9yi.wl-maz@kernel.org>
In-Reply-To: <
 <CAHUa44HCEr_HKU0Fz10HPZYMowXVkx5JtnXMVTXd29wAv-dTCg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4525040871164677196=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4525040871164677196==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Jul 2021 15:57:07 +0100,
Jens Wiklander <jens.wiklander@linaro.org> wrote:
>=20
> On Tue, Jul 27, 2021 at 10:32 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Tue, 27 Jul 2021 08:46:39 +0100,
> > Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >
> > > On Fri, Jul 23, 2021 at 12:16 PM Marc Zyngier <maz@kernel.org> wrote:
> > > >
> > > > On Fri, 23 Jul 2021 10:44:17 +0100,
> > > > Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > > > >
> > > > > Adds a section on notifications used by OP-TEE, synchronous and
> > > > > asynchronous.
> > > > >
> > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > ---
> > > > >  Documentation/staging/tee.rst | 27 +++++++++++++++++++++++++++
> > > > >  1 file changed, 27 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/staging/tee.rst b/Documentation/staging/=
tee.rst
> > > > > index 4d4b5f889603..37bdd097336f 100644
> > > > > --- a/Documentation/staging/tee.rst
> > > > > +++ b/Documentation/staging/tee.rst
> > > > > @@ -184,6 +184,33 @@ order to support device enumeration. In other =
words, OP-TEE driver invokes this
> > > > >  application to retrieve a list of Trusted Applications which can b=
e registered
> > > > >  as devices on the TEE bus.
> > > > >
> > > > > +OP-TEE notifications
> > > > > +--------------------
> > > > > +
> > > > > +There are two kinds of notifications that secure world can use to =
make
> > > > > +normal world aware of some event.
> > > > > +
> > > > > +1. Synchronous notifications delivered with ``OPTEE_RPC_CMD_NOTIFI=
CATION``
> > > > > +   using the ``OPTEE_RPC_NOTIFICATION_SEND`` parameter.
> > > > > +2. Asynchronous notifications delivered with a combination of a no=
n-secure
> > > > > +   interrupt and a fast call from the non-secure interrupt handler.
> > > > > +
> > > > > +Synchronous notifications are limited by depending on RPC for deli=
very,
> > > > > +this is only usable when secure world is entered with a yielding c=
all via
> > > > > +``OPTEE_SMC_CALL_WITH_ARG``. This excludes such notifications from=
 secure
> > > > > +world interrupt handlers.
> > > > > +
> > > > > +An asynchronous notification is delivered via a non-secure interru=
pt to an
> > > > > +interrupt handler registered in the OP-TEE driver. The actual noti=
fication
> > > > > +value are retrieved with the fast call ``OPTEE_SMC_GET_ASYNC_NOTIF=
_VALUE``.
> > > > > +
> > > > > +One notification value ``OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HAL=
F`` has a
> > > > > +special meaning. When this value is received it means that normal =
world is
> > > > > +supposed to make a yielding call ``OPTEE_MSG_CMD_DO_BOTTOM_HALF``.=
 This
> > > > > +call is done from the thread assisting the interrupt handler. This=
 is a
> > > > > +building block for OP-TEE OS in secure world to implement the top =
half and
> > > > > +bottom half style of device drivers.
> > > > > +
> > > >
> > > > What I find missing here is a description of the trigger for this
> > > > interrupt, and how it influences the way the kernel drivers interacts
> > > > with the secure side:
> > > >
> > > > - if it is edge triggered, this is 'fire and forget'. The interrupt
> > > >   will be consumed by the kernel handler, and whether it eventually
> > > >   calls into the secure side has no impact on the interrupt flow.
> > > >
> > > > - if it is level triggered, then the interrupt may be asserted until
> > > >   the kernel calls into the secure side, which may then drop the line
> > > >   level if no other requests are pending.
> > > >
> > > > These are evidently two very different flows, and you need to pick a
> > > > side. Note that not all interrupt controllers support both signalling
> > > > modes, so you are likely to leave something behind. Or you can try and
> > > > support both flows, but that may make the driver slightly more
> > > > complex.
> > > >
> > > > Either way, this needs specifying, here and in the DT binding.
> > >
> > > In the example I'm using a level triggered interrupt which is
> > > triggered by writing to GICD_ISPENDR by secure world. Reading of
> > > GICC_IAR should clear the interrupt,the GICv2 reference manual is
> > > quite clear on that.
> >
> > No, it merely activates it. You can't transition an interrupt from
> > pending to inactive (unless you clear it using GICD_ICPENDR). If you
> > have spotted something else in the GICv2 architecture manual, please
> > say so and I'll get it fixed 15 years after the facts. The fact that
> > GICC_IAR consumes a pending bit introduced by a write to ISPENDR is an
> > implementation detail, see below.
>=20
> I was looking at figure 4-10 "Logic of the pending status of a
> level-sensitive interrupt".
>=20
> >
> > It is also a flawed approach, as this behaviour is IMPDEF on GICv3
> > (see 4.5 "Shared Peripheral Interrupts" in the GICv3 arch spec). Given
> > that GICv2 is pretty much a dead horse (TFFT!), I can't see this approach
> > being successful in the long run.
>=20
> OK, thanks.
>=20
> >
> > > So, if I understand it correctly, it will for
> > > this purpose work in the same way as an edge triggered interrupt. If
> > > this wouldn't be the case in some configuration and the interrupt must
> > > be cleared by some other action that would be a job for the receiver
> > > of OPTEE_SMC_GET_ASYNC_NOTIF_VALUE, that is, a secure world problem.
> > > The normal world flow should be the same.
> >
> > You are assuming that the secure side will use GICD_ISPENDR, and
> > that's a leap of faith.
>=20
> Not in this case with upstream OP-TEE. If we need to signal in a
> different way we can do that instead.
> What happens downstream we have no control over, but that's perhaps
> not so different from the kernel.
>=20
> > An implementation should use, say, a GPIO to
> > drive the interrupt line and give it proper level semantics.
>=20
> I'm not so keen on that since we often don't touch GPIO at all in
> OP-TEE and this would then mean more platform specific code. We may
> even need to synchronize some hardware access with the normal world
> and then we'd be back at square one again.

I'm trying to make a general statement here. OP-TEE may not do any of
this. Yet. Other TEE implementations may do it because there is no
free SPI in the system, for example. The problem is that interrupt
signalling is a *device* thing, even if the device is actually some SW
running on the secure side, and I would like the TEE to behave as
such.

> > > Now that we describe the interrupt configuration in device tree it
> > > must use something that mirrors the secure world expectations. I don't
> > > see a point in restricting what's allowed as long it doesn't need code
> > > changes in the kernel too. Does this make any sense?
> >
> > And that's the crucial point: what *are* the expectations of the
> > secure side?
>=20
> That should be up to the OP-TEE port of that particular platform to
> decide and advise which device tree configuration to use.
>=20
> > You seem to assume edge semantics, but that's unclear at
> > best.
>=20
> Fair enough, edge semantics solves the problem here.
>=20
> >
> > > If I just expand a bit above explaining that the interrupt handler
> > > must call OPTEE_SMC_GET_ASYNC_NOTIF_VALUE as part of clearing the
> > > interrupt even if it might be cleared anyway in some configurations.
> > > Would that make it more clear, good enough even :-) ?
> >
> > This is an interrupt, please document it in terms of interrupt
> > signalling.
>=20
> In this file, Documentation/staging/tee.rst ? A pointer to a good
> example of what you're expecting would be much appreciated.
> There's also the file drivers/tee/optee/optee_smc.h, this is where the
> ABI to OP-TEE is defined.

This file is fine, but repeating in the DT binding that edge
signalling is what is expected would be good.

Thanks,

	M.

--=20
Without deviation from the norm, progress is not possible.

--===============4525040871164677196==--

