From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] KEYS: trusted: tee: use tee_shm_register_alloc_buf()
Date: Mon, 07 Aug 2023 13:28:21 +0530
Message-ID: 
 <CAFA6WYMzBJTNUxh6b-y=a_NND8FX65YjEP4i-HPS4tQ-Qfm+0w@mail.gmail.com>
In-Reply-To: <20230803123515.4018838-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0773643979146111643=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0773643979146111643==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Thu, 3 Aug 2023 at 18:05, Jens Wiklander <jens.wiklander@linaro.org> wro=
te:
>
> Prior to this patch was trusted_tee_seal() and trusted_tee_get_random()
> relying on tee_shm_register_kernel_buf() to share memory with the TEE.
> Depending on the memory allocation pattern the pages holding the
> registered buffers overlap with other buffers also shared with the TEE.
>

The overlap here is due to the fact that we are registering two array
members of the same struct. This overlap can be removed by registering
the overall structure at once. But that sounds unnecessary data
structure type sharing with trusted keys TA.

> The OP-TEE driver using the old SMC based ABI permits overlapping shared
> buffers, but with the new FF-A based ABI each physical page may only
> be registered once.

Would it be possible for OP-TEE FF-A ABI to check if a page is already
registered? If it is then just return success with appropriate page
offset. As otherwise this sounds like an unnecessary restriction for
users. I don't think the problem is only particular to the trusted
keys driver but can be reproduced for user-space clients as well.

>
> Fix this problem by allocating a temporary page aligned shared memory
> buffer to be used as a bounce buffer for the needed data buffers.
>
> Since TEE trusted keys doesn't depend on registered shared memory
> support any longer remove that explicit dependency when opening a
> context to the TEE.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  security/keys/trusted-keys/trusted_tee.c | 68 +++++++++++++-----------
>  1 file changed, 36 insertions(+), 32 deletions(-)
>
> diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trust=
ed-keys/trusted_tee.c
> index ac3e270ade69..3085343c489a 100644
> --- a/security/keys/trusted-keys/trusted_tee.c
> +++ b/security/keys/trusted-keys/trusted_tee.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/err.h>
>  #include <linux/key-type.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> @@ -65,38 +66,37 @@ static int trusted_tee_seal(struct trusted_key_payload =
*p, char *datablob)
>         int ret;
>         struct tee_ioctl_invoke_arg inv_arg;
>         struct tee_param param[4];
> -       struct tee_shm *reg_shm_in =3D NULL, *reg_shm_out =3D NULL;
> +       struct tee_shm *shm;
> +       uint8_t *buf;
>
>         memset(&inv_arg, 0, sizeof(inv_arg));
>         memset(&param, 0, sizeof(param));
>
> -       reg_shm_in =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
> -                                                p->key_len);
> -       if (IS_ERR(reg_shm_in)) {
> -               dev_err(pvt_data.dev, "key shm register failed\n");
> -               return PTR_ERR(reg_shm_in);
> +       shm =3D tee_shm_alloc_kernel_buf(pvt_data.ctx,
> +                                      p->key_len + sizeof(p->blob));
> +       if (IS_ERR(shm)) {
> +               dev_err(pvt_data.dev, "key shm alloc failed\n");
> +               return PTR_ERR(shm);
>         }
> -
> -       reg_shm_out =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->blob,
> -                                                 sizeof(p->blob));
> -       if (IS_ERR(reg_shm_out)) {
> -               dev_err(pvt_data.dev, "blob shm register failed\n");
> -               ret =3D PTR_ERR(reg_shm_out);
> +       buf =3D tee_shm_get_va(shm, 0);
> +       if (IS_ERR(buf)) {
> +               ret =3D PTR_ERR(buf);
>                 goto out;
>         }
> +       memcpy(buf, p->key, p->key_len);

These memcpy()'s here and below are undue overheads if we change to
tee_shm_alloc_kernel_buf().

-Sumit

>
>         inv_arg.func =3D TA_CMD_SEAL;
>         inv_arg.session =3D pvt_data.session_id;
>         inv_arg.num_params =3D 4;
>
>         param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> -       param[0].u.memref.shm =3D reg_shm_in;
> +       param[0].u.memref.shm =3D shm;
>         param[0].u.memref.size =3D p->key_len;
>         param[0].u.memref.shm_offs =3D 0;
>         param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> -       param[1].u.memref.shm =3D reg_shm_out;
> +       param[1].u.memref.shm =3D shm;
>         param[1].u.memref.size =3D sizeof(p->blob);
> -       param[1].u.memref.shm_offs =3D 0;
> +       param[1].u.memref.shm_offs =3D p->key_len;
>
>         ret =3D tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
>         if ((ret < 0) || (inv_arg.ret !=3D 0)) {
> @@ -104,14 +104,13 @@ static int trusted_tee_seal(struct trusted_key_payloa=
d *p, char *datablob)
>                         inv_arg.ret);
>                 ret =3D -EFAULT;
>         } else {
> +               memcpy(p->blob, buf + p->key_len,
> +                      min(param[1].u.memref.size, sizeof(p->blob)));
>                 p->blob_len =3D param[1].u.memref.size;
>         }
>
>  out:
> -       if (reg_shm_out)
> -               tee_shm_free(reg_shm_out);
> -       if (reg_shm_in)
> -               tee_shm_free(reg_shm_in);
> +       tee_shm_free(shm);
>
>         return ret;
>  }
> @@ -166,11 +165,9 @@ static int trusted_tee_unseal(struct trusted_key_paylo=
ad *p, char *datablob)
>                 p->key_len =3D param[1].u.memref.size;
>         }
>
> +       tee_shm_free(reg_shm_out);
>  out:
> -       if (reg_shm_out)
> -               tee_shm_free(reg_shm_out);
> -       if (reg_shm_in)
> -               tee_shm_free(reg_shm_in);
> +       tee_shm_free(reg_shm_in);
>
>         return ret;
>  }
> @@ -183,15 +180,21 @@ static int trusted_tee_get_random(unsigned char *key,=
 size_t key_len)
