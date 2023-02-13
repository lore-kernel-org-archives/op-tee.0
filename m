From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 3/4] tee: Remove call to get_kernel_pages()
Date: Mon, 13 Feb 2023 16:55:00 +0100
Message-ID: <Y+pdVMV5h6XaeCt2@jade>
In-Reply-To: <20230203-get_kernel_pages-v2-3-f1dc4af273f1@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7682292924030716183=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7682292924030716183==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 03, 2023 at 08:06:34PM -0800, Ira Weiny wrote:
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
> Because the pages can't be from highmem get_kernel_pages() boils down to
> a get_page() call.
>=20
> Remove the get_kernel_pages() call and open code the get_page().
>=20
> In case a highmem page does slip through warn on once for a kmap'ed
> address.
>=20
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>=20
> ---
> Changes from v1:
> 	Al/Christoph: Remove kiov altogether
> ---
>  drivers/tee/tee_shm.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)

Added to https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=3D=
get_kernel_pages-for-v6.4

Thanks,
Jens

>=20
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 527a6eabc03e..b1c6231defad 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -11,6 +11,7 @@
>  #include <linux/tee_drv.h>
>  #include <linux/uaccess.h>
>  #include <linux/uio.h>
> +#include <linux/highmem.h>
>  #include "tee_private.h"
> =20
>  static void shm_put_kernel_pages(struct page **pages, size_t page_count)
> @@ -24,26 +25,20 @@ static void shm_put_kernel_pages(struct page **pages, s=
ize_t page_count)
>  static int shm_get_kernel_pages(unsigned long start, size_t page_count,
>  				struct page **pages)
>  {
> -	struct kvec *kiov;
> +	struct page *page;
>  	size_t n;
> -	int rc;
> =20
> -	if (WARN_ON_ONCE(is_vmalloc_addr((void *)start)))
> +	if (WARN_ON_ONCE(is_vmalloc_addr((void *)start) ||
> +			 is_kmap_addr((void *)start)))
>  		return -EINVAL;
> =20
> -	kiov =3D kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> -	if (!kiov)
> -		return -ENOMEM;
> -
> +	page =3D virt_to_page(start);
>  	for (n =3D 0; n < page_count; n++) {
> -		kiov[n].iov_base =3D (void *)(start + n * PAGE_SIZE);
> -		kiov[n].iov_len =3D PAGE_SIZE;
> +		pages[n] =3D page + n;
> +		get_page(pages[n]);
>  	}
> =20
> -	rc =3D get_kernel_pages(kiov, page_count, 0, pages);
> -	kfree(kiov);
> -
> -	return rc;
> +	return page_count;
>  }
> =20
>  static void release_registered_pages(struct tee_shm *shm)
>=20
> --=20
> 2.39.1

--===============7682292924030716183==--

