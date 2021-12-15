From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Fix incorrect page free bug
Date: Wed, 15 Dec 2021 09:32:31 -0600
Message-ID: <20211215153231.GA217403@sequoia>
In-Reply-To: <20211215102011.3864647-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4977212957938998176=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4977212957938998176==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 2021-12-15 15:50:11, Sumit Garg wrote:
> Pointer to the allocated pages (struct page *page) has already
> progressed towards the end of allocation. It is incorrect to perform
> __free_pages(page, order) using this pointer as we would free any
> arbitrary pages. Fix this by stop modifying the page pointer.
>=20
> Fixes: ec185dd3ab25 ("optee: Fix memory leak when failing to register shm p=
ages")
> Reported-by: Patrik Lantz <patrik.lantz@axis.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Thanks for fixing this!

Tyler

> ---
>  drivers/tee/optee/core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index ab2edfcc6c70..2a66a5203d2f 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -48,10 +48,8 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool_mgr *=
poolm,
>  			goto err;
>  		}
> =20
> -		for (i =3D 0; i < nr_pages; i++) {
> -			pages[i] =3D page;
> -			page++;
> -		}
> +		for (i =3D 0; i < nr_pages; i++)
> +			pages[i] =3D page + i;
> =20
>  		shm->flags |=3D TEE_SHM_REGISTER;
>  		rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
> --=20
> 2.25.1
>=20

--===============4977212957938998176==--

