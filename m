Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EF8E9DE70
	for <op-tee@archiver.kernel.org>; Thu,  9 Apr 2026 09:10:48 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AC7EE43B58
	for <op-tee@archiver.kernel.org>; Thu,  9 Apr 2026 09:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1775725847;
	bh=MRTBTcUxuUL261/8JRtWYsWtc4LCfGGZgJoAnxCV6AY=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=XbgLkAy3X1AO859dkswIr/ViEd4KY4cRz7RRBs6WcBtyPgi3fufV14zw3oXoxj87F
	 9niDPUFasVdAPbmNfr3lfqj65VcKpTn53uLmP6uvdyA14o6JC05TvNIWTsPzu3Ti1v
	 O8gtopnIMXKg5LWpP67W/ylYztPInP9xLk71BlwiACRiJml1mmgHrX82TqeT5z1/gf
	 Y4Po3H3GmRlN4j/Yg5RSkfKftdv6KhEDdUhsw2PBhoRoda/LoN6WdPI+vjqJGVWrP0
	 2HOHPJwqD2h1x03UbS/7ildRdCzt2aGYJPYy/M914Y3PyY2T9l2F74skQ2Laj8+fAR
	 WuTzopN51wRvg==
Received: from mail.auroraos.dev (unknown [95.181.193.9])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 548D8409FE
	for <op-tee@lists.trustedfirmware.org>; Wed,  8 Apr 2026 15:54:17 +0000 (UTC)
Received: from nixos.omp.ru (77.37.240.142) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 8 Apr 2026
 18:54:06 +0300
To: <jens.wiklander@linaro.org>, <op-tee@lists.trustedfirmware.org>
Subject: [PATCH] tee: shm: fix shm leak in register_shm_helper()
Date: Wed, 8 Apr 2026 18:52:03 +0300
Message-ID: <20260408155203.817744-1-g.osokin@auroraos.dev>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [77.37.240.142]
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.30 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[auroraos.dev,quarantine];
	R_SPF_ALLOW(-0.20)[+mx];
	MIME_GOOD(-0.10)[text/plain];
	ONCE_RECEIVED(0.10)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:49063, ipnet:95.181.193.0/24, country:RU];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[77.37.240.142:received];
	DIRECT_TO_MX(0.00)[git-send-email 2.50.1];
	FROM_EQ_ENVFROM(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	HAS_XOIP(0.00)[];
	R_DKIM_NA(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 548D8409FE
X-Spamd-Bar: ++
X-MailFrom: g.osokin@auroraos.dev
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: EYVHZV25YZSH2OIMSVMREOKP5SC6RU6X
X-Message-ID-Hash: EYVHZV25YZSH2OIMSVMREOKP5SC6RU6X
X-Mailman-Approved-At: Thu, 09 Apr 2026 09:10:42 +0000
CC: sumit.garg@kernel.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, s.shtylyov@auroraos.dev, Georgiy Osokin <g.osokin@auroraos.dev>, stable@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EYVHZV25YZSH2OIMSVMREOKP5SC6RU6X/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Georgiy Osokin via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Georgiy Osokin <g.osokin@auroraos.dev>

register_shm_helper() allocates shm before calling
iov_iter_npages(). If iov_iter_npages() returns 0, the function
jumps to err_ctx_put and leaks shm.

This can be triggered by TEE_IOC_SHM_REGISTER with
struct tee_ioctl_shm_register_data where length is 0.

Jump to err_free_shm instead.

Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer registration")
Cc: stable@vger.kernel.org
Cc: lvc-project@linuxtesting.org
Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
---
 drivers/tee/tee_shm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index e9ea9f80cfd9..6742b3579c86 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -435,7 +435,7 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
 	num_pages = iov_iter_npages(iter, INT_MAX);
 	if (!num_pages) {
 		ret = ERR_PTR(-ENOMEM);
-		goto err_ctx_put;
+		goto err_free_shm;
 	}
 
 	shm->pages = kzalloc_objs(*shm->pages, num_pages);
-- 
2.50.1

