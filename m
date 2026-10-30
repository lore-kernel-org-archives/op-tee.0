Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAAB606A324
	for <op-tee@archiver.kernel.org>; Mon,  2 Nov 2026 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=uZiICyQt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b=X6O/iXJf
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6FA2D4545C
	for <op-tee@archiver.kernel.org>; Mon,  2 Nov 2026 19:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793647504;
	bh=gLtNGf+xnQZyZH8wL3QyPiPpErWnrVZ3n+qoNWqhy+w=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=uZiICyQtfm4jCIRY/1J0rPundjFe0hQrFBkcRHlO7j6qyIsQe5Fkrq+HuvEqb0TWX
	 i9nhkjhH1c84xE1dtCejoGvFL1atPIKc97CMYA7OtRF8uk96yf1qJVFAmGv2m4sDO1
	 03dt/tKXHc7YW0zoIBjKcZ7UU5LZvvBGLlslH+3Y3teMIUiuwir7AfG5y4RDH02Y/W
	 Qf3mXNue61+zr1XSS2IUQgD8XEsOW8O42CndQ1qtdxhhmNvzkd23mpEVf1zRBka7hu
	 ZgF12cRvvKYwWh8g8BLWka6DcVE66iWDdQtOOx7DhwzPvN3N8waitSWEuzGkHbgf3o
	 LxNBb3Om3BMwA==
Received: from sender-pp-o97.zoho.eu (sender-pp-o97.zoho.eu [136.143.169.97])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2F80944D68
	for <op-tee@lists.trustedfirmware.org>; Fri, 30 Oct 2026 13:30:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b=X6O/iXJf;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; t=1793367009; cv=none;
	d=zohomail.eu; s=zohoarc;
	b=IF5hD8IDyBnZq/6+I/nMLfEQsh5YkJwy8dU5EC/uUPQwEwp2VA/IyS4x0vwoBRl95kyJPvwYfnNehfoKnYam/6iOdjg5k36vMekkLK4MjktsKx6WC81Qmp5LDLheKaTw8pcOzRy9L9kBKViCWevJyvj0qD0fIGu8uYuA5+WNRZo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc;
	t=1793367009; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
	bh=yL5B9w2fd33NoSP+kcRsaKmbMe4jGgNs82wbIhiis7g=;
	b=hq24cMlQP1tQlQ2ZZhDxNAT835zmRCxc/IryVqm2r7+hx+/Go1lgxlaiitmR97KfpfBKGtbuxJMLvDtKolDUcLd7fCsTrs24q/1JM7J4pzBFkMW4sBD1JJrjoRQ6ghy3ESDEA9Sxs8l39cdAcp/SU793/0590Mn7aAjGYNwFOLM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=zohomail.eu;
	spf=pass  smtp.mailfrom=harukak@zohomail.eu;
	dmarc=pass header.from=<harukak@zohomail.eu>
DKIM-Signature: a=rsa-sha256; b=X6O/iXJfSk+HRQv4nN94agTdPYyTloIEfdVTNmVsuwixzoGOuRkL9aZqzoEAkswCHKZelsAsHmLYaHUmdM/qXB18udMiwOqmUGtKVzKCoi9W7VKosRNxiR00JOoWxfCMIznCEipUttblDIlZyNARKK2YZNWEsu0UKTy4IoS63WU=; c=relaxed/relaxed; s=zoho; d=zohomail.eu; v=1; bh=yL5B9w2fd33NoSP+kcRsaKmbMe4jGgNs82wbIhiis7g=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793367006510399.5040981229382;
	Fri, 30 Oct 2026 14:30:06 +0100 (CET)
