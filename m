From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 1/1] tee: amdtee: fix use-after-free vulnerability in
 amdtee_close_session
Date: Thu, 28 Sep 2023 20:35:14 +0530
Message-ID: 
 <CAFA6WYOk3M1EH1KPf4w=qYaQRF6Y_cnNWimJGTyiAdEokiNMKQ@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3C6a829fb24c6b680275a08edf883ee458a9cab011=2E1695365?=
 =?utf-8?q?438=2Egit=2ERijo-john=2EThomas=40amd=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7935319000309138277=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7935319000309138277==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Rijo,

On Fri, 22 Sept 2023 at 12:26, Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
>
> There is a potential race condition in amdtee_close_session that may
> cause use-after-free in amdtee_open_session. For instance, if a session
> has refcount =3D=3D 1, and one thread tries to free this session via:
>
>     kref_put(&sess->refcount, destroy_session);
>
> the reference count will get decremented, and the next step would be to
> call destroy_session(). However, if in another thread,
> amdtee_open_session() is called before destroy_session() has completed
> execution, alloc_session() may return 'sess' that will be freed up
> later in destroy_session() leading to use-after-free in
> amdtee_open_session.
>
> To fix this issue, treat decrement of sess->refcount and invocation of
> destroy_session() as a single critical section, so that it is executed
> atomically.
>
> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
> Cc: stable(a)vger.kernel.org
> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> ---
>  drivers/tee/amdtee/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
> index 372d64756ed6..04cee03bec9d 100644
> --- a/drivers/tee/amdtee/core.c
> +++ b/drivers/tee/amdtee/core.c
> @@ -217,14 +217,13 @@ static int copy_ta_binary(struct tee_context *ctx, vo=
id *ptr, void **ta,
>         return rc;
>  }
>
> +/* mutex must be held by caller */
>  static void destroy_session(struct kref *ref)
>  {
>         struct amdtee_session *sess =3D container_of(ref, struct amdtee_ses=
sion,
>                                                    refcount);
>
> -       mutex_lock(&session_list_mutex);
>         list_del(&sess->list_node);
> -       mutex_unlock(&session_list_mutex);
>         kfree(sess);
>  }
>
> @@ -272,7 +271,9 @@ int amdtee_open_session(struct tee_context *ctx,
>         if (arg->ret !=3D TEEC_SUCCESS) {
>                 pr_err("open_session failed %d\n", arg->ret);
>                 handle_unload_ta(ta_handle);
> +               mutex_lock(&session_list_mutex);
>                 kref_put(&sess->refcount, destroy_session);

How about you rather use kref_put_mutex() here and then keep the
mutex_unlock() within the destroy_session()?

> +               mutex_unlock(&session_list_mutex);
>                 goto out;
>         }
>
> @@ -290,7 +291,9 @@ int amdtee_open_session(struct tee_context *ctx,
>                 pr_err("reached maximum session count %d\n", TEE_NUM_SESSIO=
NS);
>                 handle_close_session(ta_handle, session_info);
>                 handle_unload_ta(ta_handle);
> +               mutex_lock(&session_list_mutex);
>                 kref_put(&sess->refcount, destroy_session);

Ditto.

> +               mutex_unlock(&session_list_mutex);
>                 rc =3D -ENOMEM;
>                 goto out;
>         }
> @@ -331,7 +334,9 @@ int amdtee_close_session(struct tee_context *ctx, u32 s=
ession)
>         handle_close_session(ta_handle, session_info);
>         handle_unload_ta(ta_handle);
>
> +       mutex_lock(&session_list_mutex);
>         kref_put(&sess->refcount, destroy_session);

Ditto.

-Sumit

> +       mutex_unlock(&session_list_mutex);
>
>         return 0;
>  }
> --
> 2.25.1
>

--===============7935319000309138277==--

