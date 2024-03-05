From: Arnd Bergmann <arnd@arndb.de>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 05 Mar 2024 17:37:31 +0100
Message-ID: <1859f2a9-b3fa-4d41-86e6-aa0a18fddad4@app.fastmail.com>
In-Reply-To: <=?utf-8?q?=3CDM6PR04MB65759DF9CAF6ECB5BA78E138FC222=40DM6PR04MB?=
 =?utf-8?q?6575=2Enamprd04=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8411767821964231079=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8411767821964231079==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024, at 17:33, Avri Altman wrote:
>> On Tue, Feb 27, 2024 at 4:31=E2=80=AFPM Jens Wiklander <jens.wiklander@l=
inaro.org> wrote:
>>=20
>> I would mention in the commit that the subsystem is currently only used wi=
th
>> eMMC but is designed to be used also by UFS and NVME. Nevertheless, no big
>> deal so:
> Moreover, as the years went by, the differences between mmc and ufs=20
> grew:
> In mmc there are 7 rpmb operations, in ufs 9.
> In mmc the rpmb frame is 512Bytes, also in legacy ufs (up to including=20
> ufs3.1), but in ufs4.0 onward it can be 4k with extended header.
> See e.g.=20
> https://patchwork.kernel.org/project/linux-scsi/patch/20221107131038.201724=
-3-beanhuo(a)iokpp.de/
> In mmc the rpmb sequence is atomic, in ufs not.
> In ufs rpmb is a wlun in mmc a partition.
> Both protocols support in multi-region rpmb, but there are some=20
> differences there.

How sure are we then that the user-visible ABI is sufficiently
abstract to cover all the hardware implementations? Are any of the
changes you mention going to be noticed by userspace or are they
only visible to the kernel driver?

      Arnd

--===============8411767821964231079==--

