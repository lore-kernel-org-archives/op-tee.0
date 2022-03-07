From: Clément Léger <clement.leger@bootlin.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] rtc: optee: add RTC driver for OP-TEE RTC PTA
Date: Mon, 07 Mar 2022 12:00:00 +0100
Message-ID: <20220307120000.49f88c8b@fixe.home>
In-Reply-To: <
 <CAHUa44FJEsd1wc=E0p+4pHU1=31z7JTgNDyz9Vxx77N11B8RKg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6455126113134402042=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6455126113134402042==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Le Mon, 7 Mar 2022 11:40:38 +0100,
Jens Wiklander <jens.wiklander@linaro.org> a =C3=A9crit :

> On Mon, Mar 7, 2022 at 10:42 AM Cl=C3=A9ment L=C3=A9ger <clement.leger@bo=
otlin.com> wrote:
> >
> > This drivers allows to communicate with a RTC PTA handled by OP-TEE [1].
> > This PTA allows to query RTC information, set/get time and set/get
> > offset depending on the supported features.
> >
> > [1] https://github.com/OP-TEE/optee_os/pull/5179
> >
> > Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> > ---
> >
> > Changes in v2: =20
>=20
> Hmm, this seems to be a second v2.

Hmpf, I answered to Etienne questions on V1 and forgot I already sent a
V2.

>=20
> >  - Rebased over tee-shm-for-v5.18
> >  - Switch to tee_shm_alloc_kernel_buf()
> >  - Use export_uuid() to copy uuid
> >  - Fix warnings reported by checkpatch
> >  - Free SHM in error exit path
> >  - Fix error messages to include ret value and fix wrong IOCTL names
> >  - Use 100 columns char limit =20
>=20
> From bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning"):
>     Yes, staying withing 80 columns is certainly still _preferred_.  But
>     it's not the hard limit that the checkpatch warnings imply, and other
>     concerns can most certainly dominate.
>=20
>     Increase the default limit to 100 characters.  Not because 100
>     characters is some hard limit either, but that's certainly a "what are
>     you doing" kind of value and less likely to be about the occasional
>     slightly longer lines.

Ok.

> > +
> > +       if (param[0].u.memref.size !=3D sizeof(*optee_tm)) {
> > +               dev_err(dev, "Invalid read size from OPTEE\n");
> > +               return -EPROTO;
> > +       } =20
>=20
> The dev_err() prints above are basically covering "can't happen"
> cases. Robust code should certainly do the checks, but I'm not so sure
> about how useful the prints are.

Agreed, if it fails, this is likely to be due to protocol changes and
thus, the developer will probably know where to search for the error.

[...]

> > +static int optee_rtc_probe(struct device *dev)
> > +{
> > +       struct tee_client_device *rtc_device =3D to_tee_client_device(dev=
);
> > +       struct tee_ioctl_open_session_arg sess_arg;
> > +       struct optee_rtc *priv;
> > +       struct rtc_device *rtc;
> > +       struct tee_shm *shm;
> > +       int ret, err;
> > +
> > +       memset(&sess_arg, 0, sizeof(sess_arg));
> > +
> > +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> > +
> > +       rtc =3D devm_rtc_allocate_device(dev);
> > +       if (IS_ERR(rtc))
> > +               return PTR_ERR(rtc);
> > +
> > +       /* Open context with TEE driver */
> > +       priv->ctx =3D tee_client_open_context(NULL, optee_ctx_match, NULL=
, NULL);
> > +       if (IS_ERR(priv->ctx))
> > +               return -ENODEV;
> > +
> > +       /* Open session with rtc Trusted App */
> > +       export_uuid(sess_arg.uuid, &rtc_device->id.uuid);
> > +       sess_arg.clnt_login =3D TEE_IOCTL_LOGIN_REE_KERNEL;
> > +
> > +       ret =3D tee_client_open_session(priv->ctx, &sess_arg, NULL);
> > +       if (ret < 0 || sess_arg.ret !=3D 0) {
> > +               dev_err(dev, "tee_client_open_session failed, err: %x\n",=
 sess_arg.ret); =20
>=20
> This print is the most useful print in the driver. This is typically
> reached if the PTA doesn't exist.

If the PTA does not exists, is the driver even probed ? I thought it
was based on the UUID matching.

>=20
> > +               err =3D -EINVAL;
> > +               goto out_ctx;
> > +       }
> > +       priv->session_id =3D sess_arg.session;
> > +
> > +       shm =3D tee_shm_alloc_kernel_buf(priv->ctx, sizeof(struct optee_r=
tc_info));
> > +       if (IS_ERR(shm)) {
> > +               dev_err(priv->dev, "tee_shm_alloc_kernel_buf failed\n");
> > +               err =3D PTR_ERR(shm);
> > +               goto out_sess;
> > +       }
> > +
> > +       priv->shm =3D shm;
> > +       priv->dev =3D dev;
> > +       dev_set_drvdata(dev, priv);
> > +
> > +       rtc->ops =3D &optee_rtc_ops;
> > +
> > +       err =3D optee_rtc_read_info(dev, rtc, &priv->features);
> > +       if (err) {
> > +               dev_err(dev, "Failed to get RTC features from OP-TEE\n");=
 =20
>=20
> This print could also be worth keeping, but the rest are in my opinion
> of limited interest.
>=20
> It's a tradeoff with the prints, no big deal if you'd like to keep more.

I'm ok with that statement. The runtime errors are less likely (if not
totally unlikely) to happen. I'll sent a new version (V4 this time...)
with theses modifications.

Thanks,

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com

--===============6455126113134402042==--

