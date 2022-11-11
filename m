From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Populate child nodes in probe function
Date: Fri, 11 Nov 2022 15:27:36 +0530
Message-ID: 
 <CAFA6WYPgW0ya3+yiD49QH3q4nLj1rUyEPye_x2engtihYVaNuA@mail.gmail.com>
In-Reply-To: <df564dc6ffbddcae12bd345b7a0525e586aba5ed.camel@axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4355797324536511511=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4355797324536511511==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Nov 2022 at 17:39, Ludvig P=C3=A4rsson <Ludvig.Parsson@axis.com>=
 wrote:
>
> On Thu, 2022-11-10 at 16:23 +0530, Sumit Garg wrote:
> > On Wed, 9 Nov 2022 at 21:37, Ludvig P=C3=A4rsson <ludvig.parsson@axis.c=
om>
> > wrote:
> > >
> > > Currently there is no dependency between the "linaro,scmi-optee"
> > > driver
> > > and the tee_core. If the scmi-optee driver gets probed before the
> > > tee_bus_type is initialized, then we will get an unwanted error
> > > print.
> > >
> >
> > What error print do you observe? I suppose this case is already
> > handled by scmi optee driver via -EPROBE_DEFER.
> >
> > -Sumit
> >
> Hi Sumit,
>
> The error print is in driver_register().
>
> This is kind of what happens:
> scmi_driver_init()
> scmi_probe()
>     scmi_optee_link_supplier()
>         scmi_optee_init()
>             driver_register() <--- pr_err() if tee_bus_type is not
> initialized
> tee_init() <--- tee_bus_type gets initialized here
>
> The scmi_optee_link_supplier() will always return -EPROBE_DEFER the
> first time because scmi_optee_private is initialized in
> scmi_optee_service_probe, which is only called after the driver is
> registered in scmi_optee_init. Right now the driver_register fails
> because tee_bus_type is not initialized which is printing the unwanted
> error print. Another side effect of this is that
> scmi_optee_link_supplier() will return -EPROBE_DEFER a second time, and
> scmi_probe will be successful the third time instead of the second
> time.

Thanks for the report. It rather looks like an inter subsystem
dependency problem. Check if this [1] patch resolves your problem?

[1] https://lkml.org/lkml/2022/11/11/329

-Sumit

>
> BR,
> Ludvig
>
> > > This patch enables putting scmi-optee nodes as children to the
> > > optee
> > > node in devicetree, which indirectly creates the missing
> > > dependency.
> > >
> > > Signed-off-by: Ludvig P=C3=A4rsson <ludvig.parsson@axis.com>
> > > ---
> > >  drivers/tee/optee/smc_abi.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/tee/optee/smc_abi.c
> > > b/drivers/tee/optee/smc_abi.c
> > > index a1c1fa1a9c28..be6f02fd5a7f 100644
> > > --- a/drivers/tee/optee/smc_abi.c
> > > +++ b/drivers/tee/optee/smc_abi.c
> > > @@ -1533,6 +1533,11 @@ static int optee_probe(struct
> > > platform_device *pdev)
> > >         if (rc)
> > >                 goto err_disable_shm_cache;
> > >
> > > +       /* Populate any dependent child node (if any) */
> > > +       rc =3D devm_of_platform_populate(&pdev->dev);
> > > +       if (rc)
> > > +               goto err_disable_shm_cache;
> > > +
> > >         pr_info("initialized driver\n");
> > >         return 0;
> > >
> > > --
> > > 2.30.2
> > >
>

--===============4355797324536511511==--

