From: Etienne Carriere <etienne.carriere@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 2/2] firmware: arm_scmi: optee: use optee system invocation
Date: Tue, 14 Feb 2023 16:20:47 +0100
Message-ID: <20230214152047.1143106-2-etienne.carriere@linaro.org>
In-Reply-To: <20230214152047.1143106-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9216149630330850028=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9216149630330850028==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Changes SCMI optee transport to request an OP-TEE system invocation
context per SCMI channel. This prevents possible deadlock when many
Linux clients invoke OP-TEE are all suspended waiting for an OP-TEE
RPC request access an SCMI resource through the SCMI OP-TEE PTA service.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
--
Changes since v1:
- Updated to use new tee API functions tee_client_request_system_context()
  and tee_client_release_system_context().
---
 drivers/firmware/arm_scmi/optee.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/op=
tee.c
index 2a7aeab40e54..fe91e2de3f9c 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -119,6 +119,7 @@ struct scmi_optee_channel {
 	u32 tee_session;
 	u32 caps;
 	u32 rx_len;
+	bool sys_thread;
 	struct mutex mu;
 	struct scmi_chan_info *cinfo;
 	union {
@@ -432,9 +433,15 @@ static int scmi_optee_chan_setup(struct scmi_chan_info *=
cinfo, struct device *de
 	channel->channel_id =3D channel_id;
 	mutex_init(&channel->mu);
=20
+	ret =3D tee_client_request_system_context(scmi_optee_private->tee_ctx)
+	if (ret)
+		dev_warn(dev, "Couldn't provision an OP-TEE system context\n");
+	else
+		channel->sys_thread =3D true;
+
 	ret =3D setup_shmem(dev, cinfo, channel);
 	if (ret)
-		return ret;
+		goto err_release_sysctx;
=20
 	ret =3D open_session(scmi_optee_private, &channel->tee_session);
 	if (ret)
@@ -458,6 +465,9 @@ static int scmi_optee_chan_setup(struct scmi_chan_info *c=
info, struct device *de
 err_free_shm:
 	if (channel->tee_shm)
 		tee_shm_free(channel->tee_shm);
+err_release_sysctx:
+	if (channel->sys_thread)
+		tee_client_release_system_context(scmi_optee_private->tee_ctx)
=20
 	return ret;
 }
@@ -483,6 +493,9 @@ static int scmi_optee_chan_free(int id, void *p, void *da=
ta)
=20
 	scmi_free_channel(cinfo, data, id);
=20
+	if (channel->sys_thread)
+		tee_client_release_system_context(scmi_optee_private->tee_ctx)
+
 	return 0;
 }
=20
--=20
2.25.1


--===============9216149630330850028==--

