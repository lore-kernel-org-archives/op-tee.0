From: Ludvig Pärsson <ludvig.parsson@axis.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: optee: Populate child nodes in probe function
Date: Wed, 09 Nov 2022 16:07:26 +0000
Message-ID: <20221109160708.507481-1-ludvig.parsson@axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8607900048893455749=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8607900048893455749==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently there is no dependency between the "linaro,scmi-optee" driver
and the tee_core. If the scmi-optee driver gets probed before the
tee_bus_type is initialized, then we will get an unwanted error print.

This patch enables putting scmi-optee nodes as children to the optee
node in devicetree, which indirectly creates the missing dependency.

Signed-off-by: Ludvig Pärsson <ludvig.parsson@axis.com>
---
 drivers/tee/optee/smc_abi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a1c1fa1a9c28..be6f02fd5a7f 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1533,6 +1533,11 @@ static int optee_probe(struct platform_device *pdev)
 	if (rc)
 		goto err_disable_shm_cache;
 
+	/* Populate any dependent child node (if any) */
+	rc = devm_of_platform_populate(&pdev->dev);
+	if (rc)
+		goto err_disable_shm_cache;
+
 	pr_info("initialized driver\n");
 	return 0;
 
-- 
2.30.2


--===============8607900048893455749==--

