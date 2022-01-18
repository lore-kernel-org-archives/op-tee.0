From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH] tee: optee: do not check memref size on return from Secure World
Date: Tue, 18 Jan 2022 17:35:41 +0530
Message-ID: 
 <CAFA6WYM94k7n3mXA7UpGxL=J5TYJFXSa6KWhqjHPzS63SrNCpg@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3Ca4e48364368cce3c91005a3bd4fdacee086ef00d=2E1642087?=
 =?utf-8?q?405=2Egit=2Ejerome=40forissier=2Eorg=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0609763734313935266=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0609763734313935266==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jerome,

On Thu, 13 Jan 2022 at 20:57, Jerome Forissier <jerome@forissier.org> wrote:
>
> Commit c650b8dc7a79 ("tee: optee: do not check memref size on return
> from Secure World") was mistakenly lost in commit 4602c5842f64 ("optee:
> refactor driver with internal callbacks"). Remove the unwanted code
> again.
>

Ah, that's unfortunate. The refactoring that OP-TEE driver has gone
through to support multiple ABIs (SMC and FF-A) was huge and I missed
it during review.

> Fixes: 4602c5842f64 ("optee: refactor driver with internal callbacks")
> Signed-off-by: Jerome Forissier <jerome@forissier.org>
> ---
>  drivers/tee/optee/smc_abi.c | 10 ----------
>  1 file changed, 10 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index cf2e3293567d..09e7ec673bb6 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -71,16 +71,6 @@ static int from_msg_param_tmp_mem(struct tee_param *p, u=
32 attr,
>         p->u.memref.shm_offs =3D mp->u.tmem.buf_ptr - pa;
>         p->u.memref.shm =3D shm;
>
> -       /* Check that the memref is covered by the shm object */
> -       if (p->u.memref.size) {
> -               size_t o =3D p->u.memref.shm_offs +
> -                          p->u.memref.size - 1;
> -
> -               rc =3D tee_shm_get_pa(shm, o, NULL);
> -               if (rc)
> -                       return rc;
> -       }
> -
>         return 0;
>  }
>
> --
> 2.32.0
>

--===============0609763734313935266==--

