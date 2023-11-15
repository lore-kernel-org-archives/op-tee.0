From: Jan Claußen <jan.claussen10@web.de>
To: op-tee@lists.trustedfirmware.org
Subject: How to sign TAs with an HSM?
Date: Wed, 15 Nov 2023 14:35:53 +0100
Message-ID: <4CCC8610-79B9-4890-AF1F-7A0AA56F0C20@getmailspring.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0072686299421883846=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0072686299421883846==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

There is one thing I really don't understand about the offline signing proces=
s for TAs using an HSM:

In the documentation (https://link.getmailspring.com/link/4CCC8610-79B9-4890-=
AF1F-7A0AA56F0C20(a)getmailspring.com/0?redirect=3Dhttps%3A%2F%2Foptee.readth=
edocs.io%2Fen%2Flatest%2Fbuilding%2Ftrusted_applications.html%23signing-of-ta=
s&recipient=3Db3AtdGVlQGxpc3RzLnRydXN0ZWRmaXJtd2FyZS5vcmc%3D) it says to gene=
rate a keypair with openssl and sign the TAs using the public key as ${TA_SIG=
N_KEY}. In point 4. the usage of an HSM is described, but since it is not pos=
sible to extract the private key from an HSM, I wonder how steps 3.-5. are ev=
en possible. Do you mix the previously generated RSA key with the one from th=
e HSM? I cannot image that is as it should be.
Can you please clarify this! Thank you

--===============0072686299421883846==--

