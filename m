From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: Do not send requests to supplicant during shutdown
Date: Thu, 20 Jan 2022 10:03:11 +0100
Message-ID: <20220120090311.GA1108588@jade>
In-Reply-To: <20220119174933.449842-1-larper@axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4351412177269975469=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4351412177269975469==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 19, 2022 at 06:49:33PM +0100, Lars Persson wrote:
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
c reboot
> Signed-off-by: Lars Persson <larper@axis.com>
> ---
>  drivers/tee/optee/optee_private.h | 1 +
>  drivers/tee/optee/smc_abi.c       | 5 ++++-
>  drivers/tee/optee/supp.c          | 8 ++++++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_pr=
ivate.h
> index 46f74ab07c7e..83380974ff44 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -164,6 +164,7 @@ struct optee {
>  	bool   scan_bus_done;
>  	struct workqueue_struct *scan_bus_wq;
>  	struct work_struct scan_bus_work;
> +	bool shutting_down;

Please move this to right after "bool scan_bus_done" above to avoid
unnecessary extra padding.

Thanks,
Jens

--===============4351412177269975469==--

