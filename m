From: Marc Zyngier <maz@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 1/6] docs: staging/tee.rst: add a section on OP-TEE
 notifications
Date: Wed, 18 Aug 2021 19:27:58 +0100
Message-ID: <878s0ysj4h.wl-maz@kernel.org>
In-Reply-To: <20210818101849.602257-2-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6005842405666443857=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6005842405666443857==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Aug 2021 11:18:44 +0100,
Jens Wiklander <jens.wiklander@linaro.org> wrote:
>=20
> Adds a section on notifications used by OP-TEE, synchronous and
> asynchronous.
>=20
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  Documentation/staging/tee.rst | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
> index 4d4b5f889603..951f07dd026b 100644
> --- a/Documentation/staging/tee.rst
> +++ b/Documentation/staging/tee.rst
> @@ -184,6 +184,35 @@ order to support device enumeration. In other words, O=
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
> +   edge-triggered interrupt and a fast call from the non-secure interrupt
> +   handler.
> +
> +Synchronous notifications are limited by depending on RPC for delivery,
> +this is only usable when secure world is entered with a yielding call via
> +``OPTEE_SMC_CALL_WITH_ARG``. This excludes such notifications from secure
> +world interrupt handlers.
> +
> +An asynchronous notification is delivered via a non-secure edge-triggered
> +interrupt to an interrupt handler registered in the OP-TEE driver. The
> +actual notification value are retrieved with the fast call
> +``OPTEE_SMC_GET_ASYNC_NOTIF_VALUE``.

One thing you may want to describe whether a single interrupt can
represent multiple notification (multiple edge interrupts will happily
be coalesced into a single one if not acknowledged before the next
notification).

Otherwise,

Acked-by: Marc Zyngier <maz@kernel.org>

	M.

--=20
Without deviation from the norm, progress is not possible.

--===============6005842405666443857==--

