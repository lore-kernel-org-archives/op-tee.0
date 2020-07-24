From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCHv2 2/2] hwrng: optee: fix wait use case
Date: Fri, 24 Jul 2020 18:52:07 +0530
Message-ID: 
 <CAFA6WYPQ3GGYostoHU=6qg4c_LqoqOZVbZ8gbQbGkNfyGydQjQ@mail.gmail.com>
In-Reply-To: <20200723084622.31134-2-jorge@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6964681430068101940=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6964681430068101940==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Jul 2020 at 14:16, Jorge Ramirez-Ortiz <jorge@foundries.io> wrot=
e:
>
> The current code waits for data to be available before attempting a
> second read. However the second read would not be executed as the
> while loop exits.
>
> This fix does not wait if all data has been read and reads a second
> time if only partial data was retrieved on the first read.
>
> This fix also does not attempt to read if not data is requested.

I am not sure how this is possible, can you elaborate?

>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> ---
>  v2: tidy up the while loop to avoid reading when no data is requested
>
>  drivers/char/hw_random/optee-rng.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/op=
tee-rng.c
> index 5bc4700c4dae..a99d82949981 100644
> --- a/drivers/char/hw_random/optee-rng.c
> +++ b/drivers/char/hw_random/optee-rng.c
> @@ -122,14 +122,14 @@ static int optee_rng_read(struct hwrng *rng, void *bu=
f, size_t max, bool wait)
>         if (max > MAX_ENTROPY_REQ_SZ)
>                 max =3D MAX_ENTROPY_REQ_SZ;
>
> -       while (read =3D=3D 0) {
> +       while (read < max) {
>                 rng_size =3D get_optee_rng_data(pvt_data, data, (max - read=
));
>
>                 data +=3D rng_size;
>                 read +=3D rng_size;
>
>                 if (wait && pvt_data->data_rate) {
> -                       if (timeout-- =3D=3D 0)
> +                       if ((timeout-- =3D=3D 0) || (read =3D=3D max))

If read =3D=3D max, would there be any sleep?

-Sumit

>                                 return read;
>                         msleep((1000 * (max - read)) / pvt_data->data_rate);
>                 } else {
> --
> 2.17.1
>

--===============6964681430068101940==--

