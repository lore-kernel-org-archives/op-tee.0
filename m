From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH 0/9] firmware: arm_ffa: Refactoring and initial/minor v1.1 update
Date: Tue, 30 Aug 2022 11:06:51 +0100
Message-ID: <20220830100700.344594-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8436945021304743404=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8436945021304743404==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

This series is just some refactoring in preparation to add FF-A v1.1 support.
It doesn't have any memory layout or notification changes supported in v1.1
yet.

Regards,
Sudeep

Sudeep Holla (9):
  firmware: arm_ffa: Add pointer to the ffa_dev_ops in struct ffa_dev
  tee: optee: Use ffa_dev->ops directly
  firmware: arm_ffa: Remove ffa_dev_ops_get()
  firmware: arm_ffa: Add support for querying FF-A features
  firmware: arm_ffa: Use FFA_FEATURES to detect if native versions are suppor=
ted
  firmware: arm_ffa: Make memory apis ffa_device independent
  firmware: arm_ffa: Add v1.1 get_partition_info support
  tee: optee: Drop ffa_ops in optee_ffa structure
  firmware: arm_ffa: Split up ffa_dev_ops into info, message and memory opera=
tions

 drivers/firmware/arm_ffa/bus.c    |   4 +-
 drivers/firmware/arm_ffa/driver.c | 111 ++++++++++++++++++++++--------
 drivers/tee/optee/ffa_abi.c       |  40 +++++------
 drivers/tee/optee/optee_private.h |   1 -
 include/linux/arm_ffa.h           |  34 +++++----
 5 files changed, 127 insertions(+), 63 deletions(-)

--=20
2.37.2


--===============8436945021304743404==--

