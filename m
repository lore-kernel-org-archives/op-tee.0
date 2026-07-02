Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAACC55822
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:17:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EDE4B452F5
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:17:01 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=permerror header.d=gmail.com header.i=@gmail.com header.a=rsa-sha1 header.s=20251104 header.b=ZkkwQem0;
	dkim-atps=neutral
Received: from mail-oo2-f1.google.com (mail-oo2-f1.google.com [74.125.231.129])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2913944DE0
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Jul 2026 15:12:11 +0000 (UTC)
Received: by mail-oo2-f1.google.com with SMTP id 006d021491bc7-6a150e793cfso411671eaf.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Jul 2026 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783005130; x=1783609930; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EUdfn0E+HkL5zwEpZVP9/C/NdRDvTd2wtK5Vkg7/59k=;
        b=ZkkwQem0Ic4O6IRSXIzOTMsSS1cd/UubDxde7Ki/J82Ff0fXbmg9UhoyYxm7mg4NhQ
         4MUwiEz6X5Wn0jRz3ZMczGmbPHXiA4g7+WtTRdVTIolnPcjh9BfNOB3xTwhvtpsVv4XT
         uHInHiUsWd7afXZYDv3k+g3yzQKyn6jQuLl9Imo87HC3p2FgV5Ij3ph+zfO5ZngksQ20
         7nQs3pzvJwch3RBaWsJ7z/Qm1Pw+YWxDUoGO2EHI+3sFM3KNoEQxE2xZF+wjb2MBnPG5
         wWOuL7txJp0lSPAhRkUuzDJreBraKw6HaFrxHO86PiyzAG5P7dfl5Bvla0DXnoqcHzPt
         +F0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783005130; x=1783609930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EUdfn0E+HkL5zwEpZVP9/C/NdRDvTd2wtK5Vkg7/59k=;
        b=kp/j5HsnZ5vz64dtefZraHynxTCVcev/hqutDRLrRw280TxAeW60TNp7Yn8i6O7Hzb
         /0sjn14cifXov5DVlVH4YNhRJrAFB8sb6tsBhdK8+at2zFE9aRQ2ZZIXgg+Jd6wNAxun
         yM6hhT4vSyfUWJXTqSYZbO0WMy5YSDpdyoHFYd/kATdtHTSydrgLhmg55Fu2Uv9rx7FR
         fuY4A86QLB7BbGEYl6qgjH1qvqvayAqFQiYQya4BsjmdPkcH/0QIFe3ubpeVQBdGBu6Z
         rEXg/LdBnx2iHL/od1Sd84Eczm2yKS/NULaYkvy+o7JlHx1hOtC4xeF6fxek6X+U0qL0
         PcZg==
X-Forwarded-Encrypted: i=1; AFNElJ9929Qac6NPX/x6ezxqOXOnmcnAGDHbdQBPH92lDyCjw87/8TO9HtzikvocaynFuGFSKE86EOI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzxvLgJcM0vWif5+0BSVIxP2VzeZSZ8nmtxKdYX2j4D0ciRfMW4
	5MIUBTolXRHlUne7A53zFsP/DCfcpWrw1viKa4cuIH96U/Aaxie4r0tU
X-Gm-Gg: AfdE7ckBwqgM2WSvN5tbmt8b4HD6d5S4RFCqq3Vp+LFVYKK0UpbBUfOSDbohQcpv5tg
	0WzkIZ+Hp0QAPa3esVlGXa617n6PYKw+Ong/2uN31imdO/vk0yvD4yXfCDHei7MTa8txDvcGMR1
	6s61SkA2/MEorWaG+e908XLWeupWVbm0W7Nr+SHPV28kCULWqkleNmBdG3ZPrxY9LgQwRF9JwXc
	jtB7eCjOY7E9DEY45AzBpp6GtXIhHnfJ4hRQVebQlXJxLkV7hFQTejSNBjphcENbvNoDbmSdn4S
	5sVd9zsTw9w6HtQlQ15bpBqaYP3WHFVFEGW9wxmdBKOYlP9QIBzwKCdfd2Qpc00PBl/dSoJXbSj
	ZGhkcOCHOq/j3+wO6Xa3uXMyxFlH+R3X+YQVYvTvl2/u2f6jS3Q3WqqRNM3CsESjfFqVlzWu/UQ
	XlqWtK3a9+j/HmyHDe71l7XFp0VLb9D9VFpoyBaMU183ozC02/VNAAEMg=
