From: Yuvraj Sakshith <yuvraj.kernel@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: [RFC PATCH 2/7] tee: Add TEE Mediator module which aims to expose TEE
 to a KVM guest.
Date: Tue, 01 Apr 2025 22:35:22 +0530
Message-ID: <20250401170527.344092-3-yuvraj.kernel@gmail.com>
In-Reply-To: <20250401170527.344092-1-yuvraj.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4462142906633567745=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4462142906633567745==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The TEE Mediator module is an upper abstraction layer which lets KVM guests
interact with a trusted execution environment.

TEE specific subsystems (such as OP-TEE, for example) can register a set of
handlers through tee_mediator_register_ops() with the TEE Mediator, which will
be called by the kernel when required.

Given this module, architecture specific TEE drivers can implement handler fu=
nctions to work with these
events if necessary. In most implementations, a special instruction (such as =
SMC, in arm64) switches control
leading to the TEE. These instructions are usually trapped by the hypervisor =
when executed by the guest.

This module allows making use of these trapped instructions and mediating the=
 request between guest and TEE.

Signed-off-by: Yuvraj Sakshith <yuvraj.kernel@gmail.com>
---
 drivers/tee/Kconfig          |   5 ++
 drivers/tee/Makefile         |   1 +
 drivers/tee/tee_mediator.c   | 145 +++++++++++++++++++++++++++++++++++
 include/linux/tee_mediator.h |  39 ++++++++++
 4 files changed, 190 insertions(+)
 create mode 100644 drivers/tee/tee_mediator.c
 create mode 100644 include/linux/tee_mediator.h

diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index 61b507c18780..dc446c9746ee 100644
--- a/drivers/tee/Kconfig
+++ b/drivers/tee/Kconfig
@@ -11,6 +11,11 @@ menuconfig TEE
 	  This implements a generic interface towards a Trusted Execution
 	  Environment (TEE).
=20
+config TEE_MEDIATOR
+	bool "Trusted Execution Environment Mediator support"
+	depends on KVM
+	help
+	  Provides an abstraction layer for TEE drivers to mediate KVM guest reques=
ts to the TEE.
 if TEE
=20
 source "drivers/tee/optee/Kconfig"
diff --git a/drivers/tee/Makefile b/drivers/tee/Makefile
index 5488cba30bd2..46c44e59dd0b 100644
--- a/drivers/tee/Makefile
+++ b/drivers/tee/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TEE) +=3D tee.o
+obj-$(CONFIG_TEE_MEDIATOR) +=3D tee_mediator.o
 tee-objs +=3D tee_core.o
 tee-objs +=3D tee_shm.o
 tee-objs +=3D tee_shm_pool.o
diff --git a/drivers/tee/tee_mediator.c b/drivers/tee/tee_mediator.c
new file mode 100644
index 000000000000..d1ae7f4cb994
--- /dev/null
+++ b/drivers/tee/tee_mediator.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * TEE Mediator for the Linux Kernel
+ *
+ * This module enables a KVM guest to interact with a
+ * Trusted Execution Environment in the secure processing
+ * state provided by the architecture.
+ *
+ * Author:
+ *   Yuvraj Sakshith <yuvraj.kernel@gmail.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/tee_mediator.h>
+
+static struct tee_mediator *mediator;
+
+int tee_mediator_register_ops(struct tee_mediator_ops *ops)
+{
+
+	int ret =3D 0;
+
+	if (!ops) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	if (!mediator) {
+		ret =3D -EOPNOTSUPP;
+		goto out;
+	}
+
+	mediator->ops =3D ops;
+
+out:
+	return ret;
+}
+
+int tee_mediator_is_active(void)
+{
+	return (mediator !=3D NULL &&
+	 mediator->ops !=3D NULL && mediator->ops->is_active());
+}
+
+int tee_mediator_create_host(void)
+{
+	int ret =3D 0;
+
+	if (!tee_mediator_is_active() || !mediator->ops->create_host) {
+		ret =3D -ENODEV;
+		goto out;
+	}
+
+	ret =3D mediator->ops->create_host();
+
+out:
+	return ret;
+}
+
+int tee_mediator_destroy_host(void)
+{
+	int ret =3D 0;
+
+	if (!tee_mediator_is_active() || !mediator->ops->destroy_host) {
+		ret =3D -ENODEV;
+		goto out;
+	}
+
+	ret =3D mediator->ops->destroy_host();
+out:
+	return ret;
+}
+
+int tee_mediator_create_vm(struct kvm *kvm)
+{
+	int ret =3D 0;
+
+	if (!kvm) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	if (!tee_mediator_is_active() || !mediator->ops->create_vm) {
+		ret =3D -ENODEV;
+		goto out;
+	}
+
+	ret =3D mediator->ops->create_vm(kvm);
+
+out:
+	return ret;
+}
+
+int tee_mediator_destroy_vm(struct kvm *kvm)
+{
+	int ret =3D 0;
+
+	if (!kvm) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	if (!tee_mediator_is_active() || !mediator->ops->destroy_vm) {
+		ret =3D -ENODEV;
+		goto out;
+	}
+
+	ret =3D mediator->ops->destroy_vm(kvm);
+
+out:
+	return ret;
+}
+
+void tee_mediator_forward_request(struct kvm_vcpu *vcpu)
+{
+	if (!vcpu || !tee_mediator_is_active() || !mediator->ops->forward_request)
+		return;
+
+	mediator->ops->forward_request(vcpu);
+}
+
+static int __init tee_mediator_init(void)
+{
+	int ret =3D 0;
+
+	mediator =3D kzalloc(sizeof(*mediator), GFP_KERNEL);
+	if (!mediator) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	pr_info("mediator initialised\n");
+out:
+	return ret;
+}
+module_init(tee_mediator_init);
+
+static void __exit tee_mediator_exit(void)
+{
+	kfree(mediator);
+
+	pr_info("mediator exiting\n");
+}
+module_exit(tee_mediator_exit);
diff --git a/include/linux/tee_mediator.h b/include/linux/tee_mediator.h
new file mode 100644
index 000000000000..4a971de158ec
--- /dev/null
+++ b/include/linux/tee_mediator.h
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * TEE Mediator for the Linux Kernel
+ *
+ * This module enables a KVM guest to interact with a
+ * Trusted Execution Environment in the secure processing
+ * state provided by the architecture.
+ *
+ * Author:
+ *   Yuvraj Sakshith <yuvraj.kernel@gmail.com>
+ */
+
+#ifndef __TEE_MEDIATOR_H
+#define __TEE_MEDIATOR_H
+
+#include <linux/kvm_host.h>
+
+struct tee_mediator_ops {
+	int (*create_host)(void);
+	int (*destroy_host)(void);
+	int (*create_vm)(struct kvm *kvm);
+	int (*destroy_vm)(struct kvm *kvm);
+	void (*forward_request)(struct kvm_vcpu *vcpu);
+	int (*is_active)(void);
+};
+
+struct tee_mediator {
+	struct tee_mediator_ops *ops;
+};
+
+int tee_mediator_create_host(void);
+int tee_mediator_destroy_host(void);
+int tee_mediator_create_vm(struct kvm *kvm);
+int tee_mediator_destroy_vm(struct kvm *kvm);
+void tee_mediator_forward_request(struct kvm_vcpu *vcpu);
+int tee_mediator_is_active(void);
+int tee_mediator_register_ops(struct tee_mediator_ops *ops);
+
+#endif
--=20
2.43.0


--===============4462142906633567745==--

