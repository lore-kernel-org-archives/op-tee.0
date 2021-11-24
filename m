From: Dan Carpenter <dan.carpenter@oracle.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: amdtee: fix an IS_ERR() vs NULL bug
Date: Wed, 24 Nov 2021 17:54:04 +0300
Message-ID: <20211124145404.GE13656@kili>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5614911863080023819=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5614911863080023819==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The __get_free_pages() function does not return error pointers it returns
NULL so fix this condition to avoid a NULL dereference.

Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/tee/amdtee/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index da6b88e80dc0..297dc62bca29 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -203,9 +203,8 @@ static int copy_ta_binary(struct tee_context *ctx, void *=
ptr, void **ta,
=20
 	*ta_size =3D roundup(fw->size, PAGE_SIZE);
 	*ta =3D (void *)__get_free_pages(GFP_KERNEL, get_order(*ta_size));
-	if (IS_ERR(*ta)) {
-		pr_err("%s: get_free_pages failed 0x%llx\n", __func__,
-		       (u64)*ta);
+	if (!*ta) {
+		pr_err("%s: get_free_pages failed\n", __func__);
 		rc =3D -ENOMEM;
 		goto rel_fw;
 	}
--=20
2.20.1


--===============5614911863080023819==--

