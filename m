From: Ludvig Pärsson <Ludvig.Parsson@axis.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Populate child nodes in probe function
Date: Fri, 11 Nov 2022 13:16:43 +0000
Message-ID: <02a899a1807274e2d0fa20e0d6059db00839d9ec.camel@axis.com>
In-Reply-To: <
 <CAFA6WYPgW0ya3+yiD49QH3q4nLj1rUyEPye_x2engtihYVaNuA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2215310003468588784=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2215310003468588784==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-11-11 at 15:27 +0530, Sumit Garg wrote:
> On Thu, 10 Nov 2022 at 17:39, Ludvig P=C3=A4rsson
> <Ludvig.Parsson@axis.com> wrote:
> >=20
> > On Thu, 2022-11-10 at 16:23 +0530, Sumit Garg wrote:
> > > On Wed, 9 Nov 2022 at 21:37, Ludvig P=C3=A4rsson <=20
> > > ludvig.parsson(a)axis.com>
> > > wrote:
> > > >=20
> > > > Currently there is no dependency between the "linaro,scmi-
> > > > optee"
> > > > driver
> > > > and the tee_core. If the scmi-optee driver gets probed before
> > > > the
> > > > tee_bus_type is initialized, then we will get an unwanted error
> > > > print.
> > > >=20
> > >=20
> > > What error print do you observe? I suppose this case is already
> > > handled by scmi optee driver via -EPROBE_DEFER.
> > >=20
> > > -Sumit
> > >=20
> > Hi Sumit,
> >=20
> > The error print is in driver_register().
> >=20
> > This is kind of what happens:
> > scmi_driver_init()
> > scmi_probe()
> > =C2=A0=C2=A0=C2=A0 scmi_optee_link_supplier()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scmi_optee_init()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 driver=
_register() <--- pr_err() if tee_bus_type is not
> > initialized
> > tee_init() <--- tee_bus_type gets initialized here
> >=20
> > The scmi_optee_link_supplier() will always return -EPROBE_DEFER the
> > first time because scmi_optee_private is initialized in
> > scmi_optee_service_probe, which is only called after the driver is
> > registered in scmi_optee_init. Right now the driver_register fails
> > because tee_bus_type is not initialized which is printing the
> > unwanted
> > error print. Another side effect of this is that
> > scmi_optee_link_supplier() will return -EPROBE_DEFER a second time,
> > and
> > scmi_probe will be successful the third time instead of the second
> > time.
>=20
> Thanks for the report. It rather looks like an inter subsystem
> dependency problem. Check if this [1] patch resolves your problem?
>=20
> [1] https://lkml.org/lkml/2022/11/11/329
>=20
> -Sumit
>=20
Yes, this solves the problem, but I don't think the maintainer for the
SCMI subsystem likes the solution. Earlier this week I discussed this
problem with Sudeep, Cristian and Etienne that are CCed in the
submission you linked. Changing the initcall level was one of my
suggestions which got instantly rejected. We agreed that the solution
in the patch i submitted was probably the best one, but maybe they will
change their minds.

BR,
Ludvig

> >=20
> > BR,
> > Ludvig
> >=20
> > > > This patch enables putting scmi-optee nodes as children to the
> > > > optee
> > > > node in devicetree, which indirectly creates the missing
> > > > dependency.
> > > >=20
> > > > Signed-off-by: Ludvig P=C3=A4rsson <ludvig.parsson@axis.com>
> > > > ---
> > > > =C2=A0drivers/tee/optee/smc_abi.c | 5 +++++
> > > > =C2=A01 file changed, 5 insertions(+)
> > > >=20
> > > > diff --git a/drivers/tee/optee/smc_abi.c
> > > > b/drivers/tee/optee/smc_abi.c
> > > > index a1c1fa1a9c28..be6f02fd5a7f 100644
> > > > --- a/drivers/tee/optee/smc_abi.c
> > > > +++ b/drivers/tee/optee/smc_abi.c
> > > > @@ -1533,6 +1533,11 @@ static int optee_probe(struct
> > > > platform_device *pdev)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto err_disable_shm_cache;
> > > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Populate any dependent child=
 node (if any) */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D devm_of_platform_populat=
e(&pdev->dev);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto err_disable_shm_cache;
> > > > +
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_info("initialized drive=
r\n");
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > >=20
> > > > --
> > > > 2.30.2
> > > >=20
> >=20


--===============2215310003468588784==--

