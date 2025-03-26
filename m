From: Marco Felsch <m.felsch@pengutronix.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Date: Wed, 26 Mar 2025 10:42:47 +0100
Message-ID: <20250326094247.py7q5kbalisduzcc@pengutronix.de>
In-Reply-To: <
 <CAHUa44G_z0b42kHcaxvRJOou=pPT+MgWkJ5-5kbEOdJOFLMsAA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6515780622696013135=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6515780622696013135==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On 25-03-26, Jens Wiklander wrote:
> Hi Marco,
>=20
> On Tue, Mar 25, 2025 at 9:07=E2=80=AFPM Marco Felsch <m.felsch@pengutroni=
x.de> wrote:
> >
> > Skip manipulating the refcount in case of slab pages according commit
> > b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page").
> >
> > Fixes: b9c0e49abfca ("mm: decline to manipulate the refcount on a slab pa=
ge")
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> > v2:
> > - Make use of page variable
> > v1:
> > - https://lore.kernel.org/all/20250325195021.3589797-1-m.felsch(a)pengutr=
onix.de/
> >
> >  drivers/tee/tee_shm.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index daf6e5cfd59a..35f0ac359b12 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -19,16 +19,24 @@ static void shm_put_kernel_pages(struct page **pages,=
 size_t page_count)
> >  {
> >         size_t n;
> >
> > -       for (n =3D 0; n < page_count; n++)
> > -               put_page(pages[n]);
> > +       for (n =3D 0; n < page_count; n++) {
> > +               struct page *page =3D pages[n];
> > +
> > +               if (!PageSlab(page))
> > +                       put_page(page);
> > +       }
> >  }
> >
> >  static void shm_get_kernel_pages(struct page **pages, size_t page_count)
> >  {
> >         size_t n;
> >
> > -       for (n =3D 0; n < page_count; n++)
> > -               get_page(pages[n]);
> > +       for (n =3D 0; n < page_count; n++) {
> > +               struct page *page =3D pages[n];
> > +
> > +               if (!PageSlab(page))
> > +                       get_page(page);
>=20
> b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page")
> mentions that more page types will have a zero refcount in the longer
> term. So we'll need to add exception after exception here. Is there a
> helper function somewhere to get all the pages we need? Or can we do
> this differently?

You're right, but in the long-term perspective the patch also mentions
"... stop taking a refcount on the pages that it uses and rely on the
caller to hold whatever references are necessary to make the memory
stable."

As you mentioned, in the medium term more pages are going to have a zero
refcount. I think that once mm is starting to add more zero refcounted
page types, they will also add a helper like "PageRefcounted()" or so.

At the moment all users are changed to cover only the slab use-case.
Therefore I would keep it as it is right now and change it to the new
helper later on.

Regards,
  Marco


>=20
> Cheers,
> Jens
>=20
> > +       }
> >  }
> >
> >  static void release_registered_pages(struct tee_shm *shm)
> > --
> > 2.39.5
> >
>=20

--===============6515780622696013135==--

