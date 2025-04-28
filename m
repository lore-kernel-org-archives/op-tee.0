From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 03/11] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
Date: Mon, 28 Apr 2025 14:37:37 +1000
Message-ID: <82bdb9e3-dee1-4705-b6a7-2b163f8bdcfa@oss.qualcomm.com>
In-Reply-To: <aAZFhlLv9GzHqUZc@sumit-X1>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8013986470525325924=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8013986470525325924==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

On 4/21/2025 11:17 PM, Sumit Garg wrote:
> On Wed, Apr 09, 2025 at 05:20:08PM +1000, Amirreza Zarrabi wrote:
>>
>>
>> On 4/9/2025 4:41 PM, Jens Wiklander wrote:
>>> Hi Amirreza,
>>>
>>> On Wed, Apr 9, 2025 at 2:28=E2=80=AFAM Amirreza Zarrabi
>>> <amirreza.zarrabi@oss.qualcomm.com> wrote:
>>>>
>>>> Hi jens,
>>>>
>>>> On 4/8/2025 10:19 PM, Jens Wiklander wrote:
>>>>
>>>> Hi Amirreza,
>>>>
>>>> On Fri, Mar 28, 2025 at 3:48=E2=80=AFAM Amirreza Zarrabi
>>>> <amirreza.zarrabi@oss.qualcomm.com> wrote:
>>>>
>>>> For drivers that can transfer data to the TEE without using shared
>>>> memory from client, it is necessary to receive the user address
>>>> directly, bypassing any processing by the TEE subsystem. Introduce
>>>> TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT/OUTPUT/INOUT to represent
>>>> userspace buffers.
>>>>
>>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>>> ---
>>>>  drivers/tee/tee_core.c   | 33 +++++++++++++++++++++++++++++++++
>>>>  include/linux/tee_drv.h  |  6 ++++++
>>>>  include/uapi/linux/tee.h | 22 ++++++++++++++++------
>>>>  3 files changed, 55 insertions(+), 6 deletions(-)
>>>>
>>>> Is this patch needed now that the QCOMTEE driver supports shared
>>>> memory? I prefer keeping changes to the ABI to a minimum.
>>>>
>>>> Cheers,
>>>> Jens
>>>>
>>>> Unfortunately, this is still required. QTEE supports two types of data t=
ransfer:
>>>> (1) using UBUF and (2) memory objects. Even with memory object support, =
some APIs still
>>>> expect to receive data using UBUF. For instance, to load a TA, QTEE offe=
rs two interfaces:
>>>> one where the TA binary is in UBUF and another where the TA binary is in=
 a memory object.
>>>
>>> Is this a limitation in the QTEE backend driver or on the secure side?
>>> Can it be fixed? I don't ask for changes in the ABI to the secure
>>> world since I assume you haven't made such changes while this patch
>>> set has evolved.
>>>
>>> Cheers,
>>> Jens
>>
>> The secure-side ABI supports passing data using memcpy to the same
>> buffer that contains the message for QTEE, rather than using a memory
>> object. Some services tend to use this approach for small data instead
>> of allocating a memory object. I have no choice but to expose this support.
>=20
> Okay, I can see how QTEE supports embedding user buffers in fixed size
> shared memory buffers allocated by the driver with maximum size limits.
>=20
> OP-TEE also have support for temporary shared memory where the user
> space client directly passes the buffer to share with OP-TEE. Then the
> libteec [1] handles the underneath copy to and from the shared memory
> allocation automatically.
>=20
> So is there a limitation for QCOMTEE user space library [2] to do the
> same? This way we will be able to retain the user-space ABI as well as
> simplicify the kernel driver.
>=20
> [1] https://github.com/OP-TEE/optee_client/blob/master/libteec/src/tee_clie=
nt_api.c#L365
> [2] https://github.com/quic/quic-teec
>=20
> -Sumit
>=20

Unfortunately, I do not have control over the TA's API. If a TA expects
to receive data in the embedded buffer, then I cannot use a memory
object. To maintain the ABI and avoid the UBUF, I need two copies:
(1) the user data passed to the library is copied to memory allocated
using TEE_ALLOC, (2) in the driver, the data is copied from the tee_shm to
the embedded buffer as expected by QTEE.

- Amir

