From: Joakim Bech <joakim.bech@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Secure Storage Applications
Date: Wed, 23 Feb 2022 09:56:00 +0100
Message-ID: <20220223085600.ny6sp3pgppmubz3n@tuxedo>
In-Reply-To: <
 <CAFA6WYMYzz__4nBgjcF4hcdMPLai8qkVa0g29nyHL3h+cNLvLw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7644110176853353668=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7644110176853353668==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 23, 2022 at 11:37:33AM +0530, Sumit Garg wrote:
> Hi Manorit,
>=20
> On Tue, 22 Feb 2022 at 18:59, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
> >
> > Hi,
> >
> > I have been exploring secure storage in OP-TEE for a few days and I need
> > some help in putting some files into it.
> >
> > I have been trying to find some tool which could help me put any files fr=
om
> > Linux into secure storage and retrieve them back later so that I could
> > see secure storage in action but haven't been able to find any yet.
> >
> > Is there any tool which you guys might know of which helps put files in
> > secure storage and retrieve them back later?
> >
>=20
> I would suggest you have a look at storage tests from OP-TEE test
> suite here: client  [1] and TA [2].
>=20
> [1] https://github.com/OP-TEE/optee_test/blob/master/host/xtest/regression_=
6000.c
> [2] https://github.com/OP-TEE/optee_test/tree/master/ta/storage
>=20
In addition to that we also have the secure storage example TA [3], that
comes deployed with our developer environments (QEMU [4] is an example
of such an environment).

[3] https://github.com/linaro-swg/optee_examples/tree/master/secure_storage
[4] https://optee.readthedocs.io/en/latest/building/devices/qemu.html

> -Sumit
>=20
> > Best Regards,
> > Manorit

// Regards,
Joakim

--===============7644110176853353668==--

