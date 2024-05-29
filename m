From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Build failing with vexpress/juno+mbedtls
Date: Wed, 29 May 2024 09:45:05 +0200
Message-ID: 
 <CAHUa44GmQ8CLbHmFcG7Hq4R1k3UV0dbwGbkG5X1bKp2emJw6gA@mail.gmail.com>
In-Reply-To: <c0900527-4379-4801-a026-ffd99bd620f0@axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5766440446058149109=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5766440446058149109==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jacob,

On Wed, May 29, 2024 at 8:33=E2=80=AFAM Jacob Kroon <jacob.kroon@axis.com> =
wrote:
>
> Hi Jens,
>
> On 5/28/24 10:51, Jens Wiklander wrote:
> <cut>
> > Thanks for reporting the error. The fix looks easy, but I'm not sure
> > it's the right one. I think the problem is in
> > core/lib/libtomcrypt/aes_accel.c, if _CFG_CORE_LTC_CTR isn't y (or
> > LTC_CTR_MODE undefined) then I suppose that aes_ctr_encrypt_nblocks()
> > shouldn't be provided either.
> >
> > Anyway, patches are best sent as a github pull-request. Issues on
> > github tend to reach a broader audience, but there's nothing wrong
> > with discussing them here if you prefer that.
> >
>
> Ok, how about instead doing something along the lines of the patch below ?
>
> diff --git a/core/lib/libtomcrypt/aes_accel.c b/core/lib/libtomcrypt/aes_ac=
cel.c
> index 5b622e58a..cc667795a 100644
> --- a/core/lib/libtomcrypt/aes_accel.c
> +++ b/core/lib/libtomcrypt/aes_accel.c
> @@ -170,6 +170,7 @@ static int aes_cbc_decrypt_nblocks(const unsigned char =
*ct, unsigned char *pt,
>         return CRYPT_OK;
>  }
>
> +#ifdef LTC_CTR_MODE
>  static int aes_ctr_encrypt_nblocks(const unsigned char *pt, unsigned char =
*ct,
>                                    unsigned long blocks, unsigned char *IV,
>                                    int mode, symmetric_key *skey)
> @@ -189,6 +190,7 @@ static int aes_ctr_encrypt_nblocks(const unsigned char =
*pt, unsigned char *ct,
>
>         return CRYPT_OK;
>  }
> +#endif
>
>  static int aes_xts_encrypt_nblocks(const unsigned char *pt, unsigned char =
*ct,
>                                    unsigned long blocks, unsigned char *twe=
ak,
> @@ -245,7 +247,9 @@ const struct ltc_cipher_descriptor aes_desc =3D {
>         .accel_ecb_decrypt =3D aes_ecb_decrypt_nblocks,
>         .accel_cbc_encrypt =3D aes_cbc_encrypt_nblocks,
>         .accel_cbc_decrypt =3D aes_cbc_decrypt_nblocks,
> +#ifdef LTC_CTR_MODE
>         .accel_ctr_encrypt =3D aes_ctr_encrypt_nblocks,
> +#endif
>         .accel_xts_encrypt =3D aes_xts_encrypt_nblocks,
>         .accel_xts_decrypt =3D aes_xts_decrypt_nblocks,
>  };
>
>

Yes, it makes sense. Please submit a PR for further review.

Cheers,
Jens

--===============5766440446058149109==--

