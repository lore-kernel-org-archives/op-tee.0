From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Date: Wed, 29 May 2024 10:34:58 +0530
Message-ID: 
 <CAFA6WYMobtWMFjv11Gg5-bhU_Guf_R4tx35kwdK-aT4hjLfn0g@mail.gmail.com>
In-Reply-To: <
 <CAHUa44EFYwYU6LSGfv+2ym_pweDKbJzqQG0MfW=bqx5UGSnYSQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2555857277148310705=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2555857277148310705==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 28 May 2024 at 14:38, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Hi Sumit,
>
> On Mon, May 27, 2024 at 4:38=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > On Mon, 27 May 2024 at 17:44, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe and
> > > use an RPMB device via the RPMB subsystem instead of passing the RPMB
> > > frames via tee-supplicant in user space. A fallback mechanism is kept to
> > > route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> > > available.
> > >
> > > The OP-TEE RPC ABI is extended to support iterating over all RPMB
> > > devices until one is found with the expected RPMB key already
> > > programmed.
> > >
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > Tested-by: Manuel Traut <manut@mecka.net>
> > > ---
> > >  Documentation/ABI/testing/sysfs-class-tee |  15 ++
> > >  MAINTAINERS                               |   1 +
> > >  drivers/tee/optee/core.c                  |  96 +++++++++++-
> > >  drivers/tee/optee/device.c                |   7 +
> > >  drivers/tee/optee/ffa_abi.c               |  14 ++
> > >  drivers/tee/optee/optee_ffa.h             |   2 +
> > >  drivers/tee/optee/optee_private.h         |  26 +++-
> > >  drivers/tee/optee/optee_rpc_cmd.h         |  35 +++++
> > >  drivers/tee/optee/optee_smc.h             |   2 +
> > >  drivers/tee/optee/rpc.c                   | 177 ++++++++++++++++++++++
> > >  drivers/tee/optee/smc_abi.c               |  14 ++
> > >  11 files changed, 387 insertions(+), 2 deletions(-)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-tee
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentation/=
ABI/testing/sysfs-class-tee
> > > new file mode 100644
> > > index 000000000000..c9144d16003e
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-class-tee
> > > @@ -0,0 +1,15 @@
> > > +What:          /sys/class/tee/tee{,priv}X/rpmb_routing_model
> > > +Date:          May 2024
> > > +KernelVersion: 6.10
> > > +Contact:        op-tee(a)lists.trustedfirmware.org
> > > +Description:
> > > +               RPMB frames can be routed to the RPMB device via the
> > > +               user-space daemon tee-supplicant or the RPMB subsystem
> > > +               in the kernel. The value "user" means that the driver
> > > +               will route the RPMB frames via user space. Conversely,
> > > +               "kernel" means that the frames are routed via the RPMB
> > > +               subsystem without assistance from tee-supplicant. It
> > > +               should be assumed that RPMB frames are routed via user
> > > +               space if the variable is absent. The primary purpose
> > > +               of this variable is to let systemd know whether
> > > +               tee-supplicant is needed in the early boot with initram=
fs.
> >
> > Why do we need this if we already have [1] [2]? AFAICS, whichever
> > devices like fTPM etc. systemd depends upon, it can be easily known
> > via existing sysfs property.
> >
> > [1] https://docs.kernel.org/admin-guide/abi-testing.html?highlight=3Dopte=
e#abi-sys-bus-tee-devices-optee-ta-uuid-need-supplicant
> > [2] Documentation/ABI/testing/sysfs-bus-optee-devices
>
> The dependency is reversed. A TA depending on tee-supplicant will not
> be loaded until tee-supplicant is ready. rpmb_routing_model is used as
> one of the inputs to determine if tee-supplicant must be started early
> or if it can wait until the real rootfs is available.
>

Okay but I am still not able to understand the reasoning as to why
tee-supplicant can't be started unconditionally. If it's available in
the initrd then systemd should be able to launch it unconditionally.
Or is there any dependency I am missing for the tee-supplicant to be
started? RPMB routing isn't the only service offered by tee-supplcant,
so gating it behind that for no real reason isn't making sense to me.

IOW, why do we need to defer starting tee-supplicant until the real
rootfs is available?

-Sumit

--===============2555857277148310705==--

