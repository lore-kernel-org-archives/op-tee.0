From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: BTI in OPTEE
Date: Mon, 17 Jun 2024 15:57:25 +0200
Message-ID: 
 <CAHUa44EjtUC05vm9U5+9eB=H5ZaZYxSZZia3b+MaMZb-=Y075Q@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CVI1PR08MB101749C09F63F4CD472C3789FA9CD2=40VI1PR08M?=
 =?utf-8?q?B10174=2Eeurprd08=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8623457698702353539=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8623457698702353539==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

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

Couldn't this be dealt with entirely within the SP? I assume there's a
way for an SP to test if BTI is enabled

> Do you know of any reasons why BTI protected SP-s should be loadable by BTI=
 disabled OPTEE?

BTI and PAC are another layer of protection, security can be
maintained without it. I assume that BTI and PAC are more important in
some deployments than in others so from OP-TEE point of view we can't
generally say which cause of action makes the most sense. If for some
reason an SP absolutely must use these security features, then I think
the SP should test for that itself and panic or such if needed.

That said, the way that SPs are embedded inside the OP-TEE binary
speaks for OP-TEE and SPs to always be in sync, including BTI and PAC.

Cheers,
Jens

--===============8623457698702353539==--

