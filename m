From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Wed, 07 Feb 2024 09:34:05 +0200
Message-ID: 
 <CAC_iWj+ho3Wy2cbZdgf4Uhd=9-iY-_411psuGZJwpvVwXnnyqw@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYNQoRg0PWgr1oCzrkMens7e0=m_zkBSXKvp8JVjmn2OZQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4752181392587100838=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4752181392587100838==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Feb 2024 at 08:11, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Ilias, Ulf,
>
> On Tue, 6 Feb 2024 at 20:41, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Ulf,
> >
> > On Tue, 6 Feb 2024 at 14:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Wed, 31 Jan 2024 at 18:44, Jens Wiklander <jens.wiklander@linaro.o=
rg> wrote:
> > > >
> > > > A number of storage technologies support a specialised hardware
> > > > partition designed to be resistant to replay attacks. The underlying
> > > > HW protocols differ but the operations are common. The RPMB partition
> > > > cannot be accessed via standard block layer, but by a set of specific
> > > > RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> > > > partition provides authenticated and replay protected access, hence
> > > > suitable as a secure storage.
> > > >
> > > > The initial aim of this patch is to provide a simple RPMB Driver which
> > > > can be accessed by the optee driver to facilitate early RPMB access to
> > > > OP-TEE OS (secure OS) during the boot time.
> > >
> > > How early do we expect OP-TEE to need RPMB access?
> >
> > It depends on the requested services. I am currently aware of 2
> > services that depend on the RPMB
> > - FirmwareTPM
> > - UEFI variables stored there via optee.
> >
> > For the FirmwareTPM it depends on when you want to use it. This
> > typically happens when the initramfs is loaded or systemd requests
> > access to the TPM. I guess this is late enough to not cause problems?
>
> Actually RPMB access is done as early as during fTPM probe, probably
> to cache NVRAM from RPMB during fTPM init. Also, there is a kernel
> user being IMA which would require fTPM access too. So we really need
> to manage dependencies here.

Ah true. I was wrongly assuming loading is a module and having systemd
or something similar handling that dependency. But in case this is
built-in we do need to handle that internally.


>
> >
> > For the latter, we won't need the supplicant until a write is
> > requested. This will only happen once the userspace is up and running.
> > The UEFI driver that sits behind OP-TEE has an in-memory cache of the
> > variables, so all the reads (the kernel invokes get_next_variable
> > during boot) are working without it.
> >
> > Thanks
> > /Ilias
> > >
> > > The way things work for mmc today, is that the eMMC card gets
> > > discovered/probed via a workqueue. The work is punted by the mmc host
> > > driver (typically a module-platform-driver), when it has probed
> > > successfully.
>
> It would be nice if RPMB is available as early as possible but for the
> time being we can try to see if probe deferral suffices for all
> use-cases.
>
> > >
> > > The point is, it looks like we need some kind of probe deferral
> > > mechanism too. Whether we want the OP-TEE driver to manage this itself
> > > or whether we should let rpmb_dev_find_device() deal with it, I don't
> > > know.
>
> I wouldn't like to see the OP-TEE driver probe being deferred due to
> this since there are other kernel drivers like OP-TEE RNG (should be
> available as early as we can) etc. which don't have any dependency on
> RPMB.
>
> How about for the time being we defer fTPM probe until RPMB is available?
>
> -Sumit

--===============4752181392587100838==--

