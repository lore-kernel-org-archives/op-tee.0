From: Ryan Roberts <ryan.roberts@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [RFC PATCH v1 32/57] optee: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:39 +0100
Message-ID: <20241014105912.3207374-32-ryan.roberts@arm.com>
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2763708345878042797=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2763708345878042797==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

Updated BUILD_BUG_ON() to test against limit.

Refactored "struct optee_shm_arg_entry" to use a flexible array member
for "map", since its length depends on PAGE_SIZE.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts(a)arm.com/

 drivers/tee/optee/call.c    | 7 +++++--
 drivers/tee/optee/smc_abi.c | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 16eb953e14bb6..41bd7ace6606e 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -36,7 +36,7 @@
 struct optee_shm_arg_entry {
 	struct list_head list_node;
 	struct tee_shm *shm;
-	DECLARE_BITMAP(map, MAX_ARG_COUNT_PER_ENTRY);
+	unsigned long map[];
 };
=20
 void optee_cq_init(struct optee_call_queue *cq, int thread_count)
@@ -271,6 +271,7 @@ struct optee_msg_arg *optee_get_msg_arg(struct tee_contex=
t *ctx,
 	struct optee_shm_arg_entry *entry;
 	struct optee_msg_arg *ma;
 	size_t args_per_entry;
+	size_t entry_sz;
 	u_long bit;
 	u_int offs;
 	void *res;
@@ -293,7 +294,9 @@ struct optee_msg_arg *optee_get_msg_arg(struct tee_contex=
t *ctx,
 	/*
 	 * No entry was found, let's allocate a new.
 	 */
-	entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
+	entry_sz =3D struct_size(entry, map,
+			       BITS_TO_LONGS(MAX_ARG_COUNT_PER_ENTRY));
+	entry =3D kzalloc(entry_sz, GFP_KERNEL);
 	if (!entry) {
 		res =3D ERR_PTR(-ENOMEM);
 		goto out;
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 844285d4f03c1..005689380d848 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -418,7 +418,7 @@ static void optee_fill_pages_list(u64 *dst, struct page *=
*pages, int num_pages,
 	 * code heavily relies on this assumption, so it is better be
 	 * safe than sorry.
 	 */
-	BUILD_BUG_ON(PAGE_SIZE < OPTEE_MSG_NONCONTIG_PAGE_SIZE);
+	BUILD_BUG_ON(PAGE_SIZE_MIN < OPTEE_MSG_NONCONTIG_PAGE_SIZE);
=20
 	pages_data =3D (void *)dst;
 	/*
--=20
2.43.0


--===============2763708345878042797==--

