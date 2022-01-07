From: ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 RE: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for caam jr
Date: Fri, 07 Jan 2022 10:40:16 +0000
Message-ID: <AM6PR06MB46919E01996D1F1DE326306DA64D9@AM6PR06MB4691.eurprd06.prod.outlook.com>
In-Reply-To: <30312d09effae6b78309723a7261f85915b8d5b8.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1821700215862812733=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1821700215862812733==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Rouven,

> -----Original Message-----
> From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> Sent: Friday, January 7, 2022 10:46 AM
> To: ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>; linux-
> kernel(a)vger.kernel.org
> Cc: peng.fan(a)nxp.com; ping.bai(a)nxp.com; alice.guo(a)nxp.com; agx(a)sigx=
cpu.org;
> krzk(a)kernel.org; leonard.crestez(a)nxp.com; festevam(a)gmail.com; marex(a=
)denx.de;
> herbert(a)gondor.apana.org.au; horia.geanta(a)nxp.com; daniel.baluta(a)nxp.=
com;
> frieder.schrempf(a)kontron.de; linux-imx(a)nxp.com; devicetree(a)vger.kerne=
l.org;
> hongxing.zhu(a)nxp.com; s.hauer(a)pengutronix.de; pankaj.gupta(a)nxp.com;
> robh+dt(a)kernel.org; thunder.leizhen(a)huawei.com; martink(a)posteo.de;
> aford173(a)gmail.com; linux-arm-kernel(a)lists.infradead.org;
> gregkh(a)linuxfoundation.org; shengjiu.wang(a)nxp.com; qiangqing.zhang(a)nx=
p.com;
> michael(a)walle.cc; op-tee(a)lists.trustedfirmware.org; linux-crypto(a)vger=
.kernel.org;
> kernel(a)pengutronix.de; l.stach(a)pengutronix.de; shawnguo(a)kernel.org;
> davem(a)davemloft.net; jun.li(a)nxp.com
> Subject: Re: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for caa=
m jr
>=20
>=20
> On Thu, 2022-01-06 at 14:08 +0000, ZHIZHIKIN Andrey wrote:
> > Hello Rouven,
> >
> > > -----Original Message-----
> > > From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> > > Sent: Thursday, January 6, 2022 12:27 PM
> > > To: ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>; linux-
> > > kernel(a)vger.kernel.org
> > > Cc: peng.fan(a)nxp.com; ping.bai(a)nxp.com; alice.guo(a)nxp.com; agx(a)=
sigxcpu.org;
> > > frieder.schrempf(a)kontron.de; leonard.crestez(a)nxp.com; festevam(a)gm=
ail.com;
> > > marex(a)denx.de; herbert(a)gondor.apana.org.au; horia.geanta(a)nxp.com;
> > > aford173(a)gmail.com; krzk(a)kernel.org; linux-imx(a)nxp.com;
> > > devicetree(a)vger.kernel.org; hongxing.zhu(a)nxp.com; s.hauer(a)pengutr=
onix.de;
> > > pankaj.gupta(a)nxp.com; robh+dt(a)kernel.org; thunder.leizhen(a)huawei.=
com;
> > > martink(a)posteo.de; daniel.baluta(a)nxp.com; linux-arm-
> kernel(a)lists.infradead.org;
> > > gregkh(a)linuxfoundation.org; shengjiu.wang(a)nxp.com; qiangqing.zhang(=
a)nxp.com;
> > > michael(a)walle.cc; op-tee(a)lists.trustedfirmware.org; linux-
> crypto(a)vger.kernel.org;
> > > kernel(a)pengutronix.de; jun.li(a)nxp.com; shawnguo(a)kernel.org;
> davem(a)davemloft.net;
> > > l.stach(a)pengutronix.de
> > > Subject: Re: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for=
 caam
