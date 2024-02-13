From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: make tee_bus_type const
Date: Tue, 13 Feb 2024 14:45:51 +0000
Message-ID: <20240213-bus_cleanup-tee-v1-1-77945ae1a172@marliere.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5195065346342978875=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5195065346342978875==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the tee_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/tee/tee_core.c  | 2 +-
 include/linux/tee_drv.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 792d6fae4354..e59c20d74b36 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -1226,7 +1226,7 @@ static int tee_client_device_uevent(const struct device=
 *dev,
 	return add_uevent_var(env, "MODALIAS=3Dtee:%pUb", dev_id);
 }
=20
-struct bus_type tee_bus_type =3D {
+const struct bus_type tee_bus_type =3D {
 	.name		=3D "tee",
 	.match		=3D tee_client_device_match,
 	.uevent		=3D tee_client_device_uevent,
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 911ddf92dcee..71632e3c5f18 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -482,7 +482,7 @@ static inline bool tee_param_is_memref(struct tee_param *=
param)
 	}
 }
=20
-extern struct bus_type tee_bus_type;
+extern const struct bus_type tee_bus_type;
=20
 /**
  * struct tee_client_device - tee based device

---
base-commit: 716f4aaa7b48a55c73d632d0657b35342b1fefd7
change-id: 20240213-bus_cleanup-tee-c25729bbcd7f

Best regards,
--=20
Ricardo B. Marliere <ricardo@marliere.net>


--===============5195065346342978875==--

