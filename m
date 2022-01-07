From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for caam jr
Date: Fri, 07 Jan 2022 10:46:10 +0100
Message-ID: <30312d09effae6b78309723a7261f85915b8d5b8.camel@pengutronix.de>
In-Reply-To: <=?utf-8?q?=3CAM6PR06MB469100A5D7A069AF84A83EEFA64C9=40AM6PR06MB?=
 =?utf-8?q?4691=2Eeurprd06=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1592657480583878229=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1592657480583878229==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2022-01-06 at 14:08 +0000, ZHIZHIKIN Andrey wrote:
> Hello Rouven,
>=20
> > -----Original Message-----
> > From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> > Sent: Thursday, January 6, 2022 12:27 PM
> > To: ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>; linux-
> > kernel(a)vger.kernel.org
> > Cc: peng.fan(a)nxp.com; ping.bai(a)nxp.com; alice.guo(a)nxp.com; agx(a)si=
gxcpu.org;
> > frieder.schrempf(a)kontron.de; leonard.crestez(a)nxp.com; festevam(a)gmai=
l.com;
> > marex(a)denx.de; herbert(a)gondor.apana.org.au; horia.geanta(a)nxp.com;
> > aford173(a)gmail.com; krzk(a)kernel.org; linux-imx(a)nxp.com;
> > devicetree(a)vger.kernel.org; hongxing.zhu(a)nxp.com; s.hauer(a)pengutron=
ix.de;
> > pankaj.gupta(a)nxp.com; robh+dt(a)kernel.org; thunder.leizhen(a)huawei.co=
m;
> > martink(a)posteo.de; daniel.baluta(a)nxp.com; linux-arm-kernel(a)lists.in=
fradead.org;
> > gregkh(a)linuxfoundation.org; shengjiu.wang(a)nxp.com; qiangqing.zhang(a)=
nxp.com;
> > michael(a)walle.cc; op-tee(a)lists.trustedfirmware.org; linux-crypto(a)vg=
er.kernel.org;
> > kernel(a)pengutronix.de; jun.li(a)nxp.com; shawnguo(a)kernel.org; davem(a=
)davemloft.net;
> > l.stach(a)pengutronix.de
> > Subject: Re: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for c=
aam jr
> >=20
> > Hi Andrey,
> >=20
> > On Wed, 2021-12-08 at 00:02 +0100, Andrey Zhizhikin wrote:
> > > CAAM JR nodes are configured by BootROM and are used by various software
> > > entities during the boot process before they reach the Kernel.
> > >=20
> > > Default BootROM configuration have JR0 and JR1 reserved for S-only
> > > access, while JR2 is generally available for both S and NS access. HAB
> > > feature of i.MX8M family does require that JR0 is reserved exclusively
> > > in S-only world, while JR1 and JR2 are both released to NS-World. OP-TEE
> > > can later reclaim the JR2 via dt_enable_secure_status() call, and modify
> > > the DID to hold it in S-World only.
> > >=20
> > > The above setup has been discovered during review of CAAM patchset
> > > presented to U-Boot integration [1], and does not correspond to the
> > > status on jr nodes in FDT.
> > >=20
> > > This missing status settings leads to the following error message during
> > > jr node probing:
> > > [    1.509894] caam 30900000.crypto: job rings =3D 3, qi =3D 0
> > > [    1.525201] caam_jr 30901000.jr: failed to flush job ring 0
> > > [    1.525214] caam_jr: probe of 30901000.jr failed with error -5
> > >=20
> > > JR register readout after BootROM execution shows the following values:
> > > JR0DID_MS =3D 0x8011
> > > JR1DID_MS =3D 0x8011
> > > JR2DID_MS =3D 0x0
> > >=20
> > > This shows that JR0 and JR1 have TZ_OWN bit set, which marks them to be
> > > reserved for S-World, while JR2 remains accessible from NS-World.
> > >=20
> > > Provide the correct status for JR nodes in imx8m derivatives, which have
> > > a following meaning:
> > > - JR0: S-only
> > > - JR1: visible in both
> > > - JR2: NS-only
> > >=20
> > > Note, that JR2 is initially marked to be NS-only which does correspond
> > > to DID readout when OP-TEE is not present. Once present, OP-TEE will
> > > reclaim the JR2 and set both "status" and "secure-status" to claim JR2
> > > for S-only access.
> >=20
> > While I can understand that you want to fix your use case for when HAB
> > is enabled, note that this is disabling JR0 in the none-HAB case as
> > well.
>=20
> This is not totally correct, as this patch does address the reservation of
> JR0 by BootROM in both HAB and non-HAB configurations. My current setup does
> not include HAB functionality enabled, and I still do observe boot errors
> that are listed in commit message. This is due to the fact that the BootROM
> does not release JR0 to NS-World regardless of whether HAB is enabled or no=
t.
> This has been discussed in the U-Boot thread I provided the link in the pat=
ch.
>=20
> This patch does rather bring the correct HW module description as seeing
> from Linux.=20

