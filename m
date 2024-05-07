From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 2/3] mmc: block: register RPMB partition with the RPMB
 subsystem
Date: Tue, 07 May 2024 11:21:58 +0200
Message-ID: 
 <CAHUa44GLGT7F0=LL6fjw1inf0N-OPpVL+D44F84yndUmk-xLhA@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CDM6PR04MB6575AC5DEB3A46D1AE11705FFC1B2=40DM6PR04MB?=
 =?utf-8?q?6575=2Enamprd04=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5804002082354241369=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5804002082354241369==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 9:36=E2=80=AFPM Avri Altman <Avri.Altman@wdc.com> w=
rote:
>
> > > > >
> > > > > Is it possible that idata->buf is not DMA capable? Any other ideas?
> > > >
> > > > Thanks for testing. I don't know, the idata->buf is allocated using
> > > > alloc_pages_exact(nr_pages * PAGE_SIZE, GFP_KERNEL | __GFP_ZERO); in
> > > > optee_pool_op_alloc_helper().
> > >
> > > Is this really true for idata->buf or isnt the complete RPMB frame
> > > memory allocated like this and therefore idata->buf not page aligned?
> >
> > You're right.
> Maybe add an assert of PAGE_ALIGNED(idata->buf)?

That might be a bit much. It turned out that there was a 2-byte
alignment causing the trouble. I don't know exactly what's needed, but
the amount used by kmalloc() by default is good.

Cheers,
Jens

>
> Thanks,
> Avri
>
> >
> > >
> > > For RPMB via tee-supplicant the idata->buf is allocated within
> > > memdup_user and therefore page aligned.
> >
> > Yes, that's a difference. Have you tested with page-aligned buffers to se=
e if it
> > helps?

--===============5804002082354241369==--

