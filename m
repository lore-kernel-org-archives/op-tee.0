From: Avri Altman <Avri.Altman@wdc.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: [PATCH v5 0/3] Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 23 Apr 2024 08:22:05 +0000
Message-ID: <DM6PR04MB6575E485C2CDB40CC79A3081FC112@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <
 <CAHUa44EzMpRbhJ=-h4hJifgtrMsvDZj=Zt4C3JkDxjKE4gz=7A@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8923547458161743161=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8923547458161743161==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> On Tue, Apr 23, 2024 at 8:42=E2=80=AFAM Avri Altman <Avri.Altman@wdc.com>=
 wrote:
> >
> > > The OP-TEE driver finds the correct RPMB device to interact with by
> > > iterating over available devices until one is found with a
> > > programmed authentication matching the one OP-TEE is using. This
> > > enables coexisting users of other RPMBs since the owner can be
> > > determined by who knows the authentication key.
> > Devices in plural?
> > I am unaware of any board with multi eMMC devices soldered.
> > Can you refer me to such a platform?
>=20
> I'm testing with a Hikey960 (HiSilicon Kirin 620)
> https://www.96boards.org/product/hikey
> It has one soldered eMMC and one removable eMMC.
I used to have that board but with a UFS2.1 version, so I can't really tell.
https://github.com/96boards/documentation/blob/master/consumer/hikey/hikey620=
/hardware-docs/hardware-user-manual.md#storage
indicating only a single eMMC device and a SD.

Either way, AFAIK there are no production designs that make use of more than =
a single embedded flash storage.
This goes for both eMMC and UFS.

Thanks,
Avri

>=20
> Cheers,
> Jens

--===============8923547458161743161==--

