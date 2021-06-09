From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 1/7] tee: remove unused tee_shm_pool_alloc_res_mem()
Date: Wed, 09 Jun 2021 09:03:03 -0500
Message-ID: <20210609140303.GE4910@sequoia>
In-Reply-To: <20210609102324.2222332-2-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6618884883768383808=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6618884883768383808==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 2021-06-09 12:23:18, Jens Wiklander wrote:
> None of the drivers in the TEE subsystem uses
> tee_shm_pool_alloc_res_mem() so remove the function.
>=20
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> ---
>  drivers/tee/tee_shm_pool.c | 56 --------------------------------------
>  include/linux/tee_drv.h    | 30 --------------------
>  2 files changed, 86 deletions(-)
>=20
> diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
> index fcbb461fc59c..a9f9d50fd181 100644
> --- a/drivers/tee/tee_shm_pool.c
> +++ b/drivers/tee/tee_shm_pool.c
> @@ -47,62 +47,6 @@ static const struct tee_shm_pool_mgr_ops pool_ops_generi=
c =3D {
>  	.destroy_poolmgr =3D pool_op_gen_destroy_poolmgr,
>  };
> =20
> -/**
> - * tee_shm_pool_alloc_res_mem() - Create a shared memory pool from reserved
> - * memory range
> - * @priv_info:	Information for driver private shared memory pool
> - * @dmabuf_info: Information for dma-buf shared memory pool
> - *
> - * Start and end of pools will must be page aligned.
> - *
> - * Allocation with the flag TEE_SHM_DMA_BUF set will use the range supplied
> - * in @dmabuf, others will use the range provided by @priv.
> - *
> - * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
> - */
> -struct tee_shm_pool *
> -tee_shm_pool_alloc_res_mem(struct tee_shm_pool_mem_info *priv_info,
> -			   struct tee_shm_pool_mem_info *dmabuf_info)
> -{
> -	struct tee_shm_pool_mgr *priv_mgr;
> -	struct tee_shm_pool_mgr *dmabuf_mgr;
> -	void *rc;
> -
> -	/*
> -	 * Create the pool for driver private shared memory
> -	 */
> -	rc =3D tee_shm_pool_mgr_alloc_res_mem(priv_info->vaddr, priv_info->paddr,
> -					    priv_info->size,
> -					    3 /* 8 byte aligned */);
> -	if (IS_ERR(rc))
> -		return rc;
> -	priv_mgr =3D rc;
> -
> -	/*
> -	 * Create the pool for dma_buf shared memory
> -	 */
> -	rc =3D tee_shm_pool_mgr_alloc_res_mem(dmabuf_info->vaddr,
> -					    dmabuf_info->paddr,
> -					    dmabuf_info->size, PAGE_SHIFT);
> -	if (IS_ERR(rc))
> -		goto err_free_priv_mgr;
> -	dmabuf_mgr =3D rc;
> -
> -	rc =3D tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> -	if (IS_ERR(rc))
> -		goto err_free_dmabuf_mgr;
> -
> -	return rc;
> -
> -err_free_dmabuf_mgr:
> -	tee_shm_pool_mgr_destroy(dmabuf_mgr);
> -err_free_priv_mgr:
> -	tee_shm_pool_mgr_destroy(priv_mgr);
> -
> -	return rc;
> -}
> -EXPORT_SYMBOL_GPL(tee_shm_pool_alloc_res_mem);
> -
>  struct tee_shm_pool_mgr *tee_shm_pool_mgr_alloc_res_mem(unsigned long vadd=
r,
>  							phys_addr_t paddr,
>  							size_t size,
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 54269e47ac9a..53b9b2a13a87 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -272,36 +272,6 @@ static inline void tee_shm_pool_mgr_destroy(struct tee=
_shm_pool_mgr *poolm)
>  	poolm->ops->destroy_poolmgr(poolm);
>  }
> =20
> -/**
> - * struct tee_shm_pool_mem_info - holds information needed to create a sha=
red
> - * memory pool
> - * @vaddr:	Virtual address of start of pool
> - * @paddr:	Physical address of start of pool
> - * @size:	Size in bytes of the pool
> - */
> -struct tee_shm_pool_mem_info {
> -	unsigned long vaddr;
> -	phys_addr_t paddr;
> -	size_t size;
> -};
> -
> -/**
> - * tee_shm_pool_alloc_res_mem() - Create a shared memory pool from reserved
> - * memory range
> - * @priv_info:	 Information for driver private shared memory pool
> - * @dmabuf_info: Information for dma-buf shared memory pool
> - *
> - * Start and end of pools will must be page aligned.
> - *
> - * Allocation with the flag TEE_SHM_DMA_BUF set will use the range supplied
> - * in @dmabuf, others will use the range provided by @priv.
> - *
> - * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
> - */
> -struct tee_shm_pool *
> -tee_shm_pool_alloc_res_mem(struct tee_shm_pool_mem_info *priv_info,
> -			   struct tee_shm_pool_mem_info *dmabuf_info);
> -
>  /**
>   * tee_shm_pool_free() - Free a shared memory pool
>   * @pool:	The shared memory pool to free
> --=20
> 2.31.1
>=20

--===============6618884883768383808==--

