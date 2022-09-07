From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v3 06/10] firmware: arm_ffa: Make memory apis ffa_device independent
Date: Wed, 07 Sep 2022 15:52:36 +0100
Message-ID: <20220907145240.1683088-7-sudeep.holla@arm.com>
In-Reply-To: <20220907145240.1683088-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0875551670797879430=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0875551670797879430==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

There is a requirement to make memory APIs independent of the ffa_device.
One of the use-case is to have a common memory driver that manages the
memory for all the ffa_devices. That common memory driver won't be a
ffa_driver or won't have any ffa_device associated with it. So having
these memory APIs accessible without a ffa_device is needed and should
be possible as most of these are handled by the partition manager(SPM
or hypervisor).

Drop the ffa_device argument to the memory APIs and make them ffa_device
independent.

Acked-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 6 ++----
 drivers/tee/optee/ffa_abi.c       | 2 +-
 include/linux/arm_ffa.h           | 6 ++----
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/dri=
ver.c
index 37a8ee304508..e4fd35773071 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -643,8 +643,7 @@ static int ffa_sync_send_receive(struct ffa_device *dev,
 				       dev->mode_32bit, data);
 }
=20
-static int
-ffa_memory_share(struct ffa_device *dev, struct ffa_mem_ops_args *args)
+static int ffa_memory_share(struct ffa_mem_ops_args *args)
 {
 	if (drv_info->mem_ops_native)
 		return ffa_memory_ops(FFA_FN_NATIVE(MEM_SHARE), args);
@@ -652,8 +651,7 @@ ffa_memory_share(struct ffa_device *dev, struct ffa_mem_o=
ps_args *args)
 	return ffa_memory_ops(FFA_MEM_SHARE, args);
 }
=20
-static int
-ffa_memory_lend(struct ffa_device *dev, struct ffa_mem_ops_args *args)
+static int ffa_memory_lend(struct ffa_mem_ops_args *args)
 {
 	/* Note that upon a successful MEM_LEND request the caller
 	 * must ensure that the memory region specified is not accessed
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 3d4079575ccd..7257b42d0545 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -294,7 +294,7 @@ static int optee_ffa_shm_register(struct tee_context *ctx=
, struct tee_shm *shm,
 	if (rc)
 		return rc;
 	args.sg =3D sgt.sgl;
-	rc =3D ffa_ops->memory_share(ffa_dev, &args);
+	rc =3D ffa_ops->memory_share(&args);
 	sg_free_table(&sgt);
 	if (rc)
 		return rc;
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 556f50f27fb1..eafab07c9f58 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -262,10 +262,8 @@ struct ffa_dev_ops {
 	int (*sync_send_receive)(struct ffa_device *dev,
 				 struct ffa_send_direct_data *data);
 	int (*memory_reclaim)(u64 g_handle, u32 flags);
-	int (*memory_share)(struct ffa_device *dev,
-			    struct ffa_mem_ops_args *args);
-	int (*memory_lend)(struct ffa_device *dev,
-			   struct ffa_mem_ops_args *args);
+	int (*memory_share)(struct ffa_mem_ops_args *args);
+	int (*memory_lend)(struct ffa_mem_ops_args *args);
 };
=20
 #endif /* _LINUX_ARM_FFA_H */
--=20
2.37.3


--===============0875551670797879430==--

