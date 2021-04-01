From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] OP-TEE tracepoints fix for v5.13
Date: Thu, 01 Apr 2021 14:32:54 +0200
Message-ID: 
 <CAHUa44Fdvhj2ca4O+CxD94YZ6BtzNut9HMn3FxDshh_vgHVwDA@mail.gmail.com>
In-Reply-To: <161727243793.583633.7984995735453542553.b4-ty@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4059567587835565988=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4059567587835565988==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 1, 2021 at 12:23 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> On Tue, 30 Mar 2021 10:22:08 +0200, Jens Wiklander wrote:
> > The previous pull request for OP-TEE tracepoints introduced a build
> > error when building whithout O=3D..., apparently many regression builds
> > uses that option.
> >
> > Please pull this small fix for the build error.
> >
> > Thanks,
> > Jens
> >
> > [...]
>
> You asked for this to be merged for 5.13, but as the change is clearly corr=
ect
> and required as a build fix, I added it as a fix for 5.12 instead, hope tha=
t's
> ok.
>
> Merged into arm/fixes, thanks!
>
> merge commit: 3e530f89d72dd1ab31e20d6f8567e357b928705c

OK. Please note that this pulls in 0101947dbcc3 ("tee: optee: add
invoke_fn tracepoints") (the commit just before actually) which I
believe was queued for v5.13.

Cheers,
Jens

--===============4059567587835565988==--

