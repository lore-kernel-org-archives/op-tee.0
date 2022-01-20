From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 08/12] optee: add optee_pool_op_free_helper()
Date: Thu, 20 Jan 2022 16:27:37 +0530
Message-ID: 
 <CAFA6WYN5JgY67sdk0K8Az6+T5tsQo2wbZaiNX4oigRiKRPaA+A@mail.gmail.com>
In-Reply-To: <20220114150824.3578829-9-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6766032279307514354=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6766032279307514354==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Jan 2022 at 20:38, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Adds a common helper function to free a tee_shm allocated using the
> helper function optee_pool_op_alloc_helper().
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/core.c          | 10 ++++++++++
>  drivers/tee/optee/ffa_abi.c       |  4 +---
>  drivers/tee/optee/optee_private.h |  3 +++
>  drivers/tee/optee/smc_abi.c       |  7 +++----
>  4 files changed, 17 insertions(+), 7 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index f4bccb5f0e93..daf947e98d14 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -69,6 +69,16 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool=
, struct tee_shm *shm,
>         return rc;
>  }
>
> +void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *=
shm,
> +                              int (*shm_unregister)(struct tee_context *ct=
x,
> +                                                    struct tee_shm *shm))
> +{
> +       if (shm_unregister)
> +               shm_unregister(shm->ctx, shm);
> +       free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> +       shm->kaddr =3D NULL;
> +}
> +
>  static void optee_bus_scan(struct work_struct *work)
>  {
>         WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 5ec484b42432..4cbc45035f92 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -379,9 +379,7 @@ static int pool_ffa_op_alloc(struct tee_shm_pool *pool,
>  static void pool_ffa_op_free(struct tee_shm_pool *pool,
>                              struct tee_shm *shm)
>  {
> -       optee_ffa_shm_unregister(shm->ctx, shm);
> -       free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> -       shm->kaddr =3D NULL;
> +       optee_pool_op_free_helper(pool, shm, optee_ffa_shm_unregister);
>  }
>
>  static void pool_ffa_op_destroy_pool(struct tee_shm_pool *pool)
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_pr=
ivate.h
> index df3a483bbf46..e77765c78878 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -236,6 +236,9 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *poo=
l, struct tee_shm *shm,
>                                                    struct page **pages,
>                                                    size_t num_pages,
>                                                    unsigned long start));
> +void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *=
shm,
> +                              int (*shm_unregister)(struct tee_context *ct=
x,
> +                                                    struct tee_shm *shm));
>
>
>  void optee_remove_common(struct optee *optee);
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index f2ef76451443..0b27688d1e97 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -548,10 +548,9 @@ static void pool_op_free(struct tee_shm_pool *pool,
>                          struct tee_shm *shm)
>  {
>         if (!(shm->flags & TEE_SHM_PRIV))
> -               optee_shm_unregister(shm->ctx, shm);
> -
> -       free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> -       shm->kaddr =3D NULL;
> +               optee_pool_op_free_helper(pool, shm, optee_shm_unregister);
> +       else
> +               optee_pool_op_free_helper(pool, shm, NULL);
>  }
>
>  static void pool_op_destroy_pool(struct tee_shm_pool *pool)
> --
> 2.31.1
>

--===============6766032279307514354==--

