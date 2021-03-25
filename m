From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 1/1] tee: optee: do not check memref size on return from
 Secure World
Date: Thu, 25 Mar 2021 19:48:21 +0530
Message-ID: 
 <CAFA6WYPryB+9W6EGXvea07=JH8_cfHKF8a4BDEyPeqPVkzvutw@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3C010001785986e9be-63aa88ce-3cf8-425f-87da-b2e3f84f6?=
 =?utf-8?q?ef5-000000=40email=2Eamazonses=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8166846479829656686=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8166846479829656686==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Mar 2021 at 16:11, Jerome Forissier via OP-TEE
<op-tee@lists.trustedfirmware.org> wrote:
>
> When Secure World returns, it may have changed the size attribute of the
> memory references passed as [in/out] parameters. The GlobalPlatform TEE
> Internal Core API specification does not restrict the values that this
> size can take. In particular, Secure World may increase the value to be
> larger than the size of the input buffer to indicate that it needs more.
>
> Therefore, the size check in optee_from_msg_param() is incorrect and
> needs to be removed. This fixes a number of failed test cases in the
> GlobalPlatform TEE Initial Configuratiom Test Suite v2_0_0_0-2017_06_09
> when OP-TEE is compiled without dynamic shared memory support
> (CFG_CORE_DYN_SHM=3Dn).
>
> Suggested-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Jerome Forissier <jerome@forissier.org>
> ---
>  drivers/tee/optee/core.c | 10 ----------
>  1 file changed, 10 deletions(-)
>

Looks good to me.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 319a1e701163..ddb8f9ecf307 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -79,16 +79,6 @@ int optee_from_msg_param(struct tee_param *params, size_=
t num_params,
>                                 return rc;
>                         p->u.memref.shm_offs =3D mp->u.tmem.buf_ptr - pa;
>                         p->u.memref.shm =3D shm;
> -
> -                       /* Check that the memref is covered by the shm obje=
ct */
> -                       if (p->u.memref.size) {
> -                               size_t o =3D p->u.memref.shm_offs +
> -                                          p->u.memref.size - 1;
> -
> -                               rc =3D tee_shm_get_pa(shm, o, NULL);
> -                               if (rc)
> -                                       return rc;
> -                       }
>                         break;
>                 case OPTEE_MSG_ATTR_TYPE_RMEM_INPUT:
>                 case OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT:
> --
> 2.25.1
>

--===============8166846479829656686==--

