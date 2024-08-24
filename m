From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 0/4] Replay Protected Memory Block (RPMB) subsystem
Date: Sat, 24 Aug 2024 11:13:29 +0800
Message-ID: <2024082414-doily-camisole-b5c7@gregkh>
In-Reply-To: <
 <CAPDyKFqBuQ8uUdeThRaJtd2CYNWMmpLCEDxfO+znhwjPamH+Gg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8520656703526154986=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8520656703526154986==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 11:23:03PM +0200, Ulf Hansson wrote:
> On Wed, 14 Aug 2024 at 17:36, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Hi,
> >
> > This patch set is getting ready to be queued for the next merge window. T=
he
> > issues reported by Mikka in the v7 patch set has been resolved, the issues
> > turned out to be outside of the v7 patch set relating to configuration in
> > the secure world. I'm planning a pull request to arm-soc, but before that
> > I'd rather have acks or at least an OK for:
> > - "rpmb: add Replay Protected Memory Block (RPMB) subsystem" by Greg
> > - "mmc: block: register RPMB partition with the RPMB subsystem" by Ulf
> >
> > Arnd, please let me know if anything else is missing.
>=20
> Greg, Jens,
>=20
> To help out with the merging strategy, I don't mind queuing this whole
> series via my mmc tree. It would also be nice to let it cook in
> linux-next for while, via my next branch.
>=20
>  From my point of view this looks good to me now, but please let me
> know if you prefer a different route or if you have any further
> comments.

No objection from me, please take it through your tree, makes it simpler
for me :)

greg k-h

--===============8520656703526154986==--

