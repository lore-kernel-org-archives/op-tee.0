From: Christoph Hellwig <hch@infradead.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC PATCH 1/4] tee: Re-enable vmalloc page support for shared memory
Date: Fri, 26 May 2023 05:37:56 -0700
Message-ID: <ZHCoJEkVinvsB2lZ@infradead.org>
In-Reply-To: <18a8528d-7d9d-6ed0-0045-5ee47dd39fb2@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2913181997088458476=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2913181997088458476==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 04:01:14PM +0200, Arnaud POULIQUEN wrote:
> > As per the discussion back then: don't just blindly do the same dumb
> > thing again and fix the interfae to actually pass in a page array,
> > or iov_iter or an actually useful container that fits.
> >=20
>=20
> I suppose your are speaking about this discussion:
> https://lore.kernel.org/all/20221002002326.946620-3-ira.weiny(a)intel.com/

Yes.

>=20
> If I'm not mistaken, I should modify at tee_shm_register_kernel_buf API and
> register_shm_helper inernal function, right?
>=20

> What about having equivalent of shm_get_kernel_pages in an external helper =
(to
> defined where to put it), could it be an alternative of the upadate of the
> tee_shm API?

I think the fundamentally right thing is to pass an iov_iter to
register_shm_helper, and then use the new as of 6.3
iov_iter_extract_pages helper to extract the pages from that.  For
the kernel users you can then simply pass down an ITER_BVEC iter
that you can fill with vmalloc pages if you want.


--===============2913181997088458476==--

