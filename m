From: Al Viro <viro@zeniv.linux.org.uk>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 3/4] tee: Remove call to get_kernel_pages()
Date: Sun, 02 Oct 2022 00:46:52 +0000
Message-ID: <YzjfcW6OGcPP075q@ZenIV>
In-Reply-To: <20221002002326.946620-4-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8809403048808885360=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8809403048808885360==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 01, 2022 at 05:23:25PM -0700, ira.weiny(a)intel.com wrote:

>  	kiov =3D kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> @@ -38,12 +39,12 @@ static int shm_get_kernel_pages(unsigned long start, si=
ze_t page_count,
>  	for (n =3D 0; n < page_count; n++) {
>  		kiov[n].iov_base =3D (void *)(start + n * PAGE_SIZE);
>  		kiov[n].iov_len =3D PAGE_SIZE;
> +		pages[n] =3D virt_to_page(kiov[n].iov_base);
> +		get_page(pages[n]);
>  	}
> -
> -	rc =3D get_kernel_pages(kiov, page_count, 0, pages);
>  	kfree(kiov);

IDGI.  The only thing in kiov[...] you are every reading is
->iov_base.  And you fetch it once, right after the assignment.

Why bother with allocating the array at all?
		pages[n] =3D virt_to_page((void *)start + n * PAGE_SIZE);
would do just as well, not to mention the fact that since you reject
vmalloc and kmap, you might simply do

	page =3D virt_to_page(start);
	for (int n =3D 0; n < page_count; n++)
		get_page(pages[n] =3D page + n);

instead...

--===============8809403048808885360==--

