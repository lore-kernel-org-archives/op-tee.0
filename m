From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH 0/4] Linaro restricted heap
Date: Wed, 25 Sep 2024 14:53:34 +0200
Message-ID: 
 <CAHUa44EvgcUg0QFvwsgU6BSs_BtZg6bO_5rx3CJbyCUPbiQZXQ@mail.gmail.com>
In-Reply-To: <bktt4yanmfn4gjljy2wxmigj6mncpga237oxyf4g4h2vxu2a3q@asnsn7smi4u2>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0457418474100190939=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0457418474100190939==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 1:41=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, Sep 25, 2024 at 09:15:04AM GMT, Jens Wiklander wrote:
> > On Mon, Sep 23, 2024 at 09:33:29AM +0300, Dmitry Baryshkov wrote:
> > > Hi,
> > >
> > > On Fri, Aug 30, 2024 at 09:03:47AM GMT, Jens Wiklander wrote:
> > > > Hi,
> > > >
> > > > This patch set is based on top of Yong Wu's restricted heap patch set=
 [1].
> > > > It's also a continuation on Olivier's Add dma-buf secure-heap patch s=
et [2].
> > > >
> > > > The Linaro restricted heap uses genalloc in the kernel to manage the =
heap
> > > > carvout. This is a difference from the Mediatek restricted heap which
> > > > relies on the secure world to manage the carveout.
> > > >
> > > > I've tried to adress the comments on [2], but [1] introduces changes =
so I'm
> > > > afraid I've had to skip some comments.
> > >
> > > I know I have raised the same question during LPC (in connection to
> > > Qualcomm's dma-heap implementation). Is there any reason why we are
> > > using generic heaps instead of allocating the dma-bufs on the device
> > > side?
> > >
> > > In your case you already have TEE device, you can use it to allocate and
> > > export dma-bufs, which then get imported by the V4L and DRM drivers.
> > >
> > > I have a feeling (I might be completely wrong here) that by using
> > > generic dma-buf heaps we can easily end up in a situation when the
> > > userspace depends heavily on the actual platform being used (to map the
> > > platform to heap names). I think we should instead depend on the
> > > existing devices (e.g. if there is a TEE device, use an IOCTL to
> > > allocate secured DMA BUF from it, otherwise check for QTEE device,
> > > otherwise check for some other vendor device).
> >
> > That makes sense, it's similar to what we do with TEE_IOC_SHM_ALLOC
> > where we allocate from a carveout reserverd for shared memory with the
> > secure world. It was even based on dma-buf until commit dfd0743f1d9e
> > ("tee: handle lookup of shm with reference count 0").
> >
> > We should use a new TEE_IOC_*_ALLOC for these new dma-bufs to avoid
> > confusion and to have more freedom when designing the interface.
> >
> > >
> > > The mental experiment to check if the API is correct is really simple:
> > > Can you use exactly the same rootfs on several devices without
> > > any additional tuning (e.g. your QEMU, HiKey, a Mediatek board, Qualcomm
> > > laptop, etc)?
> >
> > No, I don't think so.
>
> Then the API needs to be modified.

I don't think that is enough. I would have answered no even without
the secure data path in mind. Communication with the secure world is
still too fragmented.

>
> Or the userspace needs to be modified in the way similar to Vulkan /
> OpenCL / glvnd / VA / VDPU: platform-specific backends, coexisting on a
> single rootfs.

Yes, that's likely a needed step. But the first step is to have
something to relate to upstream, without that there's only an
ever-changing downstream ABI.

>
> It is more or less fine to have platform-specific rootfs when we are
> talking about the embedded, resource-limited devices. But for the
> end-user devices we must be able to install a generic distro with no
> device-specific packages being selected.

I'm not sure we can solve that problem here. But we should of course
not make matters worse. In the restricted heap patch set which this
patchset builds on we define a way to allocate memory from a
restricted heap, but we leave the problem of finding the right heap to
userspace.

Thanks,
Jens

>
> >
> > >
> > > >
> > > > This can be tested on QEMU with the following steps:
> > > > repo init -u https://github.com/jenswi-linaro/manifest.git -m qemu_v8=
.xml \
> > > >         -b prototype/sdp-v1
> > > > repo sync -j8
> > > > cd build
> > > > make toolchains -j4
> > > > make all -j$(nproc)
> > > > make run-only
> > > > # login and at the prompt:
> > > > xtest --sdp-basic
> > > >
> > > > https://optee.readthedocs.io/en/latest/building/prerequisites.html
> > > > list dependencies needed to build the above.
> > > >
> > > > The tests are pretty basic, mostly checking that a Trusted Applicatio=
n in
> > > > the secure world can access and manipulate the memory.
> > >
> > > - Can we test that the system doesn't crash badly if user provides
> > >   non-secured memory to the users which expect a secure buffer?
> > >
> > > - At the same time corresponding entities shouldn't decode data to the
> > >   buffers accessible to the rest of the sytem.
> >
> > I'll a few tests along that.
> >
> > Thanks,
> > Jens
> >
> > >
> > > >
> > > > Cheers,
> > > > Jens
> > > >
> > > > [1] https://lore.kernel.org/dri-devel/20240515112308.10171-1-yong.wu(=
a)mediatek.com/
> > > > [2] https://lore.kernel.org/lkml/20220805135330.970-1-olivier.masse(a=
)nxp.com/
> > > >
> > > > Changes since Olivier's post [2]:
> > > > * Based on Yong Wu's post [1] where much of dma-buf handling is done =
in
> > > >   the generic restricted heap
> > > > * Simplifications and cleanup
> > > > * New commit message for "dma-buf: heaps: add Linaro restricted dmabu=
f heap
> > > >   support"
> > > > * Replaced the word "secure" with "restricted" where applicable
> > > >
> > > > Etienne Carriere (1):
> > > >   tee: new ioctl to a register tee_shm from a dmabuf file descriptor
> > > >
> > > > Jens Wiklander (2):
> > > >   dma-buf: heaps: restricted_heap: add no_map attribute
> > > >   dma-buf: heaps: add Linaro restricted dmabuf heap support
> > > >
> > > > Olivier Masse (1):
> > > >   dt-bindings: reserved-memory: add linaro,restricted-heap
> > > >
> > > >  .../linaro,restricted-heap.yaml               |  56 ++++++
> > > >  drivers/dma-buf/heaps/Kconfig                 |  10 ++
> > > >  drivers/dma-buf/heaps/Makefile                |   1 +
> > > >  drivers/dma-buf/heaps/restricted_heap.c       |  17 +-
> > > >  drivers/dma-buf/heaps/restricted_heap.h       |   2 +
> > > >  .../dma-buf/heaps/restricted_heap_linaro.c    | 165 ++++++++++++++++=
++
> > > >  drivers/tee/tee_core.c                        |  38 ++++
> > > >  drivers/tee/tee_shm.c                         | 104 ++++++++++-
> > > >  include/linux/tee_drv.h                       |  11 ++
> > > >  include/uapi/linux/tee.h                      |  29 +++
> > > >  10 files changed, 426 insertions(+), 7 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/reserved-memory=
/linaro,restricted-heap.yaml
> > > >  create mode 100644 drivers/dma-buf/heaps/restricted_heap_linaro.c
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
> --
> With best wishes
> Dmitry

--===============0457418474100190939==--

