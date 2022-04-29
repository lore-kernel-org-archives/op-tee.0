From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 4/4] tee: optee: Use ffa_dev_get_drvdata to fetch driver_data
Date: Fri, 29 Apr 2022 12:39:46 +0100
Message-ID: <20220429113946.2087145-4-sudeep.holla@arm.com>
In-Reply-To: <20220429113946.2087145-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4419310025237431779=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4419310025237431779==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Due to lack of an helper like ffa_dev_get_drvdata, this driver was
fetching driver_data directly accessing the structure member. Now that
we have added an helper, just use the same instead.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/tee/optee/ffa_abi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index a5eb4ef46971..b819a65cf89d 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -759,7 +759,7 @@ static const struct optee_ops optee_ffa_ops = {
 
 static void optee_ffa_remove(struct ffa_device *ffa_dev)
 {
-	struct optee *optee = ffa_dev->dev.driver_data;
+	struct optee *optee = ffa_dev_get_drvdata(ffa_dev);
 
 	optee_remove_common(optee);
 
-- 
2.36.0


--===============4419310025237431779==--

