From: Simona Vetter <simona.vetter@ffwll.ch>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
Date: Wed, 18 Dec 2024 12:06:32 +0100
Message-ID: <Z2KsuAs-Dd4ZDaXR@phenom.ffwll.local>
In-Reply-To: <20241217100809.3962439-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7697641753991624224=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7697641753991624224==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 11:07:36AM +0100, Jens Wiklander wrote:
> Hi,
>=20
> This patch set allocates the restricted DMA-bufs via the TEE subsystem.
>=20
> The TEE subsystem handles the DMA-buf allocations since it is the TEE
> (OP-TEE, AMD-TEE, TS-TEE, or perhaps a future QCOMTEE) which sets up the
> restrictions for the memory used for the DMA-bufs.
>=20
> I've added a new IOCTL, TEE_IOC_RSTMEM_ALLOC, to allocate the restricted
> DMA-bufs. This IOCTL reaches the backend TEE driver, allowing it to choose
> how to allocate the restricted physical memory.
>=20
> TEE_IOC_RSTMEM_ALLOC takes in addition to a size and flags parameters also
> a use-case parameter. This is used by the backend TEE driver to decide on
> allocation policy and which devices should be able to access the memory.
>=20
> Three use-cases (Secure Video Playback, Trusted UI, and Secure Video
> Recording) has been identified so far to serve as examples of what can be
> expected. More use-cases can be added in userspace ABI, but it's up to the
> backend TEE drivers to provide the implementation.
>=20
> Each use-case has it's own restricted memory pool since different use-cases
> requires isolation from different parts of the system. A restricted memory
> pool can be based on a static carveout instantiated while probing the TEE
> backend driver, or dynamically allocated from CMA and made restricted as
> needed by the TEE.
>=20
> This can be tested on QEMU with the following steps:
> repo init -u https://github.com/jenswi-linaro/manifest.git -m qemu_v8.xml \
>         -b prototype/sdp-v4
> repo sync -j8
> cd build
> make toolchains -j$(nproc)
> make SPMC_AT_EL=3D1 all -j$(nproc)
> make SPMC_AT_EL=3D1 run-only
> # login and at the prompt:
> xtest --sdp-basic
>=20
> The SPMC_AT_EL=3D1 parameter configures the build with FF-A and an SPMC at
> S-EL1 inside OP-TEE. The parameter can be changed into SPMC_AT_EL=3Dn to te=
st
> without FF-A using the original SMC ABI instead. Please remember to do
> %rm -rf ../trusted-firmware-a/build/qemu
> for TF-A to be rebuilt properly using the new configuration.
>=20
> https://optee.readthedocs.io/en/latest/building/prerequisites.html
> list dependencies needed to build the above.
>=20
> The tests are pretty basic, mostly checking that a Trusted Application in
> the secure world can access and manipulate the memory. There are also some
> negative tests for out of bounds buffers etc.

I think I've dropped this on earlier encrypted dma-buf discussions for
TEE, but can't find one right now ...

Do we have some open source userspace for this? To my knowledge we have
two implementations of encrypted/content protected dma-buf in upstream
right now in the amd and intel gpu drivers, and unless I'm mistaken they
both have some minimal userspace supporting EXT_protected_textures:

https://github.com/KhronosGroup/OpenGL-Registry/blob/main/extensions/EXT/EXT_=
protected_textures.txt

It's not great, but it does just barely clear the bar in my opinion. I
guess something in gstreamer or similar video pipeline framework would
also do the job.

Especially with the context of the uapi discussion in the v1/RFC thread I
think we need more than a bare-bones testcase to make sure this works in
actual use.

Cheers, Sima

>=20
> Thanks,
> Jens
>=20
> Changes since V3:
> * Make the use_case and flags field in struct tee_shm u32's instead of
>   u16's
> * Add more description for TEE_IOC_RSTMEM_ALLOC in the header file
> * Import namespace DMA_BUF in module tee, reported by lkp(a)intel.com
> * Added a note in the commit message for "optee: account for direction
>   while converting parameters" why it's needed
> * Factor out dynamic restricted memory allocation from
>   "optee: support restricted memory allocation" into two new commits
>   "optee: FF-A: dynamic restricted memory allocation" and
>   "optee: smc abi: dynamic restricted memory allocation"
> * Guard CMA usage with #ifdef CONFIG_CMA, effectively disabling dynamic
>   restricted memory allocate if CMA isn't configured
>=20
> Changes since the V2 RFC:
> * Based on v6.12
> * Replaced the flags for SVP and Trusted UID memory with a u32 field with
>   unique id for each use case
> * Added dynamic allocation of restricted memory pools
> * Added OP-TEE ABI both with and without FF-A for dynamic restricted memory
> * Added support for FF-A with FFA_LEND
>=20
> Changes since the V1 RFC:
> * Based on v6.11
> * Complete rewrite, replacing the restricted heap with TEE_IOC_RSTMEM_ALLOC
>=20
> Changes since Olivier's post [2]:
> * Based on Yong Wu's post [1] where much of dma-buf handling is done in
>   the generic restricted heap
> * Simplifications and cleanup
> * New commit message for "dma-buf: heaps: add Linaro restricted dmabuf heap
>   support"
> * Replaced the word "secure" with "restricted" where applicable
>=20
> Jens Wiklander (6):
>   tee: add restricted memory allocation
>   optee: account for direction while converting parameters
>   optee: sync secure world ABI headers
>   optee: support restricted memory allocation
>   optee: FF-A: dynamic restricted memory allocation
>   optee: smc abi: dynamic restricted memory allocation
>=20
>  drivers/tee/Makefile              |   1 +
>  drivers/tee/optee/Makefile        |   1 +
>  drivers/tee/optee/call.c          |  10 +-
>  drivers/tee/optee/core.c          |   1 +
>  drivers/tee/optee/ffa_abi.c       | 178 +++++++++++++-
>  drivers/tee/optee/optee_ffa.h     |  27 ++-
>  drivers/tee/optee/optee_msg.h     |  65 ++++-
>  drivers/tee/optee/optee_private.h |  75 ++++--
>  drivers/tee/optee/optee_smc.h     |  71 +++++-
>  drivers/tee/optee/rpc.c           |  31 ++-
>  drivers/tee/optee/rstmem.c        | 388 ++++++++++++++++++++++++++++++
>  drivers/tee/optee/smc_abi.c       | 213 ++++++++++++++--
>  drivers/tee/tee_core.c            |  38 ++-
>  drivers/tee/tee_private.h         |   2 +
>  drivers/tee/tee_rstmem.c          | 201 ++++++++++++++++
>  drivers/tee/tee_shm.c             |   2 +
>  drivers/tee/tee_shm_pool.c        |  69 +++++-
>  include/linux/tee_core.h          |  15 ++
>  include/linux/tee_drv.h           |   2 +
>  include/uapi/linux/tee.h          |  44 +++-
>  20 files changed, 1358 insertions(+), 76 deletions(-)
>  create mode 100644 drivers/tee/optee/rstmem.c
>  create mode 100644 drivers/tee/tee_rstmem.c
>=20
>=20
> base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
> --=20
> 2.43.0
>=20

--=20
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

--===============7697641753991624224==--

