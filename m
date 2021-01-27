From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: simplify i2c access
Date: Wed, 27 Jan 2021 11:41:26 +0100
Message-ID: 
 <CAHUa44GwSRB=7tFpXi2ZW-SXGipp7ErDkB2_4iGQfyH_ECAU8A@mail.gmail.com>
In-Reply-To: <20210125113758.2430680-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5619831059829378641=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5619831059829378641==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Mon, Jan 25, 2021 at 12:38 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Storing a bogus i2c_client structure on the stack adds overhead and
> causes a compile-time warning:
>
> drivers/tee/optee/rpc.c:493:6: error: stack frame size of 1056 bytes in fun=
ction 'optee_handle_rpc' [-Werror,-Wframe-larger-than=3D]
> void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *para=
m,
>
> Change the implementation of handle_rpc_func_cmd_i2c_transfer() to
> open-code the i2c_transfer() call, which makes it easier to read
> and avoids the warning.
>
> Fixes: c05210ab9757 ("drivers: optee: allow op-tee to access devices on the=
 i2c bus")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tee/optee/rpc.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)

Looks good to me.
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

Do you want to take it up directly yourself or do you want a pull
request from me?

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index 1e3614e4798f..6cbb3643c6c4 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -54,8 +54,9 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg=
_arg *arg)
>  static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
>                                              struct optee_msg_arg *arg)
>  {
> -       struct i2c_client client =3D { 0 };
>         struct tee_param *params;
> +       struct i2c_adapter *adapter;
> +       struct i2c_msg msg =3D { };
>         size_t i;
>         int ret =3D -EOPNOTSUPP;
>         u8 attr[] =3D {
> @@ -85,48 +86,48 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee=
_context *ctx,
>                         goto bad;
>         }
>
> -       client.adapter =3D i2c_get_adapter(params[0].u.value.b);
> -       if (!client.adapter)
> +       adapter =3D i2c_get_adapter(params[0].u.value.b);
> +       if (!adapter)
>                 goto bad;
>
>         if (params[1].u.value.a & OPTEE_MSG_RPC_CMD_I2C_FLAGS_TEN_BIT) {
> -               if (!i2c_check_functionality(client.adapter,
> +               if (!i2c_check_functionality(adapter,
>                                              I2C_FUNC_10BIT_ADDR)) {
> -                       i2c_put_adapter(client.adapter);
> +                       i2c_put_adapter(adapter);
>                         goto bad;
>                 }
>
> -               client.flags =3D I2C_CLIENT_TEN;
> +               msg.flags =3D I2C_M_TEN;
>         }
>
> -       client.addr =3D params[0].u.value.c;
> -       snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
> +       msg.addr =3D params[0].u.value.c;
> +       msg.buf  =3D params[2].u.memref.shm->kaddr;
> +       msg.len  =3D params[2].u.memref.size;
>
>         switch (params[0].u.value.a) {
>         case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> -               ret =3D i2c_master_recv(&client, params[2].u.memref.shm->ka=
ddr,
> -                                     params[2].u.memref.size);
> +               msg.flags |=3D I2C_M_RD;
>                 break;
>         case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
> -               ret =3D i2c_master_send(&client, params[2].u.memref.shm->ka=
ddr,
> -                                     params[2].u.memref.size);
>                 break;
>         default:
> -               i2c_put_adapter(client.adapter);
> +               i2c_put_adapter(adapter);
>                 goto bad;
>         }
>
> +       ret =3D i2c_transfer(adapter, &msg, 1);
> +
>         if (ret < 0) {
>                 arg->ret =3D TEEC_ERROR_COMMUNICATION;
>         } else {
> -               params[3].u.value.a =3D ret;
> +               params[3].u.value.a =3D msg.len;
>                 if (optee_to_msg_param(arg->params, arg->num_params, params=
))
>                         arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
>                 else
>                         arg->ret =3D TEEC_SUCCESS;
>         }
>
> -       i2c_put_adapter(client.adapter);
> +       i2c_put_adapter(adapter);
>         kfree(params);
>         return;
>  bad:
> --
> 2.29.2
>

--===============5619831059829378641==--

