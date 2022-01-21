From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2] optee: Do not send requests to supplicant during shutdown
Date: Fri, 21 Jan 2022 10:47:20 -0600
Message-ID: <20220121164720.GD89184@sequoia>
In-Reply-To: <20220120104000.669278-1-larper@axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0474616451160674636=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0474616451160674636==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 2022-01-20 11:40:00, Lars Persson wrote:
> The addition of a shutdown hook by commit f25889f93184 ("optee:
> fix tee out of memory failure seen during kexec reboot") introduced a
> kernel shutdown regression that can be triggered after running the
> xtest suites.
>=20
> Once the shutdown hook is called it is not possible to communicate any
> more with the supplicant process because the system is not scheduling
> task any longer. Thus if the optee driver shutdown path receives a
> supplicant RPC request from the OP-TEE we will deadlock the kernel's
> shutdown.
>=20
> This unexpected event will in fact occur after the xtest suite has
> been run. It seems some cached SHM kept alive a context object which
> in turn kept alive a session towards a PTA or TA. Closing the session
> results in a socket RPC command being sent back from OP-TEE.
>=20
> This sequence of events is captured by a 5.15 kernel annotated with
> extra prints:
>=20
>  Calling OPTEE_SMC_DISABLE_SHM_CACHE
>  OPTEE_SMC_DISABLE_SHM_CACHE returned 0
>   freeing SHM ptr 0xFFFFFF8001079380
>  Calling OPTEE_SMC_DISABLE_SHM_CACHE
>  OPTEE_SMC_DISABLE_SHM_CACHE returned 0
>   freeing SHM ptr 0xFFFFFF8001CC5580
>  Calling OPTEE_SMC_DISABLE_SHM_CACHE
>  OPTEE_SMC_DISABLE_SHM_CACHE returned 0
>   freeing SHM ptr 0xFFFFFF8006308A80
>  Calling OPTEE_SMC_DISABLE_SHM_CACHE
>  OPTEE_SMC_DISABLE_SHM_CACHE returned 0
>   freeing SHM ptr 0xFFFFFF8006308B00
>  optee: optee_handle_rpc: a0=3D0XFFFF0000 a1=3D0XA0 a2=3D0X0
>  optee: optee_handle_rpc: a0=3D0XFFFF0005 a1=3D0XFFFFFF80 a2=3D0X61E6500
>  optee: handle_rpc_func_cmd: cmd =3D 0XA
>  optee_supp_thrd_req: func=3D0XA
>=20
> Introduce a shutdown state in the optee device object to return an
> immediate error to all RPC requests in the shutdown path.
>=20
> Fixes: f25889f93184 ("optee: fix tee out of memory failure seen during kexe=
c reboot")
> Signed-off-by: Lars Persson <larper@axis.com>

I think that this change looks alright to fix the deadlock but I don't
feel qualified to definitively say that this is the right fix. Something
makes me wonder why the session is kept alive and if there's an
underlying bug that we're masking over but I don't understand the
lifetime of the objects, sessions, etc., when the supplicant is
involved. I'm going to defer to Jens and Sumit on the design aspects.

Tyler

> ---
>  drivers/tee/optee/optee_private.h | 1 +
>  drivers/tee/optee/smc_abi.c       | 5 ++++-
>  drivers/tee/optee/supp.c          | 8 ++++++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_pr=
ivate.h
> index 46f74ab07c7e..9eb72931e11f 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -162,6 +162,7 @@ struct optee {
>  	struct tee_shm_pool *pool;
>  	unsigned int rpc_arg_count;
>  	bool   scan_bus_done;
> +	bool   shutting_down;
>  	struct workqueue_struct *scan_bus_wq;
>  	struct work_struct scan_bus_work;
>  };
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 449d6a72d289..10af747da816 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1356,7 +1356,10 @@ static int optee_smc_remove(struct platform_device *=
pdev)
>   */
>  static void optee_shutdown(struct platform_device *pdev)
>  {
> -	optee_disable_shm_cache(platform_get_drvdata(pdev));
> +	struct optee *optee =3D platform_get_drvdata(pdev);
> +
> +	optee->shutting_down =3D true;
> +	optee_disable_shm_cache(optee);
>  }
> =20
>  static int optee_probe(struct platform_device *pdev)
> diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
> index 322a543b8c27..801b4ec659e8 100644
> --- a/drivers/tee/optee/supp.c
> +++ b/drivers/tee/optee/supp.c
> @@ -83,6 +83,14 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 fun=
c, size_t num_params,
>  	bool interruptable;
>  	u32 ret;
> =20
> +	/*
> +	 * When the system is shutting down we cannot talk
> +	 * to the supplicant anymore even if we seem to have
> +	 * an open session to it.
> +	 */
> +	if (optee->shutting_down)
> +		return TEEC_ERROR_COMMUNICATION;
> +
>  	/*
>  	 * Return in case there is no supplicant available and
>  	 * non-blocking request.
> --=20
> 2.30.2
>=20

--===============0474616451160674636==--

