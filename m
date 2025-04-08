From: Stauffer Thomas MTANA <Thomas.Stauffer@mt.com>
To: op-tee@lists.trustedfirmware.org
Subject: Extract RPMB Key
Date: Tue, 08 Apr 2025 11:35:23 +0000
Message-ID: <GVXPR03MB10460083DA337669362105AB08AAA2@GVXPR03MB10460.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4967221075177673384=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4967221075177673384==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

As far as I understand there are currently two possibilities to setup an RPMB=
 with an appropriate key.

1. Use a specialized OP-TEE with CFG_RPMB_WRITE_KEY=3Dy during production in =
an environment were leaking the key is ok.
2. Get the HUK, get the CID from the MMC, then use scripts/derive_rpmb_key.py=
 to calculate the RPMB key and set e.g. via mmc tool.

I've the impression when I read through some message on https://github.com/OP=
-TEE/optee_os/issues, that 1 is not considered the best idea.

Currently I'm working on a iMX8M platform and using CFG_RPMB_WRITE_KEY also h=
as the drawback to use the legacy RPMB interface, which makes tee-supplicant =
still necessary, which otherwise would not be needed.

The problem at least on iMX8M is that its not easy possible to get the HUK, a=
nd the HUK also is different, depending if a device is in a closed state or n=
ot. To extract the whole HUK, even in a sensible environment during productio=
n, seems unnecessary.

What I did now, something very simple. I extended tee_rpmb_fs.c a little bit =
and made a function which allows to retrieve the RPMB key, I added also a tin=
y PTA, and a corresponding user space application to get the RPMB key, only a=
s long CFG_INSECURE is set, therefore also only a specialized OP-TEE build ca=
n provide this functionality.

Someone can now decide to get the RPMB key either before the device is closed=
 (for testing devices), or afterwards. Write then the RPMB key manually (e.g.=
 via mmc tool) and/or also store it securly in a production data database.

What would be the advantages, compared to CFG_RPMB_WRITE_KEY=3Dy

- HUK is still not leaked, as it may be used to derive other secrets
- derive_rpmb_key.py is not necessary
- It is guaranteed that the correct RPMB key is retrieved, 100% matches how O=
P-TEE was configured (e.g. with compat mode enabled or not)
- Because the RPMB key is known, one can manually still delete the RPMB and s=
ee how OP-TEE handles this situation, at least during development
- Testing this functionality also on an open device (which is currently not p=
ossible at least on iMX8M, due to plat_rpmb_key_is_ready)

My question is, if there would be any interest to open a PR, so other people =
also can use this?



--===============4967221075177673384==--

