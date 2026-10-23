Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB10606A31B
	for <op-tee@archiver.kernel.org>; Mon, 26 Oct 2026 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=odhccu7l
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 07CD245341
	for <op-tee@archiver.kernel.org>; Mon, 26 Oct 2026 06:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792997593;
	bh=2dj1FpAKg3oHdNOfHelQzo0SgRrQjUC5Fw93qbToHFw=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=odhccu7lOEXdbIB5eFTiz2ZXLeqMVrCexG6SsUv9nqDvwsPojS5sXqVIdhkebYjw6
	 GuZ+mCdj8Xpop20eBVLOmN/LTS32kKoQM1vN8KqXSyqiWtcqDwfVzBrPBhU3D7zDTl
	 q9tIiDOYHXeRspLHcjXQPpvObkXa813jTLwfyzvA7raEJdGq/gI0waNGosaQqH+nbu
	 kH6zRC0kimcPdXqcOKP3jrgWtm9tRHnBIQbze3IXo/ZShAZQPpEpzMc72dOE/I8Aku
	 bqrAybC99xujJzqqPTg90SBho9ZIf9UoB1XTA3HiipDjfvWYwNbPhzt/yY9hSoYhH4
	 t6pHZfVghVmSw==
Received: from mail.auroraos.dev (unknown [95.181.193.9])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 712D34503D
	for <op-tee@lists.trustedfirmware.org>; Fri, 23 Oct 2026 21:02:59 +0000 (UTC)
Received: from pc.tailf8c421.ts.net (77.37.240.142) by
 exch16.corp.auroraos.dev (10.189.209.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Sat, 24 Oct 2026 00:02:55 +0300
To: Jens Wiklander <jenswi@kernel.org>
Subject: [PATCH] tee: shm: don't warn on an oversized page array in register_shm_helper()
Date: Sat, 24 Oct 2026 00:02:38 +0300
Message-ID: <20261023210238.551855-1-g.osokin@auroraos.dev>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[auroraos.dev,quarantine];
	R_SPF_ALLOW(-0.20)[+mx];
	MIME_GOOD(-0.10)[text/plain];
	ONCE_RECEIVED(0.10)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:49063, ipnet:95.181.193.0/24, country:RU];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DIRECT_TO_MX(0.00)[git-send-email 2.54.0];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[95.181.193.9:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.941];
	HAS_XOIP(0.00)[];
	R_DKIM_NA(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 712D34503D
X-Spamd-Bar: ++
X-MailFrom: g.osokin@auroraos.dev
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: I5GR7BWMQCTWA72NZHRLIALPOTSLXGPR
X-Message-ID-Hash: I5GR7BWMQCTWA72NZHRLIALPOTSLXGPR
X-Mailman-Approved-At: Mon, 26 Oct 2026 06:52:55 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Georgiy Osokin <g.osokin@auroraos.dev>, stable@vger.kernel.org, lvc-project@linuxtesting.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/I5GR7BWMQCTWA72NZHRLIALPOTSLXGPR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Georgiy Osokin via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Georgiy Osokin <g.osokin@auroraos.dev>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

register_shm_helper() sizes shm->pages from the length passed to
TEE_IOC_SHM_REGISTER and allocates it with kzalloc_objs(). A length above
2 GiB makes the array larger than the page allocator can serve in one
block (MAX_PAGE_ORDER), so it trips its order warning; on a panic_on_warn
kernel that is a panic.

The size comes from userspace and the request fails with -ENOMEM anyway,
so pass __GFP_NOWARN. kvzalloc_objs() would not help since kvmalloc
warns above INT_MAX as well.

Fixes: 033ddf12bcf5 ("tee: add register user memory")
Cc: stable@vger.kernel.org
Cc: lvc-project@linuxtesting.org
Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
---
 drivers/tee/tee_shm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 6742b35..d539988 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -438,7 +438,8 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
 		goto err_free_shm;
 	}
 
-	shm->pages = kzalloc_objs(*shm->pages, num_pages);
+	shm->pages = kzalloc_objs(*shm->pages, num_pages,
+				  GFP_KERNEL | __GFP_NOWARN);
 	if (!shm->pages) {
 		ret = ERR_PTR(-ENOMEM);
 		goto err_free_shm;

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.54.0

