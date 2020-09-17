From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v6 4/4] MAINTAINERS: Add entry for TEE based Trusted Keys
Date: Thu, 17 Sep 2020 19:16:38 +0530
Message-ID: <1600350398-4813-5-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1600350398-4813-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5295058553673513436=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5295058553673513436==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add MAINTAINERS entry for TEE based Trusted Keys framework.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d0862b..0a913ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9668,6 +9668,14 @@ F:	include/keys/trusted-type.h
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


--===============5295058553673513436==--

