From: Matthew Wilcox <willy@infradead.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Date: Wed, 26 Mar 2025 10:54:32 +0000
Message-ID: <Z-Pc6C1YUqLyej3Z@casper.infradead.org>
In-Reply-To: <20250325200740.3645331-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5671223981093536935=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5671223981093536935==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 09:07:39PM +0100, Marco Felsch wrote:
> Skip manipulating the refcount in case of slab pages according commit
> b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page").

This almost certainly isn't right.  I know nothing about TEE, but that
you are doing this indicates a problem.  The hack that we put into
networking should not be blindly replicated.

Why are you taking a reference on the pages to begin with?  Is it copy
and pasted from somewhere else, or was there actual thought put into it?

If it's "prevent the caller from freeing the allocation", well, it never
accomplished that with slab allocations.  So for callers that do kmalloc
(eg setup_mm_hdr()  in drivers/firmware/efi/stmm/tee_stmm_efi.c), you
have to rely on them not freeing the allocation while the TEE driver
has it.

And if that's your API contract, then there's no point in taking
refcounts on other kinds of pages either; it's just unnecessary atomic
instructions.  So the right patch might be something like this:

+++ b/drivers/tee/tee_shm.c
@@ -15,29 +15,11 @@
 #include <linux/highmem.h>
 #include "tee_private.h"

-static void shm_put_kernel_pages(struct page **pages, size_t page_count)
-{
-       size_t n;
-
-       for (n =3D 0; n < page_count; n++)
-               put_page(pages[n]);
-}
-
-static void shm_get_kernel_pages(struct page **pages, size_t page_count)
-{
-       size_t n;
-
-       for (n =3D 0; n < page_count; n++)
-               get_page(pages[n]);
-}
-
 static void release_registered_pages(struct tee_shm *shm)
 {
        if (shm->pages) {
                if (shm->flags & TEE_SHM_USER_MAPPED)
                        unpin_user_pages(shm->pages, shm->num_pages);
-               else
-                       shm_put_kernel_pages(shm->pages, shm->num_pages);

                kfree(shm->pages);
        }
@@ -321,13 +303,6 @@ register_shm_helper(struct tee_context *ctx, struct iov_=
iter *iter, u32 flags,
                goto err_free_shm_pages;
        }

-       /*
-        * iov_iter_extract_kvec_pages does not get reference on the pages,
-        * get a reference on them.
-        */
-       if (iov_iter_is_kvec(iter))
-               shm_get_kernel_pages(shm->pages, num_pages);
-
        shm->offset =3D off;
        shm->size =3D len;
        shm->num_pages =3D num_pages;
@@ -341,10 +316,8 @@ register_shm_helper(struct tee_context *ctx, struct iov_=
iter *iter, u32 flags,

        return shm;
 err_put_shm_pages:
-       if (!iov_iter_is_kvec(iter))
+       if (iter_is_uvec(iter))
                unpin_user_pages(shm->pages, shm->num_pages);
-       else
-               shm_put_kernel_pages(shm->pages, shm->num_pages);
 err_free_shm_pages:
        kfree(shm->pages);
 err_free_shm:


--===============5671223981093536935==--

