From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 01/10] firmware: arm_ffa: Add pointer to the ffa_dev_ops in
 struct ffa_dev
Date: Wed, 07 Sep 2022 15:52:31 +0100
Message-ID: <20220907145240.1683088-2-sudeep.holla@arm.com>
In-Reply-To: <20220907145240.1683088-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0539002318609760877=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0539002318609760877==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Currently ffa_dev_ops_get() is the way to fetch the ffa_dev_ops pointer.
It checks if the ffa_dev structure pointer is valid before returning the
ffa_dev_ops pointer.

Instead, the pointer can be made part of the ffa_dev structure and since
the core driver is incharge of creating ffa_device for each identified
partition, there is no need to check for the validity explicitly if the
pointer is embedded in the structure.

Add the pointer to the ffa_dev_ops in the ffa_dev structure itself and
initialise the same as part of creation of the device.

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/bus.c    | 4 +++-
 drivers/firmware/arm_ffa/driver.c | 2 +-
 include/linux/arm_ffa.h           | 7 +++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index 641a91819088..69328041fbc3 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -167,7 +167,8 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev)
 	return valid;
 }
=20
-struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id)
+struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
+				       const struct ffa_dev_ops *ops)
 {
 	int ret;
 	struct device *dev;
@@ -183,6 +184,7 @@ struct ffa_device *ffa_device_register(const uuid_t *uuid=
, int vm_id)
 	dev_set_name(&ffa_dev->dev, "arm-ffa-%04x", vm_id);
=20
 	ffa_dev->vm_id =3D vm_id;
+	ffa_dev->ops =3D ops;
 	uuid_copy(&ffa_dev->uuid, uuid);
=20
 	ret =3D device_register(&ffa_dev->dev);
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/dri=
ver.c
index ec731e9e942b..213665e5ad0e 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -688,7 +688,7 @@ static void ffa_setup_partitions(void)
 		 * as part of the discovery API, we need to pass the
 		 * discovered UUID here instead.
 		 */
-		ffa_dev =3D ffa_device_register(&uuid_null, tpbuf->id);
+		ffa_dev =3D ffa_device_register(&uuid_null, tpbuf->id, &ffa_ops);
 		if (!ffa_dev) {
 			pr_err("%s: failed to register partition ID 0x%x\n",
 			       __func__, tpbuf->id);
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index e5c76c1ef9ed..91b47e42b73d 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -17,6 +17,7 @@ struct ffa_device {
 	bool mode_32bit;
 	uuid_t uuid;
 	struct device dev;
+	const struct ffa_dev_ops *ops;
 };
=20
 #define to_ffa_dev(d) container_of(d, struct ffa_device, dev)
@@ -47,7 +48,8 @@ static inline void *ffa_dev_get_drvdata(struct ffa_device *=
fdev)
 }
=20
 #if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
-struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id);
+struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
+				       const struct ffa_dev_ops *ops);
 void ffa_device_unregister(struct ffa_device *ffa_dev);
 int ffa_driver_register(struct ffa_driver *driver, struct module *owner,
 			const char *mod_name);
@@ -57,7 +59,8 @@ const struct ffa_dev_ops *ffa_dev_ops_get(struct ffa_device=
 *dev);
=20
 #else
 static inline
-struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id)
+struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
+				       const struct ffa_dev_ops *ops)
 {
 	return NULL;
 }
--=20
2.37.3


--===============0539002318609760877==--

