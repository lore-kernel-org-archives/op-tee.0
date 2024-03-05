From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 RE: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 05 Mar 2024 12:55:17 +0000
Message-ID: <PH7PR11MB7605979F0DC103BFCC617FF2E5222@PH7PR11MB7605.namprd11.prod.outlook.com>
In-Reply-To: <
 <CACRpkdZBWBio8kvKuVzj2CknCb4eS=VB2EqUsAK-vf4e328icg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7950420151028662139=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7950420151028662139==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


> Hi Jens,
>=20
> thanks for your patch!
>=20
> On Tue, Feb 27, 2024 at 4:31=E2=80=AFPM Jens Wiklander <jens.wiklander@li=
naro.org>
> wrote:
>=20
> > A number of storage technologies support a specialised hardware
> > partition designed to be resistant to replay attacks. The underlying
> > HW protocols differ but the operations are common. The RPMB partition
> > cannot be accessed via standard block layer, but by a set of specific
> > RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and
> PROGRAM_KEY. Such a
> > partition provides authenticated and replay protected access, hence
> > suitable as a secure storage.
> >
> > The initial aim of this patch is to provide a simple RPMB driver
> > interface which can be accessed by the optee driver to facilitate
> > early RPMB access to OP-TEE OS (secure OS) during the boot time.
> >
> > A TEE device driver can claim the RPMB interface, for example, via
> > rpmb_interface_register() or rpmb_dev_find_device(). The RPMB driver
> > provides a callback to route RPMB frames to the RPMB device accessible
> > via rpmb_route_frames().
> >
> > The detailed operation of implementing the access is left to the TEE
> > device driver itself.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>=20
> I would mention in the commit that the subsystem is currently only used with
> eMMC but is designed to be used also by UFS and NVME. Nevertheless, no
> big deal so:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> > +config RPMB
> > +       tristate "RPMB partition interface"
> > +       depends on MMC
>=20
> depends on MMC || SCSI_UFSHCD || NVME_CORE ?
>=20
> Or do we want to hold it off until we implement the backends?

I believe I've sent the implementation for all the backends, need to search t=
he mailing list.



--===============7950420151028662139==--

