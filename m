From: Jerome Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: [op-tee] [PATCH v2 2/2] hw/arm/virt: dt: add kaslr-seed property
Date: Mon, 20 Apr 2020 14:18:07 +0200
Message-ID: <20200420121807.8204-3-jerome@forissier.org>
In-Reply-To: <20200420121807.8204-1-jerome@forissier.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6318344367704899680=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6318344367704899680==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Generate random seeds to be used by the non-secure and/or secure OSes
for ASLR. The seeds are 64-bit random values exported via the DT
properties /chosen/kaslr-seed [1] and /secure-chosen/kaslr-seed, the
latter being used by OP-TEE [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3De5bc0c37c97e1
[2] https://github.com/OP-TEE/optee_os/commit/ef262691fe0e

Signed-off-by: Jerome Forissier <jerome@forissier.org>
---
 hw/arm/virt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c3073b7cf19..1b6f3971bf7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -77,6 +77,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
+#include "qemu/guest-random.h"
=20
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -213,6 +214,18 @@ static bool cpu_type_valid(const char *cpu)
     return false;
 }
=20
+static void create_kaslr_seed(VirtMachineState *vms, const char *node)
+{
+    Error *err =3D NULL;
+    uint64_t seed;
+
+    if (qemu_guest_getrandom(&seed, sizeof(seed), &err)) {
+        error_free(err);
+        return;
+    }
+    qemu_fdt_setprop_u64(vms->fdt, node, "kaslr-seed", seed);
+}
+
 static void create_fdt(VirtMachineState *vms)
 {
     MachineState *ms =3D MACHINE(vms);
@@ -233,9 +246,11 @@ static void create_fdt(VirtMachineState *vms)
=20
     /* /chosen must exist for load_dtb to fill in necessary properties later=
 */
     qemu_fdt_add_subnode(fdt, "/chosen");
+    create_kaslr_seed(vms, "/chosen");
=20
     if (vms->secure) {
         qemu_fdt_add_subnode(fdt, "/secure-chosen");
+        create_kaslr_seed(vms, "/secure-chosen");
     }
=20
     /* Clock node, for the benefit of the UART. The kernel device tree
--=20
2.20.1


--===============6318344367704899680==--

