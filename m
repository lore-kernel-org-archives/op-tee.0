From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Date: Thu, 30 May 2024 11:29:11 +0300
Message-ID: <Zlg411JGQJf2zRPe@nuoska>
In-Reply-To: <ZlgsLibqO59kNQUE@mecka.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7907514965367710882=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7907514965367710882==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 09:35:10AM +0200, Manuel Traut wrote:
> Hi Mikko,
>=20
> On Wed, May 29, 2024 at 05:26:15PM +0300, Mikko Rapeli wrote:
> > Hi,
> >=20
> > On Wed, May 29, 2024 at 11:38:06AM +0200, Manuel Traut wrote:
> > > Hi Mikko,
> > >=20
> > > On 10:09 Wed 29 May     , Mikko Rapeli wrote:
> > > > On Wed, May 29, 2024 at 10:56:04AM +0530, Sumit Garg wrote:
> > > > > On Tue, 28 May 2024 at 15:00, Mikko Rapeli <mikko.rapeli@linaro.o=
rg> wrote:
> > > > > > On Mon, May 27, 2024 at 03:24:01PM +0200, Jens Wiklander wrote:
> > > > > > > On Mon, May 27, 2024 at 3:00=E2=80=AFPM Jerome Forissier
> > > > > > > <jerome.forissier@linaro.org> wrote:
> > > > > > > > On 5/27/24 14:13, Jens Wiklander wrote:
> > > > > > Outside of these patches, I think the optee RPC setup with fTPM T=
A is one area which
> > > > > > currently requires tee-supplicant to be started. Detecting the ex=
istence of TPM before
> > > > > > kernel drivers are loaded is possible via the exported EFI logs f=
rom firmware to kernel
> > > > > > or ACPI TPM2 table entry, and detecting optee and thus starting t=
ee-supplicant in userspace too.
> > > > >=20
> > > > > One thing I am trying to find an answer about is why do we need to
> > > > > defer tee-supplicant launch if it's bundled into initrd? Once you
> > > > > detect OP-TEE then tee-supplicant should be launched unconditionall=
y.
> > > > > As per your example below, the motivation here seems to be the TPM2
> > > > > device dependent on RPMB backend but what if other future systemd
> > > > > services come up and depend on other services offered by
> > > > > tee-supplicant?
> > > >=20
> > > > There is an annoying depedency between firmware side optee and TAs, a=
nd kernel optee driver,
> > > > tee-supplicant in userspace and kernel TA drivers like fTPM.
> > > >=20
> > > > Kernel fTPM driver and fTPM TA require tee-supplicant in userspace fo=
r RPMB, RPC etc.
> > > >=20
> > > > This patch series is adding kernel side support for RPMB handling so =
that the dependency to
> > > > tee-supplicant in userspace can be removed. For fTPM use case, there =
is still the optee RPC
> > > > buffer setup which currently requires tee-supplicant in userspace or =
fTPM TA will panic.
> > > >=20
> > > > So yes, currently, tee-supplicant must be started. But it would be gr=
eat if kernel drivers
> > > > and firmware optee trusted applications would not depend on tee-suppl=
icant running in userspace.
> > > > The startup sequence is really tricky to get right. My fTPM use case =
is using the TPM device
> > > > to encrypt rootfs and thus all SW components including tee-supplicant=
 need to run early in
> > > > initramfs. Currently also switch from initramfs to main rootfs requir=
es unloading
> > > > fTPM kernel driver and stopping tee-supplicant in initrd, and then st=
arting tee-supplicant
> > > > and loading fTPM kernel driver from main rootfs. udev and automatic m=
odule loading for
> > > > fTPM can not be used due to the tee-supplicant userspace dependency.
> > >=20
> > > I decided to build fTPM as buildin-TA into OP-TEE. RPMB routing is alre=
ady
> > > implemented in u-boot so it can already write PCR registers.
> >=20
> > Is build in TA same as early TA? I presume so.
>=20
> Indeed.. sorry for using the wrong term.

Ok, no problem. Then we have the same fTPM TA setup. I'm using optee 4.1
with RPMB kernel support changes from Jens cherry-picked on top.

> > > With this series and the required changes in OP-TEE and a compiled in f=
TPM
> > > kernel driver and systemd v256 it is possible to use the fTPM in the in=
itrd
> > > without tee-supplicant.
> > >=20
> > > Maybe this information is helpful to you, regards
> >=20
> > This is very interesting and I'm trying to get to the same state, though =
with
> > fTPM kernel driver as module. With v6 of this patch set and matching opte=
e changes
> > I was not able to make this work as fTPM TA was crashing when loading ftp=
m kernel driver
> > due to failing RPC allocation, which tee-supplicant was setting up in the=
 whole chain.
> > I'll try to get v7 patches working and test this again on my yocto based =
setup and kernel 6.6.y.
>=20
> I'll try today also with v7 and 6.10-rc1 on an i.MX8MM. It should also
> work with fTPM as kernel module if you use systemd in the initrd
> with the new tpm.target in systemd v256.

Thanks for the details. I'm testing on qemu, rockpi4b (Rockchip rk3399 SoC) a=
nd synquacer
(Socionext Developer Box, SC2A11:Cortex-A53 MPCore 24cores). Kernel and rootfs
are from our yocto master branch based Trusted Reference Stack distro
( https://gitlab.com/Linaro/trusted-reference-stack/trs )
with kernel 6.6.29 (porting the RPMB v7 patches currently), systemd 255.4 (tp=
m2.target
backported), tee-supplicant 4.1 etc. I'm switching the initramfs from shell s=
cripts
to systemd currently, but running into various issues.

UEFI firmware is our Trusted Substrate ( https://gitlab.com/Linaro/trustedsub=
strate/meta-ts/ )
ARM System Ready IR compatible with secure boot and TPM support, u-boot
2024.04 (except rockpi4b still on 2023.01), optee 4.1, fTPM etc from meta-arm
yocto layer.

Booting without tee-supplicant has so far only resulted in the fTPM TA panic'=
ing
because RPC setup is failing. Also the fTPM TA enumation needs to be changed
from current yocto defaults to always discoverable if there is no tee-supplic=
ant:
https://git.yoctoproject.org/meta-arm/tree/meta-arm/recipes-security/optee-ft=
pm/optee-ftpm/0001-add-enum-to-ta-flags.patch

I hope to get v7 of these patches into testing today.

Cheers,

-Mikko

--===============7907514965367710882==--

