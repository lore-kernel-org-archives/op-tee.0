From: Etienne Carriere <etienne.carriere@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v11 4/4] firmware: arm_scmi: optee: use optee system invocation
Date: Mon, 16 Oct 2023 11:04:28 +0200
Message-ID: <20231016090428.1369071-5-etienne.carriere@foss.st.com>
In-Reply-To: <20231016090428.1369071-1-etienne.carriere@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8341458373225058132=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8341458373225058132==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Changes SCMI optee transport to call tee_client_system_session()
to request optee driver to provision an entry context in OP-TEE
for processing OP-TEE messages. This prevents possible deadlock
in case OP-TEE threads are all consumed while these may be waiting
for a clock or regulator to be enable which SCMI OP-TEE service which
requires a free thread context to execute.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
No change since v10

Changes since v9:
- Applied Sumit R-b tag:
  https://lore.kernel.org/lkml/CAFA6WYMyJrW25sdZRkQHDje72+tLDw4T+bjB6tmVf8XH0=
De1RQ(a)mail.gmail.com/
- Added Cc: tags and updated my e-mail address.

No change since v8
No change since v7
No change since v6

Changes since v5:
- Applied Sudeep's review tag

Changes since v4:
- Updated to new API function tee_client_system_session() introduced
  in patch v5 2/3.

No change since v3

Changes since v2:
- Fixed syntax issues (missing ';' chars), reported by kernel test robot.

Changes since v1:
- Updated to use new tee API functions tee_client_request_system_context()
  and tee_client_release_system_context().
---
 drivers/firmware/arm_scmi/optee.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/op=
tee.c
index e123de6e8c67..25bfb465484d 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -440,6 +440,10 @@ static int scmi_optee_chan_setup(struct scmi_chan_info *=
cinfo, struct device *de
 	if (ret)
 		goto err_free_shm;
=20
+	ret =3D tee_client_system_session(scmi_optee_private->tee_ctx, channel->tee=
_session);
+	if (ret)
+		dev_warn(dev, "Could not switch to system session, do best effort\n");
+
 	ret =3D get_channel(channel);
 	if (ret)
 		goto err_close_sess;
--=20
2.25.1


--===============8341458373225058132==--

