From: Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: How to sign TAs with an HSM?
Date: Thu, 16 Nov 2023 08:53:00 +0000
Message-ID: <9b409109dfa04aebbb1ee34952bc4935@foss.st.com>
In-Reply-To: <
 <CAA-cTWZKFYerFgQTQFBF6jFQ8QN7+jQT_6QqQcEJyFCFiHR1yg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3123481853559718266=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3123481853559718266==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Dear all,

The method suggested by J=C3=A9r=C3=B4me is OP-TEE native way to stitch a sig=
nature computed offline, possibly through a PKCS#11 token.
An alternate way was proposed in discussion thread [1]. We proposed to integr=
ate use of python PKCS#11 support in OP-TEE's sign_encrypt.py script to autom=
ate the signing process using a PKCS#11 token. However, at the time there was=
 demand for such support so I dropped it.

Please tell us if you see an interest in rebasing the proposed change [1] in =
OP-TEE OS mainline repository.
If so, we could take a bit of time to do this but as usual, feel free to crea=
te a P-R and propose the required changes if you rather have them to be revie=
wed (eventually merged) in a short time frame.

[1] https://github.com/OP-TEE/optee_os/issues/5284#issuecomment-1112173121

Regards,
Etienne

________________________________________
From: J=C3=A9r=C3=B4me Forissier via OP-TEE <op-tee@lists.trustedfirmware.o=
rg>
Sent: Thursday, November 16, 2023 12:21:25 AM
To: Jan Clau=C3=9Fen
Cc: op-tee(a)lists.trustedfirmware.org
Subject: Re: How to sign TAs with an HSM?

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
--
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

--===============3123481853559718266==--

