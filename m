From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] another OP-TEE fix for v5.15
Date: Wed, 13 Oct 2021 14:28:54 +0200
Message-ID: <20211013122854.GA1542549@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3562374957502448716=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3562374957502448716==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this OP-TEE driver fix to unregister OP-TEE client devices
from the TEE bus when the OP-TEE driver is unloaded.

Note that this is based on the previous already merged OP-TEE driver
fix.

Thanks,
Jens

The following changes since commit 88a3856c0a8c03188db7913f4d49379432fe1f93:

  tee/optee/shm_pool: fix application of sizeof to pointer (2021-09-14 07:54:=
56 +0200)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fix2-fo=
r-v5.15

for you to fetch changes up to 7f565d0ead264329749c0da488de9c8dfa2f18ce:

  tee: optee: Fix missing devices unregister during optee_remove (2021-10-12 =
13:24:39 +0200)

----------------------------------------------------------------
Fix missing devices unregister during optee_remove

Unregisters OP-TEE client devices (UUIDs of some known Trusted
Applications) from the TEE bus when the OP-TEE driver is unloaded.

----------------------------------------------------------------
Sumit Garg (1):
      tee: optee: Fix missing devices unregister during optee_remove

 drivers/tee/optee/core.c          |  3 +++
 drivers/tee/optee/device.c        | 22 ++++++++++++++++++++++
 drivers/tee/optee/optee_private.h |  1 +
 3 files changed, 26 insertions(+)

--===============3562374957502448716==--

