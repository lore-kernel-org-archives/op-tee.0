From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] drivers: optee: i2c: add bus retry configuration
Date: Wed, 23 Sep 2020 15:51:12 +0200
Message-ID: <20200923135112.GA21608@trex>
In-Reply-To: <20200923121356.GA1659958@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8497875118805970996=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8497875118805970996==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 23/09/20, Jens Wiklander wrote:
> On Wed, Sep 23, 2020 at 01:26:31PM +0200, Jorge Ramirez-Ortiz, Foundries wr=
ote:
> > On 23/09/20, Jorge Ramirez-Ortiz, Foundries wrote:
> > > On 22/09/20, Jens Wiklander wrote:
> > > > On Wed, Sep 16, 2020 at 05:27:32PM +0200, Jorge Ramirez-Ortiz wrote:
> > > > > Allow OP-TEE to specify the number of retries in the adaptor.
> > > > >=20
> > > > > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > > > > ---
> > > > >  drivers/tee/optee/rpc.c | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > > > > index 1e3614e4798f..2d46a9ecb1de 100644
> > > > > --- a/drivers/tee/optee/rpc.c
> > > > > +++ b/drivers/tee/optee/rpc.c
> > > > > @@ -58,6 +58,7 @@ static void handle_rpc_func_cmd_i2c_transfer(stru=
ct tee_context *ctx,
> > > > >  	struct tee_param *params;
> > > > >  	size_t i;
> > > > >  	int ret =3D -EOPNOTSUPP;
> > > > > +	int retries =3D 0;
> > > > >  	u8 attr[] =3D {
> > > > >  		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > > > >  		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > > > > @@ -102,12 +103,17 @@ static void handle_rpc_func_cmd_i2c_transfer(=
struct tee_context *ctx,
> > > > >  	client.addr =3D params[0].u.value.c;
> > > > >  	snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
> > > > > =20
> > > > > +	/* cache the current value */
> > > > > +	retries =3D client.adapter->retries;
> > > > > +
> > > > >  	switch (params[0].u.value.a) {
> > > > >  	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> > > > > +		client.adapter->retries =3D params[1].u.value.b;
> > > > Do we need to take any locks befor this?
> > >=20
> > > no I dont think so: there is no need for bus locks when requesting a
> > > transfer via i2c_master_recv/send; the lock for the bus segment gets
> > > taken later on, when the actual transfer hppens ( __i2c_transfer())
> > >=20
> > > the functionality implemented in this function pretty much mimicks
> > > what is done in the normal world via /dev/i2c-X
> > > (drivers/i2c/i2c_dev.c)
> > >
> >=20
> > correction (of course)
> >   - i2cdev_read --> i2c_master_recv
> >   - i2cdev->write -->i2c_master_send
> > >=20
> > > and now the retry count setup on the adaptor with this commit.
> > >=20
> > >  - i2cdev_ioctl I2C_RETRIES
>=20
> I don't understand. Do you mean that client.adapter->retries doesn't
> need to be protected from concurrent updates? Or is it already protected
> by some other mechanism?

yeah I probably misunderstood your comment. my bad.

um I thought that upon getting the adaptor there would be some
protection mechanism in place until it is put back; but that is not
the case. looking a bit into it I see no simple way of protecting
changes to the adaptor (at any given time any thread could get a
pointer to it) so it seems that setting the retry field is not a
guarantee that it will be applied.

>=20
> Cheers,
> Jens

--===============8497875118805970996==--

