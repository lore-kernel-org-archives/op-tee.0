From: Yue Haibing <yuehaibing@huawei.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH -next] tee: Remove unused declarations
Date: Thu, 10 Aug 2023 22:49:43 +0800
Message-ID: <20230810144943.34976-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5198133435478032700=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5198133435478032700==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Commit 4fb0a5eb364d ("tee: add OP-TEE driver") declared but never implemented
optee_supp_read()/optee_supp_write().
Commit 967c9cca2cc5 ("tee: generic TEE subsystem") never implemented tee_shm_=
init().

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/tee/optee/optee_private.h | 2 --
 drivers/tee/tee_private.h         | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index 72685ee0d53f..6bb5cae09688 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -238,8 +238,6 @@ int optee_notif_send(struct optee *optee, u_int key);
 u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 			struct tee_param *param);
=20
-int optee_supp_read(struct tee_context *ctx, void __user *buf, size_t len);
-int optee_supp_write(struct tee_context *ctx, void __user *buf, size_t len);
 void optee_supp_init(struct optee_supp *supp);
 void optee_supp_uninit(struct optee_supp *supp);
 void optee_supp_release(struct optee_supp *supp);
diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
index 409cadcc1cff..754e11dcb240 100644
--- a/drivers/tee/tee_private.h
+++ b/drivers/tee/tee_private.h
@@ -47,8 +47,6 @@ struct tee_device {
 	struct tee_shm_pool *pool;
 };
=20
-int tee_shm_init(void);
-
 int tee_shm_get_fd(struct tee_shm *shm);
=20
 bool tee_device_get(struct tee_device *teedev);
--=20
2.34.1


--===============5198133435478032700==--

