From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 3/7] remoteproc: core: Add check on cached_table pointer
Date: Wed, 14 Feb 2024 17:22:37 +0000
Message-ID: <20240214172127.1022199-4-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8483871021295895459=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8483871021295895459==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Add a check on the optional rproc->cached_table to perform the memory
copy only if it is not null.

2 use cases to support:
- starting on boot, in which case rproc->cached_table can be null,
- starting on crash recovery, where the cached table is used to save
  the resource table configuration on stop and re-apply the configuration
  on the re-start.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/remoteproc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remote=
proc_core.c
index 283ca071e35c..34b0093689da 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1278,7 +1278,7 @@ static int rproc_start(struct rproc *rproc, const struc=
t firmware *fw)
 	 * that any subsequent changes will be applied to the loaded version.
 	 */
 	loaded_table =3D rproc_find_loaded_rsc_table(rproc, fw);
-	if (loaded_table) {
+	if (loaded_table && rproc->cached_table) {
 		memcpy(loaded_table, rproc->cached_table, rproc->table_sz);
 		rproc->table_ptr =3D loaded_table;
 	}
--=20
2.25.1


--===============8483871021295895459==--

