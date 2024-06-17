From: Gabor Toth <Gabor.Toth2@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: BTI in OPTEE
Date: Mon, 17 Jun 2024 10:24:41 +0000
Message-ID: <VI1PR08MB101749C09F63F4CD472C3789FA9CD2@VI1PR08MB10174.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1258090780148601572=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1258090780148601572==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Guys,

I am working on enabling BTI (and PAC) in trusted-services and I have a quest=
ion about the topic.

If BTI is disabled in OPTEE, but someone tries to load an SP which was compil=
ed with BTI (contains the related gnu note property) it will be successful.
This seems to be a security rish and I am thinking of either panicking  or at=
 least sending an error message to remind the user that the requested protect=
ion will not be enabled.

As I know there are common parts between TA-s and SP-s loaded by ldelf so I a=
m not sure whether panicking in this scenario will result in any problems or =
not.
What do you think of this proposal?
Do you know of any reasons why BTI protected SP-s should be loadable by BTI d=
isabled OPTEE?

Thanks in advance!

G=C3=A1bor

--===============1258090780148601572==--

