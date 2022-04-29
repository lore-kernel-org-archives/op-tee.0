From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH 3/4] firmware: arm_ffa: Add ffa_dev_get_drvdata helper function
Date: Fri, 29 Apr 2022 12:39:45 +0100
Message-ID: <20220429113946.2087145-3-sudeep.holla@arm.com>
In-Reply-To: <20220429113946.2087145-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4789516852202441479=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4789516852202441479==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add a helper function to fetch ffa_dev's driver_data using
dev_get_drvdata. At the same time move existing ffa_dev_set_drvdata
to use dev_set_drvdata.

Suggested-by: Arunachalam Ganapathy <arunachalam.ganapathy@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/linux/arm_ffa.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 85651e41ded8..e5c76c1ef9ed 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -38,7 +38,12 @@ struct ffa_driver {
 
 static inline void ffa_dev_set_drvdata(struct ffa_device *fdev, void *data)
 {
-	fdev->dev.driver_data = data;
+	dev_set_drvdata(&fdev->dev, data);
+}
+
+static inline void *ffa_dev_get_drvdata(struct ffa_device *fdev)
+{
+	return dev_get_drvdata(&fdev->dev);
 }
 
 #if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
-- 
2.36.0


--===============4789516852202441479==--

