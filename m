From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 00/10] Trusted Execution Environment (TEE) driver for Qualcomm
 TEE (QTEE)
Date: Mon, 02 Dec 2024 20:19:16 -0800
Message-ID: <20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-0-f502ef01e016@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0668257117112918523=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0668257117112918523==
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

This patch series has been tested for basic QTEE object invocations and
callback requests, including loading a TA and requesting services form
the TA. However, the test platform is currently being prepared for
upstream availability and will soon be accessible to the community for
further validation. I will share updates as the platform become
available.

[1] https://www.kernel.org/doc/Documentation/tee.txt

Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
---
Amirreza Zarrabi (10):
      tee: allow a driver to allocate a tee_device without a pool
      tee: add TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF
      tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
      firmware: qcom: scm: add support for object invocation
      qcomtee: implement object invoke support
      qcomtee: add primordial object
      dt-bindings: arm: qcomtee: add QTEE driver devicetree binding for TEE s=
ubsystem
      tee: add Qualcomm TEE driver
      arm64: dts: qcom: sm8650: add support for QTEE
      Documentation: tee: Add Qualcomm TEE driver

 .../devicetree/bindings/arm/firmware/qcom,tee.yaml |  34 +
 Documentation/tee/index.rst                        |   1 +
 Documentation/tee/qtee.rst                         | 143 ++++
 arch/arm64/boot/dts/qcom/sm8650.dtsi               |   4 +
 drivers/firmware/qcom/qcom_scm.c                   |  60 ++
 drivers/firmware/qcom/qcom_scm.h                   |   7 +
 drivers/tee/Kconfig                                |   1 +
 drivers/tee/Makefile                               |   1 +
 drivers/tee/qcomtee/Kconfig                        |  10 +
 drivers/tee/qcomtee/Makefile                       |   9 +
 drivers/tee/qcomtee/async.c                        | 153 ++++
 drivers/tee/qcomtee/call.c                         | 707 ++++++++++++++++
 drivers/tee/qcomtee/core.c                         | 942 +++++++++++++++++++=
++
 drivers/tee/qcomtee/primordial_obj.c               |  63 ++
 drivers/tee/qcomtee/qcom_scm.c                     |  36 +
 drivers/tee/qcomtee/qcomtee_msg.h                  | 217 +++++
 drivers/tee/qcomtee/qcomtee_private.h              | 218 +++++
 drivers/tee/qcomtee/release.c                      |  66 ++
 drivers/tee/qcomtee/user_obj.c                     | 625 ++++++++++++++
 drivers/tee/tee_core.c                             | 113 ++-
 include/linux/firmware/qcom/qcom_scm.h             |   9 +
 include/linux/firmware/qcom/qcom_tee.h             | 284 +++++++
 include/linux/tee_core.h                           |   4 +
 include/linux/tee_drv.h                            |  12 +
 include/uapi/linux/tee.h                           |  54 +-
 25 files changed, 3765 insertions(+), 8 deletions(-)
---
base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
change-id: 20241202-qcom-tee-using-tee-ss-without-mem-obj-362c66340527

Best regards,
--=20
Amirreza Zarrabi <quic_azarrabi@quicinc.com>


--===============0668257117112918523==--

