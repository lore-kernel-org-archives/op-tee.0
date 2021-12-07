From: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 0/2] CAAM Driver: re-factor and set proper JR status
Date: Wed, 08 Dec 2021 00:02:04 +0100
Message-ID: <20211207230206.14637-1-andrey.zhizhikin@leica-geosystems.com>
In-Reply-To: <20211111164601.13135-1-andrey.zhizhikin@leica-geosystems.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1153249687241631516=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1153249687241631516==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This V3 series covers points uncovered during the review of the previous
series, one major point being that register readout should not be used
for dynamic JR availability check due to its unreliability.

Instead, JR should have a proper status set in FDT which indicates the
availability of the ring in NS-World. This status is aligned with what
BootROM code configures, and can be modified by all actors in the boot
chain.

Therefore, patch in V2 series that was handling the dynamic JR
availability check is dropped in this series and replaced by the patch
which sets proper DT status for JR nodes.

Andrey Zhizhikin (2):
  crypto: caam - convert to use capabilities
  arm64: dts: imx8m: define proper status for caam jr

 arch/arm64/boot/dts/freescale/imx8mm.dtsi |   4 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi |   4 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi |   4 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi |   4 +
 drivers/crypto/caam/caamalg_qi.c          |   2 +-
 drivers/crypto/caam/ctrl.c                | 115 ++++++++++++++--------
 drivers/crypto/caam/intern.h              |  20 ++--
 drivers/crypto/caam/jr.c                  |  19 +++-
 drivers/crypto/caam/regs.h                |   2 -
 9 files changed, 122 insertions(+), 52 deletions(-)


base-commit: 04fe99a8d936d46a310ca61b8b63dc270962bf01
-- 
2.25.1


--===============1153249687241631516==--

