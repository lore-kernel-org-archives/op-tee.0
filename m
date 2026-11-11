Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0FC606A880
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=KTRBzOP1;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QnljE0e5
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3053045045
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 11:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794395436;
	bh=9+3k1q5NpRgKpnw7SRh4MpSjhHhzU5Zd8ihxq1g1MUs=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=KTRBzOP1FjgT1169keZF7dv4R5ZwWRz+uDLjXGSJ1ysTyqDtDJ/1waL7JfaAJ2TTi
	 c24Cc+uHe224FiTqzZcWrz220jarH+trczXPF/ypsUAHA6mG431zmJZoZW1EV3CAeW
	 cmZm/bQ2J/ZS7RNHY/9YAYDzTKAfyRjWIUv9KJD5w0o7fRQoF49iXsTZUFtFCZA9IS
	 AV+UxlY/dte3XXHYUBZirojtmWx5fEGEbzoXm+M60PDOoZxDfUi2uBxEG4Kci+7HqR
	 OnBWyFSMvw774RaZjmzhnwcHmxreh5W933HTRzA0YCBHpf/iz+sqJ3X+n7N1h3TTPu
	 b9ws5Lh2ZWhgQ==
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 65531454F6
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 11:08:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QnljE0e5;
	dkim-atps=neutral
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4903fc8537aso2075615f8f.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 03:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794395307; x=1795000107; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VViZS2bb3pZ4FEd6v4FhPEGdFU0OwPB+qGWSqpoqEsA=;
        b=QnljE0e5OxfOiDxPD+xZpdX1/KPZQ6sGhBdOw/pBCgUJGL+faQEiS/gXkh5JIIevfR
         OHrj+A9CBwO/sGAuusM7OUa0HV1GlKdO/IWfqR+lhoz5kGSmVAKg1Sx7W1TnQNmT5Q2O
         /SJarmV2QC95PzMq4PFdGodEOGBew35ibcW0f0Xrjm4GftaAUuVZA1QJYP1zF5G5xVng
         UdWSdABFcLHZw4JGzTvdfRWi7DKVTb9jthxbIgt7wpSCWDEuD+DFUuP/o/8rwiBFbYTc
         LpGluaHWQZsyoqKboeOkj+UA0L0Tei8GrKqJOkOzPM6u9ZnPhgWS2jMX4eqzthZSSyw5
         accQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395307; x=1795000107;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VViZS2bb3pZ4FEd6v4FhPEGdFU0OwPB+qGWSqpoqEsA=;
        b=mClA7lfyIer0jgqTtN9BMH8GeNYey7h+/mkjXJyg9agjLEFhxac/uoSmAt73vjqanH
         1dy/Y5q79c4nOTa7z/x6/56LPgHX/PY1EmlSwgjacI422w4ZG+B9BWVoUFJXNzDqnvmx
         pn7Yyxq4JC6BI/lU19u//pMzs1hHo8q7lEsd3IjbN/EPCj24jQP/Np3eK/CY73t8jE0r
         Jsaxp0KgCJ9AczKsVbL/x9AzRocu+Zgrfdq8uUQaWpOriyujtwK0Qi/hbZ6RyjorGtkQ
         IBrX+Vtikv+MbtpotPRumBDXuhNXCKdygghzGLq5AbIUsMfr8+souVoYV0P52zgF/Hsw
         Cc5g==
X-Forwarded-Encrypted: i=1; AL+hErEpPoFSyTvAnaeXJK5H7GO5wt1iAKa7g48/5pdvPMtj5knGqUGEzwlrpDGazKS7C4fdclsEp90=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z+jFg8sm/wr1MLeh1EUTot1hDYRN1jdnx+qlCUSz7O6jMWUMHJ2
	MaWHNCPa6uO7yTJ4iQAZ1yDys7k7s3KGtbov8vVHe8JH0JuUGHbH0cdCv/54OnIWuvu+OwaqUa4
	TlBgY4THsV6fLolxw9+NeGQ==
X-Received: from wmgb22.prod.google.com ([2002:a05:600c:1516:b0:4b8:b187:f0cd])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b83:b0:4a1:f377:5c6c with SMTP id 5b1f17b1804b1-4ba0935dbfcmr39556605e9.10.1794395307014;
 Wed, 11 Nov 2026 03:08:27 -0800 (PST)
Date: Wed, 11 Nov 2026 11:07:34 +0000
In-Reply-To: <20261111110738.872947-1-vdonnefort@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111110738.872947-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111110738.872947-5-vdonnefort@google.com>
Subject: [PATCH v3 4/8] dt-bindings: reserved-memory: Add lendable-dma-pool
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, m.szyprowski@samsung.com, jenswi@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.30 / 15.00];
	BAYES_HAM(-2.60)[98.23%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[vdonnefort@google.com,3q0z0agokbnqnvgffwxgjlyggydw.ugegh-lwwdaklk.ljmklwvxajeosjw.gjy@flex--vdonnefort.bounces.google.com];
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
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3q0z0agokbnqnvgffwxgjlyggydw.ugegh-lwwdaklk.ljmklwvxajeosjw.gjy@flex--vdonnefort.bounces.google.com];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.72:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.72:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 65531454F6
X-Spamd-Bar: /
Message-ID-Hash: ARBQ37BPEFNC7MSSBSW2OQKOIGZ3YMGJ
X-Message-ID-Hash: ARBQ37BPEFNC7MSSBSW2OQKOIGZ3YMGJ
X-MailFrom: 3q0z0agoKBnQnVgffWXgjlYggYdW.Ugegh-lWWdaklk.ljmklWVXajeoSjW.gjY@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ARBQ37BPEFNC7MSSBSW2OQKOIGZ3YMGJ/>
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

Add bindings for the "lendable-dma-pool" reserved-memory CMA pool, used
to dynamically unmap pages from the kernel direct map before lending
them to a secure world.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 .../reserved-memory/lendable-dma-pool.yaml    | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/lendable-dma-pool.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/lendable-dma-pool.yaml b/Documentation/devicetree/bindings/reserved-memory/lendable-dma-pool.yaml
new file mode 100644
index 000000000000..0b924d941b4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/lendable-dma-pool.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/lendable-dma-pool.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: /reserved-memory Lendable DMA Pool
+
+maintainers:
+  - Vincent Donnefort <vdonnefort@google.com>
+
+description: |
+  This indicates a region of memory meant to be used as a pool of DMA buffers
+  that can be dynamically unmapped from the kernel direct map (e.g. before
+  lending to a secure world such as via Arm FF-A).
+
+  On architectures where the direct map cannot be arbitrarily modified at
+  runtime (such as arm64 without BBML3 or without rodata=full), the operating
+  system ensures this pool is mapped using last-level (PTE) page table entries.
+
+  The reusable property must be set, and no-map must not be set.
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    const: lendable-dma-pool
+
+  linux,cma-default:
+    type: boolean
+    description: >
+      If this property is present, then Linux will use the region for
+      the default pool of the contiguous memory allocator.
+
+  no-map: false
+
+required:
+  - compatible
+  - reusable
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        linux,cma {
+            compatible = "lendable-dma-pool";
+            reusable;
+            size = <0x4000000>;
+            alignment = <0x200000>;
+            linux,cma-default;
+        };
+    };
-- 
2.56.0.542.g3ef89b7020-goog

