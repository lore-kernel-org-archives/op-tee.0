From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: add page list to kernel private shared memory
Date: Mon, 30 Oct 2023 14:34:29 +0530
Message-ID: 
 <CAFA6WYOw9jbKFA5rvsNt7fqRNgirH2ueH3pRKKSmC9HAmmcfhA@mail.gmail.com>
In-Reply-To: <20231026171650.515275-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5264593974652543112=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5264593974652543112==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

Can we split this change into 2 patches for ease of review?

On Thu, 26 Oct 2023 at 22:47, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Until now has kernel private shared memory allocated as dynamic shared
> memory (not from the static shared memory pool) been returned without a
> list of physical pages on allocations via RPC. To support allocations
> larger than one page add a list of physical pages for all allocations
> larger than one page.

The second patch.

> Allocate the memory with  alloc_pages_exact()
> instead of alloc_pages() for more efficient memory usage.

The first patch.

-Sumit

>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/core.c    | 59 +++++++++++++++++++++++++------------
>  drivers/tee/optee/smc_abi.c | 45 +++++++++++++---------------
>  2 files changed, 61 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 2a258bd3b6b5..60fe351ee5c8 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -26,24 +26,36 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *poo=
l, struct tee_shm *shm,
>                                                    size_t num_pages,
>                                                    unsigned long start))
>  {
> -       unsigned int order =3D get_order(size);
> -       struct page *page;
> +       size_t nr_pages =3D roundup(size, PAGE_SIZE) / PAGE_SIZE;
> +       unsigned int i;
>         int rc =3D 0;
>
>         /*
>          * Ignore alignment since this is already going to be page aligned
>          * and there's no need for any larger alignment.
>          */
> -       page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> -       if (!page)
> +       shm->kaddr =3D alloc_pages_exact(nr_pages * PAGE_SIZE,
> +                                      GFP_KERNEL | __GFP_ZERO);
> +       if (!shm->kaddr)
>                 return -ENOMEM;
>
> -       shm->kaddr =3D page_address(page);
> -       shm->paddr =3D page_to_phys(page);
> -       shm->size =3D PAGE_SIZE << order;
> +       shm->size =3D nr_pages * PAGE_SIZE;
> +       shm->num_pages =3D nr_pages;
>
> -       if (shm_register) {
> -               unsigned int nr_pages =3D 1 << order, i;
> +       /*
> +        * If memory is registered immediately use a temporary page list
> +        * and free it directly after the registration is completed.
> +        *
> +        * Else, if we have allocated more than one page store a page
> +        * list in the struct tee_shm.
> +        *
> +        * Else, store the physical address of the single page that was
> +        * allocated.
> +        *
> +        * optee_pool_op_free_helper() is responsible for freeing the
> +        * resourses allocated in this function.
> +        */
> +       if (shm_register || nr_pages > 1) {
>                 struct page **pages;
>
>                 pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> @@ -53,19 +65,26 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *poo=
l, struct tee_shm *shm,
>                 }
>
>                 for (i =3D 0; i < nr_pages; i++)
> -                       pages[i] =3D page + i;
> -
> -               rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
> -                                 (unsigned long)shm->kaddr);
> -               kfree(pages);
> -               if (rc)
> -                       goto err;
> +                       pages[i] =3D virt_to_page((u8 *)shm->kaddr +
> +                                               i * PAGE_SIZE);
> +
> +               if (shm_register) {
> +                       rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
> +                                         (unsigned long)shm->kaddr);
> +                       kfree(pages);
> +                       if (rc)
> +                               goto err;
> +               } else {
> +                       shm->pages =3D pages;
> +               }
> +       } else {
> +               shm->paddr =3D virt_to_phys(shm->kaddr);
>         }
>
>         return 0;
> -
>  err:
> -       free_pages((unsigned long)shm->kaddr, order);
> +       free_pages_exact(shm->kaddr, shm->size);
> +       shm->kaddr =3D NULL;
>         return rc;
>  }
>
> @@ -75,8 +94,10 @@ void optee_pool_op_free_helper(struct tee_shm_pool *pool=
, struct tee_shm *shm,
>  {
>         if (shm_unregister)
>                 shm_unregister(shm->ctx, shm);
> -       free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> +       free_pages_exact(shm->kaddr, shm->size);
>         shm->kaddr =3D NULL;
> +       kfree(shm->pages);
> +       shm->pages =3D NULL;
>  }
>
>  static void optee_bus_scan(struct work_struct *work)
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index d5b28fd35d66..b69410c7cc0a 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -678,10 +678,11 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_=
context *ctx,
>                                           struct optee_msg_arg *arg,
>                                           struct optee_call_ctx *call_ctx)
>  {
> -       phys_addr_t pa;
>         struct tee_shm *shm;
>         size_t sz;
>         size_t n;
> +       struct page **pages;
> +       size_t page_count;
>
>         arg->ret_origin =3D TEEC_ORIGIN_COMMS;
>
> @@ -716,32 +717,23 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_=
context *ctx,
>                 return;
>         }
>
> -       if (tee_shm_get_pa(shm, 0, &pa)) {
> -               arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> -               goto bad;
> -       }
> -
> -       sz =3D tee_shm_get_size(shm);
> -
> -       if (tee_shm_is_dynamic(shm)) {
> -               struct page **pages;
> +       /*
> +        * If there are pages it's dynamically allocated shared memory (not
> +        * from the reserved shared memory pool) and needs to be
> +        * registered.
> +        */
> +       pages =3D tee_shm_get_pages(shm, &page_count);
> +       if (pages) {
>                 u64 *pages_list;
> -               size_t page_num;
> -
> -               pages =3D tee_shm_get_pages(shm, &page_num);
> -               if (!pages || !page_num) {
> -                       arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
> -                       goto bad;
> -               }
>
> -               pages_list =3D optee_allocate_pages_list(page_num);
> +               pages_list =3D optee_allocate_pages_list(page_count);
>                 if (!pages_list) {
>                         arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
>                         goto bad;
>                 }
>
>                 call_ctx->pages_list =3D pages_list;
> -               call_ctx->num_entries =3D page_num;
> +               call_ctx->num_entries =3D page_count;
>
>                 arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT |
>                                       OPTEE_MSG_ATTR_NONCONTIG;
> @@ -752,17 +744,22 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_=
context *ctx,
>                 arg->params[0].u.tmem.buf_ptr =3D virt_to_phys(pages_list) |
>                         (tee_shm_get_page_offset(shm) &
>                          (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
> -               arg->params[0].u.tmem.size =3D tee_shm_get_size(shm);
> -               arg->params[0].u.tmem.shm_ref =3D (unsigned long)shm;
>
> -               optee_fill_pages_list(pages_list, pages, page_num,
> +               optee_fill_pages_list(pages_list, pages, page_count,
>                                       tee_shm_get_page_offset(shm));
>         } else {
> +               phys_addr_t pa;
> +
> +               if (tee_shm_get_pa(shm, 0, &pa)) {
> +                       arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> +                       goto bad;
> +               }
> +
>                 arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT;
>                 arg->params[0].u.tmem.buf_ptr =3D pa;
> -               arg->params[0].u.tmem.size =3D sz;
> -               arg->params[0].u.tmem.shm_ref =3D (unsigned long)shm;
>         }
> +       arg->params[0].u.tmem.size =3D tee_shm_get_size(shm);
> +       arg->params[0].u.tmem.shm_ref =3D (unsigned long)shm;
>
>         arg->ret =3D TEEC_SUCCESS;
>         return;
>
> base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
> --
> 2.34.1
>

--===============5264593974652543112==--

