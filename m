From: Jerome Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: optee: regression with kernel v5.14 (virtualization)
Date: Tue, 28 Sep 2021 15:08:46 +0200
Message-ID: <a0e1c245-8209-a173-18c4-d21433bf46bf@forissier.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2399252601643713302=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2399252601643713302==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

I met an issue when testing OP-TEE with the latest released kernel
(v5.14). The kernel won't boot when virtualization is enabled. More
precisely, the boot hangs as the optee driver is probed. The last line
on the console is:

[xxx] optee: probing for conduit method.

The issue can easily be reproduced in the QEMU OP-TEE environment as
documented in [1]:

$ repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml
$ repo sync -j10
$ cd linux
$ git fetch github --unshallow
$ git checkout v5.14
$ cd ../build
$ make -j2 toolchains
$ make -j10 XEN_BOOT=y run

[Note, if you switch between XEN_BOOT=y and the default build, you need
to "make arm-tf-clean"]

git bisect points at commit b5c10dd04b74 ("optee: Clear stale cache
entries during initialization") and reverting this commit on top of
v5.14 does resolve the issue.

Any idea what's wrong?

[1]
https://optee.readthedocs.io/en/latest/building/devices/qemu.html#qemu-v8

Thanks,
-- 
Jerome

--===============2399252601643713302==--

