From: Jerome Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 1/5] tee: add sec_world_id to struct tee_shm
Date: Wed, 06 Oct 2021 10:36:22 +0200
Message-ID: <2af3eda2-2ceb-4812-a813-ae3dff02cdac@forissier.org>
In-Reply-To: <20211006070902.2531311-2-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3347336182192406357=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3347336182192406357==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 10/6/21 9:08 AM, Jens Wiklander wrote:
> Adds sec_world_id to struct tee_shm which describes a shared memory
> object. sec_world_id can be used by a driver to store an id assigned by
> secure world.
>=20
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  include/linux/tee_drv.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 3ebfea0781f1..a1f03461369b 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -197,7 +197,11 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 con=
nection_method,
>   * @num_pages:	number of locked pages
>   * @dmabuf:	dmabuf used to for exporting to user space
>   * @flags:	defined by TEE_SHM_* in tee_drv.h
> - * @id:		unique id of a shared memory object on this device
> + * @id:		unique id of a shared memory object on this device, shared
> + *		with user space
> + * @sec_world_id:
> + *		secure world assigned id of this shared memory object, not
> + *		used by all drivers
>   *
>   * This pool is only supposed to be accessed directly from the TEE
>   * subsystem and from drivers that implements their own shm pool manager.
> @@ -213,6 +217,7 @@ struct tee_shm {
>  	struct dma_buf *dmabuf;
>  	u32 flags;
>  	int id;
> +	u64 sec_world_id;

Wouldn't it make more sense to have this outside struct tee_shm in a
driver-specific struct? (which could always be obtained from a struct
tee_shm * using container_of() for example).

>  };
> =20
>  /**
>=20

--===============3347336182192406357==--

