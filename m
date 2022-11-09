From: Yang Yingliang <yangyingliang@huawei.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH] tee: optee: fix possible memory leak in optee_register_device()
Date: Wed, 09 Nov 2022 22:01:24 +0800
Message-ID: <20221109140124.3288803-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7318906959615084828=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7318906959615084828==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

If device_register() returns error in optee_register_device(),
the name allocated by dev_set_name() need be freed. As comment
of device_register() says, it should use put_device() to give
up the reference in the error path. So fix this by calling
put_device(), then the name can be freed in kobject_cleanup(),
and optee_device is freed in optee_release_device().

Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
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


--===============7318906959615084828==--

