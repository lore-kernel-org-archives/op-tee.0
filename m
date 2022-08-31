From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/9] tee: optee: Use ffa_dev->ops directly
Date: Wed, 31 Aug 2022 13:08:36 +0530
Message-ID: 
 <CAFA6WYPkDod+CU=31P5n-HQq9TQUukprKtRVZw4as4G7bQbaDQ@mail.gmail.com>
In-Reply-To: <20220830100700.344594-3-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7881992006551333940=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7881992006551333940==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 30 Aug 2022 at 15:38, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Now that the ffa_device structure holds the pointer to ffa_dev_ops,
> there is no need to obtain the same through ffa_dev_ops_get().
>
> Just use the ffa_dev->ops directly.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/tee/optee/ffa_abi.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 7ab31740cff8..4c3b5d0008dd 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -793,11 +793,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>         u32 sec_caps;
>         int rc;
>
> -       ffa_ops = ffa_dev_ops_get(ffa_dev);
> -       if (!ffa_ops) {
> -               pr_warn("failed \"method\" init: ffa\n");
> -               return -ENOENT;
> -       }
> +       ffa_ops = ffa_dev->ops;
>
>         if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
>                 return -EINVAL;
> --
> 2.37.2
>

--===============7881992006551333940==--

