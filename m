From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] tee: optee: Fix supplicant wait loop
Date: Mon, 03 Feb 2025 10:31:46 +0100
Message-ID: 
 <CAHUa44FXzL-MZ5y7x6qrsn3GJR=1oR8bbRVCv6ZTvDRoQmENEg@mail.gmail.com>
In-Reply-To: <20250203080030.384929-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7056934521531216649=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7056934521531216649==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 9:00=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> OP-TEE supplicant is a user-space daemon and it's possible for it
> being hung or crashed or killed in the middle of processing an OP-TEE
> RPC call. It becomes more complicated when there is incorrect shutdown
> ordering of the supplicant process vs the OP-TEE client application which
> can eventually lead to system hang-up waiting for the closure of the
> client application.
>
> Allow the client process waiting in kernel for supplicant response to
> be killed rather than indefinitetly waiting in an unkillable state. This
> fixes issues observed during system reboot/shutdown when supplicant got
> hung for some reason or gets crashed/killed which lead to client getting
> hung in an unkillable state. It in turn lead to system being in hung up
> state requiring hard power off/on to recover.
>
> Fixes: 4fb0a5eb364d ("tee: add OP-TEE driver")
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v2:
> - Switch to killable wait instead as suggested by Arnd instead
>   of supplicant timeout. It atleast allow the client to wait for
>   supplicant in killable state which in turn allows system to reboot
>   or shutdown gracefully.
>
>  drivers/tee/optee/supp.c | 32 +++++++-------------------------
>  1 file changed, 7 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
> index 322a543b8c27..3fbfa9751931 100644
> --- a/drivers/tee/optee/supp.c
> +++ b/drivers/tee/optee/supp.c
> @@ -80,7 +80,6 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func=
, size_t num_params,
>         struct optee *optee =3D tee_get_drvdata(ctx->teedev);
>         struct optee_supp *supp =3D &optee->supp;
>         struct optee_supp_req *req;
> -       bool interruptable;
>         u32 ret;
>
>         /*
> @@ -111,36 +110,19 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 =
func, size_t num_params,
>         /*
>          * Wait for supplicant to process and return result, once we've
>          * returned from wait_for_completion(&req->c) successfully we have
> -        * exclusive access again.
> +        * exclusive access again. Allow the wait to be killable such that
> +        * the wait doesn't turn into an indefinite state if the supplicant
> +        * gets hung for some reason.
>          */
> -       while (wait_for_completion_interruptible(&req->c)) {
> -               mutex_lock(&supp->mutex);
> -               interruptable =3D !supp->ctx;
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
> +       if (wait_for_completion_killable(&req->c)) {
> +               if (!mutex_lock_killable(&supp->mutex)) {

Why not mutex_lock()? If we fail to acquire the mutex here, we will
quite likely free the req list item below at the end of this function
while it remains in the list.

Cheers,
Jens

>                         if (req->in_queue) {
>                                 list_del(&req->link);
>                                 req->in_queue =3D false;
>                         }
> +                       mutex_unlock(&supp->mutex);
>                 }
> -               mutex_unlock(&supp->mutex);
> -
> -               if (interruptable) {
> -                       req->ret =3D TEEC_ERROR_COMMUNICATION;
> -                       break;
> -               }
> +               req->ret =3D TEEC_ERROR_COMMUNICATION;
>         }
>
>         ret =3D req->ret;
> --
> 2.43.0
>

--===============7056934521531216649==--

