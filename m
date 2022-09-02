From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 03/10] firmware: arm_ffa: Remove ffa_dev_ops_get()
Date: Fri, 02 Sep 2022 13:40:25 +0100
Message-ID: <20220902124032.788488-4-sudeep.holla@arm.com>
In-Reply-To: <20220902124032.788488-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7446170269529748616=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7446170269529748616==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The only user of this exported ffa_dev_ops_get() was OPTEE driver which
now uses ffa_dev->ops directly, there are no other users for this.

Also, since any ffa driver can use ffa_dev->ops directly, there will be
no need for ffa_dev_ops_get(), so just remove ffa_dev_ops_get().

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 9 ---------
 include/linux/arm_ffa.h           | 6 ------
 2 files changed, 15 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/dri=
ver.c
index 213665e5ad0e..04e7cbb1b9aa 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -644,15 +644,6 @@ static const struct ffa_dev_ops ffa_ops =3D {
 	.memory_lend =3D ffa_memory_lend,
 };
=20
-const struct ffa_dev_ops *ffa_dev_ops_get(struct ffa_device *dev)
-{
-	if (ffa_device_is_valid(dev))
-		return &ffa_ops;
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(ffa_dev_ops_get);
-
 void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid)
 {
 	int count, idx;
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 91b47e42b73d..556f50f27fb1 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -55,7 +55,6 @@ int ffa_driver_register(struct ffa_driver *driver, struct m=
odule *owner,
 			const char *mod_name);
 void ffa_driver_unregister(struct ffa_driver *driver);
 bool ffa_device_is_valid(struct ffa_device *ffa_dev);
-const struct ffa_dev_ops *ffa_dev_ops_get(struct ffa_device *dev);
=20
 #else
 static inline
@@ -79,11 +78,6 @@ static inline void ffa_driver_unregister(struct ffa_driver=
 *driver) {}
 static inline
 bool ffa_device_is_valid(struct ffa_device *ffa_dev) { return false; }
=20
-static inline
-const struct ffa_dev_ops *ffa_dev_ops_get(struct ffa_device *dev)
-{
-	return NULL;
-}
 #endif /* CONFIG_ARM_FFA_TRANSPORT */
=20
 #define ffa_register(driver) \
--=20
2.37.3


--===============7446170269529748616==--

