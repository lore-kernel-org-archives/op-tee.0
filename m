From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Add support for supplicant timeout
Date: Wed, 18 Dec 2024 07:57:33 +0100
Message-ID: 
 <CAHUa44E08d4K0pnSWt+0AoFkU_nFELzGG6HoiwnmXLJU2_bv4Q@mail.gmail.com>
In-Reply-To: <20241213111453.367031-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8467482376913455377=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8467482376913455377==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

On Fri, Dec 13, 2024 at 12:15=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> OP-TEE supplicant is a user-space daemon and it's possible for it
> being crashed or killed in the middle of processing an OP-TEE RPC call.
> It becomes more complicated when there is incorrect shutdown ordering
> of the supplicant process vs the OP-TEE client application which can
> eventually lead to system hang-up waiting for the closure of the client
> application.
>
> In order to gracefully handle this scenario, let's add a long enough
> timeout to wait for supplicant to process requests. In case there is a
> timeout then we return a proper error code for the RPC request.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/optee/supp.c | 58 +++++++++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
> index 322a543b8c27..92e86ac4cdd4 100644
> --- a/drivers/tee/optee/supp.c
> +++ b/drivers/tee/optee/supp.c
> @@ -7,6 +7,15 @@
>  #include <linux/uaccess.h>
>  #include "optee_private.h"
>
> +/*
> + * OP-TEE supplicant timeout, the user-space supplicant may get
> + * crashed or killed while servicing an RPC call. This will just lead
> + * to OP-TEE client hung indefinitely just waiting for supplicant to
> + * serve requests which isn't expected. It is rather expected to fail
> + * gracefully with a timeout which is long enough.
> + */
> +#define SUPP_TIMEOUT   (msecs_to_jiffies(10000))
> +
>  struct optee_supp_req {
>         struct list_head link;
>
> @@ -52,8 +61,10 @@ void optee_supp_release(struct optee_supp *supp)
>
>         /* Abort all queued requests */
>         list_for_each_entry_safe(req, req_tmp, &supp->reqs, link) {
> -               list_del(&req->link);
> -               req->in_queue =3D false;
> +               if (req->in_queue) {
> +                       list_del(&req->link);
> +                       req->in_queue =3D false;
> +               }
>                 req->ret =3D TEEC_ERROR_COMMUNICATION;
>                 complete(&req->c);
>         }
> @@ -82,6 +93,7 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func=
, size_t num_params,
>         struct optee_supp_req *req;
>         bool interruptable;
>         u32 ret;
> +       int res =3D 1;
>
>         /*
>          * Return in case there is no supplicant available and
> @@ -108,28 +120,28 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 =
func, size_t num_params,
>         /* Tell an eventual waiter there's a new request */
>         complete(&supp->reqs_c);
>
> -       /*
> -        * Wait for supplicant to process and return result, once we've
> -        * returned from wait_for_completion(&req->c) successfully we have
> -        * exclusive access again.
> -        */
> -       while (wait_for_completion_interruptible(&req->c)) {
> +       /* Wait for supplicant to process and return result */
> +       while (res) {
> +               res =3D wait_for_completion_interruptible_timeout(&req->c,
> +                                                               SUPP_TIMEOU=
T);
> +               /* Check if supplicant served the request */
> +               if (res > 0)
> +                       break;
> +
>                 mutex_lock(&supp->mutex);
> +               /*
> +                * There's no supplicant available and since the supp->mutex
> +                * currently is held none can become available until the mu=
tex
> +                * released again.
> +                *
> +                * Interrupting an RPC to supplicant is only allowed as a w=
ay
> +                * of slightly improving the user experience in case the
> +                * supplicant hasn't been started yet. During normal operat=
ion
> +                * the supplicant will serve all requests in a timely manne=
r and
> +                * interrupting then wouldn't make sense.
> +                */
>                 interruptable =3D !supp->ctx;
> -               if (interruptable) {
> -                       /*
> -                        * There's no supplicant available and since the
> -                        * supp->mutex currently is held none can
> -                        * become available until the mutex released
> -                        * again.
> -                        *
> -                        * Interrupting an RPC to supplicant is only
> -                        * allowed as a way of slightly improving the user
> -                        * experience in case the supplicant hasn't been
> -                        * started yet. During normal operation the supplic=
ant
> -                        * will serve all requests in a timely manner and
> -                        * interrupting then wouldn't make sense.
> -                        */
> +               if (interruptable || (res =3D=3D 0)) {

Are you fixing an observed problem or a theoretical one? If the
supplicant has died then "interruptable" is expected to be true so the
timeout shouldn't matter.

Cheers,
Jens

>                         if (req->in_queue) {
>                                 list_del(&req->link);
>                                 req->in_queue =3D false;
> @@ -141,6 +153,8 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 fu=
nc, size_t num_params,
>                         req->ret =3D TEEC_ERROR_COMMUNICATION;
>                         break;
>                 }
> +               if (res =3D=3D 0)
> +                       req->ret =3D TEE_ERROR_TIMEOUT;
>         }
>
>         ret =3D req->ret;
> --
> 2.43.0
>

--===============8467482376913455377==--

