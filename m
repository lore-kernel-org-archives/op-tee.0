From: Jerome Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: [op-tee] [PATCH v2 1/2] hw/arm/virt: dt: move creation of
 /secure-chosen to create_fdt()
Date: Mon, 20 Apr 2020 14:18:06 +0200
Message-ID: <20200420121807.8204-2-jerome@forissier.org>
In-Reply-To: <20200420121807.8204-1-jerome@forissier.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2437618145289214694=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2437618145289214694==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The /secure-chosen node is currently used only by create_uart(), but
this will change. Therefore move the creation of this node to
create_fdt().

Signed-off-by: Jerome Forissier <jerome@forissier.org>
---
 hw/arm/virt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7dc96abf72c..c3073b7cf19 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -234,6 +234,10 @@ static void create_fdt(VirtMachineState *vms)
     /* /chosen must exist for load_dtb to fill in necessary properties later=
 */
     qemu_fdt_add_subnode(fdt, "/chosen");
=20
+    if (vms->secure) {
+        qemu_fdt_add_subnode(fdt, "/secure-chosen");
+    }
+
     /* Clock node, for the benefit of the UART. The kernel device tree
      * binding documentation claims the PL011 node clock properties are
      * optional but in practice if you omit them the kernel refuses to
@@ -761,7 +765,6 @@ static void create_uart(const VirtMachineState *vms, int =
uart,
         qemu_fdt_setprop_string(vms->fdt, nodename, "status", "disabled");
         qemu_fdt_setprop_string(vms->fdt, nodename, "secure-status", "okay");
=20
-        qemu_fdt_add_subnode(vms->fdt, "/secure-chosen");
         qemu_fdt_setprop_string(vms->fdt, "/secure-chosen", "stdout-path",
                                 nodename);
     }
--=20
2.20.1


--===============2437618145289214694==--

