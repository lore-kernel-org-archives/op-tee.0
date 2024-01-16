From: Jan Claußen <jan.claussen10@web.de>
To: op-tee@lists.trustedfirmware.org
Subject: HSM offline signing of TAs
Date: Tue, 16 Jan 2024 13:34:14 +0100
Message-ID: <29B0DD53-3CC6-4FC3-8D9E-340FE26E0FE0@getmailspring.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3233794347436768615=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3233794347436768615==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I have recently commited some changes to the OP-TEE docs regarding the offlin=
e signing of TAs. I have now revisited my work after the holidays and the sig=
ning process is now failing with

ERROR:sign_encrypt.py:Verification failed, ignoring given signature.
although I am sure not to have changed anything. There is no TA being producd=
 anymore. I am currently not sure if I made a mistake and did not see this, a=
lthough I think I should have realized that no TAs are produced successfully.
I am currently a bit pressed for time and was hoping that someone could assis=
t me with the signing process. In the previous version there was a header pre=
pended to the file that is to be signed
echo "0000: 3031300D 06096086 48016503 04020105 000420" | \
xxd -c 19 -r > /tmp/sighdr
cat /tmp/sighdr $(base64 --decode digestfile) > /tmp/hashtosign

This script did not work and I omitted it. Can someone tell me why this was n=
eeded in the first place or how I could fix this step?
I tried fixing the step as follows
echo "0000: 3031300D 06096086 48016503 04020105 000420" | \
xxd -c 19 -r > /tmp/sighdr
base64 --decode digestfile > /tmp/digestfile
cat /tmp/sighdr /tmp/digestfile > /tmp/hashtosign

but the pkcs11-tool then complains that the signature is too long.
Any help appreciated!
---
Jan

--===============3233794347436768615==--

