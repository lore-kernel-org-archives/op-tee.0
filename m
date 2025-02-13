From: Boris Brezillon <boris.brezillon@collabora.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
Date: Thu, 13 Feb 2025 13:40:08 +0100
Message-ID: <20250213134008.4cbef142@collabora.com>
In-Reply-To: <
 <CAFA6WYOJkSRsH-15QdqXNMd08Q=Dg4NkRd1Cr9LXA+5nozTF6g@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5229088927039510340=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5229088927039510340==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Feb 2025 14:46:01 +0530
Sumit Garg <sumit.garg@linaro.org> wrote:

> On Thu, 13 Feb 2025 at 14:06, Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > On Thu, 13 Feb 2025 12:11:52 +0530
> > Sumit Garg <sumit.garg@linaro.org> wrote:
> > =20
> > > Hi Boris,
> > >
> > > On Thu, 13 Feb 2025 at 01:26, Boris Brezillon
> > > <boris.brezillon@collabora.com> wrote: =20
> > > >
> > > > +Florent, who's working on protected-mode support in Panthor.
> > > >
> > > > Hi Jens,
> > > >
> > > > On Tue, 17 Dec 2024 11:07:36 +0100
> > > > Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > > > =20
> > > > > Hi,
> > > > >
> > > > > This patch set allocates the restricted DMA-bufs via the TEE subsys=
tem. =20
> > > >
> > > > We're currently working on protected-mode support for Panthor [1] and=
 it
> > > > looks like your series (and the OP-TEE implementation that goes with
> > > > it) would allow us to have a fully upstream/open solution for the
> > > > protected content use case we're trying to support. I need a bit more
> > > > time to play with the implementation but this looks very promising
> > > > (especially the lend rstmem feature, which might help us allocate our
> > > > FW sections that are supposed to execute code accessing protected
> > > > content). =20
> > >
> > > Glad to hear that, if you can demonstrate an open source use case
> > > based on this series then it will help to land it. We really would
> > > love to see support for restricted DMA-buf consumers be it GPU, crypto
> > > accelerator, media pipeline etc.
> > > =20
> > > > =20
> > > > >
> > > > > The TEE subsystem handles the DMA-buf allocations since it is the T=
EE
> > > > > (OP-TEE, AMD-TEE, TS-TEE, or perhaps a future QCOMTEE) which sets u=
p the
> > > > > restrictions for the memory used for the DMA-bufs.
> > > > >
> > > > > I've added a new IOCTL, TEE_IOC_RSTMEM_ALLOC, to allocate the restr=
icted
> > > > > DMA-bufs. This IOCTL reaches the backend TEE driver, allowing it to=
 choose
> > > > > how to allocate the restricted physical memory. =20
> > > >
> > > > I'll probably have more questions soon, but here's one to start: any
> > > > particular reason you didn't go for a dma-heap to expose restricted
> > > > buffer allocation to userspace? I see you already have a cdev you can
> > > > take ioctl()s from, but my understanding was that dma-heap was the
> > > > standard solution for these device-agnostic/central allocators. =20
> > >
> > > This series started with the DMA heap approach only here [1] but later
> > > discussions [2] lead us here. To point out specifically:
> > >
> > > - DMA heaps require reliance on DT to discover static restricted
> > > regions carve-outs whereas via the TEE implementation driver (eg.
> > > OP-TEE) those can be discovered dynamically. =20
> >
> > Hm, the system heap [1] doesn't rely on any DT information AFAICT. =20
>=20
> Yeah but all the prior vendor specific secure/restricted DMA heaps
> relied on DT information.

Right, but there's nothing in the DMA heap provider API forcing that.

>=20
> > The dynamic allocation scheme, where the TEE implementation allocates a
> > chunk of protected memory for us would have a similar behavior, I guess. =
=20
>=20
> In a dynamic scheme, the allocation will still be from CMA or system
> heap depending on TEE implementation capabilities but the restriction
> will be enforced via interaction with TEE.

