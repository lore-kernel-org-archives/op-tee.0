From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for caam jr
Date: Fri, 07 Jan 2022 12:55:34 +0100
Message-ID: <b5e37dc573f9cefc83f73f1113a632a29ba9a833.camel@pengutronix.de>
In-Reply-To: <=?utf-8?q?=3CAM6PR06MB46919E01996D1F1DE326306DA64D9=40AM6PR06MB?=
 =?utf-8?q?4691=2Eeurprd06=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4857124181855319593=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4857124181855319593==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-01-07 at 10:40 +0000, ZHIZHIKIN Andrey wrote:
> Hello Rouven,
>=20
> > -----Original Message-----
> > From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> > Sent: Friday, January 7, 2022 10:46 AM
> > To: ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>; linux-
> > kernel(a)vger.kernel.org
> > Cc: peng.fan(a)nxp.com; ping.bai(a)nxp.com; alice.guo(a)nxp.com; agx(a)si=
gxcpu.org;
> > krzk(a)kernel.org; leonard.crestez(a)nxp.com; festevam(a)gmail.com; marex=
(a)denx.de;
> > herbert(a)gondor.apana.org.au; horia.geanta(a)nxp.com; daniel.baluta(a)nx=
p.com;
> > frieder.schrempf(a)kontron.de; linux-imx(a)nxp.com; devicetree(a)vger.ker=
nel.org;
> > hongxing.zhu(a)nxp.com; s.hauer(a)pengutronix.de; pankaj.gupta(a)nxp.com;
> > robh+dt(a)kernel.org; thunder.leizhen(a)huawei.com; martink(a)posteo.de;
> > aford173(a)gmail.com; linux-arm-kernel(a)lists.infradead.org;
> > gregkh(a)linuxfoundation.org; shengjiu.wang(a)nxp.com; qiangqing.zhang(a)=
nxp.com;
> > michael(a)walle.cc; op-tee(a)lists.trustedfirmware.org; linux-crypto(a)vg=
er.kernel.org;
> > kernel(a)pengutronix.de; l.stach(a)pengutronix.de; shawnguo(a)kernel.org;
> > davem(a)davemloft.net; jun.li(a)nxp.com
> > Subject: Re: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for c=
aam jr
> >=20
> >=20
> > On Thu, 2022-01-06 at 14:08 +0000, ZHIZHIKIN Andrey wrote:
> > > Hello Rouven,
> > >=20
> > > > -----Original Message-----
> > > > From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> > > > Sent: Thursday, January 6, 2022 12:27 PM
> > > > To: ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>; linux-
> > > > kernel(a)vger.kernel.org
> > > > Cc: peng.fan(a)nxp.com; ping.bai(a)nxp.com; alice.guo(a)nxp.com; agx(=
a)sigxcpu.org;
> > > > frieder.schrempf(a)kontron.de; leonard.crestez(a)nxp.com; festevam(a)=
gmail.com;
> > > > marex(a)denx.de; herbert(a)gondor.apana.org.au; horia.geanta(a)nxp.co=
m;
> > > > aford173(a)gmail.com; krzk(a)kernel.org; linux-imx(a)nxp.com;
> > > > devicetree(a)vger.kernel.org; hongxing.zhu(a)nxp.com; s.hauer(a)pengu=
tronix.de;
> > > > pankaj.gupta(a)nxp.com; robh+dt(a)kernel.org; thunder.leizhen(a)huawe=
i.com;
> > > > martink(a)posteo.de; daniel.baluta(a)nxp.com; linux-arm-
> > kernel(a)lists.infradead.org;
> > > > gregkh(a)linuxfoundation.org; shengjiu.wang(a)nxp.com; qiangqing.zhan=
g(a)nxp.com;
> > > > michael(a)walle.cc; op-tee(a)lists.trustedfirmware.org; linux-
> > crypto(a)vger.kernel.org;
> > > > kernel(a)pengutronix.de; jun.li(a)nxp.com; shawnguo(a)kernel.org;
> > davem(a)davemloft.net;
> > > > l.stach(a)pengutronix.de
> > > > Subject: Re: [PATCH v3 2/2] arm64: dts: imx8m: define proper status f=
or caam
> > jr
> > > >=20
> > > > Hi Andrey,
> > > >=20
> > > > On Wed, 2021-12-08 at 00:02 +0100, Andrey Zhizhikin wrote:
> > > > > CAAM JR nodes are configured by BootROM and are used by various sof=
tware
> > > > > entities during the boot process before they reach the Kernel.
> > > > >=20
> > > > > Default BootROM configuration have JR0 and JR1 reserved for S-only
> > > > > access, while JR2 is generally available for both S and NS access. =
HAB
> > > > > feature of i.MX8M family does require that JR0 is reserved exclusiv=
ely
> > > > > in S-only world, while JR1 and JR2 are both released to NS-World. O=
P-TEE
> > > > > can later reclaim the JR2 via dt_enable_secure_status() call, and m=
odify
> > > > > the DID to hold it in S-World only.
> > > > >=20
> > > > > The above setup has been discovered during review of CAAM patchset
> > > > > presented to U-Boot integration [1], and does not correspond to the
> > > > > status on jr nodes in FDT.
> > > > >=20
> > > > > This missing status settings leads to the following error message d=
uring
> > > > > jr node probing:
> > > > > [    1.509894] caam 30900000.crypto: job rings =3D 3, qi =3D 0
> > > > > [    1.525201] caam_jr 30901000.jr: failed to flush job ring 0
> > > > > [    1.525214] caam_jr: probe of 30901000.jr failed with error -5
> > > > >=20
> > > > > JR register readout after BootROM execution shows the following val=
ues:
> > > > > JR0DID_MS =3D 0x8011
> > > > > JR1DID_MS =3D 0x8011
> > > > > JR2DID_MS =3D 0x0
> > > > >=20
> > > > > This shows that JR0 and JR1 have TZ_OWN bit set, which marks them t=
o be
> > > > > reserved for S-World, while JR2 remains accessible from NS-World.
> > > > >=20
> > > > > Provide the correct status for JR nodes in imx8m derivatives, which=
 have
