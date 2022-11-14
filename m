From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Populate child nodes in probe function
Date: Mon, 14 Nov 2022 12:08:15 +0530
Message-ID: 
 <CAFA6WYNwgr6_TA03W4cYfZkOvbdF0DO44_CnAsdZbLcuDHur6w@mail.gmail.com>
In-Reply-To: <20221111161336.msozo7l632jvbwcn@bogus>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6310109579107207002=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6310109579107207002==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Nov 2022 at 21:43, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Nov 09, 2022 at 05:07:08PM +0100, Ludvig P=C3=A4rsson wrote:
> > Currently there is no dependency between the "linaro,scmi-optee" driver
> > and the tee_core. If the scmi-optee driver gets probed before the
> > tee_bus_type is initialized, then we will get an unwanted error print.
> >
> > This patch enables putting scmi-optee nodes as children to the optee
> > node in devicetree, which indirectly creates the missing dependency.
> >
> > Signed-off-by: Ludvig P=C3=A4rsson <ludvig.parsson@axis.com>
> > ---
> >  drivers/tee/optee/smc_abi.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index a1c1fa1a9c28..be6f02fd5a7f 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -1533,6 +1533,11 @@ static int optee_probe(struct platform_device *pde=
v)
> >       if (rc)
> >               goto err_disable_shm_cache;
> >
> > +     /* Populate any dependent child node (if any) */
> > +     rc =3D devm_of_platform_populate(&pdev->dev);
> > +     if (rc)
> > +             goto err_disable_shm_cache;
> > +
>
> While I agree with idea of populating dependent child nodes from here,
> I am not sure if it is OK to give error if that fails or to just continue
> as there may be other users(like the user-space) for the OPTEE in general.
>

This uncertainty is simply because the inter subsystem dependency
issue can't be resolved by this. See my comment regarding FF-A ABI on
the other thread [1]

[1] https://lkml.org/lkml/2022/11/14/29

-Sumit

> --
> Regards,
> Sudeep

--===============6310109579107207002==--

