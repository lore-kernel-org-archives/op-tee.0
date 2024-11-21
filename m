From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH RFC 0/3] Introduce orphan tee_shm and default tee_context
Date: Wed, 20 Nov 2024 17:37:14 -0800
Message-ID: 
 <20241120-fix-tee_shm-refcount-upstream-v1-0-5da97f584fcd@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3628798025328426706=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3628798025328426706==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The TEE subsystem manages three main structures: tee_device, the device
that represents the TEE; tee_context, the context that represents the
TEE client; and tee_shm, which represents the shared memory with the
TEE. When a tee_device is opened, it creates a tee_context instance. The
tee_shm is created for the tee_device when allocating shared memory with
the TEE but is linked to a context. The lifespan of the device is
determined by the presence of context and shared memory, while the
lifespan of a context depends on the client closing the device.

This behavior has been modified, making the lifespan of context
dependent on shared memory. If a client closes the device but doesn=E2=80=99t
release the shared memory, the linked context will remain active,
preventing the release callback from freeing resources in the TEE. This
could lead to a deadlock if the TEE holds a reference to the shared
memory and relies on the release callback to remove the reference.

In this pachset we introduce orphan tee_shm and default tee_context.

When a shared memory becomes orphan because its associated context is
released, it no longer has a tee_context. One method to differentiate
between orphaned and regular shared memory is to use NULL as the linked
context. However, this can cause issues if releasing the shared memory
triggers additional calls, like those to the supplicant, which require a
valid context. Instead of using NULL, an internal tee_context for the
driver can be used.

The driver relies on tee_device_unregister which is a blocking calls
waiting for all context to be released and all shared memory to be freed
before unloading the driver. This means that all contexts, including
internal context, should be closed before tee_device_unregister can
proceed. This can introduce a short window where there is no valid
context to use when releasing the shared memory. The default tee_context
has lifespan similar to the device.

For an orphan tee_shm, default context is used.

This has not been tested. Looking for feedback if this is a reasonable
change.

Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
---
Amirreza Zarrabi (3):
      tee: revert removal of redundant teedev in struct tee_shm
      tee: revert removal of linked list of struct tee_shm
      tee: introduce orphan tee_shm and default context

 drivers/tee/optee/core.c    |  2 +-
 drivers/tee/optee/ffa_abi.c |  2 +-
 drivers/tee/optee/smc_abi.c |  2 +-
 drivers/tee/tee_core.c      | 84 +++++++++++++++++++++++++++++--------------=
--
 drivers/tee/tee_private.h   |  3 --
 drivers/tee/tee_shm.c       | 41 ++++++++++++----------
 include/linux/tee_core.h    | 15 ++++++++
 include/linux/tee_drv.h     | 13 ++++---
 8 files changed, 100 insertions(+), 62 deletions(-)
---
base-commit: ae58226b89ac0cffa05ba7357733776542e40216
change-id: 20241120-fix-tee_shm-refcount-upstream-c671b89fbe67

Best regards,
--=20
Amirreza Zarrabi <quic_azarrabi@quicinc.com>


--===============3628798025328426706==--

