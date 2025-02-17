From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 2/8] tee: add close_context to TEE driver operation
Date: Tue, 18 Feb 2025 10:36:27 +1100
Message-ID: <6594f69e-f4ba-4d2b-a3d6-7eb5c8f95ac4@quicinc.com>
In-Reply-To: <20250217093546.GA2637163@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5953377378530920969=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5953377378530920969==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 2/17/2025 8:35 PM, Jens Wiklander wrote:
> Hi,
>=20
> On Sun, Feb 02, 2025 at 06:43:30PM -0800, Amirreza Zarrabi wrote:
>> The tee_context can be used to manage TEE user resources, including
>> those allocated by the driver for the TEE on behalf of the user.
>> The release() callback is invoked only when all resources, such as
>> tee_shm, are released and there are no references to the tee_context.
>>
>> When a user closes the device file, the driver should notify the
>> TEE to release any resources it may hold and drop the context
>> references. To achieve this, a close_context() callback is
>> introduced to initiate resource release in the TEE driver when
>> the device file is closed.
>>
>> Relocate teedev_ctx_get, teedev_ctx_put, tee_device_get, and
>> tee_device_get functions to tee_drv.h to make them accessible
>> outside the TEE subsystem.
>>
>> Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
>> ---
>>  drivers/tee/tee_core.c    |  7 +++++++
>>  drivers/tee/tee_private.h |  6 ------
>>  include/linux/tee_core.h  | 11 +++++++++--
>>  include/linux/tee_drv.h   |  6 ++++++
>>  4 files changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>> index 24edce4cdbaa..721522fe5c63 100644
>> --- a/drivers/tee/tee_core.c
>> +++ b/drivers/tee/tee_core.c
>> @@ -79,6 +79,7 @@ void teedev_ctx_get(struct tee_context *ctx)
>> =20
>>  	kref_get(&ctx->refcount);
>>  }
>> +EXPORT_SYMBOL_GPL(teedev_ctx_get);
>> =20
>>  static void teedev_ctx_release(struct kref *ref)
>>  {
>> @@ -96,11 +97,15 @@ void teedev_ctx_put(struct tee_context *ctx)
>> =20
>>  	kref_put(&ctx->refcount, teedev_ctx_release);
>>  }
>> +EXPORT_SYMBOL_GPL(teedev_ctx_put);
>> =20
>>  void teedev_close_context(struct tee_context *ctx)
>>  {
>>  	struct tee_device *teedev =3D ctx->teedev;
>> =20
>> +	if (teedev->desc->ops->close_context)
>> +		teedev->desc->ops->close_context(ctx);
>> +
>>  	teedev_ctx_put(ctx);
>>  	tee_device_put(teedev);
>>  }
>> @@ -1037,6 +1042,7 @@ void tee_device_put(struct tee_device *teedev)
>>  	}
>>  	mutex_unlock(&teedev->mutex);
>>  }
>> +EXPORT_SYMBOL_GPL(tee_device_put);
>> =20
>>  bool tee_device_get(struct tee_device *teedev)
>>  {
>> @@ -1049,6 +1055,7 @@ bool tee_device_get(struct tee_device *teedev)
>>  	mutex_unlock(&teedev->mutex);
>>  	return true;
>>  }
>> +EXPORT_SYMBOL_GPL(tee_device_get);
>> =20
>>  /**
>>   * tee_device_unregister() - Removes a TEE device
>> diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
>> index 9bc50605227c..d3f40a03de36 100644
>> --- a/drivers/tee/tee_private.h
>> +++ b/drivers/tee/tee_private.h
>> @@ -14,12 +14,6 @@
>> =20
>>  int tee_shm_get_fd(struct tee_shm *shm);
>> =20
>> -bool tee_device_get(struct tee_device *teedev);
>> -void tee_device_put(struct tee_device *teedev);
>> -
>> -void teedev_ctx_get(struct tee_context *ctx);
>> -void teedev_ctx_put(struct tee_context *ctx);
>> -
>>  struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t si=
ze);
>>  struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>>  					  unsigned long addr, size_t length);
>> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
>> index a38494d6b5f4..8a4c9e30b652 100644
>> --- a/include/linux/tee_core.h
>> +++ b/include/linux/tee_core.h
>> @@ -65,8 +65,9 @@ struct tee_device {
>>  /**
>>   * struct tee_driver_ops - driver operations vtable
>>   * @get_version:	returns version of driver
>> - * @open:		called when the device file is opened
>> - * @release:		release this open file
>> + * @open:		called for a context when the device file is opened
>> + * @close_context:	called when the device file is closed
>> + * @release:		called to release the context
>>   * @open_session:	open a new session
>>   * @close_session:	close a session
>>   * @system_session:	declare session as a system session
>> @@ -76,11 +77,17 @@ struct tee_device {
>>   * @supp_send:		called for supplicant to send a response
>>   * @shm_register:	register shared memory buffer in TEE
>>   * @shm_unregister:	unregister shared memory buffer in TEE
>> + *
>> + * The context given to @open might last longer than the device file if i=
t is
>> + * tied to other resources in the TEE driver. @close_context is called wh=
en the
>> + * client closes the device file, even if there are existing references t=
o the
>> + * context. The TEE driver can use @close_context to start cleaning up.
>>   */
>>  struct tee_driver_ops {
>>  	void (*get_version)(struct tee_device *teedev,
>>  			    struct tee_ioctl_version_data *vers);
>>  	int (*open)(struct tee_context *ctx);
>> +	void (*close_context)(struct tee_context *ctx);
>>  	void (*release)(struct tee_context *ctx);
>>  	int (*open_session)(struct tee_context *ctx,
>>  			    struct tee_ioctl_open_session_arg *arg,
>> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
>> index a54c203000ed..d5f0c70ac95c 100644
>> --- a/include/linux/tee_drv.h
>> +++ b/include/linux/tee_drv.h
>> @@ -96,6 +96,12 @@ struct tee_param {
>>  	} u;
>>  };
>> =20
>> +bool tee_device_get(struct tee_device *teedev);
>> +void tee_device_put(struct tee_device *teedev);
>> +
>> +void teedev_ctx_get(struct tee_context *ctx);
>> +void teedev_ctx_put(struct tee_context *ctx);
>> +
>=20
> Now that these functions are available to all the backend drivers,
> please add some documentation for them so it more clear how they are
> supposed to be used.
>=20
> Thanks,
> Jens

Ack.

>=20
>>  /**
>>   * tee_shm_alloc_kernel_buf() - Allocate kernel shared memory for a
>>   *                              particular TEE client driver
>>
>> --=20
>> 2.34.1
>>


--===============5953377378530920969==--

