From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v1 1/1] tee: optee: Provide special parameter field for
 UUID values
Date: Mon, 19 Apr 2021 13:35:51 +0200
Message-ID: 
 <CAHUa44FWJiL1yzHR0jwL2VJG_4t_O6An48v47gORitcaahwmYw@mail.gmail.com>
In-Reply-To: <20210415145857.34183-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4232174495566074531=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4232174495566074531==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Thu, Apr 15, 2021 at 4:58 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Dereferencing something to uuid_t value is not good idea strictly speaking.
> Provide a special parameter field for UUID values and drop ugly casting.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tee/optee/call.c      | 2 +-
>  drivers/tee/optee/optee_msg.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index 1f0a68381656..d50cff7a9406 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -241,7 +241,7 @@ int optee_open_session(struct tee_context *ctx,
>         memcpy(&msg_arg->params[0].u.value, arg->uuid, sizeof(arg->uuid));
>         msg_arg->params[1].u.value.c =3D arg->clnt_login;
>
> -       rc =3D tee_session_calc_client_uuid((uuid_t *)&msg_arg->params[1].u=
.value,
> +       rc =3D tee_session_calc_client_uuid(&msg_arg->params[1].u.uuid,
>                                           arg->clnt_login, arg->clnt_uuid);
>         if (rc)
>                 goto out;
> diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> index 81ff593ac4ec..df095a974f3f 100644
> --- a/drivers/tee/optee/optee_msg.h
> +++ b/drivers/tee/optee/optee_msg.h
> @@ -144,6 +144,7 @@ struct optee_msg_param_value {
>   * @tmem:      parameter by temporary memory reference
>   * @rmem:      parameter by registered memory reference
>   * @value:     parameter by opaque value
> + * @uuid:      parameter by UUID
>   *
>   * @attr & OPTEE_MSG_ATTR_TYPE_MASK indicates if tmem, rmem or value is us=
ed in
>   * the union. OPTEE_MSG_ATTR_TYPE_VALUE_* indicates value,
> @@ -157,6 +158,7 @@ struct optee_msg_param {
>                 struct optee_msg_param_tmem tmem;
>                 struct optee_msg_param_rmem rmem;
>                 struct optee_msg_param_value value;
> +               uuid_t uuid;

It's nice to get rid of the cast above, but I'm not that keen on the
change in this struct. This file defines the ABI towards Secure world
and adding dependencies on external complex types is a larger problem
than the cast above in my opinion.

Cheers,
Jens

--===============4232174495566074531==--

