From: Jan Claußen <jan.claussen10@web.de>
To: op-tee@lists.trustedfirmware.org
Subject: Is it possible to sign a TA twice?
Date: Tue, 14 Nov 2023 15:41:35 +0100
Message-ID: <2CB1C811-F640-405B-A05B-D30A98A58933@getmailspring.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1761732930806543162=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1761732930806543162==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I am currently trying to sing a few TAs using the Yocto environment, namely

The three in-tree TAs shipped with optee-os
oemcrypto needed for widevine

For some reason I can't sign oemcrypto successfully using the offline singing=
 method described in the documentation. I could however successfully exchange=
 the default_ta.pem successfully to accomplish the above. optee-os is then bu=
ilt with the exchanged default private key and the oemcrypto recipe pulls thi=
s key as dependency.
This is not optimal though, since we want to use an HSM for offline signing t=
o increase security. I am therefore suspecting that oemcrypto is somehow sign=
ed differently or that that the stripped.elf is somehow different. From what =
I have read, it should not matter though what you sign you TA with during the=
 build. You can always create the digest, sign and stitch everything back tog=
ether. For some reason this does not work. If I sideload the oemcrypto TA tha=
t was built by exchanging the default_ta.pem file, everything works again.
Do you have an idea what is happening here?

--===============1761732930806543162==--

