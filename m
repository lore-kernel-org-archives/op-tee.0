From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 12/12] tee: refactor TEE_SHM_* flags
Date: Fri, 21 Jan 2022 08:23:20 +0100
Message-ID: 
 <CAHUa44Hz=7L1odx746sCRuts3Xhr=ve1oU8CZ7-2+UuHyCr9pQ@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYOvsBZk17mPG9d79wQFNvQwv1deCm5ocs3qyBa8W0hvNQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7490666692226601149=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7490666692226601149==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 20, 2022 at 2:04 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Fri, 14 Jan 2022 at 20:38, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Removes the redundant TEE_SHM_DMA_BUF, TEE_SHM_EXT_DMA_BUF,
> > TEE_SHM_MAPPED and TEE_SHM_KERNEL_MAPPED flags.
> >
> > Assigns new values to the remaining flags to void gaps.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/tee_shm.c   | 21 ++++++++++-----------
> >  include/linux/tee_drv.h | 12 ++++--------
> >  2 files changed, 14 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index fe3e5977dd7c..9945bdec086b 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -139,8 +139,7 @@ static struct tee_shm *shm_alloc_helper(struct tee_co=
ntext *ctx, size_t size,
> >   */
> >  struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t s=
ize)
> >  {
> > -       u32 flags =3D TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_REGISTER=
 |
> > -                   TEE_SHM_POOL;
> > +       u32 flags =3D TEE_SHM_REGISTER | TEE_SHM_POOL;
> >         struct tee_device *teedev =3D ctx->teedev;
> >         struct tee_shm *shm;
> >         void *ret;
> > @@ -186,7 +185,7 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc_user_buf);
> >   */
> >  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t=
 size)
