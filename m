From: Manuel Traut <manut@mecka.net>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Date: Wed, 29 May 2024 11:38:06 +0200
Message-ID: <Zlb3fuqvQIO9ghQX@manut.de>
In-Reply-To: <ZlbUwI0G3HGvioNm@nuoska>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2555582442454751445=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2555582442454751445==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Mikko,

On 10:09 Wed 29 May     , Mikko Rapeli wrote:
> On Wed, May 29, 2024 at 10:56:04AM +0530, Sumit Garg wrote:
> > On Tue, 28 May 2024 at 15:00, Mikko Rapeli <mikko.rapeli@linaro.org> wr=
ote:
> > > On Mon, May 27, 2024 at 03:24:01PM +0200, Jens Wiklander wrote:
> > > > On Mon, May 27, 2024 at 3:00=E2=80=AFPM Jerome Forissier
> > > > <jerome.forissier@linaro.org> wrote:
> > > > > On 5/27/24 14:13, Jens Wiklander wrote:
> > > Outside of these patches, I think the optee RPC setup with fTPM TA is o=
ne area which
> > > currently requires tee-supplicant to be started. Detecting the existenc=
e of TPM before
> > > kernel drivers are loaded is possible via the exported EFI logs from fi=
rmware to kernel
> > > or ACPI TPM2 table entry, and detecting optee and thus starting tee-sup=
plicant in userspace too.
> >=20
> > One thing I am trying to find an answer about is why do we need to
> > defer tee-supplicant launch if it's bundled into initrd? Once you
> > detect OP-TEE then tee-supplicant should be launched unconditionally.
> > As per your example below, the motivation here seems to be the TPM2
> > device dependent on RPMB backend but what if other future systemd
> > services come up and depend on other services offered by
> > tee-supplicant?
>=20
> There is an annoying depedency between firmware side optee and TAs, and ker=
nel optee driver,
> tee-supplicant in userspace and kernel TA drivers like fTPM.
>=20
> Kernel fTPM driver and fTPM TA require tee-supplicant in userspace for RPMB=
, RPC etc.
>=20
> This patch series is adding kernel side support for RPMB handling so that t=
he dependency to
> tee-supplicant in userspace can be removed. For fTPM use case, there is sti=
ll the optee RPC
> buffer setup which currently requires tee-supplicant in userspace or fTPM T=
A will panic.
>=20
> So yes, currently, tee-supplicant must be started. But it would be great if=
 kernel drivers
> and firmware optee trusted applications would not depend on tee-supplicant =
running in userspace.
> The startup sequence is really tricky to get right. My fTPM use case is usi=
ng the TPM device
> to encrypt rootfs and thus all SW components including tee-supplicant need =
to run early in
> initramfs. Currently also switch from initramfs to main rootfs requires unl=
oading
> fTPM kernel driver and stopping tee-supplicant in initrd, and then starting=
 tee-supplicant
> and loading fTPM kernel driver from main rootfs. udev and automatic module =
loading for
> fTPM can not be used due to the tee-supplicant userspace dependency.

I decided to build fTPM as buildin-TA into OP-TEE. RPMB routing is already
implemented in u-boot so it can already write PCR registers.

With this series and the required changes in OP-TEE and a compiled in fTPM
kernel driver and systemd v256 it is possible to use the fTPM in the initrd
without tee-supplicant.

Maybe this information is helpful to you, regards
Manuel

--===============2555582442454751445==--

