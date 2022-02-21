From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3] tee: make tee_shm_register_kernel_buf vmalloc supported
Date: Mon, 21 Feb 2022 11:29:26 +0530
Message-ID: 
 <CAFA6WYMtxbJXh=WHLPg5gg7JMKUGy+NdKTh9Jb3RbNO97kjoDg@mail.gmail.com>
In-Reply-To: <20220218141004.16912-1-phil.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8077368102909603729=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8077368102909603729==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Feb 2022 at 19:40, Phil Chang <phil.chang@mediatek.com> wrote:
>
> In some low-memory devices, it's hard to aquire large-orders pages,
> this patch allowed user using scatter pages to register shm.
>
> Signed-off-by: Phil Chang <phil.chang@mediatek.com>
> ---
>
> Changelog
>         v2 -> v3: use the "n" variable to walk through "page_count"
>
>  drivers/tee/optee/call.c |  2 +-
>  drivers/tee/tee_shm.c    | 37 ++++++++++++++++++++++++++-----------
>  2 files changed, 27 insertions(+), 12 deletions(-)
>

Apart from minor nit below, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index bd49ec934060..2082e632adff 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -362,7 +362,7 @@ int optee_check_mem_type(unsigned long start, size_t nu=
m_pages)
>          * Allow kernel address to register with OP-TEE as kernel
>          * pages are configured as normal memory only.
>          */
> -       if (virt_addr_valid(start))
> +       if (virt_addr_valid(start) || is_vmalloc_addr((void *)start))
>                 return 0;
>
>         mmap_read_lock(mm);
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index f31e29e8f1ca..1412adad9397 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -23,21 +23,36 @@ static void shm_put_kernel_pages(struct page **pages, s=
ize_t page_count)
>  static int shm_get_kernel_pages(unsigned long start, size_t page_count,
>                                 struct page **pages)
>  {
> -       struct kvec *kiov;

> -       size_t n;
>         int rc;
> +       size_t n;

nit: this redundant change can be removed.

-Sumit

>
> -       kiov =3D kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> -       if (!kiov)
> -               return -ENOMEM;
> +       if (is_vmalloc_addr((void *)start)) {
> +               struct page *page;
>
> -       for (n =3D 0; n < page_count; n++) {
> -               kiov[n].iov_base =3D (void *)(start + n * PAGE_SIZE);
> -               kiov[n].iov_len =3D PAGE_SIZE;
> -       }
> +               for (n =3D 0; n < page_count; n++) {
> +                       page =3D vmalloc_to_page((void *)(start + PAGE_SIZE=
 * n));
> +                       if (!page)
> +                               return -ENOMEM;
> +
> +                       get_page(page);
> +                       pages[n] =3D page;
> +               }
> +               rc =3D page_count;
> +       } else {
> +               struct kvec *kiov;
>
> -       rc =3D get_kernel_pages(kiov, page_count, 0, pages);
> -       kfree(kiov);
> +               kiov =3D kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> +               if (!kiov)
> +                       return -ENOMEM;
> +
> +               for (n =3D 0; n < page_count; n++) {
> +                       kiov[n].iov_base =3D (void *)(start + n * PAGE_SIZE=
);
> +                       kiov[n].iov_len =3D PAGE_SIZE;
> +               }
> +
> +               rc =3D get_kernel_pages(kiov, page_count, 0, pages);
> +               kfree(kiov);
> +       }
>
>         return rc;
>  }
> --
> 2.25.1

--===============8077368102909603729==--

