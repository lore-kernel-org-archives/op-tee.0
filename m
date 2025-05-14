From: Sumit Garg <sumit.garg@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 02/11] tee: add close_context to TEE driver operation
Date: Wed, 14 May 2025 19:16:02 +0530
Message-ID: <aCSemprr1GzDoYLH@sumit-X1>
In-Reply-To: <=?utf-8?q?=3C20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-?=
 =?utf-8?q?2-6a143640a6cb=40oss=2Equalcomm=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8283687263177223431=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8283687263177223431==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 11:06:23PM -0700, Amirreza Zarrabi wrote:
> The tee_context can be used to manage TEE user resources, including
> those allocated by the driver for the TEE on behalf of the user.
> The release() callback is invoked only when all resources, such as
> tee_shm, are released and there are no references to the tee_context.
>=20
> When a user closes the device file, the driver should notify the
> TEE to release any resources it may hold and drop the context
> references. To achieve this, a close_context() callback is
> introduced to initiate resource release in the TEE driver when
> the device file is closed.
>=20
> Relocate teedev_ctx_get, teedev_ctx_put, tee_device_get, and
> tee_device_get functions to tee_core.h to make them accessible
> outside the TEE subsystem.
>=20
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
>  drivers/tee/tee_core.c    |  7 +++++++
>  drivers/tee/tee_private.h |  6 ------
>  include/linux/tee_core.h  | 50 +++++++++++++++++++++++++++++++++++++++++++=
++--
>  3 files changed, 55 insertions(+), 8 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>=20
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 24edce4cdbaa..721522fe5c63 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -79,6 +79,7 @@ void teedev_ctx_get(struct tee_context *ctx)
> =20
>  	kref_get(&ctx->refcount);
>  }
> +EXPORT_SYMBOL_GPL(teedev_ctx_get);
> =20
>  static void teedev_ctx_release(struct kref *ref)
>  {
> @@ -96,11 +97,15 @@ void teedev_ctx_put(struct tee_context *ctx)
> =20
>  	kref_put(&ctx->refcount, teedev_ctx_release);
>  }
> +EXPORT_SYMBOL_GPL(teedev_ctx_put);
> =20
>  void teedev_close_context(struct tee_context *ctx)
>  {
>  	struct tee_device *teedev =3D ctx->teedev;
> =20
> +	if (teedev->desc->ops->close_context)
> +		teedev->desc->ops->close_context(ctx);
> +
>  	teedev_ctx_put(ctx);
>  	tee_device_put(teedev);
>  }
> @@ -1037,6 +1042,7 @@ void tee_device_put(struct tee_device *teedev)
>  	}
>  	mutex_unlock(&teedev->mutex);
>  }
> +EXPORT_SYMBOL_GPL(tee_device_put);
> =20
>  bool tee_device_get(struct tee_device *teedev)
>  {
> @@ -1049,6 +1055,7 @@ bool tee_device_get(struct tee_device *teedev)
>  	mutex_unlock(&teedev->mutex);
>  	return true;
>  }
> +EXPORT_SYMBOL_GPL(tee_device_get);
> =20
>  /**
>   * tee_device_unregister() - Removes a TEE device
> diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
> index 9bc50605227c..d3f40a03de36 100644
> --- a/drivers/tee/tee_private.h
> +++ b/drivers/tee/tee_private.h
> @@ -14,12 +14,6 @@
> =20
>  int tee_shm_get_fd(struct tee_shm *shm);
> =20
> -bool tee_device_get(struct tee_device *teedev);
> -void tee_device_put(struct tee_device *teedev);
> -
> -void teedev_ctx_get(struct tee_context *ctx);
> -void teedev_ctx_put(struct tee_context *ctx);
> -
>  struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t siz=
e);
>  struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>  					  unsigned long addr, size_t length);
> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> index a38494d6b5f4..284ca6b3e03a 100644
> --- a/include/linux/tee_core.h
> +++ b/include/linux/tee_core.h
> @@ -65,8 +65,9 @@ struct tee_device {
>  /**
>   * struct tee_driver_ops - driver operations vtable
>   * @get_version:	returns version of driver
> - * @open:		called when the device file is opened
> - * @release:		release this open file
> + * @open:		called for a context when the device file is opened
> + * @close_context:	called when the device file is closed
> + * @release:		called to release the context
>   * @open_session:	open a new session
>   * @close_session:	close a session
>   * @system_session:	declare session as a system session
> @@ -76,11 +77,17 @@ struct tee_device {
>   * @supp_send:		called for supplicant to send a response
>   * @shm_register:	register shared memory buffer in TEE
>   * @shm_unregister:	unregister shared memory buffer in TEE
> + *
> + * The context given to @open might last longer than the device file if it=
 is
> + * tied to other resources in the TEE driver. @close_context is called whe=
n the
> + * client closes the device file, even if there are existing references to=
 the
> + * context. The TEE driver can use @close_context to start cleaning up.
>   */
>  struct tee_driver_ops {
>  	void (*get_version)(struct tee_device *teedev,
>  			    struct tee_ioctl_version_data *vers);
>  	int (*open)(struct tee_context *ctx);
> +	void (*close_context)(struct tee_context *ctx);
>  	void (*release)(struct tee_context *ctx);
>  	int (*open_session)(struct tee_context *ctx,
>  			    struct tee_ioctl_open_session_arg *arg,
> @@ -154,6 +161,24 @@ int tee_device_register(struct tee_device *teedev);
>   */
>  void tee_device_unregister(struct tee_device *teedev);
> =20
> +/**
> + * tee_device_get() - Increment the user count for a tee_device
> + * @teedev: Pointer to the tee_device
> + *
> + * If tee_device_unregister() has been called and the final user of @teedev
> + * has already released the device, this function will fail to prevent new=
 users
> + * from accessing the device during the unregistration process.
> + *
> + * Returns: true if @teedev remains valid, otherwise false
> + */
> +bool tee_device_get(struct tee_device *teedev);
> +
> +/**
> + * tee_device_put() - Decrease the user count for a tee_device
> + * @teedev: pointer to the tee_device
> + */
> +void tee_device_put(struct tee_device *teedev);
> +
>  /**
>   * tee_device_set_dev_groups() - Set device attribute groups
>   * @teedev:	Device to register
> @@ -315,4 +340,25 @@ struct tee_context *teedev_open(struct tee_device *tee=
dev);
>   */
>  void teedev_close_context(struct tee_context *ctx);
> =20
> +/**
> + * teedev_ctx_get() - Increment the reference count of a context
> + * @ctx: Pointer to the context
> + *
> + * This function increases the refcount of the context, which is tied to
> + * resources shared by the same tee_device. During the unregistration proc=
ess,
> + * the context may remain valid even after tee_device_unregister() has ret=
urned.
> + *
> + * Users should ensure that the context's refcount is properly decreased b=
efore
> + * calling tee_device_put(), typically within the context's release() func=
tion.
> + * Alternatively, users can call tee_device_get() and teedev_ctx_get() tog=
ether
> + * and release them simultaneously (see shm_alloc_helper()).
> + */
> +void teedev_ctx_get(struct tee_context *ctx);
> +
> +/**
> + * teedev_ctx_put() - Decrease reference count on a context
> + * @ctx: pointer to the context
> + */
> +void teedev_ctx_put(struct tee_context *ctx);
> +
>  #endif /*__TEE_CORE_H*/
>=20
> --=20
> 2.34.1
>=20

--===============8283687263177223431==--

