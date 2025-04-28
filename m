From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Date: Mon, 28 Apr 2025 14:48:15 +0200
Message-ID: 
 <CAHUa44HEsMkzQHZZufdwutQyZRtig6e0qWomhwgDZAhy2qDyhg@mail.gmail.com>
In-Reply-To: <Z-TXMIXzaro0w60M@sumit-X1>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6049024387104786837=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6049024387104786837==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 5:42=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Wed, Mar 26, 2025 at 02:47:46PM +0100, Jens Wiklander wrote:
> > On Wed, Mar 26, 2025 at 12:07=E2=80=AFPM Marco Felsch <m.felsch@pengutr=
onix.de> wrote:
> > >
> > > On 25-03-26, Matthew Wilcox wrote:
> > > > On Tue, Mar 25, 2025 at 09:07:39PM +0100, Marco Felsch wrote:
> > > > > Skip manipulating the refcount in case of slab pages according comm=
it
> > > > > b9c0e49abfca ("mm: decline to manipulate the refcount on a slab pag=
e").
> > > >
> > > > This almost certainly isn't right.  I know nothing about TEE, but that
> > > > you are doing this indicates a problem.  The hack that we put into
> > > > networking should not be blindly replicated.
> > > >
> > > > Why are you taking a reference on the pages to begin with?  Is it copy
> > > > and pasted from somewhere else, or was there actual thought put into =
it?
> > >
> > > Not sure, this belongs to the TEE maintainers.
> >
> > I don't know. We were getting the user pages first, so I assume we
> > just did the same thing when we added support for kernel pages.
> >
> > >
> > > > If it's "prevent the caller from freeing the allocation", well, it ne=
ver
> > > > accomplished that with slab allocations.  So for callers that do kmal=
loc
> > > > (eg setup_mm_hdr()  in drivers/firmware/efi/stmm/tee_stmm_efi.c), you
> > > > have to rely on them not freeing the allocation while the TEE driver
> > > > has it.
>
> It's not just about the TEE driver but rather if the TEE implementation
> (a trusted OS) to whom the page is registered with. We don't want the
> trusted OS to work on registered kernel pages if they gets free somehow
> in the TEE client driver. Having a reference in the TEE subsystem
> assured us that won't happen. But if you say slab allocations are still
> prone the kernel pages getting freed even after refcount then can you
> suggest how should we handle this better?
>
> As otherwise it can cause very hard to debug problems if trusted OS can
> manipulate kernel pages that are no longer available.

We must be able to rely on the kernel callers to have the needed
references before calling tee_shm_register_kernel_buf() and to keep
those until after calling tee_shm_free().


>
> > > >
> > > > And if that's your API contract, then there's no point in taking
> > > > refcounts on other kinds of pages either; it's just unnecessary atomic
> > > > instructions.  So the right patch might be something like this:
> > > >
> > > > +++ b/drivers/tee/tee_shm.c
> > > > @@ -15,29 +15,11 @@
> > > >  #include <linux/highmem.h>
> > > >  #include "tee_private.h"
> > >
> > > I had the same diff but didn't went this way since we can't be sure that
> > > iov's are always slab backed. As far as I understood IOVs. In
> > > 'worst-case' scenario an iov can be backed by different page types too.
> >
> > We're only using kvec's. Briefly, before commit 7bdee4157591 ("tee:
> > Use iov_iter to better support shared buffer registration") we checked
> > with is_vmalloc_addr() || is_kmap_addr(). I like Matthew's suggestion,
> > it's nice to fix problems by deleting code. :-)
> >
> > Sumit, you know the callers better. What do you think?
>
> If we don't have a sane way to refcont registered kernel pages in TEE
> subsystem then yeah we have to solely rely on the client drivers to
> behave properly. Nevertheless, it's still within the kernel boundaries
> which we can rely upon.

Yes.

Cheers,
Jens

--===============6049024387104786837==--

