From: Jarkko Sakkinen <jarkko@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 0/4] Introduce TEE based Trusted Keys support
Date: Fri, 06 Nov 2020 16:52:52 +0200
Message-ID: <20201106145252.GA10434@kernel.org>
In-Reply-To: <
 <CAFA6WYPetvod-Wov2n_L5TL771j+-kt+_csyWYT-uM=haEKMZQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2796725414293718097=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2796725414293718097==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2020 at 03:02:41PM +0530, Sumit Garg wrote:
> On Thu, 5 Nov 2020 at 10:37, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Tue, Nov 03, 2020 at 09:31:42PM +0530, Sumit Garg wrote:
> > > Add support for TEE based trusted keys where TEE provides the functiona=
lity
> > > to seal and unseal trusted keys using hardware unique key. Also, this is
> > > an alternative in case platform doesn't possess a TPM device.
> > >
> > > This patch-set has been tested with OP-TEE based early TA which is alre=
ady
> > > merged in upstream [1].
> >
> > Is the new RPI400 computer a platform that can be used for testing
> > patch sets like this? I've been looking for a while something ARM64
> > based with similar convenience as Intel NUC's, and on the surface
> > this new RPI product looks great for kernel testing purposes.
>=20
> Here [1] is the list of supported versions of Raspberry Pi in OP-TEE.
> The easiest approach would be to pick up a supported version or else
> do an OP-TEE port for an unsupported one (which should involve minimal
> effort).
>=20
> [1] https://optee.readthedocs.io/en/latest/building/devices/rpi3.html#what-=
versions-of-raspberry-pi-will-work
>=20
> -Sumit

If porting is doable, then I'll just order RPI 400, and test with QEMU
up until either I port OP-TEE myself or someone else does it.

For seldom ARM testing, RPI 400 is really convenient device with its
boxed form factor.

/Jarkko

--===============2796725414293718097==--

