From: Randy Li <ayaka@soulik.info>
To: op-tee@lists.trustedfirmware.org
Subject: 
 optee: os: toolchains would include linux target macros likes __linux__
Date: Mon, 04 Dec 2023 21:39:14 +0800
Message-ID: <bfba8d2c-646d-4d62-9f71-8e388e70f782@soulik.info>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1300780907760153709=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1300780907760153709==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello

I wonder why Optee OS would use a linux target toolchains but not a bare=20
metal target(none os)?

gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu=
-gcc=20
-dM -E - < /dev/null|grep linux
#define __linux 1
#define __gnu_linux__ 1
#define linux 1
#define __linux__ 1

That makes hard to share a header files between Linux kernel and Optee.=C2=A0=
=20
We like to pass some structure in SHM, but optee don't have all those=20
Linux types likes <linux/types.h>.

If optee didn't choose the toolchains for the Linux, we could easily=20
decide which part would use for Client Agent(Linux kernel) side or TEE=20
OS side.

Why we don't use bare metal toolchains ?


Thank you

Randy Li


--===============1300780907760153709==--

