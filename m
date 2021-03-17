From: Ard Biesheuvel <ardb@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: enable apci support
Date: Wed, 17 Mar 2021 09:29:23 +0100
Message-ID: 
 <CAMj1kXFg1a5ezoVBvrZ7xc7oM2zH-Phu1eNoXv+YZ+Yda1k7SQ@mail.gmail.com>
In-Reply-To: <20210317080442.GA3018337@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1127582520235047744=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1127582520235047744==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Mar 2021 at 09:04, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Fri, Mar 12, 2021 at 04:36:53PM +0800, Ran Wang wrote:
> > This patch add ACPI support for optee driver.
> >
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> >  drivers/tee/optee/core.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index cf4718c6d35d..8fb261f4b9db 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -5,6 +5,7 @@
> >
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >
> > +#include <linux/acpi.h>
> >  #include <linux/arm-smccc.h>
> >  #include <linux/errno.h>
> >  #include <linux/io.h>
> > @@ -735,12 +736,21 @@ static const struct of_device_id optee_dt_match[] =
=3D {
> >  };
> >  MODULE_DEVICE_TABLE(of, optee_dt_match);
> >
> > +#ifdef CONFIG_ACPI
> > +static const struct acpi_device_id optee_acpi_match[] =3D {
> > +     { "OPTEE01",},

You cannot just invent ACPI HIDs like that. The 4 character prefix is
a vendor ID that is assigned by the UEFI forum, the 4 following digits
are up to the vendor to assign,

> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, dwc3_acpi_match);

dwc3_acpi_match ?? Does this even build?


> > +#endif
> > +
> >  static struct platform_driver optee_driver =3D {
> >       .probe  =3D optee_probe,
> >       .remove =3D optee_remove,
> >       .driver =3D {
> >               .name =3D "optee",
> >               .of_match_table =3D optee_dt_match,
> > +             .acpi_match_table =3D ACPI_PTR(optee_acpi_match),
> >       },
> >  };
> >  module_platform_driver(optee_driver);
> > --
> > 2.25.1
> >
>
> This looks simple enough. Ard, is this what you had in mind earlier?
>

Not really.

On SynQuacer, we use

    Device (TOS0) {
      Name (_HID, "PRP0001")
      Name (_UID, 0x0)
      Name (_DSD, Package () {
        ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
        Package () {
          Package (2) { "compatible", "linaro,optee-tz" },
          Package (2) { "method", "smc" },
        }
      })
    }

which does not require any changes to Linux. So I don't think this
patch is needed at all tbh.

--===============1127582520235047744==--

