From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
Date: Mon, 03 Oct 2022 12:27:07 +0530
Message-ID: 
 <CAFA6WYOGT1sJLA4c_B88NaXgxv4fm-idi5QMYvXdXB0acCF3sw@mail.gmail.com>
In-Reply-To: <20221002002326.946620-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5788969521003127111=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5788969521003127111==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

+ Phil

Hi Ira,

On Sun, 2 Oct 2022 at 05:53, <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> The kernel pages used by shm_get_kernel_pages() are allocated using
> GFP_KERNEL through the following call stack:
>
> trusted_instantiate()
>         trusted_payload_alloc() -> GFP_KERNEL
>         <trusted key op>
>                 tee_shm_register_kernel_buf()
>                         register_shm_helper()
>                                 shm_get_kernel_pages()
>
> Where <trusted key op> is one of:
>
>         trusted_key_unseal()
>         trusted_key_get_random()
>         trusted_key_seal()
>
> Remove the vmalloc page support from shm_get_kernel_pages().  Replace
> with a warn on once.
>
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Jens I went with the suggestion from Linus and Christoph and rejected
> vmalloc addresses.  I did not hear back from you regarding Linus'
> question if the vmalloc page support was required by an up coming patch
> set or not.  So I assumed it was something out of tree.

It looks like I wasn't CC'd to that conversation. IIRC, support for
vmalloc addresses was added recently by Phil here [1]. So I would like
to give him a chance if he is planning to post a corresponding kernel
driver upstream.

[1] https://lists.trustedfirmware.org/archives/list/op-tee(a)lists.trustedfir=
mware.org/thread/M7HI3P2M66V27SK35CGQRICZ7DJZ5J2W/

-Sumit

> ---
>  drivers/tee/tee_shm.c | 36 ++++++++++++------------------------
>  1 file changed, 12 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 27295bda3e0b..527a6eabc03e 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -24,37 +24,25 @@ static void shm_put_kernel_pages(struct page **pages, s=
ize_t page_count)
>  static int shm_get_kernel_pages(unsigned long start, size_t page_count,
>                                 struct page **pages)
>  {
> +       struct kvec *kiov;
>         size_t n;
>         int rc;
>
> -       if (is_vmalloc_addr((void *)start)) {
> -               struct page *page;
> -
> -               for (n =3D 0; n < page_count; n++) {
> -                       page =3D vmalloc_to_page((void *)(start + PAGE_SIZE=
 * n));
> -                       if (!page)
> -                               return -ENOMEM;
> -
> -                       get_page(page);
> -                       pages[n] =3D page;
> -               }
> -               rc =3D page_count;
> -       } else {
> -               struct kvec *kiov;
> -
> -               kiov =3D kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> -               if (!kiov)
> -                       return -ENOMEM;
> +       if (WARN_ON_ONCE(is_vmalloc_addr((void *)start)))
> +               return -EINVAL;
>
> -               for (n =3D 0; n < page_count; n++) {
> -                       kiov[n].iov_base =3D (void *)(start + n * PAGE_SIZE=
);
> -                       kiov[n].iov_len =3D PAGE_SIZE;
> -               }
> +       kiov =3D kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> +       if (!kiov)
> +               return -ENOMEM;
>
> -               rc =3D get_kernel_pages(kiov, page_count, 0, pages);
> -               kfree(kiov);
> +       for (n =3D 0; n < page_count; n++) {
> +               kiov[n].iov_base =3D (void *)(start + n * PAGE_SIZE);
> +               kiov[n].iov_len =3D PAGE_SIZE;
>         }
>
> +       rc =3D get_kernel_pages(kiov, page_count, 0, pages);
> +       kfree(kiov);
> +
>         return rc;
>  }
>
> --
> 2.37.2
>

--===============5788969521003127111==--

