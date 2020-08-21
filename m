From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] tee memref null for v5.10
Date: Fri, 21 Aug 2020 12:25:35 +0200
Message-ID: <20200821102535.GA1872111@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6812033489853408750=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6812033489853408750==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this patch enabling a TEE client to indicate a NULL pointer
instead of a valid buffer when invoking a Trusted Application.

Thanks,
Jens

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-memref-nu=
ll-for-v5.10

for you to fetch changes up to ba171d3f0850003216fd1a85190d17b1feddb961:

  driver: tee: Handle NULL pointer indication from client (2020-08-21 08:55:1=
3 +0200)

----------------------------------------------------------------
Handle NULL pointer indication from tee client

Adds support to indicate NULL pointers instead of a valid buffer when
querying the needed size of a buffer.

----------------------------------------------------------------
Cedric Neveux (1):
      driver: tee: Handle NULL pointer indication from client

 drivers/tee/optee/core.c      |  7 +++++++
 drivers/tee/optee/optee_smc.h |  3 +++
 drivers/tee/tee_core.c        | 49 +++++++++++++++++++++++++++--------------=
--
 include/linux/tee_drv.h       |  3 +++
 include/uapi/linux/tee.h      | 13 ++++++++++++
 5 files changed, 57 insertions(+), 18 deletions(-)

--===============6812033489853408750==--

