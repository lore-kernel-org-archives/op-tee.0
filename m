From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 0/3] Replay Protected Memory Block (RPMB) subsystem
Date: Wed, 31 Jan 2024 18:43:44 +0100
Message-ID: <20240131174347.510961-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3504525030688151493=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3504525030688151493==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

It's been a while since Shyam posted the last version [1] of this patch
set. I've pinged Shyam, but so far I've had no reply so I'm trying to make
another attempt with the RPMB subsystem. If Shyam has other changes in mind
than what I'm adding here I hope we'll find a way to cover that too. I'm
calling it version two of the patchset since I'm trying to address all
feedback on the previous version even if I'm starting a new thread.

This patch set introduces a new RPMB subsystem, based on patches from [1],
[2], and [3]. The RPMB subsystem aims at providing access to RPMB
partitions to other kernel drivers, in particular the OP-TEE driver. A new
user space ABI isn't needed, we can instead continue using the already
present ABI when writing the RPMB key during production.

I've added and removed things to keep only what is needed by the OP-TEE
driver. Since the posting of [3], there has been major changes in the MMC
subsystem so "mmc: block: register RPMB partition with the RPMB subsystem"
is in practice completely rewritten.

With this OP-TEE can access RPMB during early boot instead of having to
wait for user space to become available as in the current design [4].
This will benefit the efi variables [5] since we wont rely on userspace as
well as some TPM issues [6] that were solved.

The OP-TEE driver finds the correct RPMB device to interact with by
iterating over available devices until one is found with a programmed
authentication matching the one OP-TEE is using. This enables coexisting
users of other RPMBs since the owner can be determined by who knows the
authentication key.

I've put myself as a maintainer for the RPMB subsystem as I have an
interest in the OP-TEE driver to keep this in good shape. However, if you'd
rather see someone else taking the maintainership that's fine too. I'll
help keep the subsystem updated regardless.

[1] https://lore.kernel.org/lkml/20230722014037.42647-1-shyamsaini(a)linux.mi=
crosoft.com/
[2] https://lore.kernel.org/lkml/20220405093759.1126835-2-alex.bennee(a)linar=
o.org/
[3] https://lore.kernel.org/linux-mmc/1478548394-8184-2-git-send-email-tomas.=
winkler(a)intel.com/
[4] https://optee.readthedocs.io/en/latest/architecture/secure_storage.html#r=
pmb-secure-storage
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dc44b6be62e8dd4ee0a308c36a70620613e6fc55f
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D7269cba53d906cf257c139d3b3a53ad272176bca

Thanks,
Jens

Changes since Shyam's RFC:
* Removed the remaining leftover rpmb_cdev_*() function calls
* Refactored the struct rpmb_ops with all the previous ops replaced, in
  some sense closer to [3] with the route_frames() op
* Added rpmb_route_frames()
* Added struct rpmb_frame, enum rpmb_op_result, and enum rpmb_type from [3]
* Removed all functions not needed in the OP-TEE use case
* Added "mmc: block: register RPMB partition with the RPMB subsystem", based
  on the commit with the same name in [3]
* Added "optee: probe RPMB device using RPMB subsystem" for integration
  with OP-TEE
* Moved the RPMB driver into drivers/misc/rpmb-core.c
* Added my name to MODULE_AUTHOR() in rpmb-core.c
* Added an rpmb_mutex to serialize access to the IDA
* Removed the target parameter from all rpmb_*() functions since it's
  currently unused



Jens Wiklander (3):
  rpmb: add Replay Protected Memory Block (RPMB) subsystem
  mmc: block: register RPMB partition with the RPMB subsystem
  optee: probe RPMB device using RPMB subsystem

 MAINTAINERS                       |   7 +
 drivers/misc/Kconfig              |   9 ++
 drivers/misc/Makefile             |   1 +
 drivers/misc/rpmb-core.c          | 247 ++++++++++++++++++++++++++++++
 drivers/mmc/core/block.c          | 177 +++++++++++++++++++++
 drivers/tee/optee/core.c          |   1 +
 drivers/tee/optee/ffa_abi.c       |   2 +
 drivers/tee/optee/optee_private.h |   6 +
 drivers/tee/optee/optee_rpc_cmd.h |  33 ++++
 drivers/tee/optee/rpc.c           | 221 ++++++++++++++++++++++++++
 drivers/tee/optee/smc_abi.c       |   2 +
 include/linux/rpmb.h              | 184 ++++++++++++++++++++++
 12 files changed, 890 insertions(+)
 create mode 100644 drivers/misc/rpmb-core.c
 create mode 100644 include/linux/rpmb.h


base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
--=20
2.34.1


--===============3504525030688151493==--

