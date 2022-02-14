From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH -next] tee: optee: fix error return code in probe function
Date: Mon, 14 Feb 2022 12:48:05 +0100
Message-ID: 
 <CAHUa44GPbzw_usSZcSqtZodaz6AKVbFGWjkDzJ3FiT5LMx8=KQ@mail.gmail.com>
In-Reply-To: <20220210091053.2045809-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8943629713981017673=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8943629713981017673==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, Feb 10, 2022 at 10:00 AM Yang Yingliang
<yangyingliang@huawei.com> wrote:
>
> If teedev_open() fails, probe function need return
> error code.
>
> Fixes: aceeafefff73 ("optee: use driver internal tee_context for some rpc")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/tee/optee/ffa_abi.c | 4 +++-
>  drivers/tee/optee/smc_abi.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)

Well spotted, I'm picking up this.

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index f2bf6c61197f..f744ab15bf2c 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -869,8 +869,10 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>         optee_supp_init(&optee->supp);
>         ffa_dev_set_drvdata(ffa_dev, optee);
>         ctx = teedev_open(optee->teedev);
> -       if (IS_ERR(ctx))
> +       if (IS_ERR(ctx)) {
> +               rc = PTR_ERR(ctx);
>                 goto err_rhashtable_free;
> +       }
>         optee->ctx = ctx;
>         rc = optee_notif_init(optee, OPTEE_DEFAULT_MAX_NOTIF_VALUE);
>         if (rc)
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 1a55339c7072..c517d310249f 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1417,8 +1417,10 @@ static int optee_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, optee);
>         ctx = teedev_open(optee->teedev);
> -       if (IS_ERR(ctx))
> +       if (IS_ERR(ctx)) {
> +               rc = PTR_ERR(ctx);
>                 goto err_supp_uninit;
> +       }
>         optee->ctx = ctx;
>         rc = optee_notif_init(optee, max_notif_value);
>         if (rc)
> --
> 2.25.1
>

--===============8943629713981017673==--