>         int ret;
>         struct tee_ioctl_invoke_arg inv_arg;
>         struct tee_param param[4];
> -       struct tee_shm *reg_shm =3D NULL;
> +       struct tee_shm *shm;
> +       void *buf;
>
>         memset(&inv_arg, 0, sizeof(inv_arg));
>         memset(&param, 0, sizeof(param));
>
> -       reg_shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, key, key_len);
> -       if (IS_ERR(reg_shm)) {
> -               dev_err(pvt_data.dev, "key shm register failed\n");
> -               return PTR_ERR(reg_shm);
> +       shm =3D tee_shm_alloc_kernel_buf(pvt_data.ctx, key_len);
> +       if (IS_ERR(shm)) {
> +               dev_err(pvt_data.dev, "key shm alloc failed\n");
> +               return PTR_ERR(shm);
> +       }
> +       buf =3D tee_shm_get_va(shm, 0);
> +       if (IS_ERR(buf)) {
> +               ret =3D PTR_ERR(buf);
> +               goto out;
>         }
>
>         inv_arg.func =3D TA_CMD_GET_RANDOM;
> @@ -199,7 +202,7 @@ static int trusted_tee_get_random(unsigned char *key, s=
ize_t key_len)
>         inv_arg.num_params =3D 4;
>
>         param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> -       param[0].u.memref.shm =3D reg_shm;
> +       param[0].u.memref.shm =3D shm;
>         param[0].u.memref.size =3D key_len;
>         param[0].u.memref.shm_offs =3D 0;
>
> @@ -209,18 +212,19 @@ static int trusted_tee_get_random(unsigned char *key,=
 size_t key_len)
>                         inv_arg.ret);
>                 ret =3D -EFAULT;
>         } else {
> +               memcpy(key, buf, min(param[0].u.memref.size, key_len));
>                 ret =3D param[0].u.memref.size;
>         }
>
> -       tee_shm_free(reg_shm);
> +out:
> +       tee_shm_free(shm);
>
>         return ret;
>  }
>
>  static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void =
*data)
>  {
> -       if (ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE &&
> -           ver->gen_caps & TEE_GEN_CAP_REG_MEM)
> +       if (ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE)
>                 return 1;
>         else
>                 return 0;
> --
> 2.34.1
>

--===============0773643979146111643==--

