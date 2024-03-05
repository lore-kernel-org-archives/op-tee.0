From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 05 Mar 2024 16:30:13 +0100
Message-ID: 
 <CAHUa44HWNGmqpvoHssvV3DbsvpRVtQpT_HfYe+SLADk3LsmQqw@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CPH7PR11MB7605979F0DC103BFCC617FF2E5222=40PH7PR11MB?=
 =?utf-8?q?7605=2Enamprd11=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7071206045362780989=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7071206045362780989==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 1:55=E2=80=AFPM Winkler, Tomas <tomas.winkler@intel.=
com> wrote:
>
>
> > Hi Jens,
> >
> > thanks for your patch!
> >
> > On Tue, Feb 27, 2024 at 4:31=E2=80=AFPM Jens Wiklander <jens.wiklander@=
linaro.org>
> > wrote:
> >
> > > A number of storage technologies support a specialised hardware
> > > partition designed to be resistant to replay attacks. The underlying
> > > HW protocols differ but the operations are common. The RPMB partition
> > > cannot be accessed via standard block layer, but by a set of specific
> > > RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and
> > PROGRAM_KEY. Such a
> > > partition provides authenticated and replay protected access, hence
> > > suitable as a secure storage.
> > >
> > > The initial aim of this patch is to provide a simple RPMB driver
> > > interface which can be accessed by the optee driver to facilitate
> > > early RPMB access to OP-TEE OS (secure OS) during the boot time.
> > >
> > > A TEE device driver can claim the RPMB interface, for example, via
> > > rpmb_interface_register() or rpmb_dev_find_device(). The RPMB driver
> > > provides a callback to route RPMB frames to the RPMB device accessible
> > > via rpmb_route_frames().
> > >
> > > The detailed operation of implementing the access is left to the TEE
> > > device driver itself.
> > >
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > > Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> >
> > I would mention in the commit that the subsystem is currently only used w=
ith
> > eMMC but is designed to be used also by UFS and NVME. Nevertheless, no
> > big deal so:
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, I'll update the commit for the next version.

> >
> > > +config RPMB
> > > +       tristate "RPMB partition interface"
> > > +       depends on MMC
> >
> > depends on MMC || SCSI_UFSHCD || NVME_CORE ?
> >
> > Or do we want to hold it off until we implement the backends?
>
> I believe I've sent the implementation for all the backends, need to search=
 the mailing list.

I would prefer to only add the MMC backend now. I'm afraid that adding
more backends will risk stalling this patch set, besides I don't have
the code for it either. Eventual older patches will need to be rebased
and possibly redesigned to take the previous comments into account.

Thanks,
Jens

--===============7071206045362780989==--

