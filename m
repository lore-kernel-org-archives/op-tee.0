From: CGEL <cgel.zte@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH linux-next] tee/optee/shm_pool: fix application of sizeof to pointer
Date: Thu, 19 Aug 2021 20:21:27 -0700
Message-ID: <c66fd6f831571b53b741350513e36405bba6c666.1629211976.git.jing.yangyang@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0773127304049073871=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0773127304049073871==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: jing yangyang <jing.yangyang@zte.com.cn>

sizeof when applied to a pointer typed expression gives the size of
the pointer.

./drivers/tee/optee/shm_pool.c:38:28-34: ERROR application of sizeof to point=
er

This issue was detected with the help of Coccinelle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
---
 drivers/tee/optee/shm_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
index c41a9a5..d167039 100644
--- a/drivers/tee/optee/shm_pool.c
+++ b/drivers/tee/optee/shm_pool.c
@@ -35,7 +35,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 		unsigned int nr_pages =3D 1 << order, i;
 		struct page **pages;
=20
-		pages =3D kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
+		pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
 		if (!pages) {
 			rc =3D -ENOMEM;
 			goto err;
--=20
1.8.3.1



--===============0773127304049073871==--

