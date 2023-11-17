From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 1/2] optee: add page list to kernel private shared memory
Date: Fri, 17 Nov 2023 09:29:51 +0100
Message-ID: 
 <CAHUa44GRL-vkXH6CKoL-JamJpk+XV8mWyO+VaE8VVdmqSVa6EQ@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYOUZBLtkoy6fpsARYN==Eqr7JymskYDTxbvxxkUjEprfg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4653054072807342189=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4653054072807342189==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 1:28=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Tue, 14 Nov 2023 at 15:22, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Until now has kernel private shared memory allocated as dynamic shared
> > memory (not from the static shared memory pool) been returned without a
> > list of physical pages on allocations via RPC. To support allocations
> > larger than one page add a list of physical pages.
>
> Although this patch looks like a good cleanup, I can't find an ABI
> change here. Wasn't a list of pages returned earlier too?

No, because handle_rpc_func_cmd_shm_alloc() didn't take the path where
optee_allocate_pages_list() is called.

Cheers,
Jens

>
> -Sumit
>
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/core.c    | 28 +++++++++++++----------
> >  drivers/tee/optee/smc_abi.c | 45 +++++++++++++++++--------------------
> >  2 files changed, 37 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index 2a258bd3b6b5..38ea2fecfc2e 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -27,7 +27,10 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *po=
ol, struct tee_shm *shm,
> >                                                    unsigned long start))
> >  {
> >         unsigned int order =3D get_order(size);
> > +       unsigned int nr_pages =3D 1 << order;
> > +       struct page **pages;
> >         struct page *page;
> > +       unsigned int i;
> >         int rc =3D 0;
> >
> >         /*
> > @@ -42,30 +45,29 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *p=
ool, struct tee_shm *shm,
> >         shm->paddr =3D page_to_phys(page);
> >         shm->size =3D PAGE_SIZE << order;
> >
> > -       if (shm_register) {
> > -               unsigned int nr_pages =3D 1 << order, i;
> > -               struct page **pages;
> > +       pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> > +       if (!pages) {
> > +               rc =3D -ENOMEM;
> > +               goto err;
> > +       }
> >
> > -               pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> > -               if (!pages) {
> > -                       rc =3D -ENOMEM;
> > -                       goto err;
> > -               }
> > +       for (i =3D 0; i < nr_pages; i++)
> > +               pages[i] =3D page + i;
> >
> > -               for (i =3D 0; i < nr_pages; i++)
> > -                       pages[i] =3D page + i;
> > +       shm->pages =3D pages;
> > +       shm->num_pages =3D nr_pages;
> >
> > +       if (shm_register) {
> >                 rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
> >                                   (unsigned long)shm->kaddr);
> > -               kfree(pages);
> >                 if (rc)
> >                         goto err;
> >         }
> >
> >         return 0;
> > -
> >  err:
> >         free_pages((unsigned long)shm->kaddr, order);
> > +       shm->kaddr =3D NULL;
> >         return rc;
> >  }
> >
> > @@ -77,6 +79,8 @@ void optee_pool_op_free_helper(struct tee_shm_pool *poo=
l, struct tee_shm *shm,
> >                 shm_unregister(shm->ctx, shm);
> >         free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> >         shm->kaddr =3D NULL;
> > +       kfree(shm->pages);
> > +       shm->pages =3D NULL;
> >  }
> >
> >  static void optee_bus_scan(struct work_struct *work)
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index d5b28fd35d66..b69410c7cc0a 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -678,10 +678,11 @@ static void handle_rpc_func_cmd_shm_alloc(struct te=
e_context *ctx,
> >                                           struct optee_msg_arg *arg,
> >                                           struct optee_call_ctx *call_ctx)
> >  {
> > -       phys_addr_t pa;
> >         struct tee_shm *shm;
> >         size_t sz;
> >         size_t n;
> > +       struct page **pages;
> > +       size_t page_count;
> >
> >         arg->ret_origin =3D TEEC_ORIGIN_COMMS;
> >
> > @@ -716,32 +717,23 @@ static void handle_rpc_func_cmd_shm_alloc(struct te=
e_context *ctx,
> >                 return;
> >         }
> >
> > -       if (tee_shm_get_pa(shm, 0, &pa)) {
> > -               arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > -               goto bad;
> > -       }
> > -
> > -       sz =3D tee_shm_get_size(shm);
> > -
> > -       if (tee_shm_is_dynamic(shm)) {
> > -               struct page **pages;
> > +       /*
> > +        * If there are pages it's dynamically allocated shared memory (n=
ot
> > +        * from the reserved shared memory pool) and needs to be
> > +        * registered.
> > +        */
> > +       pages =3D tee_shm_get_pages(shm, &page_count);
> > +       if (pages) {
> >                 u64 *pages_list;
> > -               size_t page_num;
> > -
> > -               pages =3D tee_shm_get_pages(shm, &page_num);
> > -               if (!pages || !page_num) {
> > -                       arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
> > -                       goto bad;
> > -               }
> >
> > -               pages_list =3D optee_allocate_pages_list(page_num);
> > +               pages_list =3D optee_allocate_pages_list(page_count);
> >                 if (!pages_list) {
> >                         arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
> >                         goto bad;
> >                 }
> >
> >                 call_ctx->pages_list =3D pages_list;
> > -               call_ctx->num_entries =3D page_num;
> > +               call_ctx->num_entries =3D page_count;
> >
> >                 arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT |
> >                                       OPTEE_MSG_ATTR_NONCONTIG;
> > @@ -752,17 +744,22 @@ static void handle_rpc_func_cmd_shm_alloc(struct te=
e_context *ctx,
> >                 arg->params[0].u.tmem.buf_ptr =3D virt_to_phys(pages_list=
) |
> >                         (tee_shm_get_page_offset(shm) &
> >                          (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
> > -               arg->params[0].u.tmem.size =3D tee_shm_get_size(shm);
> > -               arg->params[0].u.tmem.shm_ref =3D (unsigned long)shm;
> >
> > -               optee_fill_pages_list(pages_list, pages, page_num,
> > +               optee_fill_pages_list(pages_list, pages, page_count,
> >                                       tee_shm_get_page_offset(shm));
> >         } else {
> > +               phys_addr_t pa;
> > +
> > +               if (tee_shm_get_pa(shm, 0, &pa)) {
> > +                       arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > +                       goto bad;
> > +               }
> > +
> >                 arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT;
> >                 arg->params[0].u.tmem.buf_ptr =3D pa;
> > -               arg->params[0].u.tmem.size =3D sz;
> > -               arg->params[0].u.tmem.shm_ref =3D (unsigned long)shm;
> >         }
> > +       arg->params[0].u.tmem.size =3D tee_shm_get_size(shm);
> > +       arg->params[0].u.tmem.shm_ref =3D (unsigned long)shm;
> >
> >         arg->ret =3D TEEC_SUCCESS;
> >         return;
> > --
> > 2.34.1
> >

--===============4653054072807342189==--

