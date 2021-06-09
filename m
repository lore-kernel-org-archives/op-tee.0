From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 3/7] tee: add tee_shm_alloc_kernel_buf()
Date: Wed, 09 Jun 2021 09:51:19 -0500
Message-ID: <20210609145119.GG4910@sequoia>
In-Reply-To: <20210609102324.2222332-4-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8877275884798973465=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8877275884798973465==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 2021-06-09 12:23:20, Jens Wiklander wrote:
> Adds a new function tee_shm_alloc_kernel_buf() to allocate shared memory
> from a kernel driver. This function can later be made more lightweight
> by unnecessary dma-buf export.
>=20
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> ---
>  drivers/tee/tee_shm.c   | 18 ++++++++++++++++++
>  include/linux/tee_drv.h |  1 +
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index b9dbf4bce149..63fce8d39d8b 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -192,6 +192,24 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx,=
 size_t size, u32 flags)
>  }
>  EXPORT_SYMBOL_GPL(tee_shm_alloc);
> =20
> +/**
> + * tee_shm_alloc_kernel_buf() - Allocate shared memory for kernel buffer
> + * @ctx:	Context that allocates the shared memory
> + * @size:	Requested size of shared memory
> + *
> + * The returned memory registered in secure world and is suitable to be
> + * passed as a memory buffer in parameter argument to
> + * tee_client_invoke_func(). The memory allocated is later freed with a
> + * call to tee_shm_free().
> + *
> + * @returns a pointer to 'struct tee_shm'
> + */
> +struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t s=
ize)
> +{
> +	return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +}
> +EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
> +
>  struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long ad=
dr,
>  				 size_t length, u32 flags)
>  {
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 62b7c7a55743..58b319766f8e 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -282,6 +282,7 @@ void *tee_get_drvdata(struct tee_device *teedev);
>   * @returns a pointer to 'struct tee_shm'
>   */
>  struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 fl=
ags);
> +struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t s=
ize);
> =20
>  /**
>   * tee_shm_register() - Register shared memory buffer
> --=20
> 2.31.1
>=20

--===============8877275884798973465==--

