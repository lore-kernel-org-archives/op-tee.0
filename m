From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH 1/4] firmware: arm_ffa: Fix uuid parameter to ffa_partition_probe
Date: Fri, 29 Apr 2022 12:39:43 +0100
Message-ID: <20220429113946.2087145-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8206458479724078535=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8206458479724078535==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

While we pass uuid_null intentionally to ffa_partition_probe in
ffa_setup_partitions to get the count of the partitions, it must not be
uuid_null in ffa_partition_info_get which is used by the ffa_drivers
to fetch the specific partition info passing the UUID of the partition.

Fix ffa_partition_info_get by passing the received uuid down to
ffa_partition_probe so that the correct partition information is fetched.

Fixes: d0c0bce83122 ("firmware: arm_ffa: Setup in-kernel users of FFA partiti=
ons")
Reported-by: Arunachalam Ganapathy <arunachalam.ganapathy@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/dri=
ver.c
index ccccecae615f..6a913ac91e8e 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -588,7 +588,7 @@ static int ffa_partition_info_get(const char *uuid_str,
 		return -ENODEV;
 	}
=20
-	count =3D ffa_partition_probe(&uuid_null, &pbuf);
+	count =3D ffa_partition_probe(&uuid, &pbuf);
 	if (count <=3D 0)
 		return -ENOENT;
=20
--=20
2.36.0


--===============8206458479724078535==--

