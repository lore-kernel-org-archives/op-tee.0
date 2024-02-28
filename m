From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 1/3] tee: optee: Move pool_op helper functions
Date: Wed, 28 Feb 2024 09:40:55 +0100
Message-ID: 
 <CAHUa44F=0juXyyhA7Bu0SzCK+1igRYEWCn1XRL1sDG1ZWNhr3g@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYOq3tHq5n7=XYpsSgBghCF0RtAxs-sLxvLYMWwnQuFSeQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8556174085669378007=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8556174085669378007==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 6:58=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Tue, 27 Feb 2024 at 21:20, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > On Tue, Feb 27, 2024 at 7:06=E2=80=AFAM Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
[snip]
> > > > --- a/include/linux/tee_drv.h
> > > > +++ b/include/linux/tee_drv.h
> > > > @@ -275,6 +275,17 @@ void *tee_get_drvdata(struct tee_device *teedev);
> > > >  struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size=
_t size);
> > > >  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, si=
ze_t size);
> > > >
> > > > +int tee_shm_pool_op_alloc_helper(struct tee_shm_pool *pool, struct t=
ee_shm *shm,
> > > > +                                size_t size, size_t align,
> > > > +                                int (*shm_register)(struct tee_conte=
xt *ctx,
> > > > +                                                    struct tee_shm *=
shm,
> > > > +                                                    struct page **pa=
ges,
> > > > +                                                    size_t num_pages,
> > > > +                                                    unsigned long st=
art));
> > > > +void tee_shm_pool_op_free_helper(struct tee_shm_pool *pool, struct t=
ee_shm *shm,
> > > > +                                int (*shm_unregister)(struct tee_con=
text *ctx,
> > > > +                                                      struct tee_shm=
 *shm));
> > > > +
> > >
> > > These rather belong to drivers/tee/tee_private.h as we shouldn't
> > > expose them to other kernel client drivers.
> >
> > This is the right place, this .h file is for TEE drivers too.
> >
>
> But this is shared with other kernel TEE client drivers and we
> shouldn't expose internal APIs which aren't meant for them with a side
> effect of API abuse too. Any particular reason to not use
> drivers/tee/tee_private.h?

drivers/tee/tee_private.h is supposed to be used internally by only
the files in drivers/tee. If you look in include/linux/tee_drv.h
you'll find a few functions and other definitions that a kernel TEE
client driver should not use, for instance, tee_device_register() and
tee_device_unregister(). This kernel TEE client interface was
introduced with commit 25559c22cef8 ("tee: add kernel internal client
interface"). include/linux/tee_drv.h existed before we even had any
kernel TEE client interface.

Cheers,
Jens

--===============8556174085669378007==--

