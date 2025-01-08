From: Simona Vetter <simona.vetter@ffwll.ch>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
Date: Wed, 08 Jan 2025 17:57:50 +0100
Message-ID: <Z36ujiS8yyG1mfbA@phenom.ffwll.local>
In-Reply-To: <
 <CAFA6WYNVHu7_-bNAuTYBRBdoJwfk2VrW5M4aFVkb_UWQ=uxTvQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8386899054305114612=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8386899054305114612==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 24, 2024 at 12:05:19PM +0530, Sumit Garg wrote:
> Hi Simona,
>=20
> On Wed, 18 Dec 2024 at 16:36, Simona Vetter <simona.vetter@ffwll.ch> wrot=
e:
> >
> > On Tue, Dec 17, 2024 at 11:07:36AM +0100, Jens Wiklander wrote:
> > > Hi,
> > >
> > > This patch set allocates the restricted DMA-bufs via the TEE subsystem.
> > >
> > > The TEE subsystem handles the DMA-buf allocations since it is the TEE
> > > (OP-TEE, AMD-TEE, TS-TEE, or perhaps a future QCOMTEE) which sets up the
> > > restrictions for the memory used for the DMA-bufs.
> > >
> > > I've added a new IOCTL, TEE_IOC_RSTMEM_ALLOC, to allocate the restricted
> > > DMA-bufs. This IOCTL reaches the backend TEE driver, allowing it to cho=
ose
> > > how to allocate the restricted physical memory.
> > >
> > > TEE_IOC_RSTMEM_ALLOC takes in addition to a size and flags parameters a=
lso
> > > a use-case parameter. This is used by the backend TEE driver to decide =
on
> > > allocation policy and which devices should be able to access the memory.
> > >
> > > Three use-cases (Secure Video Playback, Trusted UI, and Secure Video
> > > Recording) has been identified so far to serve as examples of what can =
be
> > > expected. More use-cases can be added in userspace ABI, but it's up to =
the
> > > backend TEE drivers to provide the implementation.
> > >
> > > Each use-case has it's own restricted memory pool since different use-c=
ases
> > > requires isolation from different parts of the system. A restricted mem=
ory
> > > pool can be based on a static carveout instantiated while probing the T=
EE
> > > backend driver, or dynamically allocated from CMA and made restricted as
> > > needed by the TEE.
> > >
> > > This can be tested on QEMU with the following steps:
> > > repo init -u https://github.com/jenswi-linaro/manifest.git -m qemu_v8.x=
ml \
> > >         -b prototype/sdp-v4
> > > repo sync -j8
> > > cd build
> > > make toolchains -j$(nproc)
> > > make SPMC_AT_EL=3D1 all -j$(nproc)
> > > make SPMC_AT_EL=3D1 run-only
> > > # login and at the prompt:
> > > xtest --sdp-basic
> > >
> > > The SPMC_AT_EL=3D1 parameter configures the build with FF-A and an SPMC=
 at
> > > S-EL1 inside OP-TEE. The parameter can be changed into SPMC_AT_EL=3Dn t=
o test
> > > without FF-A using the original SMC ABI instead. Please remember to do
> > > %rm -rf ../trusted-firmware-a/build/qemu
> > > for TF-A to be rebuilt properly using the new configuration.
> > >
> > > https://optee.readthedocs.io/en/latest/building/prerequisites.html
> > > list dependencies needed to build the above.
> > >
> > > The tests are pretty basic, mostly checking that a Trusted Application =
in
> > > the secure world can access and manipulate the memory. There are also s=
ome
> > > negative tests for out of bounds buffers etc.
> >
> > I think I've dropped this on earlier encrypted dma-buf discussions for
> > TEE, but can't find one right now ...
>=20
> Thanks for raising this query.
>=20
> >
> > Do we have some open source userspace for this? To my knowledge we have
> > two implementations of encrypted/content protected dma-buf in upstream
> > right now in the amd and intel gpu drivers, and unless I'm mistaken they
> > both have some minimal userspace supporting EXT_protected_textures:
>=20
> First of all to clarify the support Jens is adding here for allocating
> restricted shared memory allocation in TEE subsystem is meant to be
> generic and not specific to only secure media pipeline use-case. Then
> here we not only have open source test applications but rather open
> source firmware too (OP-TEE as a Trusted OS) [1] supporting this as a
> core feature where we maintain a stable and extensible ABI among the
> kernel and the OP-TEE core.
>=20
> Restricted memory is a feature enforced by hardware specific firewalls
> where a particular TEE implementation governs which particular block
> of memory is accessible to a particular peripheral or a CPU running in
> a higher privileged mode than the Linux kernel. There can be numeric
> use-cases surrounding that as follows:
>=20
> - Secure media pipeline where the contents gets decrypted and stored
> in a restricted buffer which are then accessible only to media display
> pipeline peripherals.
> - Trusted user interface where a peripheral takes input from the user
> and stores it in a restricted buffer which then is accessible to TEE
> implementation only.
> - Another possible use-case can be for the TEE implementation to store
> key material in a restricted buffer which is only accessible to the
> hardware crypto accelerator.
>=20
> I am sure there will be more use-cases related to this feature but
> those will only be possible once we provide a stable and extensible
> restricted memory interface among the Linux user-space and the secure
> world user-space (normally referred to as Trusted Applications).
>=20
> [1] https://github.com/OP-TEE/optee_os/pull/7159
>=20
> >
> > https://github.com/KhronosGroup/OpenGL-Registry/blob/main/extensions/EXT/=
EXT_protected_textures.txt
> >
> > It's not great, but it does just barely clear the bar in my opinion. I
> > guess something in gstreamer or similar video pipeline framework would
> > also do the job.
> >
> > Especially with the context of the uapi discussion in the v1/RFC thread I
> > think we need more than a bare-bones testcase to make sure this works in
> > actual use.
>=20
> Currently the TEE subsystem already supports a stable ABI for shared
> memory allocator among Linux user-space and secure world user-space
> here [2]. And the stable ABI for restricted memory is also along the
> same lines meant to be a vendor neutral abstraction for the user-space
> access. The current test cases not only test the interface but also
> perform regression tests too.
>=20
> I am also in favour of end to end open source use-cases. But I fear
> without progressing in a step wise manner as with this proposal we
> would rather force developers to upstream all the software pieces in
> one go which will be kind of a chicken and egg situation. I am sure
> once this feature lands Mediatek folks will be interested to port
> their secure video playback patchset [3] on top of it. Similarly other
> silicon vendors like NXP, Qcom etc. will be motivated to do the same.
>=20
> [2] https://docs.kernel.org/userspace-api/tee.html
> [3] https://lore.kernel.org/linux-arm-kernel/20240515112308.10171-1-yong.wu=
(a)mediatek.com/

