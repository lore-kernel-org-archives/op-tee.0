From: Jarkko Sakkinen <jarkko@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 0/4] Introduce TEE based Trusted Keys support
Date: Fri, 12 Mar 2021 18:26:53 +0200
Message-ID: <YEuWTet0wr5DuDy/@kernel.org>
In-Reply-To: <9aa3173ab46b0aa7edb8146ffd3df05c1f74207e.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5030168520932951088=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5030168520932951088==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 10, 2021 at 02:26:27PM -0800, James Bottomley wrote:
> On Wed, 2021-03-10 at 21:56 +0200, Jarkko Sakkinen wrote:
> [...]
> > I also need to apply=20
> >=20
> > https://lore.kernel.org/linux-integrity/20210127190617.17564-1-James.Bott=
omley(a)HansenPartnership.com/
> >=20
> > and I would like to do both while I'm at it.
> >=20
> > James, there was one patch that needed fixing but I cannot find
> > lore.kernel.org link. Can you point me to that so that we
> > can proceed?
>=20
> I think you mean this one observing a missing space in the commit
> message:
>=20
> https://lore.kernel.org/keyrings/1327393.1612972717(a)warthog.procyon.org.u=
k/
>=20
> James

Makefile needed fixing (separate lines), and spaces where missing between
commas in one file (checkpatch complained).

I digged a version from my reflog but as I noted privately it's missing one
file.

Either provide that file or send a new version of the full patch set.

/Jarkko

--===============5030168520932951088==--

