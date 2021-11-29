From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH -next v2] optee: Fix NULL but dereferenced coccicheck error
Date: Mon, 29 Nov 2021 09:54:07 +0100
Message-ID: 
 <CAHUa44F=QVxRN1k6-fX1Xw17+gwjBbOedWLKMAD5a6MjsWtBJw@mail.gmail.com>
In-Reply-To: <1637547650-4205-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4015982185779118643=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4015982185779118643==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, Nov 22, 2021 at 3:20 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Eliminate the following coccicheck warning:
> ./drivers/tee/optee/smc_abi.c:1508:12-15: ERROR: optee is NULL but
> dereferenced.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 'commit 6749e69c4dad ("optee: add asynchronous notifications")'
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>
> change in v2:
> --According to Jens's suggestion
> fixed as:
>         if (memremaped_shm)
>                 memunmap(memremaped_shm);
>
>  drivers/tee/optee/smc_abi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to https://git.linaro.org/people/jens.wiklander/linux-tee.git/
async_notif

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 92759d7..d7c8235 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1505,8 +1505,8 @@ static int optee_probe(struct platform_device *pdev)
>         kfree(optee);
>  err_free_pool:
>         tee_shm_pool_free(pool);
> -       if (optee->smc.memremaped_shm)
> -               memunmap(optee->smc.memremaped_shm);
> +       if (memremaped_shm)
> +               memunmap(memremaped_shm);
>         return rc;
>  }
>
> --
> 1.8.3.1
>

--===============4015982185779118643==--

