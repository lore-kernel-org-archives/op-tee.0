From: Ira Weiny <ira.weiny@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 0/4] Remove get_kernel_pages()
Date: Fri, 03 Feb 2023 20:06:32 -0800
Message-ID: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0676933566339837090=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0676933566339837090==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Sumit,

I did not see a follow up on this series per your last email.[1]  I'd like to
move forward with getting rid of kmap_to_page().  So Hopefully this can land
and you can build on this rather than the other way around?

All,

Al Viro found[2] that kmap_to_page() is broken.  But not only is it broken, it
presents confusion over how highmem should be used because kmap() and friends
should not be used for 'long term' mappings.

get_kernel_pages() is a caller of kmap_to_page().  It only has one caller
[shm_get_kernel_pages()] which does not need the functionality.

Alter shm_get_kernel_pages() to no longer call get_kernel_pages() and remove
get_kernel_pages().  Along the way it was noted that shm_get_kernel_pages()
does not have any need to support vmalloc'ed addresses either.  Remove that
functionality to clean up the logic.

This series also fixes is_kmap_addr() and uses it to ensure no kmap addresses
slip in later.

[1] https://lore.kernel.org/all/CAFA6WYMqEVDVW-ifoh-V9ni1zntYdes8adQKf2XXAUpq=
daW53w(a)mail.gmail.com/
[2] https://lore.kernel.org/lkml/YzSSl1ItVlARDvG3(a)ZenIV

To: Sumit Garg <sumit.garg@linaro.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christoph Hellwig" <hch@lst.de>
Cc: linux-kernel(a)vger.kernel.org
Cc: op-tee(a)lists.trustedfirmware.org
Cc: linux-mm(a)kvack.org
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes in v2:
- Al Viro: Avoid allocating the kiov.
- Sumit: Update cover letter to clarify the motivation behind removing
  get_kernel_pages()
- Link to v1: https://lore.kernel.org/r/20221002002326.946620-1-ira.weiny(a)i=
ntel.com

---
Ira Weiny (4):
      highmem: Enhance is_kmap_addr() to check kmap_local_page() mappings
      tee: Remove vmalloc page support
      tee: Remove call to get_kernel_pages()
      mm: Remove get_kernel_pages()

 drivers/tee/tee_shm.c            | 37 ++++++++++---------------------------
 include/linux/highmem-internal.h |  5 ++++-
 include/linux/mm.h               |  2 --
 mm/swap.c                        | 30 ------------------------------
 4 files changed, 14 insertions(+), 60 deletions(-)
---
base-commit: 0136d86b78522bbd5755f8194c97a987f0586ba5
change-id: 20230203-get_kernel_pages-199342cfba79

Best regards,
--=20
Ira Weiny <ira.weiny@intel.com>

--===============0676933566339837090==--

