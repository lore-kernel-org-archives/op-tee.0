From: Jérôme Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: How to sign TAs with an HSM?
Date: Thu, 16 Nov 2023 00:21:25 +0100
Message-ID: 
 <CAA-cTWZKFYerFgQTQFBF6jFQ8QN7+jQT_6QqQcEJyFCFiHR1yg@mail.gmail.com>
In-Reply-To: <22295FD3-6EB0-4E2E-936A-B15770F89869@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1254250773787390757=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1254250773787390757==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Jan,

I believe the documentation at [1] has some issues and should be revised.
Please refer to the output of:

  sign_encrypt.py --help
  sign_encrypt.py digest --help
  sign_encrypt.py stitch --help

The script can be found in optee_os/scripts.
From the help text and my recollection if all this, here are some commands
that should hopefully help (untested):

- To generate the digest (<UUID>.dig) you use "sign_encrypt.py digest":
$ sign_encrypt.py digest --uuid <UUID> --in path/to/<UUID>.stripped.elf
--key path/to/<your-public-key>.pem --dig <UUID>.dig

- Then you sign the digest with the HSM using pkcs11-tool:
$ pkcs11-tool --id <your-key-id> -s --login -m RSA-PKCS-PSS
--hash-algorithm SHA256 --mgf MGF1-SHA256 --input-file <UUID>.dig |  base64
> <UUID>.sig

- Finally to create the signed TA you use "sign_encrypt.py stitch"
$ sign_encrypt.py stitch --uuid <UUID> --in path/to/<UUID>.stripped.elf
--key <your-public-key>.pem --sig <UUID>.sig --out <UUID>.ta

Make sure OP-TEE is built with "make TA_PBLIC_KEY=3D<your-public-key>.pem" as
documented in mk/config.mk.

[1]
https://optee.readthedocs.io/en/latest/building/trusted_applications.html#off=
line-signing-of-tas

HTH,
--=20
Jerome

On Wed, Nov 15, 2023 at 7:44=E2=80=AFPM Jan Clau=C3=9Fen <jan.claussen10@we=
b.de> wrote:

> I guess the pkcs11-tool is just an example for signing and I would have to
> come up with a way to calculate the digest and stitch everything back
> together myself, don=E2=80=99t I?
>
> > Am 15.11.2023 um 19:35 schrieb Jan Clau=C3=9Fen <jan.claussen10@web.de>:
> >
> > =EF=BB=BFI had no luck today with the HSM signing. Neither with the descr=
ibed
> solution using the pkcs11-tool or openssl with the pkcs11 engine. I also
> wonder if the header in the documentation will be the same in any case or
> if I have to prepend my own header. This part is not documented. Would be
> great if some could get back to me regarding this!
> >
> >> Am 15.11.2023 um 17:56 schrieb Jan Clau=C3=9Fen <jan.claussen10@web.de=
>:
> >>
> >> =EF=BB=BF
> >> The example shell script for the pkcs11-tools does not work btw. This
> could be fixed!
>
>

--===============1254250773787390757==--

