From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for caam jr
Date: Thu, 06 Jan 2022 12:26:30 +0100
Message-ID: <aa84249b7e099cf23b49016433b22ae541c0a41d.camel@pengutronix.de>
In-Reply-To: <20211207230206.14637-3-andrey.zhizhikin@leica-geosystems.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1951790645883460803=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1951790645883460803==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrey,

On Wed, 2021-12-08 at 00:02 +0100, Andrey Zhizhikin wrote:
> CAAM JR nodes are configured by BootROM and are used by various software
> entities during the boot process before they reach the Kernel.
>=20
> Default BootROM configuration have JR0 and JR1 reserved for S-only
> access, while JR2 is generally available for both S and NS access. HAB
> feature of i.MX8M family does require that JR0 is reserved exclusively
> in S-only world, while JR1 and JR2 are both released to NS-World. OP-TEE
> can later reclaim the JR2 via dt_enable_secure_status() call, and modify
> the DID to hold it in S-World only.
>=20
> The above setup has been discovered during review of CAAM patchset
> presented to U-Boot integration [1], and does not correspond to the
> status on jr nodes in FDT.
>=20
> This missing status settings leads to the following error message during
> jr node probing:
> [    1.509894] caam 30900000.crypto: job rings =3D 3, qi =3D 0
> [    1.525201] caam_jr 30901000.jr: failed to flush job ring 0
> [    1.525214] caam_jr: probe of 30901000.jr failed with error -5
>=20
> JR register readout after BootROM execution shows the following values:
> JR0DID_MS =3D 0x8011
> JR1DID_MS =3D 0x8011
> JR2DID_MS =3D 0x0
>=20
> This shows that JR0 and JR1 have TZ_OWN bit set, which marks them to be
> reserved for S-World, while JR2 remains accessible from NS-World.
>=20
> Provide the correct status for JR nodes in imx8m derivatives, which have
> a following meaning:
> - JR0: S-only
> - JR1: visible in both
> - JR2: NS-only
>=20
> Note, that JR2 is initially marked to be NS-only which does correspond
> to DID readout when OP-TEE is not present. Once present, OP-TEE will
> reclaim the JR2 and set both "status" and "secure-status" to claim JR2
> for S-only access.

While I can understand that you want to fix your use case for when HAB
is enabled, note that this is disabling JR0 in the none-HAB case as
well. IMO this should be handled correctly by the bootloader and/or OP-
TEE. The default upstream configuration for OP-TEE is to not use the
CAAM at runtime as well, since linux runtime PM disablement of the CAAM
will lock up OP-TEE when it tries to access the CAAM.

Kind regards,
Rouven Czerwinski

>=20
> Signed-off-by: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
> Link: [1]: https://lore.kernel.org/u-boot/AM6PR06MB4691FC905FE5658BE4B15C11=
A6609(a)AM6PR06MB4691.eurprd06.prod.outlook.com/
> ---
> Changes in V3:
> - No change, new patch introduced
>=20
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 4 ++++
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 4 ++++
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 4 ++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 4 ++++
>  4 files changed, 16 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mm.dtsi
> index 5b9c2cca9ac4..51465974c4ea 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -914,18 +914,22 @@ sec_jr0: jr(a)1000 {
>  					compatible =3D "fsl,sec-v4.0-job-ring";
>  					reg =3D <0x1000 0x1000>;
>  					interrupts =3D <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> +					status =3D "disabled";
> +					secure-status =3D "okay";
>  				};
> =20
>  				sec_jr1: jr(a)2000 {
>  					compatible =3D "fsl,sec-v4.0-job-ring";
>  					reg =3D <0x2000 0x1000>;
>  					interrupts =3D <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> +					secure-status =3D "okay";
>  				};
> =20
>  				sec_jr2: jr(a)3000 {
>  					compatible =3D "fsl,sec-v4.0-job-ring";
>  					reg =3D <0x3000 0x1000>;
>  					interrupts =3D <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
> +					secure-status =3D "disabled";
>  				};
>  			};
> =20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mn.dtsi
> index ba23b416b5e6..e5edf14319b1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -808,18 +808,22 @@ sec_jr0: jr(a)1000 {
>  					 compatible =3D "fsl,sec-v4.0-job-ring";
>  					 reg =3D <0x1000 0x1000>;
>  					 interrupts =3D <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> +					 status =3D "disabled";
> +					 secure-status =3D "okay";
>  				};
> =20
>  				sec_jr1: jr(a)2000 {
>  					 compatible =3D "fsl,sec-v4.0-job-ring";
>  					 reg =3D <0x2000 0x1000>;
>  					 interrupts =3D <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> +					 secure-status =3D "okay";
>  				};
> =20
>  				sec_jr2: jr(a)3000 {
>  					 compatible =3D "fsl,sec-v4.0-job-ring";
>  					 reg =3D <0x3000 0x1000>;
>  					 interrupts =3D <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
> +					 secure-status =3D "disabled";
>  				};
>  			};
> =20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mp.dtsi
> index 977783784342..3c23bf5c3910 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -661,18 +661,22 @@ sec_jr0: jr(a)1000 {
>  					compatible =3D "fsl,sec-v4.0-job-ring";
>  					reg =3D <0x1000 0x1000>;
>  					interrupts =3D <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> +					status =3D "disabled";
> +					secure-status =3D "okay";
>  				};
> =20
>  				sec_jr1: jr(a)2000 {
>  					compatible =3D "fsl,sec-v4.0-job-ring";
>  					reg =3D <0x2000 0x1000>;
>  					interrupts =3D <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> +					secure-status =3D "okay";
>  				};
> =20
>  				sec_jr2: jr(a)3000 {
>  					compatible =3D "fsl,sec-v4.0-job-ring";
>  					reg =3D <0x3000 0x1000>;
>  					interrupts =3D <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
> +					secure-status =3D "disabled";
>  				};
>  			};
> =20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
> index 95d8b95d6120..16c4c9110ce7 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -999,18 +999,22 @@ sec_jr0: jr(a)1000 {
>  					compatible =3D "fsl,sec-v4.0-job-ring";
>  					reg =3D <0x1000 0x1000>;
>  					interrupts =3D <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> +					status =3D "disabled";
> +					secure-status =3D "okay";
>  				};
> =20
>  				sec_jr1: jr(a)2000 {
>  					compatible =3D "fsl,sec-v4.0-job-ring";
>  					reg =3D <0x2000 0x1000>;
>  					interrupts =3D <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> +					secure-status =3D "okay";
>  				};
> =20
>  				sec_jr2: jr(a)3000 {
>  					compatible =3D "fsl,sec-v4.0-job-ring";
>  					reg =3D <0x3000 0x1000>;
>  					interrupts =3D <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
> +					secure-status =3D "disabled";
>  				};
>  			};
> =20

--=20
Pengutronix e.K.           | Rouven Czerwinski          |
Steuerwalder Str. 21       | http://www.pengutronix.de/ |
31137 Hildesheim, Germany  | Phone: +49-5121-206917-0   |


--===============1951790645883460803==--

