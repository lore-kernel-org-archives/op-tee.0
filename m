From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v7 3/4] tee: add tee_device_set_dev_groups()
Date: Mon, 27 May 2024 14:13:39 +0200
Message-ID: <20240527121340.3931987-4-jens.wiklander@linaro.org>
In-Reply-To: <20240527121340.3931987-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8735472274131711028=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8735472274131711028==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Add tee_device_set_dev_groups() to TEE drivers to supply driver specific
attribute groups. The class specific attributes are from now on added
via the tee_class, which currently only consist of implementation_id.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/misc/rpmb-core.c | 155 +++++++++++++++++++--------------------
 drivers/tee/tee_core.c   |  19 +++--
 include/linux/rpmb.h     |  53 +++++--------
 include/linux/tee_drv.h  |  12 +++
 4 files changed, 122 insertions(+), 117 deletions(-)

diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
index e42a45debc76..691d7de247f6 100644
--- a/drivers/misc/rpmb-core.c
+++ b/drivers/misc/rpmb-core.c
@@ -12,10 +12,8 @@
 #include <linux/rpmb.h>
 #include <linux/slab.h>
=20
-static struct list_head rpmb_dev_list;
+static DEFINE_IDA(rpmb_ida);
 static DEFINE_MUTEX(rpmb_mutex);
