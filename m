From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v7 4/4] MAINTAINERS: Add entry for TEE based Trusted Keys
Date: Wed, 07 Oct 2020 15:37:48 +0530
Message-ID: <1602065268-26017-5-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1602065268-26017-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3633991575979377195=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3633991575979377195==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add MAINTAINERS entry for TEE based Trusted Keys framework.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 48aff80..eb3d889 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9663,6 +9663,14 @@ F:	include/keys/trusted-type.h
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


--===============3633991575979377195==--

