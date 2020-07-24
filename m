From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCHv2 1/2] hwrng: optee: handle unlimited data rates
Date: Fri, 24 Jul 2020 18:54:07 +0530
Message-ID: 
 <CAFA6WYMCs-50WnwqqhefE9b_aXaORq1e3JdZJAjb04tHKvqP0A@mail.gmail.com>
In-Reply-To: <20200723084622.31134-1-jorge@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6647843035219668585=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6647843035219668585==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Jul 2020 at 14:16, Jorge Ramirez-Ortiz <jorge@foundries.io> wrot=
e:
>
> Data rates of MAX_UINT32 will schedule an unnecessary one jiffy
> timeout on the call to msleep. Avoid this scenario by using 0 as the
> unlimited data rate.
>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> ---
>  drivers/char/hw_random/optee-rng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Sounds good to me. FWIW:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/op=
tee-rng.c
> index 49b2e02537dd..5bc4700c4dae 100644
> --- a/drivers/char/hw_random/optee-rng.c
> +++ b/drivers/char/hw_random/optee-rng.c
> @@ -128,7 +128,7 @@ static int optee_rng_read(struct hwrng *rng, void *buf,=
 size_t max, bool wait)
>                 data +=3D rng_size;
>                 read +=3D rng_size;
>
> -               if (wait) {
> +               if (wait && pvt_data->data_rate) {
>                         if (timeout-- =3D=3D 0)
>                                 return read;
>                         msleep((1000 * (max - read)) / pvt_data->data_rate);
> --
> 2.17.1
>

--===============6647843035219668585==--

