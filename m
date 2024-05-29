From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Date: Wed, 29 May 2024 10:09:52 +0300
Message-ID: <ZlbUwI0G3HGvioNm@nuoska>
In-Reply-To: <
 <CAFA6WYOT52fdqgGvDYE91DQ_4MUbAv_1Gnn2fTyMNhrj_Agu=w@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2268801779687906596=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2268801779687906596==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 29, 2024 at 10:56:04AM +0530, Sumit Garg wrote:
> Hi Mikko,
>=20
> On Tue, 28 May 2024 at 15:00, Mikko Rapeli <mikko.rapeli@linaro.org> wrot=
e:
> >
> > Hi,
> >
> > On Mon, May 27, 2024 at 03:24:01PM +0200, Jens Wiklander wrote:
> > > On Mon, May 27, 2024 at 3:00=E2=80=AFPM Jerome Forissier
> > > <jerome.forissier@linaro.org> wrote:
> > > >
> > > > On 5/27/24 14:13, Jens Wiklander wrote:
> > > > > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to prob=
e and
> > > > > use an RPMB device via the RPMB subsystem instead of passing the RP=
MB
> > > > > frames via tee-supplicant in user space. A fallback mechanism is ke=
pt to
> > > > > route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> > > > > available.
> > > > >
> > > > > The OP-TEE RPC ABI is extended to support iterating over all RPMB
> > > > > devices until one is found with the expected RPMB key already
> > > > > programmed.
> > > > >
> > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > Tested-by: Manuel Traut <manut@mecka.net>
> > > > > ---
> > > > >  Documentation/ABI/testing/sysfs-class-tee |  15 ++
> > > > >  MAINTAINERS                               |   1 +
> > > > >  drivers/tee/optee/core.c                  |  96 +++++++++++-
> > > > >  drivers/tee/optee/device.c                |   7 +
> > > > >  drivers/tee/optee/ffa_abi.c               |  14 ++
> > > > >  drivers/tee/optee/optee_ffa.h             |   2 +
> > > > >  drivers/tee/optee/optee_private.h         |  26 +++-
> > > > >  drivers/tee/optee/optee_rpc_cmd.h         |  35 +++++
> > > > >  drivers/tee/optee/optee_smc.h             |   2 +
> > > > >  drivers/tee/optee/rpc.c                   | 177 ++++++++++++++++++=
++++
> > > > >  drivers/tee/optee/smc_abi.c               |  14 ++
> > > > >  11 files changed, 387 insertions(+), 2 deletions(-)
> > > > >  create mode 100644 Documentation/ABI/testing/sysfs-class-tee
> > > > >
> > > > > diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentat=
ion/ABI/testing/sysfs-class-tee
> > > > > new file mode 100644
> > > > > index 000000000000..c9144d16003e
> > > > > --- /dev/null
> > > > > +++ b/Documentation/ABI/testing/sysfs-class-tee
> > > > > @@ -0,0 +1,15 @@
> > > > > +What:                /sys/class/tee/tee{,priv}X/rpmb_routing_model
> > > >
> > > > Wouldn't /sys/class/tee/teeX/rpmb_routing_model be good enough?
> > >
> > > Doesn't the routing model concern tee-supplicant more than a TEE
> > > client? Then it might make more sense to have
> > > /sys/class/tee/teeprivX/rpmb_routing_model only. Keeping it for both
> > > devices representing the same internal struct optee makes it easier to
> > > find. Anyway, I don't mind removing one. Mikko, what do you prefer?
> >
> > As simple as possible. A single sysfs file is enough. Even the existence =
of the sysfs file
> > could be the needed indicator for userspace to queue tee-supplicant start=
up.
> >
> > Outside of these patches, I think the optee RPC setup with fTPM TA is one=
 area which
> > currently requires tee-supplicant to be started. Detecting the existence =
of TPM before
> > kernel drivers are loaded is possible via the exported EFI logs from firm=
ware to kernel
> > or ACPI TPM2 table entry, and detecting optee and thus starting tee-suppl=
icant in userspace too.
>=20
> One thing I am trying to find an answer about is why do we need to
> defer tee-supplicant launch if it's bundled into initrd? Once you
> detect OP-TEE then tee-supplicant should be launched unconditionally.
> As per your example below, the motivation here seems to be the TPM2
> device dependent on RPMB backend but what if other future systemd
> services come up and depend on other services offered by
> tee-supplicant?

There is an annoying depedency between firmware side optee and TAs, and kerne=
l optee driver,
tee-supplicant in userspace and kernel TA drivers like fTPM.

Kernel fTPM driver and fTPM TA require tee-supplicant in userspace for RPMB, =
RPC etc.

