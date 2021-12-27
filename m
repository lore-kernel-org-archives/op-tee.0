From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: Use bitmap_free() to free bitmap
Date: Mon, 27 Dec 2021 11:06:17 +0530
Message-ID: 
 <CAFA6WYOZtMW7bq98JXm8AqgajaYmythiDQ53k-zgew6zE63YCg@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3C0e30e1f1bde74bc95085093fb0289007d510a68c=2E1640529?=
 =?utf-8?q?121=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2086879673645347953=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2086879673645347953==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sun, 26 Dec 2021 at 20:02, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> kfree() and bitmap_free() are the same. But using the latter is more
> consistent when freeing memory allocated with bitmap_zalloc().
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/tee/optee/notif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Looks reasonable to me.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
> index a28fa03dcd0e..05212842b0a5 100644
> --- a/drivers/tee/optee/notif.c
> +++ b/drivers/tee/optee/notif.c
> @@ -121,5 +121,5 @@ int optee_notif_init(struct optee *optee, u_int max_key)
>
>  void optee_notif_uninit(struct optee *optee)
>  {
> -       kfree(optee->notif.bitmap);
> +       bitmap_free(optee->notif.bitmap);
>  }
> --
> 2.32.0
>

--===============2086879673645347953==--

