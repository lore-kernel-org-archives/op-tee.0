From: Mimi Zohar <zohar@linux.ibm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 3/4] doc: trusted-encrypted: updates with TEE as a new
 trust source
Date: Fri, 11 Dec 2020 10:29:05 -0500
Message-ID: <16a279eaf2c209345044c3b4e1e57e2878798940.camel@linux.ibm.com>
In-Reply-To: <20201211103627.GB12091@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7023452942776118608=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7023452942776118608==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-12-11 at 12:36 +0200, Jarkko Sakkinen wrote:
> On Wed, Dec 09, 2020 at 11:50:19AM -0500, Mimi Zohar wrote:
> > On Tue, 2020-12-08 at 19:49 +0200, Jarkko Sakkinen wrote:
> > > On Tue, Dec 08, 2020 at 10:02:57AM -0500, Mimi Zohar wrote:
> >=20
> > > > > Please also use a proper email client and split your paragraphs into
> > > > > at most 80 character lines with new line characters when writing em=
ail.
> > > > > I prefer to use 72 character line length so that there's some space
> > > > > for longer email threads.
> > > >=20
> > > > Sure, we'll re-post the suggested documentation changes/additions.
> > > >=20
> > >=20
> > > So. Wouldn't it be a better idea to post a patch that Sumit could
> > > squash to his (and add co-developed-by tag)?
> >=20
> > I just posted it on Elaine's behalf.
> >  =20
>=20
> I responded. It's good that this feedback came as I think the whole
> thing does not have the correct label for it.

Every HW is going to want to add "trusted keys" support.   We've seen
this with Udit Agarwal's "secure keys" proposal for NXP CAAM crypto HW
accelerator.  If we go down this route to extend "trusted keys" to
support specific implementations like this one, I strongly recommend
requiring an accompaying high-level threat model.  This is similar to
how new LSMs need to comply with Documentation/security/lsm-
development.rst.

Based on Elaine's work with OCP, an example of a high-level threat
model is "Common Security Threats v1.0=E2=80=9D (
https://www.opencompute.org/documents/common-security-threats-notes-1-pdf
 ).

thanks,

Mimi


--===============7023452942776118608==--

