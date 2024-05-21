From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: SSH - OpTee reboot scenario Issue
Date: Tue, 21 May 2024 09:17:34 +0200
Message-ID: 
 <CAHUa44F5FwVrwBH017+wpNDb8GM9YeLh2WLoYVYDFUoP8BbFYw@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CSJ0PR22MB3755DA143EE0A88DAC4C5EB19DEE2=40SJ0PR22MB?=
 =?utf-8?q?3755=2Enamprd22=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5562968846454248974=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5562968846454248974==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 17, 2024 at 10:42=E2=80=AFAM Hareesh Das Ulleri
<hareesh.ulleri@ovt.com> wrote:
>
> Hello All,
>
> [please suggest the email list if this is not the right platform to discuss=
, sorry for that]
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

The OP-TEE kernel driver does something to prepare for shutdown. The
exception in the ssh client suggests it could be a user-space
integration issue. I assume the exception is triggered by an
unexpected return code from OP-TEE. Is it possible to do something
special when receiving that return code in order to avoid the
exception?

Cheers,
Jens

--===============5562968846454248974==--

