From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 3/7] remoteproc: core: Add check on cached_table pointer
Date: Fri, 23 Feb 2024 11:32:47 -0700
Message-ID: <Zdjkz9bgaz+QkLg1@p14s>
In-Reply-To: <20240214172127.1022199-4-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2750560095066639337=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2750560095066639337==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 06:21:23PM +0100, Arnaud Pouliquen wrote:
> Add a check on the optional rproc->cached_table to perform the memory
> copy only if it is not null.
>=20
> 2 use cases to support:
> - starting on boot, in which case rproc->cached_table can be null,
> - starting on crash recovery, where the cached table is used to save
>   the resource table configuration on stop and re-apply the configuration
>   on the re-start.
>=20
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remo=
teproc_core.c
> index 283ca071e35c..34b0093689da 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1278,7 +1278,7 @@ static int rproc_start(struct rproc *rproc, const str=
uct firmware *fw)
>  	 * that any subsequent changes will be applied to the loaded version.
>  	 */
>  	loaded_table =3D rproc_find_loaded_rsc_table(rproc, fw);
> -	if (loaded_table) {
> +	if (loaded_table && rproc->cached_table) {

... and this becomes:

        if (loaded_table !=3D rproc->cached_table)

with a detailed comment about what is going on and a reference to
tee_rproc_parse_fw().

There are other things to adjust in this patchset but starting with that will
hopefully deal with a few of them.  We can address the rest at the next
iteration.

I am done reviewing this set.

Thanks,
Mathieu
>  		memcpy(loaded_table, rproc->cached_table, rproc->table_sz);
>  		rproc->table_ptr =3D loaded_table;
>  	}
> --=20
> 2.25.1
>=20

--===============2750560095066639337==--

