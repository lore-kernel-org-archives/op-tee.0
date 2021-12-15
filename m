From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Fix incorrect page free bug
Date: Wed, 15 Dec 2021 09:34:04 -0600
Message-ID: <20211215153404.GB217403@sequoia>
In-Reply-To: <
 <CAHUa44Hqitcmj3=0FDOxsh0NytdpKyTEUUC2J8fcOmX9ZxQWsA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4000446150382950123=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4000446150382950123==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 2021-12-15 16:29:08, Jens Wiklander wrote:
> On Wed, Dec 15, 2021 at 11:20 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Pointer to the allocated pages (struct page *page) has already
> > progressed towards the end of allocation. It is incorrect to perform
> > __free_pages(page, order) using this pointer as we would free any
> > arbitrary pages. Fix this by stop modifying the page pointer.
> >
> > Fixes: ec185dd3ab25 ("optee: Fix memory leak when failing to register shm=
 pages")
> > Reported-by: Patrik Lantz <patrik.lantz@axis.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/tee/optee/core.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> Looks good to me, but I think we should cc stable since that was done
> in the patch fixed by this.

Yes, please add the 'Cc: stable(a)vger.kernel.org' tag because it will
ensure that it'll be applied to the affected stable kernels or, if
there's a conflict, that we'll get an email notification to provide a
manual backport.

Tyler

>=20
> Thanks,
> Jens
>=20
> >
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index ab2edfcc6c70..2a66a5203d2f 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -48,10 +48,8 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool_mgr=
 *poolm,
> >                         goto err;
> >                 }
> >
> > -               for (i =3D 0; i < nr_pages; i++) {
> > -                       pages[i] =3D page;
> > -                       page++;
> > -               }
> > +               for (i =3D 0; i < nr_pages; i++)
> > +                       pages[i] =3D page + i;
> >
> >                 shm->flags |=3D TEE_SHM_REGISTER;
> >                 rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
> > --
> > 2.25.1
> >
>=20

--===============4000446150382950123==--

