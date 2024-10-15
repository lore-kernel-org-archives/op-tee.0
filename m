From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [RFC PATCH v2 0/2] TEE subsystem for restricted dma-buf allocations
Date: Tue, 15 Oct 2024 12:15:32 +0200
Message-ID: <20241015101716.740829-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3613000229067036571=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3613000229067036571==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This patch set allocates the restricted DMA-bufs via the TEE subsystem.
This a complete rewrite compared to the previous patch set [1], and other
earlier proposals [2] and [3] with a separate restricted heap.

The TEE subsystem handles the DMA-buf allocations since it is the TEE
(OP-TEE, AMD-TEE, TS-TEE, or a future QTEE) which sets up the restrictions
for the memory used for the DMA-bufs.

I've added a new IOCTL, TEE_IOC_RSTMEM_ALLOC, to allocate the restricted
DMA-bufs. This new IOCTL reaches the backend TEE driver, allowing it to
choose how to allocate the restricted physical memory.

TEE_IOC_RSTMEM_ALLOC is quite similar to TEE_IOC_SHM_ALLOC so it's tempting
to extend TEE_IOC_SHM_ALLOC with two new flags
TEE_IOC_SHM_FLAG_SECURE_VIDEO and TEE_IOC_SHM_FLAG_SECURE_TRUSTED_UI for
the same feature. However, it might be a bit confusing since
TEE_IOC_SHM_ALLOC only returns an anonymous file descriptor, but
TEE_IOC_SHM_FLAG_SECURE_VIDEO and TEE_IOC_SHM_FLAG_SECURE_TRUSTED_UI would
return a DMA-buf file descriptor instead. What do others think?

This can be tested on QEMU with the following steps:
repo init -u https://github.com/jenswi-linaro/manifest.git -m qemu_v8.xml \
        -b prototype/sdp-v2
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
the secure world can access and manipulate the memory. There are also some
negative tests for out of bounds buffers etc.

Thanks,
Jens

[1] https://lore.kernel.org/lkml/20240830070351.2855919-1-jens.wiklander(a)li=
naro.org/
[2] https://lore.kernel.org/dri-devel/20240515112308.10171-1-yong.wu(a)mediat=
ek.com/
[3] https://lore.kernel.org/lkml/20220805135330.970-1-olivier.masse(a)nxp.com/

Changes since the V1 RFC:
* Based on v6.11
* Complete rewrite, replacing the restricted heap with TEE_IOC_RSTMEM_ALLOC

Changes since Olivier's post [2]:
* Based on Yong Wu's post [1] where much of dma-buf handling is done in
  the generic restricted heap
* Simplifications and cleanup
* New commit message for "dma-buf: heaps: add Linaro restricted dmabuf heap
  support"
* Replaced the word "secure" with "restricted" where applicable

Jens Wiklander (2):
  tee: add restricted memory allocation
  optee: support restricted memory allocation

 drivers/tee/Makefile              |   1 +
 drivers/tee/optee/core.c          |  21 ++++
 drivers/tee/optee/optee_private.h |   6 +
 drivers/tee/optee/optee_smc.h     |  35 ++++++
 drivers/tee/optee/smc_abi.c       |  45 ++++++-
 drivers/tee/tee_core.c            |  33 ++++-
 drivers/tee/tee_private.h         |   2 +
 drivers/tee/tee_rstmem.c          | 200 ++++++++++++++++++++++++++++++
 drivers/tee/tee_shm.c             |   2 +
 drivers/tee/tee_shm_pool.c        |  69 ++++++++++-
 include/linux/tee_core.h          |   6 +
 include/linux/tee_drv.h           |   9 ++
 include/uapi/linux/tee.h          |  33 ++++-
 13 files changed, 455 insertions(+), 7 deletions(-)
 create mode 100644 drivers/tee/tee_rstmem.c

--=20
2.43.0


--===============3613000229067036571==--

