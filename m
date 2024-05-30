From: Manuel Traut <manut@mecka.net>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Date: Thu, 30 May 2024 09:35:10 +0200
Message-ID: <ZlgsLibqO59kNQUE@mecka.net>
In-Reply-To: <Zlc7B6khuhGZ6QOZ@nuoska>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4741305203133513099=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4741305203133513099==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Mikko,

On Wed, May 29, 2024 at 05:26:15PM +0300, Mikko Rapeli wrote:
> Hi,
>=20
> On Wed, May 29, 2024 at 11:38:06AM +0200, Manuel Traut wrote:
> > Hi Mikko,
> >=20
> > On 10:09 Wed 29 May     , Mikko Rapeli wrote:
> > > On Wed, May 29, 2024 at 10:56:04AM +0530, Sumit Garg wrote:
> > > > On Tue, 28 May 2024 at 15:00, Mikko Rapeli <mikko.rapeli@linaro.org=
> wrote:
> > > > > On Mon, May 27, 2024 at 03:24:01PM +0200, Jens Wiklander wrote:
> > > > > > On Mon, May 27, 2024 at 3:00=E2=80=AFPM Jerome Forissier
> > > > > > <jerome.forissier@linaro.org> wrote:
> > > > > > > On 5/27/24 14:13, Jens Wiklander wrote:
> > > > > Outside of these patches, I think the optee RPC setup with fTPM TA =
is one area which
> > > > > currently requires tee-supplicant to be started. Detecting the exis=
tence of TPM before
> > > > > kernel drivers are loaded is possible via the exported EFI logs fro=
m firmware to kernel
> > > > > or ACPI TPM2 table entry, and detecting optee and thus starting tee=
-supplicant in userspace too.
> > > >=20
> > > > One thing I am trying to find an answer about is why do we need to
> > > > defer tee-supplicant launch if it's bundled into initrd? Once you
> > > > detect OP-TEE then tee-supplicant should be launched unconditionally.
> > > > As per your example below, the motivation here seems to be the TPM2
> > > > device dependent on RPMB backend but what if other future systemd
> > > > services come up and depend on other services offered by
> > > > tee-supplicant?
> > >=20
> > > There is an annoying depedency between firmware side optee and TAs, and=
 kernel optee driver,
> > > tee-supplicant in userspace and kernel TA drivers like fTPM.
> > >=20
> > > Kernel fTPM driver and fTPM TA require tee-supplicant in userspace for =
RPMB, RPC etc.
> > >=20
> > > This patch series is adding kernel side support for RPMB handling so th=
at the dependency to
> > > tee-supplicant in userspace can be removed. For fTPM use case, there is=
 still the optee RPC
> > > buffer setup which currently requires tee-supplicant in userspace or fT=
PM TA will panic.
> > >=20
> > > So yes, currently, tee-supplicant must be started. But it would be grea=
t if kernel drivers
> > > and firmware optee trusted applications would not depend on tee-supplic=
ant running in userspace.
> > > The startup sequence is really tricky to get right. My fTPM use case is=
 using the TPM device
> > > to encrypt rootfs and thus all SW components including tee-supplicant n=
eed to run early in
> > > initramfs. Currently also switch from initramfs to main rootfs requires=
 unloading
> > > fTPM kernel driver and stopping tee-supplicant in initrd, and then star=
ting tee-supplicant
> > > and loading fTPM kernel driver from main rootfs. udev and automatic mod=
ule loading for
> > > fTPM can not be used due to the tee-supplicant userspace dependency.
> >=20
> > I decided to build fTPM as buildin-TA into OP-TEE. RPMB routing is already
> > implemented in u-boot so it can already write PCR registers.
>=20
> Is build in TA same as early TA? I presume so.

Indeed.. sorry for using the wrong term.

> > With this series and the required changes in OP-TEE and a compiled in fTPM
> > kernel driver and systemd v256 it is possible to use the fTPM in the init=
rd
> > without tee-supplicant.
> >=20
> > Maybe this information is helpful to you, regards
>=20
> This is very interesting and I'm trying to get to the same state, though wi=
th
> fTPM kernel driver as module. With v6 of this patch set and matching optee =
changes
> I was not able to make this work as fTPM TA was crashing when loading ftpm =
kernel driver
> due to failing RPC allocation, which tee-supplicant was setting up in the w=
hole chain.
> I'll try to get v7 patches working and test this again on my yocto based se=
tup and kernel 6.6.y.

I'll try today also with v7 and 6.10-rc1 on an i.MX8MM. It should also
work with fTPM as kernel module if you use systemd in the initrd
with the new tpm.target in systemd v256.

Regards
Manuel

--===============4741305203133513099==--

