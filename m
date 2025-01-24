From: "Jork Loeser (he/him)" <Jork.Loeser@microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: [EXTERNAL] Re: libtomcrypt, AES-CTR: Missing counter-increment
 for non-crypto-accelerated archs?
Date: Fri, 24 Jan 2025 18:32:30 +0000
Message-ID: <IA1PR21MB4631CE640BC06293C45E24CEF1E32@IA1PR21MB4631.namprd21.prod.outlook.com>
In-Reply-To: <
 <CA+NB=mb=fZ3_e38mb3fyF5jMv-PpmgCUsF_63Wi2XL9J4dFuUQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1876239428353997513=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1876239428353997513==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

LGTM, thanks!

Best,
Jork

From: J=C3=A9r=C3=B4me Forissier <jerome.forissier@linaro.org>
Sent: Friday, January 24, 2025 10:09
To: Jork Loeser (he/him) <Jork.Loeser@microsoft.com>
Cc: op-tee(a)lists.trustedfirmware.org
Subject: Re: [EXTERNAL] Re: libtomcrypt, AES-CTR: Missing counter-increment f=
or non-crypto-accelerated archs?

You're welcome. I have created https://github.com/OP-TEE/optee_os/pull/7243.

Regards,
--
Jerome

On Fri, 24 Jan 2025 at 18:57, Jork Loeser (he/him) <Jork.Loeser(a)microsoft.c=
om<mailto:Jork.Loeser@microsoft.com>> wrote:
That is quite excellent then, thank you for the tips & details! Appreciate th=
e credit ;-)

Best,
Jork Loeser,
Microsoft

From: J=C3=A9r=C3=B4me Forissier <jerome.forissier(a)linaro.org<mailto:jerome=
.forissier@linaro.org>>
Sent: Friday, January 24, 2025 02:17
To: Jork Loeser (he/him) <Jork.Loeser(a)microsoft.com<mailto:Jork.Loeser@mi=
crosoft.com>>
Cc: op-tee(a)lists.trustedfirmware.org<mailto:op-tee@lists.trustedfirmware.=
org>
Subject: [EXTERNAL] Re: libtomcrypt, AES-CTR: Missing counter-increment for n=
on-crypto-accelerated archs?

Hi Jork,

On Fri, 24 Jan 2025 at 01:00, Jork Loeser (he/him) via OP-TEE <op-tee(a)lists=
.trustedfirmware.org<mailto:op-tee@lists.trustedfirmware.org>> wrote:
(Please provide a better way of reporting should this ML not be a good forum =
for bug-reports/fixes)

The prefered place is on the OP-TEE OS GitHub issues section: https://github.=
com/OP-TEE/optee_os/issues, but this ML is OK too, unless the discussion invo=
lves a lot of code changes.

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

Yes, and even without acceleration the platforms we routinely build for (arm,=
 arm64) do not set LTC_FAST and therefore do not use the part of the code tha=
t has the problem.

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

This change looks totally correct to me, both in principle (given how CTR is =
supposed to work) and considering that the non-LTC_FAST part does call s_ctr_=
increment_counter() on a block boundary just a few lines below.

I understand that you might prefer a full PR instead. Please accept my apolog=
ies for not providing such at this time; perhaps one of the maintainers (Jero=
me Forissier?) can take the above into consideration instead. If in doubt, co=
nsider above change as BSD-2-Clause'd.

That's fine with me. I will create a PR. Let me know if I may credit you with=
 a "Reported-by: Your Name <your.email>" tag.

Many thanks for reporting!

--
Jerome Forissier
Linaro


Best,
Jork Loeser,
Microsoft

--===============1876239428353997513==--

