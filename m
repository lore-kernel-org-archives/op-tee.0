From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCHv2 2/2] hwrng: optee: fix wait use case
Date: Wed, 05 Aug 2020 15:34:20 +0200
Message-ID: <20200805133420.GA8276@trex>
In-Reply-To: <20200723084622.31134-2-jorge@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8892514859294348744=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8892514859294348744==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 23/07/20, Jorge Ramirez-Ortiz wrote:
> The current code waits for data to be available before attempting a
> second read. However the second read would not be executed as the
> while loop exits.
>=20
> This fix does not wait if all data has been read and reads a second
> time if only partial data was retrieved on the first read.
>=20
> This fix also does not attempt to read if not data is requested.
>=20
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> ---
>  v2: tidy up the while loop to avoid reading when no data is requested
>=20
>  drivers/char/hw_random/optee-rng.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/op=
tee-rng.c
> index 5bc4700c4dae..a99d82949981 100644
> --- a/drivers/char/hw_random/optee-rng.c
> +++ b/drivers/char/hw_random/optee-rng.c
> @@ -122,14 +122,14 @@ static int optee_rng_read(struct hwrng *rng, void *bu=
f, size_t max, bool wait)
>  	if (max > MAX_ENTROPY_REQ_SZ)
>  		max =3D MAX_ENTROPY_REQ_SZ;
> =20
> -	while (read =3D=3D 0) {
> +	while (read < max) {
>  		rng_size =3D get_optee_rng_data(pvt_data, data, (max - read));
> =20
>  		data +=3D rng_size;
>  		read +=3D rng_size;
> =20
>  		if (wait && pvt_data->data_rate) {
> -			if (timeout-- =3D=3D 0)
> +			if ((timeout-- =3D=3D 0) || (read =3D=3D max))
>  				return read;
>  			msleep((1000 * (max - read)) / pvt_data->data_rate);
>  		} else {

any comments please?

--===============8892514859294348744==--

