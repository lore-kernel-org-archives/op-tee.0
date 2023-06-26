From: shiju.jose@huawei.com
To: op-tee@lists.trustedfirmware.org
Subject: [RFC PATCH 1/1] tests/avocado: Introduce avocado tests for aarch64
 S-EL2 booting
Date: Mon, 26 Jun 2023 19:48:25 +0800
Message-ID: <20230626114825.1859-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7562147840505720693=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7562147840505720693==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Shiju Jose <shiju.jose@huawei.com>

Add avocado tests for aarch64 S-EL2, include booting and
run xtest on linux terminal.

The prebuilt S-EL2 images are corresponding to the
https://github.com/jenswi-linaro/manifest.git \
-m qemu_v8.xml -b qemu_sel2

How to run
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
"make check-avocado" in qemu/build
or
with QEMU_CI=3D1 and QEMU_CI_AVOCADO_TESTING=3D1
"amd64-fedora-container",  "build-cfi-aarch64" and
"avocado-cfi-aarch64" on gitlab for qemu

Question:
Presently tested with the prebuilt images temporarily  in
/tests/data/sel2-boot-images/prebuilt-sel2-images.zip

Can the prebuilt images for SEL2 available in the OP-TEE/TF-A/similar
release?

Note1:
The pre-built S-EL2 images used are few months old
as there are some issue found in xtest with the images build from
the recent Linaro SEL2 code.

Note2:
On gitlab CI, there is an outstanding issue found in booting linux,
after starting network OK.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 tests/avocado/machine_aarch64_virt.py         |  63 ++++++++++++++++++
 .../sel2-boot-images/prebuilt-sel2-images.zip | Bin 0 -> 23151996 bytes
 2 files changed, 63 insertions(+)
 create mode 100644 tests/data/sel2-boot-images/prebuilt-sel2-images.zip

diff --git a/tests/avocado/machine_aarch64_virt.py b/tests/avocado/machine_aa=
rch64_virt.py
index a90dc6ff4b..039673fd40 100644
--- a/tests/avocado/machine_aarch64_virt.py
+++ b/tests/avocado/machine_aarch64_virt.py
@@ -11,13 +11,16 @@
 import time
 import os
 import logging
+import shutil
=20
 from avocado_qemu import QemuSystemTest
 from avocado_qemu import wait_for_console_pattern
 from avocado_qemu import exec_command
 from avocado_qemu import BUILD_DIR
+from avocado_qemu import is_readable_executable_file
 from avocado.utils import process
 from avocado.utils.path import find_command
+from avocado.utils import archive
=20
 class Aarch64VirtMachine(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
@@ -144,3 +147,63 @@ def test_aarch64_virt_gicv2(self):
         :avocado: tags=3Dcpu:max
         """
         self.common_aarch64_virt("virt,gic-version=3D2")
+
+    def copy_sel2_prebuilt_images(self):
+        """extract the prebuilt S-EL2 binaries to the test directory. """
+
+        relative_path =3D "./tests/data/sel2-boot-images/prebuilt-sel2-image=
s.zip"
+        prebuilt_bin_path =3D os.path.join(BUILD_DIR, relative_path)
+        target_dir =3D os.path.join(BUILD_DIR)
+
+        self.assertTrue(os.path.exists(prebuilt_bin_path))
+        self.assertTrue(os.path.exists(target_dir))
+        archive.extract(prebuilt_bin_path, target_dir)
+
+    timeout =3D 1000
+    def test_aarch64_sel2_boot(self):
+        """
+        :avocado: tags=3Darch:aarch64
+        :avocado: tags=3Dmachine:secure
+        :avocado: tags=3Dmachine:virt
+        :avocado: tags=3Dcpu:max
+        """
+
+        self.copy_sel2_prebuilt_images()
+        self.vm.set_console()
+        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=3DttyAMA0,38400 keep_bootcon root=3D=
/dev/vda2 nokaslr')
+
+        self.vm.add_args("-cpu", "max,sme=3Doff,pauth-impdef=3Don")
+        self.vm.add_args("-machine",
+                         "virt,secure=3Don,"
+                         "virtualization=3Don,"
+                         "mte=3Don,"
+                         "gic-version=3D3")
+        self.vm.add_args("-d", "unimp")
+        self.vm.add_args("-semihosting-config", "enable=3Don,target=3Dnative=
")
+        self.vm.add_args("-smp", "2", "-m", "1024")
+        self.vm.add_args('-bios', 'bl1.bin')
+        self.vm.add_args('-initrd', 'rootfs.cpio.gz')
+        self.vm.add_args('-kernel', 'Image')
+        self.vm.add_args('-machine', 'acpi=3Doff')
+        self.vm.add_args('-append', kernel_command_line)
+        self.vm.add_args('-object', 'rng-random,filename=3D/dev/urandom,id=
=3Drng0')
+        self.vm.add_args('-device', 'virtio-rng-pci,rng=3Drng0,max-bytes=3D1=
024,period=3D1000')
+        self.vm.launch()
+        self.wait_for_console_pattern('Welcome to Buildroot')
+        time.sleep(0.1)
+        exec_command(self, 'root')
+        time.sleep(0.1)
+
+    def test_aarch64_sel2_xtest(self):
+        """
+        :avocado: tags=3Darch:aarch64
+        :avocado: tags=3Dmachine:secure
+        :avocado: tags=3Dmachine:virt
+        :avocado: tags=3Dcpu:max
+        """
+        self.test_aarch64_sel2_boot()
+        exec_command(self, 'xtest')
+        time.sleep(0.1)
+        self.wait_for_console_pattern('subtests of which 0 failed')
+        time.sleep(0.1)
diff --git a/tests/data/sel2-boot-images/prebuilt-sel2-images.zip b/tests/dat=
a/sel2-boot-images/prebuilt-sel2-images.zip
new file mode 100644
index 0000000000..13c5e1e4cc
Binary files /dev/null and b/tests/data/sel2-boot-images/prebuilt-sel2-images=
.zip differ
--=20
2.25.1


--===============7562147840505720693==--

