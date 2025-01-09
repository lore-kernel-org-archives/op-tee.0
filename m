From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
Date: Thu, 09 Jan 2025 11:38:50 +0530
Message-ID: 
 <CAFA6WYPXxUQYe9TF3PB9C0NwCz1eceCdYNa1yoKpv320M20qDw@mail.gmail.com>
In-Reply-To: <Z36ujiS8yyG1mfbA@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1432843667397353864=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1432843667397353864==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jan 2025 at 22:27, Simona Vetter <simona.vetter@ffwll.ch> wrote:
>
> On Tue, Dec 24, 2024 at 12:05:19PM +0530, Sumit Garg wrote:
> > Hi Simona,
> >
> > On Wed, 18 Dec 2024 at 16:36, Simona Vetter <simona.vetter@ffwll.ch> wr=
ote:
> > >
> > > On Tue, Dec 17, 2024 at 11:07:36AM +0100, Jens Wiklander wrote:
> > > > Hi,
> > > >
> > > > This patch set allocates the restricted DMA-bufs via the TEE subsyste=
m.
> > > >
> > > > The TEE subsystem handles the DMA-buf allocations since it is the TEE
> > > > (OP-TEE, AMD-TEE, TS-TEE, or perhaps a future QCOMTEE) which sets up =
the
> > > > restrictions for the memory used for the DMA-bufs.
> > > >
> > > > I've added a new IOCTL, TEE_IOC_RSTMEM_ALLOC, to allocate the restric=
ted
> > > > DMA-bufs. This IOCTL reaches the backend TEE driver, allowing it to c=
hoose
> > > > how to allocate the restricted physical memory.
> > > >
> > > > TEE_IOC_RSTMEM_ALLOC takes in addition to a size and flags parameters=
 also
> > > > a use-case parameter. This is used by the backend TEE driver to decid=
e on
> > > > allocation policy and which devices should be able to access the memo=
ry.
> > > >
> > > > Three use-cases (Secure Video Playback, Trusted UI, and Secure Video
> > > > Recording) has been identified so far to serve as examples of what ca=
n be
> > > > expected. More use-cases can be added in userspace ABI, but it's up t=
o the
> > > > backend TEE drivers to provide the implementation.
> > > >
> > > > Each use-case has it's own restricted memory pool since different use=
-cases
> > > > requires isolation from different parts of the system. A restricted m=
emory
> > > > pool can be based on a static carveout instantiated while probing the=
 TEE
> > > > backend driver, or dynamically allocated from CMA and made restricted=
 as
> > > > needed by the TEE.
> > > >
> > > > This can be tested on QEMU with the following steps:
> > > > repo init -u https://github.com/jenswi-linaro/manifest.git -m qemu_v8=
.xml \
> > > >         -b prototype/sdp-v4
> > > > repo sync -j8
> > > > cd build
> > > > make toolchains -j$(nproc)
> > > > make SPMC_AT_EL=3D1 all -j$(nproc)
> > > > make SPMC_AT_EL=3D1 run-only
> > > > # login and at the prompt:
> > > > xtest --sdp-basic
> > > >
> > > > The SPMC_AT_EL=3D1 parameter configures the build with FF-A and an SP=
MC at
> > > > S-EL1 inside OP-TEE. The parameter can be changed into SPMC_AT_EL=3Dn=
 to test
> > > > without FF-A using the original SMC ABI instead. Please remember to do
> > > > %rm -rf ../trusted-firmware-a/build/qemu
> > > > for TF-A to be rebuilt properly using the new configuration.
> > > >
> > > > https://optee.readthedocs.io/en/latest/building/prerequisites.html
> > > > list dependencies needed to build the above.
> > > >
> > > > The tests are pretty basic, mostly checking that a Trusted Applicatio=
n in
> > > > the secure world can access and manipulate the memory. There are also=
 some
