From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 06/11] firmware: qcom: scm: remove unused arguments to the
 shm_brige
Date: Thu, 27 Mar 2025 19:47:28 -0700
Message-ID: <20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-6-7f457073282d@oss.qualcomm.com>
In-Reply-To: <=?utf-8?q?=3C20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-?=
 =?utf-8?q?0-7f457073282d=40oss=2Equalcomm=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3982797463713985825=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3982797463713985825==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

shm_bridge create/delete functions always use the scm device.
There is no need to pass it as an argument.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 4 ++--
 drivers/firmware/qcom/qcom_tzmem.c     | 8 ++++----
 include/linux/firmware/qcom/qcom_scm.h | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_sc=
m.c
index bff1b0d3306e..9fd5f900d327 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1631,7 +1631,7 @@ int qcom_scm_shm_bridge_enable(void)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_shm_bridge_enable);
=20
-int qcom_scm_shm_bridge_create(struct device *dev, u64 pfn_and_ns_perm_flags,
+int qcom_scm_shm_bridge_create(u64 pfn_and_ns_perm_flags,
 			       u64 ipfn_and_s_perm_flags, u64 size_and_flags,
 			       u64 ns_vmids, u64 *handle)
 {
@@ -1659,7 +1659,7 @@ int qcom_scm_shm_bridge_create(struct device *dev, u64 =
pfn_and_ns_perm_flags,
 }
 EXPORT_SYMBOL_GPL(qcom_scm_shm_bridge_create);
=20
-int qcom_scm_shm_bridge_delete(struct device *dev, u64 handle)
+int qcom_scm_shm_bridge_delete(u64 handle)
 {
 	struct qcom_scm_desc desc =3D {
 		.svc =3D QCOM_SCM_SVC_MP,
diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_=
tzmem.c
index 92b365178235..548dbd346b1b 100644
--- a/drivers/firmware/qcom/qcom_tzmem.c
+++ b/drivers/firmware/qcom/qcom_tzmem.c
@@ -123,9 +123,9 @@ static int qcom_tzmem_init_area(struct qcom_tzmem_area *a=
rea)
 	if (!handle)
 		return -ENOMEM;
=20
-	ret =3D qcom_scm_shm_bridge_create(qcom_tzmem_dev, pfn_and_ns_perm,
-					 ipfn_and_s_perm, size_and_flags,
-					 QCOM_SCM_VMID_HLOS, handle);
+	ret =3D qcom_scm_shm_bridge_create(pfn_and_ns_perm, ipfn_and_s_perm,
+					 size_and_flags, QCOM_SCM_VMID_HLOS,
+					 handle);
 	if (ret)
 		return ret;
=20
@@ -141,7 +141,7 @@ static void qcom_tzmem_cleanup_area(struct qcom_tzmem_are=
a *area)
 	if (!qcom_tzmem_using_shm_bridge)
 		return;
=20
-	qcom_scm_shm_bridge_delete(qcom_tzmem_dev, *handle);
+	qcom_scm_shm_bridge_delete(*handle);
 	kfree(handle);
 }
=20
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/=
qcom/qcom_scm.h
index bf5e64f6deba..33fde08dce70 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -149,10 +149,10 @@ bool qcom_scm_lmh_dcvsh_available(void);
 int qcom_scm_gpu_init_regs(u32 gpu_req);
=20
 int qcom_scm_shm_bridge_enable(void);
-int qcom_scm_shm_bridge_create(struct device *dev, u64 pfn_and_ns_perm_flags,
+int qcom_scm_shm_bridge_create(u64 pfn_and_ns_perm_flags,
 			       u64 ipfn_and_s_perm_flags, u64 size_and_flags,
 			       u64 ns_vmids, u64 *handle);
-int qcom_scm_shm_bridge_delete(struct device *dev, u64 handle);
+int qcom_scm_shm_bridge_delete(u64 handle);
=20
 #ifdef CONFIG_QCOM_QSEECOM
=20

--=20
2.34.1


--===============3982797463713985825==--

