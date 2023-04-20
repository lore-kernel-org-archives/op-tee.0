From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: fix uninited async notif value
Date: Thu, 20 Apr 2023 14:32:45 +0530
Message-ID: 
 <CAFA6WYM6E_8nnH_v8O4EROdGQ0mY+Bw=ZT_a-y92bh654UozZg@mail.gmail.com>
In-Reply-To: <20230420074923.2281303-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3544565735020874784=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3544565735020874784==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Apr 2023 at 13:43, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Fixes an uninitialized variable in irq_handler() that could lead to
> unpredictable behavior in case OP-TEE fails to handle SMC function ID
> OPTEE_SMC_GET_ASYNC_NOTIF_VALUE. This change ensures that in that case
> get_async_notif_value() properly reports there are no notification
> event.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/r/202304200755.OoiuclDZ-lkp(a)intel.com/
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/all/d9b7f69b-c737-4cb3-8e74-79fe00c934f9(a)ki=
li.mountain/
> Fixes: 6749e69c4dad ("optee: add asynchronous notifications")
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
>  drivers/tee/optee/smc_abi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index de7ac9a46354..6d3705770755 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1001,8 +1001,10 @@ static u32 get_async_notif_value(optee_invoke_fn *in=
voke_fn, bool *value_valid,
>
>         invoke_fn(OPTEE_SMC_GET_ASYNC_NOTIF_VALUE, 0, 0, 0, 0, 0, 0, 0, &re=
s);
>
> -       if (res.a0)
> +       if (res.a0) {
> +               *value_valid =3D false;
>                 return 0;
> +       }
>         *value_valid =3D (res.a2 & OPTEE_SMC_ASYNC_NOTIF_VALUE_VALID);
>         *value_pending =3D (res.a2 & OPTEE_SMC_ASYNC_NOTIF_VALUE_PENDING);
>         return res.a1;
> --
> 2.25.1
>

--===============3544565735020874784==--

