From: 梅建强(禹夜) <meijianqiang.mjq@alibaba-inc.com>
To: op-tee@lists.trustedfirmware.org
Subject: optee xtest cannot run success stably
Date: Mon, 20 Mar 2023 11:43:37 +0800
Message-ID: 
 <1b8fabc9-a521-4489-8817-a34c91288ec7.meijianqiang.mjq@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4185372977135489208=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4185372977135489208==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi, experts
Recently, we are testing the stability for running optee xtest with environme=
nt that hafnium runs as SPMC and optee runs on SPMC as SP.
When we reboot the system, xtest failed on some cases with TEEC_ERROR_OUT_OF_=
MEMORY.
It seems to be that there is an insufficient memory allocation somewhere in t=
he chain.
We tried the following:=20
Using Single core startup,=20
Increased optee MAX_XLAT_TABLES size to 16,
Increased optee CFG_CORE_HEAP_SIZE to 0x2000000,=20
Increasing the size of optee CFG_TEE_RAM_VA_SIZE to 0x4000000,
 Increasing the size of hafnium heap_pages to 8192,=20
But nothing seems to be working.=20
Can you offer any help or suggestions?
Some other configuration for optee is attached in the issue:
https://github.com/OP-TEE/optee_os/issues/5893 <https://github.com/OP-TEE/opt=
ee_os/issues/5893 >
Regards,
Yuye.

--===============4185372977135489208==--

