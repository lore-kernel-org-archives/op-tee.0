From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: make tee_shm_register_kernel_buf vmalloc supported
Date: Wed, 16 Feb 2022 08:44:39 +0100
Message-ID: 
 <CAHUa44HynmNkNdzxu0R0NALLja86jT2WGEVcz0rCYfpxt=bjdw@mail.gmail.com>
In-Reply-To: <20220213162110.27210-1-phil.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3064350269909303300=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3064350269909303300==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 13, 2022 at 5:21 PM Phil Chang <phil.chang@mediatek.com> wrote:
>
> In some low-memory devices, it's hard to aquire large-orders pages,
> this patch allowed user using scatter pages to register shm.
>
> Signed-off-by: Phil Chang <phil.chang@mediatek.com>
> ---
>  drivers/tee/optee/call.c |  2 +-
>  drivers/tee/tee_shm.c    | 40 ++++++++++++++++++++++++++++------------
>  2 files changed, 29 insertions(+), 13 deletions(-)
>
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
> index f31e29e8f1ca..861403588485 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -23,22 +23,38 @@ static void shm_put_kernel_pages(struct page **pages, s=
ize_t page_count)
>  static int shm_get_kernel_pages(unsigned long start, size_t page_count,
>                                 struct page **pages)
>  {
> -       struct kvec *kiov;
> -       size_t n;
>         int rc;
>
> -       kiov =3D kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> -       if (!kiov)
> -               return -ENOMEM;
> -
> -       for (n =3D 0; n < page_count; n++) {
> -               kiov[n].iov_base =3D (void *)(start + n * PAGE_SIZE);
> -               kiov[n].iov_len =3D PAGE_SIZE;
> +       if (is_vmalloc_addr((void *)start)) {
> +               struct page *page;
> +               int i;
> +
> +               for (i =3D 0; i < page_count; i++) {

page_count is of an unsigned type and i is of a signed type, this is
bound to cause a warning.
Please move the "n" variable below to the top of this function and use
that as an index variable here too.

> +                       page =3D vmalloc_to_page((void *)(start + PAGE_SIZE=
 * i));
> +                       if (!page)
> +                               return -ENOMEM;
> +
> +                       get_page(page);
> +                       pages[i] =3D page;
> +               }
> +               rc =3D page_count;
> +       } else {
> +               struct kvec *kiov;
> +               size_t n;
> +
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
>         }
>
> -       rc =3D get_kernel_pages(kiov, page_count, 0, pages);
> -       kfree(kiov);
> -
>         return rc;
>  }
>
> --
> 2.25.1

This patch makes sense. Please fix the comment above and post a v3
(with a changelog this time).

Cheers,
Jens

--===============3064350269909303300==--

