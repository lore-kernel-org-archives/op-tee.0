From: Daniel Thompson <daniel.thompson@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH linux-next] tee/optee/shm_pool: fix application of sizeof
 to pointer
Date: Thu, 02 Sep 2021 11:34:28 +0100
Message-ID: <20210902103428.bdbkybvi6he6mgy2@maple.lan>
In-Reply-To: <=?utf-8?q?=3Cc66fd6f831571b53b741350513e36405bba6c666=2E1629211?=
 =?utf-8?q?976=2Egit=2Ejing=2Eyangyang=40zte=2Ecom=2Ecn=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9063141111244748249=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9063141111244748249==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 19, 2021 at 08:21:27PM -0700, CGEL wrote:
> From: jing yangyang <jing.yangyang@zte.com.cn>
>=20
> sizeof when applied to a pointer typed expression gives the size of
> the pointer.
>=20
> ./drivers/tee/optee/shm_pool.c:38:28-34: ERROR application of sizeof to poi=
nter
>=20
> This issue was detected with the help of Coccinelle.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>

This should not affect code generation since both pages and *pages are
pointers but the change looks good to me.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/tee/optee/shm_pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
> index c41a9a5..d167039 100644
> --- a/drivers/tee/optee/shm_pool.c
> +++ b/drivers/tee/optee/shm_pool.c
> @@ -35,7 +35,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
>  		unsigned int nr_pages =3D 1 << order, i;
>  		struct page **pages;
> =20
> -		pages =3D kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
> +		pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
>  		if (!pages) {
>  			rc =3D -ENOMEM;
>  			goto err;
> --=20
> 1.8.3.1

--===============9063141111244748249==--

