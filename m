From: Christian König <christian.koenig@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: handle lookup of shm with reference count 0
Date: Tue, 14 Dec 2021 15:51:50 +0100
Message-ID: <0b974205-4420-52b9-7491-38e830a93bc4@amd.com>
In-Reply-To: <YbifvnSBjW5m19hZ@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4199312479006178609=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4199312479006178609==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 14.12.21 um 14:44 schrieb Greg KH:
> On Tue, Dec 14, 2021 at 01:35:40PM +0100, Jens Wiklander wrote:
>> Since the tee subsystem does not keep a strong reference to its idle
>> shared memory buffers, it races with other threads that try to destroy a
>> shared memory through a close of its dma-buf fd or by unmapping the
>> memory.
>>
>> In tee_shm_get_from_id() when a lookup in teedev->idr has been
>> successful, it is possible that the tee_shm is in the dma-buf teardown
>> path, but that path is blocked by the teedev mutex. Since we don't have
>> an API to tell if the tee_shm is in the dma-buf teardown path or not we
>> must find another way of detecting this condition.
>>
>> Fix this by doing the reference counting directly on the tee_shm using a
>> new refcount_t refcount field. dma-buf is replaced by using
>> anon_inode_getfd() instead, this separates the life-cycle of the
>> underlying file from the tee_shm. tee_shm_put() is updated to hold the
>> mutex when decreasing the refcount to 0 and then remove the tee_shm from
>> teedev->idr before releasing the mutex. This means that the tee_shm can
>> never be found unless it has a refcount larger than 0.
> So you are dropping dma-buf support entirely?  And anon_inode_getfd()
> works instead?  Why do more people not do this as well?

Well, I assume that mostly everybody else actually implements DMA-buf=20
support and not just stubs for the callback function which rejects=20
everybody trying to use it with an error.

So yeah, dropping it completely and using an anon file descriptor=20
instead sounds totally like the right thing to do. Especially since the=20
resulting implementation looks simpler over all.

Christian.

