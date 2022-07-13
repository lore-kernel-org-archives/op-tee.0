From: Olivier Deprez <Olivier.Deprez@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: OP-TEE BTI support
Date: Wed, 13 Jul 2022 13:20:34 +0000
Message-ID: <VE1PR08MB4976593CAB0239C2FE9E075C9B899@VE1PR08MB4976.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7000101009816845564=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7000101009816845564==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

(in context of testing BTI support when OP-TEE is loaded as a secure partitio=
n on top of SEL2/Hafnium)

I read through the OP-TEE documentation, and would like to confirm:
CFG_CORE_BTI=3Dy seems mandatorily required to support BTI in TAs. It means w=
e cannot enable independently BTI for TAs and 'disable' for TEE core, is this=
 correct?

Interestingly I noticed I can build with CFG_CORE_BTI=3Dn and CTG_TA_BTI=3Dy =
but I appreciate the end result is that the TA get BTI landpads but is not ef=
fectively leveraging the arch extension because code page aren't guarde if TE=
E core option isn't enabled.

I was investigating a way to omit building a specific toolchain as it appears=
 to be required when CFG_CORE_BTI=3Dy, but I'll go ahead if there's no way ro=
und.
Out of curiosity is OP-TEE core pulling gcc libraries? And if yes, which kind=
? I naively thought OP-TEE core would be freestanding or be independent from =
toolchain libs.

Thanks & Regards,
Olivier.

--===============7000101009816845564==--

