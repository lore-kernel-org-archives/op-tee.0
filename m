From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: make tee_class constant
Date: Mon, 09 Oct 2023 12:13:21 +0200
Message-ID: <2023100952-yapping-rockiness-f1e3@gregkh>
In-Reply-To: <
 <CAFA6WYNbMsEE7OF0SpLN5gQx5-TNPXD7Zm+2tVu21xdpzKU=Xg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8478751562878453404=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8478751562878453404==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2023 at 11:04:33AM +0530, Sumit Garg wrote:
> On Fri, 6 Oct 2023 at 19:30, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Now that the driver core allows for struct class to be in read-only
> > memory, we should make all 'class' structures declared at build time
> > placing them into read-only memory, instead of having to be dynamically
> > allocated at runtime.
> >
> > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > Cc: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/tee/tee_core.c | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> >
>=20
> Apart from nit below, feel free to add:
>=20
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>=20
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index 0eb342de0b00..5ddfd5d9ac7f 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -40,7 +40,10 @@ static const uuid_t tee_client_uuid_ns =3D UUID_INIT(0=
x58ac9ca0, 0x2086, 0x4683,
> >  static DECLARE_BITMAP(dev_mask, TEE_NUM_DEVICES);
> >  static DEFINE_SPINLOCK(driver_lock);
> >
> > -static struct class *tee_class;
> > +static const struct class tee_class =3D {
> > +       .name =3D "tee",
> > +};
> > +
> >  static dev_t tee_devt;
> >
> >  struct tee_context *teedev_open(struct tee_device *teedev)
> > @@ -919,7 +922,7 @@ struct tee_device *tee_device_alloc(const struct tee_=
desc *teedesc,
> >                  teedesc->flags & TEE_DESC_PRIVILEGED ? "priv" : "",
> >                  teedev->id - offs);
> >
> > -       teedev->dev.class =3D tee_class;
> > +       teedev->dev.class =3D &tee_class;
> >         teedev->dev.release =3D tee_release_device;
> >         teedev->dev.parent =3D dev;
> >
> > @@ -1112,7 +1115,7 @@ tee_client_open_context(struct tee_context *start,
> >                 dev =3D &start->teedev->dev;
> >
> >         do {
> > -               dev =3D class_find_device(tee_class, dev, &match_data, ma=
tch_dev);
> > +               dev =3D class_find_device(&tee_class, dev, &match_data, m=
atch_dev);
> >                 if (!dev) {
> >                         ctx =3D ERR_PTR(-ENOENT);
> >                         break;
> > @@ -1226,10 +1229,10 @@ static int __init tee_init(void)
> >  {
> >         int rc;
> >
> > -       tee_class =3D class_create("tee");
> > -       if (IS_ERR(tee_class)) {
> > +       rc =3D class_register(&tee_class);
> > +       if (rc) {
> >                 pr_err("couldn't create class\n");
>=20
> nit: this error message should be updated as well.

Ah, missed that, thanks!  Will send a follow-up patch for that.

greg k-h

--===============8478751562878453404==--

