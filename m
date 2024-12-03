From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 10/10] Documentation: tee: Add Qualcomm TEE driver
Date: Mon, 02 Dec 2024 20:19:26 -0800
Message-ID: <20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-10-f502ef01e016@quicinc.com>
In-Reply-To: <=?utf-8?q?=3C20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-?=
 =?utf-8?q?0-f502ef01e016=40quicinc=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4017629352251074074=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4017629352251074074==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Add documentation for the Qualcomm TEE driver.

Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
---
 Documentation/tee/index.rst |   1 +
 Documentation/tee/qtee.rst  | 143 ++++++++++++++++++++++++++++++++++++++++++=
++
 2 files changed, 144 insertions(+)

diff --git a/Documentation/tee/index.rst b/Documentation/tee/index.rst
index 4be6e69d7837..62afb7ee9b52 100644
--- a/Documentation/tee/index.rst
+++ b/Documentation/tee/index.rst
@@ -11,6 +11,7 @@ TEE Subsystem
    op-tee
    amd-tee
    ts-tee
+   qtee
=20
 .. only::  subproject and html
=20
diff --git a/Documentation/tee/qtee.rst b/Documentation/tee/qtee.rst
new file mode 100644
index 000000000000..3185af2c2b2b
--- /dev/null
+++ b/Documentation/tee/qtee.rst
@@ -0,0 +1,143 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+QTEE (Qualcomm Trusted Execution Environment)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The QTEE driver handle communication with Qualcomm TEE [1].
+
+Lowest level of communication with QTEE builds on ARM SMC Calling Convention
+(SMCCC) [2], which is the foundation for QTEE's Secure Channel Manager (SCM)=
 [3]
+used internally by the driver [4].
+
+In a QTEE-based system, services are represented as objects with series of
+operations that can be called to produce results, including other objects. W=
hen
+an object is hosted within QTEE, executing its operations is referred to as =
direct
+invocation. QTEE can invoke objects hosted in the kernel or userspace using a
+method known as callback requests.
+
+The SCM provides two functions for object invocation and callback request:
+
+- QCOM_SCM_SMCINVOKE_INVOKE for direct invocation. It can return either a re=
sult or a callback request.
+- QCOM_SCM_SMCINVOKE_CB_RSP submits a response for a previous callback reque=
st.
+
+The QTEE Transport Message [5] is stacked on top of SCM driver functions.
+
+A message consists of two buffers shared with QTEE, inbound and outbound buf=
fers.
+The inbound buffer is used for direct invocation and the outbound buffer is =
used
+to make callback request. This picture shows the contents of a QTEE transpor=
t message::
+
+                                      +---------------------+
+                                      |                     v
+    +-----------------+-------+-------+------+--------------------------+
+    | qcom_tee_msg_   |object | buffer       |                          |
+    |  object_invoke  |  id   | offset, size |                          | (i=
nbound buffer)
+    +-----------------+-------+--------------+--------------------------+
+    <---- header -----><---- arguments ------><- in/out buffer payload ->
+
+                                      +-----------+
+                                      |           v
+    +-----------------+-------+-------+------+----------------------+
+    | qcom_tee_msg_   |object | buffer       |                      |
+    |  callback       |  id   | offset, size |                      | (outbo=
und buffer)
+    +-----------------+-------+--------------+----------------------+
+
+Each buffer is started with a header and array of arguments.
+
+QTEE Transport Message supports four types of arguments:
+
+- Input object is an object parameter to the current invocation or callback =
request
+- Output object is an object parameter from the current invocation or callba=
ck request
+- Input buffer is (offset, size) pair to the inbound or outbound region to s=
tore parameter to the current invocation or callback request
+- Output buffer is (offset, size) pair to the inbound or outbound region to =
store parameter from the current invocation or callback request
+
+The QTEE driver offers the qcom_tee_object, which represents an object withi=
n both
+QTEE and the kernel. To access any service in QTEE, client needs to invoke an
+instance of this object. Any structure intended to represent a service for e=
xport
+to QTEE should include an instance of qcom_tee_object::
+
+	struct driver_service {
+		struct qcom_tee_object object;
+		...
+	};
+
+	#define to_driver_service_object(o) container_of((o), struct driver_service=
, object)
+
+	static int driver_service_dispatch(struct qcom_tee_object *object, u32 op,
+					   struct qcom_tee_arg *args)
+	{
+		struct driver_service *so =3D to_driver_service_object(object);
+
+		switch(op) {
+		case OBJECT_OP1:
+			...
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	static void driver_service_object_release(struct si_object *object)
+	{
+		struct driver_service *so =3D to_driver_service_object(object);
+		kfree(so);
+	}
+
+	struct si_object_operations driver_service_ops =3D {
+		.release =3D driver_service_object_release;
+		.dispatch =3D driver_service_dispatch;
+	};
+
+	void service_init(void)
+	{
+		struct driver_service *so =3D kzalloc(sizeof(*so), GFP_KERNEL);
+
+		/* Initialize so->object as a callback object. */
+		qcom_tee_object_user_init(&so->object, QCOM_TEE_OBJECT_TYPE_CB_OBJECT,
+					  &driver_service_ops, "driver_service_object");
+
+		/* Invoke a QTEE object and pass/register 'so->object' with QTEE. */
+		...
+	}
+	module_init(service_init);
+
+The QTEE driver utilizes qcom_tee_object to encapsulate userspace objects. W=
hen a
+callback request is made, it translates into calling the dispatch callback. =
For
+userspace objects, this is converted into requests accessible to callback se=
rvers
+and available through generic TEE API IOCTLs.
+
+Picture of the relationship between the different components in the QTEE
+architecture::
+
+         User space               Kernel                     Secure world
+         ~~~~~~~~~~               ~~~~~~                     ~~~~~~~~~~~~
+   +--------+   +----------+                                +--------------+
+   | Client |   |callback  |                                | Trusted      |
+   +--------+   |server    |                                | Application  |
+      /\        +----------+                                +--------------+
+      ||  +----------+ /\                                          /\
+      ||  |callback  | ||                                          ||
+      ||  |server    | ||                                          \/
+      ||  +----------+ ||                                   +--------------+
+      \/       /\      ||                                   | TEE Internal |
+   +-------+   ||      ||                                   | API          |
+   | TEE   |   ||      ||   +--------+--------+             +--------------+
+   | Client|   ||      ||   | TEE    | QTEE   |             | QTEE         |
+   | API   |   \/      \/   | subsys | driver |             | Trusted OS   |
+   +-------+----------------+----+-------+----+-------------+--------------+
+   |      Generic TEE API        |       |   QTEE MSG                      |
+   |      IOCTL (TEE_IOC_*)      |       |   SMCCC (QCOM_SCM_SMCINVOKE_*)  |
+   +-----------------------------+       +---------------------------------+
+
+References
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+[1] https://docs.qualcomm.com/bundle/publicresource/topics/80-70015-11/qualc=
omm-trusted-execution-environment.html
+
+[2] http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
+
+[3] drivers/firmware/qcom/qcom_scm.c
+
+[4] /local/mnt/workspace/Linux/drivers/tee/qcomtee/qcom_scm.c
+
+[5] drivers/tee/qcomtee/qcomtee_msg.h
\ No newline at end of file

--=20
2.34.1


--===============4017629352251074074==--

