From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 5/7] tee: Support shm registration without dma-buf backing
Date: Thu, 10 Jun 2021 09:18:12 +0200
Message-ID: <20210610071812.GA2753553@jade>
In-Reply-To: <
 <CAFA6WYOYt2vcQ4ng=Nwu2R7d6=R=DGXQKpQ-+UiENerEtQRKWg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1396485755397892535=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1396485755397892535==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 2021 at 04:22:49PM +0530, Sumit Garg wrote:
> + Rijo
>=20
> On Wed, 9 Jun 2021 at 11:16, Tyler Hicks <tyhicks@linux.microsoft.com> wr=
ote:
[snip]
>=20
> > - tee_shm_alloc() performs allocations using contiguous pages
> >   from alloc_pages() while tee_shm_register() performs non-contiguous
> >   allocations with kcalloc(). I suspect this would be fine but I don't
> >   know the secure world side of these things well enough to assess the
> >   risk involved with such a change on the kernel side.
> >
>=20
> I don't think that would make any difference.

Agree.

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

I had another approach in mind in "[PATCH 0/7] tee: shared memory updates",
https://lore.kernel.org/lkml/20210609102324.2222332-1-jens.wiklander(a)linaro=
.org/

The flags needed by tee_shm_alloc() and tee_shm_register() aren't
very intuitive and in fact only accept quite few combinations. So my
idea was to hide those flags from callers outside of the TEE subsystem
with tee_shm_alloc_kernel_buf().

The approach with tee_shm_register() you suggest above has the drawback
that the TEE driver is forced to be able to handle any kernel memory.
This is OK with OP-TEE and dynamic shared memory enabled, but there are
platforms where dynamic shared memory isn't enabled. In those case must
the memory be allocated from a special pool.

Do you see any problem with instead replacing tee_shm_alloc()
with tee_shm_alloc_kernel_buf()?

Cheers,
Jens

--===============1396485755397892535==--

