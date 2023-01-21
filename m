From: Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] ta: avb: fix object leakage at lock state write
Date: Sat, 21 Jan 2023 05:45:23 +0000
Message-ID: <20230121054516.3979073-1-ivan.khoronzhuk@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0187111337010761201=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0187111337010761201==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Ivan Khoronzhuk <ivan.khoronzhuk@globallogic.com>

Should close object created for reading, so better use seek
and then close the object.

Fixes: b29b41950 ("ta: add AVB TA")
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@globallogic.com>
---
 ta/avb/entry.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/ta/avb/entry.c b/ta/avb/entry.c
index 4e57003e..a6e01035 100644
--- a/ta/avb/entry.c
+++ b/ta/avb/entry.c
@@ -239,7 +239,11 @@ static TEE_Result write_lock_state(uint32_t pt,
 	if (count == sizeof(lock_state) && lock_state == wlock_state)
 		goto out;
 
-	res = create_rb_state(wlock_state, &h);
+	res = TEE_SeekObjectData(h, 0, TEE_DATA_SEEK_SET);
+	if (res)
+		goto out;
+
+	res = TEE_WriteObjectData(h, &wlock_state, sizeof(wlock_state));
 out:
 	TEE_CloseObject(h);
 	return res;
-- 
2.34.1


--===============0187111337010761201==--

