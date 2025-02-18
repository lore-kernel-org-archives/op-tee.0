From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v5 0/7] TEE subsystem for restricted dma-buf allocations
Date: Tue, 18 Feb 2025 15:34:49 +0100
Message-ID: <20250218143527.1236668-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0425572323921925594=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0425572323921925594==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

[Now with a Gstreamer demo, see below.]

This patch set allocates the restricted DMA-bufs via the TEE subsystem.

The TEE subsystem handles the DMA-buf allocations since it is the TEE
(OP-TEE, AMD-TEE, TS-TEE, or perhaps a future QCOMTEE) which sets up the
restrictions for the memory used for the DMA-bufs.

I've added a new IOCTL, TEE_IOC_RSTMEM_ALLOC, to allocate the restricted
DMA-bufs. This IOCTL reaches the backend TEE driver, allowing it to choose
how to allocate the restricted physical memory.

TEE_IOC_RSTMEM_ALLOC takes in addition to a size and flags parameters also
a use-case parameter. This is used by the backend TEE driver to decide on
allocation policy and which devices should be able to access the memory.

Three use-cases (Secure Video Playback, Trusted UI, and Secure Video
Recording) has been identified so far to serve as examples of what can be
expected. More use-cases can be added in userspace ABI, but it's up to the
backend TEE drivers to provide the implementation.

Each use-case has it's own restricted memory pool since different use-cases
requires isolation from different parts of the system. A restricted memory
pool can be based on a static carveout instantiated while probing the TEE
backend driver, or dynamically allocated from CMA and made restricted as
needed by the TEE.

This can be tested on a RockPi 4B+ with the following steps:
repo init -u https://github.com/jenswi-linaro/manifest.git -m rockpi4.xml \
        -b prototype/sdp-v5
repo sync -j8
cd build
make toolchains -j$(nproc)
make all -j$(nproc)
# Copy ../out/rockpi4.img to an SD card and boot the RockPi from that
# Connect a monitor to the RockPi
# login and at the prompt:
gst-launch-1.0 videotestsrc ! \
        aesenc key=3D1f9423681beb9a79215820f6bda73d0f \
                iv=3De9aa8e834d8d70b7e0d254ff670dd718 serialize-iv=3Dtrue ! \
        aesdec key=3D1f9423681beb9a79215820f6bda73d0f ! \
        kmssink

The aesdec module has been hacked to use an OP-TEE TA to decrypt the stream
into restricted DMA-bufs which are consumed by the kmssink.

The primitive QEMU tests from previous patch set can be tested on RockPi
in the same way with:
xtest --sdp-basic

The primitive test are tested on QEMU with the following steps:
repo init -u https://github.com/jenswi-linaro/manifest.git -m qemu_v8.xml \
        -b prototype/sdp-v5
repo sync -j8
cd build
make toolchains -j$(nproc)
make SPMC_AT_EL=3D1 all -j$(nproc)
make SPMC_AT_EL=3D1 run-only
# login and at the prompt:
xtest --sdp-basic

The SPMC_AT_EL=3D1 parameter configures the build with FF-A and an SPMC at
S-EL1 inside OP-TEE. The parameter can be changed into SPMC_AT_EL=3Dn to test
without FF-A using the original SMC ABI instead. Please remember to do
%rm -rf ../trusted-firmware-a/build/qemu
for TF-A to be rebuilt properly using the new configuration.

https://optee.readthedocs.io/en/latest/building/prerequisites.html
list dependencies needed to build the above.

The tests are pretty basic, mostly checking that a Trusted Application in
the secure world can access and manipulate the memory. There are also some
negative tests for out of bounds buffers etc.

Thanks,
Jens

Changes since V4:
* Adding the patch "tee: add TEE_IOC_RSTMEM_FD_INFO" needed by the
  GStreamer demo
* Removing the dummy CPU access and mmap functions from the dma_buf_ops
* Fixing a compile error in "optee: FF-A: dynamic restricted memory allocatio=
n"
  reported by kernel test robot <lkp@intel.com>

Changes since V3:
* Make the use_case and flags field in struct tee_shm u32's instead of
  u16's
* Add more description for TEE_IOC_RSTMEM_ALLOC in the header file
* Import namespace DMA_BUF in module tee, reported by lkp(a)intel.com
* Added a note in the commit message for "optee: account for direction
  while converting parameters" why it's needed
* Factor out dynamic restricted memory allocation from
  "optee: support restricted memory allocation" into two new commits
  "optee: FF-A: dynamic restricted memory allocation" and
  "optee: smc abi: dynamic restricted memory allocation"
* Guard CMA usage with #ifdef CONFIG_CMA, effectively disabling dynamic
  restricted memory allocate if CMA isn't configured

Changes since the V2 RFC:
* Based on v6.12
* Replaced the flags for SVP and Trusted UID memory with a u32 field with
  unique id for each use case
* Added dynamic allocation of restricted memory pools
* Added OP-TEE ABI both with and without FF-A for dynamic restricted memory
* Added support for FF-A with FFA_LEND

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

Jens Wiklander (7):
  tee: add restricted memory allocation
  tee: add TEE_IOC_RSTMEM_FD_INFO
  optee: account for direction while converting parameters
  optee: sync secure world ABI headers
  optee: support restricted memory allocation
  optee: FF-A: dynamic restricted memory allocation
  optee: smc abi: dynamic restricted memory allocation

 drivers/tee/Makefile              |   1 +
 drivers/tee/optee/Makefile        |   1 +
 drivers/tee/optee/call.c          |  10 +-
 drivers/tee/optee/core.c          |   1 +
 drivers/tee/optee/ffa_abi.c       | 179 +++++++++++++-
 drivers/tee/optee/optee_ffa.h     |  27 ++-
 drivers/tee/optee/optee_msg.h     |  65 ++++-
 drivers/tee/optee/optee_private.h |  75 ++++--
 drivers/tee/optee/optee_smc.h     |  71 +++++-
 drivers/tee/optee/rpc.c           |  31 ++-
 drivers/tee/optee/rstmem.c        | 389 ++++++++++++++++++++++++++++++
 drivers/tee/optee/smc_abi.c       | 215 +++++++++++++++--
 drivers/tee/tee_core.c            |  69 +++++-
 drivers/tee/tee_private.h         |   4 +
 drivers/tee/tee_rstmem.c          | 188 +++++++++++++++
 drivers/tee/tee_shm.c             |   2 +
 drivers/tee/tee_shm_pool.c        |  69 +++++-
 include/linux/tee_core.h          |  15 ++
 include/linux/tee_drv.h           |   2 +
 include/uapi/linux/tee.h          |  71 +++++-
 20 files changed, 1409 insertions(+), 76 deletions(-)
 create mode 100644 drivers/tee/optee/rstmem.c
 create mode 100644 drivers/tee/tee_rstmem.c


base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
--=20
2.43.0


--===============0425572323921925594==--

