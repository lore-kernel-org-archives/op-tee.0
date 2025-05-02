From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v8 09/14] cma: export cma_alloc() and cma_release()
Date: Fri, 02 May 2025 11:59:23 +0200
Message-ID: <20250502100049.1746335-10-jens.wiklander@linaro.org>
In-Reply-To: <20250502100049.1746335-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6946604230758164661=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6946604230758164661==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Export the two functions cma_alloc() and cma_release().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm(a)kvack.org
Cc: linux-kernel(a)vger.kernel.org
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 mm/cma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index 15632939f20a..c60901e73a26 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -915,6 +915,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long cou=
nt,
 {
 	return __cma_alloc(cma, count, align, GFP_KERNEL | (no_warn ? __GFP_NOWARN =
: 0));
 }
+EXPORT_SYMBOL(cma_alloc);
=20
 struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp)
 {
@@ -1002,6 +1003,7 @@ bool cma_release(struct cma *cma, const struct page *pa=
ges,
=20
 	return true;
 }
+EXPORT_SYMBOL(cma_release);
=20
 bool cma_free_folio(struct cma *cma, const struct folio *folio)
 {
--=20
2.43.0


--===============6946604230758164661==--

