From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] optee: Use bitmap_free() to free bitmap
Date: Sun, 26 Dec 2021 15:32:45 +0100
Message-ID: <0e30e1f1bde74bc95085093fb0289007d510a68c.1640529121.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7874216737299233933=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7874216737299233933==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

kfree() and bitmap_free() are the same. But using the latter is more
consistent when freeing memory allocated with bitmap_zalloc().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/tee/optee/notif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
index a28fa03dcd0e..05212842b0a5 100644
--- a/drivers/tee/optee/notif.c
+++ b/drivers/tee/optee/notif.c
@@ -121,5 +121,5 @@ int optee_notif_init(struct optee *optee, u_int max_key)
 
 void optee_notif_uninit(struct optee *optee)
 {
-	kfree(optee->notif.bitmap);
+	bitmap_free(optee->notif.bitmap);
 }
-- 
2.32.0


--===============7874216737299233933==--

