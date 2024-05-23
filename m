From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: SSH - OpTee reboot scenario Issue
Date: Thu, 23 May 2024 10:32:14 +0200
Message-ID: 
 <CAHUa44H=25d+_YzydNMQHLGcb-gzQrP9Ow80ZpZ-dr0rC4rDXw@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CSJ0PR22MB375592D7CDBB16A594A03D2F9DEA2=40SJ0PR22MB?=
 =?utf-8?q?3755=2Enamprd22=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8701603207995827476=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8701603207995827476==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 21, 2024 at 10:08=E2=80=AFAM Hareesh Das Ulleri
<hareesh.ulleri@ovt.com> wrote:
>
> Hi,
>
>  Thanks for the reply.
>
>  In this scenario, userspace lib triggers a series of OP-TEE lib calls (Ini=
t, TEEC_OpenSession,  TA_CRYPT_CMD_PREPARE, TA_CRYPT_CMD_SET_KEY ... ) one by=
 one based on previous call's response return code. Shutdown request can happ=
en middle of any of the above calls and what I see is TEE function return cod=
e is SUCESSS even after system shutdown request. So here I can't take any act=
ion based on the return code !

That is strange. It would make more sense to return some error code in
this scenario. Can you find where an error should have been returned
instead of OK? I suspect there's a struct somewhere where an error
code isn't written in this case.

Cheers,
Jens

>
> Regards,
> Hareesh
>
> -----Original Message-----
> From: Jens Wiklander <jens.wiklander@linaro.org>
> Sent: Tuesday, May 21, 2024 3:18 PM
> To: Hareesh Das Ulleri <hareesh.ulleri@ovt.com>
> Cc: op-tee(a)lists.trustedfirmware.org
> Subject: Re: SSH - OpTee reboot scenario Issue
>
> [CAUTION]: EXTERNAL EMAIL
>
>
> Hi,
>
> On Fri, May 17, 2024 at 10:42=E2=80=AFAM Hareesh Das Ulleri <hareesh.ulleri=
@ovt.com> wrote:
> >
> > Hello All,
> >
> > [please suggest the email list if this is not the right platform to
> > discuss, sorry for that]
> >
> > We use Op-tee (3.18) in our ARM64 based project (Linux 5.15.14+) for cryp=
tion, so basically it is like " OpenSSH -> OpenSSL -> OpTee -> HSM". It works=
 fine until we tried with a test scenario of reboot request via SSH.
> >
> > When we request the system reboot via SSH, the shutting down looks not a =
graceful way (ssh client connection exception). This is only we add OpTee lay=
er, otherwise everything works fine. I would like to know anyone has encounte=
red similar kind of issue where OpTee has to take care any special shutting d=
own process. Any leads much appreciated !
>
> The OP-TEE kernel driver does something to prepare for shutdown. The except=
ion in the ssh client suggests it could be a user-space integration issue. I =
assume the exception is triggered by an unexpected return code from OP-TEE. I=
s it possible to do something special when receiving that return code in orde=
r to avoid the exception?
>
> Cheers,
> Jens

--===============8701603207995827476==--

