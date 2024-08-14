From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 1/7] firmware: arm_ffa: Some coding style fixes
Date: Wed, 14 Aug 2024 14:48:50 +0100
Message-ID: <20240814-ffa_v1-2-v1-1-9e9abef69b21@arm.com>
In-Reply-To: <20240814-ffa_v1-2-v1-0-9e9abef69b21@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9141988949573252303=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9141988949573252303==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

These changes fixes a set of below coding style issues:
1. spaces required around that '=3D' (ctx:VxW)
2. possible unnecessary 'out of memory' message
3. unnecessary for single statement blocks

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/dri=
ver.c
index 7ba98c7af2e9..b4b3ecc9824e 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1242,7 +1242,7 @@ ffa_bus_notifier(struct notifier_block *nb, unsigned lo=
ng action, void *data)
=20
 	if (action =3D=3D BUS_NOTIFY_BIND_DRIVER) {
 		struct ffa_driver *ffa_drv =3D to_ffa_driver(dev->driver);
-		const struct ffa_device_id *id_table=3D ffa_drv->id_table;
+		const struct ffa_device_id *id_table =3D ffa_drv->id_table;
=20
 		/*
 		 * FF-A v1.1 provides UUID for each partition as part of the
@@ -1327,8 +1327,6 @@ static int ffa_setup_partitions(void)
 	/* Allocate for the host */
 	info =3D kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
-		pr_err("%s: failed to alloc Host partition ID 0x%x. Abort.\n",
-		       __func__, drv_info->vm_id);
 		/* Already registered devices are freed on bus_exit */
 		ffa_partitions_cleanup();
 		return -ENOMEM;
@@ -1609,9 +1607,8 @@ static int __init ffa_init(void)
 		return ret;
=20
 	drv_info =3D kzalloc(sizeof(*drv_info), GFP_KERNEL);
-	if (!drv_info) {
+	if (!drv_info)
 		return -ENOMEM;
-	}
=20
 	ret =3D ffa_version_check(&drv_info->version);
 	if (ret)

--=20
2.46.0


--===============9141988949573252303==--

