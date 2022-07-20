From: Judy Wang <wangjudy@microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: Current design of tee-supplicant can't support ftpm requests during
 kernel space bootup
Date: Wed, 20 Jul 2022 03:51:57 +0000
Message-ID: <PUZP153MB06977BECD3377560AE02D4BFDC8E9@PUZP153MB0697.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1163178508923745393=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1163178508923745393==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

As we are developing platforms to enable RPMB secure storage + fTPM TA, we re=
alize that the current design of optee-os relying on a user space daemon tee-=
supplicant to serve requests cannot meet requirements of another open source =
linux kernel, IMA(Integrity Measurement Architecture). This module will try t=
o collect data from TPM devices, which in our case, is fTPM TA. It has to col=
lect data when kernel space is booting up, so we cannot delay these requests =
further until user space is up. With RPMB as our secure storage, some request=
s will be sent back to kernel space, but tee-supplicant context is not yet in=
itialized, which results in IMA detection of TPM devices failed. Therefore, f=
ailed on the measurements we need.
I am wondering if we have related discussion on how modify the design to serv=
e optee-os requests during kernel bootup. I can't find related topics in LKML=
 archive.

Thank you.
Judy.

Cat from /Documentation/ABI/testing/sysfs-bus-optee-devices
What:                /sys/bus/tee/devices/optee-ta-<uuid>/
Date:           May 2020
KernelVersion   5.8
Contact:        op-tee(a)lists.trustedfirmware.org<mailto:op-tee@lists.trus=
tedfirmware.org>
Description:
                  OP-TEE bus provides reference to registered drivers under t=
his directory. The <uuid>
                  matches Trusted Application (TA) driver and corresponding T=
A in secure OS. Drivers
                  are free to create needed API under optee-ta-<uuid> directo=
ry.

Reference:

fTPM TA: microsoft/MSRSec: Security and Privacy Research at Microsoft (github=
.com)<https://github.com/microsoft/MSRSec>
IMA enabling: https://sourceforge.net/p/linux-ima/wiki/Home/#enabling-ima-mea=
surement:~:text=3Dsystem%27s%20runtime%20integrity.-,Enabling%20IMA%2Dmeasure=
ment,-IMA%20was%20first


--===============1163178508923745393==--

