From: Jacob Kroon <jacob.kroon@axis.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Build failing with vexpress/juno+mbedtls
Date: Wed, 29 May 2024 08:33:04 +0200
Message-ID: <c0900527-4379-4801-a026-ffd99bd620f0@axis.com>
In-Reply-To: <
 <CAHUa44HbPScOx36cOrb9BzUiqc+Maw7EhHMD5oWqDEFNa7qy2A@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7939153677853339149=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7939153677853339149==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On 5/28/24 10:51, Jens Wiklander wrote:
<cut>
> Thanks for reporting the error. The fix looks easy, but I'm not sure
> it's the right one. I think the problem is in
> core/lib/libtomcrypt/aes_accel.c, if _CFG_CORE_LTC_CTR isn't y (or
> LTC_CTR_MODE undefined) then I suppose that aes_ctr_encrypt_nblocks()
> shouldn't be provided either.
>=20
> Anyway, patches are best sent as a github pull-request. Issues on
> github tend to reach a broader audience, but there's nothing wrong
> with discussing them here if you prefer that.
>=20

Ok, how about instead doing something along the lines of the patch below ?

diff --git a/core/lib/libtomcrypt/aes_accel.c b/core/lib/libtomcrypt/aes_acce=
l.c
index 5b622e58a..cc667795a 100644
--- a/core/lib/libtomcrypt/aes_accel.c
+++ b/core/lib/libtomcrypt/aes_accel.c
@@ -170,6 +170,7 @@ static int aes_cbc_decrypt_nblocks(const unsigned char *c=
t, unsigned char *pt,
        return CRYPT_OK;
 }
=20
+#ifdef LTC_CTR_MODE
 static int aes_ctr_encrypt_nblocks(const unsigned char *pt, unsigned char *c=
t,
                                   unsigned long blocks, unsigned char *IV,
                                   int mode, symmetric_key *skey)
@@ -189,6 +190,7 @@ static int aes_ctr_encrypt_nblocks(const unsigned char *p=
t, unsigned char *ct,
=20
        return CRYPT_OK;
 }
+#endif
=20
 static int aes_xts_encrypt_nblocks(const unsigned char *pt, unsigned char *c=
t,
                                   unsigned long blocks, unsigned char *tweak,
@@ -245,7 +247,9 @@ const struct ltc_cipher_descriptor aes_desc =3D {
        .accel_ecb_decrypt =3D aes_ecb_decrypt_nblocks,
        .accel_cbc_encrypt =3D aes_cbc_encrypt_nblocks,
        .accel_cbc_decrypt =3D aes_cbc_decrypt_nblocks,
+#ifdef LTC_CTR_MODE
        .accel_ctr_encrypt =3D aes_ctr_encrypt_nblocks,
+#endif
        .accel_xts_encrypt =3D aes_xts_encrypt_nblocks,
        .accel_xts_decrypt =3D aes_xts_decrypt_nblocks,
 };


Regards
Jacob

--===============7939153677853339149==--

