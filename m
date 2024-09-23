From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH 0/4] Linaro restricted heap
Date: Mon, 23 Sep 2024 09:33:29 +0300
Message-ID: <dhxvyshwi4qmcmwceokhqey2ww4azjcs6qrpnkgivdj7tv5cke@r36srvvbof6q>
In-Reply-To: <20240830070351.2855919-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7757962928715394778=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7757962928715394778==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 30, 2024 at 09:03:47AM GMT, Jens Wiklander wrote:
> Hi,
>=20
> This patch set is based on top of Yong Wu's restricted heap patch set [1].
> It's also a continuation on Olivier's Add dma-buf secure-heap patch set [2].
>=20
> The Linaro restricted heap uses genalloc in the kernel to manage the heap
> carvout. This is a difference from the Mediatek restricted heap which
> relies on the secure world to manage the carveout.
>=20
> I've tried to adress the comments on [2], but [1] introduces changes so I'm
> afraid I've had to skip some comments.

I know I have raised the same question during LPC (in connection to
Qualcomm's dma-heap implementation). Is there any reason why we are
using generic heaps instead of allocating the dma-bufs on the device
side?

In your case you already have TEE device, you can use it to allocate and
export dma-bufs, which then get imported by the V4L and DRM drivers.

I have a feeling (I might be completely wrong here) that by using
generic dma-buf heaps we can easily end up in a situation when the
userspace depends heavily on the actual platform being used (to map the
platform to heap names). I think we should instead depend on the
existing devices (e.g. if there is a TEE device, use an IOCTL to
allocate secured DMA BUF from it, otherwise check for QTEE device,
otherwise check for some other vendor device).

The mental experiment to check if the API is correct is really simple:
Can you use exactly the same rootfs on several devices without
any additional tuning (e.g. your QEMU, HiKey, a Mediatek board, Qualcomm
laptop, etc)?

>=20
> This can be tested on QEMU with the following steps:
> repo init -u https://github.com/jenswi-linaro/manifest.git -m qemu_v8.xml \
>         -b prototype/sdp-v1
> repo sync -j8
> cd build
> make toolchains -j4
> make all -j$(nproc)
> make run-only
> # login and at the prompt:
> xtest --sdp-basic
>=20
> https://optee.readthedocs.io/en/latest/building/prerequisites.html
> list dependencies needed to build the above.
>=20
> The tests are pretty basic, mostly checking that a Trusted Application in
> the secure world can access and manipulate the memory.

- Can we test that the system doesn't crash badly if user provides
  non-secured memory to the users which expect a secure buffer?

- At the same time corresponding entities shouldn't decode data to the
  buffers accessible to the rest of the sytem.

>=20
> Cheers,
> Jens
>=20
> [1] https://lore.kernel.org/dri-devel/20240515112308.10171-1-yong.wu(a)medi=
atek.com/
> [2] https://lore.kernel.org/lkml/20220805135330.970-1-olivier.masse(a)nxp.c=
om/
>=20
> Changes since Olivier's post [2]:
> * Based on Yong Wu's post [1] where much of dma-buf handling is done in
>   the generic restricted heap
> * Simplifications and cleanup
> * New commit message for "dma-buf: heaps: add Linaro restricted dmabuf heap
>   support"
> * Replaced the word "secure" with "restricted" where applicable
>=20
> Etienne Carriere (1):
>   tee: new ioctl to a register tee_shm from a dmabuf file descriptor
>=20
> Jens Wiklander (2):
>   dma-buf: heaps: restricted_heap: add no_map attribute
>   dma-buf: heaps: add Linaro restricted dmabuf heap support
>=20
> Olivier Masse (1):
>   dt-bindings: reserved-memory: add linaro,restricted-heap
>=20
>  .../linaro,restricted-heap.yaml               |  56 ++++++
>  drivers/dma-buf/heaps/Kconfig                 |  10 ++
>  drivers/dma-buf/heaps/Makefile                |   1 +
>  drivers/dma-buf/heaps/restricted_heap.c       |  17 +-
>  drivers/dma-buf/heaps/restricted_heap.h       |   2 +
>  .../dma-buf/heaps/restricted_heap_linaro.c    | 165 ++++++++++++++++++
>  drivers/tee/tee_core.c                        |  38 ++++
>  drivers/tee/tee_shm.c                         | 104 ++++++++++-
>  include/linux/tee_drv.h                       |  11 ++
>  include/uapi/linux/tee.h                      |  29 +++
>  10 files changed, 426 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/linar=
o,restricted-heap.yaml
>  create mode 100644 drivers/dma-buf/heaps/restricted_heap_linaro.c
>=20
> --=20
> 2.34.1
>=20

--=20
With best wishes
Dmitry

--===============7757962928715394778==--

