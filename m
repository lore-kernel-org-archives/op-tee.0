From: Hareesh Das Ulleri <hareesh.ulleri@ovt.com>
To: op-tee@lists.trustedfirmware.org
Subject: SSH - OpTee reboot scenario Issue
Date: Fri, 17 May 2024 08:41:51 +0000
Message-ID: <SJ0PR22MB3755DA143EE0A88DAC4C5EB19DEE2@SJ0PR22MB3755.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2669409435323750995=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2669409435323750995==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello All,

[please suggest the email list if this is not the right platform to discuss, =
sorry for that]

We use Op-tee (3.18) in our ARM64 based project (Linux 5.15.14+) for cryption=
, so basically it is like " OpenSSH -> OpenSSL -> OpTee -> HSM". It works fin=
e until we tried with a test scenario of reboot request via SSH.

When we request the system reboot via SSH, the shutting down looks not a grac=
eful way (ssh client connection exception). This is only we add OpTee layer, =
otherwise everything works fine. I would like to know anyone has encountered =
similar kind of issue where OpTee has to take care any special shutting down =
process. Any leads much appreciated !

Thanks & Regards,
Hareesh

--===============2669409435323750995==--

