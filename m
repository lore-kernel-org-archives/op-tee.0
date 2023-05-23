From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] Fix uninitialized variable in OP-TEE driver for v6.3
Date: Tue, 23 May 2023 08:14:00 +0200
Message-ID: 
 <CAHUa44GOzp-w0vqxEqw8uVk95x+tM-H59gY0EyqjYB+H09a=LQ@mail.gmail.com>
In-Reply-To: <20230421075443.GA3136581@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2247742686887709826=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2247742686887709826==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 21, 2023 at 9:54=E2=80=AFAM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hello arm-soc maintainers,
>
> Please pull this small patch fixing an unintialized variable in the
> OP-TEE driver. The error has been reported recently by the kernel test
> robot.
>
> I realize that this is late for v6.3, please queue this for v6.4 instead
> if v6.3 isn't possible.

I noticed that this hasn't been merged yet. Perhaps it fell between
the cracks, or do you see an issue with it?

Thanks,
Jens

>
> Thanks,
> Jens
>
> The following changes since commit eeac8ede17557680855031c6f305ece2378af326:
>
>   Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-asy=
nc-notif-fix-for-v6.3
>
> for you to fetch changes up to 654d0310007146fae87b0c1a68f81e53ad519b14:
>
>   optee: fix uninited async notif value (2023-04-20 14:52:25 +0200)
>
> ----------------------------------------------------------------
> Fixes an uninitialized variable in OP-TEE driver
>
> ----------------------------------------------------------------
> Etienne Carriere (1):
>       optee: fix uninited async notif value
>
>  drivers/tee/optee/smc_abi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

--===============2247742686887709826==--

