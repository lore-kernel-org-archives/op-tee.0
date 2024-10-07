From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v10 6/7] remoteproc: stm32: Create sub-functions to request
 shutdown and release
Date: Mon, 07 Oct 2024 15:16:19 +0200
Message-ID: <20241007131620.2090104-7-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20241007131620.2090104-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5690814189799531786=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5690814189799531786==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

To prepare for the support of TEE remoteproc, create sub-functions
that can be used in both cases, with and without remoteproc TEE support.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
Update vs previous version
- Fix stm32_rproc_request_shutdown code, which was not an exact move of the
  source code from stm32_rproc_stop. This issue was introduced by a
  rebase of the commit from an old version of the code.
---
 drivers/remoteproc/stm32_rproc.c | 82 +++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 33 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rpro=
c.c
index 8c7f7950b80e..288bd70c7861 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -209,6 +209,52 @@ static int stm32_rproc_mbox_idx(struct rproc *rproc, con=
st unsigned char *name)
 	return -EINVAL;
 }
=20
+static void stm32_rproc_request_shutdown(struct rproc *rproc)
+{
+	struct stm32_rproc *ddata =3D rproc->priv;
+	int err, idx;
+
+	/* Request shutdown of the remote processor */
+	if (rproc->state !=3D RPROC_OFFLINE && rproc->state !=3D RPROC_CRASHED) {
+		idx =3D stm32_rproc_mbox_idx(rproc, STM32_MBX_SHUTDOWN);
+		if (idx >=3D 0 && ddata->mb[idx].chan) {
+			err =3D mbox_send_message(ddata->mb[idx].chan, "detach");
+			if (err < 0)
+				dev_warn(&rproc->dev, "warning: remote FW shutdown without ack\n");
+		}
+	}
+}
+
+static int stm32_rproc_release(struct rproc *rproc)
+{
+	struct stm32_rproc *ddata =3D rproc->priv;
+	unsigned int err =3D 0;
+
+	/* To allow platform Standby power mode, set remote proc Deep Sleep */
+	if (ddata->pdds.map) {
+		err =3D regmap_update_bits(ddata->pdds.map, ddata->pdds.reg,
+					 ddata->pdds.mask, 1);
+		if (err) {
+			dev_err(&rproc->dev, "failed to set pdds\n");
+			return err;
+		}
+	}
+
+	/* Update coprocessor state to OFF if available */
+	if (ddata->m4_state.map) {
+		err =3D regmap_update_bits(ddata->m4_state.map,
+					 ddata->m4_state.reg,
+					 ddata->m4_state.mask,
+					 M4_STATE_OFF);
+		if (err) {
+			dev_err(&rproc->dev, "failed to set copro state\n");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 static int stm32_rproc_prepare(struct rproc *rproc)
 {
 	struct device *dev =3D rproc->dev.parent;
@@ -519,17 +565,9 @@ static int stm32_rproc_detach(struct rproc *rproc)
 static int stm32_rproc_stop(struct rproc *rproc)
 {
 	struct stm32_rproc *ddata =3D rproc->priv;
-	int err, idx;
+	int err;
=20
-	/* request shutdown of the remote processor */
-	if (rproc->state !=3D RPROC_OFFLINE && rproc->state !=3D RPROC_CRASHED) {
-		idx =3D stm32_rproc_mbox_idx(rproc, STM32_MBX_SHUTDOWN);
-		if (idx >=3D 0 && ddata->mb[idx].chan) {
-			err =3D mbox_send_message(ddata->mb[idx].chan, "detach");
-			if (err < 0)
-				dev_warn(&rproc->dev, "warning: remote FW shutdown without ack\n");
-		}
-	}
+	stm32_rproc_request_shutdown(rproc);
=20
 	err =3D stm32_rproc_set_hold_boot(rproc, true);
 	if (err)
@@ -541,29 +579,7 @@ static int stm32_rproc_stop(struct rproc *rproc)
 		return err;
 	}
=20
-	/* to allow platform Standby power mode, set remote proc Deep Sleep */
-	if (ddata->pdds.map) {
-		err =3D regmap_update_bits(ddata->pdds.map, ddata->pdds.reg,
-					 ddata->pdds.mask, 1);
-		if (err) {
-			dev_err(&rproc->dev, "failed to set pdds\n");
-			return err;
-		}
-	}
-
-	/* update coprocessor state to OFF if available */
-	if (ddata->m4_state.map) {
-		err =3D regmap_update_bits(ddata->m4_state.map,
-					 ddata->m4_state.reg,
-					 ddata->m4_state.mask,
-					 M4_STATE_OFF);
-		if (err) {
-			dev_err(&rproc->dev, "failed to set copro state\n");
-			return err;
-		}
-	}
-
-	return 0;
+	return stm32_rproc_release(rproc);
 }
=20
 static void stm32_rproc_kick(struct rproc *rproc, int vqid)
--=20
2.25.1


--===============5690814189799531786==--

