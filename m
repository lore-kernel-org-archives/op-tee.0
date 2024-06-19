From: Gabor Toth <Gabor.Toth2@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: BTI in OPTEE
Date: Wed, 19 Jun 2024 07:55:30 +0000
Message-ID: <VI1PR08MB101743EF22A248E4AB8820034A9CF2@VI1PR08MB10174.eurprd08.prod.outlook.com>
In-Reply-To: <
 <CAHUa44EjtUC05vm9U5+9eB=H5ZaZYxSZZia3b+MaMZb-=Y075Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2895781600855249320=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2895781600855249320==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Jens,

In this case the information whether pac/bti features are enabled will be pas=
sed to the SP via manifest, the same way as crc32 or passed and the SP can ac=
t depending
on this information.
Thank you for your answer!

Br,
G=C3=A1bor

-----Original Message-----
From: Jens Wiklander <jens.wiklander@linaro.org>=20
Sent: Monday, June 17, 2024 3:57 PM
To: Gabor Toth <Gabor.Toth2@arm.com>
Cc: op-tee(a)lists.trustedfirmware.org
Subject: Re: BTI in OPTEE

Hi Gabor,

On Mon, Jun 17, 2024 at 12:25=E2=80=AFPM Gabor Toth <Gabor.Toth2@arm.com> w=
rote:
>
> Hi Guys,
>
> I am working on enabling BTI (and PAC) in trusted-services and I have a que=
stion about the topic.
>
> If BTI is disabled in OPTEE, but someone tries to load an SP which was comp=
iled with BTI (contains the related gnu note property) it will be successful.
> This seems to be a security rish and I am thinking of either panicking  or =
at least sending an error message to remind the user that the requested prote=
ction will not be enabled.
>
> As I know there are common parts between TA-s and SP-s loaded by ldelf so I=
 am not sure whether panicking in this scenario will result in any problems o=
r not.
> What do you think of this proposal?

Couldn't this be dealt with entirely within the SP? I assume there's a way fo=
r an SP to test if BTI is enabled

> Do you know of any reasons why BTI protected SP-s should be loadable by BTI=
 disabled OPTEE?

BTI and PAC are another layer of protection, security can be maintained witho=
ut it. I assume that BTI and PAC are more important in some deployments than =
in others so from OP-TEE point of view we can't generally say which cause of =
action makes the most sense. If for some reason an SP absolutely must use the=
se security features, then I think the SP should test for that itself and pan=
ic or such if needed.

That said, the way that SPs are embedded inside the OP-TEE binary speaks for =
OP-TEE and SPs to always be in sync, including BTI and PAC.

Cheers,
Jens

--===============2895781600855249320==--