This patch series is adding kernel side support for RPMB handling so that the=
 dependency to
tee-supplicant in userspace can be removed. For fTPM use case, there is still=
 the optee RPC
buffer setup which currently requires tee-supplicant in userspace or fTPM TA =
will panic.

So yes, currently, tee-supplicant must be started. But it would be great if k=
ernel drivers
and firmware optee trusted applications would not depend on tee-supplicant ru=
nning in userspace.
The startup sequence is really tricky to get right. My fTPM use case is using=
 the TPM device
to encrypt rootfs and thus all SW components including tee-supplicant need to=
 run early in
initramfs. Currently also switch from initramfs to main rootfs requires unloa=
ding
fTPM kernel driver and stopping tee-supplicant in initrd, and then starting t=
ee-supplicant
and loading fTPM kernel driver from main rootfs. udev and automatic module lo=
ading for
fTPM can not be used due to the tee-supplicant userspace dependency.

As an example, here is v6 of this series on rockpi4b using fTPM TA with syste=
md based initrd
without tee-supplicant and fTPM TA panics because the RPC setup is missing:

https://ledge.validation.linaro.org/scheduler/job/87488

[[0;32m  OK  [0m] Finished [0;1;39mFile System Check on /dev/mapper/usr[0m.
E/TC:? 0 get_rpc_alloc_res:645 RPC allocation failed. Non-secure world result=
: ret=3D0xffff000c ret_origin=3D0x2
E/TC:? 0=20
E/TC:? 0 TA panicked with code 0xffff000c
E/LD:  Status of TA bc50d971-d4c9-42c4-82cb-343fb7f37896
E/LD:   arch: aarch64
E/LD:  region  0: va 0x40005000 pa 0x3061b000 size 0x002000 flags rw-s (ldelf)
E/LD:  region  1: va 0x40007000 pa 0x3061d000 size 0x008000 flags r-xs (ldelf)
E/LD:  region  2: va 0x4000f000 pa 0x30625000 size 0x001000 flags rw-s (ldelf)
E/LD:  region  3: va 0x40010000 pa 0x30626000 size 0x004000 flags rw-s (ldelf)
E/LD:  region  4: va 0x40014000 pa 0x3062a000 size 0x001000 flags r--s
E/LD:  region  5: va 0x40015000 pa 0x306b2000 size 0x011000 flags rw-s (stack)
E/LD:  region  6: va 0x40026000 pa 0xe50ce000 size 0x002000 flags rw-- (param)
E/LD:  region  7: va 0x40062000 pa 0x00001000 size 0x068000 flags r-xs [0]
E/LD:  region  8: va 0x400ca000 pa 0x00069000 size 0x01f000 flags rw-s [0]
E/LD:   [0] bc50d971-d4c9-42c4-82cb-343fb7f37896 @ 0x40062000
E/LD:  Call stack:
E/LD:   0x400a00c0
E/LD:   0x40062b40
E/LD:   0x400631b8
E/LD:   0x40081f44
E/LD:   0x4009b060
E/LD:   0x40063a2c
E/LD:   0x400a6298
E/LD:   0x4009b214
[    7.212584] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0=
xffff3024
[    7.213281] tpm tpm0: tpm_try_transmit: send(): error -53212
[    7.213820] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0=
xffff3024
[    7.214493] tpm tpm0: tpm_try_transmit: send(): error -53212
[    7.214996] optee-ftpm optee-ta-bc50d971-d4c9-42c4-82cb-343fb7f37896: ftpm=
_tee_probe: tpm_chip_register failed with rc=3D-53212
         Mounting [0;1;39m/sysusr/usr[0m...=20

This series adds the RPMB support in kernel, if HW supports it, but some HW d=
oesn't and the
tee-supplicant is emulating it as fall back. Userspace needs to know if tee-s=
upplicant start
is needed. Thus to me, exporting the RPMB routing details is useful for users=
pace.

It's one thing to have a full control of HW and SW and force a policy, like a=
lways
waiting for a specific TPM device to appear, but then again distros should be=
 able
to have automatic detection of TPM devices if firmware used them too and then
start the needed bits in userspace, which depend on the firmware and HW confi=
guration,
like which SW components are needed for RPMB storage, kernel or tee-supplican=
t in userspace.

These could possibly be just bugs in fTPM kernel driver and fTPM TA in optee =
world,
which should be able to handle missing RPC and RPMB too and retry later on. R=
ight now
without tee-supplicant they panic early in boot and become unusable for the r=
est of the
power cycle.

Cheers,

-Mikko

--===============2268801779687906596==--

