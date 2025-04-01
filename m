From: Yuvraj Sakshith <yuvraj.kernel@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [RFC PATCH 3/7] KVM: Notify TEE Mediator when KVM creates and destroys guests
Date: Tue, 01 Apr 2025 22:35:23 +0530
Message-ID: <20250401170527.344092-4-yuvraj.kernel@gmail.com>
In-Reply-To: <20250401170527.344092-1-yuvraj.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4099830195550578383=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4099830195550578383==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

TEEs supporting virtualization in the rich execution environment
would want to know about guest creation and destruction by the
hypervisor.

This change notifies the TEE mediator of these events (if its active).

Signed-off-by: Yuvraj Sakshith <yuvraj.kernel@gmail.com>
---
 virt/kvm/kvm_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ba0327e2d0d3..65f1f5075fdd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -49,6 +49,7 @@
 #include <linux/lockdep.h>
 #include <linux/kthread.h>
 #include <linux/suspend.h>
+#include <linux/tee_mediator.h>
 
 #include <asm/processor.h>
 #include <asm/ioctl.h>
@@ -1250,7 +1251,10 @@ static void kvm_destroy_vm(struct kvm *kvm)
 {
 	int i;
 	struct mm_struct *mm = kvm->mm;
-
+#ifdef CONFIG_TEE_MEDIATOR
+	if (tee_mediator_is_active())
+		(void) tee_mediator_destroy_vm(kvm);
+#endif
 	kvm_destroy_pm_notifier(kvm);
 	kvm_uevent_notify_change(KVM_EVENT_DESTROY_VM, kvm);
 	kvm_destroy_vm_debugfs(kvm);
@@ -5407,7 +5411,10 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
 	 * care of doing kvm_put_kvm(kvm).
 	 */
 	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
-
+#ifdef CONFIG_TEE_MEDIATOR
+	if (tee_mediator_is_active())
+		(void) tee_mediator_create_vm(kvm);
+#endif
 	fd_install(fd, file);
 	return fd;
 
-- 
2.43.0


--===============4099830195550578383==--