Sorry, that's a wording issue. By dynamic allocation I meant the mode
where allocations goes through the TEE, not the lend rstmem thing. BTW,
calling the lend mode dynamic-allocation is kinda confusing, because in
a sense, both modes can be considered dynamic allocation from the user
PoV. I get that when the TEE allocates memory, it's picking from its
fixed address/size pool, hence the name, but when I first read this, I
thought the dynamic mode was the other one, and the static mode was the
one where you reserve a mem range from the DT, query it from the driver
and pass it to the TEE to restrict access post reservation/static
allocation.

>=20
> > =20
> > > - Dynamic allocation of buffers and making them restricted requires
> > > vendor specific driver hooks with DMA heaps whereas the TEE subsystem
> > > abstracts that out with underlying TEE implementation (eg. OP-TEE)
> > > managing the dynamic buffer restriction. =20
> >
> > Yeah, the lend rstmem feature is clearly something tee specific, and I
> > think that's okay to assume the user knows the protection request
> > should go through the tee subsystem in that case. =20
>=20
> Yeah but how will the user discover that?

There's nothing to discover here. It would just be explicitly specified:

- for in-kernel users it can be a module parameter (or a DT prop if
  that's deemed acceptable)
- for userspace, it can be an envvar, a config file, or whatever the
  app/lib uses to get config options

> Rather than that it's better
> for the user to directly ask the TEE device to allocate restricted
> memory without worrying about how the memory restriction gets
> enforced.

If the consensus is that restricted/protected memory allocation should
always be routed to the TEE, sure, but I had the feeling this wasn't as
clear as that. OTOH, using a dma-heap to expose the TEE-SDP
implementation provides the same benefits, without making potential
future non-TEE based implementations a pain for users. The dma-heap
ioctl being common to all implementations, it just becomes a
configuration matter if we want to change the heap we rely on for
protected/restricted buffer allocation. And because heaps have
unique/well-known names, users can still default to (or rely solely on)
the TEE-SPD implementation if they want.

>=20
> > =20
> > > - TEE subsystem already has a well defined user-space interface for
> > > managing shared memory buffers with TEE and restricted DMA buffers
> > > will be yet another interface managed along similar lines. =20
> >
> > Okay, so the very reason I'm asking about the dma-buf heap interface is
> > because there might be cases where the protected/restricted allocation
> > doesn't go through the TEE (Mediatek has a TEE-free implementation
> > for instance, but I realize vendor implementations are probably not the
> > best selling point :-/). =20
>=20
> You can always have a system with memory and peripheral access
> permissions setup during boot (or even have a pre-configured hardware
> as a special case) prior to booting up the kernel too. But that even
> gets somehow configured by a TEE implementation during boot, so
> calling it a TEE-free implementation seems over-simplified and not a
> scalable solution. However, this patchset [1] from Mediatek requires
> runtime TEE interaction too.
>=20
> [1] https://lore.kernel.org/linux-arm-kernel/20240515112308.10171-1-yong.wu=
(a)mediatek.com/
>=20
> > If we expose things as a dma-heap, we have
> > a solution where integrators can pick the dma-heap they think is
> > relevant for protected buffer allocations without the various drivers
> > (GPU, video codec, ...) having to implement a dispatch function for all
> > possible implementations. The same goes for userspace allocations,
> > where passing a dma-heap name, is simpler than supporting different
> > ioctl()s based on the allocation backend. =20
>=20
> There have been several attempts with DMA heaps in the past which all
> resulted in a very vendor specific vertically integrated solution. But
> the solution with TEE subsystem aims to make it generic and vendor
> agnostic.

Just because all previous protected/restricted dma-heap effort
failed to make it upstream, doesn't mean dma-heap is the wrong way of
exposing this feature IMHO.

Regards,

Boris

--===============5229088927039510340==--

