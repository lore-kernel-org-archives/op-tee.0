From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v5 2/3] efi: Add EFI_ACCESS_DENIED status code
Date: Fri, 26 May 2023 10:07:46 +0900
Message-ID: <20230526010748.1222-3-masahisa.kojima@linaro.org>
In-Reply-To: <20230526010748.1222-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4693951758593216803=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4693951758593216803==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This commit adds the EFI_ACCESS_DENIED status code.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 include/linux/efi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index b8ba9c5adc7a..657f7e203374 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -39,6 +39,7 @@
 #define EFI_WRITE_PROTECTED	( 8 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_OUT_OF_RESOURCES	( 9 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_NOT_FOUND		(14 | (1UL << (BITS_PER_LONG-1)))
+#define EFI_ACCESS_DENIED	(15 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_TIMEOUT		(18 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_ABORTED		(21 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_SECURITY_VIOLATION	(26 | (1UL << (BITS_PER_LONG-1)))
-- 
2.30.2


--===============4693951758593216803==--

