From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: fix format string for printing optee build_id
Date: Tue, 17 Dec 2024 22:06:02 +0100
Message-ID: 
 <CAHUa44Gs8T+hxkmVr2ap-HKB9QHkPB14-O2S6BvLrkEhP-Rw9Q@mail.gmail.com>
In-Reply-To: <20241129114648.3048941-1-sahil.malhotra@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1381270636961792612=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1381270636961792612==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sahil,

On Fri, Nov 29, 2024 at 12:46=E2=80=AFPM Sahil Malhotra <sahil.malhotra@nxp=
.com> wrote:
>
> There has been a recent change in OP-TEE to print 8 and 16 character
> commit id for 32bit and 64bit architecture respectively.
> In case if commit id is starting with 0 like 04d1c612ec7beaede073b8c
> it is printing revision as below removing leading 0
> "optee: revision 4.4 (4d1c612ec7beaed)"
>
> Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
> ---
>  drivers/tee/optee/smc_abi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

I'm picking up this.

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index e9456e3e74cc..eb51dc18f32d 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1272,8 +1272,9 @@ static void optee_msg_get_os_revision(optee_invoke_fn=
 *invoke_fn)
>                   &res.smccc);
>
>         if (res.result.build_id)
> -               pr_info("revision %lu.%lu (%08lx)", res.result.major,
> -                       res.result.minor, res.result.build_id);
> +               pr_info("revision %lu.%lu (%0*lx)", res.result.major,
> +                       res.result.minor, (int)sizeof(res.result.build_id) =
* 2,
> +                       res.result.build_id);
>         else
>                 pr_info("revision %lu.%lu", res.result.major, res.result.mi=
nor);
>  }
> --
> 2.34.1
>

--===============1381270636961792612==--

