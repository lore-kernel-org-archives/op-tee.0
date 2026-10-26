Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D2B606A31A
	for <op-tee@archiver.kernel.org>; Mon, 26 Oct 2026 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=WLzT4jDE
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A97284529C
	for <op-tee@archiver.kernel.org>; Mon, 26 Oct 2026 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793030892;
	bh=eNaci7riotKqnfi9JLbi/loMc2ju0jgjFGkiV4/woKg=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=WLzT4jDEqNE5KUGv+xcxoaYlsKKhKjTfsYRBF8FGzTWJKk8otY6fpPQx6pI/OiXX8
	 BZEPwSJ4oDB1aYY5fsljjAmCYA/cUKOeONoJAUUO/WFxfyxzhsN0hBgmXWO2ol9V77
	 Ms+QwmJDxOqorK6/4gjLBFW46zuAR2cgy50KKU0yAumKWhR5OtdvP9Kt9f5tALxd3k
	 C3b/9B2+fenKIhITY62s0/9/ztWa3ufQ2K9HlweRrbC1xnfxMRnnHxkgzYLDvcZuBy
	 yL17bDLxNTrJYAH6AynhGL5oNolL58nn3UlqnfYniAjUDs8Xsvk8+qjGZtkO4Ob1cy
	 bx4Sx5NTxR7Rg==
Received: from mail.auroraos.dev (unknown [95.181.193.9])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A277744848
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 Oct 2026 15:04:13 +0000 (UTC)
Received: from pc.tailf8c421.ts.net (77.37.240.142) by
 exch16.corp.auroraos.dev (10.189.209.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 26 Oct 2026 18:04:10 +0300
To: Jens Wiklander <jenswi@kernel.org>
Subject: [PATCH v2] tee: shm: don't warn on oversized request in tee_dyn_shm_alloc_helper()
Date: Mon, 26 Oct 2026 18:03:45 +0300
Message-ID: <20261026150345.284404-1-g.osokin@auroraos.dev>
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
	DNSWL_BLOCKED(0.00)[77.37.240.142:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	HAS_XOIP(0.00)[];
	R_DKIM_NA(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A277744848
X-Spamd-Bar: ++
X-MailFrom: g.osokin@auroraos.dev
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 6FAXVI2VE4EJVAZZ2K2LYKH6KOUVVR2G
X-Message-ID-Hash: 6FAXVI2VE4EJVAZZ2K2LYKH6KOUVVR2G
X-Mailman-Approved-At: Mon, 26 Oct 2026 16:07:55 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Georgiy Osokin <g.osokin@auroraos.dev>, stable@vger.kernel.org, lvc-project@linuxtesting.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6FAXVI2VE4EJVAZZ2K2LYKH6KOUVVR2G/>
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

tee_dyn_shm_alloc_helper() passes the size from TEE_IOC_SHM_ALLOC to
alloc_pages_exact(), which needs one physically contiguous block. A size
above 4 MiB (MAX_PAGE_ORDER with 4 KiB pages) is more than the page
allocator can serve, so it trips its order warning; on a panic_on_warn
kernel that is a panic.

The size comes from userspace and the request fails with -ENOMEM anyway,
so pass __GFP_NOWARN.

Fixes: abd135ba215c ("tee: optee: add optee-specific shared pool implementation")
Cc: stable@vger.kernel.org
Cc: lvc-project@linuxtesting.org
Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
---
v2: Fixes now points to abd135ba215c, the commit that introduced the
    unchecked allocation; cf4441503e20 only moved the code.
v1: https://lore.kernel.org/all/20261026105209.161195-1-g.osokin@auroraos.dev/

 drivers/tee/tee_shm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index daa4af1..8b117d6 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -352,7 +352,7 @@ int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
 	 * and there's no need for any larger alignment.
 	 */
 	shm->kaddr = alloc_pages_exact(nr_pages * PAGE_SIZE,
-				       GFP_KERNEL | __GFP_ZERO);
+				       GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN);
 	if (!shm->kaddr)
 		return -ENOMEM;

-- 
2.54.0

