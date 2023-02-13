From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 2/4] tee: Remove vmalloc page support
Date: Mon, 13 Feb 2023 16:54:23 +0100
Message-ID: <Y+pdL2g4k0Ek2iN+@jade>
In-Reply-To: <20230203-get_kernel_pages-v2-2-f1dc4af273f1@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8390433637785910080=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8390433637785910080==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 03, 2023 at 08:06:33PM -0800, Ira Weiny wrote:
> The kernel pages used by shm_get_kernel_pages() are allocated using
> GFP_KERNEL through the following call stack:
>=20
> trusted_instantiate()
> 	trusted_payload_alloc() -> GFP_KERNEL
> 	<trusted key op>
> 		tee_shm_register_kernel_buf()
> 			register_shm_helper()
> 				shm_get_kernel_pages()
>=20
> Where <trusted key op> is one of:
>=20
> 	trusted_key_unseal()
> 	trusted_key_get_random()
> 	trusted_key_seal()
>=20
> Remove the vmalloc page support from shm_get_kernel_pages().  Replace
> with a warn on once.
>=20
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/tee/tee_shm.c | 36 ++++++++++++------------------------
>  1 file changed, 12 insertions(+), 24 deletions(-)

Added to https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=3D=
get_kernel_pages-for-v6.4

Thanks,
Jens

>=20
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 27295bda3e0b..527a6eabc03e 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -24,37 +24,25 @@ static void shm_put_kernel_pages(struct page **pages, s=
ize_t page_count)
>  static int shm_get_kernel_pages(unsigned long start, size_t page_count,
>  				struct page **pages)
>  {
> +	struct kvec *kiov;
>  	size_t n;
>  	int rc;
> =20
> -	if (is_vmalloc_addr((void *)start)) {
> -		struct page *page;
> -
> -		for (n =3D 0; n < page_count; n++) {
> -			page =3D vmalloc_to_page((void *)(start + PAGE_SIZE * n));
> -			if (!page)
> -				return -ENOMEM;
> -
> -			get_page(page);
> -			pages[n] =3D page;
> -		}
> -		rc =3D page_count;
> -	} else {
> -		struct kvec *kiov;
> -
> -		kiov =3D kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> -		if (!kiov)
> -			return -ENOMEM;
> +	if (WARN_ON_ONCE(is_vmalloc_addr((void *)start)))
> +		return -EINVAL;
> =20
> -		for (n =3D 0; n < page_count; n++) {
> -			kiov[n].iov_base =3D (void *)(start + n * PAGE_SIZE);
> -			kiov[n].iov_len =3D PAGE_SIZE;
> -		}
> +	kiov =3D kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> +	if (!kiov)
> +		return -ENOMEM;
> =20
> -		rc =3D get_kernel_pages(kiov, page_count, 0, pages);
> -		kfree(kiov);
> +	for (n =3D 0; n < page_count; n++) {
> +		kiov[n].iov_base =3D (void *)(start + n * PAGE_SIZE);
> +		kiov[n].iov_len =3D PAGE_SIZE;
>  	}
> =20
> +	rc =3D get_kernel_pages(kiov, page_count, 0, pages);
> +	kfree(kiov);
> +
>  	return rc;
>  }
> =20
>=20
> --=20
> 2.39.1

--===============8390433637785910080==--

