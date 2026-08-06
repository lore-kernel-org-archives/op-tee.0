Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29290C55838
	for <op-tee@archiver.kernel.org>; Thu,  6 Aug 2026 07:28:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3F3A644F8B
	for <op-tee@archiver.kernel.org>; Thu,  6 Aug 2026 07:28:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=ZolzeUSj;
	dkim-atps=neutral
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C083B43EFC
	for <op-tee@lists.trustedfirmware.org>; Thu,  6 Aug 2026 06:07:47 +0000 (UTC)
Received: from LAPTOP-99KJFSET (unknown [36.153.54.46])
	by smtp.qiye.163.com (Hmail) with ESMTP id 48fb94a46;
	Thu, 6 Aug 2026 14:07:38 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Jens Wiklander <jenswi@kernel.org>
Subject: [PATCH] tee: avoid accessing dma-buf shared memory after put
Date: Thu,  6 Aug 2026 14:07:26 +0800
Message-ID: <20260806060727.191-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fd5af2d7403a1kunm76c5a6df289405
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGh1MVk9JSkoeShpOHk5LS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VT01ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ZolzeUSj6YRiIv0ruZIBmWVn7EZqYLx5elbDP+PQDVOTVHKiNDX42GiLxepaSEG1cAAnfDOhEOuP3REMaZTvpBhoHuRcnmmGBDLVAUEXGvYZP/fpt2VMFbJc2yi+StiBsU66jy7HDm3CJp4evRISoeUyhLGaIiFgjCUcSUIotmk=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=9RA2Z8b4dmp5tFkLa2Y9ivfrK61mgA5v6jB4BSnog4w=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:101.71.155.0/24];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:4837, ipnet:101.71.0.0/16, country:CN];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_IN_DNSWL_NONE(0.00)[101.71.155.101:from];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C083B43EFC
X-Spamd-Bar: --
X-MailFrom: getshell@seu.edu.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: GF26KOQ7ZC5T7V2MDAJCXDAMFDMNXQUS
X-Message-ID-Hash: GF26KOQ7ZC5T7V2MDAJCXDAMFDMNXQUS
X-Mailman-Approved-At: Thu, 06 Aug 2026 07:28:08 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, Olivier Masse <olivier.masse@nxp.com>, Etienne Carriere <etienne.carriere@foss.st.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, jianhao.xu@seu.edu.cn, Hongyan Xu <getshell@seu.edu.cn>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GF26KOQ7ZC5T7V2MDAJCXDAMFDMNXQUS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

param_from_user_memref() obtains a temporary reference to the dma-buf
tee_shm wrapper by ID. If closing the shared-memory file descriptor races
with the ioctl, this temporary reference can be the wrapper's last one.
tee_shm_put() then frees the enclosing tee_shm_dmabuf_ref, but the function
still reads ref->parent_shm and ref->offset afterwards.

Save the parent pointer and offset before dropping the wrapper reference.
The additional parent reference keeps the parent shared memory alive for
the parameter list as before.

Fixes: 146bf4e75eca ("tee: new ioctl to a register tee_shm from a dmabuf file descriptor")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/tee/tee_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 1aac50c7c1de..489c39d5b35f 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -397,6 +397,7 @@ static int param_from_user_memref(struct tee_context *ctx,
 		}
 
 		if (shm->flags & TEE_SHM_DMA_BUF) {
+			struct tee_shm *parent_shm;
 			struct tee_shm_dmabuf_ref *ref;
 
 			ref = container_of(shm, struct tee_shm_dmabuf_ref, shm);
@@ -409,10 +410,11 @@ static int param_from_user_memref(struct tee_context *ctx,
 				 * list instead of the shm we got with
 				 * tee_shm_get_from_id() above.
 				 */
-				refcount_inc(&ref->parent_shm->refcount);
-				tee_shm_put(shm);
-				shm = ref->parent_shm;
+				parent_shm = ref->parent_shm;
 				offs = ref->offset;
+				refcount_inc(&parent_shm->refcount);
+				tee_shm_put(shm);
+				shm = parent_shm;
 			}
 		}
 	} else if (ctx->cap_memref_null) {
-- 
2.50.1.windows.1

