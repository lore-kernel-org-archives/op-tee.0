From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: make tee_shm_register vmalloc supported
Date: Fri, 04 Feb 2022 16:38:58 +0530
Message-ID: 
 <CAFA6WYNR_axHaFdbS3sy7pRYFOuTv7KyRe+aP8MywkGdh33NaQ@mail.gmail.com>
In-Reply-To: <20220204093254.2467-1-phil.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3538263683220084826=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3538263683220084826==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 4 Feb 2022 at 15:03, Phil Chang <phil.chang@mediatek.com> wrote:
>
> This patch allowed the tee shm use vmalloc area buffer.
>
> Signed-off-by: Phil Chang <phil.chang@mediatek.com>
> ---
>
> Hi,
>
>  In some low-memory devices, it's hard to aquire large-orders pages,
>  this pathes is allowed user use scatter pages to register shm.

This kind of info should go into the commit description describing why
this change is needed.

>
>  Thanks.
>
>  drivers/tee/optee/call.c |  2 +-
>  drivers/tee/tee_shm.c    | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>

Also, I would like this patch to be rebased on top of SHM updates
series [1] from Jens as there has been a lot of refactoring touching
these files.

[1] https://lists.trustedfirmware.org/archives/list/op-tee(a)lists.trustedfir=
mware.org/thread/3J2IJX5LG2X4CZBYDLVA4PDVM4APMZSD/

-Sumit

> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index b25cc1fac945..937bcc7df8e4 100644
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
> index 499fccba3d74..31d0c10485ff 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -195,6 +195,20 @@ struct tee_shm *tee_shm_register(struct tee_context *c=
tx, unsigned long addr,
>         if (flags & TEE_SHM_USER_MAPPED) {
>                 rc =3D pin_user_pages_fast(start, num_pages, FOLL_WRITE,
>                                          shm->pages);
> +       } else if (is_vmalloc_addr((void *)start)) {
> +               struct page *page;
> +               int i;
> +
> +               for (i =3D 0; i < num_pages; i++) {
> +                       page =3D vmalloc_to_page((void *)(start + PAGE_SIZE=
 * i));
> +                       if (!page) {
> +                               ret =3D ERR_PTR(-ENOMEM);
> +                               goto err;
> +                       }
> +                       get_page(page);
> +                       shm->pages[i] =3D page;
> +               }
> +               rc =3D num_pages;
>         } else {
>                 struct kvec *kiov;
>                 int i;
> --
> 2.25.1

--===============3538263683220084826==--

