From: ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: [PATCH v3 0/2] CAAM Driver: re-factor and set proper JR status
Date: Thu, 06 Jan 2022 10:56:12 +0000
Message-ID: <AM6PR06MB469129E72ED6FBE0B33C693DA64C9@AM6PR06MB4691.eurprd06.prod.outlook.com>
In-Reply-To: <20211207230206.14637-1-andrey.zhizhikin@leica-geosystems.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8099551689591066247=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8099551689591066247==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Herbert,

Gentle ping on this V3. I see that in Patchwork this series state is set to "=
Deferred".

Is there anything missing here to proceed further?

> -----Original Message-----
> From: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
> Sent: Wednesday, December 8, 2021 12:02 AM
> To: linux-kernel(a)vger.kernel.org
> Cc: robh+dt(a)kernel.org; shawnguo(a)kernel.org; michael(a)walle.cc;
> s.hauer(a)pengutronix.de; kernel(a)pengutronix.de; festevam(a)gmail.com; li=
nux-
> imx(a)nxp.com; horia.geanta(a)nxp.com; pankaj.gupta(a)nxp.com;
> herbert(a)gondor.apana.org.au; davem(a)davemloft.net; l.stach(a)pengutronix=
.de;
> qiangqing.zhang(a)nxp.com; peng.fan(a)nxp.com; alice.guo(a)nxp.com; aford17=
3(a)gmail.com;
> frieder.schrempf(a)kontron.de; krzk(a)kernel.org; shengjiu.wang(a)nxp.com;
> gregkh(a)linuxfoundation.org; ping.bai(a)nxp.com; daniel.baluta(a)nxp.com;
> jun.li(a)nxp.com; marex(a)denx.de; thunder.leizhen(a)huawei.com; martink(a)=
posteo.de;
> leonard.crestez(a)nxp.com; hongxing.zhu(a)nxp.com; agx(a)sigxcpu.org;
> devicetree(a)vger.kernel.org; linux-arm-kernel(a)lists.infradead.org; linux-
> crypto(a)vger.kernel.org; op-tee(a)lists.trustedfirmware.org; Andrey Zhizhi=
kin
> <andrey.zhizhikin@leica-geosystems.com>
> Subject: [PATCH v3 0/2] CAAM Driver: re-factor and set proper JR status
>=20
> This V3 series covers points uncovered during the review of the previous
> series, one major point being that register readout should not be used
> for dynamic JR availability check due to its unreliability.
>=20
> Instead, JR should have a proper status set in FDT which indicates the
> availability of the ring in NS-World. This status is aligned with what
> BootROM code configures, and can be modified by all actors in the boot
> chain.
>=20
> Therefore, patch in V2 series that was handling the dynamic JR
> availability check is dropped in this series and replaced by the patch
> which sets proper DT status for JR nodes.
>=20
> Andrey Zhizhikin (2):
>   crypto: caam - convert to use capabilities
>   arm64: dts: imx8m: define proper status for caam jr
>=20
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi |   4 +
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi |   4 +
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi |   4 +
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi |   4 +
>  drivers/crypto/caam/caamalg_qi.c          |   2 +-
>  drivers/crypto/caam/ctrl.c                | 115 ++++++++++++++--------
>  drivers/crypto/caam/intern.h              |  20 ++--
>  drivers/crypto/caam/jr.c                  |  19 +++-
>  drivers/crypto/caam/regs.h                |   2 -
>  9 files changed, 122 insertions(+), 52 deletions(-)
>=20
>=20
> base-commit: 04fe99a8d936d46a310ca61b8b63dc270962bf01
> --
> 2.25.1
>=20

-- andrey

--===============8099551689591066247==--

