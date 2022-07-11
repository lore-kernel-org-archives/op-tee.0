From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: Remove duplicate 'of' in two places.
Date: Mon, 11 Jul 2022 08:06:53 +0200
Message-ID: 
 <CAHUa44GLAJttfW+6m5O8ds=FRXAmOEWK5=rqe8+QOoLMskC=5g@mail.gmail.com>
In-Reply-To: <20220621161648.20117-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3357252520824162374=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3357252520824162374==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, Jun 21, 2022 at 6:18 PM Jiang Jian <jiangjian@cdjrlc.com> wrote:
>
> file: ./drivers/tee/optee/optee_smc.h
> line: 192
>  * a2   Size of of SHM
> chanegd to
>  * a2   Size of SHM
>
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/tee/optee/optee_smc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm picking up this.

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> index c60896cf71cb..73b5e7760d10 100644
> --- a/drivers/tee/optee/optee_smc.h
> +++ b/drivers/tee/optee/optee_smc.h
> @@ -189,7 +189,7 @@ struct optee_smc_call_get_os_revision_result {
>   * Have config return register usage:
>   * a0  OPTEE_SMC_RETURN_OK
>   * a1  Physical address of start of SHM
> - * a2  Size of of SHM
> + * a2  Size of SHM
>   * a3  Cache settings of memory, as defined by the
>   *     OPTEE_SMC_SHM_* values above
>   * a4-7        Preserved
> --
> 2.17.1
>

--===============3357252520824162374==--

