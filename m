From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 4/7] remoteproc: core: Add TEE interface support for
 firmware release
Date: Thu, 12 Sep 2024 09:26:10 -0600
Message-ID: <ZuMIEp4cVrp1hWa7@p14s>
In-Reply-To: <20240830095147.3538047-5-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5467105155140992728=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5467105155140992728==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 11:51:44AM +0200, Arnaud Pouliquen wrote:
> Add support for releasing remote processor firmware through
> the Trusted Execution Environment (TEE) interface.
>=20
> The tee_rproc_release_fw() function is called in the following cases:
>=20
> - An error occurs in rproc_start() between the loading of the segments and
>   the start of the remote processor.
> - When rproc_release_fw is called on error or after stopping the remote
>   processor.
>=20
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remo=
teproc_core.c
> index 7694817f25d4..32052dedc149 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -29,6 +29,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/rculist.h>
>  #include <linux/remoteproc.h>
> +#include <linux/remoteproc_tee.h>
>  #include <linux/iommu.h>
>  #include <linux/idr.h>
>  #include <linux/elf.h>
> @@ -1258,6 +1259,9 @@ static int rproc_alloc_registered_carveouts(struct rp=
roc *rproc)
> =20
>  static void rproc_release_fw(struct rproc *rproc)
>  {
> +	if (rproc->state =3D=3D RPROC_OFFLINE && rproc->tee_interface)
> +		tee_rproc_release_fw(rproc);

Function tee_rproc_release_fw() returns a value that is ignored.  I don't know
how it passes the Sparse checker but I already see patches coming in my Inbox=
 to
deal with that.  In this case there is nothing else to do if there is an error
releasing the firware.  As such I would put a (void) in front and add a comme=
nt
about the return value being ignore on purpose.

> +
>  	/* Free the copy of the resource table */
>  	kfree(rproc->cached_table);
>  	rproc->cached_table =3D NULL;
> @@ -1348,7 +1352,7 @@ static int rproc_start(struct rproc *rproc, const str=
uct firmware *fw)
>  	if (ret) {
>  		dev_err(dev, "failed to prepare subdevices for %s: %d\n",
>  			rproc->name, ret);
> -		goto reset_table_ptr;
> +		goto release_fw;
>  	}
> =20
>  	/* power up the remote processor */
> @@ -1376,7 +1380,9 @@ static int rproc_start(struct rproc *rproc, const str=
uct firmware *fw)
>  	rproc->ops->stop(rproc);
>  unprepare_subdevices:
>  	rproc_unprepare_subdevices(rproc);
> -reset_table_ptr:
> +release_fw:
> +	if (rproc->tee_interface)
> +		tee_rproc_release_fw(rproc);

Same here.

>  	rproc->table_ptr =3D rproc->cached_table;
> =20
>  	return ret;
> --=20
> 2.25.1
>=20

--===============5467105155140992728==--

