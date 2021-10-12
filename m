From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH] tee: optee: Fix missing devices unregister during optee_remove
Date: Tue, 12 Oct 2021 13:01:16 +0530
Message-ID: <20211012073116.4156054-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7298312055496925988=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7298312055496925988==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

When OP-TEE driver is built as a module, OP-TEE client devices
registered on TEE bus during probe should be unregistered during
optee_remove. So implement optee_unregister_devices() accordingly.

Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
Reported-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/optee/core.c          |  3 +++
 drivers/tee/optee/device.c        | 22 ++++++++++++++++++++++
 drivers/tee/optee/optee_private.h |  1 +
 3 files changed, 26 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index ccad3c7c8f6d..3915dc574503 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -586,6 +586,9 @@ static int optee_remove(struct platform_device *pdev)
 {
 	struct optee *optee =3D platform_get_drvdata(pdev);
=20
+	/* Unregister OP-TEE specific client devices on TEE bus */
+	optee_unregister_devices();
+
 	/*
 	 * Ask OP-TEE to free all cached shared memory objects to decrease
 	 * reference counters and also avoid wild pointers in secure world
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index ec1d24693eba..128a2d2a50a1 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -53,6 +53,13 @@ static int get_devices(struct tee_context *ctx, u32 sessio=
n,
 	return 0;
 }
=20
+static void optee_release_device(struct device *dev)
+{
+	struct tee_client_device *optee_device =3D to_tee_client_device(dev);
+
+	kfree(optee_device);
+}
+
 static int optee_register_device(const uuid_t *device_uuid)
 {
 	struct tee_client_device *optee_device =3D NULL;
@@ -63,6 +70,7 @@ static int optee_register_device(const uuid_t *device_uuid)
 		return -ENOMEM;
=20
 	optee_device->dev.bus =3D &tee_bus_type;
+	optee_device->dev.release =3D optee_release_device;
 	if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid)) {
 		kfree(optee_device);
 		return -ENOMEM;
@@ -154,3 +162,17 @@ int optee_enumerate_devices(u32 func)
 {
 	return  __optee_enumerate_devices(func);
 }
+
+static int __optee_unregister_device(struct device *dev, void *data)
+{
+	if (!strncmp(dev_name(dev), "optee-ta", strlen("optee-ta")))
+		device_unregister(dev);
+
+	return 0;
+}
+
+void optee_unregister_devices(void)
+{
+	bus_for_each_dev(&tee_bus_type, NULL, NULL,
+			 __optee_unregister_device);
+}
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index e25b216a14ef..39be9aa7bd22 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -183,6 +183,7 @@ void optee_fill_pages_list(u64 *dst, struct page **pages,=
 int num_pages,
 #define PTA_CMD_GET_DEVICES		0x0
 #define PTA_CMD_GET_DEVICES_SUPP	0x1
 int optee_enumerate_devices(u32 func);
+void optee_unregister_devices(void);
=20
 /*
  * Small helpers
--=20
2.25.1


--===============7298312055496925988==--

