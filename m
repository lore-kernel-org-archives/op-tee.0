From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 4/7] remoteproc: core: Add TEE interface support for
 firmware release
Date: Wed, 18 Sep 2024 16:43:32 +0200
Message-ID: <fabec69a-3b3a-4068-8906-7996cf125c0b@foss.st.com>
In-Reply-To: <20240830095147.3538047-5-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8111771529129929054=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8111771529129929054==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Mathieu,

On 8/30/24 11:51, Arnaud Pouliquen wrote:
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

I'm requesting you expertise to fix an issue I'm facing during my test prepar=
ing
the V10.

My issue is that here, we can call the tee_rproc_release_fw() function, defin=
ed
in remoteproc_tee built as a remoteproc_tee.ko module.

I tried to use the IS_ENABLED and IS_REACHABLE macros in remoteproc_tee.h, but
without success:
- use IS_ENABLED() results in a link error: "undefined reference to
tee_rproc_release_fw."
- use IS_REACHABLE() returns false and remoteproc_core calls the inline
tee_rproc_release_fw function that just call WARN_ON(1).

To solve the issue, I can see three alternatives:

1) Modify Kconfig and remoteproc_tee.c to support only built-in.
2) Use symbol_get/symbol_put.
3) Define a new rproc_ops->release_fw operation that will be initialized to
tee_rproc_release_fw.

From my perspective, the solution 3 seems to be the cleanest way, as it also
removes the dependency between remoteproc_core.c and remoteproc_tee.c. But
regarding previous discussion/series version, it seems that it could not be y=
our
preferred solution.

Please, could you indicate your preference so that I can directly implement t=
he
best solution (or perhaps you have another alternative to propose)?

Thanks in advance!

Arnaud


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
>  	rproc->table_ptr =3D rproc->cached_table;
> =20
>  	return ret;

--===============8111771529129929054==--

