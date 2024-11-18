From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v13 4/7] remoteproc: Introduce release_fw optional operation
Date: Mon, 18 Nov 2024 10:52:44 -0700
Message-ID: <Zzt+7NBdNjyzWZIb@p14s>
In-Reply-To: <20241104133515.256497-5-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0931206462201940089=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0931206462201940089==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 02:35:12PM +0100, Arnaud Pouliquen wrote:
> This patch updates the rproc_ops struct to include an optional
> release_fw function.
>=20
> The release_fw ops is responsible for releasing the remote processor
> firmware image. The ops is called in the following cases:
>=20
>  - An error occurs in rproc_start() between the loading of the segments and
>       the start of the remote processor.
>  - after stopping the remote processor.
>=20
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> Updates from version V11:
> - fix typo in @release_fw comment
> ---
>  drivers/remoteproc/remoteproc_core.c | 5 +++++
>  include/linux/remoteproc.h           | 3 +++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remo=
teproc_core.c
> index 7694817f25d4..46863e1ca307 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1258,6 +1258,9 @@ static int rproc_alloc_registered_carveouts(struct rp=
roc *rproc)
> =20
>  static void rproc_release_fw(struct rproc *rproc)
>  {
> +	if (rproc->ops->release_fw)
> +		rproc->ops->release_fw(rproc);
> +
>  	/* Free the copy of the resource table */
>  	kfree(rproc->cached_table);
>  	rproc->cached_table =3D NULL;
> @@ -1377,6 +1380,8 @@ static int rproc_start(struct rproc *rproc, const str=
uct firmware *fw)
>  unprepare_subdevices:
>  	rproc_unprepare_subdevices(rproc);
>  reset_table_ptr:
> +	if (rproc->ops->release_fw)
> +		rproc->ops->release_fw(rproc);
>  	rproc->table_ptr =3D rproc->cached_table;

I suggest the following:

1) Create two new functions, i.e rproc_load_fw() and rproc_release_fw().  The
only thing those would do is call rproc->ops->load_fw() and
rproc->ops->release_fw(), if they are present.  When a TEE interface is
available, ->load_fw() and ->release_fw() become rproc_tee_load_fw() and
rproc_tee_release_fw().

2) Call rproc_load_fw() in rproc_boot(), just before rproc_fw_boot().  If the
call to rproc_fw_boot() fails, call rproc_release_fw().

3) The same logic applies to rproc_boot_recovery(), i.e call rproc_load_fw()
before rproc_start() and call rproc_release_fw() if rproc_start() fails.

4) Take rproc_tee_load_fw() out of rproc_tee_parse_fw().  It will now be call=
ed
in rproc_load_fw().

5) As stated above function rproc_release_fw() now calls rproc_tee_release_fw=
().
The former is already called in rproc_shutdown() so we are good in that front.

With the above the cached_table management within the core remains the same a=
nd
we can get rid of patch 3.7.

Thanks,
Mathieu

> =20
>  	return ret;
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 2e0ddcb2d792..08e0187a84d9 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -381,6 +381,8 @@ enum rsc_handling_status {
>   * @panic:	optional callback to react to system panic, core will delay
>   *		panic at least the returned number of milliseconds
>   * @coredump:	  collect firmware dump after the subsystem is shutdown
> + * @release_fw:	optional function to release the firmware image from ROM m=
emories.
> + *		This function is called after stopping the remote processor or in case=
 of an error
>   */
>  struct rproc_ops {
>  	int (*prepare)(struct rproc *rproc);
> @@ -403,6 +405,7 @@ struct rproc_ops {
>  	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
>  	unsigned long (*panic)(struct rproc *rproc);
>  	void (*coredump)(struct rproc *rproc);
> +	void (*release_fw)(struct rproc *rproc);
>  };
> =20
>  /**
> --=20
> 2.25.1
>=20

--===============0931206462201940089==--

