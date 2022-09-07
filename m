From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v3 00/10] firmware: arm_ffa: Refactoring and initial/minor v1.1 update
Date: Wed, 07 Sep 2022 15:52:30 +0100
Message-ID: <20220907145240.1683088-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6924938782177841626=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6924938782177841626==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

This series is just some refactoring in preparation to add FF-A v1.1
support. It doesn't have any memory layout or notification changes
supported in v1.1 yet.

Regards,
Sudeep

v2[2]->v3:
	- Fixed the logic to set 32bit mode which was wrong.
	- Ensured that we advance each partition info size by returned
	  size even if the size is greater than the partition_info structure,
	  we will still just copy the right size.

v1[1]->v2[2]:
	- Merged dropping of ffa_ops in optee_ffa structure and using
	  ffa_dev->ops into single patch
	- Added separate patch(didn't fit any patch strictly to fit in)
	  to rename ffa_dev_ops as ffa_ops as suggested by Sumit
	- Fixed some minor comments, handling size > structure size in
	  partition_info_get and added extra parameter to ffa_features
	  to get both possible output/interface properties.

[1] https://lore.kernel.org/all/20220830100700.344594-1-sudeep.holla(a)arm.com
[2] https://lore.kernel.org/all/20220902124032.788488-1-sudeep.holla(a)arm.com

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
 drivers/firmware/arm_ffa/driver.c | 131 +++++++++++++++++++++++-------
 drivers/tee/optee/ffa_abi.c       |  46 +++++------
 drivers/tee/optee/optee_private.h |   1 -
 include/linux/arm_ffa.h           |  36 +++++---
 5 files changed, 151 insertions(+), 67 deletions(-)

--
2.37.3


--===============6924938782177841626==--

