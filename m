From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 0/5] Add FF-A support in OP-TEE driver
Date: Thu, 27 May 2021 10:13:59 +0200
Message-ID: <20210527081404.1433177-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0237247918198044336=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0237247918198044336==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

This adds supports for the OP-TEE driver to communicate with secure world
using FF-A [1] as transport.

These patches are based on the FF-A v7 patch set by Sudeep Holla [2] [3].

There is one change to the TEE subsystem with "tee: add sec_world_id to
struct tee_shm" to add support for holding globally unique handle assigned
by the FF-A. This is a field that I believe could useful for the AMDTEE
driver too.

For communication the OP-TEE message protocol is still used, but with a new
type of memory reference, struct optee_msg_param_fmem, to carry the
information needed by FF-A. The OP-TEE driver is refactored internally with
to sets of callbacks, one for the old SMC based communication and another
set with FF-A as transport.

There is also a difference in how the drivers are instantiated. With the
SMC based transport we have a platform driver, module_platform_driver(),
today which we're keeping as is for this configuration. In a FF-A system we
have a FF-A driver, module_ffa_driver(), instead.

The OP-TEE driver can be compiled for both targets at the same time and
it's up to runtime configuration (device tree or ACPI) to decide how it's
initialized.

Thanks,
Jens

[1] https://developer.arm.com/documentation/den0077/latest
[2] https://lore.kernel.org/linux-arm-kernel/20210521151033.181846-1-sudeep.h=
olla(a)arm.com/
[3] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git v5.1=
3/ffa

v1->v2:
- Rebased to the FF-A v7 patch
- Fixed a couple of reports from kernel test robot <lkp@intel.com>

Jens Wiklander (5):
  tee: add sec_world_id to struct tee_shm
  optee: simplify optee_release()
  optee: refactor driver with internal callbacks
  optee: add a FF-A memory pool
  optee: add FF-A support

 drivers/tee/optee/call.c          | 325 +++++++++++---
 drivers/tee/optee/core.c          | 689 ++++++++++++++++++++++++++----
 drivers/tee/optee/optee_ffa.h     | 153 +++++++
 drivers/tee/optee/optee_msg.h     |  27 +-
 drivers/tee/optee/optee_private.h |  88 +++-
 drivers/tee/optee/rpc.c           | 137 +++++-
 drivers/tee/optee/shm_pool.c      |  65 ++-
 drivers/tee/optee/shm_pool.h      |   1 +
 include/linux/tee_drv.h           |   7 +-
 9 files changed, 1326 insertions(+), 166 deletions(-)
 create mode 100644 drivers/tee/optee/optee_ffa.h

--=20
2.25.1


--===============0237247918198044336==--