X-Received: by 2002:a05:6820:2903:b0:69e:98c0:a9c with SMTP id 006d021491bc7-6a30d747a2cmr3407719eaf.11.1783005130487;
        Thu, 02 Jul 2026 08:12:10 -0700 (PDT)
Received: from ubuntu24.. (dsl092-249-254.sfo4.dsl.speakeasy.net. [66.92.249.254])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbec9a113sm3094561fac.9.2026.07.02.08.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 08:12:10 -0700 (PDT)
From: Xing Loong <xing.xl.loong@gmail.com>
To: Jens Wiklander <jenswi@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: firmware: add mbedtee,tee binding
Date: Thu,  2 Jul 2026 23:11:14 +0800
Message-ID: <20260702151115.544016-3-xing.xl.loong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702151115.544016-1-xing.xl.loong@gmail.com>
References: <20260701132514.186953-1-xing.xl.loong@gmail.com>
 <20260702151115.544016-1-xing.xl.loong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:74.125.0.0/16:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[kernel.org,lists.trustedfirmware.org,vger.kernel.org,lists.infradead.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:74.125.0.0/16, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.231.129:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.231.129:from];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_BLOCKED(0.00)[gmail.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2913944DE0
X-Spamd-Bar: -
X-MailFrom: xing.xl.loong@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 4OKAHJ2Z5EO5Q6QT7CILT5N6TSWY2CFN
X-Message-ID-Hash: 4OKAHJ2Z5EO5Q6QT7CILT5N6TSWY2CFN
X-Mailman-Approved-At: Wed, 05 Aug 2026 09:13:17 +0000
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Xing Loong <xing.xl.loong@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4OKAHJ2Z5EO5Q6QT7CILT5N6TSWY2CFN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

MbedTEE is a Trusted Execution Environment for embedded
systems (https://github.com/mbedtee). It communicates with
the REE via shared-memory ring buffers using a fixed RPC
protocol. Two platform configurations are supported:

  - ARM/AArch64 (TrustZone, SMC): two reserved-memory
    regions (t2r-ring and t2r-shm) plus a GIC SPI edge
    interrupt for TEE-to-REE notifications.
  - RISC-V (IMSIC): three reserved-memory regions, adding
    r2t-ring for REE-to-TEE command submissions; no
    interrupts property (T2R notifications use IMSIC MSI
    allocated at runtime).

Signed-off-by: Xing Loong <xing.xl.loong@gmail.com>
---
Changes in v2:
- Fix DT binding review comments from Krzysztof Kozlowski:
  - Drop $nodename, "YAML devicetree binding" wording, property descriptions
  - Rename compatible string to mbedtee,tee
  - Rename memory regions: rpc-t2r-ring -> t2r-ring, rpc-t2r-shm -> t2r-shm,
    rpc-r2t-ring -> r2t-ring
  - Add memory-region / memory-region-names to required
  - Simplify allOf constraints (drop redundant else-branch items)
  - Rewrite description to describe hardware/firmware, not the binding or driver
  - Drop all irrelevant platform nodes (gic, cpus, reserved-memory
    containers, reg addresses, riscv wrapper); the ARM example now
    uses bare interrupts (matching arm,sbsa-gwdt.yaml precedent)
    with only phandle-required stubs (imsic, t2r-ring, r2t-ring)
  - Add maxItems: 1 constraint to interrupts property (Sashiko AI review)

---

 .../bindings/firmware/mbedtee,tee.yaml        | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/mbedtee,tee.yaml

diff --git a/Documentation/devicetree/bindings/firmware/mbedtee,tee.yaml b/Documentation/devicetree/bindings/firmware/mbedtee,tee.yaml
new file mode 100644
index 0000000..62f2522
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/mbedtee,tee.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/mbedtee,tee.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MbedTEE Trusted Execution Environment
+
+maintainers:
+  - Xing Loong <xing.xl.loong@gmail.com>
+
+description: |
+  MbedTEE is a Trusted Execution Environment for embedded systems.
+  It communicates with the REE (Linux) via shared-memory ring
+  buffers using a fixed RPC protocol.
+
+  The REE and TEE CPUs sharing the RPC memory must be in a
+  hardware-coherent domain (same CPU cluster, coherent caches).
+
+  Two or three reserved-memory regions are required:
+
+    t2r-ring  ring buffer for TEE-to-REE notifications (all platforms)
+    t2r-shm   shared memory for TEE-to-REE RPC payloads (all platforms)
+    r2t-ring  ring buffer for REE-to-TEE command submissions (RISC-V only)
+
+  On ARM/AArch64 the TEE is invoked via SMC and signals the REE via
+  a GIC SPI edge interrupt.
+
+  On RISC-V the TEE signals the REE via IMSIC MSI; the REE submits
+  commands via r2t-ring that the TEE polls. No REE-to-TEE interrupt
+  is used. No SBI ecall is involved.
+
+properties:
+  compatible:
+    const: mbedtee,tee
+
+  interrupts:
+    maxItems: 1
+
+  msi-parent:
+    maxItems: 1
+
+  memory-region:
+    minItems: 2
+    maxItems: 3
+    # Minimum across platforms (ARM: 2, RISC-V: 3), constrained by allOf below
+
+  memory-region-names:
+    minItems: 2
+    maxItems: 3
+    items:
+      enum:
+        - t2r-ring
+        - t2r-shm
+        - r2t-ring
+
+required:
+  - compatible
+  - memory-region
+  - memory-region-names
+
+allOf:
+  - if:
+      required:
+        - interrupts
+    then:
+      required:
+        - interrupts
+      properties:
+        msi-parent: false
+        memory-region:
+          maxItems: 2
+        memory-region-names:
+          items:
+            - const: t2r-ring
+            - const: t2r-shm
+    else:
+      required:
+        - msi-parent
+      properties:
+        memory-region:
+          minItems: 3
+        memory-region-names:
+          items:
+            - const: t2r-ring
+            - const: t2r-shm
+            - const: r2t-ring
+
+additionalProperties: false
+
+examples:
+  - |
+    /* ARM TrustZone (SMC) */
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    firmware {
+      mbedtee {
+        compatible = "mbedtee,tee";
+        interrupts = <GIC_SPI 72 IRQ_TYPE_EDGE_RISING>;
+        memory-region = <&mbedtee_t2r_ring>, <&mbedtee_t2r_shm>;
+        memory-region-names = "t2r-ring", "t2r-shm";
+      };
+    };
+
+    /* memory-region phandle targets */
+    mbedtee_t2r_ring: t2r-ring {};
+    mbedtee_t2r_shm: t2r-shm {};
+
+  - |
+    /* RISC-V IMSIC (ring-buffer polling REE->TEE, MSI TEE->REE) */
+
+    firmware {
+      mbedtee {
+        compatible = "mbedtee,tee";
+        msi-parent = <&imsic>;
+        memory-region = <&rv_t2r_ring>, <&rv_t2r_shm>,
+                        <&rv_r2t_ring>;
+        memory-region-names = "t2r-ring", "t2r-shm",
+                              "r2t-ring";
+      };
+    };
+
+    /* msi-parent phandle target */
+    imsic: imsic {
+      msi-controller;
+      #msi-cells = <0>;
+    };
+
+    /* memory-region phandle targets */
+    rv_t2r_ring: t2r-ring {};
+    rv_t2r_shm: t2r-shm {};
+    rv_r2t_ring: r2t-ring {};
-- 
2.43.0

