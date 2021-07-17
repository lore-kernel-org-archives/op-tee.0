From: Rafael Gameiro <rr.gameiro@campus.fct.unl.pt>
To: op-tee@lists.trustedfirmware.org
Subject: OP-TEE SKS
Date: Sat, 17 Jul 2021 17:29:26 +0100
Message-ID: 
 <CAAwxyZ_eahZo8J2QSvbQ4xNOJwGa9YtkFCQ82OTXYSVtp00CtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1831054492675088873=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1831054492675088873==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Greetings,



I=E2=80=99m Rafael Gameiro, and I=E2=80=99m currently doing my Thesis in Msc =
Computer
Science course of FCT NOVA University of Lisbon.



As the subject suggests, I have come across a presentation Linaro did some
years ago [1]. In my thesis, I have been trying to create an attestation
ta, that generates an attestation proof of a set of components created by
me. To ensure trustability over this attestation service, I thought I could
use this SKS to possibly generate a keypair, and perform the sign operation
that I need to generate the attestation proof.

I searched for this SKS on OP-TEE OS [2], OP-TEE Client [3], and OP-TEE
Tests[4], but I did not found any TA that explicitly said it was the SKS
that was referred in the said presentation. The only possible comparisons I
found were the TEE_AsymmetricSignDigest etc functions, derived from GP
internal API, and the TA PKCS#11.


My Question is, does this SKS still exists, and if yes, where could I find
it.

If not, does one of the above mentioned libraries is a SKS "replacement"?
If yes, which one?



Thank you for your time.



Best regards,

Rafael Gameiro


[1]
https://pt.slideshare.net/linaroorg/hkg18402-build-secure-key-management-serv=
ices-in-optee

[2] https://github.com/OP-TEE/optee_os

[3] https://github.com/OP-TEE/optee_client

[4] https://github.com/OP-TEE/optee_test

--===============1831054492675088873==--

