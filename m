From: Ira Weiny <ira.weiny@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 4/4] mm: Remove get_kernel_pages()
Date: Fri, 03 Feb 2023 20:06:35 -0800
Message-ID: <20230203-get_kernel_pages-v2-4-f1dc4af273f1@intel.com>
In-Reply-To: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7756436997921268318=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7756436997921268318==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The only caller to get_kernel_pages() [shm_get_kernel_pages()] has been
updated to not need it.

Remove get_kernel_pages().

Cc: Mel Gorman <mgorman@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/mm.h |  2 --
 mm/swap.c          | 30 ------------------------------
 2 files changed, 32 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8f857163ac89..2041e6d4fa27 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2095,8 +2095,6 @@ int __account_locked_vm(struct mm_struct *mm, unsigned =
long pages, bool inc,
 			struct task_struct *task, bool bypass_rlim);
=20
 struct kvec;
-int get_kernel_pages(const struct kvec *iov, int nr_pages, int write,
-			struct page **pages);
 struct page *get_dump_page(unsigned long addr);
=20
 bool folio_mark_dirty(struct folio *folio);
diff --git a/mm/swap.c b/mm/swap.c
index 70e2063ef43a..4c03ecab698e 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -158,36 +158,6 @@ void put_pages_list(struct list_head *pages)
 }
 EXPORT_SYMBOL(put_pages_list);
=20
-/*
- * get_kernel_pages() - pin kernel pages in memory
- * @kiov:	An array of struct kvec structures
- * @nr_segs:	number of segments to pin
- * @write:	pinning for read/write, currently ignored
- * @pages:	array that receives pointers to the pages pinned.
- *		Should be at least nr_segs long.
- *
- * Returns number of pages pinned. This may be fewer than the number request=
ed.
- * If nr_segs is 0 or negative, returns 0.  If no pages were pinned, returns=
 0.
- * Each page returned must be released with a put_page() call when it is
- * finished with.
- */
-int get_kernel_pages(const struct kvec *kiov, int nr_segs, int write,
-		struct page **pages)
-{
-	int seg;
-
-	for (seg =3D 0; seg < nr_segs; seg++) {
-		if (WARN_ON(kiov[seg].iov_len !=3D PAGE_SIZE))
-			return seg;
-
-		pages[seg] =3D kmap_to_page(kiov[seg].iov_base);
-		get_page(pages[seg]);
-	}
-
-	return seg;
-}
-EXPORT_SYMBOL_GPL(get_kernel_pages);
-
 typedef void (*move_fn_t)(struct lruvec *lruvec, struct folio *folio);
=20
 static void lru_add_fn(struct lruvec *lruvec, struct folio *folio)

--=20
2.39.1

--===============7756436997921268318==--

