From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Wed, 07 Feb 2024 09:11:34 +0100
Message-ID: 
 <CAHUa44EnKCHXoPdmnyn3JSthNH=tnLa_LEwk_u797yBk=mFRAw@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYMNyw5GPji8XMMcPNHSkX5zXubsuVhauWHyGvBBQ3Mefw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2616106276132081906=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2616106276132081906==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 8:49=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> On Wed, 7 Feb 2024 at 12:56, Jens Wiklander <jens.wiklander@linaro.org> w=
rote:
> >
> > H,
> >
> > On Wed, Feb 7, 2024 at 7:11=E2=80=AFAM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> > >
> > > Hi Ilias, Ulf,
> > >
> > > On Tue, 6 Feb 2024 at 20:41, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Ulf,
> > > >
> > > > On Tue, 6 Feb 2024 at 14:34, Ulf Hansson <ulf.hansson@linaro.org> w=
rote:
> > > > >
> > > > > On Wed, 31 Jan 2024 at 18:44, Jens Wiklander <jens.wiklander@lina=
ro.org> wrote:
> > > > > >
> > > > > > A number of storage technologies support a specialised hardware
> > > > > > partition designed to be resistant to replay attacks. The underly=
ing
> > > > > > HW protocols differ but the operations are common. The RPMB parti=
tion
> > > > > > cannot be accessed via standard block layer, but by a set of spec=
ific
> > > > > > RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. S=
uch a
> > > > > > partition provides authenticated and replay protected access, hen=
ce
> > > > > > suitable as a secure storage.
> > > > > >
> > > > > > The initial aim of this patch is to provide a simple RPMB Driver =
which
> > > > > > can be accessed by the optee driver to facilitate early RPMB acce=
ss to
> > > > > > OP-TEE OS (secure OS) during the boot time.
> > > > >
> > > > > How early do we expect OP-TEE to need RPMB access?
> > > >
> > > > It depends on the requested services. I am currently aware of 2
> > > > services that depend on the RPMB
> > > > - FirmwareTPM
> > > > - UEFI variables stored there via optee.
> > > >
> > > > For the FirmwareTPM it depends on when you want to use it. This
> > > > typically happens when the initramfs is loaded or systemd requests
> > > > access to the TPM. I guess this is late enough to not cause problems?
> > >
> > > Actually RPMB access is done as early as during fTPM probe, probably
> > > to cache NVRAM from RPMB during fTPM init. Also, there is a kernel
> > > user being IMA which would require fTPM access too. So we really need
> > > to manage dependencies here.
> > >
> > > >
> > > > For the latter, we won't need the supplicant until a write is
> > > > requested. This will only happen once the userspace is up and running.
> > > > The UEFI driver that sits behind OP-TEE has an in-memory cache of the
> > > > variables, so all the reads (the kernel invokes get_next_variable
> > > > during boot) are working without it.
> > > >
> > > > Thanks
> > > > /Ilias
> > > > >
> > > > > The way things work for mmc today, is that the eMMC card gets
> > > > > discovered/probed via a workqueue. The work is punted by the mmc ho=
st
> > > > > driver (typically a module-platform-driver), when it has probed
> > > > > successfully.
> > >
> > > It would be nice if RPMB is available as early as possible but for the
> > > time being we can try to see if probe deferral suffices for all
> > > use-cases.
> > >
> > > > >
> > > > > The point is, it looks like we need some kind of probe deferral
> > > > > mechanism too. Whether we want the OP-TEE driver to manage this its=
elf
> > > > > or whether we should let rpmb_dev_find_device() deal with it, I don=
't
> > > > > know.
> > >
> > > I wouldn't like to see the OP-TEE driver probe being deferred due to
> > > this since there are other kernel drivers like OP-TEE RNG (should be
> > > available as early as we can) etc. which don't have any dependency on
> > > RPMB.
> >
> > I agree, the optee driver itself can probe without RPMB.
> >
> > >
> > > How about for the time being we defer fTPM probe until RPMB is availabl=
e?
> >
> > Sounds a bit like what we do with the
> > optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP) call when
> > tee-supplicant has opened the supplicant device. It would perhaps work
> > with a PTA_CMD_GET_DEVICES_RPMB or such.
>
> That sounds much better, it will be like an OP-TEE driver callback
> (optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB)) registered with
> the RPMB subsystem. But we should check if all the RPMB partitions are
> registered before we invoke the callbacks such that OP-TEE will have a
> chance to select the right one.

I agree, we should wait until OP-TEE has found an RPMB device
programmed with the expected key as only OP-TEE should know that key.

Thanks,
Jens

>
> -Sumit
>
> >
> > Thanks,
> > Jens

--===============2616106276132081906==--

