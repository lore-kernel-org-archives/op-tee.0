From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] hwrng: optee -: Use device-managed registration API
Date: Wed, 03 Feb 2021 17:47:57 +0530
Message-ID: 
 <CAFA6WYPveMszfhnK7_BXWivBaQdS6Fye_yW5gL9ax-qvpjfcdw@mail.gmail.com>
In-Reply-To: <1612344288-12201-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2299991063292866912=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2299991063292866912==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Feb 2021 at 14:55, Tian Tao <tiantao6@hisilicon.com> wrote:
>
> Use devm_hwrng_register to get rid of manual unregistration.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/char/hw_random/optee-rng.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>

Fix up subject line as s/hwrng: optee -:/hwrng: optee:/

With that fixed you can add:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/op=
tee-rng.c
> index a99d829..135a825 100644
> --- a/drivers/char/hw_random/optee-rng.c
> +++ b/drivers/char/hw_random/optee-rng.c
> @@ -243,7 +243,7 @@ static int optee_rng_probe(struct device *dev)
>         if (err)
>                 goto out_sess;
>
> -       err =3D hwrng_register(&pvt_data.optee_rng);
> +       err =3D devm_hwrng_register(dev, &pvt_data.optee_rng);
>         if (err) {
>                 dev_err(dev, "hwrng registration failed (%d)\n", err);
>                 goto out_sess;
> @@ -263,7 +263,6 @@ static int optee_rng_probe(struct device *dev)
>
>  static int optee_rng_remove(struct device *dev)
>  {
> -       hwrng_unregister(&pvt_data.optee_rng);
>         tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
>         tee_client_close_context(pvt_data.ctx);
>
> --
> 2.7.4
>

--===============2299991063292866912==--

