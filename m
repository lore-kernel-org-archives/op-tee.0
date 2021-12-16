From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2] tee: optee: Fix incorrect page free bug
Date: Thu, 16 Dec 2021 11:17:25 +0530
Message-ID: <20211216054725.3873834-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7185592983328424274=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7185592983328424274==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Pointer to the allocated pages (struct page *page) has already
progressed towards the end of allocation. It is incorrect to perform
__free_pages(page, order) using this pointer as we would free any
arbitrary pages. Fix this by stop modifying the page pointer.

Fixes: ec185dd3ab25 ("optee: Fix memory leak when failing to register shm pag=
es")
Cc: stable(a)vger.kernel.org
Reported-by: Patrik Lantz <patrik.lantz@axis.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---

Changes since v1:
- Added stable CC tag.
- Picked up Tyler's review tag.

 drivers/tee/optee/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index ab2edfcc6c70..2a66a5203d2f 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -48,10 +48,8 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool_mgr *po=
olm,
 			goto err;
 		}
=20
-		for (i =3D 0; i < nr_pages; i++) {
-			pages[i] =3D page;
-			page++;
-		}
+		for (i =3D 0; i < nr_pages; i++)
+			pages[i] =3D page + i;
=20
 		shm->flags |=3D TEE_SHM_REGISTER;
 		rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
--=20
2.25.1


--===============7185592983328424274==--

