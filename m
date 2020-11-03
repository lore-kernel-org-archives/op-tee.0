From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v8 4/4] MAINTAINERS: Add myself as Trusted Keys co-maintainer
Date: Tue, 03 Nov 2020 21:31:46 +0530
Message-ID: <1604419306-26105-5-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4661107920449591579=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4661107920449591579==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add a Trusted Keys co-maintainer entry in order to support TEE based
Trusted Keys framework.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b..52687bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9732,11 +9732,13 @@ KEYS-TRUSTED
 M:	James Bottomley <jejb@linux.ibm.com>
 M:	Jarkko Sakkinen <jarkko@kernel.org>
 M:	Mimi Zohar <zohar@linux.ibm.com>
+M:	Sumit Garg <sumit.garg@linaro.org>
 L:	linux-integrity(a)vger.kernel.org
 L:	keyrings(a)vger.kernel.org
 S:	Supported
 F:	Documentation/security/keys/trusted-encrypted.rst
 F:	include/keys/trusted-type.h
+F:	include/keys/trusted_tee.h
 F:	include/keys/trusted_tpm.h
 F:	security/keys/trusted-keys/
 
-- 
2.7.4


--===============4661107920449591579==--

