From: Jarkko Sakkinen <jarkko@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 0/4] Introduce TEE based Trusted Keys support
Date: Sat, 13 Mar 2021 12:44:55 +0200
Message-ID: <YEyXpwilJq8DR7vI@kernel.org>
In-Reply-To: <5dfe8f6b5f25cc38c8410b849aaef2c3dbed7f65.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7194745544199558629=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7194745544199558629==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 12, 2021 at 08:30:36AM -0800, James Bottomley wrote:
> On Fri, 2021-03-12 at 18:26 +0200, Jarkko Sakkinen wrote:
> > On Wed, Mar 10, 2021 at 02:26:27PM -0800, James Bottomley wrote:
> > > On Wed, 2021-03-10 at 21:56 +0200, Jarkko Sakkinen wrote:
> > > [...]
> > > > I also need to apply=20
> > > >=20
> > > > https://lore.kernel.org/linux-integrity/20210127190617.17564-1-James.=
Bottomley(a)HansenPartnership.com/
> > > >=20
> > > > and I would like to do both while I'm at it.
> > > >=20
> > > > James, there was one patch that needed fixing but I cannot find
> > > > lore.kernel.org link. Can you point me to that so that we
> > > > can proceed?
> > >=20
> > > I think you mean this one observing a missing space in the commit
> > > message:
> > >=20
> > > https://lore.kernel.org/keyrings/1327393.1612972717(a)warthog.procyon.o=
rg.uk/
> > >=20
> > > James
> >=20
> > Makefile needed fixing (separate lines), and spaces where missing
> > between
> > commas in one file (checkpatch complained).
> >=20
> > I digged a version from my reflog but as I noted privately it's
> > missing one
> > file.
> >=20
> > Either provide that file or send a new version of the full patch set.
>=20
> This is the file that got lost
>=20
> James
>=20

> ---
> --- ASN.1 for TPM 2.0 keys
> ---
>=20
> TPMKey ::=3D SEQUENCE {
> 	type		OBJECT IDENTIFIER ({tpm2_key_type}),
> 	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
> 	parent		INTEGER ({tpm2_key_parent}),
> 	pubkey		OCTET STRING ({tpm2_key_pub}),
> 	privkey		OCTET STRING ({tpm2_key_priv})
> 	}

Thanks, NP, I amended the commit.

/Jarkko


/Jarkko

--===============7194745544199558629==--

