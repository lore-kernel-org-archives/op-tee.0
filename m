Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2046C982E1
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 11:04:32 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D882C44A2A
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789988672;
	bh=zFiwAFdoDDqcAb3ymJ/xbfdcP3hdNR8xkvVRX0o4gLc=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=X1NpJLtHXXQVqh8wmsibcClpbIz1PmpMqVD+GVjZ6aRX+JdG2UexFagIDmx6MFLXp
	 ZYmWwMICMns1rXEiusRlnjTr0ZVI6o/WkUDmfS6gsADeCj1Lzc/kCmWczSrkJkFd60
	 K02t7JCl+66+iAiKzWS0KbkCMiODk8mjpHykZAffltLMDVrCb/2VPCmXHKOwSOhKIO
	 mHqb0YKmQmvXJw5aGCJhuTd+VypKw1/5jIkDYMlrDz69tt3cKZZil5kwLvrQS9BUgt
	 kw+YSJ1fZbGpaDPyymqqQ+OIP7e8Fn7Mwotzd+ZZZjTmSMPESEfU8HXR6eUMwUX0u1
	 o2pWl9CK49maQ==
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9F8BF44F26
	for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 11:01:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=smfujBrS;
	dkim-atps=neutral
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so22026545e9.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 04:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789988464; x=1790593264; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dcGk9G8S000WArAMLwdOiTGHKXUA8vP6GMN4jNzx1Ic=;
        b=smfujBrS60PNPXBgEytRnHncjquJ+0aPj+IGXiQeLEDbhrrbnY8y6cScSOxr77Yluv
         AdatA+kTYkGHFwTm3wJEpW73VPQ60miFCS/8Zjvp8QSltXLZuvn3bLCquRGixGqvjUIX
         LdLtTI+Y53OKNUyGw3wTk6QpgvxBwhe9mDm5uTbvR2RtRmWSMLpEZuC/1GKsbxztDFRi
         3CABPDmgb2G8h6CuiEGLj6DaYLrB8uD6pDzay9QQJpBoKuK9h4OZHBEdKSYDnyeOJEHX
         aSaKSqjQlg8wxs2qxqHnLngo/Pa1Dj+QC49lRIgKCTyk9bTVilGTh+gekT8vxXTIzmMp
         TLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789988464; x=1790593264;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dcGk9G8S000WArAMLwdOiTGHKXUA8vP6GMN4jNzx1Ic=;
        b=RDeARgk3ZI48pofxCvGjdBusyCDjSqm33Gu7JmWYxjHwzlPOZW2fM/+IswIplWoqFR
         kLH9tXjvFRO+RQhZBseEI0nYI0VZ9UWw6p7R6v9qtpwv1UkROM75X4MffC0O6m4n3vH/
         Ymnm8KdvO4i+u2OgLINe2IH69fDUze3NKu2JbI09a6/EggUEDbYBYCgFhMkWMCyIrwuy
         2+CZxT0Sx/V25yavzI74e73bw2CZYYl7mcxTDnPKIQ44rDGAfyeaGiUXZHmlYjjtintC
         r8JKUuArXE1/3K33wEZYfyCSAxCmPeYq1xMFdDoiQ7onNb/zaNk1J90N9J7KU39gd7YD
         0uYg==
X-Forwarded-Encrypted: i=1; AKwUvByI6Sqo0hPTUr7j2HtkZV2miOIfAC/WLCMjuO9NFUXx7uy04HJrzdletglzibIZLEF5a/PdrZs=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mf/cywuORRh7rfsFXp9DgbFcoJlfnm9OUQf/cNV6graEuS5f32
	chnbNc8ds4vyVew9z8SUz+VvdPsjoV2dJTpHx05tqlJ3MNP/SkJHWa1/8m63zwrnPtdtwR4aNux
	wel2KX/zo020l8YXmfZkS/w==
X-Received: from wmph41.prod.google.com ([2002:a05:600c:49a9:b0:49e:78cc:d29])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b82:b0:49f:ce72:dfe7 with SMTP id 5b1f17b1804b1-49fce72e040mr109082755e9.35.1789988464458;
 Mon, 21 Sep 2026 04:01:04 -0700 (PDT)
Date: Mon, 21 Sep 2026 12:00:49 +0100
In-Reply-To: <20260921110050.3977591-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20260921110050.3977591-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921110050.3977591-8-vdonnefort@google.com>
Subject: [PATCH v2 7/8] dt-bindings: reserved-memory: Add Arm FF-A lend pool
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org,
	robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[99.98%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[vdonnefort@google.com,3ca6xagokbq0iqbaarsbegtbbtyr.pbzbc-grryvfgf.gehfgrqsvezjner.bet@flex--vdonnefort.bounces.google.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.69:from];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.128.69:from];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3ca6xagokbq0iqbaarsbegtbbtyr.pbzbc-grryvfgf.gehfgrqsvezjner.bet@flex--vdonnefort.bounces.google.com];
	RCVD_TLS_LAST(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9F8BF44F26
X-Spamd-Bar: --
Message-ID-Hash: GPLLCEC73CAIJVFCU7T7JTW3LOJV3DIL
X-Message-ID-Hash: GPLLCEC73CAIJVFCU7T7JTW3LOJV3DIL
X-MailFrom: 3cA6xagoKBq0iQbaaRSbegTbbTYR.PbZbc-gRRYVfgf.gehfgRQSVeZjNeR.beT@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GPLLCEC73CAIJVFCU7T7JTW3LOJV3DIL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

Add bindings for the "arm,ffa-lend-pool" reserved-memory CMA pool.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 .../reserved-memory/arm,ffa-lend-pool.yaml    | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/arm,ffa-lend-pool.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/arm,ffa-lend-pool.yaml b/Documentation/devicetree/bindings/reserved-memory/arm,ffa-lend-pool.yaml
new file mode 100644
index 000000000000..c02d36e1e418
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/arm,ffa-lend-pool.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/arm,ffa-lend-pool.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm FF-A Memory Lend Pool
+
+maintainers:
+  - Vincent Donnefort <vdonnefort@google.com>
+
+description: |
+  When memory is lent to the Secure world via FF-A, CPU speculative accesses
+  from Non-Secure to the lent pages can still occur as long as it retains a
+  cacheable mapping to it.
+
+  Ideally, lent memory would be "no-map", but that would mean giving up MiBs of
+  useful memory. Instead, "arm,ffa-lend-pool" defines a reserved-memory CMA pool
+  to manage unmapping pages prior to lending and restoring them when reclaimed.
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    const: arm,ffa-lend-pool
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
+    / {
+        compatible = "foo";
+        model = "foo";
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        reserved-memory {
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges;
+
+            ffa_lend: ffa-lend-pool {
+                compatible = "arm,ffa-lend-pool";
+                reusable;
+                size = <0x0 0x4000000>;
+            };
+        };
+    };
-- 
2.55.0.1082.g2b9226bbc0-goog

