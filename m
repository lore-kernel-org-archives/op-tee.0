From: ira.weiny@intel.com
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 0/4] Remove get_kernel_pages()
Date: Sat, 01 Oct 2022 17:23:22 -0700
Message-ID: <20221002002326.946620-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4155406200978654778=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4155406200978654778==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Ira Weiny <ira.weiny@intel.com>

get_kernel_pages() only had one caller [shm_get_kernel_pages()] which did not
need the functionality it provided.  Furthermore, it called kmap_to_page()
which we are looking to removed.

Alter shm_get_kernel_pages() to no longer call get_kernel_pages() and remove
get_kernel_pages().  Along the way it was noted that shm_get_kernel_pages()
does not have any need to support vmalloc'ed addresses either.  Remove that
functionality to clean up the logic.

This series also fixes and uses is_kmap_addr().

Ira Weiny (4):
  highmem: Enhance is_kmap_addr() to check kmap_local_page() mappings
  tee: Remove vmalloc page support
  tee: Remove call to get_kernel_pages()
  mm: Remove get_kernel_pages()

 drivers/tee/tee_shm.c            | 41 ++++++++++++--------------------
 include/linux/highmem-internal.h |  5 +++-
 include/linux/mm.h               |  2 --
 mm/swap.c                        | 30 -----------------------
 4 files changed, 19 insertions(+), 59 deletions(-)


base-commit: 274d7803837da78dfc911bcda0d593412676fc20
-- 
2.37.2


--===============4155406200978654778==--

