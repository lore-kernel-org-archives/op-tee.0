From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH 2/4] firmware: arm_ffa: Remove incorrect assignment of driver_data
Date: Fri, 29 Apr 2022 12:39:44 +0100
Message-ID: <20220429113946.2087145-2-sudeep.holla@arm.com>
In-Reply-To: <20220429113946.2087145-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3049055664961805508=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3049055664961805508==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The ffa core driver currently assigns its own driver information
to individual ffa device driver_data which is wrong. Firstly, it leaks
this core driver information to individual ffa_device and hence to
ffa_driver. Secondly the ffa_device driver_data is for use by individual
ffa_driver and not for this core driver managing all those devices.

Fixes: d0c0bce83122 ("firmware: arm_ffa: Setup in-kernel users of FFA partiti=
ons")
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/dri=
ver.c
index 6a913ac91e8e..ec731e9e942b 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -694,8 +694,6 @@ static void ffa_setup_partitions(void)
 			       __func__, tpbuf->id);
 			continue;
 		}
-
-		ffa_dev_set_drvdata(ffa_dev, drv_info);
 	}
 	kfree(pbuf);
 }
--=20
2.36.0


--===============3049055664961805508==--

