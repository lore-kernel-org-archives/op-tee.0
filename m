From: Sumit Garg <sumit.garg@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 06/10] tee: new ioctl to a register tee_shm from a
 dmabuf file descriptor
Date: Tue, 25 Mar 2025 12:20:30 +0530
Message-ID: <Z-JSNoALMOoyfOXu@sumit-X1>
In-Reply-To: <20250305130634.1850178-7-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6933407992444265452=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6933407992444265452==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Wed, Mar 05, 2025 at 02:04:12PM +0100, Jens Wiklander wrote:
> From: Etienne Carriere <etienne.carriere@linaro.org>
>=20
> Enable userspace to create a tee_shm object that refers to a dmabuf
> reference.
>=20
> Userspace registers the dmabuf file descriptor as in a tee_shm object.
> The registration is completed with a tee_shm file descriptor returned to
> userspace.
>=20
> Userspace is free to close the dmabuf file descriptor now since all the
> resources are now held via the tee_shm object.
>=20
> Closing the tee_shm file descriptor will release all resources used by the
> tee_shm object.
>=20
> This change only support dmabuf references that relates to physically
> contiguous memory buffers.
>=20
> New tee_shm flag to identify tee_shm objects built from a registered
> dmabuf, TEE_SHM_DMA_BUF.
>=20
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> Signed-off-by: Olivier Masse <olivier.masse@nxp.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_core.c    | 145 ++++++++++++++++++++++++++-----------
>  drivers/tee/tee_private.h |   1 +
>  drivers/tee/tee_shm.c     | 146 ++++++++++++++++++++++++++++++++++++--
>  include/linux/tee_core.h  |   1 +
>  include/linux/tee_drv.h   |  10 +++
>  include/uapi/linux/tee.h  |  29 ++++++++
>  6 files changed, 288 insertions(+), 44 deletions(-)
>=20

I am still trying to find if we really need a separate IOCTL to register
DMA heap with TEE subsystem. Can't we initialize tee_shm as a member of
struct tee_heap_buffer in tee_dma_heap_alloc() where the allocation
happens? We can always find a reference back to tee_shm object from DMA
buffer.

-Sumit

> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 685afcaa3ea1..3a71643766d5 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -353,6 +353,103 @@ tee_ioctl_shm_register(struct tee_context *ctx,
>  	return ret;
>  }
> =20
> +static int
> +tee_ioctl_shm_register_fd(struct tee_context *ctx,
> +			  struct tee_ioctl_shm_register_fd_data __user *udata)
> +{
> +	struct tee_ioctl_shm_register_fd_data data;
> +	struct tee_shm *shm;
> +	long ret;
> +
> +	if (copy_from_user(&data, udata, sizeof(data)))
> +		return -EFAULT;
> +
> +	/* Currently no input flags are supported */
> +	if (data.flags)
> +		return -EINVAL;
> +
> +	shm =3D tee_shm_register_fd(ctx, data.fd);
> +	if (IS_ERR(shm))
> +		return -EINVAL;
> +
> +	data.id =3D shm->id;
> +	data.flags =3D shm->flags;
> +	data.size =3D shm->size;
> +
> +	if (copy_to_user(udata, &data, sizeof(data)))
> +		ret =3D -EFAULT;
> +	else
> +		ret =3D tee_shm_get_fd(shm);
> +
> +	/*
> +	 * When user space closes the file descriptor the shared memory
> +	 * should be freed or if tee_shm_get_fd() failed then it will
> +	 * be freed immediately.
> +	 */
> +	tee_shm_put(shm);
> +	return ret;
> +}
> +
> +static int param_from_user_memref(struct tee_context *ctx,
> +				  struct tee_param_memref *memref,
> +				  struct tee_ioctl_param *ip)
> +{
> +	struct tee_shm *shm;
> +	size_t offs =3D 0;
> +
> +	/*
> +	 * If a NULL pointer is passed to a TA in the TEE,
> +	 * the ip.c IOCTL parameters is set to TEE_MEMREF_NULL
> +	 * indicating a NULL memory reference.
> +	 */
> +	if (ip->c !=3D TEE_MEMREF_NULL) {
> +		/*
> +		 * If we fail to get a pointer to a shared
> +		 * memory object (and increase the ref count)
> +		 * from an identifier we return an error. All
> +		 * pointers that has been added in params have
> +		 * an increased ref count. It's the callers
> +		 * responibility to do tee_shm_put() on all
> +		 * resolved pointers.
> +		 */
> +		shm =3D tee_shm_get_from_id(ctx, ip->c);
> +		if (IS_ERR(shm))
> +			return PTR_ERR(shm);
> +
> +		/*
> +		 * Ensure offset + size does not overflow
> +		 * offset and does not overflow the size of
> +		 * the referred shared memory object.
> +		 */
> +		if ((ip->a + ip->b) < ip->a ||
> +		    (ip->a + ip->b) > shm->size) {
> +			tee_shm_put(shm);
> +			return -EINVAL;
> +		}
> +
> +		if (shm->flags & TEE_SHM_DMA_BUF) {
> +			struct tee_shm *parent_shm;
> +
> +			parent_shm =3D tee_shm_get_parent_shm(shm, &offs);
> +			if (parent_shm) {
> +				tee_shm_put(shm);
> +				shm =3D parent_shm;
> +			}
> +		}
> +	} else if (ctx->cap_memref_null) {
> +		/* Pass NULL pointer to OP-TEE */
> +		shm =3D NULL;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	memref->shm_offs =3D ip->a + offs;
> +	memref->size =3D ip->b;
> +	memref->shm =3D shm;
> +
> +	return 0;
> +}
> +
>  static int params_from_user(struct tee_context *ctx, struct tee_param *par=
ams,
>  			    size_t num_params,
>  			    struct tee_ioctl_param __user *uparams)
> @@ -360,8 +457,8 @@ static int params_from_user(struct tee_context *ctx, st=
ruct tee_param *params,
>  	size_t n;
> =20
>  	for (n =3D 0; n < num_params; n++) {
> -		struct tee_shm *shm;
>  		struct tee_ioctl_param ip;
> +		int rc;
> =20
>  		if (copy_from_user(&ip, uparams + n, sizeof(ip)))
>  			return -EFAULT;
> @@ -384,45 +481,10 @@ static int params_from_user(struct tee_context *ctx, =
struct tee_param *params,
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
> -			/*
> -			 * If a NULL pointer is passed to a TA in the TEE,
> -			 * the ip.c IOCTL parameters is set to TEE_MEMREF_NULL
> -			 * indicating a NULL memory reference.
> -			 */
> -			if (ip.c !=3D TEE_MEMREF_NULL) {
> -				/*
> -				 * If we fail to get a pointer to a shared
> -				 * memory object (and increase the ref count)
> -				 * from an identifier we return an error. All
> -				 * pointers that has been added in params have
> -				 * an increased ref count. It's the callers
> -				 * responibility to do tee_shm_put() on all
> -				 * resolved pointers.
> -				 */
> -				shm =3D tee_shm_get_from_id(ctx, ip.c);
> -				if (IS_ERR(shm))
> -					return PTR_ERR(shm);
> -
> -				/*
> -				 * Ensure offset + size does not overflow
> -				 * offset and does not overflow the size of
> -				 * the referred shared memory object.
> -				 */
> -				if ((ip.a + ip.b) < ip.a ||
> -				    (ip.a + ip.b) > shm->size) {
> -					tee_shm_put(shm);
> -					return -EINVAL;
> -				}
> -			} else if (ctx->cap_memref_null) {
> -				/* Pass NULL pointer to OP-TEE */
> -				shm =3D NULL;
> -			} else {
> -				return -EINVAL;
> -			}
> -
> -			params[n].u.memref.shm_offs =3D ip.a;
> -			params[n].u.memref.size =3D ip.b;
> -			params[n].u.memref.shm =3D shm;
> +			rc =3D param_from_user_memref(ctx, &params[n].u.memref,
> +						    &ip);
> +			if (rc)
> +				return rc;
>  			break;
>  		default:
>  			/* Unknown attribute */
> @@ -827,6 +889,8 @@ static long tee_ioctl(struct file *filp, unsigned int c=
md, unsigned long arg)
>  		return tee_ioctl_shm_alloc(ctx, uarg);
>  	case TEE_IOC_SHM_REGISTER:
>  		return tee_ioctl_shm_register(ctx, uarg);
> +	case TEE_IOC_SHM_REGISTER_FD:
> +		return tee_ioctl_shm_register_fd(ctx, uarg);
>  	case TEE_IOC_OPEN_SESSION:
>  		return tee_ioctl_open_session(ctx, uarg);
>  	case TEE_IOC_INVOKE:
> @@ -1288,3 +1352,4 @@ MODULE_AUTHOR("Linaro");
>  MODULE_DESCRIPTION("TEE Driver");
>  MODULE_VERSION("1.0");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS("DMA_BUF");
> diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
> index 6c6ff5d5eed2..aad7f6c7e0f0 100644
> --- a/drivers/tee/tee_private.h
> +++ b/drivers/tee/tee_private.h
> @@ -24,6 +24,7 @@ void teedev_ctx_put(struct tee_context *ctx);
>  struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t siz=
e);
>  struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>  					  unsigned long addr, size_t length);
> +struct tee_shm *tee_shm_get_parent_shm(struct tee_shm *shm, size_t *offs);
> =20
>  int tee_heap_update_from_dma_buf(struct tee_device *teedev,
>  				 struct dma_buf *dmabuf, size_t *offset,
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index daf6e5cfd59a..8b79918468b5 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -4,6 +4,7 @@
>   */
>  #include <linux/anon_inodes.h>
>  #include <linux/device.h>
> +#include <linux/dma-buf.h>
>  #include <linux/idr.h>
>  #include <linux/io.h>
>  #include <linux/mm.h>
> @@ -15,6 +16,16 @@
>  #include <linux/highmem.h>
>  #include "tee_private.h"
> =20
> +/* extra references appended to shm object for registered shared memory */
> +struct tee_shm_dmabuf_ref {
> +	struct tee_shm shm;
> +	size_t offset;
> +	struct dma_buf *dmabuf;
> +	struct dma_buf_attachment *attach;
> +	struct sg_table *sgt;
> +	struct tee_shm *parent_shm;
> +};
> +
>  static void shm_put_kernel_pages(struct page **pages, size_t page_count)
>  {
>  	size_t n;
> @@ -45,7 +56,23 @@ static void release_registered_pages(struct tee_shm *shm)
> =20
>  static void tee_shm_release(struct tee_device *teedev, struct tee_shm *shm)
>  {
> -	if (shm->flags & TEE_SHM_POOL) {
> +	struct tee_shm *parent_shm =3D NULL;
> +	void *p =3D shm;
> +
> +	if (shm->flags & TEE_SHM_DMA_BUF) {
> +		struct tee_shm_dmabuf_ref *ref;
> +
> +		ref =3D container_of(shm, struct tee_shm_dmabuf_ref, shm);
> +		parent_shm =3D ref->parent_shm;
> +		p =3D ref;
> +		if (ref->attach) {
> +			dma_buf_unmap_attachment(ref->attach, ref->sgt,
> +						 DMA_BIDIRECTIONAL);
> +
> +			dma_buf_detach(ref->dmabuf, ref->attach);
> +		}
> +		dma_buf_put(ref->dmabuf);
> +	} else if (shm->flags & TEE_SHM_POOL) {
>  		teedev->pool->ops->free(teedev->pool, shm);
>  	} else if (shm->flags & TEE_SHM_DYNAMIC) {
>  		int rc =3D teedev->desc->ops->shm_unregister(shm->ctx, shm);
> @@ -57,9 +84,10 @@ static void tee_shm_release(struct tee_device *teedev, s=
truct tee_shm *shm)
>  		release_registered_pages(shm);
>  	}
> =20
> -	teedev_ctx_put(shm->ctx);
> +	if (shm->ctx)
> +		teedev_ctx_put(shm->ctx);
> =20
> -	kfree(shm);
> +	kfree(p);
> =20
>  	tee_device_put(teedev);
>  }
> @@ -169,7 +197,7 @@ struct tee_shm *tee_shm_alloc_user_buf(struct tee_conte=
xt *ctx, size_t size)
>   * tee_client_invoke_func(). The memory allocated is later freed with a
>   * call to tee_shm_free().
>   *
> - * @returns a pointer to 'struct tee_shm'
> + * @returns a pointer to 'struct tee_shm' on success, and ERR_PTR on failu=
re
>   */
>  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t s=
ize)
>  {
> @@ -179,6 +207,116 @@ struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_c=
ontext *ctx, size_t size)
>  }
>  EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
> =20
> +struct tee_shm *tee_shm_register_fd(struct tee_context *ctx, int fd)
> +{
> +	struct tee_shm_dmabuf_ref *ref;
> +	int rc;
> +
> +	if (!tee_device_get(ctx->teedev))
> +		return ERR_PTR(-EINVAL);
> +
> +	teedev_ctx_get(ctx);
> +
> +	ref =3D kzalloc(sizeof(*ref), GFP_KERNEL);
> +	if (!ref) {
> +		rc =3D -ENOMEM;
> +		goto err_put_tee;
> +	}
> +
> +	refcount_set(&ref->shm.refcount, 1);
> +	ref->shm.ctx =3D ctx;
> +	ref->shm.id =3D -1;
> +	ref->shm.flags =3D TEE_SHM_DMA_BUF;
> +
> +	ref->dmabuf =3D dma_buf_get(fd);
> +	if (IS_ERR(ref->dmabuf)) {
> +		rc =3D PTR_ERR(ref->dmabuf);
> +		goto err_kfree_ref;
> +	}
> +
> +	rc =3D tee_heap_update_from_dma_buf(ctx->teedev, ref->dmabuf,
> +					  &ref->offset, &ref->shm,
> +					  &ref->parent_shm);
> +	if (!rc)
> +		goto out;
> +	if (rc !=3D -EINVAL)
> +		goto err_put_dmabuf;
> +
> +	ref->attach =3D dma_buf_attach(ref->dmabuf, &ctx->teedev->dev);
> +	if (IS_ERR(ref->attach)) {
> +		rc =3D PTR_ERR(ref->attach);
> +		goto err_put_dmabuf;
> +	}
> +
> +	ref->sgt =3D dma_buf_map_attachment(ref->attach, DMA_BIDIRECTIONAL);
> +	if (IS_ERR(ref->sgt)) {
> +		rc =3D PTR_ERR(ref->sgt);
> +		goto err_detach;
> +	}
> +
> +	if (sg_nents(ref->sgt->sgl) !=3D 1) {
> +		rc =3D PTR_ERR(ref->sgt->sgl);
> +		goto err_unmap_attachement;
> +	}
> +
> +	ref->shm.paddr =3D page_to_phys(sg_page(ref->sgt->sgl));
> +	ref->shm.size =3D ref->sgt->sgl->length;
> +
> +out:
> +	mutex_lock(&ref->shm.ctx->teedev->mutex);
> +	ref->shm.id =3D idr_alloc(&ref->shm.ctx->teedev->idr, &ref->shm,
> +				1, 0, GFP_KERNEL);
> +	mutex_unlock(&ref->shm.ctx->teedev->mutex);
> +	if (ref->shm.id < 0) {
> +		rc =3D ref->shm.id;
> +		if (ref->attach)
> +			goto err_unmap_attachement;
> +		goto err_put_dmabuf;
> +	}
> +
> +	return &ref->shm;
> +
> +err_unmap_attachement:
> +	dma_buf_unmap_attachment(ref->attach, ref->sgt, DMA_BIDIRECTIONAL);
> +err_detach:
> +	dma_buf_detach(ref->dmabuf, ref->attach);
> +err_put_dmabuf:
> +	dma_buf_put(ref->dmabuf);
> +err_kfree_ref:
> +	kfree(ref);
> +err_put_tee:
> +	teedev_ctx_put(ctx);
> +	tee_device_put(ctx->teedev);
> +
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_GPL(tee_shm_register_fd);
> +
> +struct tee_shm *tee_shm_get_parent_shm(struct tee_shm *shm, size_t *offs)
> +{
> +	struct tee_shm *parent_shm =3D NULL;
> +
> +	if (shm->flags & TEE_SHM_DMA_BUF) {
> +		struct tee_shm_dmabuf_ref *ref;
> +
> +		ref =3D container_of(shm, struct tee_shm_dmabuf_ref, shm);
> +		if (ref->parent_shm) {
> +			/*
> +			 * the shm already has one reference to
> +			 * ref->parent_shm so we should be clear of 0.
> +			 * We're getting another reference since the caller
> +			 * of this function expects to put the returned
> +			 * parent_shm when it's done with it.
> +			 */
> +			parent_shm =3D ref->parent_shm;
> +			refcount_inc(&parent_shm->refcount);
> +			*offs =3D ref->offset;
> +		}
> +	}
> +
> +	return parent_shm;
> +}
> +
>  /**
>   * tee_shm_alloc_priv_buf() - Allocate shared memory for a privately shared
>   *			      kernel buffer
> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> index 16ef078247ae..6bd833b6d0e1 100644
> --- a/include/linux/tee_core.h
> +++ b/include/linux/tee_core.h
> @@ -28,6 +28,7 @@
>  #define TEE_SHM_USER_MAPPED	BIT(1)  /* Memory mapped in user space */
>  #define TEE_SHM_POOL		BIT(2)  /* Memory allocated from pool */
>  #define TEE_SHM_PRIV		BIT(3)  /* Memory private to TEE driver */
> +#define TEE_SHM_DMA_BUF		BIT(4)	/* Memory with dma-buf handle */
> =20
>  #define TEE_DEVICE_FLAG_REGISTERED	0x1
>  #define TEE_MAX_DEV_NAME_LEN		32
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index a54c203000ed..824f1251de60 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -116,6 +116,16 @@ struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_co=
ntext *ctx, size_t size);
>  struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
>  					    void *addr, size_t length);
> =20
> +/**
> + * tee_shm_register_fd() - Register shared memory from file descriptor
> + *
> + * @ctx:	Context that allocates the shared memory
> + * @fd:		Shared memory file descriptor reference
> + *
> + * @returns a pointer to 'struct tee_shm' on success, and ERR_PTR on failu=
re
> + */
> +struct tee_shm *tee_shm_register_fd(struct tee_context *ctx, int fd);
> +
>  /**
>   * tee_shm_free() - Free shared memory
>   * @shm:	Handle to shared memory to free
> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
> index d0430bee8292..1f9a4ac2b211 100644
> --- a/include/uapi/linux/tee.h
> +++ b/include/uapi/linux/tee.h
> @@ -118,6 +118,35 @@ struct tee_ioctl_shm_alloc_data {
>  #define TEE_IOC_SHM_ALLOC	_IOWR(TEE_IOC_MAGIC, TEE_IOC_BASE + 1, \
>  				     struct tee_ioctl_shm_alloc_data)
> =20
> +/**
> + * struct tee_ioctl_shm_register_fd_data - Shared memory registering argum=
ent
> + * @fd:		[in] File descriptor identifying the shared memory
> + * @size:	[out] Size of shared memory to allocate
> + * @flags:	[in] Flags to/from allocation.
> + * @id:		[out] Identifier of the shared memory
> + *
> + * The flags field should currently be zero as input. Updated by the call
> + * with actual flags as defined by TEE_IOCTL_SHM_* above.
> + * This structure is used as argument for TEE_IOC_SHM_REGISTER_FD below.
> + */
> +struct tee_ioctl_shm_register_fd_data {
> +	__s64 fd;
> +	__u64 size;
> +	__u32 flags;
> +	__s32 id;
> +};
> +
> +/**
> + * TEE_IOC_SHM_REGISTER_FD - register a shared memory from a file descript=
or
> + *
> + * Returns a file descriptor on success or < 0 on failure
> + *
> + * The returned file descriptor refers to the shared memory object in kern=
el
> + * land. The shared memory is freed when the descriptor is closed.
> + */
> +#define TEE_IOC_SHM_REGISTER_FD	_IOWR(TEE_IOC_MAGIC, TEE_IOC_BASE + 8, \
> +				     struct tee_ioctl_shm_register_fd_data)
> +
>  /**
>   * struct tee_ioctl_buf_data - Variable sized buffer
>   * @buf_ptr:	[in] A __user pointer to a buffer
> --=20
> 2.43.0
>=20

--===============6933407992444265452==--