> > > > > a following meaning:
> > > > > - JR0: S-only
> > > > > - JR1: visible in both
> > > > > - JR2: NS-only
> > > > >=20
> > > > > Note, that JR2 is initially marked to be NS-only which does corresp=
ond
> > > > > to DID readout when OP-TEE is not present. Once present, OP-TEE will
> > > > > reclaim the JR2 and set both "status" and "secure-status" to claim =
JR2
> > > > > for S-only access.
> > > >=20
> > > > While I can understand that you want to fix your use case for when HAB
> > > > is enabled, note that this is disabling JR0 in the none-HAB case as
> > > > well.
> > >=20
> > > This is not totally correct, as this patch does address the reservation=
 of
> > > JR0 by BootROM in both HAB and non-HAB configurations. My current setup=
 does
> > > not include HAB functionality enabled, and I still do observe boot erro=
rs
> > > that are listed in commit message. This is due to the fact that the Boo=
tROM
> > > does not release JR0 to NS-World regardless of whether HAB is enabled o=
r not.
> > > This has been discussed in the U-Boot thread I provided the link in the=
 patch.
> > >=20
> > > This patch does rather bring the correct HW module description as seeing
> > > from Linux.
> >=20
> > I took a look into i.MX8MQ, the bootrom indeed sets 0x8011 for JR0 &
> > JR1:
> > JR0:0000000000008011
> > JR1:0000000000008011
> > JR2:0000000000000000
> > TF-A
> > > CAAM
> > JR0:0000000000000001
> > JR1:0000000000000001
> > JR2:0000000000000001
> >=20
> > However at least the upstream TF-A reconfigures the DIDs to 1 for all
> > i.MX8M* derivates.  So while it is technically correct to change the DT
> > values as you describe, the downstream TF-A and upstream TF-A seem to
> > differ in their configuration. I also think it's a bad move to hardcode
> > the JR configuration to the boot ROM config, since AFAIK i.MX8M* can
> > not be run without TF-A. And IMO the upstream kernel should follow what
> > the upstream TF-A does in this case.
>=20
> This is indeed an interesting piece of information, thanks a lot!
>=20
> From what I understood in previous discussions for this series here in
> the Kernel, and on U-Boot ML: JR0 is required to be held reserved in
> S-World for HAB to operate, and this is clearly communicated by NXP in [1].
> If my understanding is correct, then upstream TF-A either does not support
> or breaks the HAB feature.

