From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 0/2] small amdtee cleanups
Date: Mon, 28 Apr 2025 16:27:34 +0200
Message-ID: 
 <CAHUa44EczHYv0mNrMMbF-Vwc3jbOJqPy5sMsiW=0v2o1UaVfBw@mail.gmail.com>
In-Reply-To: <20250421152238.764659-1-superm1@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3074227967700084883=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3074227967700084883==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 21, 2025 at 5:22=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> I just noticed a few small things for amdtee where the error messages
> didn't consistently use the driver name.  While fixing that I noticed
> the headers weren't sorted.
>
> These patches fix both issues.
>
> Mario Limonciello (2):
>   tee: Use pr_fmt for messages
>   tee: Sort header includes
>
>  drivers/tee/amdtee/core.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

I'm trying to build this, but I run into some selinux build error. How
did you build this?

Cheers,
Jens

>
> --
> 2.43.0
>

--===============3074227967700084883==--

