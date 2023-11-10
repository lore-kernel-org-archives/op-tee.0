From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 1/2] optee: add page list to kernel private shared memory
Date: Fri, 10 Nov 2023 20:06:33 +0530
Message-ID: 
 <CAFA6WYPqkRdGc6R6Q=w0YJ=SN9FvQ48qDEc6d05gOyyV6x066g@mail.gmail.com>
In-Reply-To: <20231108102755.93079-2-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2542200806694212517=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2542200806694212517==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Wed, 8 Nov 2023 at 15:57, Jens Wiklander <jens.wiklander@linaro.org> wro=
te:
>
> Until now has kernel private shared memory allocated as dynamic shared
> memory (not from the static shared memory pool) been returned without a
> list of physical pages on allocations via RPC. To support allocations
> larger than one page add a list of physical pages for all allocations
> larger than one page.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/core.c    | 40 +++++++++++++++++++++++++--------
>  drivers/tee/optee/smc_abi.c | 45 +++++++++++++++++--------------------
>  2 files changed, 52 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 2a258bd3b6b5..a425eca0173d 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -27,6 +27,7 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool,=
 struct tee_shm *shm,
>                                                    unsigned long start))
>  {
>         unsigned int order =3D get_order(size);
> +       unsigned int nr_pages =3D 1 << order;
>         struct page *page;
>         int rc =3D 0;
>
> @@ -39,12 +40,24 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *poo=
l, struct tee_shm *shm,
>                 return -ENOMEM;
>
>         shm->kaddr =3D page_address(page);
> -       shm->paddr =3D page_to_phys(page);
>         shm->size =3D PAGE_SIZE << order;
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

It looks a bit complex to me. Do we really need it to be conditional?
I was thinking if we can simplify this API as follows:

int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
                               size_t size, size_t align,
                               int (*shm_register)(struct tee_shm *shm))
{
        unsigned int order =3D get_order(size);
        unsigned int nr_pages =3D 1 << order, i;
        struct page **pages;
        struct page *page;
        int rc =3D 0;

        /*
         * Ignore alignment since this is already going to be page aligned
         * and there's no need for any larger alignment.
         */
        page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
        if (!page)
                return -ENOMEM;

        shm->kaddr =3D page_address(page);
        shm->paddr =3D page_to_phys(page);
        shm->size =3D PAGE_SIZE << order;

        pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
        if (!pages) {
                rc =3D -ENOMEM;
                goto err;
        }

        for (i =3D 0; i < nr_pages; i++)
                pages[i] =3D page + i;

        shm->pages =3D pages;
        shm->num_pages =3D nr_pages;

        if (shm_register) {
                rc =3D shm_register(shm);
                if (rc)
                        goto err;
        }

        return 0;

err:
        kfree(pages);
        free_pages((unsigned long)shm->kaddr, order);
        return rc;
}

-Sumit

> +       if (shm_register || nr_pages > 1) {
>                 struct page **pages;
> +               unsigned int i;
>
>                 pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
>                 if (!pages) {
> @@ -55,17 +68,24 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *poo=
l, struct tee_shm *shm,
>                 for (i =3D 0; i < nr_pages; i++)
>                         pages[i] =3D page + i;
>
> -               rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
> -                                 (unsigned long)shm->kaddr);
> -               kfree(pages);
> -               if (rc)
> -                       goto err;
> +               if (shm_register) {
> +                       rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
> +                                         (unsigned long)shm->kaddr);
> +                       kfree(pages);
> +                       if (rc)
> +                               goto err;
> +               } else {
> +                       shm->pages =3D pages;
> +                       shm->num_pages =3D nr_pages;
> +               }
> +       } else {
> +               shm->paddr =3D page_to_phys(page);
>         }
>
>         return 0;
> -
>  err:
>         free_pages((unsigned long)shm->kaddr, order);
> +       shm->kaddr =3D NULL;
>         return rc;
>  }
>
> @@ -77,6 +97,8 @@ void optee_pool_op_free_helper(struct tee_shm_pool *pool,=
 struct tee_shm *shm,
>                 shm_unregister(shm->ctx, shm);
>         free_pages((unsigned long)shm->kaddr, get_order(shm->size));
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
> --
> 2.34.1
>

--===============2542200806694212517==--

