From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: Pass a pointer to virt_to_page()
Date: Thu, 30 Mar 2023 14:44:42 +0200
Message-ID: 
 <CAHUa44GRd3A_5161omysyz-YT54DGBVB6k-v9dV5CFAoyoKJ8w@mail.gmail.com>
In-Reply-To: <20230324101531.711735-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3639296300485657357=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3639296300485657357==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 11:15=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> Like the other calls in this function virt_to_page() expects
> a pointer, not an integer.
>
> However since many architectures implement virt_to_pfn() as
> a macro, this function becomes polymorphic and accepts both a
> (unsigned long) and a (void *).
>
> Fix this up with an explicit cast.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I'm picking up this.

Thanks,
Jens

> ---
>  drivers/tee/tee_shm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index b1c6231defad..673cf0359494 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -32,7 +32,7 @@ static int shm_get_kernel_pages(unsigned long start, size=
_t page_count,
>                          is_kmap_addr((void *)start)))
>                 return -EINVAL;
>
> -       page =3D virt_to_page(start);
> +       page =3D virt_to_page((void *)start);
>         for (n =3D 0; n < page_count; n++) {
>                 pages[n] =3D page + n;
>                 get_page(pages[n]);
> --
> 2.34.1
>

--===============3639296300485657357==--

