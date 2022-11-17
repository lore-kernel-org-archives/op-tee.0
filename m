From: ruanjinjie <ruanjinjie@huawei.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH] tee: optee: fix possible memory leak in optee_register_device()
Date: Thu, 17 Nov 2022 11:22:20 +0800
Message-ID: <20221117032220.3442738-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7748441586740420977=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7748441586740420977==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

If device_register() returns error in optee_register_device(),
name of kobject which is allocated in dev_set_name() called in device_add()
is leaked.

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized.

Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
---
 drivers/tee/optee/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index f3947be13e2e..64f0e047c23d 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -80,7 +80,7 @@ static int optee_register_device(const uuid_t *device_uuid)
 	rc = device_register(&optee_device->dev);
 	if (rc) {
 		pr_err("device registration failed, err: %d\n", rc);
-		kfree(optee_device);
+		put_device(&optee_device->dev);
 	}
 
 	return rc;
-- 
2.25.1


--===============7748441586740420977==--

