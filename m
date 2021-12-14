From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: handle lookup of shm with reference count 0
Date: Tue, 14 Dec 2021 17:31:44 +0100
Message-ID: <20211214163144.GA1807724@jade>
In-Reply-To: <Ybi3Vx1UzJ/tpTHq@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2944394642773876071=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2944394642773876071==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 14, 2021 at 04:25:11PM +0100, Greg KH wrote:
> On Tue, Dec 14, 2021 at 03:59:57PM +0100, Jens Wiklander wrote:
> > On Tue, Dec 14, 2021 at 02:44:30PM +0100, Greg KH wrote:
> > > On Tue, Dec 14, 2021 at 01:35:40PM +0100, Jens Wiklander wrote:
> > > > Since the tee subsystem does not keep a strong reference to its idle
> > > > shared memory buffers, it races with other threads that try to destro=
y a
> > > > shared memory through a close of its dma-buf fd or by unmapping the
> > > > memory.
> > > >=20
> > > > In tee_shm_get_from_id() when a lookup in teedev->idr has been
> > > > successful, it is possible that the tee_shm is in the dma-buf teardown
> > > > path, but that path is blocked by the teedev mutex. Since we don't ha=
ve
> > > > an API to tell if the tee_shm is in the dma-buf teardown path or not =
we
> > > > must find another way of detecting this condition.
> > > >=20
> > > > Fix this by doing the reference counting directly on the tee_shm usin=
g a
> > > > new refcount_t refcount field. dma-buf is replaced by using
> > > > anon_inode_getfd() instead, this separates the life-cycle of the
> > > > underlying file from the tee_shm. tee_shm_put() is updated to hold the
> > > > mutex when decreasing the refcount to 0 and then remove the tee_shm f=
rom
> > > > teedev->idr before releasing the mutex. This means that the tee_shm c=
an
> > > > never be found unless it has a refcount larger than 0.
> > >=20
> > > So you are dropping dma-buf support entirely?  And anon_inode_getfd()
> > > works instead?  Why do more people not do this as well?
> >=20
> > I don't know, but it should be noted that we're not doing very much with
> > this file descriptor. We're only using it with mmap() and close().
> >=20
> > >=20
> > > >=20
> > > > Fixes: 967c9cca2cc5 ("tee: generic TEE subsystem")
> > > > Cc: stable(a)vger.kernel.org
> > > > Reviewed-by: Lars Persson <larper@axis.com>
> > > > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> > > > Reported-by: Patrik Lantz <patrik.lantz@axis.com>
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > ---
> > > >  drivers/tee/tee_shm.c   | 174 +++++++++++++++-----------------------=
--
> > > >  include/linux/tee_drv.h |   2 +-
> > > >  2 files changed, 67 insertions(+), 109 deletions(-)
> > > >=20
> > > > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > > > index 8a8deb95e918..0c82cf981c46 100644
> > > > --- a/drivers/tee/tee_shm.c
> > > > +++ b/drivers/tee/tee_shm.c
> > > > @@ -1,20 +1,17 @@
> > > >  // SPDX-License-Identifier: GPL-2.0-only
> > > >  /*
> > > > - * Copyright (c) 2015-2016, Linaro Limited
> > > > + * Copyright (c) 2015-2021, Linaro Limited
> > >=20
> > > Nit, did Linaro really make a copyrightable change in 2017, 2018, 2019
> > > and 2020 as well?  If not, please do not claim it.
> >=20
> > Fair enough, I was a bit lazy 2018 shouldn't be there now that I've
> > checked the log. I'll fix.
> >=20
> > >=20
> > > >   */
> > > > +#include <linux/anon_inodes.h>
> > > >  #include <linux/device.h>
> > > > -#include <linux/dma-buf.h>
> > > > -#include <linux/fdtable.h>
> > > >  #include <linux/idr.h>
> > > > +#include <linux/mm.h>
> > > >  #include <linux/sched.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/tee_drv.h>
> > > >  #include <linux/uio.h>
> > > > -#include <linux/module.h>
> > > >  #include "tee_private.h"
> > > > =20
> > > > -MODULE_IMPORT_NS(DMA_BUF);
> > > > -
> > > >  static void release_registered_pages(struct tee_shm *shm)
> > > >  {
> > > >  	if (shm->pages) {
> > > > @@ -31,16 +28,8 @@ static void release_registered_pages(struct tee_sh=
m *shm)
> > > >  	}
> > > >  }
> > > > =20
> > > > -static void tee_shm_release(struct tee_shm *shm)
> > > > +static void tee_shm_release(struct tee_device *teedev, struct tee_sh=
m *shm)
> > > >  {
> > > > -	struct tee_device *teedev =3D shm->ctx->teedev;
> > > > -
> > > > -	if (shm->flags & TEE_SHM_DMA_BUF) {
> > > > -		mutex_lock(&teedev->mutex);
> > > > -		idr_remove(&teedev->idr, shm->id);
> > > > -		mutex_unlock(&teedev->mutex);
> > > > -	}
> > > > -
> > > >  	if (shm->flags & TEE_SHM_POOL) {
> > > >  		struct tee_shm_pool_mgr *poolm;
> > > > =20
> > > > @@ -67,45 +56,6 @@ static void tee_shm_release(struct tee_shm *shm)
> > > >  	tee_device_put(teedev);
> > > >  }
> > > > =20
> > > > -static struct sg_table *tee_shm_op_map_dma_buf(struct dma_buf_attach=
ment
> > > > -			*attach, enum dma_data_direction dir)
> > > > -{
> > > > -	return NULL;
> > > > -}
> > > > -
> > > > -static void tee_shm_op_unmap_dma_buf(struct dma_buf_attachment *atta=
ch,
> > > > -				     struct sg_table *table,
> > > > -				     enum dma_data_direction dir)
> > > > -{
> > > > -}
> > > > -
> > > > -static void tee_shm_op_release(struct dma_buf *dmabuf)
> > > > -{
> > > > -	struct tee_shm *shm =3D dmabuf->priv;
> > > > -
> > > > -	tee_shm_release(shm);
> > > > -}
> > > > -
> > > > -static int tee_shm_op_mmap(struct dma_buf *dmabuf, struct vm_area_st=
ruct *vma)
> > > > -{
> > > > -	struct tee_shm *shm =3D dmabuf->priv;
> > > > -	size_t size =3D vma->vm_end - vma->vm_start;
> > > > -
> > > > -	/* Refuse sharing shared memory provided by application */
> > > > -	if (shm->flags & TEE_SHM_USER_MAPPED)
> > > > -		return -EINVAL;
> > > > -
> > > > -	return remap_pfn_range(vma, vma->vm_start, shm->paddr >> PAGE_SHIFT,
> > > > -			       size, vma->vm_page_prot);
> > > > -}
> > > > -
> > > > -static const struct dma_buf_ops tee_shm_dma_buf_ops =3D {
> > > > -	.map_dma_buf =3D tee_shm_op_map_dma_buf,
> > > > -	.unmap_dma_buf =3D tee_shm_op_unmap_dma_buf,
> > > > -	.release =3D tee_shm_op_release,
> > > > -	.mmap =3D tee_shm_op_mmap,
> > > > -};
> > > > -
> > > >  struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, =
u32 flags)
> > > >  {
> > > >  	struct tee_device *teedev =3D ctx->teedev;
> > > > @@ -140,6 +90,7 @@ struct tee_shm *tee_shm_alloc(struct tee_context *=
ctx, size_t size, u32 flags)
> > > >  		goto err_dev_put;
> > > >  	}
> > > > =20
> > > > +	refcount_set(&shm->refcount, 1);
> > > >  	shm->flags =3D flags | TEE_SHM_POOL;
> > > >  	shm->ctx =3D ctx;
> > > >  	if (flags & TEE_SHM_DMA_BUF)
> > > > @@ -153,10 +104,7 @@ struct tee_shm *tee_shm_alloc(struct tee_context=
 *ctx, size_t size, u32 flags)
