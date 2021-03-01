From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v9 4/4] MAINTAINERS: Add entry for TEE based Trusted Keys
Date: Mon, 01 Mar 2021 18:41:27 +0530
Message-ID: <20210301131127.793707-5-sumit.garg@linaro.org>
In-Reply-To: <20210301131127.793707-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7485867038687348468=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7485867038687348468==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add MAINTAINERS entry for TEE based Trusted Keys framework.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d75afad615f..eb1ac9c90f7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9830,6 +9830,14 @@ F:	include/keys/trusted-type.h
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
 M:	Jarkko Sakkinen <jarkko@kernel.org>
-- 
2.25.1


--===============7485867038687348468==--

