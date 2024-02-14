From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 2/7] remoteproc: Extract the firmware load from the start
Date: Wed, 14 Feb 2024 17:22:38 +0000
Message-ID: <20240214172127.1022199-3-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2168632640293875179=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2168632640293875179==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

With the introduction of tee_remoteproc, the firmware has to be loaded
first before parsing the resource table. This constraint is linked to
the firmware authentication, that contains the resource table.
In OP-TEE, this authentication is correlated with the load of the
firmware (the loaded segments authenticated after being copied
to the destination memory). Removing rproc_load_segments will allow
it to be called earlier in the boot sequence.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/remoteproc_core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remote=
proc_core.c
index 695cce218e8c..283ca071e35c 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1269,13 +1269,6 @@ static int rproc_start(struct rproc *rproc, const stru=
ct firmware *fw)
 	struct device *dev =3D &rproc->dev;
 	int ret;
=20
-	/* load the ELF segments to memory */
-	ret =3D rproc_load_segments(rproc, fw);
-	if (ret) {
-		dev_err(dev, "Failed to load program segments: %d\n", ret);
-		return ret;
-	}
-
 	/*
 	 * The starting device has been given the rproc->cached_table as the
 	 * resource table. The address of the vring along with the other
@@ -1430,6 +1423,13 @@ static int rproc_fw_boot(struct rproc *rproc, const st=
ruct firmware *fw)
 		goto clean_up_resources;
 	}
=20
+	/* load the ELF segments to memory */
+	ret =3D rproc_load_segments(rproc, fw);
+	if (ret) {
+		dev_err(dev, "Failed to load program segments: %d\n", ret);
+		return ret;
+	}
+
 	ret =3D rproc_start(rproc, fw);
 	if (ret)
 		goto clean_up_resources;
@@ -1808,6 +1808,13 @@ static int rproc_boot_recovery(struct rproc *rproc)
 		return ret;
 	}
=20
+	/* load the ELF segments to memory */
+	ret =3D rproc_load_segments(rproc, firmware_p);
+	if (ret) {
+		dev_err(dev, "Failed to load program segments: %d\n", ret);
+		return ret;
+	}
+
 	/* boot the remote processor up again */
 	ret =3D rproc_start(rproc, firmware_p);
=20
--=20
2.25.1


--===============2168632640293875179==--

