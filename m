From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 1/2] tee: optee: Fix supplicant based device enumeration
Date: Mon, 30 Oct 2023 21:29:00 +0530
Message-ID: <20231030155901.80673-2-sumit.garg@linaro.org>
In-Reply-To: <20231030155901.80673-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5728316039503680941=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5728316039503680941==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Currently supplicant dependent optee device enumeration only registers
devices whenever tee-supplicant is invoked for the first time. But it
forgets to remove devices when tee-supplicant daemon stops running and
closes its context gracefully. This leads to following error for fTPM
driver during reboot/shutdown:

[   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0=
xffff3024

Fix this by separating supplicant dependent devices so that the
user-space service can detach supplicant devices before closing the
supplicant.

Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Link: https://github.com/OP-TEE/optee_os/issues/6094
Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration")
Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
Tested-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/optee/device.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index 64f0e047c23d..78fc0a15c463 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -60,9 +60,10 @@ static void optee_release_device(struct device *dev)
 	kfree(optee_device);
 }
=20
-static int optee_register_device(const uuid_t *device_uuid)
+static int optee_register_device(const uuid_t *device_uuid, u32 func)
 {
 	struct tee_client_device *optee_device =3D NULL;
+	const char *dev_name_fmt =3D NULL;
 	int rc;
=20
 	optee_device =3D kzalloc(sizeof(*optee_device), GFP_KERNEL);
@@ -71,7 +72,13 @@ static int optee_register_device(const uuid_t *device_uuid)
=20
 	optee_device->dev.bus =3D &tee_bus_type;
 	optee_device->dev.release =3D optee_release_device;
-	if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid)) {
+
+	if (func =3D=3D PTA_CMD_GET_DEVICES_SUPP)
+		dev_name_fmt =3D "optee-ta-supp-%pUb";
+	else
+		dev_name_fmt =3D "optee-ta-%pUb";
+
+	if (dev_set_name(&optee_device->dev, dev_name_fmt, device_uuid)) {
 		kfree(optee_device);
 		return -ENOMEM;
 	}
@@ -142,7 +149,7 @@ static int __optee_enumerate_devices(u32 func)
 	num_devices =3D shm_size / sizeof(uuid_t);
=20
 	for (idx =3D 0; idx < num_devices; idx++) {
-		rc =3D optee_register_device(&device_uuid[idx]);
+		rc =3D optee_register_device(&device_uuid[idx], func);
 		if (rc)
 			goto out_shm;
 	}
--=20
2.34.1


--===============5728316039503680941==--

