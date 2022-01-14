From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: Use bitmap_free() to free bitmap
Date: Fri, 14 Jan 2022 11:01:17 +0100
Message-ID: 
 <CAHUa44Ghzbtj_YUQxAjq7cKmmJW8hRrYvq+9UwZn9CHkHO8_PQ@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYOZtMW7bq98JXm8AqgajaYmythiDQ53k-zgew6zE63YCg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7797056395706445132=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7797056395706445132==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, Dec 27, 2021 at 6:36 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Sun, 26 Dec 2021 at 20:02, Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
> >
> > kfree() and bitmap_free() are the same. But using the latter is more
> > consistent when freeing memory allocated with bitmap_zalloc().
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> >  drivers/tee/optee/notif.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> Looks reasonable to me.
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>

Looks good, picking up this.

Thanks,
Jens

--===============7797056395706445132==--

