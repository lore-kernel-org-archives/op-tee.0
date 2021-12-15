From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Fix incorrect page free bug
Date: Wed, 15 Dec 2021 16:29:08 +0100
Message-ID: 
 <CAHUa44Hqitcmj3=0FDOxsh0NytdpKyTEUUC2J8fcOmX9ZxQWsA@mail.gmail.com>
In-Reply-To: <20211215102011.3864647-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1830665101207992481=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1830665101207992481==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 15, 2021 at 11:20 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Pointer to the allocated pages (struct page *page) has already
> progressed towards the end of allocation. It is incorrect to perform
> __free_pages(page, order) using this pointer as we would free any
> arbitrary pages. Fix this by stop modifying the page pointer.
>
> Fixes: ec185dd3ab25 ("optee: Fix memory leak when failing to register shm p=
ages")
> Reported-by: Patrik Lantz <patrik.lantz@axis.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/optee/core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Looks good to me, but I think we should cc stable since that was done
in the patch fixed by this.

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index ab2edfcc6c70..2a66a5203d2f 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -48,10 +48,8 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool_mgr *=
poolm,
>                         goto err;
>                 }
>
> -               for (i =3D 0; i < nr_pages; i++) {
> -                       pages[i] =3D page;
> -                       page++;
> -               }
> +               for (i =3D 0; i < nr_pages; i++)
> +                       pages[i] =3D page + i;
>
>                 shm->flags |=3D TEE_SHM_REGISTER;
>                 rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
> --
> 2.25.1
>

--===============1830665101207992481==--

