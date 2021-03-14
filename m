From: Anupama K Patil <anupamakpatil123@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] drivers: tee: optee: removed repeated words in comments
Date: Sun, 14 Mar 2021 09:18:50 -0700
Message-ID: <20210314161854.4541-1-anupamakpatil123@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8862385233283165928=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8862385233283165928==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

the word "the" is repeated in the file core.c
so it has been removed. Likewise the word "of"
is repeated in optee_smc.h and have removed it.

Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
---
 drivers/tee/optee/core.c      | 2 +-
 drivers/tee/optee/optee_smc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index cf4718c6d35d..2ccb091cd643 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -422,7 +422,7 @@ static bool optee_msg_exchange_capabilities(optee_invoke_=
fn *invoke_fn,
=20
 	/*
 	 * TODO This isn't enough to tell if it's UP system (from kernel
-	 * point of view) or not, is_smp() returns the the information
+	 * point of view) or not, is_smp() returns the information
 	 * needed, but can't be called directly from here.
 	 */
 	if (!IS_ENABLED(CONFIG_SMP) || nr_cpu_ids =3D=3D 1)
diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index 80eb763a8a80..49e8e027dc5b 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -162,7 +162,7 @@ struct optee_smc_call_get_os_revision_result {
  * Have config return register usage:
  * a0	OPTEE_SMC_RETURN_OK
  * a1	Physical address of start of SHM
- * a2	Size of of SHM
+ * a2	Size of SHM
  * a3	Cache settings of memory, as defined by the
  *	OPTEE_SMC_SHM_* values above
  * a4-7	Preserved
--=20
2.25.1


--===============8862385233283165928==--

