From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH RFC 3/3] tee: introduce orphan tee_shm and default context
Date: Fri, 22 Nov 2024 12:08:41 +1100
Message-ID: <3ab115bf-7ac6-452f-b760-0d631b6e75dd@quicinc.com>
In-Reply-To: <
 <CAHUa44Eoxa+NfRF-XCuV-O5uVgtC3UMT0utCLrUZ4rCBREp=pQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3946368475344689992=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3946368475344689992==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


On 11/21/2024 11:08 PM, Jens Wiklander wrote:

Hi Jens,

> Hi Amirreza,
>=20
> On Thu, Nov 21, 2024 at 2:37=E2=80=AFAM Amirreza Zarrabi
> <quic_azarrabi@quicinc.com> wrote:
>>
>> The default context has a lifespan similar to the tee_device.
>> It is used as a context for shared memory if the context to which the
>> shared memory belongs is released, making the tee_shm an orphan.
>> This allows the driver implementing shm_unregister to safely make
>> subsequent calls, such as to a supplicant if needed.
>>
>> It also enables users to free the shared memory while the driver is
>> blocked on unregister_tee_device safely.
>>
>> Preferably, this should be used for all driver internal uses, using
>> teedev_get_def_context rather than calling teedev_open.
>>
>> Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
>> ---
>>  drivers/tee/optee/core.c    |  2 +-
>>  drivers/tee/optee/ffa_abi.c |  2 +-
>>  drivers/tee/optee/smc_abi.c |  2 +-
>>  drivers/tee/tee_core.c      | 83 +++++++++++++++++++++++++++++-----------=
-----
>>  drivers/tee/tee_private.h   |  3 --
>>  drivers/tee/tee_shm.c       | 18 ++--------
>>  include/linux/tee_core.h    | 15 ++++++++
>>  include/linux/tee_drv.h     |  7 ----
>>  8 files changed, 73 insertions(+), 59 deletions(-)
>>
>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
>> index c75fddc83576..78d43d0c8014 100644
>> --- a/drivers/tee/optee/core.c
>> +++ b/drivers/tee/optee/core.c
>> @@ -173,7 +173,7 @@ void optee_remove_common(struct optee *optee)
>>
>>         optee_notif_uninit(optee);
>>         optee_shm_arg_cache_uninit(optee);
>> -       teedev_close_context(optee->ctx);
>> +
>>         /*
>>          * The two devices have to be unregistered before we can free the
>>          * other resources.
>> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
>> index f3af5666bb11..6ad94f0788ad 100644
>> --- a/drivers/tee/optee/ffa_abi.c
>> +++ b/drivers/tee/optee/ffa_abi.c
>> @@ -949,7 +949,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>>         optee_shm_arg_cache_init(optee, arg_cache_flags);
>>         mutex_init(&optee->rpmb_dev_mutex);
>>         ffa_dev_set_drvdata(ffa_dev, optee);
>> -       ctx =3D teedev_open(optee->teedev);
>> +       ctx =3D teedev_get_def_context(optee->teedev);
>>         if (IS_ERR(ctx)) {
>>                 rc =3D PTR_ERR(ctx);
>>                 goto err_rhashtable_free;
>> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
>> index e9456e3e74cc..c77a3e631d04 100644
>> --- a/drivers/tee/optee/smc_abi.c
>> +++ b/drivers/tee/optee/smc_abi.c
>> @@ -1722,7 +1722,7 @@ static int optee_probe(struct platform_device *pdev)
>>         mutex_init(&optee->rpmb_dev_mutex);
>>
>>         platform_set_drvdata(pdev, optee);
>> -       ctx =3D teedev_open(optee->teedev);
>> +       ctx =3D teedev_get_def_context(optee->teedev);
>>         if (IS_ERR(ctx)) {
>>                 rc =3D PTR_ERR(ctx);
>>                 goto err_supp_uninit;
>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>> index 93f3b330aec8..805e1336089d 100644
>> --- a/drivers/tee/tee_core.c
>> +++ b/drivers/tee/tee_core.c
>> @@ -57,7 +57,6 @@ struct tee_context *teedev_open(struct tee_device *teede=
v)
>>                 goto err;
>>         }
>>
>> -       kref_init(&ctx->refcount);
>>         ctx->teedev =3D teedev;
>>         INIT_LIST_HEAD(&ctx->list_shm);
>>         rc =3D teedev->desc->ops->open(ctx);
>> @@ -73,36 +72,43 @@ struct tee_context *teedev_open(struct tee_device *tee=
dev)
>>  }
>>  EXPORT_SYMBOL_GPL(teedev_open);
>>
>> -void teedev_ctx_get(struct tee_context *ctx)
>> +struct tee_context *teedev_get_def_context(struct tee_device *teedev)
>>  {
>> -       if (ctx->releasing)
>> -               return;
>> +       int rc;
>> +       struct tee_context *ctx =3D &teedev->def_ctx;
>>
>> -       kref_get(&ctx->refcount);
>> -}
>> +       ctx->teedev =3D teedev;
>> +       INIT_LIST_HEAD(&ctx->list_shm);
>> +       rc =3D teedev->desc->ops->open(ctx);
>> +       if (rc)
>> +               return ERR_PTR(rc);
>=20
> I think ctx->teedev and ctx->list_shm must always be initialized or
> &teedev->def_ctx can't be used in teedev_close_context().

True, but &teedev->def_ctx is never used in teedev_close_context().
The closing of the &teedev->def_ctx simply ignored. So once opened,
&teedev->def_ctx will always remain open until the tee_device is alive.=20

> We could initialize teedev->def_ctx on the first call to teedev_open()
> on that tee_device. We need a way to tell the
> teedev->desc->ops->open() to the backed driver that it's initializing
> the default context though, or optee_open() can't handle the
> tee-supplicant case properly.
>=20

That's a good point. This way, it is guaranteed that there is one def_ctx
per teedev. There should be a way to tell the open() callback that it is
a def_ctx, so it is not registered as a supplicant context.


> Should we allow this function to be called more than once for each teedev?

Yes, moving to teedev_open() will fix the issue.

> Do we need serialization in this function if it's called after the
> driver is probed?
>=20

True. I'll make sure there is no race.

>>
>> -static void teedev_ctx_release(struct kref *ref)
>> -{
>> -       struct tee_context *ctx =3D container_of(ref, struct tee_context,
>> -                                              refcount);
>> -       ctx->releasing =3D true;
>> -       ctx->teedev->desc->ops->release(ctx);
>> -       kfree(ctx);
>> +       return ctx;
>>  }
>> +EXPORT_SYMBOL_GPL(teedev_get_def_context);
>>
>> -void teedev_ctx_put(struct tee_context *ctx)
>> +void teedev_close_context(struct tee_context *ctx)
>>  {
>> -       if (ctx->releasing)
>> +       struct tee_device *teedev =3D ctx->teedev;
>> +       struct tee_shm *shm;
>> +
>> +       if (ctx =3D=3D &teedev->def_ctx)
>>                 return;
>>
>> -       kref_put(&ctx->refcount, teedev_ctx_release);
>> -}
>> +       teedev->desc->ops->release(ctx);
>>
>> -void teedev_close_context(struct tee_context *ctx)
>> -{
>> -       struct tee_device *teedev =3D ctx->teedev;
>> +       mutex_lock(&teedev->mutex);
>> +       list_for_each_entry(shm, &ctx->list_shm, link) {
>> +               /* Context released. However, shm still holding a teedev r=
eference.
>> +                * Replace shm->ctx with the default context so that tee_s=
hm_get_from_id()
>> +                * fails (i.e. it is not accessible from userspace) but sh=
m still
>> +                * holds a valid context for further clean up, e.g. shm_un=
register().
>> +                */
>=20
> /*
>  * Please format
>  * multiline comments
>  * like this. Please
>  * keep the lines at
>  * max 80 columns
>  * here and at other
>  * places in the patch-
>  * set.
>  */
>=20

