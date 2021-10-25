From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH][next] optee: Fix spelling mistake "reclain" -> "reclaim"
Date: Mon, 25 Oct 2021 14:13:36 +0530
Message-ID: 
 <CAFA6WYMJkEPOCUMeF1EL7G1q7akBc-os5GF33Dkh6nok8fANZw@mail.gmail.com>
In-Reply-To: <20211023115209.19115-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9218756208059652601=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9218756208059652601==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 23 Oct 2021 at 17:22, Colin Ian King
<colin.i.king@googlemail.com> wrote:
>
> There are spelling mistakes in pr_err error messages. Fix them.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/tee/optee/ffa_abi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 6defd1ec982a..45424824e0f9 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -333,7 +333,7 @@ static int optee_ffa_shm_unregister(struct tee_context =
*ctx,
>
>         rc =3D ffa_ops->memory_reclaim(global_handle, 0);
>         if (rc)
> -               pr_err("mem_reclain: 0x%llx %d", global_handle, rc);
> +               pr_err("mem_reclaim: 0x%llx %d", global_handle, rc);
>
>         return rc;
>  }
> @@ -355,7 +355,7 @@ static int optee_ffa_shm_unregister_supp(struct tee_con=
text *ctx,
>         optee_shm_rem_ffa_handle(optee, global_handle);
>         rc =3D ffa_ops->memory_reclaim(global_handle, 0);
>         if (rc)
> -               pr_err("mem_reclain: 0x%llx %d", global_handle, rc);
> +               pr_err("mem_reclaim: 0x%llx %d", global_handle, rc);
>
>         shm->sec_world_id =3D 0;
>
> --
> 2.32.0
>

--===============9218756208059652601==--

