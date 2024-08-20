From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 7/7] firmware: arm_ffa: Fetch the Rx/Tx buffer size using
 ffa_features()
Date: Tue, 20 Aug 2024 15:28:00 +0100
Message-ID: <20240820-ffa_v1-2-v2-7-18c0c5f3c65e@arm.com>
In-Reply-To: <20240820-ffa_v1-2-v2-0-18c0c5f3c65e@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2788879504871147770=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2788879504871147770==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

An endpoint can discover the minimum size, maximum size and alignment
boundary for the Rx/Tx buffers by passing the function ID of the
FFA_RXTX_MAP ABI as input in the FFA_FEATURES interface. The maximum
size is an optional field and a value of 0 means that the partition
manager or the hypervisor does not enforce a maximum size.

Use the discovery mechanism and remove the hardcoded 4kB buffer size.
If the discovery fails, it still defaults to 4kB.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 44 +++++++++++++++++++++++++------------=
--
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/dri=
ver.c
index d47272859190..4d231bc375e0 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -54,11 +54,8 @@
 #define PACK_TARGET_INFO(s, r)		\
 	(FIELD_PREP(SENDER_ID_MASK, (s)) | FIELD_PREP(RECEIVER_ID_MASK, (r)))
=20
-/*
- * Keeping RX TX buffer size as 4K for now
- * 64K may be preferred to keep it min a page in 64K PAGE_SIZE config
- */
-#define RXTX_BUFFER_SIZE	SZ_4K
+#define RXTX_MAP_MIN_BUFSZ_MASK	GENMASK(1, 0)
+#define RXTX_MAP_MIN_BUFSZ(x)	((x) & RXTX_MAP_MIN_BUFSZ_MASK)
=20
 #define FFA_MAX_NOTIFICATIONS		64
=20
@@ -99,6 +96,7 @@ struct ffa_drv_info {
 	struct mutex tx_lock; /* lock to protect Tx buffer */
 	void *rx_buffer;
 	void *tx_buffer;
+	size_t rxtx_bufsz;
 	bool mem_ops_native;
 	bool msg_direct_req2_supp;
 	bool bitmap_created;
@@ -454,7 +452,7 @@ static int ffa_msg_send2(u16 src_id, u16 dst_id, void *bu=
f, size_t sz)
 	ffa_value_t ret;
 	int retval =3D 0;
=20
-	if (sz > (RXTX_BUFFER_SIZE - sizeof(*msg)))
+	if (sz > (drv_info->rxtx_bufsz - sizeof(*msg)))
 		return -ERANGE;
=20
 	mutex_lock(&drv_info->tx_lock);
@@ -689,9 +687,10 @@ static int ffa_memory_ops(u32 func_id, struct ffa_mem_op=
s_args *args)
 {
 	int ret;
 	void *buffer;
+	size_t rxtx_bufsz =3D drv_info->rxtx_bufsz;
=20
 	if (!args->use_txbuf) {
-		buffer =3D alloc_pages_exact(RXTX_BUFFER_SIZE, GFP_KERNEL);
+		buffer =3D alloc_pages_exact(rxtx_bufsz, GFP_KERNEL);
 		if (!buffer)
 			return -ENOMEM;
 	} else {
@@ -699,12 +698,12 @@ static int ffa_memory_ops(u32 func_id, struct ffa_mem_o=
ps_args *args)
 		mutex_lock(&drv_info->tx_lock);
 	}
=20
-	ret =3D ffa_setup_and_transmit(func_id, buffer, RXTX_BUFFER_SIZE, args);
+	ret =3D ffa_setup_and_transmit(func_id, buffer, rxtx_bufsz, args);
=20
 	if (args->use_txbuf)
 		mutex_unlock(&drv_info->tx_lock);
 	else
-		free_pages_exact(buffer, RXTX_BUFFER_SIZE);
+		free_pages_exact(buffer, rxtx_bufsz);
=20
 	return ret < 0 ? ret : 0;
 }
@@ -1718,6 +1717,8 @@ static void ffa_notifications_setup(void)
 static int __init ffa_init(void)
 {
 	int ret;
+	u32 buf_sz;
+	size_t rxtx_bufsz =3D SZ_4K;
=20
 	ret =3D ffa_transport_init(&invoke_ffa_fn);
 	if (ret)
@@ -1737,13 +1738,24 @@ static int __init ffa_init(void)
 		goto free_drv_info;
 	}
=20
-	drv_info->rx_buffer =3D alloc_pages_exact(RXTX_BUFFER_SIZE, GFP_KERNEL);
+	ret =3D ffa_features(FFA_FN_NATIVE(RXTX_MAP), 0, &buf_sz, NULL);
+	if (!ret) {
+		if (RXTX_MAP_MIN_BUFSZ(buf_sz) =3D=3D 1)
+			rxtx_bufsz =3D SZ_64K;
+		else if (RXTX_MAP_MIN_BUFSZ(buf_sz) =3D=3D 2)
+			rxtx_bufsz =3D SZ_16K;
+		else
+			rxtx_bufsz =3D SZ_4K;
+	}
+
+	drv_info->rxtx_bufsz =3D rxtx_bufsz;
+	drv_info->rx_buffer =3D alloc_pages_exact(rxtx_bufsz, GFP_KERNEL);
 	if (!drv_info->rx_buffer) {
 		ret =3D -ENOMEM;
 		goto free_pages;
 	}
=20
-	drv_info->tx_buffer =3D alloc_pages_exact(RXTX_BUFFER_SIZE, GFP_KERNEL);
+	drv_info->tx_buffer =3D alloc_pages_exact(rxtx_bufsz, GFP_KERNEL);
 	if (!drv_info->tx_buffer) {
 		ret =3D -ENOMEM;
 		goto free_pages;
@@ -1751,7 +1763,7 @@ static int __init ffa_init(void)
=20
 	ret =3D ffa_rxtx_map(virt_to_phys(drv_info->tx_buffer),
 			   virt_to_phys(drv_info->rx_buffer),
-			   RXTX_BUFFER_SIZE / FFA_PAGE_SIZE);
+			   rxtx_bufsz / FFA_PAGE_SIZE);
 	if (ret) {
 		pr_err("failed to register FFA RxTx buffers\n");
 		goto free_pages;
@@ -1781,8 +1793,8 @@ static int __init ffa_init(void)
 	ffa_notifications_cleanup();
 free_pages:
 	if (drv_info->tx_buffer)
-		free_pages_exact(drv_info->tx_buffer, RXTX_BUFFER_SIZE);
-	free_pages_exact(drv_info->rx_buffer, RXTX_BUFFER_SIZE);
+		free_pages_exact(drv_info->tx_buffer, rxtx_bufsz);
+	free_pages_exact(drv_info->rx_buffer, rxtx_bufsz);
 free_drv_info:
 	kfree(drv_info);
 	return ret;
@@ -1794,8 +1806,8 @@ static void __exit ffa_exit(void)
 	ffa_notifications_cleanup();
 	ffa_partitions_cleanup();
 	ffa_rxtx_unmap(drv_info->vm_id);
-	free_pages_exact(drv_info->tx_buffer, RXTX_BUFFER_SIZE);
-	free_pages_exact(drv_info->rx_buffer, RXTX_BUFFER_SIZE);
+	free_pages_exact(drv_info->tx_buffer, drv_info->rxtx_bufsz);
+	free_pages_exact(drv_info->rx_buffer, drv_info->rxtx_bufsz);
 	kfree(drv_info);
 }
 module_exit(ffa_exit);

--=20
2.46.0


--===============2788879504871147770==--

