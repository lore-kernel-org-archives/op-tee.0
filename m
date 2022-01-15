From: Wang Cheng <wanngchenng@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] docs: staging/tee.rst: fix two typos found while reading
Date: Sat, 15 Jan 2022 12:52:42 +0000
Message-ID: <20220115125236.34886-1-wanngchenng@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7384746976505917928=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7384746976505917928==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Wang Cheng <wanngchenng@gmail.com>
---
 Documentation/staging/tee.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
index 3c63d8dcd61e..498343c7ab08 100644
--- a/Documentation/staging/tee.rst
+++ b/Documentation/staging/tee.rst
@@ -255,7 +255,7 @@ The following picture shows a high level overview of AMD-=
TEE::
  +--------------------------+      +---------+--------------------+
=20
 At the lowest level (in x86), the AMD Secure Processor (ASP) driver uses the
-CPU to PSP mailbox regsister to submit commands to the PSP. The format of the
+CPU to PSP mailbox register to submit commands to the PSP. The format of the
 command buffer is opaque to the ASP driver. It's role is to submit commands =
to
 the secure processor and return results to AMD-TEE driver. The interface
 between AMD-TEE driver and AMD Secure Processor driver can be found in [6].
@@ -290,7 +290,7 @@ cancel_req driver callback is not supported by AMD-TEE.
=20
 The GlobalPlatform TEE Client API [5] can be used by the user space (client)=
 to
 talk to AMD's TEE. AMD's TEE provides a secure environment for loading, open=
ing
-a session, invoking commands and clossing session with TA.
+a session, invoking commands and closing session with TA.
=20
 References
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--=20
2.33.1


--===============7384746976505917928==--