Yes, upstream TF-A does not implement the NXP specific SIPs to
communicate with the ROM code to do further image authentication.
Thats also the reason why all JRs are released to normal world, there
is no possible HAB use after TF-A has started.

> I've been following the build documentation in U-Boot, where the downstream
> TF-A is listed as build prequisites [2] without any mentioning of upstream,
> hence I received a readout that matched the BootROM "1-to-1".

Yes, since the downstream TF-A is required to authenticate further
images.

Aside from this the bootrom HAB interface on i.MX8MQ was broken in
interesting ways, I had to implement parsing of the HAB status SRAM
area by hand within barebox.

> I believe that if the information from NXP regarding JR0 reservation for
> HAB is correct (and I have no reasons to doubt it), then upstream TF-A
> should be adapted in order for HAB feature to work, and in that case this
> patch brings correct HW state description as seeing from Linux.

JR0 for HAB in S-World makes sense to me, otherwise the bootrom will
probably refuse to work with the JR.

> And in contrary, if the upstream TF-A is not adjusted to include HAB
> support - then applying this patch would effectively just "remove" one
> JR device, still keeping 2 additional available nodes for HW crypto
> operations in Kernel, with added benefit that both upstream and
> downstream TF-A can be used during the boot without seeing issues later
> in the Kernel.

Even with the downstream TF-A there is no reason to keep JR0 asigned to
the secure world, unless you are running OP-TEE. JR0 assignement for
HAB shouldn't be required after the bootloader has run, unless you want
to HAB authenticate images from a running Linux kernel.

The reason NXP hardcodes the configuration downstream is of course to
support HAB & OP-TEE, but this is still not a reason to hardcode this
assignement into the kernel device tree. They probably also hardcode it
in their downstream kernel versions.

I can understand that it seems easier to hardcode this in the kernel,
but as I said before, if you are running OP-TEE you need to adjust the
DT anyway since nodes need to be added and you might as well adjust the
jobring configuration than.

Kind regards,
Rouven

>=20
> >=20
> > >=20
> > > > IMO this should be handled correctly by the bootloader and/or OP-
> > > > TEE. The default upstream configuration for OP-TEE is to not use the
> > > > CAAM at runtime as well, since linux runtime PM disablement of the CA=
AM
> > > > will lock up OP-TEE when it tries to access the CAAM.
> > >=20
> > > If by handling you mean releasing JR0 reservation - then yes, it should=
 be
> > > done by either SPL or TF-A as they do run in S World. In such a case, D=
TB
> > > bindings need to be adapted further according to the new state. Until t=
his
> > > done - this patch does provide a correct state of HW to the Kernel.
> >=20
> > Upstream TF-A simply releases all JRs to the normal world, matching the
> > current DTB description.
> >=20
> > Kind Regards,
> > Rouven Czerwinski
> >=20
> >=20
> [snip]
>=20
> Regards,
> Andrey
>=20
> Link: [1]: https://lore.kernel.org/u-boot/VI1PR04MB5342C8C6E651EC2CC4477EB5=
E79A9(a)VI1PR04MB5342.eurprd04.prod.outlook.com/
> Link: [2]: https://source.denx.de/u-boot/u-boot/-/blob/master/doc/board/nxp=
/imx8mm_evk.rst

--=20
Pengutronix e.K.           | Rouven Czerwinski          |
Steuerwalder Str. 21       | http://www.pengutronix.de/ |
31137 Hildesheim, Germany  | Phone: +49-5121-206917-0   |


--===============4857124181855319593==--

