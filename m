From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v2 00/10] firmware: arm_ffa: Refactoring and initial/minor v1.1 update
Date: Fri, 02 Sep 2022 13:40:22 +0100
Message-ID: <20220902124032.788488-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5988946040363173248=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5988946040363173248==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

This series is just some refactoring in preparation to add FF-A v1.1
support. It doesn't have any memory layout or notification changes
supported in v1.1 yet.

Regards,
Sudeep

v1[1]->v2:
	- Merged dropping of ffa_ops in optee_ffa structure and using
	  ffa_dev->ops into single patch
	- Added separate patch(didn't fit any patch strictly to fit in)
	  to rename ffa_dev_ops as ffa_ops as suggested by Sumit
	- Fixed some minor comments, handling size > structure size in
	  partition_info_get and added extra parameter to ffa_features
	  to get both possible output/interface properties.

[1] https://lore.kernel.org/all/20220830100700.344594-1-sudeep.holla(a)arm.co=
m/

Sudeep Holla (10):
  firmware: arm_ffa: Add pointer to the ffa_dev_ops in struct ffa_dev
  tee: optee: Drop ffa_ops in optee_ffa structure using ffa_dev->ops directly
  firmware: arm_ffa: Remove ffa_dev_ops_get()
  firmware: arm_ffa: Add support for querying FF-A features
  firmware: arm_ffa: Use FFA_FEATURES to detect if native versions are suppor=
ted
  firmware: arm_ffa: Make memory apis ffa_device independent
  firmware: arm_ffa: Rename ffa_dev_ops as ffa_ops
  firmware: arm_ffa: Add v1.1 get_partition_info support
  firmware: arm_ffa: Set up 32bit execution mode flag using partiion property
  firmware: arm_ffa: Split up ffa_ops into info, message and memory operations

 drivers/firmware/arm_ffa/bus.c    |   4 +-
 drivers/firmware/arm_ffa/driver.c | 130 +++++++++++++++++++++++-------
 drivers/tee/optee/ffa_abi.c       |  46 +++++------
 drivers/tee/optee/optee_private.h |   1 -
 include/linux/arm_ffa.h           |  36 ++++++---
 5 files changed, 150 insertions(+), 67 deletions(-)

--=20
2.37.3


--===============5988946040363173248==--

