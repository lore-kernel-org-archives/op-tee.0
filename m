From: Yuvraj Sakshith <yuvraj.kernel@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: [RFC PATCH 4/7] KVM: arm64: Forward guest CPU state to TEE mediator
 on SMC trap
Date: Tue, 01 Apr 2025 22:35:24 +0530
Message-ID: <20250401170527.344092-5-yuvraj.kernel@gmail.com>
In-Reply-To: <20250401170527.344092-1-yuvraj.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9070494725108267091=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9070494725108267091==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

When guest makes an SMC, the call is denied by the hypervisor
and not handled (ignored). In the presence of the TEE Mediator
module, the SMC from guest is forwarded with it's vCPU register
state through tee_mediator_forward_request().

Signed-off-by: Yuvraj Sakshith <yuvraj.kernel@gmail.com>
---
 arch/arm64/kvm/hypercalls.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 569941eeb3fe..cb34bb87188c 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -3,6 +3,7 @@
=20
 #include <linux/arm-smccc.h>
 #include <linux/kvm_host.h>
+#include <linux/tee_mediator.h>
=20
 #include <asm/kvm_emulate.h>
=20
@@ -90,7 +91,10 @@ static bool kvm_smccc_default_allowed(u32 func_id)
 		 */
 		if (func_id >=3D KVM_PSCI_FN(0) && func_id <=3D KVM_PSCI_FN(3))
 			return true;
-
+#ifdef CONFIG_TEE_MEDIATOR
+		if (ARM_SMCCC_IS_OWNER_TRUSTED_APP(func_id) || ARM_SMCCC_IS_OWNER_TRUSTED_=
OS(func_id))
+			return true;
+#endif
 		return false;
 	}
 }
@@ -284,7 +288,14 @@ int kvm_smccc_call_handler(struct kvm_vcpu *vcpu)
 		WARN_RATELIMIT(1, "Unhandled SMCCC filter action: %d\n", action);
 		goto out;
 	}
-
+#ifdef CONFIG_TEE_MEDIATOR
+	if (ARM_SMCCC_IS_OWNER_TRUSTED_APP(func_id) || ARM_SMCCC_IS_OWNER_TRUSTED_O=
S(func_id)) {
+		if (tee_mediator_is_active()) {
+			tee_mediator_forward_request(vcpu);
+			return 1;
+		}
+	}
+#endif
 	switch (func_id) {
 	case ARM_SMCCC_VERSION_FUNC_ID:
 		val[0] =3D ARM_SMCCC_VERSION_1_1;
--=20
2.43.0


--===============9070494725108267091==--