To: Jens Wiklander <jenswi@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 1/2] rpmb: stop the routing after unregister
Date: Fri, 30 Oct 2026 22:29:59 +0900
Message-ID: <20261030133000.24147-2-harukak@zohomail.eu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030133000.24147-1-harukak@zohomail.eu>
References: <20261030133000.24147-1-harukak@zohomail.eu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	ARC_ALLOW(-1.00)[zohomail.eu:s=zohoarc:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.eu,reject];
	R_MISSING_CHARSET(0.50)[];
	ONCE_RECEIVED(0.20)[];
	R_SPF_ALLOW(-0.20)[+ip4:136.143.169.0/24];
	R_DKIM_ALLOW(-0.20)[zohomail.eu:s=zoho];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[arndb.de,linuxfoundation.org,gmail.com,redhat.com,linux.alibaba.com,kernel.org,linaro.org,sandisk.com,oss.qualcomm.com,lists.linux.dev,lists.trustedfirmware.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:205111, ipnet:136.143.169.0/24, country:NL];
	RCVD_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[136.143.169.97:from];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[136.143.169.97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[zohomail.eu:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2F80944D68
X-Spamd-Bar: ---
X-MailFrom: harukak@zohomail.eu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: EAXXVXEEM5C4N4MVZNB334XLD7MKG5OI
X-Message-ID-Hash: EAXXVXEEM5C4N4MVZNB334XLD7MKG5OI
X-Mailman-Approved-At: Mon, 02 Nov 2026 19:24:47 +0000
CC: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Wang <jasowangio@gmail.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Sumit Garg <sumit.garg@kernel.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Tomas Winkler <tomas.winkler@sandisk.com>, Ulf Hansson <ulfh@kernel.org>, Harald Mommer <harald.mommer@oss.qualcomm.com>, virtualization@lists.linux.dev, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EAXXVXEEM5C4N4MVZNB334XLD7MKG5OI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Haruka Kuze via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Haruka Kuze <harukak@zohomail.eu>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Haruka Kuze <harukak@zohomail.eu>

OP-TEE has a reference of RPMB device it used. So, it can route
frames through the device after rpmb_dev_unregister() is called.
Therefore, the parent device passed to route_frames() can be
already freed, for example, mmc_blk_remove_rpmb_part() drops the
last reference after rpmb unregister.

This patch clears the route_frames when the device is going to
be removed by getting new rwsem and makes rpmb_route_frames()
return -ENODEV if the device is gone.

Fixes: 1e9046e3a154 ("rpmb: add Replay Protected Memory Block (RPMB) subsystem")
Assisted-by: LLM
Signed-off-by: Haruka Kuze <harukak@zohomail.eu>
---
 drivers/misc/rpmb-core.c | 14 +++++++++++++-
 include/linux/rpmb.h     |  4 ++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
index ecf14acf230a..0ae018d1a276 100644
--- a/drivers/misc/rpmb-core.c
+++ b/drivers/misc/rpmb-core.c
@@ -45,7 +45,7 @@ EXPORT_SYMBOL_GPL(rpmb_dev_put);
  * @rsp:	rpmb response frames
  * @rsp_len:	length of rpmb response frames in bytes
  *
- * Returns: < 0 on failure
+ * Returns: < 0 on failure, -ENODEV if the device has been unregistered
  */
 int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
 		      unsigned int req_len, u8 *rsp, unsigned int rsp_len)
@@ -53,6 +53,10 @@ int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
 	if (!req || !req_len || !rsp || !rsp_len)
 		return -EINVAL;
 
+	guard(rwsem_read)(&rdev->lock);
+	if (!rdev->descr.route_frames)
+		return -ENODEV;
+
 	return rdev->descr.route_frames(rdev->dev.parent, req, req_len,
 					rsp, rsp_len);
 }
@@ -126,6 +130,10 @@ EXPORT_SYMBOL_GPL(rpmb_interface_unregister);
  * This function should be called from the release function of the
  * underlying device used when the RPMB device was registered.
  *
+ * Once this returns, rpmb_route_frames() no longer calls into
+ * the driver, even though the users might still hold a reference
+ * to the RPMB dev.
+ *
  * Returns: < 0 on failure
  */
 int rpmb_dev_unregister(struct rpmb_dev *rdev)
@@ -133,6 +141,9 @@ int rpmb_dev_unregister(struct rpmb_dev *rdev)
 	if (!rdev)
 		return -EINVAL;
 
+	scoped_guard(rwsem_write, &rdev->lock)
+		rdev->descr.route_frames = NULL;
+
 	device_del(&rdev->dev);
 
 	rpmb_dev_put(rdev);
@@ -165,6 +176,7 @@ struct rpmb_dev *rpmb_dev_register(struct device *dev,
 	if (!rdev)
 		return ERR_PTR(-ENOMEM);
 	rdev->descr = *descr;
+	init_rwsem(&rdev->lock);
 	rdev->descr.dev_id = kmemdup(descr->dev_id, descr->dev_id_len,
 				     GFP_KERNEL);
 	if (!rdev->descr.dev_id) {
diff --git a/include/linux/rpmb.h b/include/linux/rpmb.h
index ed3f8e431eff..0a976572d1cd 100644
--- a/include/linux/rpmb.h
+++ b/include/linux/rpmb.h
@@ -7,6 +7,7 @@
 #define __RPMB_H__
 
 #include <linux/device.h>
+#include <linux/rwsem.h>
 #include <linux/types.h>
 
 /**
@@ -51,12 +52,15 @@ struct rpmb_descr {
  * @id               : device_id
  * @list_node        : linked list node
  * @descr            : RPMB description
+ * @lock             : protect @descr.route_frames which is cleared when this
+ *                     device is unregistered
  */
 struct rpmb_dev {
 	struct device dev;
 	int id;
 	struct list_head list_node;
 	struct rpmb_descr descr;
+	struct rw_semaphore lock;
 };
 
 #define to_rpmb_dev(x)		container_of((x), struct rpmb_dev, dev)
-- 
2.55.0

