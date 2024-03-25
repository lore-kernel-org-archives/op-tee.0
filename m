From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: smc: Convert to platform remove callback
 returning void
Date: Mon, 25 Mar 2024 15:54:27 +0100
Message-ID: 
 <CAHUa44FH9g=k6b-YGzESxsJ_LixbRD3wkV17+Rza_9AidiO+QQ@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYMDvFGopHkLfMUL963MAOBwcCSfu8TwnjqcyTRWWZrN8w@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6185770129925955839=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6185770129925955839==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 12:31=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> On Fri, 8 Mar 2024 at 14:21, Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code. However the value returned is ignored (apart
> > from emitting a warning) and this typically results in resource leaks.
> >
> > To improve here there is a quest to make the remove callback return
> > void. In the first step of this quest all drivers are converted to
> > .remove_new(), which already returns void. Eventually after all drivers
> > are converted, .remove_new() will be renamed to .remove().
> >
> > Trivially convert this driver from always returning zero in the remove
> > callback to the void returning variant.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/tee/optee/smc_abi.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I'm picking up this for 6.10.

Thanks,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index a37f87087e5c..c82b7b88991d 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -1433,7 +1433,7 @@ static optee_invoke_fn *get_invoke_func(struct devi=
ce *dev)
> >   * optee_remove is called by platform subsystem to alert the driver
> >   * that it should release the device
> >   */
> > -static int optee_smc_remove(struct platform_device *pdev)
> > +static void optee_smc_remove(struct platform_device *pdev)
> >  {
> >         struct optee *optee =3D platform_get_drvdata(pdev);
> >
> > @@ -1453,8 +1453,6 @@ static int optee_smc_remove(struct platform_device =
*pdev)
> >                 memunmap(optee->smc.memremaped_shm);
> >
> >         kfree(optee);
> > -
> > -       return 0;
> >  }
> >
> >  /* optee_shutdown - Device Removal Routine
> > @@ -1806,7 +1804,7 @@ MODULE_DEVICE_TABLE(of, optee_dt_match);
> >
> >  static struct platform_driver optee_driver =3D {
> >         .probe  =3D optee_probe,
> > -       .remove =3D optee_smc_remove,
> > +       .remove_new =3D optee_smc_remove,
> >         .shutdown =3D optee_shutdown,
> >         .driver =3D {
> >                 .name =3D "optee",
> >
> > base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
> > --
> > 2.43.0
> >

--===============6185770129925955839==--

