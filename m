From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 2/2] tee: avoid explicit sysfs_create/delete_group by
 initialising dev->groups
Date: Tue, 01 Sep 2020 11:33:35 +0100
Message-ID: <20200901103335.685-2-sudeep.holla@arm.com>
In-Reply-To: <20200901103335.685-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7046039331303737884=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7046039331303737884==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

If the dev->groups is initialised, the sysfs group is created as part
of device_add call. There is no need to call sysfs_create/delete_group
explicitly.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/tee/tee_core.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index b4a8b362d78f..f77d64fafead 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -962,9 +962,7 @@ static struct attribute *tee_dev_attrs[] = {
 	NULL
 };
 
-static const struct attribute_group tee_dev_group = {
-	.attrs = tee_dev_attrs,
-};
+ATTRIBUTE_GROUPS(tee_dev);
 
 /**
  * tee_device_register() - Registers a TEE device
@@ -984,6 +982,8 @@ int tee_device_register(struct tee_device *teedev)
 		return -EINVAL;
 	}
 
+	teedev->dev.groups = tee_dev_groups;
+
 	rc = cdev_device_add(&teedev->cdev, &teedev->dev);
 	if (rc) {
 		dev_err(&teedev->dev,
@@ -993,19 +993,8 @@ int tee_device_register(struct tee_device *teedev)
 		return rc;
 	}
 
-	rc = sysfs_create_group(&teedev->dev.kobj, &tee_dev_group);
-	if (rc) {
-		dev_err(&teedev->dev,
-			"failed to create sysfs attributes, err=%d\n", rc);
-		goto err_sysfs_create_group;
-	}
-
 	teedev->flags |= TEE_DEVICE_FLAG_REGISTERED;
 	return 0;
-
-err_sysfs_create_group:
-	cdev_device_del(&teedev->cdev, &teedev->dev);
-	return rc;
 }
 EXPORT_SYMBOL_GPL(tee_device_register);
 
@@ -1048,10 +1037,8 @@ void tee_device_unregister(struct tee_device *teedev)
 	if (!teedev)
 		return;
 
-	if (teedev->flags & TEE_DEVICE_FLAG_REGISTERED) {
-		sysfs_remove_group(&teedev->dev.kobj, &tee_dev_group);
+	if (teedev->flags & TEE_DEVICE_FLAG_REGISTERED)
 		cdev_device_del(&teedev->cdev, &teedev->dev);
-	}
 
 	tee_device_put(teedev);
 	wait_for_completion(&teedev->c_no_users);
-- 
2.17.1


--===============7046039331303737884==--

