From: "Thomas, Rijo-john" <Rijo-john.Thomas@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: [PATCH] tee: amdtee: fix an IS_ERR() vs NULL bug
Date: Mon, 29 Nov 2021 08:23:59 +0000
Message-ID: <CH0PR12MB5346CA4DBE99A795A1B6CA48CF669@CH0PR12MB5346.namprd12.prod.outlook.com>
In-Reply-To: <20211124145404.GE13656@kili>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7912518181025635169=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7912518181025635169==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Rijo Thomas <Rijo-john.Thomas@amd.com>

-----Original Message-----
From: Dan Carpenter <dan.carpenter@oracle.com>=20
Sent: Wednesday, November 24, 2021 8:24 PM
To: Jens Wiklander <jens.wiklander@linaro.org>; Thomas, Rijo-john <Rijo-joh=
n.Thomas@amd.com>
Cc: Sumit Garg <sumit.garg@linaro.org>; Rangasamy, Devaraj <Devaraj.Rangasa=
my@amd.com>; Herbert Xu <herbert@gondor.apana.org.au>; Gary R Hook <gary.=
hook@amd.com>; op-tee(a)lists.trustedfirmware.org; linux-kernel(a)vger.kern=
el.org; kernel-janitors(a)vger.kernel.org
Subject: [PATCH] tee: amdtee: fix an IS_ERR() vs NULL bug

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

--===============7912518181025635169==--

