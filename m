From: Yuvraj Sakshith <yuvraj.kernel@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: [RFC PATCH 5/7] tee: optee: Add OPTEE_SMC_VM_CREATED and
 OPTEE_SMC_VM_DESTROYED
Date: Tue, 01 Apr 2025 22:35:25 +0530
Message-ID: <20250401170527.344092-6-yuvraj.kernel@gmail.com>
In-Reply-To: <20250401170527.344092-1-yuvraj.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7670248791230757545=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7670248791230757545==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

OP-TEE when compiled with NS-Virtualization support expects NS-Hypervisor
to notify events such as guest creation and destruction through SMCs.

This change adds two macros OPTEE_SMC_VM_CREATED and OPTEE_SMC_VM_DESTROYED.

Signed-off-by: Yuvraj Sakshith <yuvraj.kernel@gmail.com>
---
 drivers/tee/optee/optee_smc.h | 53 +++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index 879426300821..988539b2407b 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -452,6 +452,59 @@ struct optee_smc_disable_shm_cache_result {
 /* See OPTEE_SMC_CALL_WITH_REGD_ARG above */
 #define OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG	19
 
+/*
+ * Inform OP-TEE about a new virtual machine
+ *
+ * Hypervisor issues this call during virtual machine (guest) creation.
+ * OP-TEE records client id of new virtual machine and prepares
+ * to receive requests from it. This call is available only if OP-TEE
+ * was built with virtualization support.
+ *
+ * Call requests usage:
+ * a0	SMC Function ID, OPTEE_SMC_VM_CREATED
+ * a1	Hypervisor Client ID of newly created virtual machine
+ * a2-6 Not used
+ * a7	Hypervisor Client ID register. Must be 0, because only hypervisor
+ *      can issue this call
+ *
+ * Normal return register usage:
+ * a0	OPTEE_SMC_RETURN_OK
+ * a1-7	Preserved
+ *
+ * Error return:
+ * a0	OPTEE_SMC_RETURN_ENOTAVAIL	OP-TEE have no resources for
+ *					another VM
+ * a1-7	Preserved
+ *
+ */
+#define OPTEE_SMC_FUNCID_VM_CREATED		13
+#define OPTEE_SMC_VM_CREATED \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_VM_CREATED)
+
+/*
+ * Inform OP-TEE about shutdown of a virtual machine
+ *
+ * Hypervisor issues this call during virtual machine (guest) destruction.
+ * OP-TEE will clean up all resources associated with this VM. This call is
+ * available only if OP-TEE was built with virtualization support.
+ *
+ * Call requests usage:
+ * a0	SMC Function ID, OPTEE_SMC_VM_DESTROYED
+ * a1	Hypervisor Client ID of virtual machine being shut down
+ * a2-6 Not used
+ * a7	Hypervisor Client ID register. Must be 0, because only hypervisor
+ *      can issue this call
+ *
+ * Normal return register usage:
+ * a0	OPTEE_SMC_RETURN_OK
+ * a1-7	Preserved
+ *
+ */
+
+#define OPTEE_SMC_FUNCID_VM_DESTROYED	14
+#define OPTEE_SMC_VM_DESTROYED \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_VM_DESTROYED)
+
 /*
  * Resume from RPC (for example after processing a foreign interrupt)
  *
-- 
2.43.0


--===============7670248791230757545==--

