From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [RFC PATCH 0/4] Linaro restricted heap
Date: Fri, 30 Aug 2024 09:03:47 +0200
Message-ID: <20240830070351.2855919-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3541433790334214326=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3541433790334214326==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This patch set is based on top of Yong Wu's restricted heap patch set [1].
It's also a continuation on Olivier's Add dma-buf secure-heap patch set [2].

The Linaro restricted heap uses genalloc in the kernel to manage the heap
carvout. This is a difference from the Mediatek restricted heap which
relies on the secure world to manage the carveout.

I've tried to adress the comments on [2], but [1] introduces changes so I'm
afraid I've had to skip some comments.

This can be tested on QEMU with the following steps:
repo init -u https://github.com/jenswi-linaro/manifest.git -m qemu_v8.xml \
        -b prototype/sdp-v1
repo sync -j8
cd build
make toolchains -j4
make all -j$(nproc)
make run-only
# login and at the prompt:
xtest --sdp-basic

https://optee.readthedocs.io/en/latest/building/prerequisites.html
list dependencies needed to build the above.

The tests are pretty basic, mostly checking that a Trusted Application in
the secure world can access and manipulate the memory.

Cheers,
Jens

[1] https://lore.kernel.org/dri-devel/20240515112308.10171-1-yong.wu(a)mediat=
ek.com/
[2] https://lore.kernel.org/lkml/20220805135330.970-1-olivier.masse(a)nxp.com/

Changes since Olivier's post [2]:
* Based on Yong Wu's post [1] where much of dma-buf handling is done in
  the generic restricted heap
* Simplifications and cleanup
* New commit message for "dma-buf: heaps: add Linaro restricted dmabuf heap
  support"
* Replaced the word "secure" with "restricted" where applicable

Etienne Carriere (1):
  tee: new ioctl to a register tee_shm from a dmabuf file descriptor

Jens Wiklander (2):
  dma-buf: heaps: restricted_heap: add no_map attribute
  dma-buf: heaps: add Linaro restricted dmabuf heap support

Olivier Masse (1):
  dt-bindings: reserved-memory: add linaro,restricted-heap

 .../linaro,restricted-heap.yaml               |  56 ++++++
 drivers/dma-buf/heaps/Kconfig                 |  10 ++
 drivers/dma-buf/heaps/Makefile                |   1 +
 drivers/dma-buf/heaps/restricted_heap.c       |  17 +-
 drivers/dma-buf/heaps/restricted_heap.h       |   2 +
 .../dma-buf/heaps/restricted_heap_linaro.c    | 165 ++++++++++++++++++
 drivers/tee/tee_core.c                        |  38 ++++
 drivers/tee/tee_shm.c                         | 104 ++++++++++-
 include/linux/tee_drv.h                       |  11 ++
 include/uapi/linux/tee.h                      |  29 +++
 10 files changed, 426 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/linaro,=
restricted-heap.yaml
 create mode 100644 drivers/dma-buf/heaps/restricted_heap_linaro.c

--=20
2.34.1


--===============3541433790334214326==--