We get entire opengl/vulkan driver stacks ready before we merge new drm
drivers, I really don't think this is too hard from a technical pov. And I
think the mediatek patches had the same issue of lacking userspace for it,
so that's not moving things forward.
-Sima

>=20
> -Sumit
>=20
> >
> > Cheers, Sima
> >
> > >
> > > Thanks,
> > > Jens
> > >
> > > Changes since V3:
> > > * Make the use_case and flags field in struct tee_shm u32's instead of
> > >   u16's
> > > * Add more description for TEE_IOC_RSTMEM_ALLOC in the header file
> > > * Import namespace DMA_BUF in module tee, reported by lkp(a)intel.com
> > > * Added a note in the commit message for "optee: account for direction
> > >   while converting parameters" why it's needed
> > > * Factor out dynamic restricted memory allocation from
> > >   "optee: support restricted memory allocation" into two new commits
> > >   "optee: FF-A: dynamic restricted memory allocation" and
> > >   "optee: smc abi: dynamic restricted memory allocation"
> > > * Guard CMA usage with #ifdef CONFIG_CMA, effectively disabling dynamic
> > >   restricted memory allocate if CMA isn't configured
> > >
> > > Changes since the V2 RFC:
> > > * Based on v6.12
> > > * Replaced the flags for SVP and Trusted UID memory with a u32 field wi=
th
> > >   unique id for each use case
> > > * Added dynamic allocation of restricted memory pools
> > > * Added OP-TEE ABI both with and without FF-A for dynamic restricted me=
mory
> > > * Added support for FF-A with FFA_LEND
> > >
> > > Changes since the V1 RFC:
> > > * Based on v6.11
> > > * Complete rewrite, replacing the restricted heap with TEE_IOC_RSTMEM_A=
LLOC
> > >
> > > Changes since Olivier's post [2]:
> > > * Based on Yong Wu's post [1] where much of dma-buf handling is done in
> > >   the generic restricted heap
> > > * Simplifications and cleanup
> > > * New commit message for "dma-buf: heaps: add Linaro restricted dmabuf =
heap
> > >   support"
> > > * Replaced the word "secure" with "restricted" where applicable
> > >
> > > Jens Wiklander (6):
> > >   tee: add restricted memory allocation
> > >   optee: account for direction while converting parameters
> > >   optee: sync secure world ABI headers
> > >   optee: support restricted memory allocation
> > >   optee: FF-A: dynamic restricted memory allocation
> > >   optee: smc abi: dynamic restricted memory allocation
> > >
> > >  drivers/tee/Makefile              |   1 +
> > >  drivers/tee/optee/Makefile        |   1 +
> > >  drivers/tee/optee/call.c          |  10 +-
> > >  drivers/tee/optee/core.c          |   1 +
> > >  drivers/tee/optee/ffa_abi.c       | 178 +++++++++++++-
> > >  drivers/tee/optee/optee_ffa.h     |  27 ++-
> > >  drivers/tee/optee/optee_msg.h     |  65 ++++-
> > >  drivers/tee/optee/optee_private.h |  75 ++++--
> > >  drivers/tee/optee/optee_smc.h     |  71 +++++-
> > >  drivers/tee/optee/rpc.c           |  31 ++-
> > >  drivers/tee/optee/rstmem.c        | 388 ++++++++++++++++++++++++++++++
> > >  drivers/tee/optee/smc_abi.c       | 213 ++++++++++++++--
> > >  drivers/tee/tee_core.c            |  38 ++-
> > >  drivers/tee/tee_private.h         |   2 +
> > >  drivers/tee/tee_rstmem.c          | 201 ++++++++++++++++
> > >  drivers/tee/tee_shm.c             |   2 +
> > >  drivers/tee/tee_shm_pool.c        |  69 +++++-
> > >  include/linux/tee_core.h          |  15 ++
> > >  include/linux/tee_drv.h           |   2 +
> > >  include/uapi/linux/tee.h          |  44 +++-
> > >  20 files changed, 1358 insertions(+), 76 deletions(-)
> > >  create mode 100644 drivers/tee/optee/rstmem.c
> > >  create mode 100644 drivers/tee/tee_rstmem.c
> > >
> > >
> > > base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
> > > --
> > > 2.43.0
> > >
> >
> > --
> > Simona Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch

--=20
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

--===============8386899054305114612==--

