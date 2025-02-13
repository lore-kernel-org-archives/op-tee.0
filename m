From: Boris Brezillon <boris.brezillon@collabora.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
Date: Thu, 13 Feb 2025 09:35:57 +0100
Message-ID: <20250213093557.278f5d19@collabora.com>
In-Reply-To: <
 <CAFA6WYOaGEPj0xNEDBCoEmjJreEHChjQ2hyXRJ_CYoGhiBonfw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9202121383797334027=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9202121383797334027==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Feb 2025 12:11:52 +0530
Sumit Garg <sumit.garg@linaro.org> wrote:

> Hi Boris,
>=20
> On Thu, 13 Feb 2025 at 01:26, Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > +Florent, who's working on protected-mode support in Panthor.
> >
> > Hi Jens,
> >
> > On Tue, 17 Dec 2024 11:07:36 +0100
> > Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > =20
> > > Hi,
> > >
> > > This patch set allocates the restricted DMA-bufs via the TEE subsystem.=
 =20
> >
> > We're currently working on protected-mode support for Panthor [1] and it
> > looks like your series (and the OP-TEE implementation that goes with
> > it) would allow us to have a fully upstream/open solution for the
> > protected content use case we're trying to support. I need a bit more
> > time to play with the implementation but this looks very promising
> > (especially the lend rstmem feature, which might help us allocate our
> > FW sections that are supposed to execute code accessing protected
> > content). =20
>=20
> Glad to hear that, if you can demonstrate an open source use case
> based on this series then it will help to land it. We really would
> love to see support for restricted DMA-buf consumers be it GPU, crypto
> accelerator, media pipeline etc.
>=20
> > =20
> > >
> > > The TEE subsystem handles the DMA-buf allocations since it is the TEE
> > > (OP-TEE, AMD-TEE, TS-TEE, or perhaps a future QCOMTEE) which sets up the
> > > restrictions for the memory used for the DMA-bufs.
> > >
> > > I've added a new IOCTL, TEE_IOC_RSTMEM_ALLOC, to allocate the restricted
> > > DMA-bufs. This IOCTL reaches the backend TEE driver, allowing it to cho=
ose
> > > how to allocate the restricted physical memory. =20
> >
> > I'll probably have more questions soon, but here's one to start: any
> > particular reason you didn't go for a dma-heap to expose restricted
> > buffer allocation to userspace? I see you already have a cdev you can
> > take ioctl()s from, but my understanding was that dma-heap was the
> > standard solution for these device-agnostic/central allocators. =20
>=20
> This series started with the DMA heap approach only here [1] but later
> discussions [2] lead us here. To point out specifically:
>=20
> - DMA heaps require reliance on DT to discover static restricted
> regions carve-outs whereas via the TEE implementation driver (eg.
> OP-TEE) those can be discovered dynamically.

Hm, the system heap [1] doesn't rely on any DT information AFAICT.
The dynamic allocation scheme, where the TEE implementation allocates a
chunk of protected memory for us would have a similar behavior, I guess.

> - Dynamic allocation of buffers and making them restricted requires
> vendor specific driver hooks with DMA heaps whereas the TEE subsystem
> abstracts that out with underlying TEE implementation (eg. OP-TEE)
> managing the dynamic buffer restriction.

Yeah, the lend rstmem feature is clearly something tee specific, and I
think that's okay to assume the user knows the protection request
should go through the tee subsystem in that case.

> - TEE subsystem already has a well defined user-space interface for
> managing shared memory buffers with TEE and restricted DMA buffers
> will be yet another interface managed along similar lines.

Okay, so the very reason I'm asking about the dma-buf heap interface is
because there might be cases where the protected/restricted allocation
doesn't go through the TEE (Mediatek has a TEE-free implementation
for instance, but I realize vendor implementations are probably not the
best selling point :-/). If we expose things as a dma-heap, we have
a solution where integrators can pick the dma-heap they think is
relevant for protected buffer allocations without the various drivers
(GPU, video codec, ...) having to implement a dispatch function for all
possible implementations. The same goes for userspace allocations,
where passing a dma-heap name, is simpler than supporting different
ioctl()s based on the allocation backend.

[1]https://elixir.bootlin.com/linux/v6.13.2/source/drivers/dma-buf/heaps/syst=
em_heap.c#L424

--===============9202121383797334027==--

