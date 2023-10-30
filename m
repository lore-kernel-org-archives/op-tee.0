From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: add missing description of RPC argument reference
Date: Mon, 30 Oct 2023 14:35:59 +0530
Message-ID: 
 <CAFA6WYO4m5n9oTzP1zJdJXASCwXdhVaa_tMN2EhDTNDMmxwaJg@mail.gmail.com>
In-Reply-To: <20231030085515.907123-1-etienne.carriere@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6017309692054599494=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6017309692054599494==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Oct 2023 at 14:25, Etienne Carriere
<etienne.carriere@foss.st.com> wrote:
>
> Adds missing inline description comment for RPC optional arguments
> reference.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/lkml/202310192021.fvb6JDOY-lkp(a)intel.com/
> Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> ---
>  drivers/tee/optee/smc_abi.c | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index d5b28fd35d66..67bfa25d6302 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -806,6 +806,7 @@ static void handle_rpc_func_cmd(struct tee_context *ctx=
, struct optee *optee,
>  /**
>   * optee_handle_rpc() - handle RPC from secure world
>   * @ctx:       context doing the RPC
> + * @rpc_arg:   pointer to RPC arguments if any, or NULL if none
>   * @param:     value of registers for the RPC
>   * @call_ctx:  call context. Preserved during one OP-TEE invocation
>   *
> --
> 2.25.1
>

--===============6017309692054599494==--

