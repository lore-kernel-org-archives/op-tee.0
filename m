From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 1/5] tee: add sec_world_id to struct tee_shm
Date: Wed, 28 Jul 2021 14:11:37 +0530
Message-ID: 
 <CAFA6WYPW3XQiXJSxsj_HDXZ_JPEx58hOZiZ1Yctn-r7FG6hUpg@mail.gmail.com>
In-Reply-To: <20210722121757.1944658-2-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1649093142721422338=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1649093142721422338==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Jul 2021 at 17:48, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Adds sec_world_id to struct tee_shm which describes a shared memory
> object. sec_world_id can be used by a driver to store an id assigned by
> secure world.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  include/linux/tee_drv.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 54269e47ac9a..1a29f0e66e13 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -196,7 +196,11 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 con=
nection_method,
>   * @num_pages: number of locked pages
>   * @dmabuf:    dmabuf used to for exporting to user space
>   * @flags:     defined by TEE_SHM_* in tee_drv.h
> - * @id:                unique id of a shared memory object on this device
> + * @id:                unique id of a shared memory object on this device,=
 shared
> + *             with user space
> + * @sec_world_id:
> + *             secure world assigned id of this shared memory object, not
> + *             used by all drivers
>   *
>   * This pool is only supposed to be accessed directly from the TEE
>   * subsystem and from drivers that implements their own shm pool manager.
> @@ -212,6 +216,7 @@ struct tee_shm {
>         struct dma_buf *dmabuf;
>         u32 flags;
>         int id;
> +       u64 sec_world_id;
>  };
>
>  /**
> --
> 2.31.1
>

--===============1649093142721422338==--

