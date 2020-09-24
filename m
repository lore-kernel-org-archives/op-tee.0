From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH -next] tee: optee: fix type warning of sizeof in pool_op_alloc()
Date: Thu, 24 Sep 2020 09:33:21 +0200
Message-ID: 
 <CAHUa44GmCC0-WLjGJJN8-mWyHdRxS84+2hi1vUG1zKx3=t09RQ@mail.gmail.com>
In-Reply-To: <20200917081356.2083345-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3857914232916274100=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3857914232916274100==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, Sep 17, 2020 at 9:52 AM Liu Shixin <liushixin2@huawei.com> wrote:
>
> sizeof() when applied to a pointer typed expression should gives the
> size of the pointed data, even if the data is a pointer.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/tee/optee/shm_pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
> index d767eebf30bd..9fdc667b5df0 100644
> --- a/drivers/tee/optee/shm_pool.c
> +++ b/drivers/tee/optee/shm_pool.c
> @@ -31,7 +31,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
>                 unsigned int nr_pages = 1 << order, i;
>                 struct page **pages;
>
> -               pages = kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
> +               pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);

In this case we want an array of pointers as you also can see in the
type of "pages".

Thanks,
Jens

>                 if (!pages)
>                         return -ENOMEM;
>
> --
> 2.25.1
>

--===============3857914232916274100==--

