From: Jan Claußen <jan.claussen10@web.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: How to sign TAs with an HSM?
Date: Wed, 15 Nov 2023 14:38:05 +0100
Message-ID: <756A14AB-7D5B-4EB4-B980-50EB714532CD@getmailspring.com>
In-Reply-To: <4CCC8610-79B9-4890-AF1F-7A0AA56F0C20@getmailspring.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6505618692234222392=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6505618692234222392==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Sign the TAs using the private key I meant...

On Nov. 15 2023, at 2:35 pm, Jan Clau=C3=9Fen <jan.claussen10@web.de> wrote:
> There is one thing I really don't understand about the offline signing proc=
ess for TAs using an HSM:
>
> In the documentation (https://link.getmailspring.com/link/756A14AB-7D5B-4EB=
4-B980-50EB714532CD(a)getmailspring.com/0?redirect=3Dhttps%3A%2F%2Foptee.read=
thedocs.io%2Fen%2Flatest%2Fbuilding%2Ftrusted_applications.html%23signing-of-=
tas&recipient=3Db3AtdGVlQGxpc3RzLnRydXN0ZWRmaXJtd2FyZS5vcmc%3D) it says to ge=
nerate a keypair with openssl and sign the TAs using the public key as ${TA_S=
IGN_KEY}. In point 4. the usage of an HSM is described, but since it is not p=
ossible to extract the private key from an HSM, I wonder how steps 3.-5. are =
even possible. Do you mix the previously generated RSA key with the one from =
the HSM? I cannot image that is as it should be.
> Can you please clarify this! Thank you

--===============6505618692234222392==--

