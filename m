From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v5 1/6] docs: staging/tee.rst: add a section on OP-TEE notifications
Date: Thu, 26 Aug 2021 14:30:27 +0200
Message-ID: <20210826123032.1732926-2-jens.wiklander@linaro.org>
In-Reply-To: <20210826123032.1732926-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6717363906359841282=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6717363906359841282==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds a section on notifications used by OP-TEE, synchronous and
asynchronous.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 Documentation/staging/tee.rst | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
index 4d4b5f889603..3c63d8dcd61e 100644
--- a/Documentation/staging/tee.rst
+++ b/Documentation/staging/tee.rst
@@ -184,6 +184,36 @@ order to support device enumeration. In other words, OP-=
TEE driver invokes this
 application to retrieve a list of Trusted Applications which can be register=
ed
 as devices on the TEE bus.
=20
+OP-TEE notifications
+--------------------
+
+There are two kinds of notifications that secure world can use to make
+normal world aware of some event.
+
+1. Synchronous notifications delivered with ``OPTEE_RPC_CMD_NOTIFICATION``
+   using the ``OPTEE_RPC_NOTIFICATION_SEND`` parameter.
+2. Asynchronous notifications delivered with a combination of a non-secure
+   edge-triggered interrupt and a fast call from the non-secure interrupt
+   handler.
+
+Synchronous notifications are limited by depending on RPC for delivery,
+this is only usable when secure world is entered with a yielding call via
+``OPTEE_SMC_CALL_WITH_ARG``. This excludes such notifications from secure
+world interrupt handlers.
+
+An asynchronous notification is delivered via a non-secure edge-triggered
+interrupt to an interrupt handler registered in the OP-TEE driver. The
+actual notification value are retrieved with the fast call
+``OPTEE_SMC_GET_ASYNC_NOTIF_VALUE``. Note that one interrupt can represent
+multiple notifications.
+
+One notification value ``OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF`` has a
+special meaning. When this value is received it means that normal world is
+supposed to make a yielding call ``OPTEE_MSG_CMD_DO_BOTTOM_HALF``. This
+call is done from the thread assisting the interrupt handler. This is a
+building block for OP-TEE OS in secure world to implement the top half and
+bottom half style of device drivers.
+
 AMD-TEE driver
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
--=20
2.31.1


--===============6717363906359841282==--

