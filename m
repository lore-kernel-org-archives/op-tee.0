From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 10/12] KEYS: trusted: tee: use tee_shm_register_kernel_buf()
Date: Thu, 20 Jan 2022 16:33:37 +0530
Message-ID: 
 <CAFA6WYOhetqNbPdTtugOsOnwQECx6S_m0aF0V33CSC86GLuY9Q@mail.gmail.com>
In-Reply-To: <20220114150824.3578829-11-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2019683919427234061=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2019683919427234061==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Jan 2022 at 20:38, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Uses the new simplified tee_shm_register_kernel_buf() function instead
> of the old tee_shm_alloc() function which required specific
> TEE_SHM-flags
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  security/keys/trusted-keys/trusted_tee.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trust=
ed-keys/trusted_tee.c
> index 2ce66c199e1d..c8626686ee1b 100644
> --- a/security/keys/trusted-keys/trusted_tee.c
> +++ b/security/keys/trusted-keys/trusted_tee.c
> @@ -70,17 +70,15 @@ static int trusted_tee_seal(struct trusted_key_payload =
*p, char *datablob)
>         memset(&inv_arg, 0, sizeof(inv_arg));
>         memset(&param, 0, sizeof(param));
>
> -       reg_shm_in =3D tee_shm_register(pvt_data.ctx, (unsigned long)p->key,
> -                                     p->key_len, TEE_SHM_DMA_BUF |
> -                                     TEE_SHM_KERNEL_MAPPED);
> +       reg_shm_in =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
> +                                                p->key_len);
>         if (IS_ERR(reg_shm_in)) {
>                 dev_err(pvt_data.dev, "key shm register failed\n");
>                 return PTR_ERR(reg_shm_in);
>         }
>
> -       reg_shm_out =3D tee_shm_register(pvt_data.ctx, (unsigned long)p->bl=
ob,
> -                                      sizeof(p->blob), TEE_SHM_DMA_BUF |
> -                                      TEE_SHM_KERNEL_MAPPED);
> +       reg_shm_out =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->blob,
> +                                                 sizeof(p->blob));
>         if (IS_ERR(reg_shm_out)) {
>                 dev_err(pvt_data.dev, "blob shm register failed\n");
>                 ret =3D PTR_ERR(reg_shm_out);
> @@ -131,17 +129,15 @@ static int trusted_tee_unseal(struct trusted_key_payl=
oad *p, char *datablob)
>         memset(&inv_arg, 0, sizeof(inv_arg));
>         memset(&param, 0, sizeof(param));
>
> -       reg_shm_in =3D tee_shm_register(pvt_data.ctx, (unsigned long)p->blo=
b,
> -                                     p->blob_len, TEE_SHM_DMA_BUF |
> -                                     TEE_SHM_KERNEL_MAPPED);
> +       reg_shm_in =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->blob,
> +                                                p->blob_len);
>         if (IS_ERR(reg_shm_in)) {
>                 dev_err(pvt_data.dev, "blob shm register failed\n");
>                 return PTR_ERR(reg_shm_in);
>         }
>
> -       reg_shm_out =3D tee_shm_register(pvt_data.ctx, (unsigned long)p->ke=
y,
> -                                      sizeof(p->key), TEE_SHM_DMA_BUF |
> -                                      TEE_SHM_KERNEL_MAPPED);
> +       reg_shm_out =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
> +                                                 sizeof(p->key));
>         if (IS_ERR(reg_shm_out)) {
>                 dev_err(pvt_data.dev, "key shm register failed\n");
>                 ret =3D PTR_ERR(reg_shm_out);
> @@ -192,8 +188,7 @@ static int trusted_tee_get_random(unsigned char *key, s=
ize_t key_len)
>         memset(&inv_arg, 0, sizeof(inv_arg));
>         memset(&param, 0, sizeof(param));
>
> -       reg_shm =3D tee_shm_register(pvt_data.ctx, (unsigned long)key, key_=
len,
> -                                  TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED);
> +       reg_shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, key, key_len);
>         if (IS_ERR(reg_shm)) {
>                 dev_err(pvt_data.dev, "key shm register failed\n");
>                 return PTR_ERR(reg_shm);
> --
> 2.31.1
>

--===============2019683919427234061==--

