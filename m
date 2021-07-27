From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 1/6] docs: staging/tee.rst: add a section on OP-TEE
 notifications
Date: Tue, 27 Jul 2021 09:46:39 +0200
Message-ID: 
 <CAHUa44EhP5NCH6S27+Af8ePxAup9nJnrwGr_nMRUFumXOTh7uQ@mail.gmail.com>
In-Reply-To: <87zgud1giz.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0391672623453065000=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0391672623453065000==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 23, 2021 at 12:16 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 23 Jul 2021 10:44:17 +0100,
> Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Adds a section on notifications used by OP-TEE, synchronous and
> > asynchronous.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  Documentation/staging/tee.rst | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
> > index 4d4b5f889603..37bdd097336f 100644
> > --- a/Documentation/staging/tee.rst
> > +++ b/Documentation/staging/tee.rst
> > @@ -184,6 +184,33 @@ order to support device enumeration. In other words,=
 OP-TEE driver invokes this
> >  application to retrieve a list of Trusted Applications which can be regi=
stered
> >  as devices on the TEE bus.
> >
> > +OP-TEE notifications
> > +--------------------
> > +
> > +There are two kinds of notifications that secure world can use to make
> > +normal world aware of some event.
> > +
> > +1. Synchronous notifications delivered with ``OPTEE_RPC_CMD_NOTIFICATION=
``
> > +   using the ``OPTEE_RPC_NOTIFICATION_SEND`` parameter.
> > +2. Asynchronous notifications delivered with a combination of a non-secu=
re
> > +   interrupt and a fast call from the non-secure interrupt handler.
> > +
> > +Synchronous notifications are limited by depending on RPC for delivery,
> > +this is only usable when secure world is entered with a yielding call via
> > +``OPTEE_SMC_CALL_WITH_ARG``. This excludes such notifications from secure
> > +world interrupt handlers.
> > +
> > +An asynchronous notification is delivered via a non-secure interrupt to =
an
> > +interrupt handler registered in the OP-TEE driver. The actual notificati=
on
> > +value are retrieved with the fast call ``OPTEE_SMC_GET_ASYNC_NOTIF_VALUE=
``.
> > +
> > +One notification value ``OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF`` ha=
s a
> > +special meaning. When this value is received it means that normal world =
is
> > +supposed to make a yielding call ``OPTEE_MSG_CMD_DO_BOTTOM_HALF``. This
> > +call is done from the thread assisting the interrupt handler. This is a
> > +building block for OP-TEE OS in secure world to implement the top half a=
nd
> > +bottom half style of device drivers.
> > +
>
> What I find missing here is a description of the trigger for this
> interrupt, and how it influences the way the kernel drivers interacts
> with the secure side:
>
> - if it is edge triggered, this is 'fire and forget'. The interrupt
>   will be consumed by the kernel handler, and whether it eventually
>   calls into the secure side has no impact on the interrupt flow.
>
> - if it is level triggered, then the interrupt may be asserted until
>   the kernel calls into the secure side, which may then drop the line
>   level if no other requests are pending.
>
> These are evidently two very different flows, and you need to pick a
> side. Note that not all interrupt controllers support both signalling
> modes, so you are likely to leave something behind. Or you can try and
> support both flows, but that may make the driver slightly more
> complex.
>
> Either way, this needs specifying, here and in the DT binding.

In the example I'm using a level triggered interrupt which is
triggered by writing to GICD_ISPENDR by secure world. Reading of
GICC_IAR should clear the interrupt, the GICv2 reference manual is
quite clear on that. So, if I understand it correctly, it will for
this purpose work in the same way as an edge triggered interrupt. If
this wouldn't be the case in some configuration and the interrupt must
be cleared by some other action that would be a job for the receiver
of OPTEE_SMC_GET_ASYNC_NOTIF_VALUE, that is, a secure world problem.
The normal world flow should be the same.

Now that we describe the interrupt configuration in device tree it
must use something that mirrors the secure world expectations. I don't
see a point in restricting what's allowed as long it doesn't need code
changes in the kernel too. Does this make any sense?

If I just expand a bit above explaining that the interrupt handler
must call OPTEE_SMC_GET_ASYNC_NOTIF_VALUE as part of clearing the
interrupt even if it might be cleared anyway in some configurations.
Would that make it more clear, good enough even :-) ?

Thanks,
Jens

--===============0391672623453065000==--

