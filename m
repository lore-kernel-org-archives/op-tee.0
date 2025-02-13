From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
Date: Thu, 13 Feb 2025 09:19:21 +0100
Message-ID: 
 <CAHUa44FtXA8bOS1-BAGSrCFLxu_FRd2TaEtxGNdkzKua_-wNUQ@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYOaGEPj0xNEDBCoEmjJreEHChjQ2hyXRJ_CYoGhiBonfw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4066860393404034150=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4066860393404034150==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 13, 2025 at 7:42=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> Hi Boris,
>
> On Thu, 13 Feb 2025 at 01:26, Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > +Florent, who's working on protected-mode support in Panthor.
> >
> > Hi Jens,
> >
> > On Tue, 17 Dec 2024 11:07:36 +0100
> > Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > > Hi,
> > >
> > > This patch set allocates the restricted DMA-bufs via the TEE subsystem.
> >
> > We're currently working on protected-mode support for Panthor [1] and it
> > looks like your series (and the OP-TEE implementation that goes with
> > it) would allow us to have a fully upstream/open solution for the
> > protected content use case we're trying to support. I need a bit more
> > time to play with the implementation but this looks very promising
> > (especially the lend rstmem feature, which might help us allocate our
> > FW sections that are supposed to execute code accessing protected
> > content).
>
> Glad to hear that, if you can demonstrate an open source use case
> based on this series then it will help to land it. We really would
> love to see support for restricted DMA-buf consumers be it GPU, crypto
> accelerator, media pipeline etc.

I'm preparing a demo based on GStreamer to share. It helps with more
real-world examples to see that APIs etc work.

>
> >
> > >
> > > The TEE subsystem handles the DMA-buf allocations since it is the TEE
> > > (OP-TEE, AMD-TEE, TS-TEE, or perhaps a future QCOMTEE) which sets up the
> > > restrictions for the memory used for the DMA-bufs.
> > >
> > > I've added a new IOCTL, TEE_IOC_RSTMEM_ALLOC, to allocate the restricted
> > > DMA-bufs. This IOCTL reaches the backend TEE driver, allowing it to cho=
ose
> > > how to allocate the restricted physical memory.
> >
> > I'll probably have more questions soon, but here's one to start: any
> > particular reason you didn't go for a dma-heap to expose restricted
> > buffer allocation to userspace? I see you already have a cdev you can
> > take ioctl()s from, but my understanding was that dma-heap was the
> > standard solution for these device-agnostic/central allocators.
>
> This series started with the DMA heap approach only here [1] but later
> discussions [2] lead us here. To point out specifically:
>
> - DMA heaps require reliance on DT to discover static restricted
> regions carve-outs whereas via the TEE implementation driver (eg.
> OP-TEE) those can be discovered dynamically.
> - Dynamic allocation of buffers and making them restricted requires
> vendor specific driver hooks with DMA heaps whereas the TEE subsystem
> abstracts that out with underlying TEE implementation (eg. OP-TEE)
> managing the dynamic buffer restriction.
> - TEE subsystem already has a well defined user-space interface for
> managing shared memory buffers with TEE and restricted DMA buffers
> will be yet another interface managed along similar lines.
>
> [1] https://lore.kernel.org/lkml/mzur3odofwwrdqnystozjgf3qtvb73wqjm6g2vf5df=
sqiehaxk(a)u67fcarhm6ge/T/
> [2] https://lore.kernel.org/lkml/CAFA6WYPtp3H5JhxzgH9=3Dz2EvNL7Kdku3EmG1aDk=
TS-gjFtNZZA(a)mail.gmail.com/

Thanks for the good summary. :-)

Cheers,
Jens

>
> -Sumit
>
> >
> > Regards,
> >
> > Boris
> >
> > [1]https://lwn.net/ml/all/cover.1738228114.git.florent.tomasin(a)arm.com/=
#t

--===============4066860393404034150==--

