From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 5/7] tee: Support shm registration without dma-buf backing
Date: Wed, 09 Jun 2021 14:15:33 +0200
Message-ID: <20210609121533.GA2267052@jade>
In-Reply-To: <
 <CAFA6WYOYt2vcQ4ng=Nwu2R7d6=R=DGXQKpQ-+UiENerEtQRKWg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1800260285998274006=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1800260285998274006==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 09, 2021 at 04:22:49PM +0530, Sumit Garg wrote:
> + Rijo
>=20
> On Wed, 9 Jun 2021 at 11:16, Tyler Hicks <tyhicks@linux.microsoft.com> wr=
ote:
> >
> > On 2021-06-09 09:59:04, Sumit Garg wrote:
> > > Hi Tyler,
> >
> > Hey Sumit - Thanks for the review.
> >
> > >
> > > On Wed, 9 Jun 2021 at 05:55, Tyler Hicks <tyhicks@linux.microsoft.com=
> wrote:
> > > >
> > > > Uncouple the registration of dynamic shared memory buffers from the
> > > > TEE_SHM_DMA_BUF flag. Drivers may wish to allocate dynamic shared mem=
ory
> > > > regions but do not need them to be backed by a dma-buf when the memory
> > > > region is private to the driver.
> > >
> > > In this case drivers should use tee_shm_register() instead where the
> > > memory allocated is actually private to the driver. However, you need
> > > to remove TEE_SHM_DMA_BUF as a mandatory flag for tee_shm_register().
> > > Have a look at an example here [1]. So modifying tee_shm_alloc() for
> > > this purpose doesn't look appropriate to me.
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/security/keys/trusted-keys/trusted_tee.c#n73
> >
> > I noticed what you did in commit 2a6ba3f794e8 ("tee: enable support to
> > register kernel memory") and considered moving ftpm and tee_bnxt_fw over
> > to tee_shm_register(). I think that's likely the right long term
> > approach but I decided against it since this series is a minimal set of
> > bug fixes that will hopefully go to stable (I'm affected by these bugs
> > in 5.4). Here are my reasons for feeling like moving to
> > tee_shm_register() isn't minimal in terms of a stable-focused fix:
> >
> > - tee_shm_alloc() looks like it should work fine with AMD-TEE today.
> >   tee_shm_register() definitely does not since AMD-TEE doesn't provide a
> >   .shm_register or .shm_unregister hook. This may break existing users
> >   of AMD-TEE?
>=20
> AFAIK, ftpm and tee_bnxt_fw drivers only support OP-TEE at this point.
> See ftpm_tee_match() and optee_ctx_match() APIs in corresponding
> drivers.
>=20
> > - tee_shm_register() has not historically been used for kernel
> >   allocations and is not fixed wrt the bug that Jens fixed in commit
> >   f1bbacedb0af ("tee: don't assign shm id for private shms").
>=20
> Yes, that's what I meant earlier to make the TEE_SHM_DMA_BUF flag optional.
>=20
> > - tee_shm_alloc() performs allocations using contiguous pages
> >   from alloc_pages() while tee_shm_register() performs non-contiguous
> >   allocations with kcalloc(). I suspect this would be fine but I don't
> >   know the secure world side of these things well enough to assess the
> >   risk involved with such a change on the kernel side.
> >
>=20
> I don't think that would make any difference.
>=20
> > I should have mentioned this in the cover letter but my hope was that
> > these minimal changes would be accepted and then additional work could
> > be done to merge tee_shm_alloc() and tee_shm_register() in a way that
> > would allow the caller to request contiguous or non-contiguous pages,
> > fix up the additional issues mentioned above, and then adjust the
> > call sites in ftpm and tee_bnxt_fw as appropriate.
> >
> > I think that's a bigger set of changes because there are several things
> > that still confuse/concern me:
> >
> > - Why does tee_shm_alloc() use TEE_SHM_MAPPED while tee_shm_register()
> >   uses TEE_SHM_KERNEL_MAPPED or TEE_SHM_USER_MAPPED? Why do all three
> >   exist?
>=20
> AFAIK, its due the the inherent nature of tee_shm_alloc() and
> tee_shm_register() where tee_shm_alloc() doesn't need to know whether
> its a kernel or user-space memory since it is the one that allocates
> whereas tee_shm_register() need to know that since it has to register
> pre-allocated client memory.
>=20
> > - Why does tee_shm_register() unconditionally use non-contiguous
> >   allocations without ever taking into account whether or not
> >   OPTEE_SMC_SEC_CAP_DYNAMIC_SHM was set? It sounds like that's required
> >   from my reading of https://optee.readthedocs.io/en/latest/architecture/=
core.html#noncontiguous-shared-buffers.
>=20
> Yeah, but do we have platforms in OP-TEE that don't support dynamic
> shared memory? I guess it has become the sane default which is a
> mandatory requirement when it comes to OP-TEE driver in u-boot.
>=20
> > - Why is TEE_SHM_REGISTER implemented at the TEE driver level when it is
> >   specific to OP-TEE? How to better abstract that away?
> >
>=20
> I would like you to go through Section "3.2.4. Shared Memory" in TEE
> Client API Specification. There are two standard ways for shared
> memory approach with TEE:
>=20
> 1. A Shared Memory block can either be existing Client Application
> memory (kernel driver in our case) which is subsequently registered
> with the TEE Client API (using tee_shm_register() in our case).
>=20
> 2. Or memory which is allocated on behalf of the Client Application
> using the TEE
> Client API (using tee_shm_alloc() in our case).
>=20
> > Let me know if you agree with the more minimal approach that I took for
> > these bug fix series or still feel like tee_shm_register() should be
> > fixed up so that it is usable. Thanks!
>=20
> From drivers perspective I think the change should be:
>=20
> tee_shm_alloc()
>=20
> to
>=20
> kcalloc()
> tee_shm_register()

I've just posted "[PATCH 0/7] tee: shared memory updates",
https://lore.kernel.org/lkml/20210609102324.2222332-1-jens.wiklander(a)linaro=
.org/

Where tee_shm_alloc() is replaced by among other functions
tee_shm_alloc_kernel_buf(). tee_shm_alloc_kernel_buf() takes care of the
problem with TEE_SHM_DMA_BUF.

Cheers,
Jens

--===============1800260285998274006==--

