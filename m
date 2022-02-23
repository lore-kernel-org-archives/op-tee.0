From: Manorit Chawdhry <m-chawdhry@ti.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Secure Storage Applications
Date: Wed, 23 Feb 2022 17:39:45 +0530
Message-ID: <20220223120945.uq2lwqwb2ldv64k6@ula0497581>
In-Reply-To: <20220223085600.ny6sp3pgppmubz3n@tuxedo>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3206324920695907768=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3206324920695907768==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 09:56-20220223, Joakim Bech wrote:
> Hi,
>=20
Hi,

Thank you all for your replies. Those have been really helpful!

Though from all the links you have shared, I am still wondering if there is a=
ny
core part in OP-TEE which could allow to provide a generic interface for
using the secure storage functionality instead of we needing to setup
our own TA ( along with some binary on the host with the simple purpose of
putting files from Linux in secure storage. )

As this seemed somewhat intuitive to me from a perspective of user
wanting to try out secure_storage and would be interested to know if
something like this is available in it.=20

Thanks and regards,
Manorit

> On Wed, Feb 23, 2022 at 11:37:33AM +0530, Sumit Garg wrote:
> > Hi Manorit,
> >=20
> > On Tue, 22 Feb 2022 at 18:59, Manorit Chawdhry <m-chawdhry@ti.com> wrot=
e:
> > >
> > > Hi,
> > >
> > > I have been exploring secure storage in OP-TEE for a few days and I need
> > > some help in putting some files into it.
> > >
> > > I have been trying to find some tool which could help me put any files =
from
> > > Linux into secure storage and retrieve them back later so that I could
> > > see secure storage in action but haven't been able to find any yet.
> > >
> > > Is there any tool which you guys might know of which helps put files in
> > > secure storage and retrieve them back later?
> > >
> >=20
> > I would suggest you have a look at storage tests from OP-TEE test
> > suite here: client  [1] and TA [2].
> >=20
> > [1] https://github.com/OP-TEE/optee_test/blob/master/host/xtest/regressio=
n_6000.c
> > [2] https://github.com/OP-TEE/optee_test/tree/master/ta/storage
> >=20
> In addition to that we also have the secure storage example TA [3], that
> comes deployed with our developer environments (QEMU [4] is an example
> of such an environment).
>=20
> [3] https://github.com/linaro-swg/optee_examples/tree/master/secure_storage
> [4] https://optee.readthedocs.io/en/latest/building/devices/qemu.html
>=20
> > -Sumit
> >=20
> > > Best Regards,
> > > Manorit
>=20
> // Regards,
> Joakim

--===============3206324920695907768==--

