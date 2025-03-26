From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Date: Wed, 26 Mar 2025 14:47:46 +0100
Message-ID: 
 <CAHUa44FUK_73oKSaqGdiPqB3geZbTNDFsC1Mh=KN3YPWr9=7gQ@mail.gmail.com>
In-Reply-To: <20250326110718.qzbwpmaf6xlcb4xf@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6438488147808718483=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6438488147808718483==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 12:07=E2=80=AFPM Marco Felsch <m.felsch@pengutronix=
.de> wrote:
>
> On 25-03-26, Matthew Wilcox wrote:
> > On Tue, Mar 25, 2025 at 09:07:39PM +0100, Marco Felsch wrote:
> > > Skip manipulating the refcount in case of slab pages according commit
> > > b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page").
> >
> > This almost certainly isn't right.  I know nothing about TEE, but that
> > you are doing this indicates a problem.  The hack that we put into
> > networking should not be blindly replicated.
> >
> > Why are you taking a reference on the pages to begin with?  Is it copy
> > and pasted from somewhere else, or was there actual thought put into it?
>
> Not sure, this belongs to the TEE maintainers.

I don't know. We were getting the user pages first, so I assume we
just did the same thing when we added support for kernel pages.

>
> > If it's "prevent the caller from freeing the allocation", well, it never
> > accomplished that with slab allocations.  So for callers that do kmalloc
> > (eg setup_mm_hdr()  in drivers/firmware/efi/stmm/tee_stmm_efi.c), you
> > have to rely on them not freeing the allocation while the TEE driver
> > has it.
> >
> > And if that's your API contract, then there's no point in taking
> > refcounts on other kinds of pages either; it's just unnecessary atomic
> > instructions.  So the right patch might be something like this:
> >
> > +++ b/drivers/tee/tee_shm.c
> > @@ -15,29 +15,11 @@
> >  #include <linux/highmem.h>
> >  #include "tee_private.h"
>
> I had the same diff but didn't went this way since we can't be sure that
> iov's are always slab backed. As far as I understood IOVs. In
> 'worst-case' scenario an iov can be backed by different page types too.

We're only using kvec's. Briefly, before commit 7bdee4157591 ("tee:
Use iov_iter to better support shared buffer registration") we checked
with is_vmalloc_addr() || is_kmap_addr(). I like Matthew's suggestion,
it's nice to fix problems by deleting code. :-)

Sumit, you know the callers better. What do you think?

Cheers,
Jens

>
> Regards,
>   Marco
>
> > -static void shm_put_kernel_pages(struct page **pages, size_t page_count)
> > -{
> > -       size_t n;
> > -
> > -       for (n =3D 0; n < page_count; n++)
> > -               put_page(pages[n]);
> > -}
> > -
> > -static void shm_get_kernel_pages(struct page **pages, size_t page_count)
> > -{
> > -       size_t n;
> > -
> > -       for (n =3D 0; n < page_count; n++)
> > -               get_page(pages[n]);
> > -}
> > -
> >  static void release_registered_pages(struct tee_shm *shm)
> >  {
> >         if (shm->pages) {
> >                 if (shm->flags & TEE_SHM_USER_MAPPED)
> >                         unpin_user_pages(shm->pages, shm->num_pages);
> > -               else
> > -                       shm_put_kernel_pages(shm->pages, shm->num_pages);
> >
> >                 kfree(shm->pages);
> >         }
> > @@ -321,13 +303,6 @@ register_shm_helper(struct tee_context *ctx, struct =
iov_iter *iter, u32 flags,
> >                 goto err_free_shm_pages;
> >         }
> >
> > -       /*
> > -        * iov_iter_extract_kvec_pages does not get reference on the page=
s,
> > -        * get a reference on them.
> > -        */
> > -       if (iov_iter_is_kvec(iter))
> > -               shm_get_kernel_pages(shm->pages, num_pages);
> > -
> >         shm->offset =3D off;
> >         shm->size =3D len;
> >         shm->num_pages =3D num_pages;
> > @@ -341,10 +316,8 @@ register_shm_helper(struct tee_context *ctx, struct =
iov_iter *iter, u32 flags,
> >
> >         return shm;
> >  err_put_shm_pages:
> > -       if (!iov_iter_is_kvec(iter))
> > +       if (iter_is_uvec(iter))
> >                 unpin_user_pages(shm->pages, shm->num_pages);
> > -       else
> > -               shm_put_kernel_pages(shm->pages, shm->num_pages);
> >  err_free_shm_pages:
> >         kfree(shm->pages);
> >  err_free_shm:
> >
> >

--===============6438488147808718483==--

