From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 1/6] docs: staging/tee.rst: add a section on OP-TEE
 notifications
Date: Tue, 27 Jul 2021 16:57:07 +0200
Message-ID: 
 <CAHUa44HCEr_HKU0Fz10HPZYMowXVkx5JtnXMVTXd29wAv-dTCg@mail.gmail.com>
In-Reply-To: <87eebkdumr.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6571077921365286063=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6571077921365286063==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 27, 2021 at 10:32 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 27 Jul 2021 08:46:39 +0100,
> Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > On Fri, Jul 23, 2021 at 12:16 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Fri, 23 Jul 2021 10:44:17 +0100,
> > > Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > > >
> > > > Adds a section on notifications used by OP-TEE, synchronous and
> > > > asynchronous.
> > > >
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > ---
> > > >  Documentation/staging/tee.rst | 27 +++++++++++++++++++++++++++
> > > >  1 file changed, 27 insertions(+)
> > > >
> > > > diff --git a/Documentation/staging/tee.rst b/Documentation/staging/te=
e.rst
> > > > index 4d4b5f889603..37bdd097336f 100644
> > > > --- a/Documentation/staging/tee.rst
> > > > +++ b/Documentation/staging/tee.rst
> > > > @@ -184,6 +184,33 @@ order to support device enumeration. In other wo=
rds, OP-TEE driver invokes this
> > > >  application to retrieve a list of Trusted Applications which can be =
registered
> > > >  as devices on the TEE bus.
> > > >
> > > > +OP-TEE notifications
> > > > +--------------------
> > > > +
> > > > +There are two kinds of notifications that secure world can use to ma=
ke
> > > > +normal world aware of some event.
> > > > +
> > > > +1. Synchronous notifications delivered with ``OPTEE_RPC_CMD_NOTIFICA=
TION``
> > > > +   using the ``OPTEE_RPC_NOTIFICATION_SEND`` parameter.
> > > > +2. Asynchronous notifications delivered with a combination of a non-=
secure
> > > > +   interrupt and a fast call from the non-secure interrupt handler.
> > > > +
> > > > +Synchronous notifications are limited by depending on RPC for delive=
ry,
> > > > +this is only usable when secure world is entered with a yielding cal=
l via
> > > > +``OPTEE_SMC_CALL_WITH_ARG``. This excludes such notifications from s=
ecure
> > > > +world interrupt handlers.
> > > > +
> > > > +An asynchronous notification is delivered via a non-secure interrupt=
 to an
> > > > +interrupt handler registered in the OP-TEE driver. The actual notifi=
cation
> > > > +value are retrieved with the fast call ``OPTEE_SMC_GET_ASYNC_NOTIF_V=
ALUE``.
> > > > +
> > > > +One notification value ``OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF`=
` has a
> > > > +special meaning. When this value is received it means that normal wo=
rld is
> > > > +supposed to make a yielding call ``OPTEE_MSG_CMD_DO_BOTTOM_HALF``. T=
his
> > > > +call is done from the thread assisting the interrupt handler. This i=
s a
> > > > +building block for OP-TEE OS in secure world to implement the top ha=
lf and
> > > > +bottom half style of device drivers.
> > > > +
> > >
> > > What I find missing here is a description of the trigger for this
> > > interrupt, and how it influences the way the kernel drivers interacts
> > > with the secure side:
> > >
> > > - if it is edge triggered, this is 'fire and forget'. The interrupt
> > >   will be consumed by the kernel handler, and whether it eventually
> > >   calls into the secure side has no impact on the interrupt flow.
> > >
> > > - if it is level triggered, then the interrupt may be asserted until
> > >   the kernel calls into the secure side, which may then drop the line
> > >   level if no other requests are pending.
> > >
> > > These are evidently two very different flows, and you need to pick a
> > > side. Note that not all interrupt controllers support both signalling
> > > modes, so you are likely to leave something behind. Or you can try and
> > > support both flows, but that may make the driver slightly more
> > > complex.
> > >
> > > Either way, this needs specifying, here and in the DT binding.
> >
> > In the example I'm using a level triggered interrupt which is
> > triggered by writing to GICD_ISPENDR by secure world. Reading of
> > GICC_IAR should clear the interrupt,the GICv2 reference manual is
> > quite clear on that.
>
> No, it merely activates it. You can't transition an interrupt from
> pending to inactive (unless you clear it using GICD_ICPENDR). If you
> have spotted something else in the GICv2 architecture manual, please
> say so and I'll get it fixed 15 years after the facts. The fact that
> GICC_IAR consumes a pending bit introduced by a write to ISPENDR is an
> implementation detail, see below.

