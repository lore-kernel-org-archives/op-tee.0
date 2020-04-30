From: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [op-tee] [PATCH v2 0/3] tee: add support for session's client UUID generation
Date: Thu, 30 Apr 2020 15:37:08 +0300
Message-ID: <20200430123711.20083-1-vesa.jaaskelainen@vaisala.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6039968073389264299=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6039968073389264299==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

TEE Client API defines that from user space only information needed for
specified login operations is group identifier for group based logins.

REE kernel is expected to formulate trustworthy client UUID and pass that
to TEE environment. REE kernel is required to verify that provided group
identifier for group based logins matches calling processes group
memberships.

TEE specification only defines that the information passed from REE
environment to TEE environment is encoded into on UUID.

In order to guarantee trustworthiness of client UUID user space is not
allowed to freely pass client UUID.

Vesa J=C3=A4=C3=A4skel=C3=A4inen (3):
  tee: add support for session's client UUID generation
  tee: optee: Add support for session login client UUID generation
  [RFC] tee: add support for app id for client UUID generation

 drivers/tee/Kconfig      |   1 +
 drivers/tee/optee/call.c |   6 +-
 drivers/tee/tee_core.c   | 211 +++++++++++++++++++++++++++++++++++++++
 include/linux/tee_drv.h  |  16 +++
 4 files changed, 233 insertions(+), 1 deletion(-)

--=20
2.17.1

Changes v1->v2:

* Changed goto labels to be more logical
* Capture error if formatted string for UUIDv5 does not fit into buffer

Notes:

This patcheset has been designed so that it can be iteratively intergrated
meaning that the application ID (RFC patch) part can be left for later when
there is agreed solution for that.

TEE specification leaves Linux behavior undefined. It does not define any
UUID value for name space. UUID in here is randomly generated with uuidgen
tool.

I have also include amdtee people as this method probably should also be
applied in there.

Using op-tee(a)lists.trustedfirmware.org instead of tee-dev(a)lists.linaro.or=
g as
latter is deprecated old list.

Original issue in OP-TEE OS tracker:
https://github.com/OP-TEE/optee_os/issues/3642

Related reviews and demonstration for the concept:
https://github.com/linaro-swg/linux/pull/74
https://github.com/OP-TEE/optee_client/pull/195
https://github.com/OP-TEE/optee_test/pull/406

--===============6039968073389264299==--

