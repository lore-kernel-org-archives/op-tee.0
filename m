From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v1] firmware: tee_bnxt: Use UUID API for exporting the UUID
Date: Mon, 12 Oct 2020 20:24:14 +0300
Message-ID: <20201012172414.GJ4077@smile.fi.intel.com>
In-Reply-To: <20200618105648.GP2428291@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7751643395181827747=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7751643395181827747==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2020 at 01:56:48PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 22, 2020 at 04:00:21PM +0300, Andy Shevchenko wrote:
> > There is export_uuid() function which exports uuid_t to the u8 array.
> > Use it instead of open coding variant.
> >=20
> > This allows to hide the uuid_t internals.
>=20
> Any comment on this?

Guys, who is going to pick this up?

> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/firmware/broadcom/tee_bnxt_fw.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/b=
roadcom/tee_bnxt_fw.c
> > index ed10da5313e86..4cf0c2576037d 100644
> > --- a/drivers/firmware/broadcom/tee_bnxt_fw.c
> > +++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
> > @@ -197,7 +197,7 @@ static int tee_bnxt_fw_probe(struct device *dev)
> >  		return -ENODEV;
> > =20
> >  	/* Open session with Bnxt load Trusted App */
> > -	memcpy(sess_arg.uuid, bnxt_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
> > +	export_uuid(sess_arg.uuid, &bnxt_device->id.uuid);
> >  	sess_arg.clnt_login =3D TEE_IOCTL_LOGIN_PUBLIC;
> >  	sess_arg.num_params =3D 0;
> > =20

--=20
With Best Regards,
Andy Shevchenko



--===============7751643395181827747==--

