From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Date: Wed, 26 Mar 2025 07:59:08 +0100
Message-ID: 
 <CAHUa44G_z0b42kHcaxvRJOou=pPT+MgWkJ5-5kbEOdJOFLMsAA@mail.gmail.com>
In-Reply-To: <20250325200740.3645331-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7109925511329268276=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7109925511329268276==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Marco,

On Tue, Mar 25, 2025 at 9:07=E2=80=AFPM Marco Felsch <m.felsch@pengutronix.=
de> wrote:
>
> Skip manipulating the refcount in case of slab pages according commit
> b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page").
>
> Fixes: b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page=
")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> v2:
> - Make use of page variable
> v1:
> - https://lore.kernel.org/all/20250325195021.3589797-1-m.felsch(a)pengutron=
ix.de/
>
>  drivers/tee/tee_shm.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index daf6e5cfd59a..35f0ac359b12 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -19,16 +19,24 @@ static void shm_put_kernel_pages(struct page **pages, s=
ize_t page_count)
>  {
>         size_t n;
>
> -       for (n =3D 0; n < page_count; n++)
> -               put_page(pages[n]);
> +       for (n =3D 0; n < page_count; n++) {
> +               struct page *page =3D pages[n];
> +
> +               if (!PageSlab(page))
> +                       put_page(page);
> +       }
>  }
>
>  static void shm_get_kernel_pages(struct page **pages, size_t page_count)
>  {
>         size_t n;
>
> -       for (n =3D 0; n < page_count; n++)
> -               get_page(pages[n]);
> +       for (n =3D 0; n < page_count; n++) {
> +               struct page *page =3D pages[n];
> +
> +               if (!PageSlab(page))
> +                       get_page(page);

b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page")
mentions that more page types will have a zero refcount in the longer
term. So we'll need to add exception after exception here. Is there a
helper function somewhere to get all the pages we need? Or can we do
this differently?

Cheers,
Jens

> +       }
>  }
>
>  static void release_registered_pages(struct tee_shm *shm)
> --
> 2.39.5
>

--===============7109925511329268276==--

