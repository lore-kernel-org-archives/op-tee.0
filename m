From: Marc Zyngier <maz@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 1/6] docs: staging/tee.rst: add a section on OP-TEE
 notifications
Date: Fri, 23 Jul 2021 11:16:52 +0100
Message-ID: <87zgud1giz.wl-maz@kernel.org>
In-Reply-To: <20210723094422.2150313-2-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9201026251809633878=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9201026251809633878==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Jul 2021 10:44:17 +0100,
Jens Wiklander <jens.wiklander@linaro.org> wrote:
>=20
> Adds a section on notifications used by OP-TEE, synchronous and
> asynchronous.
>=20
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  Documentation/staging/tee.rst | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
> index 4d4b5f889603..37bdd097336f 100644
> --- a/Documentation/staging/tee.rst
> +++ b/Documentation/staging/tee.rst
> @@ -184,6 +184,33 @@ order to support device enumeration. In other words, O=
P-TEE driver invokes this
>  application to retrieve a list of Trusted Applications which can be regist=
ered
>  as devices on the TEE bus.
> =20
> +OP-TEE notifications
> +--------------------
> +
> +There are two kinds of notifications that secure world can use to make
> +normal world aware of some event.
> +
> +1. Synchronous notifications delivered with ``OPTEE_RPC_CMD_NOTIFICATION``
> +   using the ``OPTEE_RPC_NOTIFICATION_SEND`` parameter.
> +2. Asynchronous notifications delivered with a combination of a non-secure
> +   interrupt and a fast call from the non-secure interrupt handler.
> +
> +Synchronous notifications are limited by depending on RPC for delivery,
> +this is only usable when secure world is entered with a yielding call via
> +``OPTEE_SMC_CALL_WITH_ARG``. This excludes such notifications from secure
> +world interrupt handlers.
> +
> +An asynchronous notification is delivered via a non-secure interrupt to an
> +interrupt handler registered in the OP-TEE driver. The actual notification
> +value are retrieved with the fast call ``OPTEE_SMC_GET_ASYNC_NOTIF_VALUE``.
> +
> +One notification value ``OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF`` has a
> +special meaning. When this value is received it means that normal world is
> +supposed to make a yielding call ``OPTEE_MSG_CMD_DO_BOTTOM_HALF``. This
> +call is done from the thread assisting the interrupt handler. This is a
> +building block for OP-TEE OS in secure world to implement the top half and
> +bottom half style of device drivers.
> +

What I find missing here is a description of the trigger for this
interrupt, and how it influences the way the kernel drivers interacts
with the secure side:

- if it is edge triggered, this is 'fire and forget'. The interrupt
  will be consumed by the kernel handler, and whether it eventually
  calls into the secure side has no impact on the interrupt flow.

- if it is level triggered, then the interrupt may be asserted until
  the kernel calls into the secure side, which may then drop the line
  level if no other requests are pending.

These are evidently two very different flows, and you need to pick a
side. Note that not all interrupt controllers support both signalling
modes, so you are likely to leave something behind. Or you can try and
support both flows, but that may make the driver slightly more
complex.

Either way, this needs specifying, here and in the DT binding.

Thanks,

	M.

--=20
Without deviation from the norm, progress is not possible.

--===============9201026251809633878==--

