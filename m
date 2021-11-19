From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH -next] optee: Fix NULL but dereferenced coccicheck error
Date: Fri, 19 Nov 2021 13:04:28 +0100
Message-ID: 
 <CAHUa44EPVSQSMr78om6SXG3B+UEQ-J6qUnLJs_ZqswTAbTv2+Q@mail.gmail.com>
In-Reply-To: <1637309143-53528-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0454921545756104215=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0454921545756104215==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, Nov 19, 2021 at 9:05 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Eliminate the following coccicheck warning:
> ./drivers/tee/optee/smc_abi.c:1508:12-15: ERROR: optee is NULL but
> dereferenced.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 'commit 6749e69c4dad ("optee: add asynchronous notifications")'
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/tee/optee/smc_abi.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 92759d7..1f471ff 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1505,8 +1505,6 @@ static int optee_probe(struct platform_device *pdev)
>         kfree(optee);
>  err_free_pool:
>         tee_shm_pool_free(pool);
> -       if (optee->smc.memremaped_shm)
> -               memunmap(optee->smc.memremaped_shm);

Thanks for reporting. This should rather be fixed as:
        if (memremaped_shm)
                memunmap(memremaped_shm);

Cheers,
Jens

>         return rc;
>  }
>
> --
> 1.8.3.1
>

--===============0454921545756104215==--

