From: Hareesh Das Ulleri <hareesh.ulleri@ovt.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: SSH - OpTee reboot scenario Issue
Date: Tue, 21 May 2024 08:08:23 +0000
Message-ID: <SJ0PR22MB375592D7CDBB16A594A03D2F9DEA2@SJ0PR22MB3755.namprd22.prod.outlook.com>
In-Reply-To: <
 <CAHUa44F5FwVrwBH017+wpNDb8GM9YeLh2WLoYVYDFUoP8BbFYw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0966804945345087952=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0966804945345087952==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

 Thanks for the reply.

 In this scenario, userspace lib triggers a series of OP-TEE lib calls (Init,=
 TEEC_OpenSession,  TA_CRYPT_CMD_PREPARE, TA_CRYPT_CMD_SET_KEY ... ) one by o=
ne based on previous call's response return code. Shutdown request can happen=
 middle of any of the above calls and what I see is TEE function return code =
is SUCESSS even after system shutdown request. So here I can't take any actio=
n based on the return code !

Regards,
Hareesh

-----Original Message-----
From: Jens Wiklander <jens.wiklander@linaro.org>=20
Sent: Tuesday, May 21, 2024 3:18 PM
To: Hareesh Das Ulleri <hareesh.ulleri@ovt.com>
Cc: op-tee(a)lists.trustedfirmware.org
Subject: Re: SSH - OpTee reboot scenario Issue

[CAUTION]: EXTERNAL EMAIL


Hi,

On Fri, May 17, 2024 at 10:42=E2=80=AFAM Hareesh Das Ulleri <hareesh.ulleri(a=
)ovt.com> wrote:
>
> Hello All,
>
> [please suggest the email list if this is not the right platform to=20
> discuss, sorry for that]
>
> We use Op-tee (3.18) in our ARM64 based project (Linux 5.15.14+) for crypti=
on, so basically it is like " OpenSSH -> OpenSSL -> OpTee -> HSM". It works f=
ine until we tried with a test scenario of reboot request via SSH.
>
> When we request the system reboot via SSH, the shutting down looks not a gr=
aceful way (ssh client connection exception). This is only we add OpTee layer=
, otherwise everything works fine. I would like to know anyone has encountere=
d similar kind of issue where OpTee has to take care any special shutting dow=
n process. Any leads much appreciated !

The OP-TEE kernel driver does something to prepare for shutdown. The exceptio=
n in the ssh client suggests it could be a user-space integration issue. I as=
sume the exception is triggered by an unexpected return code from OP-TEE. Is =
it possible to do something special when receiving that return code in order =
to avoid the exception?

Cheers,
Jens

--===============0966804945345087952==--

