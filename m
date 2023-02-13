From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 1/4] highmem: Enhance is_kmap_addr() to check
 kmap_local_page() mappings
Date: Mon, 13 Feb 2023 16:53:28 +0100
Message-ID: <Y+pc+AZ22Tflnpuk@jade>
In-Reply-To: <20230203-get_kernel_pages-v2-1-f1dc4af273f1@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0695938714777693341=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0695938714777693341==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 03, 2023 at 08:06:32PM -0800, Ira Weiny wrote:
> is_kmap_addr() is only looking at the kmap() address range which may
> cause check_heap_object() to miss checking an overflow on a
> kmap_local_page() page.
>=20
> Add a check for the kmap_local_page() address range to is_kmap_addr().
>=20
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  include/linux/highmem-internal.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20

Added to https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=3D=
get_kernel_pages-for-v6.4

Thanks,
Jens

> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-inter=
nal.h
> index e098f38422af..a3028e400a9c 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -152,7 +152,10 @@ static inline void totalhigh_pages_add(long count)
>  static inline bool is_kmap_addr(const void *x)
>  {
>  	unsigned long addr =3D (unsigned long)x;
> -	return addr >=3D PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP);
> +
> +	return (addr >=3D PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP)) ||
> +		(addr >=3D __fix_to_virt(FIX_KMAP_END) &&
> +		 addr < __fix_to_virt(FIX_KMAP_BEGIN));
>  }
>  #else /* CONFIG_HIGHMEM */
> =20
>=20
> --=20
> 2.39.1

--===============0695938714777693341==--

