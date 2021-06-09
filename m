From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 4/4] optee: add asynchronous notifications
Date: Wed, 09 Jun 2021 09:40:33 +0200
Message-ID: <20210609074033.GA1913856@jade>
In-Reply-To: <
 <CAMj1kXGP=ZzVNTYZ3zuUS6G8wmbiu1f52nxmXk8QWeFgvXhBeA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3941632584693299303=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3941632584693299303==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Ard,

On Wed, Jun 09, 2021 at 09:02:19AM +0200, Ard Biesheuvel wrote:
> (+ Marc)
>=20
> Hi Jens,
>=20
> On Wed, 9 Jun 2021 at 08:11, Jens Wiklander <jens.wiklander@linaro.org> w=
rote:
> >
> > Adds support for asynchronous notifications from secure world to normal
> > world. This allows a design with a top half and bottom half type of
> > driver where the top half runs in secure interrupt context and a
> > notifications tells normal world to schedule a yielding call to do the
> > bottom half processing.
> >
> > The protocol is defined in optee_msg.h optee_rpc_cmd.h and optee_smc.h.
> >
> > A notification consists of a 32-bit value which normal world can
> > retrieve using a fastcall into secure world. The value
> > OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF (0) has a special meaning.
> > When this value is sent it means that normal world is supposed to make a
> > yielding call OPTEE_MSG_CMD_DO_BOTTOM_HALF.
> >
> > Notification capability is negotiated while the driver is initialized.
> > If both sides supports these notifications then they are enabled.
> >
> > A SPI interrupt is used to notify the driver that there are asynchronous
> > notifications pending.
>=20
> Wouldn't it be better for this interrupt to be described using DT or
> ACPI, and use the normal IRQ request API, rather than putting GIC
> specifics into this driver?

For this to work both OP-TEE in secure world and the kernel driver must
agree on the same configuration. Having the configuration hardcoded in
two different locations (DT/ACPI and OP-TEE) at the same time is going
to be painful so we should pick one place.

OP-TEE is normally compiled for a single platform at a time so compiling
with a preferred configuration for that platform is not an issue. On the
other hand, dynamic configuration with different optinally drivers is
something that we try to avoid. If nothing else just to conserve secure
memory. Dynamic configuration with a parameter like and interrupt ID or
such is fine though.

Regardless if the main configuration is kept in DT/ACPI or OP-TEE we
should preferably be able to convey that configuration to the other side
during the capability exchange when the driver is probed. Do you think
it's possible to come up with something generic enough using just a few
registers?

>=20
> E.g., SynQuacer has a EXIU interrupt block that sits before the GIC,
> and would probably be more suitable for delivering secure-to-normal
> world software interrupts in this way, but I don't think your current
> design would support that.

Agree, we need to be a bit more flexible.

By the way, here's some documention on the design:
https://optee.readthedocs.io/en/latest/architecture/core.html#notifications

>=20
>=20
> > The interrupt number is transmitted during
> > capability exchange. The maximum needed notification value is also
> > communicated at this stage. This allows scaling up when needed.


Cheers,
Jens

--===============3941632584693299303==--

