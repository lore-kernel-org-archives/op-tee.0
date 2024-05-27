From: Jacob Kroon <Jacob.Kroon@axis.com>
To: op-tee@lists.trustedfirmware.org
Subject: Build failing with vexpress/juno+mbedtls
Date: Mon, 27 May 2024 12:59:24 +0000
Message-ID: <GV2PR02MB892060B39ABB345467DF5F908AF02@GV2PR02MB8920.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1551708000286933667=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1551708000286933667==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

When building master as of today with:

make PLATFORM=3Dvexpress PLATFORM_FLAVOR=3Djuno CFG_CRYPTOLIB_NAME=3Dmbedtls =
CFG_CRYPTOLIB_DIR=3Dlib/libmbedtls

I get the following build failure:

core/lib/libtomcrypt/aes_accel.c: In function =E2=80=98aes_ctr_encrypt_nblock=
s=E2=80=99:
core/lib/libtomcrypt/aes_accel.c:182:21: error: =E2=80=98CTR_COUNTER_LITTLE_E=
NDIAN=E2=80=99 undeclared (first use in this function)
  182 |         if (mode =3D=3D CTR_COUNTER_LITTLE_ENDIAN) {

I can fix the build with:

diff --git a/core/lib/libtomcrypt/src/headers/tomcrypt_cipher.h b/core/lib/li=
btomcrypt/src/headers/tomcrypt_cipher.h
index aa94698de..760aa70e1 100644
--- a/core/lib/libtomcrypt/src/headers/tomcrypt_cipher.h
+++ b/core/lib/libtomcrypt/src/headers/tomcrypt_cipher.h
@@ -925,12 +925,12 @@ int cbc_setiv(const unsigned char *IV, unsigned long le=
n, symmetric_CBC *cbc);
 int cbc_done(symmetric_CBC *cbc);
 #endif
=20
-#ifdef LTC_CTR_MODE
-
 #define CTR_COUNTER_LITTLE_ENDIAN    0x0000
 #define CTR_COUNTER_BIG_ENDIAN       0x1000
 #define LTC_CTR_RFC3686              0x2000
=20
+#ifdef LTC_CTR_MODE
+
 int ctr_start(               int   cipher,
               const unsigned char *IV,
               const unsigned char *key,       int keylen,

------------------

Does this look like a proper fix ? If so, can I send patches to the mailing l=
ist, or do I need to go via a github pull-request ?

Regards
Jacob

--===============1551708000286933667==--

