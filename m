From: Jerome Forissier <jerome.forissier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Date: Mon, 27 May 2024 15:00:41 +0200
Message-ID: <fc3bfebb-78b7-428e-8da5-5221f4921faa@linaro.org>
In-Reply-To: <20240527121340.3931987-5-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0935982464916229219=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0935982464916229219==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 5/27/24 14:13, Jens Wiklander wrote:
> Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe and
> use an RPMB device via the RPMB subsystem instead of passing the RPMB
> frames via tee-supplicant in user space. A fallback mechanism is kept to
> route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> available.
>=20
> The OP-TEE RPC ABI is extended to support iterating over all RPMB
> devices until one is found with the expected RPMB key already
> programmed.
>=20
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Tested-by: Manuel Traut <manut@mecka.net>
> ---
>  Documentation/ABI/testing/sysfs-class-tee |  15 ++
>  MAINTAINERS                               |   1 +
>  drivers/tee/optee/core.c                  |  96 +++++++++++-
>  drivers/tee/optee/device.c                |   7 +
>  drivers/tee/optee/ffa_abi.c               |  14 ++
>  drivers/tee/optee/optee_ffa.h             |   2 +
>  drivers/tee/optee/optee_private.h         |  26 +++-
>  drivers/tee/optee/optee_rpc_cmd.h         |  35 +++++
>  drivers/tee/optee/optee_smc.h             |   2 +
>  drivers/tee/optee/rpc.c                   | 177 ++++++++++++++++++++++
>  drivers/tee/optee/smc_abi.c               |  14 ++
>  11 files changed, 387 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-tee
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentation/ABI/=
testing/sysfs-class-tee
> new file mode 100644
> index 000000000000..c9144d16003e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-tee
> @@ -0,0 +1,15 @@
> +What:		/sys/class/tee/tee{,priv}X/rpmb_routing_model

Wouldn't /sys/class/tee/teeX/rpmb_routing_model be good enough?

Thanks,
--=20
Jerome

--===============0935982464916229219==--

