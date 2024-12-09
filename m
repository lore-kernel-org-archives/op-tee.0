From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 02/10] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF
Date: Mon, 09 Dec 2024 16:46:11 +0100
Message-ID: 
 <CAHUa44GxY=nZP9O6XpO-nRKJ_wUnK66h-QEnFPJ9myFGydBZYw@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3C20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-?=
 =?utf-8?q?2-f502ef01e016=40quicinc=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7225550255868740979=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7225550255868740979==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Amirreza,

On Tue, Dec 3, 2024 at 5:20=E2=80=AFAM Amirreza Zarrabi
<quic_azarrabi@quicinc.com> wrote:
>
> For drivers that can transfer data to the TEE without needing shared
> memory from client, it is necessary to receive the user address
> directly, bypassing any processing by the TEE subsystem. Introduce
> TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INPUT/OUTPUT/INOUT to represent
> userspace buffers.

Internally you allocate a bounce buffer from the pool of shared memory
and copy the content of the user space buffer into that.
Wouldn't it be fair to replace "without needing shared memory" with
"without using shared memory"?

>
> Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
> ---
>  drivers/tee/tee_core.c   | 26 ++++++++++++++++++++++++++
>  include/linux/tee_drv.h  |  6 ++++++
>  include/uapi/linux/tee.h | 22 ++++++++++++++++------
>  3 files changed, 48 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 24edce4cdbaa..942ff5b359b2 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -381,6 +381,16 @@ static int params_from_user(struct tee_context *ctx, s=
truct tee_param *params,
>                         params[n].u.value.b =3D ip.b;
>                         params[n].u.value.c =3D ip.c;
>                         break;
> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INPUT:
> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_OUTPUT:
> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INOUT:
> +                       params[n].u.membuf.uaddr =3D u64_to_user_ptr(ip.a);
> +                       params[n].u.membuf.size =3D ip.b;
> +
> +                       if (!access_ok(params[n].u.membuf.uaddr, params[n].=
u.membuf.size))
> +                               return -EFAULT;
> +
> +                       break;
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
> @@ -449,6 +459,11 @@ static int params_to_user(struct tee_ioctl_param __use=
r *uparams,
>                             put_user(p->u.value.c, &up->c))
>                                 return -EFAULT;
>                         break;
> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_OUTPUT:
> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INOUT:
> +                       if (put_user((u64)p->u.membuf.size, &up->b))
> +                               return -EFAULT;
> +                       break;
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
>                         if (put_user((u64)p->u.memref.size, &up->b))
> @@ -649,6 +664,12 @@ static int params_to_supp(struct tee_context *ctx,
>                         ip.b =3D p->u.value.b;
>                         ip.c =3D p->u.value.c;
>                         break;
> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INPUT:
> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INOUT:
> +                       ip.a =3D (u64)p->u.membuf.uaddr;
> +                       ip.b =3D p->u.membuf.size;
> +                       ip.c =3D 0;
> +                       break;
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
> @@ -751,6 +772,11 @@ static int params_from_supp(struct tee_param *params, =
size_t num_params,
>                         p->u.value.b =3D ip.b;
>                         p->u.value.c =3D ip.c;
>                         break;
> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_OUTPUT:
> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INOUT:
> +                       p->u.membuf.uaddr =3D u64_to_user_ptr(ip.a);
> +                       p->u.membuf.size =3D ip.b;
> +                       break;
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
>                         /*
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index a54c203000ed..b66e611fece4 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -82,6 +82,11 @@ struct tee_param_memref {
>         struct tee_shm *shm;
>  };
>
> +struct tee_param_membuf {

I would prefer tee_param_ubuf to better describe what it is.

> +       void * __user uaddr;
> +       size_t size;
> +};
> +
>  struct tee_param_value {
>         u64 a;
>         u64 b;
> @@ -92,6 +97,7 @@ struct tee_param {
>         u64 attr;
>         union {
>                 struct tee_param_memref memref;
> +               struct tee_param_membuf membuf;
>                 struct tee_param_value value;
>         } u;
>  };
> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
> index d0430bee8292..fae68386968a 100644
> --- a/include/uapi/linux/tee.h
> +++ b/include/uapi/linux/tee.h
> @@ -151,6 +151,13 @@ struct tee_ioctl_buf_data {
>  #define TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT        6
>  #define TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT 7       /* input and output=
 */
>
> +/*
> + * These defines memory buffer parameters.

user space buffer

> + */
> +#define TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INPUT 8
> +#define TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_OUTPUT        9
> +#define TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INOUT 10      /* input and output=
 */

TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_*

> +
>  /*
>   * Mask for the type part of the attribute, leaves room for more types
>   */
> @@ -186,14 +193,17 @@ struct tee_ioctl_buf_data {
>  /**
>   * struct tee_ioctl_param - parameter
>   * @attr: attributes
> - * @a: if a memref, offset into the shared memory object, else a value par=
ameter
> - * @b: if a memref, size of the buffer, else a value parameter
> + * @a: if a memref, offset into the shared memory object,
> + *     else if a membuf, address into the user buffer,
> + *     else a value parameter
> + * @b: if a memref or membuf, size of the buffer, else a value parameter
>   * @c: if a memref, shared memory identifier, else a value parameter
>   *
> - * @attr & TEE_PARAM_ATTR_TYPE_MASK indicates if memref or value is used in
> - * the union. TEE_PARAM_ATTR_TYPE_VALUE_* indicates value and
> - * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref. TEE_PARAM_ATTR_TYPE_NONE
> - * indicates that none of the members are used.
> + * @attr & TEE_PARAM_ATTR_TYPE_MASK indicates if memref, membuf, or value =
is
> + * used in the union. TEE_PARAM_ATTR_TYPE_VALUE_* indicates value,
> + * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref, and TEE_PARAM_ATTR_TYPE_=
MEMBUF_*
> + * indicates membuf. TEE_PARAM_ATTR_TYPE_NONE indicates that none of the m=
embers
> + * are used.
>   *
>   * Shared memory is allocated with TEE_IOC_SHM_ALLOC which returns an
>   * identifier representing the shared memory object. A memref can reference

Please update the comment above with UBUF and ubuf as needed.

Cheers,
Jens

>
> --
> 2.34.1
>

--===============7225550255868740979==--

