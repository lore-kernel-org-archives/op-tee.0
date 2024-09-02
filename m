From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 2/2] optee: add RPMB dependency
Date: Mon, 02 Sep 2024 17:12:31 +0200
Message-ID: <20240902151231.3705204-2-jens.wiklander@linaro.org>
In-Reply-To: <20240902151231.3705204-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2317530080663552092=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2317530080663552092==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Prevent build error when CONFIG_RPMB=3Dm and CONFIG_OPTEE=3Dy by adding a
dependency to CONFIG_RPMB for CONFIG_OPTEE so the RPMB subsystem always
is reachable if configured. This means that CONFIG_OPTEE automatically
becomes compiled as a module if CONFIG_RPMB is compiled as a module. If
CONFIG_RPMB isn't configured or is configured as built-in, CONFIG_OPTEE
will remain unchanged.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409021448.RSvcBPzt-lkp(a)int=
el.com/
Fixes: f0c8431568ee ("optee: probe RPMB device using RPMB subsystem")
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
Replacing "rpmb: use IS_REACHABLE instead of IS_ENABLED"
https://lore.kernel.org/lkml/20240902080727.2665235-1-jens.wiklander(a)linaro=
.org/
---
 drivers/tee/optee/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
index 976928641aa6..7bb7990d0b07 100644
--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -4,6 +4,7 @@ config OPTEE
 	tristate "OP-TEE"
 	depends on HAVE_ARM_SMCCC
 	depends on MMU
+	depends on RPMB || !RPMB
 	help
 	  This implements the OP-TEE Trusted Execution Environment (TEE)
 	  driver.
--=20
2.34.1


--===============2317530080663552092==--