>>
>> Throughout the patchset, I have not made any change to the ABI but
>> tried to provide support for the memory object in a separate,
>> independent commit, distinct from the UBUF.
>>
>> Best regards,
>> Amir
>>
>>>
>>>>
>>>> Best Regards,
>>>> Amir
>>>>
>>>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>>>> index 22cc7d624b0c..bc862a11d437 100644
>>>> --- a/drivers/tee/tee_core.c
>>>> +++ b/drivers/tee/tee_core.c
>>>> @@ -404,6 +404,17 @@ static int params_from_user(struct tee_context *ctx=
, struct tee_param *params,
>>>>                         params[n].u.value.b =3D ip.b;
>>>>                         params[n].u.value.c =3D ip.c;
>>>>                         break;
>>>> +               case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
>>>> +               case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
>>>> +               case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
>>>> +                       params[n].u.ubuf.uaddr =3D u64_to_user_ptr(ip.a);
>>>> +                       params[n].u.ubuf.size =3D ip.b;
>>>> +
>>>> +                       if (!access_ok(params[n].u.ubuf.uaddr,
>>>> +                                      params[n].u.ubuf.size))
>>>> +                               return -EFAULT;
>>>> +
>>>> +                       break;
>>>>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
>>>>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>>>>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
>>>> @@ -472,6 +483,11 @@ static int params_to_user(struct tee_ioctl_param __=
user *uparams,
>>>>                             put_user(p->u.value.c, &up->c))
>>>>                                 return -EFAULT;
>>>>                         break;
>>>> +               case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
>>>> +               case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
>>>> +                       if (put_user((u64)p->u.ubuf.size, &up->b))
>>>> +                               return -EFAULT;
>>>> +                       break;
>>>>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>>>>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
>>>>                         if (put_user((u64)p->u.memref.size, &up->b))
>>>> @@ -672,6 +688,13 @@ static int params_to_supp(struct tee_context *ctx,
>>>>                         ip.b =3D p->u.value.b;
>>>>                         ip.c =3D p->u.value.c;
>>>>                         break;
>>>> +               case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
>>>> +               case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
>>>> +               case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
>>>> +                       ip.a =3D (u64)p->u.ubuf.uaddr;
>>>> +                       ip.b =3D p->u.ubuf.size;
>>>> +                       ip.c =3D 0;
>>>> +                       break;
>>>>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
>>>>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>>>>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
>>>> @@ -774,6 +797,16 @@ static int params_from_supp(struct tee_param *param=
s, size_t num_params,
>>>>                         p->u.value.b =3D ip.b;
>>>>                         p->u.value.c =3D ip.c;
>>>>                         break;
>>>> +               case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
>>>> +               case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
>>>> +                       p->u.ubuf.uaddr =3D u64_to_user_ptr(ip.a);
>>>> +                       p->u.ubuf.size =3D ip.b;
>>>> +
>>>> +                       if (!access_ok(params[n].u.ubuf.uaddr,
>>>> +                                      params[n].u.ubuf.size))
>>>> +                               return -EFAULT;
>>>> +
>>>> +                       break;
>>>>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>>>>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
>>>>                         /*
>>>> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
>>>> index ce23fd42c5d4..d773f91c6bdd 100644
>>>> --- a/include/linux/tee_drv.h
>>>> +++ b/include/linux/tee_drv.h
>>>> @@ -82,6 +82,11 @@ struct tee_param_memref {
>>>>         struct tee_shm *shm;
>>>>  };
>>>>
>>>> +struct tee_param_ubuf {
>>>> +       void * __user uaddr;
>>>> +       size_t size;
>>>> +};
>>>> +
>>>>  struct tee_param_value {
>>>>         u64 a;
>>>>         u64 b;
>>>> @@ -92,6 +97,7 @@ struct tee_param {
>>>>         u64 attr;
>>>>         union {
>>>>                 struct tee_param_memref memref;
>>>> +               struct tee_param_ubuf ubuf;
>>>>                 struct tee_param_value value;
>>>>         } u;
>>>>  };
>>>> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
>>>> index d0430bee8292..3e9b1ec5dfde 100644
>>>> --- a/include/uapi/linux/tee.h
>>>> +++ b/include/uapi/linux/tee.h
>>>> @@ -151,6 +151,13 @@ struct tee_ioctl_buf_data {
>>>>  #define TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT        6
>>>>  #define TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT 7       /* input and out=
put */
>>>>
>>>> +/*
>>>> + * These defines userspace buffer parameters.
>>>> + */
>>>> +#define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT   8
>>>> +#define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT  9
>>>> +#define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT   10      /* input and out=
put */
>>>> +
>>>>  /*
>>>>   * Mask for the type part of the attribute, leaves room for more types
>>>>   */
>>>> @@ -186,14 +193,17 @@ struct tee_ioctl_buf_data {
>>>>  /**
>>>>   * struct tee_ioctl_param - parameter
>>>>   * @attr: attributes
>>>> - * @a: if a memref, offset into the shared memory object, else a value =
parameter
>>>> - * @b: if a memref, size of the buffer, else a value parameter
>>>> + * @a: if a memref, offset into the shared memory object,
>>>> + *     else if a ubuf, address of the user buffer,
>>>> + *     else a value parameter
>>>> + * @b: if a memref or ubuf, size of the buffer, else a value parameter
>>>>   * @c: if a memref, shared memory identifier, else a value parameter
>>>>   *
>>>> - * @attr & TEE_PARAM_ATTR_TYPE_MASK indicates if memref or value is use=
d in
>>>> - * the union. TEE_PARAM_ATTR_TYPE_VALUE_* indicates value and
>>>> - * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref. TEE_PARAM_ATTR_TYPE_N=
ONE
>>>> - * indicates that none of the members are used.
>>>> + * @attr & TEE_PARAM_ATTR_TYPE_MASK indicates if memref, ubuf, or value=
 is
>>>> + * used in the union. TEE_PARAM_ATTR_TYPE_VALUE_* indicates value,
>>>> + * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref, and TEE_PARAM_ATTR_TY=
PE_UBUF_*
>>>> + * indicates ubuf. TEE_PARAM_ATTR_TYPE_NONE indicates that none of the =
members
>>>> + * are used.
>>>>   *
>>>>   * Shared memory is allocated with TEE_IOC_SHM_ALLOC which returns an
>>>>   * identifier representing the shared memory object. A memref can refer=
ence
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>
>>


--===============8013986470525325924==--

