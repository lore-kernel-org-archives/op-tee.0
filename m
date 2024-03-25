From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v4 5/5] MAINTAINERS: tee: tstee: Add entry
Date: Mon, 25 Mar 2024 16:11:05 +0100
Message-ID: <20240325151105.135667-6-balint.dobszay@arm.com>
In-Reply-To: <20240325151105.135667-1-balint.dobszay@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2147575930756119589=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2147575930756119589==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Create an entry for the newly added Trusted Services TEE driver, with
Sudeep and myself as maintainers.

Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd221a7d4d1c..eaa89feabd25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22470,6 +22470,15 @@ F:	Documentation/ABI/testing/configfs-tsm
 F:	drivers/virt/coco/tsm.c
 F:	include/linux/tsm.h
 
+TRUSTED SERVICES TEE DRIVER
+M:	Balint Dobszay <balint.dobszay@arm.com>
+M:	Sudeep Holla <sudeep.holla@arm.com>
+L:	linux-arm-kernel(a)lists.infradead.org (moderated for non-subscribers)
+L:	trusted-services(a)lists.trustedfirmware.org
+S:	Maintained
+F:	Documentation/tee/ts-tee.rst
+F:	drivers/tee/tstee/
+
 TTY LAYER AND SERIAL DRIVERS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Jiri Slaby <jirislaby@kernel.org>
-- 
2.34.1


--===============2147575930756119589==--

