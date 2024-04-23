From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 0/3] Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 23 Apr 2024 10:44:09 +0200
Message-ID: 
 <CAHUa44F8J6byatNpg9W6Y2yinJw_RKEtLBKBSDxGkz0yx4Zi3A@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CDM6PR04MB6575E485C2CDB40CC79A3081FC112=40DM6PR04MB?=
 =?utf-8?q?6575=2Enamprd04=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6066959076788892783=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6066959076788892783==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 10:22=E2=80=AFAM Avri Altman <Avri.Altman@wdc.com> =
wrote:
>
> > On Tue, Apr 23, 2024 at 8:42=E2=80=AFAM Avri Altman <Avri.Altman@wdc.co=
m> wrote:
> > >
> > > > The OP-TEE driver finds the correct RPMB device to interact with by
> > > > iterating over available devices until one is found with a
> > > > programmed authentication matching the one OP-TEE is using. This
> > > > enables coexisting users of other RPMBs since the owner can be
> > > > determined by who knows the authentication key.
> > > Devices in plural?
> > > I am unaware of any board with multi eMMC devices soldered.
> > > Can you refer me to such a platform?
> >
> > I'm testing with a Hikey960 (HiSilicon Kirin 620)
> > https://www.96boards.org/product/hikey
> > It has one soldered eMMC and one removable eMMC.
> I used to have that board but with a UFS2.1 version, so I can't really tell.
> https://github.com/96boards/documentation/blob/master/consumer/hikey/hikey6=
20/hardware-docs/hardware-user-manual.md#storage
> indicating only a single eMMC device and a SD.

That's what I'm testing with, the kernel finds two RPMBs with
different CIDs. I'm running my tests with the removable one.

> Either way, AFAIK there are no production designs that make use of more tha=
n a single embedded flash storage.
> This goes for both eMMC and UFS.

OK

Thanks,
Jens

--===============6066959076788892783==--

