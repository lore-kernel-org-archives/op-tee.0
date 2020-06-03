From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [op-tee] [PATCH] Documentation: tee: Document TEE kernel interface
Date: Wed, 03 Jun 2020 17:01:28 +0530
Message-ID: <1591183888-11101-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4866038616064524997=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4866038616064524997==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Update documentation with TEE bus infrastructure which provides an
interface for kernel client drivers to communicate with corresponding
Trusted Application.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 Documentation/tee.txt | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/tee.txt b/Documentation/tee.txt
index c8fad81..428d3b5 100644
--- a/Documentation/tee.txt
+++ b/Documentation/tee.txt
@@ -53,6 +53,28 @@ clients, forward them to the TEE and send back the results=
. In the case of
 supplicants the communication goes in the other direction, the TEE sends
 requests to the supplicant which then sends back the result.
=20
+The TEE kernel interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Kernel provides a TEE bus infrastructure where a Trusted Application is
+represented as a device identified via Universally Unique Identifier (UUID) =
and
+client drivers register a table of supported device UUIDs.
+
+TEE bus infrastructure registers following APIs:
+-  match(): iterates over the client driver UUID table to find a correspondi=
ng
+   match for device UUID. If a match is found, then this particular device is
+   probed via corresponding probe API registered by the client driver. This
+   process happens whenever a device or a client driver is registered with T=
EE
+   bus.
+-  uevent(): notifies user-space (udev) whenever a new device is registered =
on
+   TEE bus for auto-loading of modularized client drivers.
+
+TEE bus device enumeration is specific to underlying TEE implementation, so =
it
+is left open for TEE drivers to provide corresponding implementation.
+
+Then TEE client driver can talk to a matched Trusted Application using APIs
+listed in include/linux/tee_drv.h.
+
 OP-TEE driver
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
@@ -112,6 +134,14 @@ kernel are handled by the kernel driver. Other RPC messa=
ges will be forwarded to
 tee-supplicant without further involvement of the driver, except switching
 shared memory buffer representation.
=20
+OP-TEE device enumeration
+-------------------------
+
+OP-TEE provides a pseudo Trusted Application: drivers/tee/optee/device.c in
+order to support device enumeration. In other words, OP-TEE driver invokes t=
his
+application to retrieve a list of Trusted Applications which can be register=
ed
+as devices on the TEE bus.
+
 AMD-TEE driver
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
--=20
2.7.4


--===============4866038616064524997==--

