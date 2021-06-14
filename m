From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v5 4/8] optee: Clear stale cache entries during initialization
Date: Mon, 14 Jun 2021 17:33:13 -0500
Message-ID: <20210614223317.999867-5-tyhicks@linux.microsoft.com>
In-Reply-To: <20210614223317.999867-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8052963601524606158=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8052963601524606158==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The shm cache could contain invalid addresses if
optee_disable_shm_cache() was not called from the .shutdown hook of the
previous kernel before a kexec. These addresses could be unmapped or
they could point to mapped but unintended locations in memory.

Clear the shared memory cache, while being careful to not translate the
addresses returned from OPTEE_SMC_DISABLE_SHM_CACHE, during driver
initialization. Once all pre-cache shm objects are removed, proceed with
enabling the cache so that we know that we can handle cached shm objects
with confidence later in the .shutdown hook.

Cc: stable(a)vger.kernel.org
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/tee/optee/call.c          | 36 ++++++++++++++++++++++++++++---
 drivers/tee/optee/core.c          |  9 ++++++++
 drivers/tee/optee/optee_private.h |  1 +
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 6e6eb836e9b6..387e94768182 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -416,11 +416,13 @@ void optee_enable_shm_cache(struct optee *optee)
 }
=20
 /**
- * optee_disable_shm_cache() - Disables caching of some shared memory alloca=
tion
- *			      in OP-TEE
+ * __optee_disable_shm_cache() - Disables caching of some shared memory
+ *                               allocation in OP-TEE
  * @optee:	main service struct
+ * @is_mapped:	true if the cached shared memory addresses were mapped by this
+ *		kernel, are safe to dereference, and should be freed
  */
-void optee_disable_shm_cache(struct optee *optee)
+static void __optee_disable_shm_cache(struct optee *optee, bool is_mapped)
 {
 	struct optee_call_waiter w;
=20
@@ -439,6 +441,13 @@ void optee_disable_shm_cache(struct optee *optee)
 		if (res.result.status =3D=3D OPTEE_SMC_RETURN_OK) {
 			struct tee_shm *shm;
=20
+			/*
+			 * Shared memory references that were not mapped by
+			 * this kernel must be ignored to prevent a crash.
+			 */
+			if (!is_mapped)
+				continue;
+
 			shm =3D reg_pair_to_ptr(res.result.shm_upper32,
 					      res.result.shm_lower32);
 			tee_shm_free(shm);
@@ -449,6 +458,27 @@ void optee_disable_shm_cache(struct optee *optee)
 	optee_cq_wait_final(&optee->call_queue, &w);
 }
=20
+/**
+ * optee_disable_shm_cache() - Disables caching of mapped shared memory
+ *                             allocations in OP-TEE
+ * @optee:	main service struct
+ */
+void optee_disable_shm_cache(struct optee *optee)
+{
+	return __optee_disable_shm_cache(optee, true);
+}
+
+/**
+ * optee_disable_unmapped_shm_cache() - Disables caching of shared memory
+ *                                      allocations in OP-TEE which are not
+ *                                      currently mapped
+ * @optee:	main service struct
+ */
+void optee_disable_unmapped_shm_cache(struct optee *optee)
+{
+	return __optee_disable_shm_cache(optee, false);
+}
+
 #define PAGELIST_ENTRIES_PER_PAGE				\
 	((OPTEE_MSG_NONCONTIG_PAGE_SIZE / sizeof(u64)) - 1)
=20
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 0987074d7ed0..651d49b53d3b 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -716,6 +716,15 @@ static int optee_probe(struct platform_device *pdev)
 	optee->memremaped_shm =3D memremaped_shm;
 	optee->pool =3D pool;
=20
+	/*
+	 * Ensure that there are no pre-existing shm objects before enabling
+	 * the shm cache so that there's no chance of receiving an invalid
+	 * address during shutdown. This could occur, for example, if we're
+	 * kexec booting from an older kernel that did not properly cleanup the
+	 * shm cache.
+	 */
+	optee_disable_unmapped_shm_cache(optee);
+
 	optee_enable_shm_cache(optee);
=20
 	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index e25b216a14ef..dbdd367be156 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -159,6 +159,7 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_=
id, u32 session);
=20
 void optee_enable_shm_cache(struct optee *optee);
 void optee_disable_shm_cache(struct optee *optee);
+void optee_disable_unmapped_shm_cache(struct optee *optee);
=20
 int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
 		       struct page **pages, size_t num_pages,
--=20
2.25.1


--===============8052963601524606158==--

