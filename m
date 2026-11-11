Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656C6606A327
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=o5yafh6h;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l4yt5Nta
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C7D39454C0
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 11:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794395408;
	bh=2DODH/cA5HlX61GYK4lGFk54/xdfvIEtnnDbno1Ao90=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=o5yafh6hhUXLMj7UkvT9A/2+P+e15vW0obFyo4RfZO1KhxYjo7+bV30DbQj2EjpQ4
	 dCYs1HhAF4By3DwyziY+/IO7Yfa/2JpIZYIqySC9BOGi7O33b7HIkw3uHnMkToEo5D
	 YDlsnQ13ceZR/K+cBrT8K0fHaDLRTYOx/S7T0vp8KxlWvUqmzLChgCjH14RQa0Jqx/
	 RUjHk4I3u6C46lcIGEMDDxOWPf+aEXIB5JkN1TgcPBHo0d4T20zJA4UE2my7FFDMpS
	 TNS1y+BCGHC8k3OnsrVdxgnCnc/VUzyU9ylvdL34e16qVAkqBrhQB38Cyh104NP7nv
	 5xnylfs/Qw3Jg==
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 77D4F454D9
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 11:08:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l4yt5Nta;
	dkim-atps=neutral
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-492425d771bso1942115f8f.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 03:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794395306; x=1795000106; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t9e5fiKyui+gLN6NGnueZPdNy7gU/9XjTaWNkCYpwsg=;
        b=l4yt5NtajdiYJiBta+KLY4ARyYbHeFVDrYqiuUn2dmf4ukdC48MO/LDJyqafPRVUpL
         WXWmj4CixROCGVNkRBo9F+57dcCKcdTRr8+le5hamkVV7P3YnGj5xP+u7BpWZ+ODBWfL
         WNVTqNduq/8fW8TxuoETx25tKpVTugNPTp2+4gbYpzqdKXUFPXaV0Nb52GWl2TnI1XM/
         by8las5ZkIqKcdIow2KuKysxrBM3aBMsB2k/XRySiLpPse4MTUTbRh0qJo6KtEyj/N25
         Q5agM2K17MOP5AYPScL7V53IEG+QEFxt4aG6iYYcA0/ceDFVsYhPKxSLhH11mUZu4Mve
         /cMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395306; x=1795000106;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t9e5fiKyui+gLN6NGnueZPdNy7gU/9XjTaWNkCYpwsg=;
        b=cPELqf5prconlCi4Kqw8mTerxQdxIgH22LbiBZ5wbJyzfDDkL5CRAy9Z1L+ufa4+Up
         kkzPavxuWO0OWlvJrG2G8xW/bbcD2GZWTYXENoJo/Ps1F/Xgm2v4dOpdhoWcldVI7hds
         R9foaRqA/fGpyf2v2UmJxcJ1q4Pme+oe8QasdGvZuW2qdjeXXrNrn5uULM7PRthzJLbF
         H2xy/6xTZHIgYVrxqLTbwuasN6d4Jw7AjzDvBDY+FMThHoTf1rxRUZ7chA/qkhmKkxwJ
         Ey+sfXi0QkF9ojxxtlJMQzy0eH2jcbr4gdUzoKYdAg4v1OC+GuxaQThTHMmmaSgyIsub
         bciw==
X-Forwarded-Encrypted: i=1; AL+hErEDBJhDU/apodCtuCGx07Jd5BUIFg/7p4Ilq7w2UbKpHxS8ojXUn0QkPAQMLVUavRmlYWFynas=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z/pSjw6JxjJ3gJmfc0c1KEh0nJRuq3aMNjG/2+EUyFNcEgvvedb
	2D5BYb+bQiyvw+hFyYRC6tGgJxFigp+e1tXpq0joWxLeVMbzMC16OjpOU8P+a9Zpj8iPROKasyu
	v7tCWDWYOejHusY0tX8taCg==
X-Received: from wrsb1.prod.google.com ([2002:a5d:45c1:0:b0:48c:753a:6283])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e194:0:b0:491:6a7:b4ac with SMTP id ffacd0b85a97d-499c7b1aea4mr3063798f8f.56.1794395305902;
 Wed, 11 Nov 2026 03:08:25 -0800 (PST)
Date: Wed, 11 Nov 2026 11:07:33 +0000
In-Reply-To: <20261111110738.872947-1-vdonnefort@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111110738.872947-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111110738.872947-4-vdonnefort@google.com>
Subject: [PATCH v3 3/8] dma-contiguous: Expose rmem_cma_ops
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, m.szyprowski@samsung.com, jenswi@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[vdonnefort@google.com,3quz0agokbniltedduvehjweewbu.secef-juubyiji.jhkijutvyhcmqhu.ehw@flex--vdonnefort.bounces.google.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20260707];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3quz0agokbniltedduvehjweewbu.secef-juubyiji.jhkijutvyhcmqhu.ehw@flex--vdonnefort.bounces.google.com];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.71:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.71:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 77D4F454D9
X-Spamd-Bar: /
Message-ID-Hash: LJIABFFE4FL7XGLE2FDC2X7B6F3GGXOS
X-Message-ID-Hash: LJIABFFE4FL7XGLE2FDC2X7B6F3GGXOS
X-MailFrom: 3qUz0agoKBnIlTeddUVehjWeeWbU.Secef-jUUbYiji.jhkijUTVYhcmQhU.ehW@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LJIABFFE4FL7XGLE2FDC2X7B6F3GGXOS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expose rmem_cma_ops via a kernel/dma-private header so the upcoming
lendable-dma-pool reserved-memory handler can wrap the CMA callbacks
instead of duplicating them.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/dma/contiguous.c |  4 +++-
 kernel/dma/contiguous.h | 10 ++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 kernel/dma/contiguous.h

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 90937dc7c627..22d6e54aea35 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -46,6 +46,8 @@
 #include <linux/cma.h>
 #include <linux/nospec.h>
 
+#include "contiguous.h"
+
 #ifdef CONFIG_CMA_SIZE_MBYTES
 #define CMA_SIZE_MBYTES CONFIG_CMA_SIZE_MBYTES
 #else
@@ -578,7 +580,7 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 	return 0;
 }
 
-static const struct reserved_mem_ops rmem_cma_ops = {
+const struct reserved_mem_ops rmem_cma_ops = {
 	.node_validate  = rmem_cma_validate,
 	.node_fixup	= rmem_cma_fixup,
 	.node_init	= rmem_cma_setup,
diff --git a/kernel/dma/contiguous.h b/kernel/dma/contiguous.h
new file mode 100644
index 000000000000..9b1fdbfc794f
--- /dev/null
+++ b/kernel/dma/contiguous.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _KERNEL_DMA_CONTIGUOUS_H
+#define _KERNEL_DMA_CONTIGUOUS_H
+
+#ifdef CONFIG_OF_RESERVED_MEM
+struct reserved_mem_ops;
+extern const struct reserved_mem_ops rmem_cma_ops;
+#endif
+
+#endif /* _KERNEL_DMA_CONTIGUOUS_H */
-- 
2.56.0.542.g3ef89b7020-goog