> > > >  		goto err_kfree;
> > > >  	}
> > > > =20
> > > > -
> > > >  	if (flags & TEE_SHM_DMA_BUF) {
> > > > -		DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> > > > -
> > > >  		mutex_lock(&teedev->mutex);
> > > >  		shm->id =3D idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
> > > >  		mutex_unlock(&teedev->mutex);
> > > > @@ -164,28 +112,11 @@ struct tee_shm *tee_shm_alloc(struct tee_contex=
t *ctx, size_t size, u32 flags)
> > > >  			ret =3D ERR_PTR(shm->id);
> > > >  			goto err_pool_free;
> > > >  		}
> > > > -
> > > > -		exp_info.ops =3D &tee_shm_dma_buf_ops;
> > > > -		exp_info.size =3D shm->size;
> > > > -		exp_info.flags =3D O_RDWR;
> > > > -		exp_info.priv =3D shm;
> > > > -
> > > > -		shm->dmabuf =3D dma_buf_export(&exp_info);
> > > > -		if (IS_ERR(shm->dmabuf)) {
> > > > -			ret =3D ERR_CAST(shm->dmabuf);
> > > > -			goto err_rem;
> > > > -		}
> > > >  	}
> > > > =20
> > > >  	teedev_ctx_get(ctx);
> > > > =20
> > > >  	return shm;
> > > > -err_rem:
> > > > -	if (flags & TEE_SHM_DMA_BUF) {
> > > > -		mutex_lock(&teedev->mutex);
> > > > -		idr_remove(&teedev->idr, shm->id);
> > > > -		mutex_unlock(&teedev->mutex);
> > > > -	}
> > > >  err_pool_free:
> > > >  	poolm->ops->free(poolm, shm);
> > > >  err_kfree:
> > > > @@ -246,6 +177,7 @@ struct tee_shm *tee_shm_register(struct tee_conte=
xt *ctx, unsigned long addr,
> > > >  		goto err;
> > > >  	}
> > > > =20
> > > > +	refcount_set(&shm->refcount, 1);
> > > >  	shm->flags =3D flags | TEE_SHM_REGISTER;
> > > >  	shm->ctx =3D ctx;
> > > >  	shm->id =3D -1;
> > > > @@ -306,22 +238,6 @@ struct tee_shm *tee_shm_register(struct tee_cont=
ext *ctx, unsigned long addr,
> > > >  		goto err;
> > > >  	}
> > > > =20
> > > > -	if (flags & TEE_SHM_DMA_BUF) {
> > > > -		DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> > > > -
> > > > -		exp_info.ops =3D &tee_shm_dma_buf_ops;
> > > > -		exp_info.size =3D shm->size;
> > > > -		exp_info.flags =3D O_RDWR;
> > > > -		exp_info.priv =3D shm;
> > > > -
> > > > -		shm->dmabuf =3D dma_buf_export(&exp_info);
> > > > -		if (IS_ERR(shm->dmabuf)) {
> > > > -			ret =3D ERR_CAST(shm->dmabuf);
> > > > -			teedev->desc->ops->shm_unregister(ctx, shm);
> > > > -			goto err;
> > > > -		}
> > > > -	}
> > > > -
> > > >  	return shm;
> > > >  err:
> > > >  	if (shm) {
> > > > @@ -339,6 +255,35 @@ struct tee_shm *tee_shm_register(struct tee_cont=
ext *ctx, unsigned long addr,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(tee_shm_register);
> > > > =20
> > > > +static int tee_shm_fop_release(struct inode *inode, struct file *fil=
p)
> > > > +{
> > > > +	tee_shm_put(filp->private_data);
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int tee_shm_fop_mmap(struct file *filp, struct vm_area_struct=
 *vma)
> > > > +{
> > > > +	struct tee_shm *shm =3D filp->private_data;
> > > > +	size_t size =3D vma->vm_end - vma->vm_start;
> > > > +
> > > > +	/* Refuse sharing shared memory provided by application */
> > > > +	if (shm->flags & TEE_SHM_USER_MAPPED)
> > > > +		return -EINVAL;
> > > > +
> > > > +	/* check for overflowing the buffer's size */
> > > > +	if (vma->vm_pgoff + vma_pages(vma) > shm->size >> PAGE_SHIFT)
> > > > +		return -EINVAL;
> > > > +
> > > > +	return remap_pfn_range(vma, vma->vm_start, shm->paddr >> PAGE_SHIFT,
> > > > +			       size, vma->vm_page_prot);
> > > > +}
> > > > +
> > > > +static const struct file_operations tee_shm_fops =3D {
> > > > +	.owner =3D THIS_MODULE,
> > > > +	.release =3D tee_shm_fop_release,
> > > > +	.mmap =3D tee_shm_fop_mmap,
> > > > +};
> > > > +
> > > >  /**
> > > >   * tee_shm_get_fd() - Increase reference count and return file descr=
iptor
> > > >   * @shm:	Shared memory handle
> > > > @@ -351,10 +296,11 @@ int tee_shm_get_fd(struct tee_shm *shm)
> > > >  	if (!(shm->flags & TEE_SHM_DMA_BUF))
> > > >  		return -EINVAL;
> > > > =20
> > > > -	get_dma_buf(shm->dmabuf);
> > > > -	fd =3D dma_buf_fd(shm->dmabuf, O_CLOEXEC);
> > > > +	/* matched by tee_shm_put() in tee_shm_op_release() */
> > > > +	refcount_inc(&shm->refcount);
> > > > +	fd =3D anon_inode_getfd("tee_shm", &tee_shm_fops, shm, O_RDWR);
> > > >  	if (fd < 0)
> > > > -		dma_buf_put(shm->dmabuf);
> > > > +		tee_shm_put(shm);
> > > >  	return fd;
> > > >  }
> > > > =20
> > > > @@ -364,17 +310,7 @@ int tee_shm_get_fd(struct tee_shm *shm)
> > > >   */
> > > >  void tee_shm_free(struct tee_shm *shm)
> > > >  {
> > > > -	/*
> > > > -	 * dma_buf_put() decreases the dmabuf reference counter and will
> > > > -	 * call tee_shm_release() when the last reference is gone.
> > > > -	 *
> > > > -	 * In the case of driver private memory we call tee_shm_release
> > > > -	 * directly instead as it doesn't have a reference counter.
> > > > -	 */
> > > > -	if (shm->flags & TEE_SHM_DMA_BUF)
> > > > -		dma_buf_put(shm->dmabuf);
> > > > -	else
> > > > -		tee_shm_release(shm);
> > > > +	tee_shm_put(shm);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(tee_shm_free);
> > > > =20
> > > > @@ -481,10 +417,15 @@ struct tee_shm *tee_shm_get_from_id(struct tee_=
context *ctx, int id)
> > > >  	teedev =3D ctx->teedev;
> > > >  	mutex_lock(&teedev->mutex);
> > > >  	shm =3D idr_find(&teedev->idr, id);
> > > > +	/*
> > > > +	 * If the tee_shm was found in the IDR it must have a refcount
> > > > +	 * larger than 0 due to the guarantee in tee_shm_put() below. So
> > > > +	 * it's safe to use refcount_inc().
> > > > +	 */
> > > >  	if (!shm || shm->ctx !=3D ctx)
> > > >  		shm =3D ERR_PTR(-EINVAL);
> > > > -	else if (shm->flags & TEE_SHM_DMA_BUF)
> > > > -		get_dma_buf(shm->dmabuf);
> > > > +	else
> > > > +		refcount_inc(&shm->refcount);
> > > >  	mutex_unlock(&teedev->mutex);
> > > >  	return shm;
> > > >  }
> > > > @@ -496,7 +437,24 @@ EXPORT_SYMBOL_GPL(tee_shm_get_from_id);
> > > >   */
> > > >  void tee_shm_put(struct tee_shm *shm)
> > > >  {
> > > > -	if (shm->flags & TEE_SHM_DMA_BUF)
> > > > -		dma_buf_put(shm->dmabuf);
> > > > +	struct tee_device *teedev =3D shm->ctx->teedev;
> > > > +	bool do_release =3D false;
> > > > +
> > > > +	mutex_lock(&teedev->mutex);
> > > > +	if (refcount_dec_and_test(&shm->refcount)) {
> > > > +		/*
> > > > +		 * refcount has reached 0, we must now remove it from the
> > > > +		 * IDR before releasing the mutex. This will guarantee that
> > > > +		 * the refcount_inc() in tee_shm_get_from_id() never starts
> > > > +		 * from 0.
> > > > +		 */
> > > > +		if (shm->flags & TEE_SHM_DMA_BUF)
> > > > +			idr_remove(&teedev->idr, shm->id);
> > > > +		do_release =3D true;
> > >=20
> > > As you are using a refcount in the "traditional" way, why not just use a
> > > kref instead?  That solves your "do_release" mess here.
> >=20
> > Yes, but it adds another problem. I don't want to hold the mutex when
> > calling tee_shm_release() so that would mean moving idr_remove() to
> > tee_shm_release() again and then use kref_get_unless_zero() in
> > tee_shm_get_from_id() instead.
>=20
> Why does the idr have anything to do with it here?  Once you are "done"
> with the object, remove the entry from the idr and that's it.  You
> should never have to mess with kref_get_unless_zero(), that's what locks
> are for.

I hope it becomes more clear below.

> > With this approach the tee_shm is removed from the IDR so it cannot be
> > seen any longer when the refcount is 0. I tried implementing it in both
> > ways before and in my opinion this turned out better.
>=20
> Really?  Something feels wrong here.  tee_release_device() should drop
> the reference from the idr structure as then you know that userspace can
> not grab any new references to it and should not need to look it up
> again from anything.  Then in your final kref_put() call, in the release
> callback for that, free the memory.

I assume you mean tee_shm_release().

As I understand it you're describing more or less how it worked before
this patch, the only significant difference I see is that it was the
release callback from the DMA-buf that called tee_shm_release() instead
of kref_put() as you suggest. With that we have a window where the
reference counter is 0, but the tee_shm is still in the IDR. If another
thread, perhaps malicious, calls tee_shm_get_from_id() it may be able to
grab the mutex before tee_shm_release(). If we just increase the
reference counter without checking if it's 0 to start with or not then
we're in trouble.

I see two ways around this, one is doing like in this patch and the
other is to check that the reference counter isn't 0 before increasing
it in tee_shm_get_from_id().

To me it seems preferable to avoid having invalid tee_shm's reachable
from the IDR.

>=20
> When is the idr being used by any other code path to look up the object
> that will be alive after your char dev's release call is made?

Once the tee_device is released then all the tee_shm's should have been
removed from the IDR. The tee_device will live as long as it has any
tee_shm's.

Thanks,
Jens

--===============2944394642773876071==--

