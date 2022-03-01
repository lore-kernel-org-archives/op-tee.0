From: Miklos Balint <Miklos.Balint@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: Secure Storage Applications
Date: Tue, 01 Mar 2022 19:16:42 +0000
Message-ID: <VI1PR0802MB251103B72492C27C9351B308E6029@VI1PR0802MB2511.eurprd08.prod.outlook.com>
In-Reply-To: <20220223120945.uq2lwqwb2ldv64k6@ula0497581>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8696012364824271817=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8696012364824271817==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Manorit,

You may be interested in the Trusted Services project and its relation to OP-=
TEE.
This recent announcement on the op-tee mailing list describes an extension of=
 OP-TEE with an additional feature:
https://lists.trustedfirmware.org/archives/list/op-tee(a)lists.trustedfirmwar=
e.org/thread/HCIYYT6BZ55L7AZNBDPUSP6TDPF3TCWV/

The key message in the linked wiki entry https://developer.trustedfirmware.or=
g/w/trusted-services/op-tee-spmc/ from your perspective might be that OP-TEE =
now has a capability to run so called Trusted Services, which implement PSA F=
unctional API, including, but not limited to, its Secure Storage API:
https://www.psacertified.org/development-resources/building-in-security/speci=
fications-implementations/#functional-apis
This provides a client application with a generic interface for using secure =
storage functionality.

Please be mindful of the limitations mentioned on the linked page as this is =
project is still work in progress, but we would be more than happy to get fee=
dback on what we have done, and whether it can meet your expectations.

Regards,
Miklos

-----Original Message-----
From: Manorit Chawdhry <m-chawdhry@ti.com>=20
Sent: 23 February 2022 13:10
To: Joakim Bech <joakim.bech@linaro.org>
Cc: op-tee(a)lists.trustedfirmware.org; p.yadav(a)ti.com
Subject: Re: Secure Storage Applications

On 09:56-20220223, Joakim Bech wrote:
> Hi,
>=20
Hi,

Thank you all for your replies. Those have been really helpful!

Though from all the links you have shared, I am still wondering if there is a=
ny core part in OP-TEE which could allow to provide a generic interface for u=
sing the secure storage functionality instead of we needing to setup our own =
TA ( along with some binary on the host with the simple purpose of putting fi=
les from Linux in secure storage. )

As this seemed somewhat intuitive to me from a perspective of user wanting to=
 try out secure_storage and would be interested to know if something like thi=
s is available in it.=20

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
> > > I have been exploring secure storage in OP-TEE for a few days and=20
> > > I need some help in putting some files into it.
> > >
> > > I have been trying to find some tool which could help me put any=20
> > > files from Linux into secure storage and retrieve them back later=20
> > > so that I could see secure storage in action but haven't been able to f=
ind any yet.
> > >
> > > Is there any tool which you guys might know of which helps put=20
> > > files in secure storage and retrieve them back later?
> > >
> >=20
> > I would suggest you have a look at storage tests from OP-TEE test=20
> > suite here: client  [1] and TA [2].
> >=20
> > [1]=20
> > https://github.com/OP-TEE/optee_test/blob/master/host/xtest/regressi
> > on_6000.c [2]=20
> > https://github.com/OP-TEE/optee_test/tree/master/ta/storage
> >=20
> In addition to that we also have the secure storage example TA [3],=20
> that comes deployed with our developer environments (QEMU [4] is an=20
> example of such an environment).
>=20
> [3]=20
> https://github.com/linaro-swg/optee_examples/tree/master/secure_storag
> e [4]=20
> https://optee.readthedocs.io/en/latest/building/devices/qemu.html
>=20
> > -Sumit
> >=20
> > > Best Regards,
> > > Manorit
>=20
> // Regards,
> Joakim

--===============8696012364824271817==--

