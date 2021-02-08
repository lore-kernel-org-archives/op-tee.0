From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: simplify i2c access
Date: Mon, 08 Feb 2021 09:32:50 +0100
Message-ID: <20210208083250.GB27508@trex>
In-Reply-To: <20210208074631.GA27508@trex>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8065009682451715989=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8065009682451715989==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 08/02/21, Jorge Ramirez-Ortiz, Foundries wrote:
> On 08/02/21, Jens Wiklander wrote:
> > Hi Jorge,
> >=20
> > On Wed, Jan 27, 2021 at 11:41 AM Jens Wiklander
> > <jens.wiklander@linaro.org> wrote:
> > >
> > > Hi Arnd,
> > >
> > > On Mon, Jan 25, 2021 at 12:38 PM Arnd Bergmann <arnd@kernel.org> wrot=
e:
> > > >
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > Storing a bogus i2c_client structure on the stack adds overhead and
> > > > causes a compile-time warning:
> > > >
> > > > drivers/tee/optee/rpc.c:493:6: error: stack frame size of 1056 bytes =
in function 'optee_handle_rpc' [-Werror,-Wframe-larger-than=3D]
> > > > void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param=
 *param,
> > > >
> > > > Change the implementation of handle_rpc_func_cmd_i2c_transfer() to
> > > > open-code the i2c_transfer() call, which makes it easier to read
> > > > and avoids the warning.
> > > >
> > > > Fixes: c05210ab9757 ("drivers: optee: allow op-tee to access devices =
on the i2c bus")
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > ---
> > > >  drivers/tee/optee/rpc.c | 31 ++++++++++++++++---------------
> > > >  1 file changed, 16 insertions(+), 15 deletions(-)
> > >
> > > Looks good to me.
> > > Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
> >=20
> > Would you mind testing this?
>=20
> sure, doing it this morning.
>=20
> btw what Arnd has done - removing the unnecessary level of indirection
> - was pretty much my initial though but I thought it was easier to
> read the way I wrote it (I guess I was wrong and I obviously missed
> the stack size increase)
>=20
> but yes, will test

Tested on imx6ull.

Tested-by: Jorge Ramirez-Ortiz <jorge@foundries.io>

>=20
> >=20
> > Thanks,
> > Jens

--===============8065009682451715989==--

