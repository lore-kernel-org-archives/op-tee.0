From: Cai Huoqing <cai.huoqing@linux.dev>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: amdtee: Make use of the helper macro LIST_HEAD()
Date: Wed, 09 Feb 2022 11:27:43 +0800
Message-ID: <20220209032745.38570-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2427755013332937415=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2427755013332937415==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Replace "struct list_head head =3D LIST_HEAD_INIT(head)" with
"LIST_HEAD(head)" to simplify the code.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/tee/amdtee/call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
index 07f36ac834c8..cec6e70f0ac9 100644
--- a/drivers/tee/amdtee/call.c
+++ b/drivers/tee/amdtee/call.c
@@ -122,7 +122,7 @@ static int amd_params_to_tee_params(struct tee_param *tee=
, u32 count,
 }
=20
 static DEFINE_MUTEX(ta_refcount_mutex);
-static struct list_head ta_list =3D LIST_HEAD_INIT(ta_list);
+static LIST_HEAD(ta_list);
=20
 static u32 get_ta_refcount(u32 ta_handle)
 {
--=20
2.25.1


--===============2427755013332937415==--