Ack.

>> +               shm->ctx =3D &teedev->def_ctx;
>=20
> shm->ctx will always point to a valid context, even if it is the
> default context. It seems that we can always get hold of the correct
> teedev via shm->ctx->teedev. Do we need "tee: revert removal of
> redundant teedev in struct tee_shm"?
>=20

It was there in case we wanted to use NULL, but with def_ctx, it is not
necessary. I am withdrawing that commit. :).

> Shouldn't the shm be removed from the ctx->list_shm and be moved to
> teedev->def_ctx.list_shm?
>

Not really. If we put shm in the teedev->def_ctx.list_shm, by the time
we are closing the def_ctx, the list is guaranteed to be empty.

However, I understand it is cleaner and more consistent to do that rather
than making changes to tee_shm_put().

I'll do it.

>> +       }
>> +       mutex_unlock(&teedev->mutex);
>>
>> -       teedev_ctx_put(ctx);
>> +       kfree(ctx);
>>         tee_device_put(teedev);
>>  }
>>  EXPORT_SYMBOL_GPL(teedev_close_context);
>> @@ -946,6 +952,8 @@ struct tee_device *tee_device_alloc(const struct tee_d=
esc *teedesc,
>>
>>         teedev->desc =3D teedesc;
>>         teedev->pool =3D pool;
>> +       /* Only open default context when teedev_get_def_context() called.=
 */
>> +       teedev->def_ctx.teedev =3D NULL;
>>
>>         return teedev;
>>  err_devt:
>> @@ -1027,16 +1035,31 @@ EXPORT_SYMBOL_GPL(tee_device_register);
>>
>>  void tee_device_put(struct tee_device *teedev)
>>  {
>> -       mutex_lock(&teedev->mutex);
>> -       /* Shouldn't put in this state */
>> -       if (!WARN_ON(!teedev->desc)) {
>> -               teedev->num_users--;
>> -               if (!teedev->num_users) {
>> -                       teedev->desc =3D NULL;
>> -                       complete(&teedev->c_no_users);
>> -               }
>> +       const struct tee_desc *desc;
>> +
>> +       scoped_guard(mutex, &teedev->mutex) {
>> +               desc =3D teedev->desc;
>> +
>> +               /* Shouldn't put in this state */
>> +               if (WARN_ON(!desc))
>> +                       return;
>> +
>> +               /* If there is still users for teedev */
>> +               if (--teedev->num_users)
>=20
> Please do teedev->num_users-- first and then check. It makes the code
> easier to read.

Ack.

>=20
>> +                       return;
>> +
>> +               /* tee_device_unregister() has been called and there is no
>> +                * user in userspace or kernel, including orphan shm for t=
eedev.
>> +                * Set teedev->desc to NULL, so that teedev can not be reu=
sed.
>> +                */
>> +               teedev->desc =3D NULL;
>>         }
>> -       mutex_unlock(&teedev->mutex);
>> +
>> +       /* Release the default context */
>> +       desc->ops->release(&teedev->def_ctx);
>=20
> This should only be done if teedev->def_ctx has been initialized.
>=20

Ack.

> Cheers,
> Jens

Thank you very much for your comments :).
If you're okay with introducing def_ctx, I'll prepare a complete patchset
with all the details.=20

Best Regards,
Amir


>=20
>> +       teedev->def_ctx.teedev =3D NULL;
>> +
>> +       complete(&teedev->c_no_users);
>>  }
>>
>>  bool tee_device_get(struct tee_device *teedev)
>> diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
>> index 9bc50605227c..6c7bcc308958 100644
>> --- a/drivers/tee/tee_private.h
>> +++ b/drivers/tee/tee_private.h
>> @@ -17,9 +17,6 @@ int tee_shm_get_fd(struct tee_shm *shm);
>>  bool tee_device_get(struct tee_device *teedev);
>>  void tee_device_put(struct tee_device *teedev);
>>
>> -void teedev_ctx_get(struct tee_context *ctx);
>> -void teedev_ctx_put(struct tee_context *ctx);
>> -
>>  struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t si=
ze);
>>  struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>>                                           unsigned long addr, size_t lengt=
h);
>> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
>> index c0164c0f4a01..f07274291edf 100644
>> --- a/drivers/tee/tee_shm.c
>> +++ b/drivers/tee/tee_shm.c
>> @@ -59,8 +59,6 @@ static void tee_shm_release(struct tee_shm *shm)
>>                 release_registered_pages(shm);
>>         }
>>
>> -       teedev_ctx_put(shm->ctx);
>> -
>>         kfree(shm);
>>
>>         tee_device_put(teedev);
>> @@ -93,13 +91,6 @@ static struct tee_shm *shm_alloc_helper(struct tee_cont=
ext *ctx, size_t size,
>>         shm->flags =3D flags;
>>         shm->teedev =3D teedev;
>>         shm->id =3D id;
>> -
>> -       /*
>> -        * We're assigning this as it is needed if the shm is to be
>> -        * registered. If this function returns OK then the caller expected
>> -        * to call teedev_ctx_get() or clear shm->ctx in case it's not
>> -        * needed any longer.
>> -        */
>>         shm->ctx =3D ctx;
>>
>>         rc =3D teedev->pool->ops->alloc(teedev->pool, shm, size, align);
>> @@ -112,7 +103,6 @@ static struct tee_shm *shm_alloc_helper(struct tee_con=
text *ctx, size_t size,
>>         list_add_tail(&shm->link, &ctx->list_shm);
>>         mutex_unlock(&teedev->mutex);
>>
>> -       teedev_ctx_get(ctx);
>>         return shm;
>>  err_kfree:
>>         kfree(shm);
>> @@ -295,12 +285,10 @@ register_shm_helper(struct tee_context *ctx, struct =
iov_iter *iter, u32 flags,
>>                 goto err_dev_put;
>>         }
>>
>> -       teedev_ctx_get(ctx);
>> -
>>         shm =3D kzalloc(sizeof(*shm), GFP_KERNEL);
>>         if (!shm) {
>>                 ret =3D ERR_PTR(-ENOMEM);
>> -               goto err_ctx_put;
>> +               goto err_dev_put;
>>         }
>>
>>         refcount_set(&shm->refcount, 1);
>> @@ -313,7 +301,7 @@ register_shm_helper(struct tee_context *ctx, struct io=
v_iter *iter, u32 flags,
>>         num_pages =3D iov_iter_npages(iter, INT_MAX);
>>         if (!num_pages) {
>>                 ret =3D ERR_PTR(-ENOMEM);
>> -               goto err_ctx_put;
>> +               goto err_dev_put;
>>         }
>>
>>         shm->pages =3D kcalloc(num_pages, sizeof(*shm->pages), GFP_KERNEL);
>> @@ -361,8 +349,6 @@ register_shm_helper(struct tee_context *ctx, struct io=
v_iter *iter, u32 flags,
>>         kfree(shm->pages);
>>  err_free_shm:
>>         kfree(shm);
>> -err_ctx_put:
>> -       teedev_ctx_put(ctx);
>>  err_dev_put:
>>         tee_device_put(teedev);
>>         return ret;
>> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
>> index a38494d6b5f4..13393ddac530 100644
>> --- a/include/linux/tee_core.h
>> +++ b/include/linux/tee_core.h
>> @@ -44,6 +44,7 @@
>>   * @idr:       register of user space shared memory objects allocated or
>>   *             registered on this device
>>   * @pool:      shared memory pool
>> + * @def_ctx:   default context used if there is no context available, e.g=
. internal driver calls.
>>   */
>>  struct tee_device {
>>         char name[TEE_MAX_DEV_NAME_LEN];
>> @@ -60,6 +61,7 @@ struct tee_device {
>>
>>         struct idr idr;
>>         struct tee_shm_pool *pool;
>> +       struct tee_context def_ctx;
>>  };
>>
>>  /**
>> @@ -309,6 +311,19 @@ static inline bool tee_param_is_memref(struct tee_par=
am *param)
>>   */
>>  struct tee_context *teedev_open(struct tee_device *teedev);
>>
>> +/**
>> + * teedev_get_def_context() - Get default context for a struct tee_device
>> + * @teedev:    Device to open
>> + *
>> + * Unlike a context that returned from teedev_open(), the default context=
 is static
>> + * and available as long as @teedev has a user ''other then this context'=
'. This context
>> + * can be used for driver internal operation and clean up where a context=
 should be
>> + * available, while tee_device_unregister() is waiting for other users to=
 go away.
>> + *
>> + * @return a pointer to struct tee_context on success or an ERR_PTR on fa=
ilure.
>> + */
>> +struct tee_context *teedev_get_def_context(struct tee_device *teedev);
>> +
>>  /**
>>   * teedev_close_context() - closes a struct tee_context
>>   * @ctx:       The struct tee_context to close
>> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
>> index 1b57cddfecc8..9633e14ba484 100644
>> --- a/include/linux/tee_drv.h
>> +++ b/include/linux/tee_drv.h
>> @@ -7,7 +7,6 @@
>>  #define __TEE_DRV_H
>>
>>  #include <linux/device.h>
>> -#include <linux/kref.h>
>>  #include <linux/list.h>
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/tee.h>
>> @@ -25,10 +24,6 @@ struct tee_device;
>>   * @teedev:    pointer to this drivers struct tee_device
>>   * @list_shm:  List of shared memory object owned by this context
>>   * @data:      driver specific context data, managed by the driver
>> - * @refcount:  reference counter for this structure
>> - * @releasing:  flag that indicates if context is being released right no=
w.
>> - *             It is needed to break circular dependency on context during
>> - *              shared memory release.
>>   * @supp_nowait: flag that indicates that requests in this context should=
 not
>>   *              wait for tee-supplicant daemon to be started if not prese=
nt
>>   *              and just return with an error code. It is needed for requ=
ests
>> @@ -41,8 +36,6 @@ struct tee_context {
>>         struct tee_device *teedev;
>>         struct list_head list_shm;
>>         void *data;
>> -       struct kref refcount;
>> -       bool releasing;
>>         bool supp_nowait;
>>         bool cap_memref_null;
>>  };
>>
>> --
>> 2.34.1
>>

--===============3946368475344689992==--

