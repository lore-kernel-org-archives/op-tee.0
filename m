From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] plat-rzn1: increase DDR size to 1GB
Date: Fri, 12 May 2023 13:05:55 -0400
Message-ID: <20230512170555.2252017-1-ralph.siemsen@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3658425972197131508=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3658425972197131508==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

There are now some RZ/N1 devices with 1GB rather than 256MB. The
first-stage bootloader does not support passing a DT to OP-TEE, so
static values are set at compile time. Increase the DDR size so as to
avoid OP-TEE calls failing with TEEC_ERROR_OUT_OF_MEMORY.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 core/arch/arm/plat-rzn1/platform_config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/core/arch/arm/plat-rzn1/platform_config.h b/core/arch/arm/plat-r=
zn1/platform_config.h
index a6340bb33..eb709c62f 100644
--- a/core/arch/arm/plat-rzn1/platform_config.h
+++ b/core/arch/arm/plat-rzn1/platform_config.h
@@ -11,7 +11,7 @@
=20
 /* DRAM */
 #define DRAM_BASE			0x80000000
-#define DRAM_SIZE			0x10000000
+#define DRAM_SIZE			0x40000000
=20
 /* GIC */
 #define GIC_BASE			0x44100000
--=20
2.25.1


--===============3658425972197131508==--

