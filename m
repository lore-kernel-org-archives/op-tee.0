From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH] optee: smc_abi.c: fix wrong pointer passed to IS_ERR/PTR_ERR()
Date: Mon, 11 Jul 2022 08:09:22 +0200
Message-ID: 
 <CAHUa44Gxs9-wB6xJ9+Fbkgzw+n8UkpLOzj0GDX4toH_O5Dtqwg@mail.gmail.com>
In-Reply-To: <20220628065216.901194-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9211650585664083545=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9211650585664083545==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 28, 2022 at 8:42 AM Yang Yingliang <yangyingliang@huawei.com> w=
rote:
>
> It should be 'rpc_arg' pass to IS_ERR/PTR_ERR().
>
> Fixes: ed8faf6c8f8c ("optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and OPTEE_SMC_=
CALL_WITH_REGD_ARG")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/tee/optee/smc_abi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I'm picking up this. I've added some description in the commit message.

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 385cb0aee610..a1c1fa1a9c28 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -884,8 +884,8 @@ static int optee_smc_do_call_with_arg(struct tee_contex=
t *ctx,
>
>                 rpc_arg_offs =3D OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
>                 rpc_arg =3D tee_shm_get_va(shm, offs + rpc_arg_offs);
> -               if (IS_ERR(arg))
> -                       return PTR_ERR(arg);
> +               if (IS_ERR(rpc_arg))
> +                       return PTR_ERR(rpc_arg);
>         }
>
>         if  (rpc_arg && tee_shm_is_dynamic(shm)) {
> --
> 2.25.1
>

--===============9211650585664083545==--

