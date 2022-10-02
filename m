From: Ira Weiny <ira.weiny@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 3/4] tee: Remove call to get_kernel_pages()
Date: Sat, 01 Oct 2022 19:30:15 -0700
Message-ID: <Yzj3t6PDIFNPyI35@iweiny-mobl>
In-Reply-To: <YzjfcW6OGcPP075q@ZenIV>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8042993023795073324=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8042993023795073324==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 02, 2022 at 01:46:41AM +0100, Al Viro wrote:
> On Sat, Oct 01, 2022 at 05:23:25PM -0700, ira.weiny(a)intel.com wrote:
>=20
> >  	kiov =3D kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> > @@ -38,12 +39,12 @@ static int shm_get_kernel_pages(unsigned long start, =
size_t page_count,
> >  	for (n =3D 0; n < page_count; n++) {
> >  		kiov[n].iov_base =3D (void *)(start + n * PAGE_SIZE);
> >  		kiov[n].iov_len =3D PAGE_SIZE;
> > +		pages[n] =3D virt_to_page(kiov[n].iov_base);
> > +		get_page(pages[n]);
> >  	}
> > -
> > -	rc =3D get_kernel_pages(kiov, page_count, 0, pages);
> >  	kfree(kiov);
>=20
> IDGI.  The only thing in kiov[...] you are every reading is
> ->iov_base.  And you fetch it once, right after the assignment.

:-(  Good point.  Thanks for catching that.  I was too focused on just
replacing get_kernel_pages() with get_page() and I should have refactored
more.

>=20
> Why bother with allocating the array at all?
> 		pages[n] =3D virt_to_page((void *)start + n * PAGE_SIZE);
> would do just as well, not to mention the fact that since you reject
> vmalloc and kmap, you might simply do
>=20
> 	page =3D virt_to_page(start);
> 	for (int n =3D 0; n < page_count; n++)
> 		get_page(pages[n] =3D page + n);

I think I'd avoid the assignment in the parameter as I would miss that if I
came back and looked at this code later.

I'll get rid of the kiov in v2.

Sorry for not cleaning it up more and thanks for the review!

Ira

--===============8042993023795073324==--

