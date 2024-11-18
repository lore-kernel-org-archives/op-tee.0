From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: tee-supplicant priority
Date: Mon, 18 Nov 2024 08:10:51 +0100
Message-ID: 
 <CAHUa44E_SVajXKUyj01OJcQkbUYRmE_8X3pNYEvgt5ySAiAMOA@mail.gmail.com>
In-Reply-To: <
 <CAAsLiDOH9PxL2HSopuY-FD8QosQT6E32ywhQtpY6SLqc6Af=Ag@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8046717040541320177=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8046717040541320177==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Matteo,

On Thu, Nov 14, 2024 at 2:19=E2=80=AFPM Matteo Facchinetti <facmatteo@gmail=
.com> wrote:
>
> Hi,
> I have a doubt about the correct priority that tee-supplicant should have
> in the system.
>
> In detail, we have 2 user-space applications (user-pkcs11-0, user-pkcs11-1)
> that use the same PKCS11 services from OPTEE-OS (access to RPDB partition
> for private key).
> For project reason we use the following nice priority values:
>
>      user-pkcs11-0, nice=3D-5
>      user-pkcs11-1, nice=3D-10
>      ....
>      tee-supplcant, nice=3D0
>      ...
>      a lot of other services with nice=3D0
>      ...
>
> Unfortunately, in some strange case when CPU is overload (booting)....
> appear a strange problem in user-pkcs11-1: occasionally the time for the
> certificate's signature check explode to 400ms.
>
> Due to the problem to replicate this defect, I have try to investigate in
> theory if could be verify a starvation/race-condition between
> tee-supplicant and user-pkcs11-1 or other-services.
> In this scenario, what is the correct priority value that tee-supplicant
> should have?
>
> I suspect that we should change the priority of tee-supplcant =3D
> user-pkcs11-1 =3D -10
> Is it make sense for you, or maybe better to search the problem from an
> other side :-) ?

There are more factors than the nice value to determine if a process
will get CPU time. However, processes with higher priority requesting
a service from tee-supplicant with lower priority might result in
priority inversion if the scheduler doesn't note the dependency.

You could try changing the nice value of the tee supplicant to see if
it makes a difference, but I suspect that someone else is requesting
RPMB service from the tee-supplicant. If one RPMB request is in
progress while another is being made, it's bound to result in a
noticeable delay.

Cheers,
Jens


>
> Thanks in advance for your attention
>
> BR
> Matteo Facchinetti

--===============8046717040541320177==--

