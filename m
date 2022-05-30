From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Pass a pointer to virt_addr_valid()
Date: Mon, 30 May 2022 07:55:00 +0200
Message-ID: 
 <CAHUa44GF-k5NZnvQYMYQLo3HsmQ6b2Y7wW5rU-2jT7N39-C1Yg@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYPDMAaF2N-REbwoUCvXi2WcK8v1KBcy1UudCGtvYUiYmg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9165760445229317325=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9165760445229317325==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 23, 2022 at 8:36 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Fri, 20 May 2022 at 03:18, Linus Walleij <linus.walleij@linaro.org> wr=
ote:
> >
> > A pointer into virtual memory is represented by a (void *)
> > not an u32, so the compiler warns:
> >
> > drivers/tee/optee/call.c:365:29: warning: passing argument 1
> >   of 'virt_to_pfn' makes pointer from integer without a
> >   cast [-Wint-conversion]
> >
> > Fix this with an explicit cast.
> >
> > Cc: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/tee/optee/call.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

Looks good, I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > index bd49ec934060..51275d77ec84 100644
> > --- a/drivers/tee/optee/call.c
> > +++ b/drivers/tee/optee/call.c
> > @@ -362,7 +362,7 @@ int optee_check_mem_type(unsigned long start, size_t =
num_pages)
> >          * Allow kernel address to register with OP-TEE as kernel
> >          * pages are configured as normal memory only.
> >          */
> > -       if (virt_addr_valid(start))
> > +       if (virt_addr_valid((void *)start))
> >                 return 0;
> >
> >         mmap_read_lock(mm);
> > --
> > 2.35.1
> >

--===============9165760445229317325==--

