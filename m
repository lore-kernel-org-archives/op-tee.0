From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Build failing with vexpress/juno+mbedtls
Date: Tue, 28 May 2024 10:51:35 +0200
Message-ID: 
 <CAHUa44HbPScOx36cOrb9BzUiqc+Maw7EhHMD5oWqDEFNa7qy2A@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CGV2PR02MB892060B39ABB345467DF5F908AF02=40GV2PR02MB?=
 =?utf-8?q?8920=2Eeurprd02=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8202704875807480275=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8202704875807480275==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jacob,


On Mon, May 27, 2024 at 2:59=E2=80=AFPM Jacob Kroon <Jacob.Kroon@axis.com> =
wrote:
>
> Hi,
>
> When building master as of today with:
>
> make PLATFORM=3Dvexpress PLATFORM_FLAVOR=3Djuno CFG_CRYPTOLIB_NAME=3Dmbedtl=
s CFG_CRYPTOLIB_DIR=3Dlib/libmbedtls
>
> I get the following build failure:
>
> core/lib/libtomcrypt/aes_accel.c: In function =E2=80=98aes_ctr_encrypt_nblo=
cks=E2=80=99:
> core/lib/libtomcrypt/aes_accel.c:182:21: error: =E2=80=98CTR_COUNTER_LITTLE=
_ENDIAN=E2=80=99 undeclared (first use in this function)
>   182 |         if (mode =3D=3D CTR_COUNTER_LITTLE_ENDIAN) {
>
> I can fix the build with:
>
> diff --git a/core/lib/libtomcrypt/src/headers/tomcrypt_cipher.h b/core/lib/=
libtomcrypt/src/headers/tomcrypt_cipher.h
> index aa94698de..760aa70e1 100644
> --- a/core/lib/libtomcrypt/src/headers/tomcrypt_cipher.h
> +++ b/core/lib/libtomcrypt/src/headers/tomcrypt_cipher.h
> @@ -925,12 +925,12 @@ int cbc_setiv(const unsigned char *IV, unsigned long =
len, symmetric_CBC *cbc);
>  int cbc_done(symmetric_CBC *cbc);
>  #endif
>
> -#ifdef LTC_CTR_MODE
> -
>  #define CTR_COUNTER_LITTLE_ENDIAN    0x0000
>  #define CTR_COUNTER_BIG_ENDIAN       0x1000
>  #define LTC_CTR_RFC3686              0x2000
>
> +#ifdef LTC_CTR_MODE
> +
>  int ctr_start(               int   cipher,
>                const unsigned char *IV,
>                const unsigned char *key,       int keylen,
>
> ------------------
>
> Does this look like a proper fix ? If so, can I send patches to the mailing=
 list, or do I need to go via a github pull-request ?

Thanks for reporting the error. The fix looks easy, but I'm not sure
it's the right one. I think the problem is in
core/lib/libtomcrypt/aes_accel.c, if _CFG_CORE_LTC_CTR isn't y (or
LTC_CTR_MODE undefined) then I suppose that aes_ctr_encrypt_nblocks()
shouldn't be provided either.

Anyway, patches are best sent as a github pull-request. Issues on
github tend to reach a broader audience, but there's nothing wrong
with discussing them here if you prefer that.

Cheers,
Jens

--===============8202704875807480275==--