> >  {
> > -       u32 flags =3D TEE_SHM_MAPPED | TEE_SHM_REGISTER | TEE_SHM_POOL;
> > +       u32 flags =3D TEE_SHM_REGISTER | TEE_SHM_POOL;
> >
> >         return shm_alloc_helper(ctx, size, PAGE_SIZE, flags, -1);
> >  }
> > @@ -211,7 +210,7 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
> >  struct tee_shm *tee_shm_alloc_priv_kernel_buf(struct tee_context *ctx,
> >                                               size_t size)
> >  {
> > -       u32 flags =3D TEE_SHM_MAPPED | TEE_SHM_PRIV | TEE_SHM_POOL;
> > +       u32 flags =3D TEE_SHM_PRIV | TEE_SHM_POOL;
> >
> >         return shm_alloc_helper(ctx, size, sizeof(long) * 2, flags, -1);
> >  }
> > @@ -308,7 +307,7 @@ register_shm_helper(struct tee_context *ctx, unsigned=
 long addr,
> >  struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
> >                                           unsigned long addr, size_t leng=
th)
> >  {
> > -       u32 f =3D TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED | TEE_SHM_REGISTE=
R;
> > +       u32 f =3D TEE_SHM_USER_MAPPED | TEE_SHM_REGISTER;
> >         struct tee_device *teedev =3D ctx->teedev;
> >         struct tee_shm *shm;
> >         void *ret;
> > @@ -354,7 +353,7 @@ EXPORT_SYMBOL_GPL(tee_shm_register_user_buf);
> >  struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
> >                                             void *addr, size_t length)
> >  {
> > -       u32 f =3D TEE_SHM_REGISTER | TEE_SHM_KERNEL_MAPPED;
> > +       u32 f =3D TEE_SHM_REGISTER;
> >
> >         return register_shm_helper(ctx, (unsigned long)addr, length, f, -=
1);
> >  }
> > @@ -398,7 +397,7 @@ int tee_shm_get_fd(struct tee_shm *shm)
> >  {
> >         int fd;
> >
> > -       if (!(shm->flags & TEE_SHM_DMA_BUF))
> > +       if (shm->id < 0)
> >                 return -EINVAL;
> >
> >         /* matched by tee_shm_put() in tee_shm_op_release() */
> > @@ -428,7 +427,7 @@ EXPORT_SYMBOL_GPL(tee_shm_free);
> >   */
> >  int tee_shm_va2pa(struct tee_shm *shm, void *va, phys_addr_t *pa)
> >  {
> > -       if (!(shm->flags & TEE_SHM_MAPPED))
> > +       if (!shm->kaddr)
> >                 return -EINVAL;
> >         /* Check that we're in the range of the shm */
> >         if ((char *)va < (char *)shm->kaddr)
> > @@ -450,7 +449,7 @@ EXPORT_SYMBOL_GPL(tee_shm_va2pa);
> >   */
> >  int tee_shm_pa2va(struct tee_shm *shm, phys_addr_t pa, void **va)
> >  {
> > -       if (!(shm->flags & TEE_SHM_MAPPED))
> > +       if (!shm->kaddr)
> >                 return -EINVAL;
> >         /* Check that we're in the range of the shm */
> >         if (pa < shm->paddr)
> > @@ -478,7 +477,7 @@ EXPORT_SYMBOL_GPL(tee_shm_pa2va);
> >   */
> >  void *tee_shm_get_va(struct tee_shm *shm, size_t offs)
> >  {
> > -       if (!(shm->flags & TEE_SHM_MAPPED))
> > +       if (!shm->kaddr)
> >                 return ERR_PTR(-EINVAL);
> >         if (offs >=3D shm->size)
> >                 return ERR_PTR(-EINVAL);
> > @@ -553,7 +552,7 @@ void tee_shm_put(struct tee_shm *shm)
> >                  * the refcount_inc() in tee_shm_get_from_id() never star=
ts
> >                  * from 0.
> >                  */
> > -               if (shm->flags & TEE_SHM_DMA_BUF)
> > +               if (shm->id >=3D 0)
> >                         idr_remove(&teedev->idr, shm->id);
> >                 do_release =3D true;
> >         }
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index e4f32885e273..dcc7a55e1128 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -20,14 +20,10 @@
> >   * specific TEE driver.
> >   */
> >
> > -#define TEE_SHM_MAPPED         BIT(0)  /* Memory mapped by the kernel */
> > -#define TEE_SHM_DMA_BUF                BIT(1)  /* Memory with dma-buf ha=
ndle */
> > -#define TEE_SHM_EXT_DMA_BUF    BIT(2)  /* Memory with dma-buf handle */
> > -#define TEE_SHM_REGISTER       BIT(3)  /* Memory registered in secure wo=
rld */
> > -#define TEE_SHM_USER_MAPPED    BIT(4)  /* Memory mapped in user space */
> > -#define TEE_SHM_POOL           BIT(5)  /* Memory allocated from pool */
> > -#define TEE_SHM_KERNEL_MAPPED  BIT(6)  /* Memory mapped in kernel space =
*/
> > -#define TEE_SHM_PRIV           BIT(7)  /* Memory private to TEE driver */
> > +#define TEE_SHM_REGISTER       BIT(0)  /* Memory registered in secure wo=
rld */
>
> TEE_SHM_REGISTER as a flag name seems ambiguous to me when it is being
> used by both types of APIs tee_shm_alloc_* and tee_shm_register_*. Can
> we rename it to TEE_SHM_DYNAMIC instead?

Sure, I'll fix that in v3.

Thanks,
Jens

>
> -Sumit
>
> > +#define TEE_SHM_USER_MAPPED    BIT(1)  /* Memory mapped in user space */
> > +#define TEE_SHM_POOL           BIT(2)  /* Memory allocated from pool */
> > +#define TEE_SHM_PRIV           BIT(3)  /* Memory private to TEE driver */
> >
> >  struct device;
> >  struct tee_device;
> > --
> > 2.31.1
> >

--===============7490666692226601149==--

