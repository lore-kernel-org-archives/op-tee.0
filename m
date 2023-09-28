From: jeshwank <JESHWANTHKUMAR.NK@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3] virtio-tee: Reserve device ID 46 for TEE device
Date: Thu, 28 Sep 2023 11:42:30 +0530
Message-ID: <cf8eee37bb9f5c2408f0ed8f4798e87b3c01f39c.1695881523.git.JESHWANTHKUMAR.NK@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2713114184397847305=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2713114184397847305==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

In a virtual environment, an application running in guest VM may want
to delegate security sensitive tasks to a Trusted Application (TA)
running within a Trusted Execution Environment (TEE). A TEE is a trusted
OS running in some secure environment, for example, TrustZone on ARM
CPUs, or a separate secure co-processor etc.

A virtual TEE device emulates a TEE within a guest VM. Such a virtual
TEE device supports multiple operations such as:

VIRTIO_TEE_CMD_OPEN_DEVICE – Open a communication channel with virtio
                             TEE device.
VIRTIO_TEE_CMD_CLOSE_DEVICE – Close communication channel with virtio
                              TEE device.
VIRTIO_TEE_CMD_GET_VERSION – Get version of virtio TEE.
VIRTIO_TEE_CMD_OPEN_SESSION – Open a session to communicate with
                              trusted application running in TEE.
VIRTIO_TEE_CMD_CLOSE_SESSION – Close a session to end communication
                               with trusted application running in TEE.
VIRTIO_TEE_CMD_INVOKE_FUNC – Invoke a command or function in trusted
                             application running in TEE.
VIRTIO_TEE_CMD_CANCEL_REQ – Cancel an ongoing command within TEE.
VIRTIO_TEE_CMD_REGISTER_MEM - Register shared memory with TEE.
VIRTIO_TEE_CMD_UNREGISTER_MEM - Unregister shared memory from TEE.

We would like to reserve device ID 46 for Virtio-TEE device.

Signed-off-by: Jeshwanth Kumar <jeshwanthkumar.nk@amd.com>
Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Acked-by: Sumit Garg <sumit.garg@linaro.org>
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index 0a62dce..644aa4a 100644
--- a/content.tex
+++ b/content.tex
@@ -739,6 +739,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 45         &   SPI master \\
 \hline
+46         &   TEE device \\
+\hline
 \end{tabular}
 
 Some of the devices above are unspecified by this document,
-- 
2.25.1


--===============2713114184397847305==--