I was looking at figure 4-10 "Logic of the pending status of a
level-sensitive interrupt".

>
> It is also a flawed approach, as this behaviour is IMPDEF on GICv3
> (see 4.5 "Shared Peripheral Interrupts" in the GICv3 arch spec). Given
> that GICv2 is pretty much a dead horse (TFFT!), I can't see this approach
> being successful in the long run.

OK, thanks.

>
> > So, if I understand it correctly, it will for
> > this purpose work in the same way as an edge triggered interrupt. If
> > this wouldn't be the case in some configuration and the interrupt must
> > be cleared by some other action that would be a job for the receiver
> > of OPTEE_SMC_GET_ASYNC_NOTIF_VALUE, that is, a secure world problem.
> > The normal world flow should be the same.
>
> You are assuming that the secure side will use GICD_ISPENDR, and
> that's a leap of faith.

Not in this case with upstream OP-TEE. If we need to signal in a
different way we can do that instead.
What happens downstream we have no control over, but that's perhaps
not so different from the kernel.

> An implementation should use, say, a GPIO to
> drive the interrupt line and give it proper level semantics.

I'm not so keen on that since we often don't touch GPIO at all in
OP-TEE and this would then mean more platform specific code. We may
even need to synchronize some hardware access with the normal world
and then we'd be back at square one again.

>
> > Now that we describe the interrupt configuration in device tree it
> > must use something that mirrors the secure world expectations. I don't
> > see a point in restricting what's allowed as long it doesn't need code
> > changes in the kernel too. Does this make any sense?
>
> And that's the crucial point: what *are* the expectations of the
> secure side?

That should be up to the OP-TEE port of that particular platform to
decide and advise which device tree configuration to use.

> You seem to assume edge semantics, but that's unclear at
> best.

Fair enough, edge semantics solves the problem here.

>
> > If I just expand a bit above explaining that the interrupt handler
> > must call OPTEE_SMC_GET_ASYNC_NOTIF_VALUE as part of clearing the
> > interrupt even if it might be cleared anyway in some configurations.
> > Would that make it more clear, good enough even :-) ?
>
> This is an interrupt, please document it in terms of interrupt
> signalling.

In this file, Documentation/staging/tee.rst ? A pointer to a good
example of what you're expecting would be much appreciated.
There's also the file drivers/tee/optee/optee_smc.h, this is where the
ABI to OP-TEE is defined.

>
> - If it is level, the handler has to call into secure to observe the
>   level dropping. If the driver can observe the level being low before
>   calling into secure, it is perfectly allowed to consider the
>   interrupt being spurious and not perform the call. If you don't have
>   a device actively driving the line, this doesn't work.

Spurious calls to OPTEE_SMC_GET_ASYNC_NOTIF_VALUE are harmless, but it
will of course save a few cycles if they can be avoided.

>
> - It is edge, the handler can do anything it likes, including ignoring
>   the request after consuming the interrupt, or call into secure from
>   a kernel thread with interrupts enabled.

Yes, that's a bit more relaxed. Now I'm doing that part in the upper
half handler. I don't suppose it matters much, not much time is spent
there. The advantage is that it will work with a level triggered
interrupt too, if it would ever come to that. Provided that
OPTEE_SMC_GET_ASYNC_NOTIF_VALUE does what's needed to clear the
interrupt in secure world, but that should be mandated in such
configurations.

>
> At the end of the day, only you can decide which of these two flows
> are appropriate. If you don't want to mandate actual HW driving the
> line, edge triggered is your only option.

I agree that in the GIC case we should use edge triggered interrupts.
But It's not clear to me why this must be nailed down in any other
case instead of being left open to configuration.

The configuration that is best for the platform should be used, but
this is still a platform specific detail [1]. If device tree can give
us the flexibility to use level triggered interrupts with some other
interrupt controller and the kernel code already is capable of working
with that, what's the harm in leaving that open?

Thanks for your patience, I'm still trying to understand the parameters.

Cheers,
Jens
[1] The OP-TEE firmware is always built per platform with platform
specific configuration. With FF-A that may change, but then we'll also
base these notifications on FF-A instead of playing directly with
interrupts.

--===============6571077921365286063==--