I took a look into i.MX8MQ, the bootrom indeed sets 0x8011 for JR0 &
JR1:
JR0:0000000000008011
JR1:0000000000008011
JR2:0000000000000000
TF-A
>CAAM
JR0:0000000000000001
JR1:0000000000000001
JR2:0000000000000001

However at least the upstream TF-A reconfigures the DIDs to 1 for all
i.MX8M* derivates.  So while it is technically correct to change the DT
values as you describe, the downstream TF-A and upstream TF-A seem to
differ in their configuration. I also think it's a bad move to hardcode
the JR configuration to the boot ROM config, since AFAIK i.MX8M* can
not be run without TF-A. And IMO the upstream kernel should follow what
the upstream TF-A does in this case.

>=20
> > IMO this should be handled correctly by the bootloader and/or OP-
> > TEE. The default upstream configuration for OP-TEE is to not use the
> > CAAM at runtime as well, since linux runtime PM disablement of the CAAM
> > will lock up OP-TEE when it tries to access the CAAM.
>=20
> If by handling you mean releasing JR0 reservation - then yes, it should be
> done by either SPL or TF-A as they do run in S World. In such a case, DTB
> bindings need to be adapted further according to the new state. Until this
> done - this patch does provide a correct state of HW to the Kernel.

Upstream TF-A simply releases all JRs to the normal world, matching the
current DTB description.

Kind Regards,
Rouven Czerwinski


