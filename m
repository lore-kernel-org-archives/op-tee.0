From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Date: Wed, 29 May 2024 17:26:15 +0300
Message-ID: <Zlc7B6khuhGZ6QOZ@nuoska>
In-Reply-To: <Zlb3fuqvQIO9ghQX@manut.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0237817455173533810=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0237817455173533810==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 29, 2024 at 11:38:06AM +0200, Manuel Traut wrote:
> Hi Mikko,
>=20
> On 10:09 Wed 29 May     , Mikko Rapeli wrote:
> > On Wed, May 29, 2024 at 10:56:04AM +0530, Sumit Garg wrote:
> > > On Tue, 28 May 2024 at 15:00, Mikko Rapeli <mikko.rapeli@linaro.org> =
wrote:
> > > > On Mon, May 27, 2024 at 03:24:01PM +0200, Jens Wiklander wrote:
> > > > > On Mon, May 27, 2024 at 3:00=E2=80=AFPM Jerome Forissier
> > > > > <jerome.forissier@linaro.org> wrote:
> > > > > > On 5/27/24 14:13, Jens Wiklander wrote:
> > > > Outside of these patches, I think the optee RPC setup with fTPM TA is=
 one area which
> > > > currently requires tee-supplicant to be started. Detecting the existe=
nce of TPM before
> > > > kernel drivers are loaded is possible via the exported EFI logs from =
firmware to kernel
> > > > or ACPI TPM2 table entry, and detecting optee and thus starting tee-s=
upplicant in userspace too.
> > >=20
> > > One thing I am trying to find an answer about is why do we need to
> > > defer tee-supplicant launch if it's bundled into initrd? Once you
> > > detect OP-TEE then tee-supplicant should be launched unconditionally.
> > > As per your example below, the motivation here seems to be the TPM2
> > > device dependent on RPMB backend but what if other future systemd
> > > services come up and depend on other services offered by
> > > tee-supplicant?
> >=20
> > There is an annoying depedency between firmware side optee and TAs, and k=
ernel optee driver,
> > tee-supplicant in userspace and kernel TA drivers like fTPM.
> >=20
> > Kernel fTPM driver and fTPM TA require tee-supplicant in userspace for RP=
MB, RPC etc.
> >=20
> > This patch series is adding kernel side support for RPMB handling so that=
 the dependency to
> > tee-supplicant in userspace can be removed. For fTPM use case, there is s=
till the optee RPC
> > buffer setup which currently requires tee-supplicant in userspace or fTPM=
 TA will panic.
> >=20
> > So yes, currently, tee-supplicant must be started. But it would be great =
if kernel drivers
> > and firmware optee trusted applications would not depend on tee-supplican=
t running in userspace.
> > The startup sequence is really tricky to get right. My fTPM use case is u=
sing the TPM device
> > to encrypt rootfs and thus all SW components including tee-supplicant nee=
d to run early in
> > initramfs. Currently also switch from initramfs to main rootfs requires u=
nloading
> > fTPM kernel driver and stopping tee-supplicant in initrd, and then starti=
ng tee-supplicant
> > and loading fTPM kernel driver from main rootfs. udev and automatic modul=
e loading for
> > fTPM can not be used due to the tee-supplicant userspace dependency.
>=20
> I decided to build fTPM as buildin-TA into OP-TEE. RPMB routing is already
> implemented in u-boot so it can already write PCR registers.

Is build in TA same as early TA? I presume so.

> With this series and the required changes in OP-TEE and a compiled in fTPM
> kernel driver and systemd v256 it is possible to use the fTPM in the initrd
> without tee-supplicant.
>=20
> Maybe this information is helpful to you, regards

This is very interesting and I'm trying to get to the same state, though with
fTPM kernel driver as module. With v6 of this patch set and matching optee ch=
anges
I was not able to make this work as fTPM TA was crashing when loading ftpm ke=
rnel driver
due to failing RPC allocation, which tee-supplicant was setting up in the who=
le chain.
I'll try to get v7 patches working and test this again on my yocto based setu=
p and kernel 6.6.y.

Cheers,

-Mikko

--===============0237817455173533810==--

