From: "Jork Loeser (he/him)" <Jork.Loeser@microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: libtomcrypt, AES-CTR: Missing counter-increment for
 non-crypto-accelerated archs?
Date: Fri, 24 Jan 2025 00:00:16 +0000
Message-ID: <IA1PR21MB4631A2F77D73A8AFC95395F0F1E32@IA1PR21MB4631.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5263652547492649361=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5263652547492649361==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

(Please provide a better way of reporting should this ML not be a good forum =
for bug-reports/fixes)

Hello all,

While experimenting with OP-TEE OS on a non-ARM platform (x86, to be precise)=
, I noticed xtest regression_4003 and regression_4017 to be failing. It appea=
rs that for AES-CTR encrypt/decrypt, optee_os/core/lib/libtomcrypt/src/modes/=
ctr/ctr_encrypt.c:s_ctr_encrypt()<https://github.com/OP-TEE/optee_os/blob/37d=
e1791d97d0df56db0709b5d001f821598df39/core/lib/libtomcrypt/src/modes/ctr/ctr_=
encrypt.c#L41> fails to increment the counter on block boundaries when passed=
 data covers a whole block. I suppose that it is a non-problem for architectu=
res having crypto acceleration hooked up, since ctr_encrypt() bypasses s_ctr_=
encrypt() in that case.

The below fixes the behavior for my setup - xtest regression_4003 and regress=
ion_4017 pass as a result:

diff --git a/core/lib/libtomcrypt/src/modes/ctr/ctr_encrypt.c b/core/lib/libt=
omcrypt/src/modes/ctr/ctr_encrypt.c
index a23e33c05..2019de2b6 100644
--- a/core/lib/libtomcrypt/src/modes/ctr/ctr_encrypt.c
+++ b/core/lib/libtomcrypt/src/modes/ctr/ctr_encrypt.c
@@ -61,6 +61,7 @@ static int s_ctr_encrypt(const unsigned char *pt, unsigned =
char *ct, unsigned lo
        ct         +=3D ctr->blocklen;
        len        -=3D ctr->blocklen;
        ctr->padlen =3D ctr->blocklen;
+       s_ctr_increment_counter(ctr);
        continue;
       }
#endif

I understand that you might prefer a full PR instead. Please accept my apolog=
ies for not providing such at this time; perhaps one of the maintainers (Jero=
me Forissier?) can take the above into consideration instead. If in doubt, co=
nsider above change as BSD-2-Clause'd.

Best,
Jork Loeser,
Microsoft


--===============5263652547492649361==--

