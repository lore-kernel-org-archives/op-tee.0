From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 3/7] remoteproc: core: Refactor resource table cleanup
 into rproc_release_fw
Date: Wed, 11 Sep 2024 09:20:26 -0600
Message-ID: <ZuG1OiYO7YA+c81G@p14s>
In-Reply-To: <20240830095147.3538047-4-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2927118746052473081=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2927118746052473081==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 11:51:43AM +0200, Arnaud Pouliquen wrote:
> This patch centralizing the cleanup of the resource table into a new
> helper function rproc_release_fw().
>=20

Sure, but you did not explain _why_ the change is needed.

> Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remo=
teproc_core.c
> index ace11ea17097..7694817f25d4 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1256,6 +1256,13 @@ static int rproc_alloc_registered_carveouts(struct r=
proc *rproc)
>  	return 0;
>  }
> =20
> +static void rproc_release_fw(struct rproc *rproc)
> +{
> +	/* Free the copy of the resource table */
> +	kfree(rproc->cached_table);
> +	rproc->cached_table =3D NULL;
> +	rproc->table_ptr =3D NULL;
> +}
> =20
>  /**
>   * rproc_resource_cleanup() - clean up and free all acquired resources
> @@ -1485,9 +1492,7 @@ static int rproc_fw_boot(struct rproc *rproc, const s=
truct firmware *fw)
> =20
>  clean_up_resources:
>  	rproc_resource_cleanup(rproc);
> -	kfree(rproc->cached_table);
> -	rproc->cached_table =3D NULL;
> -	rproc->table_ptr =3D NULL;
> +	rproc_release_fw(rproc);
>  unprepare_rproc:
>  	/* release HW resources if needed */
>  	rproc_unprepare_device(rproc);
> @@ -2067,10 +2072,7 @@ int rproc_shutdown(struct rproc *rproc)
> =20
>  	rproc_disable_iommu(rproc);
> =20
> -	/* Free the copy of the resource table */
> -	kfree(rproc->cached_table);
> -	rproc->cached_table =3D NULL;
> -	rproc->table_ptr =3D NULL;
> +	rproc_release_fw(rproc);
>  out:
>  	mutex_unlock(&rproc->lock);
>  	return ret;
> @@ -2133,10 +2135,7 @@ int rproc_detach(struct rproc *rproc)
> =20
>  	rproc_disable_iommu(rproc);
> =20
> -	/* Free the copy of the resource table */
> -	kfree(rproc->cached_table);
> -	rproc->cached_table =3D NULL;
> -	rproc->table_ptr =3D NULL;
> +	rproc_release_fw(rproc);
>  out:
>  	mutex_unlock(&rproc->lock);
>  	return ret;
> --=20
> 2.25.1
>=20

--===============2927118746052473081==--

