From: Marco Felsch <m.felsch@pengutronix.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Date: Wed, 26 Mar 2025 12:07:18 +0100
Message-ID: <20250326110718.qzbwpmaf6xlcb4xf@pengutronix.de>
In-Reply-To: <Z-Pc6C1YUqLyej3Z@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7912132695631320532=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7912132695631320532==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 25-03-26, Matthew Wilcox wrote:
> On Tue, Mar 25, 2025 at 09:07:39PM +0100, Marco Felsch wrote:
> > Skip manipulating the refcount in case of slab pages according commit
> > b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page").
>=20
> This almost certainly isn't right.  I know nothing about TEE, but that
> you are doing this indicates a problem.  The hack that we put into
> networking should not be blindly replicated.
>=20
> Why are you taking a reference on the pages to begin with?  Is it copy
> and pasted from somewhere else, or was there actual thought put into it?

Not sure, this belongs to the TEE maintainers.

> If it's "prevent the caller from freeing the allocation", well, it never
> accomplished that with slab allocations.  So for callers that do kmalloc
> (eg setup_mm_hdr()  in drivers/firmware/efi/stmm/tee_stmm_efi.c), you
> have to rely on them not freeing the allocation while the TEE driver
> has it.
>=20
> And if that's your API contract, then there's no point in taking
> refcounts on other kinds of pages either; it's just unnecessary atomic
> instructions.  So the right patch might be something like this:
>=20
> +++ b/drivers/tee/tee_shm.c
> @@ -15,29 +15,11 @@
>  #include <linux/highmem.h>
>  #include "tee_private.h"

I had the same diff but didn't went this way since we can't be sure that
iov's are always slab backed. As far as I understood IOVs. In
'worst-case' scenario an iov can be backed by different page types too.

Regards,
  Marco

> -static void shm_put_kernel_pages(struct page **pages, size_t page_count)
> -{
> -       size_t n;
> -
> -       for (n =3D 0; n < page_count; n++)
> -               put_page(pages[n]);
> -}
> -
> -static void shm_get_kernel_pages(struct page **pages, size_t page_count)
> -{
> -       size_t n;
> -
> -       for (n =3D 0; n < page_count; n++)
> -               get_page(pages[n]);
> -}
> -
>  static void release_registered_pages(struct tee_shm *shm)
>  {
>         if (shm->pages) {
>                 if (shm->flags & TEE_SHM_USER_MAPPED)
>                         unpin_user_pages(shm->pages, shm->num_pages);
> -               else
> -                       shm_put_kernel_pages(shm->pages, shm->num_pages);
>=20
>                 kfree(shm->pages);
>         }
> @@ -321,13 +303,6 @@ register_shm_helper(struct tee_context *ctx, struct io=
v_iter *iter, u32 flags,
>                 goto err_free_shm_pages;
>         }
>=20
> -       /*
> -        * iov_iter_extract_kvec_pages does not get reference on the pages,
> -        * get a reference on them.
> -        */
> -       if (iov_iter_is_kvec(iter))
> -               shm_get_kernel_pages(shm->pages, num_pages);
> -
>         shm->offset =3D off;
>         shm->size =3D len;
>         shm->num_pages =3D num_pages;
> @@ -341,10 +316,8 @@ register_shm_helper(struct tee_context *ctx, struct io=
v_iter *iter, u32 flags,
>=20
>         return shm;
>  err_put_shm_pages:
> -       if (!iov_iter_is_kvec(iter))
> +       if (iter_is_uvec(iter))
>                 unpin_user_pages(shm->pages, shm->num_pages);
> -       else
> -               shm_put_kernel_pages(shm->pages, shm->num_pages);
>  err_free_shm_pages:
>         kfree(shm->pages);
>  err_free_shm:
>=20
>=20

--===============7912132695631320532==--

