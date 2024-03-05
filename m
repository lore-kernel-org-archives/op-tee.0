From: Avri Altman <Avri.Altman@wdc.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 RE: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 05 Mar 2024 16:42:37 +0000
Message-ID: <DM6PR04MB657511E98570A227AD1AF40AFC222@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <1859f2a9-b3fa-4d41-86e6-aa0a18fddad4@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3877940613239213113=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3877940613239213113==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=20
> On Tue, Mar 5, 2024, at 17:33, Avri Altman wrote:
> >> On Tue, Feb 27, 2024 at 4:31=E2=80=AFPM Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
> >>
> >> I would mention in the commit that the subsystem is currently only
> >> used with eMMC but is designed to be used also by UFS and NVME.
> >> Nevertheless, no big deal so:
> > Moreover, as the years went by, the differences between mmc and ufs
> > grew:
> > In mmc there are 7 rpmb operations, in ufs 9.
> > In mmc the rpmb frame is 512Bytes, also in legacy ufs (up to including
> > ufs3.1), but in ufs4.0 onward it can be 4k with extended header.
> > See e.g.
> > https://patchwork.kernel.org/project/linux-scsi/patch/20221107131038.2
> > 01724-3-beanhuo(a)iokpp.de/ In mmc the rpmb sequence is atomic, in ufs
> > not.
> > In ufs rpmb is a wlun in mmc a partition.
> > Both protocols support in multi-region rpmb, but there are some
> > differences there.
>=20
> How sure are we then that the user-visible ABI is sufficiently abstract to =
cover
> all the hardware implementations? Are any of the changes you mention going =
to
> be noticed by userspace or are they only visible to the kernel driver?
Both in ufs & mmc rpmb today is accessed via user-space utils:
In mmc via mmc-utils (ioctl) , and in ufs via ufs-utils using its bsg interfa=
ce.
No ABI changes are needed.

Thanks,
Avri

>=20
>       Arnd

--===============3877940613239213113==--

