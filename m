From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v4 1/6] docs: staging/tee.rst: add a section on OP-TEE notifications
Date: Wed, 18 Aug 2021 12:18:44 +0200
Message-ID: <20210818101849.602257-2-jens.wiklander@linaro.org>
In-Reply-To: <20210818101849.602257-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1533344754724110418=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1533344754724110418==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds a section on notifications used by OP-TEE, synchronous and
asynchronous.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 Documentation/staging/tee.rst | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
index 4d4b5f889603..951f07dd026b 100644
--- a/Documentation/staging/tee.rst
+++ b/Documentation/staging/tee.rst
@@ -184,6 +184,35 @@ order to support device enumeration. In other words, OP-=
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
+``OPTEE_SMC_GET_ASYNC_NOTIF_VALUE``.
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


--===============1533344754724110418==--

