From: Linus Walleij <linus.walleij@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: optee: Pass a pointer to virt_addr_valid()
Date: Thu, 19 May 2022 23:46:35 +0200
Message-ID: <20220519214635.780339-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5206636010410736681=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5206636010410736681==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

A pointer into virtual memory is represented by a (void *)
not an u32, so the compiler warns:

drivers/tee/optee/call.c:365:29: warning: passing argument 1
  of 'virt_to_pfn' makes pointer from integer without a
  cast [-Wint-conversion]

Fix this with an explicit cast.

Cc: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tee/optee/call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index bd49ec934060..51275d77ec84 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -362,7 +362,7 @@ int optee_check_mem_type(unsigned long start, size_t num_=
pages)
 	 * Allow kernel address to register with OP-TEE as kernel
 	 * pages are configured as normal memory only.
 	 */
-	if (virt_addr_valid(start))
+	if (virt_addr_valid((void *)start))
 		return 0;
=20
 	mmap_read_lock(mm);
--=20
2.35.1


--===============5206636010410736681==--

