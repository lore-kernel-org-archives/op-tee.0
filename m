From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 6/8] tee: Support kernel shm registration without
 dma-buf backing
Date: Fri, 11 Jun 2021 08:16:19 -0500
Message-ID: <20210611131619.GS4910@sequoia>
In-Reply-To: <20210611130958.GR4910@sequoia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6592128300766879147=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6592128300766879147==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 2021-06-11 08:10:01, Tyler Hicks wrote:
> On 2021-06-11 10:46:20, Sumit Garg wrote:
> > On Fri, 11 Jun 2021 at 02:39, Tyler Hicks <tyhicks@linux.microsoft.com>=
 wrote:
> > >
> > > Uncouple the registration of kernel shared memory buffers from the
> > > TEE_SHM_DMA_BUF flag. Drivers may wish to allocate multi-page contiguous
> > > shared memory regions but do not need them to be backed by a dma-buf
> > > when the memory region is only used by the driver.
> > >
> > > If the TEE implementation does not require shared memory to be
> > > registered, clear the flag prior to calling the corresponding pool alloc
> > > function. Update the OP-TEE driver to respect TEE_SHM_REGISTER, rather
> > > than TEE_SHM_DMA_BUF, when deciding whether to (un)register on
> > > alloc/free operations.
> >=20
> > > The AMD-TEE driver continues to ignore the
> > > TEE_SHM_REGISTER flag.
> > >
> >=20
> > That's the main point that no other TEE implementation would honour
> > TEE_SHM_REGISTER and I think it's just the incorrect usage of
> > TEE_SHM_REGISTER flag to suffice OP-TEE underlying implementation.
> >=20
> > > Allow callers of tee_shm_alloc_kernel_buf() to allocate and register a
> > > shared memory region without the backing of dma-buf.
> > >
> > > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > ---
> > >  drivers/tee/optee/shm_pool.c |  5 ++---
> > >  drivers/tee/tee_shm.c        | 13 +++++++++++--
> > >  2 files changed, 13 insertions(+), 5 deletions(-)
> > >
> >=20
> > This patch is just mixing two separate approaches to TEE shared
> > memory. Have a look at alternative suggestions below.
> >=20
> > > diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
> > > index da06ce9b9313..6054343a29fb 100644
> > > --- a/drivers/tee/optee/shm_pool.c
> > > +++ b/drivers/tee/optee/shm_pool.c
> > > @@ -27,7 +27,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poo=
lm,
> > >         shm->paddr =3D page_to_phys(page);
> > >         shm->size =3D PAGE_SIZE << order;
> > >
> > > -       if (shm->flags & TEE_SHM_DMA_BUF) {
> > > +       if (shm->flags & TEE_SHM_REGISTER) {
> >=20
> > Here you can just do following check instead:
> >=20
> >        if (!(shm->flags & TEE_SHM_PRIV)) {
>=20
> This is a bug fix series that's intended to fix the current and older
> kernels. tee_shm_alloc_anon_kernel_buf()/TEE_SHM_PRIV is not present in
> older kernels and isn't required to fix these kexec/kdump bugs. Your
> suggestion feels like something that should be done in the allocator
> rewrite that Jens is working on to clean all of this up going forward.

I want to add that I do fully agree with you that TEE_SHM_REGISTER is an
OP-TEE thing and not a TEE thing. Ideally, it wouldn't be defined in
tee_drv.h and would be completely private to the OP-TEE driver.
Likewise, I don't think that tee_shm_register() should exist (certainly
not at the TEE level) because it only works with OP-TEE.

That said, I think the first step is to fix the kexec/kdump bugs and the
second step is to clean up the code to remove the layering violation of
exposing shm registration from the TEE interfaces.

Tyler

>=20
> Tyler
>=20
> >=20
> > And this flag needs to be passed from the call sites here [1] [2].
> >=20
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/tee/optee/core.c#n280
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/tee/optee/call.c#n186
> >=20
> > >                 unsigned int nr_pages =3D 1 << order, i;
> > >                 struct page **pages;
> > >
> > > @@ -42,7 +42,6 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poo=
lm,
> > >                         page++;
> > >                 }
> > >
> > > -               shm->flags |=3D TEE_SHM_REGISTER;
> >=20
> > This should remain as it is.
> >=20
> > >                 rc =3D optee_shm_register(shm->ctx, shm, pages, nr_page=
s,
> > >                                         (unsigned long)shm->kaddr);
> > >                 kfree(pages);
> > > @@ -60,7 +59,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poo=
lm,
> > >  static void pool_op_free(struct tee_shm_pool_mgr *poolm,
> > >                          struct tee_shm *shm)
> > >  {
> > > -       if (shm->flags & TEE_SHM_DMA_BUF)
> > > +       if (shm->flags & TEE_SHM_REGISTER)
> >=20
> > Same as above.
> >=20
> > >                 optee_shm_unregister(shm->ctx, shm);
> > >
> > >         free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> > > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > > index c65e44707cd6..26a76f817c57 100644
> > > --- a/drivers/tee/tee_shm.c
> > > +++ b/drivers/tee/tee_shm.c
> > > @@ -117,7 +117,7 @@ struct tee_shm *tee_shm_alloc(struct tee_context *c=
tx, size_t size, u32 flags)
> > >                 return ERR_PTR(-EINVAL);
> > >         }
> > >
> > > -       if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF))) {
> > > +       if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_REGIS=
TER))) {
> >=20
> > No need for this change.
> >=20
> > >                 dev_err(teedev->dev.parent, "invalid shm flags 0x%x", f=
lags);
> > >                 return ERR_PTR(-EINVAL);
> > >         }
> > > @@ -137,6 +137,15 @@ struct tee_shm *tee_shm_alloc(struct tee_context *=
ctx, size_t size, u32 flags)
> > >                 goto err_dev_put;
> > >         }
> > >
> > > +       if (!teedev->desc->ops->shm_register ||
> > > +           !teedev->desc->ops->shm_unregister) {
> > > +               /* registration is not required by the TEE implementati=
on */
> > > +               flags &=3D ~TEE_SHM_REGISTER;
> > > +       } else if (flags & TEE_SHM_DMA_BUF) {
> > > +               /* all dma-buf backed shm allocations are registered */
> > > +               flags |=3D TEE_SHM_REGISTER;
> > > +       }
> > > +
> >=20
> > This change isn't required as well as underlying TEE implementation:
> > OP-TEE in this case knows how to implement shared memory allocation
> > whether to use reserved shared memory pool or dynamic shared memory
> > pool. For more details see shared memory pool creation in
> > optee_probe().
> >=20
> > >         shm->flags =3D flags | TEE_SHM_POOL;
> > >         shm->ctx =3D ctx;
> > >         if (flags & TEE_SHM_DMA_BUF)
> > > @@ -207,7 +216,7 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc);
> > >   */
> > >  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size=
_t size)
> > >  {
> > > -       return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BU=
F);
> > > +       return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_REGIST=
ER);
> >=20
> > Here it could just be:
> >=20
> >        return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED);
> >=20
> > -Sumit
> >=20
> > >  }
> > >  EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
> > >
> > > --
> > > 2.25.1
> > >
> >=20

--===============6592128300766879147==--

