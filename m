From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v10 5/5] efivarfs: force RO when remounting if SetVariable is
 not supported
Date: Tue, 07 Nov 2023 14:40:56 +0900
Message-ID: <20231107054057.1893-6-masahisa.kojima@linaro.org>
In-Reply-To: <20231107054057.1893-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0131601422580517343=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0131601422580517343==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

If SetVariable at runtime is not supported by the firmware we never assign
a callback for that function. At the same time mount the efivarfs as
RO so no one can call that.  However, we never check the permission flags
when someone remounts the filesystem as RW. As a result this leads to a
crash looking like this:

$ mount -o remount,rw /sys/firmware/efi/efivars
$ efi-updatevar -f PK.auth PK

[  303.279166] Unable to handle kernel NULL pointer dereference at virtual ad=
dress 0000000000000000
[  303.280482] Mem abort info:
[  303.280854]   ESR =3D 0x0000000086000004
[  303.281338]   EC =3D 0x21: IABT (current EL), IL =3D 32 bits
[  303.282016]   SET =3D 0, FnV =3D 0
[  303.282414]   EA =3D 0, S1PTW =3D 0
[  303.282821]   FSC =3D 0x04: level 0 translation fault
[  303.283771] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000004258c000
[  303.284913] [0000000000000000] pgd=3D0000000000000000, p4d=3D0000000000000=
000
[  303.286076] Internal error: Oops: 0000000086000004 [#1] PREEMPT SMP
[  303.286936] Modules linked in: qrtr tpm_tis tpm_tis_core crct10dif_ce arm_=
smccc_trng rng_core drm fuse ip_tables x_tables ipv6
[  303.288586] CPU: 1 PID: 755 Comm: efi-updatevar Not tainted 6.3.0-rc1-0010=
8-gc7d0c4695c68 #1
[  303.289748] Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2=
023.04-00627-g88336918701d 04/01/2023
[  303.291150] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D=
--)
[  303.292123] pc : 0x0
[  303.292443] lr : efivar_set_variable_locked+0x74/0xec
[  303.293156] sp : ffff800008673c10
[  303.293619] x29: ffff800008673c10 x28: ffff0000037e8000 x27: 0000000000000=
000
[  303.294592] x26: 0000000000000800 x25: ffff000002467400 x24: 0000000000000=
027
[  303.295572] x23: ffffd49ea9832000 x22: ffff0000020c9800 x21: ffff000002467=
000
[  303.296566] x20: 0000000000000001 x19: 00000000000007fc x18: 0000000000000=
000
[  303.297531] x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaaac807a=
b54
[  303.298495] x14: ed37489f673633c0 x13: 71c45c606de13f80 x12: 47464259e219a=
cf4
[  303.299453] x11: ffff000002af7b01 x10: 0000000000000003 x9 : 0000000000000=
002
[  303.300431] x8 : 0000000000000010 x7 : ffffd49ea8973230 x6 : 0000000000a85=
201
[  303.301412] x5 : 0000000000000000 x4 : ffff0000020c9800 x3 : 0000000000000=
7fc
[  303.302370] x2 : 0000000000000027 x1 : ffff000002467400 x0 : ffff000002467=
000
[  303.303341] Call trace:
[  303.303679]  0x0
[  303.303938]  efivar_entry_set_get_size+0x98/0x16c
[  303.304585]  efivarfs_file_write+0xd0/0x1a4
[  303.305148]  vfs_write+0xc4/0x2e4
[  303.305601]  ksys_write+0x70/0x104
[  303.306073]  __arm64_sys_write+0x1c/0x28
[  303.306622]  invoke_syscall+0x48/0x114
[  303.307156]  el0_svc_common.constprop.0+0x44/0xec
[  303.307803]  do_el0_svc+0x38/0x98
[  303.308268]  el0_svc+0x2c/0x84
[  303.308702]  el0t_64_sync_handler+0xf4/0x120
[  303.309293]  el0t_64_sync+0x190/0x194
[  303.309794] Code: ???????? ???????? ???????? ???????? (????????)
[  303.310612] ---[ end trace 0000000000000000 ]---

Fix this by adding a .reconfigure() function to the fs operations which
we can use to check the requested flags and deny anything that's not RO
if the firmware doesn't implement SetVariable at runtime.

Fixes: f88814cc2578 ("efi/efivars: Expose RT service availability via efivars=
 abstraction")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 fs/efivarfs/super.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 5751413d124c..2b71e5106d13 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -16,6 +16,7 @@
 #include <linux/magic.h>
 #include <linux/statfs.h>
 #include <linux/notifier.h>
+#include <linux/printk.h>
=20
 #include "internal.h"
=20
@@ -356,9 +357,20 @@ static int efivarfs_get_tree(struct fs_context *fc)
 	return get_tree_single(fc, efivarfs_fill_super);
 }
=20
+static int efivarfs_reconfigure(struct fs_context *fc)
+{
+	if (!efivar_supports_writes() && !(fc->sb_flags & SB_RDONLY)) {
+		pr_err("Firmware does not support SetVariableRT. Can not remount with rw\n=
");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct fs_context_operations efivarfs_context_ops =3D {
 	.get_tree	=3D efivarfs_get_tree,
 	.parse_param	=3D efivarfs_parse_param,
+	.reconfigure	=3D efivarfs_reconfigure,
 };
=20
 static int efivarfs_init_fs_context(struct fs_context *fc)
--=20
2.39.2


--===============0131601422580517343==--

