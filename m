From: ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 RE: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for caam jr
Date: Sat, 08 Jan 2022 20:48:03 +0000
Message-ID: <AM6PR06MB4691D4FCA4D82284E70A9F53A64E9@AM6PR06MB4691.eurprd06.prod.outlook.com>
In-Reply-To: <b5e37dc573f9cefc83f73f1113a632a29ba9a833.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8040885445894105232=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8040885445894105232==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Rouven,

> -----Original Message-----
> From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> Sent: Friday, January 7, 2022 12:56 PM

[snip]

>=20
> Yes, upstream TF-A does not implement the NXP specific SIPs to
> communicate with the ROM code to do further image authentication.
> Thats also the reason why all JRs are released to normal world, there
> is no possible HAB use after TF-A has started.
>=20
> > I've been following the build documentation in U-Boot, where the downstre=
am
> > TF-A is listed as build prequisites [2] without any mentioning of upstrea=
m,
> > hence I received a readout that matched the BootROM "1-to-1".
>=20
> Yes, since the downstream TF-A is required to authenticate further
> images.
>=20
> Aside from this the bootrom HAB interface on i.MX8MQ was broken in
> interesting ways, I had to implement parsing of the HAB status SRAM
> area by hand within barebox.
>=20
> > I believe that if the information from NXP regarding JR0 reservation for
> > HAB is correct (and I have no reasons to doubt it), then upstream TF-A
> > should be adapted in order for HAB feature to work, and in that case this
> > patch brings correct HW state description as seeing from Linux.
>=20
> JR0 for HAB in S-World makes sense to me, otherwise the bootrom will
> probably refuse to work with the JR.
>=20
> > And in contrary, if the upstream TF-A is not adjusted to include HAB
> > support - then applying this patch would effectively just "remove" one
> > JR device, still keeping 2 additional available nodes for HW crypto
> > operations in Kernel, with added benefit that both upstream and
> > downstream TF-A can be used during the boot without seeing issues later
> > in the Kernel.
>=20
> Even with the downstream TF-A there is no reason to keep JR0 asigned to
> the secure world, unless you are running OP-TEE. JR0 assignement for
> HAB shouldn't be required after the bootloader has run, unless you want
> to HAB authenticate images from a running Linux kernel.

Then this probably should be communicated in U-Boot as there is a
patchset proposed in U-Boot, and one of the patches in that series [1]
disabled JR0 as well. Once merged - the JR0 is not going to be available
for Linux, regardless of the fact that TF-A would set DIDs to 0x1.

>=20
> The reason NXP hardcodes the configuration downstream is of course to
> support HAB & OP-TEE, but this is still not a reason to hardcode this
> assignement into the kernel device tree. They probably also hardcode it
> in their downstream kernel versions.

Actually, I've checked the downstream NXP Kernel version, and none of
the Job Ring nodes (including JR0) are disabled there.

>=20
> I can understand that it seems easier to hardcode this in the kernel,
> but as I said before, if you are running OP-TEE you need to adjust the
> DT anyway since nodes need to be added and you might as well adjust the
> jobring configuration than.

My first version of this patch has been targeting dynamic register
readout to check if DID is set for either S or NS Worlds, but that was
rejected due to unreliable readout in HW. Hence this attempt to
statically disable node was made.

Please note, that there are combinations out there which do have HAB,
TF-A but no OP-TEE. In that case patching DT is not an option, and
would cause the probing error at boot.

Frankly speaking, I'm not sure how to proceed with this further...

Clearly, there is an issue that JR devices are not available in certain
combination of SW entities that are setting different permissions on JR:
upstream TF-A does not do any reservation but does not support HAB (and
this is aligned with current DT nodes description); downstream TF-A does
perform reservation and support HAB, but does not release JR0 to NS-World
causing error on the boot at JR probing. Since those 2 combinations are
orthogonal - the only solution that I see (including the patch proposed
in U-Boot ML) is to reserve the JR0 for all combinations, loosing it in
Linux but covering both TF-A (HAB and non-HAB) at the same time.

If you have any other suggestions here - I'm fully opened to receive those!

>=20
> Kind regards,
> Rouven
>=20
>=20

Regards,
Andrey

Link: [1]: https://lore.kernel.org/u-boot/20211207074129.10955-3-gaurav.jain(=
a)nxp.com/

--===============8040885445894105232==--

