From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 5/5] optee: add FF-A support
Date: Fri, 01 Oct 2021 10:34:24 +0100
Message-ID: <20211001093424.n4x34qp3ewbbijmc@bogus>
In-Reply-To: <20210831072412.887565-6-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4408862566883834733=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4408862566883834733==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 31, 2021 at 09:24:12AM +0200, Jens Wiklander wrote:
> Adds support for using FF-A [1] as transport to the OP-TEE driver.
>=20
> Introduces struct optee_msg_param_fmem which carries all information
> needed when OP-TEE is calling FFA_MEM_RETRIEVE_REQ to get the shared
> memory reference mapped by the hypervisor in S-EL2. Register usage is
> also updated to include the information needed.
>=20
> The FF-A part of this driver is enabled if CONFIG_ARM_FFA_TRANSPORT is
> enabled.
>=20
> [1] https://developer.arm.com/documentation/den0077/latest
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/Makefile        |   3 +-
>  drivers/tee/optee/call.c          |  13 +-
>  drivers/tee/optee/core.c          |  16 +-
>  drivers/tee/optee/ffa_abi.c       | 907 ++++++++++++++++++++++++++++++
>  drivers/tee/optee/optee_ffa.h     | 153 +++++
>  drivers/tee/optee/optee_msg.h     |  27 +-
>  drivers/tee/optee/optee_private.h |  43 +-
>  7 files changed, 1148 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/tee/optee/ffa_abi.c
>  create mode 100644 drivers/tee/optee/optee_ffa.h
>=20
> diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> index d4e4776d2dec..dbfd83d3c4ae 100644
> --- a/drivers/tee/optee/Makefile
> +++ b/drivers/tee/optee/Makefile
> @@ -7,7 +7,8 @@ optee-objs +=3D supp.o
>  optee-objs +=3D device.o
> =20
>  optee-smc-abi-y =3D smc_abi.o
> -optee-objs +=3D $(optee-smc-abi-y)
> +optee-ffa-abi-$(CONFIG_ARM_FFA_TRANSPORT) =3D ffa_abi.o
> +optee-objs +=3D $(optee-smc-abi-y) $(optee-ffa-abi-y)
>

This may not work when CONFIG_ARM_FFA_TRANSPORT=3Dm, I don't have cleaner
solution apart from having if else.


[...]

> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_pr=
ivate.h
> index ca0213e330b5..2593742364da 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h

[...]

> @@ -116,11 +127,13 @@ struct optee_ops {
>   *			world
>   * @teedev:		client device
>   * @smc:		specific to SMC ABI
> + * @ffa:		specific to FF-A ABI
>   * @call_queue:		queue of threads waiting to call @invoke_fn
>   * @wait_queue:		queue of threads from secure world waiting for a
>   *			secure world sync object
>   * @supp:		supplicant synchronization struct for RPC to supplicant
>   * @pool:		shared memory pool
> + * @rpc_arg_count:	If > 0 number of RPC parameters to make room for
>   * @scan_bus_done	flag if device registation was already done.
>   * @scan_bus_wq		workqueue to scan optee bus and register optee drivers
>   * @scan_bus_work	workq to scan optee bus and register optee drivers
> @@ -129,11 +142,17 @@ struct optee {
>  	struct tee_device *supp_teedev;
>  	struct tee_device *teedev;
>  	const struct optee_ops *ops;
> -	struct optee_smc smc;
> +	union {
> +		struct optee_smc smc;
> +#ifdef CONFIG_ARM_FFA_TRANSPORT

I don't see a point in saving this especially that the definition is
available always. Also helps the case when FFA is module.

> +		struct optee_ffa ffa;
> +#endif
> +	};
>  	struct optee_call_queue call_queue;
>  	struct optee_wait_queue wait_queue;
>  	struct optee_supp supp;
>  	struct tee_shm_pool *pool;
> +	unsigned int rpc_arg_count;
>  	bool   scan_bus_done;
>  	struct workqueue_struct *scan_bus_wq;
>  	struct work_struct scan_bus_work;
> @@ -266,4 +285,12 @@ static inline void reg_pair_from_64(u32 *reg0, u32 *re=
g1, u64 val)
>  int optee_smc_abi_register(void);
>  void optee_smc_abi_unregister(void);
> =20
> +#ifdef CONFIG_ARM_FFA_TRANSPORT

To support CONFIG_ARM_FFA_TRANSPORT=3Dm this must be,

#if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)

--=20
Regards,
Sudeep

--===============4408862566883834733==--

