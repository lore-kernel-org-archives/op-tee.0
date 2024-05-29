From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Date: Wed, 29 May 2024 10:56:04 +0530
Message-ID: 
 <CAFA6WYOT52fdqgGvDYE91DQ_4MUbAv_1Gnn2fTyMNhrj_Agu=w@mail.gmail.com>
In-Reply-To: <ZlWkSCCjJ2fbE2ML@nuoska>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0821100326749458887=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0821100326749458887==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Mikko,

On Tue, 28 May 2024 at 15:00, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
>
> Hi,
>
> On Mon, May 27, 2024 at 03:24:01PM +0200, Jens Wiklander wrote:
> > On Mon, May 27, 2024 at 3:00=E2=80=AFPM Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> > >
> > > On 5/27/24 14:13, Jens Wiklander wrote:
> > > > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe =
and
> > > > use an RPMB device via the RPMB subsystem instead of passing the RPMB
> > > > frames via tee-supplicant in user space. A fallback mechanism is kept=
 to
> > > > route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> > > > available.
> > > >
> > > > The OP-TEE RPC ABI is extended to support iterating over all RPMB
> > > > devices until one is found with the expected RPMB key already
> > > > programmed.
> > > >
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > Tested-by: Manuel Traut <manut@mecka.net>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-class-tee |  15 ++
> > > >  MAINTAINERS                               |   1 +
> > > >  drivers/tee/optee/core.c                  |  96 +++++++++++-
> > > >  drivers/tee/optee/device.c                |   7 +
> > > >  drivers/tee/optee/ffa_abi.c               |  14 ++
> > > >  drivers/tee/optee/optee_ffa.h             |   2 +
> > > >  drivers/tee/optee/optee_private.h         |  26 +++-
> > > >  drivers/tee/optee/optee_rpc_cmd.h         |  35 +++++
> > > >  drivers/tee/optee/optee_smc.h             |   2 +
> > > >  drivers/tee/optee/rpc.c                   | 177 ++++++++++++++++++++=
++
> > > >  drivers/tee/optee/smc_abi.c               |  14 ++
> > > >  11 files changed, 387 insertions(+), 2 deletions(-)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-class-tee
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentatio=
n/ABI/testing/sysfs-class-tee
> > > > new file mode 100644
> > > > index 000000000000..c9144d16003e
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-class-tee
> > > > @@ -0,0 +1,15 @@
> > > > +What:                /sys/class/tee/tee{,priv}X/rpmb_routing_model
> > >
> > > Wouldn't /sys/class/tee/teeX/rpmb_routing_model be good enough?
> >
> > Doesn't the routing model concern tee-supplicant more than a TEE
> > client? Then it might make more sense to have
> > /sys/class/tee/teeprivX/rpmb_routing_model only. Keeping it for both
> > devices representing the same internal struct optee makes it easier to
> > find. Anyway, I don't mind removing one. Mikko, what do you prefer?
>
> As simple as possible. A single sysfs file is enough. Even the existence of=
 the sysfs file
> could be the needed indicator for userspace to queue tee-supplicant startup.
>
> Outside of these patches, I think the optee RPC setup with fTPM TA is one a=
rea which
> currently requires tee-supplicant to be started. Detecting the existence of=
 TPM before
> kernel drivers are loaded is possible via the exported EFI logs from firmwa=
re to kernel
> or ACPI TPM2 table entry, and detecting optee and thus starting tee-supplic=
ant in userspace too.

One thing I am trying to find an answer about is why do we need to
defer tee-supplicant launch if it's bundled into initrd? Once you
detect OP-TEE then tee-supplicant should be launched unconditionally.
As per your example below, the motivation here seems to be the TPM2
device dependent on RPMB backend but what if other future systemd
services come up and depend on other services offered by
tee-supplicant?

-Sumit

>
> In userspace and systemd it's just important to know that service need to w=
ait for a TPM2
> device to appear in early initrd and when can things be postponed to main r=
ootfs and later
> stages. Kernel and udev will bring up the device then once discovered.
> Knowledge about the RPMB backend is important when something like TPM2 devi=
ce
> depends on it.
>
> Hope this helps,
>
> -Mikko

--===============0821100326749458887==--

