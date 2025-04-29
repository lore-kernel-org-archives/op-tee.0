From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v4 07/11] firmware: qcom: tzmem: export shm_bridge create/delete
Date: Mon, 28 Apr 2025 23:06:28 -0700
Message-ID: <20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-7-6a143640a6cb@oss.qualcomm.com>
In-Reply-To: <=?utf-8?q?=3C20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-?=
 =?utf-8?q?0-6a143640a6cb=40oss=2Equalcomm=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4948379687242027257=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4948379687242027257==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Anyone with access to contiguous physical memory should be able to
share memory with QTEE using shm_bridge.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_tzmem.c       | 57 +++++++++++++++++++++++++-----=
--
 include/linux/firmware/qcom/qcom_tzmem.h | 15 +++++++++
 2 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_=
tzmem.c
index 548dbd346b1b..a02913665801 100644
--- a/drivers/firmware/qcom/qcom_tzmem.c
+++ b/drivers/firmware/qcom/qcom_tzmem.c
@@ -107,25 +107,61 @@ static int qcom_tzmem_init(void)
 	return 0;
 }
=20
-static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
+/**
+ * qcom_tzmem_shm_bridge_create() - Create a SHM bridge.
+ * @paddr: Physical address of the memory to share.
+ * @size: Size of the memory to share.
+ * @handle: Handle to the SHM bridge.
+ *
+ * On platforms that support SHM bridge, this function creates a SHM bridge
+ * for the given memory region with QTEE. The handle returned by this functi=
on
+ * must be passed to qcom_tzmem_shm_bridge_delete() to free the SHM bridge.
+ *
+ * Return: On success, returns 0; on failure, returns < 0.
+ */
+int qcom_tzmem_shm_bridge_create(phys_addr_t paddr, size_t size, u64 *handle)
 {
 	u64 pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags;
-	int ret;
=20
 	if (!qcom_tzmem_using_shm_bridge)
 		return 0;
=20
-	pfn_and_ns_perm =3D (u64)area->paddr | QCOM_SCM_PERM_RW;
-	ipfn_and_s_perm =3D (u64)area->paddr | QCOM_SCM_PERM_RW;
-	size_and_flags =3D area->size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
+	pfn_and_ns_perm =3D paddr | QCOM_SCM_PERM_RW;
+	ipfn_and_s_perm =3D paddr | QCOM_SCM_PERM_RW;
+	size_and_flags =3D size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
+	if (qcom_scm_shm_bridge_create(pfn_and_ns_perm, ipfn_and_s_perm,
+				       size_and_flags, QCOM_SCM_VMID_HLOS,
+				       handle))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_tzmem_shm_bridge_create);
+
+/**
+ * qcom_tzmem_shm_bridge_delete() - Delete a SHM bridge.
+ * @handle: Handle to the SHM bridge.
+ *
+ * On platforms that support SHM bridge, this function deletes the SHM bridge
+ * for the given memory region. The handle must be the same as the one
+ * returned by qcom_tzmem_shm_bridge_create().
+ */
+void qcom_tzmem_shm_bridge_delete(u64 handle)
+{
+	if (qcom_tzmem_using_shm_bridge)
+		qcom_scm_shm_bridge_delete(handle);
+}
+EXPORT_SYMBOL_GPL(qcom_tzmem_shm_bridge_delete);
+
+static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
+{
+	int ret;
=20
 	u64 *handle __free(kfree) =3D kzalloc(sizeof(*handle), GFP_KERNEL);
 	if (!handle)
 		return -ENOMEM;
=20
-	ret =3D qcom_scm_shm_bridge_create(pfn_and_ns_perm, ipfn_and_s_perm,
-					 size_and_flags, QCOM_SCM_VMID_HLOS,
-					 handle);
+	ret =3D qcom_tzmem_shm_bridge_create(area->paddr, area->size, handle);
 	if (ret)
 		return ret;
=20
@@ -138,10 +174,7 @@ static void qcom_tzmem_cleanup_area(struct qcom_tzmem_ar=
ea *area)
 {
 	u64 *handle =3D area->priv;
=20
-	if (!qcom_tzmem_using_shm_bridge)
-		return;
-
-	qcom_scm_shm_bridge_delete(*handle);
+	qcom_tzmem_shm_bridge_delete(*handle);
 	kfree(handle);
 }
=20
diff --git a/include/linux/firmware/qcom/qcom_tzmem.h b/include/linux/firmwar=
e/qcom/qcom_tzmem.h
index b83b63a0c049..48ac0e5454c7 100644
--- a/include/linux/firmware/qcom/qcom_tzmem.h
+++ b/include/linux/firmware/qcom/qcom_tzmem.h
@@ -53,4 +53,19 @@ DEFINE_FREE(qcom_tzmem, void *, if (_T) qcom_tzmem_free(_T=
))
=20
 phys_addr_t qcom_tzmem_to_phys(void *ptr);
=20
+#if IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE)
+int qcom_tzmem_shm_bridge_create(phys_addr_t paddr, size_t size, u64 *handle=
);
+void qcom_tzmem_shm_bridge_delete(u64 handle);
+#else
+static inline int qcom_tzmem_shm_bridge_create(phys_addr_t paddr,
+					       size_t size, u64 *handle)
+{
+	return 0;
+}
+
+static inline void qcom_tzmem_shm_bridge_delete(u64 handle)
+{
+}
+#endif
+
 #endif /* __QCOM_TZMEM */

--=20
2.34.1


--===============4948379687242027257==--