> > > > negative tests for out of bounds buffers etc.
> > >
> > > I think I've dropped this on earlier encrypted dma-buf discussions for
> > > TEE, but can't find one right now ...
> >
> > Thanks for raising this query.
> >
> > >
> > > Do we have some open source userspace for this? To my knowledge we have
> > > two implementations of encrypted/content protected dma-buf in upstream
> > > right now in the amd and intel gpu drivers, and unless I'm mistaken they
> > > both have some minimal userspace supporting EXT_protected_textures:
> >
> > First of all to clarify the support Jens is adding here for allocating
> > restricted shared memory allocation in TEE subsystem is meant to be
> > generic and not specific to only secure media pipeline use-case. Then
> > here we not only have open source test applications but rather open
> > source firmware too (OP-TEE as a Trusted OS) [1] supporting this as a
> > core feature where we maintain a stable and extensible ABI among the
> > kernel and the OP-TEE core.
> >
> > Restricted memory is a feature enforced by hardware specific firewalls
> > where a particular TEE implementation governs which particular block
> > of memory is accessible to a particular peripheral or a CPU running in
> > a higher privileged mode than the Linux kernel. There can be numeric
> > use-cases surrounding that as follows:
> >
> > - Secure media pipeline where the contents gets decrypted and stored
> > in a restricted buffer which are then accessible only to media display
> > pipeline peripherals.
> > - Trusted user interface where a peripheral takes input from the user
> > and stores it in a restricted buffer which then is accessible to TEE
> > implementation only.
> > - Another possible use-case can be for the TEE implementation to store
> > key material in a restricted buffer which is only accessible to the
> > hardware crypto accelerator.
> >
> > I am sure there will be more use-cases related to this feature but
> > those will only be possible once we provide a stable and extensible
> > restricted memory interface among the Linux user-space and the secure
> > world user-space (normally referred to as Trusted Applications).
> >
> > [1] https://github.com/OP-TEE/optee_os/pull/7159
> >
> > >
> > > https://github.com/KhronosGroup/OpenGL-Registry/blob/main/extensions/EX=
T/EXT_protected_textures.txt
> > >
> > > It's not great, but it does just barely clear the bar in my opinion. I
> > > guess something in gstreamer or similar video pipeline framework would
> > > also do the job.
> > >
> > > Especially with the context of the uapi discussion in the v1/RFC thread=
 I
> > > think we need more than a bare-bones testcase to make sure this works in
> > > actual use.
> >
> > Currently the TEE subsystem already supports a stable ABI for shared
> > memory allocator among Linux user-space and secure world user-space
> > here [2]. And the stable ABI for restricted memory is also along the
> > same lines meant to be a vendor neutral abstraction for the user-space
> > access. The current test cases not only test the interface but also
> > perform regression tests too.
> >
> > I am also in favour of end to end open source use-cases. But I fear
> > without progressing in a step wise manner as with this proposal we
> > would rather force developers to upstream all the software pieces in
> > one go which will be kind of a chicken and egg situation. I am sure
> > once this feature lands Mediatek folks will be interested to port
> > their secure video playback patchset [3] on top of it. Similarly other
> > silicon vendors like NXP, Qcom etc. will be motivated to do the same.
> >
> > [2] https://docs.kernel.org/userspace-api/tee.html
> > [3] https://lore.kernel.org/linux-arm-kernel/20240515112308.10171-1-yong.=
wu(a)mediatek.com/
>
> We get entire opengl/vulkan driver stacks ready before we merge new drm
> drivers, I really don't think this is too hard from a technical pov. And I
> think the mediatek patches had the same issue of lacking userspace for it,
> so that's not moving things forward.
> -Sima
>

Okay fair enough, I think I get your point. Currently we are missing
at least one peripheral support being the consumer for these
restricted DMA-bufs. So I discussed with Jens offline that we can try
with a crypto peripheral use-case first which can simply be
demonstrated using the current OP-TEE client user-space.

Also, in crypto peripheral use-case we can target the symmetric crypto
use-case first which already has a concept of hardware backed
symmetric key [1]. IOW, we should be able to come up with a generic
symmetric crypto algorithm which can be supported by different crypto
accelerators using a TEE backed restricted key DMA buffer.

[1] https://www.youtube.com/watch?v=3DGbcpwUBFGDw

-Sumit

--===============1432843667397353864==--

