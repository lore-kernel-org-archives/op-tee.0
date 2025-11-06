Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3231ECCFA03
	for <op-tee@archiver.kernel.org>; Thu,  6 Nov 2025 11:03:48 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8D40B3F74F
	for <op-tee@archiver.kernel.org>; Thu,  6 Nov 2025 11:03:47 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4EEAA41BA3
	for <op-tee@lists.trustedfirmware.org>; Thu,  6 Nov 2025 10:20:18 +0000 (UTC)
X-UUID: 2e1643c6bafa11f0a38c85956e01ac42-20251106
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:8ac0c484-78c8-42d5-a003-cdcf468be62e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:4e918cfdeedce2de0dbcf3a87f7a3545,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|15|50,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2e1643c6bafa11f0a38c85956e01ac42-20251106
X-User: yangzhao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yangzhao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1990498614; Thu, 06 Nov 2025 18:20:12 +0800
From: yangzhao <yangzhao@kylinos.cn>
To: op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tee: fix illegal pointer dereference in tee_shm_put()
Date: Thu,  6 Nov 2025 18:20:08 +0800
Message-Id: <20251106102008.1310234-1-yangzhao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4EEAA41BA3
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.80 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:124.126.103.232];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	NEURAL_SPAM(0.00)[0.850];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:4847, ipnet:124.126.0.0/16, country:CN];
	ARC_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	R_DKIM_NA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-MailFrom: yangzhao@kylinos.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: MGIWWS55XUHLDXIZLT46OD4TDQOJWENL
X-Message-ID-Hash: MGIWWS55XUHLDXIZLT46OD4TDQOJWENL
X-Mailman-Approved-At: Thu, 06 Nov 2025 11:03:01 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, yangzhao <yangzhao@kylinos.cn>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MGIWWS55XUHLDXIZLT46OD4TDQOJWENL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

In tee_shm_put(), there is not only the NULL pointer dereference,
but also the illegal pointer dereference.

shutdown() --->
    __optee_disable_shm_cache -->
        shm = reg_pair_to_ptr(...);
        tee_shm_free(shm); -->
            tee_shm_put(shm); //crash: shm->ctx maybe NULL pointer or illegal pointer

Check whether the pointer is NULL and whether the pointer address is valid.

This issue occurs when rich world uses the 6.x version of the kernel and
optee secure world uses a lower version (such as version 3.2), and it is
highly likely to trigger a kernel panic when conducting hibernate tests.

Fixes: e4a718a3a47e ("tee: fix NULL pointer dereference in tee_shm_put")
Signed-off-by: yangzhao <yangzhao@kylinos.cn>
---
 drivers/tee/tee_shm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 4a47de4bb2e5..de01d16409c1 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -722,7 +722,14 @@ void tee_shm_put(struct tee_shm *shm)
 	struct tee_device *teedev;
 	bool do_release = false;
 
-	if (!shm || !shm->ctx || !shm->ctx->teedev)
+	/* checking pointer */
+	if (IS_ERR_OR_NULL(shm) || !virt_addr_valid(shm))
+		return;
+
+	if (IS_ERR_OR_NULL(shm->ctx) || !virt_addr_valid(shm->ctx))
+		return;
+
+	if (IS_ERR_OR_NULL(shm->ctx->teedev) || !virt_addr_valid(shm->ctx->teedev))
 		return;
 
 	teedev = shm->ctx->teedev;
-- 
2.25.1

