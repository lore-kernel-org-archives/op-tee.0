From: John Hubbard <jhubbard@nvidia.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 4/4] mm: Remove get_kernel_pages()
Date: Mon, 03 Oct 2022 13:28:56 -0700
Message-ID: <dd67e7c5-a2e1-40a9-335d-c35aa6e32955@nvidia.com>
In-Reply-To: <20221002002326.946620-5-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7907438661585029372=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7907438661585029372==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 10/1/22 17:23, ira.weiny(a)intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
>=20
> The only caller to get_kernel_pages() [shm_get_kernel_pages()] has been
> updated to not need it.
>=20
> Remove get_kernel_pages().
>=20
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>   include/linux/mm.h |  2 --
>   mm/swap.c          | 30 ------------------------------
>   2 files changed, 32 deletions(-)
>=20

Good to see this removed (including the EXPORT), even if the
functionality still remains in a less obvious form, over in shm.

The fewer "all your page are pinned" calls we need, the simpler things
get. :)


Acked-by: John Hubbard <jhubbard@nvidia.com>

thanks,
--=20
John Hubbard
NVIDIA

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8bbcccbc5565..9a06df4f057c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1969,8 +1969,6 @@ int __account_locked_vm(struct mm_struct *mm, unsigne=
d long pages, bool inc,
>   			struct task_struct *task, bool bypass_rlim);
>  =20
>   struct kvec;
> -int get_kernel_pages(const struct kvec *iov, int nr_pages, int write,
> -			struct page **pages);
>   struct page *get_dump_page(unsigned long addr);
>  =20
>   bool folio_mark_dirty(struct folio *folio);
> diff --git a/mm/swap.c b/mm/swap.c
> index 955930f41d20..a9aa648eb0d0 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -157,36 +157,6 @@ void put_pages_list(struct list_head *pages)
>   }
>   EXPORT_SYMBOL(put_pages_list);
>  =20
> -/*
> - * get_kernel_pages() - pin kernel pages in memory
> - * @kiov:	An array of struct kvec structures
> - * @nr_segs:	number of segments to pin
> - * @write:	pinning for read/write, currently ignored
> - * @pages:	array that receives pointers to the pages pinned.
> - *		Should be at least nr_segs long.
> - *
> - * Returns number of pages pinned. This may be fewer than the number reque=
sted.
> - * If nr_segs is 0 or negative, returns 0.  If no pages were pinned, retur=
ns 0.
> - * Each page returned must be released with a put_page() call when it is
> - * finished with.
> - */
> -int get_kernel_pages(const struct kvec *kiov, int nr_segs, int write,
> -		struct page **pages)
> -{
> -	int seg;
> -
> -	for (seg =3D 0; seg < nr_segs; seg++) {
> -		if (WARN_ON(kiov[seg].iov_len !=3D PAGE_SIZE))
> -			return seg;
> -
> -		pages[seg] =3D kmap_to_page(kiov[seg].iov_base);
> -		get_page(pages[seg]);
> -	}
> -
> -	return seg;
> -}
> -EXPORT_SYMBOL_GPL(get_kernel_pages);
> -
>   typedef void (*move_fn_t)(struct lruvec *lruvec, struct folio *folio);
>  =20
>   static void lru_add_fn(struct lruvec *lruvec, struct folio *folio)



--===============7907438661585029372==--