-static struct blocking_notifier_head rpmb_interface =3D
-	BLOCKING_NOTIFIER_INIT(rpmb_interface);
=20
 /**
  * rpmb_dev_get() - increase rpmb device ref counter
@@ -24,7 +22,7 @@ static struct blocking_notifier_head rpmb_interface =3D
 struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
 {
 	if (rdev)
-		get_device(rdev->parent_dev);
+		get_device(&rdev->dev);
 	return rdev;
 }
 EXPORT_SYMBOL_GPL(rpmb_dev_get);
@@ -36,7 +34,7 @@ EXPORT_SYMBOL_GPL(rpmb_dev_get);
 void rpmb_dev_put(struct rpmb_dev *rdev)
 {
 	if (rdev)
-		put_device(rdev->parent_dev);
+		put_device(&rdev->dev);
 }
 EXPORT_SYMBOL_GPL(rpmb_dev_put);
=20
@@ -56,11 +54,27 @@ int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
 	if (!req || !req_len || !rsp || !rsp_len)
 		return -EINVAL;
=20
-	return rdev->descr.route_frames(rdev->parent_dev, req, req_len,
+	return rdev->descr.route_frames(rdev->dev.parent, req, req_len,
 					rsp, rsp_len);
 }
 EXPORT_SYMBOL_GPL(rpmb_route_frames);
=20
+static void rpmb_dev_release(struct device *dev)
+{
+	struct rpmb_dev *rdev =3D to_rpmb_dev(dev);
+
+	mutex_lock(&rpmb_mutex);
+	ida_simple_remove(&rpmb_ida, rdev->id);
+	mutex_unlock(&rpmb_mutex);
+	kfree(rdev->descr.dev_id);
+	kfree(rdev);
+}
+
+static struct class rpmb_class =3D {
+	.name =3D "rpmb",
+	.dev_release =3D rpmb_dev_release,
+};
+
 /**
  * rpmb_dev_find_device() - return first matching rpmb device
  * @data: data for the match function
@@ -79,35 +93,34 @@ EXPORT_SYMBOL_GPL(rpmb_route_frames);
  */
 struct rpmb_dev *rpmb_dev_find_device(const void *data,
 				      const struct rpmb_dev *start,
-				      int (*match)(struct rpmb_dev *rdev,
+				      int (*match)(struct device *dev,
 						   const void *data))
 {
-	struct rpmb_dev *rdev;
-	struct list_head *pos;
+	struct device *dev;
+	const struct device *start_dev =3D NULL;
=20
-	mutex_lock(&rpmb_mutex);
 	if (start)
-		pos =3D start->list_node.next;
-	else
-		pos =3D rpmb_dev_list.next;
-
-	while (pos !=3D &rpmb_dev_list) {
-		rdev =3D container_of(pos, struct rpmb_dev, list_node);
-		if (match(rdev, data)) {
-			rpmb_dev_get(rdev);
-			goto out;
-		}
-		pos =3D pos->next;
-	}
-	rdev =3D NULL;
-
-out:
-	mutex_unlock(&rpmb_mutex);
+		start_dev =3D &start->dev;
+	dev =3D class_find_device(&rpmb_class, start_dev, data, match);
=20
-	return rdev;
+	return dev ? to_rpmb_dev(dev) : NULL;
 }
 EXPORT_SYMBOL_GPL(rpmb_dev_find_device);
=20
+int rpmb_interface_register(struct class_interface *intf)
+{
+	intf->class =3D &rpmb_class;
+
+	return class_interface_register(intf);
+}
+EXPORT_SYMBOL_GPL(rpmb_interface_register);
+
+void rpmb_interface_unregister(struct class_interface *intf)
+{
+	class_interface_unregister(intf);
+}
+EXPORT_SYMBOL_GPL(rpmb_interface_unregister);
+
 /**
  * rpmb_dev_unregister() - unregister RPMB partition from the RPMB subsystem
  * @rdev: the rpmb device to unregister
@@ -122,11 +135,9 @@ int rpmb_dev_unregister(struct rpmb_dev *rdev)
 	if (!rdev)
 		return -EINVAL;
=20
-	mutex_lock(&rpmb_mutex);
-	list_del(&rdev->list_node);
-	mutex_unlock(&rpmb_mutex);
-	kfree(rdev->descr.dev_id);
-	kfree(rdev);
+	device_del(&rdev->dev);
+
+	rpmb_dev_put(rdev);
=20
 	return 0;
 }
@@ -146,6 +157,7 @@ struct rpmb_dev *rpmb_dev_register(struct device *dev,
 				   struct rpmb_descr *descr)
 {
 	struct rpmb_dev *rdev;
+	int ret;
=20
 	if (!dev || !descr || !descr->route_frames || !descr->dev_id ||
 	    !descr->dev_id_len)
@@ -158,71 +170,58 @@ struct rpmb_dev *rpmb_dev_register(struct device *dev,
 	rdev->descr.dev_id =3D kmemdup(descr->dev_id, descr->dev_id_len,
 				     GFP_KERNEL);
 	if (!rdev->descr.dev_id) {
-		kfree(rdev);
-		return ERR_PTR(-ENOMEM);
+		ret =3D -ENOMEM;
+		goto err_free_rdev;
 	}
=20
-	rdev->parent_dev =3D dev;
-
-	dev_dbg(rdev->parent_dev, "registered device\n");
-
 	mutex_lock(&rpmb_mutex);
-	list_add_tail(&rdev->list_node, &rpmb_dev_list);
-	blocking_notifier_call_chain(&rpmb_interface, RPMB_NOTIFY_ADD_DEVICE,
-				     rdev);
+	ret =3D ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
 	mutex_unlock(&rpmb_mutex);
+	if (ret < 0)
+		goto err_free_dev_id;
+	rdev->id =3D ret;
=20
-	return rdev;
-}
-EXPORT_SYMBOL_GPL(rpmb_dev_register);
+	dev_set_name(&rdev->dev, "rpmb%d", rdev->id);
+	rdev->dev.class =3D &rpmb_class;
+	rdev->dev.parent =3D dev;
=20
-/**
- * rpmb_interface_register() - register for new device notifications
- *
- * @nb : New entry in notifier chain
- *
- * Returns: 0 on success  -EEXIST on error.
- */
-int rpmb_interface_register(struct notifier_block *nb)
-{
-	struct rpmb_dev *rdev;
-	int ret;
-
-	ret =3D blocking_notifier_chain_register(&rpmb_interface, nb);
+	ret =3D device_register(&rdev->dev);
 	if (ret)
-		return ret;
+		goto err_id_remove;
=20
-	mutex_lock(&rpmb_mutex);
-	list_for_each_entry(rdev, &rpmb_dev_list, list_node)
-		nb->notifier_call(nb, RPMB_NOTIFY_ADD_DEVICE, rdev);
-	mutex_unlock(&rpmb_mutex);
+	dev_dbg(&rdev->dev, "registered device\n");
=20
-	return 0;
-}
-EXPORT_SYMBOL_GPL(rpmb_interface_register);
+	return rdev;
=20
-/**
- * rpmb_interface_unregister() - unregister from new device notifications
- *
- * @nb : Entry to remove from notifier chain
- *
- * Returns: 0 on success or -ENOENT on failure.
- */
-int rpmb_interface_unregister(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_unregister(&rpmb_interface, nb);
+err_id_remove:
+	mutex_lock(&rpmb_mutex);
+	ida_simple_remove(&rpmb_ida, rdev->id);
+	mutex_unlock(&rpmb_mutex);
+err_free_dev_id:
+	kfree(rdev->descr.dev_id);
+err_free_rdev:
+	kfree(rdev);
+	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(rpmb_interface_unregister);
+EXPORT_SYMBOL_GPL(rpmb_dev_register);
=20
 static int __init rpmb_init(void)
 {
-	INIT_LIST_HEAD(&rpmb_dev_list);
+	int ret;
+
+	ret =3D class_register(&rpmb_class);
+	if (ret) {
+		pr_err("couldn't create class\n");
+		return ret;
+	}
+	ida_init(&rpmb_ida);
 	return 0;
 }
=20
 static void __exit rpmb_exit(void)
 {
-	mutex_destroy(&rpmb_mutex);
+	ida_destroy(&rpmb_ida);
+	class_unregister(&rpmb_class);
 }
=20
 subsys_initcall(rpmb_init);
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index e59c20d74b36..437d00fa6d4c 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -40,10 +40,7 @@ static const uuid_t tee_client_uuid_ns =3D UUID_INIT(0x58a=
c9ca0, 0x2086, 0x4683,
 static DECLARE_BITMAP(dev_mask, TEE_NUM_DEVICES);
 static DEFINE_SPINLOCK(driver_lock);
=20
-static const struct class tee_class =3D {
-	.name =3D "tee",
-};
-
+static const struct class tee_class;
 static dev_t tee_devt;
=20
 struct tee_context *teedev_open(struct tee_device *teedev)
@@ -965,6 +962,13 @@ struct tee_device *tee_device_alloc(const struct tee_des=
c *teedesc,
 }
 EXPORT_SYMBOL_GPL(tee_device_alloc);
=20
+void tee_device_set_dev_groups(struct tee_device *teedev,
+			       const struct attribute_group **dev_groups)
+{
+	teedev->dev.groups =3D dev_groups;
+}
+EXPORT_SYMBOL_GPL(tee_device_set_dev_groups);
+
 static ssize_t implementation_id_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
@@ -983,6 +987,11 @@ static struct attribute *tee_dev_attrs[] =3D {
=20
 ATTRIBUTE_GROUPS(tee_dev);
=20
+static const struct class tee_class =3D {
+	.name =3D "tee",
+	.dev_groups =3D tee_dev_groups,
+};
+
 /**
  * tee_device_register() - Registers a TEE device
  * @teedev:	Device to register
@@ -1001,8 +1010,6 @@ int tee_device_register(struct tee_device *teedev)
 		return -EINVAL;
 	}
=20
-	teedev->dev.groups =3D tee_dev_groups;
-
 	rc =3D cdev_device_add(&teedev->cdev, &teedev->dev);
 	if (rc) {
 		dev_err(&teedev->dev,
diff --git a/include/linux/rpmb.h b/include/linux/rpmb.h
index 3ced206fdc17..8fb672ab7b9f 100644
--- a/include/linux/rpmb.h
+++ b/include/linux/rpmb.h
@@ -6,9 +6,8 @@
 #ifndef __RPMB_H__
 #define __RPMB_H__
=20
-#include <linux/types.h>
 #include <linux/device.h>
-#include <linux/notifier.h>
+#include <linux/types.h>
=20
 /**
  * enum rpmb_type - type of underlying storage technology
@@ -48,38 +47,29 @@ struct rpmb_descr {
 /**
  * struct rpmb_dev - device which can support RPMB partition
  *
- * @parent_dev       : parent device
+ * @dev              : device
+ * @id               : device_id
  * @list_node        : linked list node
  * @descr            : RPMB description
  */
 struct rpmb_dev {
-	struct device *parent_dev;
+	struct device dev;
+	int id;
 	struct list_head list_node;
 	struct rpmb_descr descr;
 };
=20
-enum rpmb_interface_action {
-	RPMB_NOTIFY_ADD_DEVICE,
-};
-
-/**
- * struct rpmb_interface - subscribe to new RPMB devices
- *
- * @list_node     : linked list node
- * @add_rdev      : notifies that a new RPMB device has been found
- */
-struct rpmb_interface {
-	struct list_head list_node;
-	void (*add_rdev)(struct rpmb_interface *intf, struct rpmb_dev *rdev);
-};
+#define to_rpmb_dev(x)		container_of((x), struct rpmb_dev, dev)
=20
 #if IS_ENABLED(CONFIG_RPMB)
 struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev);
 void rpmb_dev_put(struct rpmb_dev *rdev);
 struct rpmb_dev *rpmb_dev_find_device(const void *data,
 				      const struct rpmb_dev *start,
-				      int (*match)(struct rpmb_dev *rdev,
+				      int (*match)(struct device *dev,
 						   const void *data));
+int rpmb_interface_register(struct class_interface *intf);
+void rpmb_interface_unregister(struct class_interface *intf);
 struct rpmb_dev *rpmb_dev_register(struct device *dev,
 				   struct rpmb_descr *descr);
 int rpmb_dev_unregister(struct rpmb_dev *rdev);
@@ -87,8 +77,6 @@ int rpmb_dev_unregister(struct rpmb_dev *rdev);
 int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
 		      unsigned int req_len, u8 *resp, unsigned int resp_len);
=20
-int rpmb_interface_register(struct notifier_block *nb);
-int rpmb_interface_unregister(struct notifier_block *nb);
 #else
 static inline struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
 {
@@ -99,13 +87,22 @@ static inline void rpmb_dev_put(struct rpmb_dev *rdev) { }
=20
 static inline struct rpmb_dev *
 rpmb_dev_find_device(const void *data, const struct rpmb_dev *start,
-		     int (*match)(struct rpmb_dev *rdev, const void *data))
+		     int (*match)(struct device *dev, const void *data))
 {
 	return NULL;
 }
=20
+static inline int rpmb_interface_register(struct class_interface *intf)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void rpmb_interface_unregister(struct class_interface *intf)
+{
+}
+
 static inline struct rpmb_dev *
-rpmb_dev_register(struct device *dev, const struct rpmb_ops *ops)
+rpmb_dev_register(struct device *dev, struct rpmb_descr *descr)
 {
 	return NULL;
 }
@@ -121,16 +118,6 @@ static inline int rpmb_route_frames(struct rpmb_dev *rde=
v, u8 *req,
 {
 	return -EOPNOTSUPP;
 }
-
-static inline int rpmb_interface_register(struct notifier_block *nb)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline int rpmb_interface_unregister(struct notifier_block *nb)
-{
-	return -EOPNOTSUPP;
-}
 #endif /* CONFIG_RPMB */
=20
 #endif /* __RPMB_H__ */
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 71632e3c5f18..c668e51ae939 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -169,6 +169,18 @@ int tee_device_register(struct tee_device *teedev);
  */
 void tee_device_unregister(struct tee_device *teedev);
=20
+/**
+ * tee_device_set_dev_groups() - Set device attribute groups
+ * @teedev:	Device to register
+ * @dev_groups: Attribute groups
+ *
+ * Assigns the provided @dev_groups to the @teedev to be registered later
+ * with tee_device_register(). Calling this function is optional, but if
+ * it's called it must be called before tee_device_register().
+ */
+void tee_device_set_dev_groups(struct tee_device *teedev,
+			       const struct attribute_group **dev_groups);
+
 /**
  * tee_session_calc_client_uuid() - Calculates client UUID for session
  * @uuid:		Resulting UUID
--=20
2.34.1


--===============8735472274131711028==--