> jr
> > >
> > > Hi Andrey,
> > >
> > > On Wed, 2021-12-08 at 00:02 +0100, Andrey Zhizhikin wrote:
> > > > CAAM JR nodes are configured by BootROM and are used by various softw=
are
> > > > entities during the boot process before they reach the Kernel.
> > > >
> > > > Default BootROM configuration have JR0 and JR1 reserved for S-only
> > > > access, while JR2 is generally available for both S and NS access. HAB
> > > > feature of i.MX8M family does require that JR0 is reserved exclusively
> > > > in S-only world, while JR1 and JR2 are both released to NS-World. OP-=
TEE
> > > > can later reclaim the JR2 via dt_enable_secure_status() call, and mod=
ify
> > > > the DID to hold it in S-World only.
> > > >
> > > > The above setup has been discovered during review of CAAM patchset
> > > > presented to U-Boot integration [1], and does not correspond to the
> > > > status on jr nodes in FDT.
> > > >
> > > > This missing status settings leads to the following error message dur=
ing
> > > > jr node probing:
> > > > [    1.509894] caam 30900000.crypto: job rings =3D 3, qi =3D 0
> > > > [    1.525201] caam_jr 30901000.jr: failed to flush job ring 0
> > > > [    1.525214] caam_jr: probe of 30901000.jr failed with error -5
> > > >
> > > > JR register readout after BootROM execution shows the following value=
s:
> > > > JR0DID_MS =3D 0x8011
> > > > JR1DID_MS =3D 0x8011
> > > > JR2DID_MS =3D 0x0
> > > >
> > > > This shows that JR0 and JR1 have TZ_OWN bit set, which marks them to =
be
> > > > reserved for S-World, while JR2 remains accessible from NS-World.
> > > >
> > > > Provide the correct status for JR nodes in imx8m derivatives, which h=
ave
> > > > a following meaning:
> > > > - JR0: S-only
> > > > - JR1: visible in both
> > > > - JR2: NS-only
> > > >
> > > > Note, that JR2 is initially marked to be NS-only which does correspond
> > > > to DID readout when OP-TEE is not present. Once present, OP-TEE will
> > > > reclaim the JR2 and set both "status" and "secure-status" to claim JR2
> > > > for S-only access.
> > >
> > > While I can understand that you want to fix your use case for when HAB
> > > is enabled, note that this is disabling JR0 in the none-HAB case as
> > > well.
> >
> > This is not totally correct, as this patch does address the reservation of
> > JR0 by BootROM in both HAB and non-HAB configurations. My current setup d=
oes
> > not include HAB functionality enabled, and I still do observe boot errors
> > that are listed in commit message. This is due to the fact that the BootR=
OM
> > does not release JR0 to NS-World regardless of whether HAB is enabled or =
not.
> > This has been discussed in the U-Boot thread I provided the link in the p=
atch.
> >
> > This patch does rather bring the correct HW module description as seeing
> > from Linux.
>=20
> I took a look into i.MX8MQ, the bootrom indeed sets 0x8011 for JR0 &
> JR1:
> JR0:0000000000008011
> JR1:0000000000008011
> JR2:0000000000000000
> TF-A
> >CAAM
> JR0:0000000000000001
> JR1:0000000000000001
> JR2:0000000000000001
>=20
> However at least the upstream TF-A reconfigures the DIDs to 1 for all
> i.MX8M* derivates.  So while it is technically correct to change the DT
> values as you describe, the downstream TF-A and upstream TF-A seem to
> differ in their configuration. I also think it's a bad move to hardcode
> the JR configuration to the boot ROM config, since AFAIK i.MX8M* can
> not be run without TF-A. And IMO the upstream kernel should follow what
> the upstream TF-A does in this case.

This is indeed an interesting piece of information, thanks a lot!

From what I understood in previous discussions for this series here in
the Kernel, and on U-Boot ML: JR0 is required to be held reserved in
S-World for HAB to operate, and this is clearly communicated by NXP in [1].
If my understanding is correct, then upstream TF-A either does not support
or breaks the HAB feature.

I've been following the build documentation in U-Boot, where the downstream
TF-A is listed as build prequisites [2] without any mentioning of upstream,
hence I received a readout that matched the BootROM "1-to-1".

I believe that if the information from NXP regarding JR0 reservation for
HAB is correct (and I have no reasons to doubt it), then upstream TF-A
should be adapted in order for HAB feature to work, and in that case this
patch brings correct HW state description as seeing from Linux.

And in contrary, if the upstream TF-A is not adjusted to include HAB
support - then applying this patch would effectively just "remove" one
JR device, still keeping 2 additional available nodes for HW crypto
operations in Kernel, with added benefit that both upstream and
downstream TF-A can be used during the boot without seeing issues later
in the Kernel.

>=20
> >
> > > IMO this should be handled correctly by the bootloader and/or OP-
> > > TEE. The default upstream configuration for OP-TEE is to not use the
> > > CAAM at runtime as well, since linux runtime PM disablement of the CAAM
> > > will lock up OP-TEE when it tries to access the CAAM.
> >
> > If by handling you mean releasing JR0 reservation - then yes, it should be
> > done by either SPL or TF-A as they do run in S World. In such a case, DTB
> > bindings need to be adapted further according to the new state. Until this
> > done - this patch does provide a correct state of HW to the Kernel.
>=20
> Upstream TF-A simply releases all JRs to the normal world, matching the
> current DTB description.
>=20
> Kind Regards,
> Rouven Czerwinski
>=20
>=20
[snip]

Regards,
Andrey

Link: [1]: https://lore.kernel.org/u-boot/VI1PR04MB5342C8C6E651EC2CC4477EB5E7=
9A9(a)VI1PR04MB5342.eurprd04.prod.outlook.com/
Link: [2]: https://source.denx.de/u-boot/u-boot/-/blob/master/doc/board/nxp/i=
mx8mm_evk.rst

--===============1821700215862812733==--

