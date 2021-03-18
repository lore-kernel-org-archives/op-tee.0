From: Ran Wang <ran.wang_1@nxp.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: [PATCH] optee: enable apci support
Date: Thu, 18 Mar 2021 07:29:31 +0000
Message-ID: <AM6PR04MB54133297642949378521C6A9F1699@AM6PR04MB5413.eurprd04.prod.outlook.com>
In-Reply-To: <
 <CAMj1kXFg1a5ezoVBvrZ7xc7oM2zH-Phu1eNoXv+YZ+Yda1k7SQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0767999362043394583=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0767999362043394583==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Ard,


On Wednesday, March 17, 2021 4:29 PM, Ard Biesheuvel wrote:
>=20
> On Wed, 17 Mar 2021 at 09:04, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > On Fri, Mar 12, 2021 at 04:36:53PM +0800, Ran Wang wrote:
> > > This patch add ACPI support for optee driver.
> > >
> > > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > > ---
> > >  drivers/tee/optee/core.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > > index cf4718c6d35d..8fb261f4b9db 100644
> > > --- a/drivers/tee/optee/core.c
> > > +++ b/drivers/tee/optee/core.c
> > > @@ -5,6 +5,7 @@
> > >
> > >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > >
> > > +#include <linux/acpi.h>
> > >  #include <linux/arm-smccc.h>
> > >  #include <linux/errno.h>
> > >  #include <linux/io.h>
> > > @@ -735,12 +736,21 @@ static const struct of_device_id
> > > optee_dt_match[] =3D {  };  MODULE_DEVICE_TABLE(of, optee_dt_match);
> > >
> > > +#ifdef CONFIG_ACPI
> > > +static const struct acpi_device_id optee_acpi_match[] =3D {
> > > +     { "OPTEE01",},
>=20
> You cannot just invent ACPI HIDs like that. The 4 character prefix is a ven=
dor ID that is assigned by the UEFI forum, the 4 following digits are
> up to the vendor to assign,

Thanks for this info. Could you please show me where I can find the guide/exa=
mple for this assign process?

> > > +     { },
> > > +};
> > > +MODULE_DEVICE_TABLE(acpi, dwc3_acpi_match);
>=20
> dwc3_acpi_match ?? Does this even build?

My bad, I was referring dwc3 code as an example, will correct it.

But looks this typo didn=E2=80=99t trigger error in my unit-test.
=20
>=20
> > > +#endif
> > > +
> > >  static struct platform_driver optee_driver =3D {
> > >       .probe  =3D optee_probe,
> > >       .remove =3D optee_remove,
> > >       .driver =3D {
> > >               .name =3D "optee",
> > >               .of_match_table =3D optee_dt_match,
> > > +             .acpi_match_table =3D ACPI_PTR(optee_acpi_match),
> > >       },
> > >  };
> > >  module_platform_driver(optee_driver);
> > > --
> > > 2.25.1
> > >
> >
> > This looks simple enough. Ard, is this what you had in mind earlier?
> >
>=20
> Not really.
>=20
> On SynQuacer, we use
>=20
>     Device (TOS0) {
>       Name (_HID, "PRP0001")
>       Name (_UID, 0x0)
>       Name (_DSD, Package () {
>         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>         Package () {
>           Package (2) { "compatible", "linaro,optee-tz" },
>           Package (2) { "method", "smc" },
>         }
>       })
>     }
>=20
> which does not require any changes to Linux. So I don't think this patch is=
 needed at all tbh.

Thanks for this example, but actually I failed to trigger kernel optee probe =
function by using
above code in ACPI table.

And I am curious how this 'compatible' properties be picked up by kernel when=
 try to match driver in ACPI mode?

My understanding is to get it done by feeding .acpi_match_table with somethin=
g, right?

Regards,
Ran


--===============0767999362043394583==--

