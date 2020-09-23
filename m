From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] drivers: optee: i2c: add bus retry configuration
Date: Wed, 23 Sep 2020 13:18:13 +0200
Message-ID: <20200923111813.GA30271@trex>
In-Reply-To: <20200922163859.GA1518183@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2973211942753470273=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2973211942753470273==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 22/09/20, Jens Wiklander wrote:
> On Wed, Sep 16, 2020 at 05:27:32PM +0200, Jorge Ramirez-Ortiz wrote:
> > Allow OP-TEE to specify the number of retries in the adaptor.
> >=20
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > ---
> >  drivers/tee/optee/rpc.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > index 1e3614e4798f..2d46a9ecb1de 100644
> > --- a/drivers/tee/optee/rpc.c
> > +++ b/drivers/tee/optee/rpc.c
> > @@ -58,6 +58,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee=
_context *ctx,
> >  	struct tee_param *params;
> >  	size_t i;
> >  	int ret =3D -EOPNOTSUPP;
> > +	int retries =3D 0;
> >  	u8 attr[] =3D {
> >  		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> >  		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > @@ -102,12 +103,17 @@ static void handle_rpc_func_cmd_i2c_transfer(struct=
 tee_context *ctx,
> >  	client.addr =3D params[0].u.value.c;
> >  	snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
> > =20
> > +	/* cache the current value */
> > +	retries =3D client.adapter->retries;
> > +
> >  	switch (params[0].u.value.a) {
> >  	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> > +		client.adapter->retries =3D params[1].u.value.b;
> Do we need to take any locks befor this?

no I dont think so: there is no need for bus locks when requesting a
transfer via i2c_master_recv/send; the lock for the bus segment gets
taken later on, when the actual transfer hppens ( __i2c_transfer())

the functionality implemented in this function pretty much mimicks
what is done in the normal world via /dev/i2c-X
(drivers/i2c/i2c_dev.c)

 - i2cdev_read --> i2c_master_send
 - i2cdev->write -->i2c_master_recv

and now the retry count setup on the adaptor with this commit.

 - i2cdev_ioctl I2C_RETRIES

>=20
> Cheers,
> Jens
>=20
> >  		ret =3D i2c_master_recv(&client, params[2].u.memref.shm->kaddr,
> >  				      params[2].u.memref.size);
> >  		break;
> >  	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
> > +		client.adapter->retries =3D params[1].u.value.b;
> >  		ret =3D i2c_master_send(&client, params[2].u.memref.shm->kaddr,
> >  				      params[2].u.memref.size);
> >  		break;
> > @@ -126,6 +132,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct t=
ee_context *ctx,
> >  			arg->ret =3D TEEC_SUCCESS;
> >  	}
> > =20
> > +	client.adapter->retries =3D retries;
> >  	i2c_put_adapter(client.adapter);
> >  	kfree(params);
> >  	return;
> > --=20
> > 2.17.1
> >=20

--===============2973211942753470273==--

