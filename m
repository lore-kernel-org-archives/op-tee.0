From: Arnd Bergmann <arnd@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] OP-TEE tracepoints fix for v5.13
Date: Thu, 01 Apr 2021 16:32:11 +0200
Message-ID: 
 <CAK8P3a1eKs+xkO0JVT38iUn2PJf5KQh0gQ2SuiLeRpMUSmgUrQ@mail.gmail.com>
In-Reply-To: <
 <CAHUa44Fdvhj2ca4O+CxD94YZ6BtzNut9HMn3FxDshh_vgHVwDA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1659994487803802449=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1659994487803802449==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 1, 2021 at 2:32 PM Jens Wiklander <jens.wiklander@linaro.org> w=
rote:
> On Thu, Apr 1, 2021 at 12:23 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > merge commit: 3e530f89d72dd1ab31e20d6f8567e357b928705c
>
> OK. Please note that this pulls in 0101947dbcc3 ("tee: optee: add
> invoke_fn tracepoints") (the commit just before actually) which I
> believe was queued for v5.13.

Of course, that explains it. I'll take it out of the fixes branch again then
and apply it on top of the original merge in the drivers branch instead.

Thanks for the clarification!

         Arnd

--===============1659994487803802449==--

