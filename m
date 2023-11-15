From: Jan Claußen <jan.claussen10@web.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: How to sign TAs with an HSM?
Date: Wed, 15 Nov 2023 19:43:48 +0100
Message-ID: <22295FD3-6EB0-4E2E-936A-B15770F89869@web.de>
In-Reply-To: <292BEFBD-A3EC-4AFF-99FB-4BBE9CEFD2CE@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1802456180927724806=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1802456180927724806==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I guess the pkcs11-tool is just an example for signing and I would have to co=
me up with a way to calculate the digest and stitch everything back together =
myself, don=E2=80=99t I?

> Am 15.11.2023 um 19:35 schrieb Jan Clau=C3=9Fen <jan.claussen10@web.de>:
>=20
> =EF=BB=BFI had no luck today with the HSM signing. Neither with the describ=
ed solution using the pkcs11-tool or openssl with the pkcs11 engine. I also w=
onder if the header in the documentation will be the same in any case or if I=
 have to prepend my own header. This part is not documented. Would be great i=
f some could get back to me regarding this!
>=20
>> Am 15.11.2023 um 17:56 schrieb Jan Clau=C3=9Fen <jan.claussen10@web.de>:
>>=20
>> =EF=BB=BF
>> The example shell script for the pkcs11-tools does not work btw. This coul=
d be fixed!


--===============1802456180927724806==--

