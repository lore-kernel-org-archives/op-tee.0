From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v7 0/6] Asynchronous notifications from secure world
Date: Tue, 26 Oct 2021 10:31:32 +0200
Message-ID: <20211026083138.1818705-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0082860185313341348=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0082860185313341348==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

This adds support for asynchronous notifications from OP-TEE in secure
world to the OP-TEE driver. This allows a design with a top half and bottom
half type of driver where the top half runs in secure interrupt context and
a notifications tells normal world to schedule a yielding call to do the
bottom half processing.

An edge-triggered interrupt is used to notify the driver that there are
asynchronous notifications pending.

Only the SMC based ABI of the OP-TEE driver gains asynchronous
notifications. Future support for asynchronous notifications in the FF-A
based ABI will rely on APIs which are expected to be provided by the FF-A
driver in a not too distant future.

Most of the patches here are well reviewed, but the last patch "optee: add
asynchronous notifications" could do with some more attention.

This patchset is also available at
https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=3Dasync_not=
if_v7

v6->v7:
* Rebased on 4615e5a34b95 ("optee: add FF-A support") in
  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git with
  34f3c67b8178 ("optee: smc_abi.c: add missing #include <linux/mm.h>")
  cherry-picked on top. This allows to resolve the conflicts with
  pull request "[GIT PULL] OP-TEE FF-A for V5.16"
* Factored out the interrupt handling added in "optee: add asynchronous
  notifications" to only go into smb_abi.c. A different approach is
  expected with FF-A once it has asynchronous notifications.
* Addressed review comments from Sumit Garg:
  - Replaced 0 and 1 with the macros GIC_SPI and IRQ_TYPE_EDGE_RISING in
    the example in the bindings.
  - Replaced the magic number to optee_notif_init() with
    OPTEE_DEFAULT_MAX_NOTIF_VALUE in the commit "optee: separate notification
    functions"
  - Switched back to tagged error path in optee_probe()
  - Fixed a few nits in "optee: add asynchronous notifications"
  - Applied Sumit's Reviewed-by on all commits but the last,
    "optee: add asynchronous notifications"

v5->v6:
* Rebased on v5.15-rc2
* Replaced "tee: add tee_dev_open_helper() primitive" with "tee: export
  teedev_open() and teedev_close_context()" since it turned out that the
  normal teedev functions could be used instead as noted by Sumit.
* Changed "optee: add asynchronous notifications" to use the exported
  teedev_open() and teedev_close_context() functions instead.

v4->v5:
* Rebased on v5.14-rc7
* Updated documentation to clarify that one interrupt may represent multiple
  notifications as requested.
* Applied Marc's and Rob's tags

v3->v4:
* Clarfied the expected type of interrypt is edge-triggered, both in
  the normal documentation and in the DT bindings as requested.

v2->v3:
* Rebased on v5.14-rc2 which made the patch "dt-bindings: arm: Convert
  optee binding to json-schema" from the V2 patch set obsolete.
* Applied Ard's Acked-by on "optee: add asynchronous notifications"

v1->v2:
* Added documentation
* Converted optee bindings to json-schema and added interrupt property
* Configure notification interrupt from DT instead of getting it
  from secure world, suggested by Ard Biesheuvel <ardb@kernel.org>.

Thanks,
Jens



Jens Wiklander (6):
  docs: staging/tee.rst: add a section on OP-TEE notifications
  dt-bindings: arm: optee: add interrupt property
  tee: fix put order in teedev_close_context()
  tee: export teedev_open() and teedev_close_context()
  optee: separate notification functions
  optee: add asynchronous notifications

 .../arm/firmware/linaro,optee-tz.yaml         |   7 +
 Documentation/staging/tee.rst                 |  30 +++
 drivers/tee/optee/Makefile                    |   1 +
 drivers/tee/optee/core.c                      |   2 +-
 drivers/tee/optee/ffa_abi.c                   |   6 +-
 drivers/tee/optee/notif.c                     | 125 +++++++++
 drivers/tee/optee/optee_msg.h                 |   9 +
 drivers/tee/optee/optee_private.h             |  28 ++-
 drivers/tee/optee/optee_rpc_cmd.h             |  31 +--
 drivers/tee/optee/optee_smc.h                 |  75 +++++-
 drivers/tee/optee/rpc.c                       |  71 +-----
 drivers/tee/optee/smc_abi.c                   | 238 +++++++++++++++---
 drivers/tee/tee_core.c                        |  10 +-
 include/linux/tee_drv.h                       |  14 ++
 14 files changed, 522 insertions(+), 125 deletions(-)
 create mode 100644 drivers/tee/optee/notif.c

--=20
2.31.1


--===============0082860185313341348==--

