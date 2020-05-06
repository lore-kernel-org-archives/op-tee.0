From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [op-tee] [PATCH v4 4/4] MAINTAINERS: Add entry for TEE based Trusted Keys
Date: Wed, 06 May 2020 15:10:17 +0530
Message-ID: <1588758017-30426-5-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1826164797111521493=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1826164797111521493==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add MAINTAINERS entry for TEE based Trusted Keys framework.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b816a45..fc8bf16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9403,6 +9403,14 @@ F:	include/keys/trusted-type.h
 F:	include/keys/trusted_tpm.h
 F:	security/keys/trusted-keys/
 
+KEYS-TRUSTED-TEE
+M:	Sumit Garg <sumit.garg@linaro.org>
+L:	linux-integrity(a)vger.kernel.org
+L:	keyrings(a)vger.kernel.org
+S:	Supported
+F:	include/keys/trusted_tee.h
+F:	security/keys/trusted-keys/trusted_tee.c
+
 KEYS/KEYRINGS
 M:	David Howells <dhowells@redhat.com>
 M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
-- 
2.7.4


--===============1826164797111521493==--

