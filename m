Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB79CA5FA5
	for <op-tee@archiver.kernel.org>; Mon, 28 Sep 2026 14:41:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4556C454CD
	for <op-tee@archiver.kernel.org>; Mon, 28 Sep 2026 14:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790606488;
	bh=G5nhJFHOphxhLy5VEu+x6x3ZtsxPZ4gB+naoUcQxVH4=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=X9VwqimAv161HdBGhtKEMVyHg27C0gWnPXrGLJNM+a9PY1ZyJAvD6YvMb7WBfUwO+
	 u3gXfaULA0PT27TxIt9rZgUE4o2p8YVovg34HV/vl5CML/9kluU2Sc0hVn+f8Lhkn9
	 jZC0tFJcovl159J27/yL++QEqEofPkbz+yKqC44d0s56/S2+P95dAj1Qw94TdgTLS1
	 hpHlx6QZXjoewrb47RlW+/txlyxaRAV22R7r5KFvYj/JUkwjl6EMt0gOKxy0IbImzB
	 AYYCsonVtBHPYddLJpqty8idIZlSkt0uxkQa0qNSMe+KWEPI/UhgsJR8wicjpWkAm3
	 bYmEMJgg32NnA==
Received: from mail.auroraos.dev (unknown [95.181.193.9])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6E06443EF5
	for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 14:31:38 +0000 (UTC)
Received: from pc.omp.ru (77.37.240.142) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 28 Sep
 2026 17:31:36 +0300
To: Jens Wiklander <jenswi@kernel.org>
Subject: [PATCH] tee: shm: reject zero-sized allocations in tee_dyn_shm_alloc_helper()
Date: Mon, 28 Sep 2026 17:31:13 +0300
Message-ID: <20260928143113.1700001-1-g.osokin@auroraos.dev>
X-Mailer: git-send-email 2.54.0
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
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:49063, ipnet:95.181.193.0/24, country:RU];
	TO_DN_SOME(0.00)[];
	DIRECT_TO_MX(0.00)[git-send-email 2.54.0];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_XOIP(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.813];
	FROM_EQ_ENVFROM(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6E06443EF5
X-Spamd-Bar: ++
X-MailFrom: g.osokin@auroraos.dev
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 7JKLPAAYDMMZTHR3ISKAEXQIMOOPJC5M
X-Message-ID-Hash: 7JKLPAAYDMMZTHR3ISKAEXQIMOOPJC5M
X-Mailman-Approved-At: Mon, 28 Sep 2026 14:41:21 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, lvc-project@linuxtesting.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7JKLPAAYDMMZTHR3ISKAEXQIMOOPJC5M/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Georgiy Osokin via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Georgiy Osokin <g.osokin@auroraos.dev>

tee_dyn_shm_alloc_helper() derives nr_pages from a caller-supplied size
and passes it to alloc_pages_exact() without checking it. For size == 0
nr_pages is 0, and alloc_pages_exact(0) calls get_order(0), which is
documented as undefined and returns BITS_PER_LONG - PAGE_SHIFT. The page
allocator then trips its order > MAX_PAGE_ORDER warning and fails the
allocation; on a panic_on_warn kernel that ends the boot.

This can be triggered by TEE_IOC_SHM_ALLOC with struct
tee_ioctl_shm_alloc_data where size is 0.

Reject a zero page count, as register_shm_helper() already does for the
register path.

Fixes: cf4441503e20 ("tee: optee: Move pool_op helper functions")
Cc: stable@vger.kernel.org
Cc: lvc-project@linuxtesting.org
Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
---
 drivers/tee/tee_shm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 6742b3579..daa4af1e0 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -343,6 +343,10 @@ int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
 	unsigned int i;
 	int rc = 0;
 
+	/* get_order(0) is undefined and exceeds MAX_PAGE_ORDER. */
+	if (!nr_pages)
+		return -EINVAL;
+
 	/*
 	 * Ignore alignment since this is already going to be page aligned
 	 * and there's no need for any larger alignment.

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.54.0

