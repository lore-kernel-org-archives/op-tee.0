From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 0/8] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
Date: Sun, 02 Feb 2025 18:43:28 -0800
Message-ID: <20250202-qcom-tee-using-tee-ss-without-mem-obj-v2-0-297eacd0d34f@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7538438395105049917=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7538438395105049917==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This patch series introduces a Trusted Execution Environment (TEE)
driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
and services to run securely. It uses an object-based interface, where
each service is an object with sets of operations. Clients can invoke
these operations on objects, which can generate results, including other
objects. For example, an object can load a TA and return another object
that represents the loaded TA, allowing access to its services.

Kernel and userspace services are also available to QTEE through a
similar approach. QTEE makes callback requests that are converted into
object invocations. These objects can represent services within the
kernel or userspace process.

Note: This patch series focuses on QTEE objects and userspace services.

Linux already provides a TEE subsystem, which is described in [1]. The
tee subsystem provides a generic ioctl interface, TEE_IOC_INVOKE, which
can be used by userspace to talk to a TEE backend driver. We extend the
Linux TEE subsystem to understand object parameters and an ioctl call so
client can invoke objects in QTEE:

  - TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_*
  - TEE_IOC_OBJECT_INVOKE

The existing ioctl calls TEE_IOC_SUPPL_RECV and TEE_IOC_SUPPL_SEND are
used for invoking services in the userspace process by QTEE.

The TEE backend driver uses the QTEE Transport Message to communicate
with QTEE. Interactions through the object INVOKE interface are
translated into QTEE messages. Likewise, object invocations from QTEE
for userspace objects are converted into SEND/RECV ioctl calls to
supplicants.

The details of QTEE Transport Message to communicate with QTEE is
available in [PATCH 10/10] Documentation: tee: Add Qualcomm TEE driver.

You can run basic tests with following steps:
git clone https://github.com/quic/quic-teec.git
cd quic-teec
mkdir build
cmake .. -DCMAKE_TOOLCHAIN_FILE=3DCMakeToolchain.txt -DBUILD_UNITTEST=3DON

https://github.com/quic/quic-teec/blob/main/README.md lists dependancies
needed to build the above.

This series has been tested for basic QTEE object invocations and
callback requests, including loading a TA and requesting services form
the TA.

[1] https://www.kernel.org/doc/Documentation/tee.txt

Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
---
Changes in v2:
- Clean up commit messages and comments.
- Use better names such as ubuf instead of membuf or QCOMTEE prefix
  instead of QCOM_TEE, or names that are more consistent with other
  TEE-backend drivers such as qcomtee_context_data instead of
  qcom_tee_context.
- Drop the DTS patch and instantiate the device from the scm driver.
- Use a single structure for all driver's internal states.
- Drop srcu primitives and use the existing mutex for synchronization
  between the supplicant and QTEE.
- Directly use tee_context to track the lifetime of qcomtee_context_data.
- Add close_context() to be called when the user closes the tee_context.
- Link to v1: https://lore.kernel.org/r/20241202-qcom-tee-using-tee-ss-withou=
t-mem-obj-v1-0-f502ef01e016(a)quicinc.com

Changes in v1:
- It is a complete rewrite to utilize the TEE subsystem.
- Link to RFC: https://lore.kernel.org/all/20240702-qcom-tee-object-and-ioctl=
s-v1-0-633c3ddf57ee(a)quicinc.com

---
Amirreza Zarrabi (8):
      tee: allow a driver to allocate a tee_device without a pool
      tee: add close_context to TEE driver operation
      tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
      tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
      firmware: qcom: scm: add support for object invocation
      tee: add Qualcomm TEE driver
      qcomtee: add primordial object
      Documentation: tee: Add Qualcomm TEE driver

 Documentation/tee/index.rst            |   1 +
 Documentation/tee/qtee.rst             | 150 ++++++
 drivers/firmware/qcom/qcom_scm.c       | 128 ++++++
 drivers/firmware/qcom/qcom_scm.h       |   7 +
 drivers/tee/Kconfig                    |   1 +
 drivers/tee/Makefile                   |   1 +
 drivers/tee/qcomtee/Kconfig            |  10 +
 drivers/tee/qcomtee/Makefile           |  10 +
 drivers/tee/qcomtee/async.c            | 160 +++++++
 drivers/tee/qcomtee/call.c             | 741 ++++++++++++++++++++++++++++++
 drivers/tee/qcomtee/core.c             | 810 +++++++++++++++++++++++++++++++=
++
 drivers/tee/qcomtee/primordial_obj.c   |  65 +++
 drivers/tee/qcomtee/qcom_scm.c         |  36 ++
 drivers/tee/qcomtee/qcomtee_msg.h      | 234 ++++++++++
 drivers/tee/qcomtee/qcomtee_private.h  | 226 +++++++++
 drivers/tee/qcomtee/release.c          |  59 +++
 drivers/tee/qcomtee/shm.c              | 102 +++++
 drivers/tee/qcomtee/user_obj.c         | 712 +++++++++++++++++++++++++++++
 drivers/tee/tee_core.c                 | 121 ++++-
 drivers/tee/tee_private.h              |   6 -
 include/linux/firmware/qcom/qcom_scm.h |  27 ++
 include/linux/firmware/qcom/qcom_tee.h | 286 ++++++++++++
 include/linux/tee_core.h               |  15 +-
 include/linux/tee_drv.h                |  18 +
 include/uapi/linux/tee.h               |  54 ++-
 25 files changed, 3964 insertions(+), 16 deletions(-)
---
base-commit: dab2734f8e9ecba609d66d1dd087a392a7774c04
change-id: 20241202-qcom-tee-using-tee-ss-without-mem-obj-362c66340527

Best regards,
--=20
Amirreza Zarrabi <quic_azarrabi@quicinc.com>


--===============7538438395105049917==--

