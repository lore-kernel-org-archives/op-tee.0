From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: [RFC, PATCH 0/1] Replay Protected Memory Block (RPMB) driver
Date: Sat, 22 Jul 2023 01:41:11 +0000
Message-ID: <20230722014037.42647-1-shyamsaini@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1189838852557195210=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1189838852557195210==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

This is yet another attempt to come up with an RPMB API for the kernel.
This patch is based on patch 1 of last submission except few minor changes.
The last discussion of this was in the thread:

  Subject: [PATCH  v2 1/4] rpmb: add Replay Protected Memory Block (RPMB) sub=
system
  Date: Tue,  5 Apr 2022 10:37:56 +0100 [thread overview]
  Message-ID: <20220405093759.1126835-2-alex.bennee@linaro.org>

The patch provides a simple RPMB driver. This is a RFC version and this
single driver can't be used by its own. It would require further work to
make use of API's provided by this driver.

Changes since the last posting:
  drop RPMB char driver
  drop virtio rpmb frontend driver
  drop rpmb: add RPBM access tool
  Rename get_write_count to get_write_counter
  Make return type for rpmb_set_key() function explicit

Alex Benn=C3=A9e (1):
  rpmb: add Replay Protected Memory Block (RPMB) driver

 MAINTAINERS           |   7 +
 drivers/Kconfig       |   1 +
 drivers/Makefile      |   2 +
 drivers/rpmb/Kconfig  |  11 ++
 drivers/rpmb/Makefile |   7 +
 drivers/rpmb/core.c   | 439 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/rpmb.h  | 182 +++++++++++++++++
 7 files changed, 649 insertions(+)
 create mode 100644 drivers/rpmb/Kconfig
 create mode 100644 drivers/rpmb/Makefile
 create mode 100644 drivers/rpmb/core.c
 create mode 100644 include/linux/rpmb.h

--=20
2.34.1


--===============1189838852557195210==--

