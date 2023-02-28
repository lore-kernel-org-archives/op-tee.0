From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 1/1] tee: amdtee: fix race condition in amdtee_open_session
Date: Tue, 28 Feb 2023 16:37:18 +0530
Message-ID: 
 <CAFA6WYOZwWuMHXGscgK0Lv9Jbt5WHhfhmK+2ZNR6cr2EAbikCw@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3C5bf4f1d679e2f80814d07937309602877afd02c6=2E1677577?=
 =?utf-8?q?036=2Egit=2ERijo-john=2EThomas=40amd=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2433006272726117052=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2433006272726117052==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Feb 2023 at 15:11, Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
>
> There is a potential race condition in amdtee_open_session that may
> lead to use-after-free. For instance, in amdtee_open_session() after
> sess->sess_mask is set, and before setting:
>
>     sess->session_info[i] =3D session_info;
>
> if amdtee_close_session() closes this same session, then 'sess' data
> structure will be released, causing kernel panic when 'sess' is
> accessed within amdtee_open_session().
>
> The solution is to set the bit sess->sess_mask as the last step in
> amdtee_open_session().
>
> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
> Cc: stable(a)vger.kernel.org
> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> ---
>  drivers/tee/amdtee/core.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>

Looks sane to me, FWIW:

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
> index 297dc62bca29..372d64756ed6 100644
> --- a/drivers/tee/amdtee/core.c
> +++ b/drivers/tee/amdtee/core.c
> @@ -267,35 +267,34 @@ int amdtee_open_session(struct tee_context *ctx,
>                 goto out;
>         }
>
> +       /* Open session with loaded TA */
> +       handle_open_session(arg, &session_info, param);
> +       if (arg->ret !=3D TEEC_SUCCESS) {
> +               pr_err("open_session failed %d\n", arg->ret);
> +               handle_unload_ta(ta_handle);
> +               kref_put(&sess->refcount, destroy_session);
> +               goto out;
> +       }
> +
>         /* Find an empty session index for the given TA */
>         spin_lock(&sess->lock);
>         i =3D find_first_zero_bit(sess->sess_mask, TEE_NUM_SESSIONS);
> -       if (i < TEE_NUM_SESSIONS)
> +       if (i < TEE_NUM_SESSIONS) {
> +               sess->session_info[i] =3D session_info;
> +               set_session_id(ta_handle, i, &arg->session);
>                 set_bit(i, sess->sess_mask);
> +       }
>         spin_unlock(&sess->lock);
>
>         if (i >=3D TEE_NUM_SESSIONS) {
>                 pr_err("reached maximum session count %d\n", TEE_NUM_SESSIO=
NS);
> +               handle_close_session(ta_handle, session_info);
>                 handle_unload_ta(ta_handle);
>                 kref_put(&sess->refcount, destroy_session);
>                 rc =3D -ENOMEM;
>                 goto out;
>         }
>
> -       /* Open session with loaded TA */
> -       handle_open_session(arg, &session_info, param);
> -       if (arg->ret !=3D TEEC_SUCCESS) {
> -               pr_err("open_session failed %d\n", arg->ret);
> -               spin_lock(&sess->lock);
> -               clear_bit(i, sess->sess_mask);
> -               spin_unlock(&sess->lock);
> -               handle_unload_ta(ta_handle);
> -               kref_put(&sess->refcount, destroy_session);
> -               goto out;
> -       }
> -
> -       sess->session_info[i] =3D session_info;
> -       set_session_id(ta_handle, i, &arg->session);
>  out:
>         free_pages((u64)ta, get_order(ta_size));
>         return rc;
> --
> 2.25.1
>

--===============2433006272726117052==--

