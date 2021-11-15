From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: fix kfree NULL pointer
Date: Mon, 15 Nov 2021 13:36:36 +0100
Message-ID: 
 <CAHUa44FvNiyZ_S=G49UbbjdBScKXvtgtsMVYjfG_RE7--N7azw@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYPOz1g+-6=Roo88qwcSv9W5vsbVHFWTzv_ALXxyMsLJ8w@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4400931178373961154=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4400931178373961154==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, Nov 8, 2021 at 6:34 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Thu, 4 Nov 2021 at 17:00, <cgel.zte@gmail.com> wrote:
> >
> > From: Lv Ruyi <lv.ruyi@zte.com.cn>
> >
> > This patch fixes the following Coccinelle error:
> > drivers/tee/optee/ffa_abi.c: 877: ERROR  optee is NULL but dereferenced.
> >
> > If memory allocation fails, optee is null pointer. the code will goto err
> >  and release optee.
> >
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> > ---
> >  drivers/tee/optee/ffa_abi.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > index 6defd1ec982a..8d9d189557f9 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -811,8 +811,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
> >
> >         optee = kzalloc(sizeof(*optee), GFP_KERNEL);
> >         if (!optee) {
> > -               rc = -ENOMEM;
> > -               goto err;
> > +               return -ENOMEM;
> >         }
>
> So the braces are redundant after this change, hence can be dropped.
>
> With that addressed:
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I'll fix up the commit and pick it up now.

Thanks,
Jens

--===============4400931178373961154==--