>> Fixes: 967c9cca2cc5 ("tee: generic TEE subsystem")
>> Cc: stable(a)vger.kernel.org
>> Reviewed-by: Lars Persson <larper@axis.com>
>> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>> Reported-by: Patrik Lantz <patrik.lantz@axis.com>
>> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>> ---
>>   drivers/tee/tee_shm.c   | 174 +++++++++++++++-------------------------
>>   include/linux/tee_drv.h |   2 +-
>>   2 files changed, 67 insertions(+), 109 deletions(-)
>>
>> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
>> index 8a8deb95e918..0c82cf981c46 100644
>> --- a/drivers/tee/tee_shm.c
>> +++ b/drivers/tee/tee_shm.c
>> @@ -1,20 +1,17 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /*
>> - * Copyright (c) 2015-2016, Linaro Limited
>> + * Copyright (c) 2015-2021, Linaro Limited
> Nit, did Linaro really make a copyrightable change in 2017, 2018, 2019
> and 2020 as well?  If not, please do not claim it.
>
>>    */
>> +#include <linux/anon_inodes.h>
>>   #include <linux/device.h>
>> -#include <linux/dma-buf.h>
>> -#include <linux/fdtable.h>
>>   #include <linux/idr.h>
>> +#include <linux/mm.h>
>>   #include <linux/sched.h>
>>   #include <linux/slab.h>
>>   #include <linux/tee_drv.h>
>>   #include <linux/uio.h>
>> -#include <linux/module.h>
>>   #include "tee_private.h"
>>  =20
>> -MODULE_IMPORT_NS(DMA_BUF);
>> -
>>   static void release_registered_pages(struct tee_shm *shm)
>>   {
>>   	if (shm->pages) {
>> @@ -31,16 +28,8 @@ static void release_registered_pages(struct tee_shm *sh=
m)
>>   	}
>>   }
>>  =20
>> -static void tee_shm_release(struct tee_shm *shm)
>> +static void tee_shm_release(struct tee_device *teedev, struct tee_shm *sh=
m)
>>   {
>> -	struct tee_device *teedev =3D shm->ctx->teedev;
>> -
>> -	if (shm->flags & TEE_SHM_DMA_BUF) {
>> -		mutex_lock(&teedev->mutex);
>> -		idr_remove(&teedev->idr, shm->id);
>> -		mutex_unlock(&teedev->mutex);
>> -	}
>> -
>>   	if (shm->flags & TEE_SHM_POOL) {
>>   		struct tee_shm_pool_mgr *poolm;
>>  =20
>> @@ -67,45 +56,6 @@ static void tee_shm_release(struct tee_shm *shm)
>>   	tee_device_put(teedev);
>>   }
>>  =20
>> -static struct sg_table *tee_shm_op_map_dma_buf(struct dma_buf_attachment
>> -			*attach, enum dma_data_direction dir)
>> -{
>> -	return NULL;
>> -}
>> -
>> -static void tee_shm_op_unmap_dma_buf(struct dma_buf_attachment *attach,
>> -				     struct sg_table *table,
>> -				     enum dma_data_direction dir)
>> -{
>> -}
>> -
>> -static void tee_shm_op_release(struct dma_buf *dmabuf)
>> -{
>> -	struct tee_shm *shm =3D dmabuf->priv;
>> -
>> -	tee_shm_release(shm);
>> -}
>> -
>> -static int tee_shm_op_mmap(struct dma_buf *dmabuf, struct vm_area_struct =
*vma)
>> -{
>> -	struct tee_shm *shm =3D dmabuf->priv;
>> -	size_t size =3D vma->vm_end - vma->vm_start;
>> -
>> -	/* Refuse sharing shared memory provided by application */
>> -	if (shm->flags & TEE_SHM_USER_MAPPED)
>> -		return -EINVAL;
>> -
>> -	return remap_pfn_range(vma, vma->vm_start, shm->paddr >> PAGE_SHIFT,
>> -			       size, vma->vm_page_prot);
>> -}
>> -
>> -static const struct dma_buf_ops tee_shm_dma_buf_ops =3D {
>> -	.map_dma_buf =3D tee_shm_op_map_dma_buf,
>> -	.unmap_dma_buf =3D tee_shm_op_unmap_dma_buf,
>> -	.release =3D tee_shm_op_release,
>> -	.mmap =3D tee_shm_op_mmap,
>> -};
>> -
>>   struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 =
flags)
>>   {
>>   	struct tee_device *teedev =3D ctx->teedev;
>> @@ -140,6 +90,7 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, =
size_t size, u32 flags)
>>   		goto err_dev_put;
>>   	}
>>  =20
>> +	refcount_set(&shm->refcount, 1);
>>   	shm->flags =3D flags | TEE_SHM_POOL;
>>   	shm->ctx =3D ctx;
>>   	if (flags & TEE_SHM_DMA_BUF)
>> @@ -153,10 +104,7 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx=
, size_t size, u32 flags)
>>   		goto err_kfree;
>>   	}
>>  =20
>> -
>>   	if (flags & TEE_SHM_DMA_BUF) {
>> -		DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>> -
>>   		mutex_lock(&teedev->mutex);
>>   		shm->id =3D idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
>>   		mutex_unlock(&teedev->mutex);
>> @@ -164,28 +112,11 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ct=
x, size_t size, u32 flags)
>>   			ret =3D ERR_PTR(shm->id);
>>   			goto err_pool_free;
>>   		}
>> -
>> -		exp_info.ops =3D &tee_shm_dma_buf_ops;
>> -		exp_info.size =3D shm->size;
>> -		exp_info.flags =3D O_RDWR;
>> -		exp_info.priv =3D shm;
>> -
>> -		shm->dmabuf =3D dma_buf_export(&exp_info);
>> -		if (IS_ERR(shm->dmabuf)) {
>> -			ret =3D ERR_CAST(shm->dmabuf);
>> -			goto err_rem;
>> -		}
>>   	}
>>  =20
>>   	teedev_ctx_get(ctx);
>>  =20
>>   	return shm;
>> -err_rem:
>> -	if (flags & TEE_SHM_DMA_BUF) {
>> -		mutex_lock(&teedev->mutex);
>> -		idr_remove(&teedev->idr, shm->id);
>> -		mutex_unlock(&teedev->mutex);
>> -	}
>>   err_pool_free:
>>   	poolm->ops->free(poolm, shm);
>>   err_kfree:
>> @@ -246,6 +177,7 @@ struct tee_shm *tee_shm_register(struct tee_context *c=
tx, unsigned long addr,
>>   		goto err;
>>   	}
>>  =20
>> +	refcount_set(&shm->refcount, 1);
>>   	shm->flags =3D flags | TEE_SHM_REGISTER;
>>   	shm->ctx =3D ctx;
>>   	shm->id =3D -1;
>> @@ -306,22 +238,6 @@ struct tee_shm *tee_shm_register(struct tee_context *=
ctx, unsigned long addr,
>>   		goto err;
>>   	}
>>  =20
>> -	if (flags & TEE_SHM_DMA_BUF) {
>> -		DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>> -
>> -		exp_info.ops =3D &tee_shm_dma_buf_ops;
>> -		exp_info.size =3D shm->size;
>> -		exp_info.flags =3D O_RDWR;
>> -		exp_info.priv =3D shm;
>> -
>> -		shm->dmabuf =3D dma_buf_export(&exp_info);
>> -		if (IS_ERR(shm->dmabuf)) {
>> -			ret =3D ERR_CAST(shm->dmabuf);
>> -			teedev->desc->ops->shm_unregister(ctx, shm);
>> -			goto err;
>> -		}
>> -	}
>> -
>>   	return shm;
>>   err:
>>   	if (shm) {
>> @@ -339,6 +255,35 @@ struct tee_shm *tee_shm_register(struct tee_context *=
ctx, unsigned long addr,
>>   }
>>   EXPORT_SYMBOL_GPL(tee_shm_register);
>>  =20
>> +static int tee_shm_fop_release(struct inode *inode, struct file *filp)
>> +{
>> +	tee_shm_put(filp->private_data);
>> +	return 0;
>> +}
>> +
>> +static int tee_shm_fop_mmap(struct file *filp, struct vm_area_struct *vma)
>> +{
>> +	struct tee_shm *shm =3D filp->private_data;
>> +	size_t size =3D vma->vm_end - vma->vm_start;
>> +
>> +	/* Refuse sharing shared memory provided by application */
>> +	if (shm->flags & TEE_SHM_USER_MAPPED)
>> +		return -EINVAL;
>> +
>> +	/* check for overflowing the buffer's size */
>> +	if (vma->vm_pgoff + vma_pages(vma) > shm->size >> PAGE_SHIFT)
>> +		return -EINVAL;
>> +
>> +	return remap_pfn_range(vma, vma->vm_start, shm->paddr >> PAGE_SHIFT,
>> +			       size, vma->vm_page_prot);
>> +}
>> +
>> +static const struct file_operations tee_shm_fops =3D {
>> +	.owner =3D THIS_MODULE,
>> +	.release =3D tee_shm_fop_release,
>> +	.mmap =3D tee_shm_fop_mmap,
>> +};
>> +
>>   /**
>>    * tee_shm_get_fd() - Increase reference count and return file descriptor
>>    * @shm:	Shared memory handle
>> @@ -351,10 +296,11 @@ int tee_shm_get_fd(struct tee_shm *shm)
>>   	if (!(shm->flags & TEE_SHM_DMA_BUF))
>>   		return -EINVAL;
>>  =20
>> -	get_dma_buf(shm->dmabuf);
>> -	fd =3D dma_buf_fd(shm->dmabuf, O_CLOEXEC);
>> +	/* matched by tee_shm_put() in tee_shm_op_release() */
>> +	refcount_inc(&shm->refcount);
>> +	fd =3D anon_inode_getfd("tee_shm", &tee_shm_fops, shm, O_RDWR);
>>   	if (fd < 0)
>> -		dma_buf_put(shm->dmabuf);
>> +		tee_shm_put(shm);
>>   	return fd;
>>   }
>>  =20
>> @@ -364,17 +310,7 @@ int tee_shm_get_fd(struct tee_shm *shm)
>>    */
>>   void tee_shm_free(struct tee_shm *shm)
>>   {
>> -	/*
>> -	 * dma_buf_put() decreases the dmabuf reference counter and will
>> -	 * call tee_shm_release() when the last reference is gone.
>> -	 *
>> -	 * In the case of driver private memory we call tee_shm_release
>> -	 * directly instead as it doesn't have a reference counter.
>> -	 */
>> -	if (shm->flags & TEE_SHM_DMA_BUF)
>> -		dma_buf_put(shm->dmabuf);
>> -	else
>> -		tee_shm_release(shm);
>> +	tee_shm_put(shm);
>>   }
>>   EXPORT_SYMBOL_GPL(tee_shm_free);
>>  =20
>> @@ -481,10 +417,15 @@ struct tee_shm *tee_shm_get_from_id(struct tee_conte=
xt *ctx, int id)
>>   	teedev =3D ctx->teedev;
>>   	mutex_lock(&teedev->mutex);
>>   	shm =3D idr_find(&teedev->idr, id);
>> +	/*
>> +	 * If the tee_shm was found in the IDR it must have a refcount
>> +	 * larger than 0 due to the guarantee in tee_shm_put() below. So
>> +	 * it's safe to use refcount_inc().
>> +	 */
>>   	if (!shm || shm->ctx !=3D ctx)
>>   		shm =3D ERR_PTR(-EINVAL);
>> -	else if (shm->flags & TEE_SHM_DMA_BUF)
>> -		get_dma_buf(shm->dmabuf);
>> +	else
>> +		refcount_inc(&shm->refcount);
>>   	mutex_unlock(&teedev->mutex);
>>   	return shm;
>>   }
>> @@ -496,7 +437,24 @@ EXPORT_SYMBOL_GPL(tee_shm_get_from_id);
>>    */
>>   void tee_shm_put(struct tee_shm *shm)
>>   {
>> -	if (shm->flags & TEE_SHM_DMA_BUF)
>> -		dma_buf_put(shm->dmabuf);
>> +	struct tee_device *teedev =3D shm->ctx->teedev;
>> +	bool do_release =3D false;
>> +
>> +	mutex_lock(&teedev->mutex);
>> +	if (refcount_dec_and_test(&shm->refcount)) {
>> +		/*
>> +		 * refcount has reached 0, we must now remove it from the
>> +		 * IDR before releasing the mutex. This will guarantee that
>> +		 * the refcount_inc() in tee_shm_get_from_id() never starts
>> +		 * from 0.
>> +		 */
>> +		if (shm->flags & TEE_SHM_DMA_BUF)
>> +			idr_remove(&teedev->idr, shm->id);
>> +		do_release =3D true;
> As you are using a refcount in the "traditional" way, why not just use a
> kref instead?  That solves your "do_release" mess here.
>
> thanks,
>
> greg k-h


--===============4199312479006178609==--

