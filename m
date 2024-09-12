From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 6/7] remoteproc: stm32: Create sub-functions to request
 shutdown and release
Date: Thu, 12 Sep 2024 09:41:23 -0600
Message-ID: <ZuMLo2+an1sxdYlt@p14s>
In-Reply-To: <20240830095147.3538047-7-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6592606213228569197=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6592606213228569197==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 11:51:46AM +0200, Arnaud Pouliquen wrote:
> To prepare for the support of TEE remoteproc, create sub-functions
> that can be used in both cases, with and without remoteproc TEE support.
>=20
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/remoteproc/stm32_rproc.c | 84 +++++++++++++++++++-------------
>  1 file changed, 51 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rp=
roc.c
> index 8c7f7950b80e..79c638936163 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -209,6 +209,54 @@ static int stm32_rproc_mbox_idx(struct rproc *rproc, c=
onst unsigned char *name)
>  	return -EINVAL;
>  }
> =20
> +static void stm32_rproc_request_shutdown(struct rproc *rproc)
> +{
> +	struct stm32_rproc *ddata =3D rproc->priv;
> +	int err, dummy_data, idx;
> +
> +	/* Request shutdown of the remote processor */
> +	if (rproc->state !=3D RPROC_OFFLINE && rproc->state !=3D RPROC_CRASHED) {
> +		idx =3D stm32_rproc_mbox_idx(rproc, STM32_MBX_SHUTDOWN);
> +		if (idx >=3D 0 && ddata->mb[idx].chan) {
> +			/* A dummy data is sent to allow to block on transmit. */
> +			err =3D mbox_send_message(ddata->mb[idx].chan,
> +						&dummy_data);

When refactoring functions, please do not change the inner code.  Here
@dummy_data was introduced.  Making changes, even small ones, makes it really
hard to review your work.  I'm pretty sure we talked about that before.

> +			if (err < 0)
> +				dev_warn(&rproc->dev, "warning: remote FW shutdown without ack\n");
> +		}
> +	}
> +}
> +
> +static int stm32_rproc_release(struct rproc *rproc)
> +{
> +	struct stm32_rproc *ddata =3D rproc->priv;
> +	unsigned int err =3D 0;
> +
> +	/* To allow platform Standby power mode, set remote proc Deep Sleep. */
> +	if (ddata->pdds.map) {
> +		err =3D regmap_update_bits(ddata->pdds.map, ddata->pdds.reg,
> +					 ddata->pdds.mask, 1);
> +		if (err) {
> +			dev_err(&rproc->dev, "failed to set pdds\n");
> +			return err;
> +		}
> +	}
> +
> +	/* Update coprocessor state to OFF if available. */
> +	if (ddata->m4_state.map) {
> +		err =3D regmap_update_bits(ddata->m4_state.map,
> +					 ddata->m4_state.reg,
> +					 ddata->m4_state.mask,
> +					 M4_STATE_OFF);
> +		if (err) {
> +			dev_err(&rproc->dev, "failed to set copro state\n");
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int stm32_rproc_prepare(struct rproc *rproc)
>  {
>  	struct device *dev =3D rproc->dev.parent;
> @@ -519,17 +567,9 @@ static int stm32_rproc_detach(struct rproc *rproc)
>  static int stm32_rproc_stop(struct rproc *rproc)
>  {
>  	struct stm32_rproc *ddata =3D rproc->priv;
> -	int err, idx;
> +	int err;
> =20
> -	/* request shutdown of the remote processor */
> -	if (rproc->state !=3D RPROC_OFFLINE && rproc->state !=3D RPROC_CRASHED) {
> -		idx =3D stm32_rproc_mbox_idx(rproc, STM32_MBX_SHUTDOWN);
> -		if (idx >=3D 0 && ddata->mb[idx].chan) {
> -			err =3D mbox_send_message(ddata->mb[idx].chan, "detach");
> -			if (err < 0)
> -				dev_warn(&rproc->dev, "warning: remote FW shutdown without ack\n");
> -		}
> -	}
> +	stm32_rproc_request_shutdown(rproc);
> =20
>  	err =3D stm32_rproc_set_hold_boot(rproc, true);
>  	if (err)
> @@ -541,29 +581,7 @@ static int stm32_rproc_stop(struct rproc *rproc)
>  		return err;
>  	}
> =20
> -	/* to allow platform Standby power mode, set remote proc Deep Sleep */
> -	if (ddata->pdds.map) {
> -		err =3D regmap_update_bits(ddata->pdds.map, ddata->pdds.reg,
> -					 ddata->pdds.mask, 1);
> -		if (err) {
> -			dev_err(&rproc->dev, "failed to set pdds\n");
> -			return err;
> -		}
> -	}
> -
> -	/* update coprocessor state to OFF if available */
> -	if (ddata->m4_state.map) {
> -		err =3D regmap_update_bits(ddata->m4_state.map,
> -					 ddata->m4_state.reg,
> -					 ddata->m4_state.mask,
> -					 M4_STATE_OFF);
> -		if (err) {
> -			dev_err(&rproc->dev, "failed to set copro state\n");
> -			return err;
> -		}
> -	}
> -
> -	return 0;
> +	return stm32_rproc_release(rproc);
>  }
> =20
>  static void stm32_rproc_kick(struct rproc *rproc, int vqid)
> --=20
> 2.25.1
>=20

--===============6592606213228569197==--