> >=20
> > Kind regards,
> > Rouven Czerwinski
> >=20
> > >=20
> > > Signed-off-by: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.co=
m>
> > > Link: [1]: https://lore.kernel.org/u-boot/AM6PR06MB4691FC905FE5658BE4B1=
5C11A6609(a)AM6PR06MB4691.eurprd06.prod.outlook.com/
> > > ---
> > > Changes in V3:
> > > - No change, new patch introduced
> > >=20
> > >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 4 ++++
> > >  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 4 ++++
> > >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 4 ++++
> > >  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 4 ++++
> > >  4 files changed, 16 insertions(+)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > index 5b9c2cca9ac4..51465974c4ea 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > @@ -914,18 +914,22 @@ sec_jr0: jr(a)1000 {
> > >                                       compatible =3D "fsl,sec-v4.0-job-=
ring";
> > >                                       reg =3D <0x1000 0x1000>;
> > >                                       interrupts =3D <GIC_SPI 105
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                     status =3D "disabled";
> > > +                                     secure-status =3D "okay";
> > >                               };
> > >=20
> > >                               sec_jr1: jr(a)2000 {
> > >                                       compatible =3D "fsl,sec-v4.0-job-=
ring";
> > >                                       reg =3D <0x2000 0x1000>;
> > >                                       interrupts =3D <GIC_SPI 106
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                     secure-status =3D "okay";
> > >                               };
> > >=20
> > >                               sec_jr2: jr(a)3000 {
> > >                                       compatible =3D "fsl,sec-v4.0-job-=
ring";
> > >                                       reg =3D <0x3000 0x1000>;
> > >                                       interrupts =3D <GIC_SPI 114
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                     secure-status =3D "disabled";
> > >                               };
> > >                       };
> > >=20
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > index ba23b416b5e6..e5edf14319b1 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > @@ -808,18 +808,22 @@ sec_jr0: jr(a)1000 {
> > >                                        compatible =3D "fsl,sec-v4.0-job=
-ring";
> > >                                        reg =3D <0x1000 0x1000>;
> > >                                        interrupts =3D <GIC_SPI 105
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                      status =3D "disabled";
> > > +                                      secure-status =3D "okay";
> > >                               };
> > >=20
> > >                               sec_jr1: jr(a)2000 {
> > >                                        compatible =3D "fsl,sec-v4.0-job=
-ring";
> > >                                        reg =3D <0x2000 0x1000>;
> > >                                        interrupts =3D <GIC_SPI 106
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                      secure-status =3D "okay";
> > >                               };
> > >=20
> > >                               sec_jr2: jr(a)3000 {
> > >                                        compatible =3D "fsl,sec-v4.0-job=
-ring";
> > >                                        reg =3D <0x3000 0x1000>;
> > >                                        interrupts =3D <GIC_SPI 114
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                      secure-status =3D "disabled";
> > >                               };
> > >                       };
> > >=20
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > index 977783784342..3c23bf5c3910 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > @@ -661,18 +661,22 @@ sec_jr0: jr(a)1000 {
> > >                                       compatible =3D "fsl,sec-v4.0-job-=
ring";
> > >                                       reg =3D <0x1000 0x1000>;
> > >                                       interrupts =3D <GIC_SPI 105
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                     status =3D "disabled";
> > > +                                     secure-status =3D "okay";
> > >                               };
> > >=20
> > >                               sec_jr1: jr(a)2000 {
> > >                                       compatible =3D "fsl,sec-v4.0-job-=
ring";
> > >                                       reg =3D <0x2000 0x1000>;
> > >                                       interrupts =3D <GIC_SPI 106
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                     secure-status =3D "okay";
> > >                               };
> > >=20
> > >                               sec_jr2: jr(a)3000 {
> > >                                       compatible =3D "fsl,sec-v4.0-job-=
ring";
> > >                                       reg =3D <0x3000 0x1000>;
> > >                                       interrupts =3D <GIC_SPI 114
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                     secure-status =3D "disabled";
> > >                               };
> > >                       };
> > >=20
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > index 95d8b95d6120..16c4c9110ce7 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > @@ -999,18 +999,22 @@ sec_jr0: jr(a)1000 {
> > >                                       compatible =3D "fsl,sec-v4.0-job-=
ring";
> > >                                       reg =3D <0x1000 0x1000>;
> > >                                       interrupts =3D <GIC_SPI 105
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                     status =3D "disabled";
> > > +                                     secure-status =3D "okay";
> > >                               };
> > >=20
> > >                               sec_jr1: jr(a)2000 {
> > >                                       compatible =3D "fsl,sec-v4.0-job-=
ring";
> > >                                       reg =3D <0x2000 0x1000>;
> > >                                       interrupts =3D <GIC_SPI 106
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                     secure-status =3D "okay";
> > >                               };
> > >=20
> > >                               sec_jr2: jr(a)3000 {
> > >                                       compatible =3D "fsl,sec-v4.0-job-=
ring";
> > >                                       reg =3D <0x3000 0x1000>;
> > >                                       interrupts =3D <GIC_SPI 114
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +                                     secure-status =3D "disabled";
> > >                               };
> > >                       };
> > >=20
> >=20
> > --
> > Pengutronix e.K.           | Rouven Czerwinski          |
> > Steuerwalder Str. 21       | http://www.pengutronix.de/ |
> > 31137 Hildesheim, Germany  | Phone: +49-5121-206917-0   |
>=20
>=20
> -- andrey

--=20
Pengutronix e.K.           | Rouven Czerwinski          |
Steuerwalder Str. 21       | http://www.pengutronix.de/ |
31137 Hildesheim, Germany  | Phone: +49-5121-206917-0   |


--===============1592657480583878229==--

