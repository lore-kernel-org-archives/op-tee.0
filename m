From: Avri Altman <Avri.Altman@wdc.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: [PATCH v5 2/3] mmc: block: register RPMB partition with the RPMB
 subsystem
Date: Mon, 29 Apr 2024 19:36:44 +0000
Message-ID: <DM6PR04MB6575AC5DEB3A46D1AE11705FFC1B2@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <
 <CAHUa44HHtcaYXhcWg5zL5EQ8pEP7aEDKS+yjpaMJH8vTtF3xFw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0975952599598482995=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0975952599598482995==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> > > >
> > > > Is it possible that idata->buf is not DMA capable? Any other ideas?
> > >
> > > Thanks for testing. I don't know, the idata->buf is allocated using
> > > alloc_pages_exact(nr_pages * PAGE_SIZE, GFP_KERNEL | __GFP_ZERO); in
> > > optee_pool_op_alloc_helper().
> >
> > Is this really true for idata->buf or isnt the complete RPMB frame
> > memory allocated like this and therefore idata->buf not page aligned?
>=20
> You're right.
Maybe add an assert of PAGE_ALIGNED(idata->buf)?

Thanks,
Avri

>=20
> >
> > For RPMB via tee-supplicant the idata->buf is allocated within
> > memdup_user and therefore page aligned.
>=20
> Yes, that's a difference. Have you tested with page-aligned buffers to see =
if it
> helps?

--===============0975952599598482995==--

