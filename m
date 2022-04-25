From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] hwrng: optee-rng: remove redundant initialization to
 variable rng_size
Date: Mon, 25 Apr 2022 11:22:19 +0530
Message-ID: 
 <CAFA6WYMeOv160_mnEHVN9GgN1tqN9Zt0GqnGQRgP4m8V-aztTQ@mail.gmail.com>
In-Reply-To: <20220424181156.1364446-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2155274313331772170=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2155274313331772170==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 24 Apr 2022 at 23:41, Colin Ian King <colin.i.king@gmail.com> wrote:
>
> Variable rng_size is being initialized with a value that is never read,
> the variable is being re-assigned later on. The initialization is
> redundant and can be removed.
>
> Cleans up cppcheck warning:
> Variable 'rng_size' is assigned a value that is never used.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/char/hw_random/optee-rng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/op=
tee-rng.c
> index a948c0727b2b..96b5d546d136 100644
> --- a/drivers/char/hw_random/optee-rng.c
> +++ b/drivers/char/hw_random/optee-rng.c
> @@ -115,7 +115,7 @@ static size_t get_optee_rng_data(struct optee_rng_priva=
te *pvt_data,
>  static int optee_rng_read(struct hwrng *rng, void *buf, size_t max, bool w=
ait)
>  {
>         struct optee_rng_private *pvt_data =3D to_optee_rng_private(rng);
> -       size_t read =3D 0, rng_size =3D 0;
> +       size_t read =3D 0, rng_size;
>         int timeout =3D 1;
>         u8 *data =3D buf;
>
> --
> 2.35.1
>

--===============2155274313331772170==--

