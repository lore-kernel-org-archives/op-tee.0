Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635DAC55822
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:21:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B50C14534C
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:21:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=permerror header.d=gmail.com header.i=@gmail.com header.a=rsa-sha1 header.s=20251104 header.b=IUB0F+fe;
	dkim-atps=neutral
Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0F40E43EE4
	for <op-tee@lists.trustedfirmware.org>; Mon, 20 Jul 2026 07:36:47 +0000 (UTC)
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-ca24d39d8a4so6361170a12.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 20 Jul 2026 00:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784533006; x=1785137806; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bdaqGWHkjITQmhPR3c1nuJGM5fgMQJ2LTHjMaX1w49Y=;
        b=IUB0F+feBsNNBT/p8KcTU5nSwHHfaA6FDv0pCTcywBcKhRK63x1lI3B7w3Kr6nhzyt
         eWcDsRhKLVwWKmJjVLPsvXYEWrmAwPOsmMRFh9/N7qbNsQzpwP/O06m1HplJXXYl6pMv
         04M7PlZ1V3HsiOolZM/sogklTmg5ddqxvjJoXCnLBsLAscWLRmR+06AFNyePmFTzFDdc
         iCOXmdpTLy04kQvN9ImpZMCIUD1JdC75vDemfJwoEIS+OaXydYj8dhZmAHqzxrTGQYBD
         QJxLkglGP3lKB8+W/Jss1nSsCt7gLElOSCot0nKUxAkacH8enbawOJAvKFf7rUvnfY3o
         CzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784533006; x=1785137806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bdaqGWHkjITQmhPR3c1nuJGM5fgMQJ2LTHjMaX1w49Y=;
        b=AGT/PQV1cS7LVCut/LzMgfS6jTplQrEInVsXXYTiUik2/qJanpaRLUjOfNMIrsDFyu
         22oTwxRQoixtb0XmQ44evc8IW0Is7NNkRnfeY5aa1VvwSmkIgyCGHavEiMxmpv4Og+CX
         C0+x+Jnsxyk2f4y4okq4ddBmRubl8zwjmJdEaAOYjRMJnZyA5K0/+xQert7klCH8W3mo
         qSEboVYL8e35mvcxqy63Savxf1HSDvAZlig7jFdEmgU240DGCnQyoHseC1XkMAiYwxlP
         uZPxNHKef6uUO6/CI4deqI6iPVd9fnZ7ryAB4QO0mzF/ydFnRR15rX098ZhfsthWtS9G
         kYGA==
X-Forwarded-Encrypted: i=1; AHgh+RqHqUhmp9NZwNdUvAZxIFGpOzI1zz3/hXTmQ5kOeZ8M4JEHYmJkA9RvPLuDh69abw60sosLVGY=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwfK7X4IAim83qxR6Ux/nS1WSNAiGSMO0+teh4xyvLik3WSjZj0
	eo6+bqS8oVavMFAtaYmf5lYbAiB++XZZWDqHjaEl6DB4QT2/AhZwO6vc
X-Gm-Gg: AfdE7cnURyBNsibrWIep3ow5LItI8WiXuBnI2HceBwB/uplViIe+yBKSIkew/n4sD8Y
	q5IxaUMJlMGUcg+Lh5rkpZmR9pMmRvW4mQtB/dGpS7rbTvQhKu6TogSU+g2xjMGZOPhKR0OYsye
	GbZMRCwViuz61+odvgPuh7Yfu/kiPltV0CwRVzhLhawYOCBpEeax4hF+RJFJhqTSkDs2qyi2syw
	BDuQwteUGkR8pAvZ3xqHCvk0CVhjoeb8mhYS9S8/QoG6yEeNxkpRIkGMQ1JRMTMooCz/EwTSy90
	0h1N6FiflKOjj0g7qo4wht9/zYNDD6d3yblOIxlgk88TK4zmBOs0ywkS3GN60LzL4WZtBl7O+XJ
	pD2/Rf1w5qAycnvXmJsSy9tGvp/n1izr4dlUmhUlY2o7r23jy9eqgFhdSuqp1SWB7/fmJ69VtEL
	OMgLY=
X-Received: by 2002:a05:6a00:190e:b0:847:b16b:46d9 with SMTP id d2e1a72fcca58-84c292efc9amr12800371b3a.34.1784533006047;
        Mon, 20 Jul 2026 00:36:46 -0700 (PDT)
Received: from ubuntu24.. ([216.23.123.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adcaa0bsm5210536b3a.20.2026.07.20.00.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 00:36:45 -0700 (PDT)
From: Xing Loong <xing.xl.loong@gmail.com>
To: Jens Wiklander <jenswi@kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: firmware: add mbedtee,tee binding
Date: Mon, 20 Jul 2026 15:35:56 +0800
Message-ID: <20260720073558.799755-3-xing.xl.loong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720073558.799755-1-xing.xl.loong@gmail.com>
References: <20260720073558.799755-1-xing.xl.loong@gmail.com>
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
	ASN(0.00)[asn:15169, ipnet:74.125.228.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.228.0:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[74.125.228.0:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[dt];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0F40E43EE4
X-Spamd-Bar: -
X-MailFrom: xing.xl.loong@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: OTWHVVBKGJJGGRBS5XUXEWGN5MBX4HHS
X-Message-ID-Hash: OTWHVVBKGJJGGRBS5XUXEWGN5MBX4HHS
X-Mailman-Approved-At: Wed, 05 Aug 2026 09:14:08 +0000
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Xing Loong <xing.xl.loong@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OTWHVVBKGJJGGRBS5XUXEWGN5MBX4HHS/>
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
Changes in v3:
- Drop all phandle stub nodes from examples.
- Remove redundant required: - interrupts from then branch.
- Simplify title and description.

Changes in v2:
- Fix DT binding review comments from Krzysztof Kozlowski:
  - Drop $nodename, "YAML devicetree binding" wording, property descriptions
  - Rename compatible string to mbedtee,tee
  - Rename memory regions: rpc-t2r-ring -> t2r-ring, rpc-t2r-shm -> t2r-shm,
    rpc-r2t-ring -> r2t-ring
  - Add memory-region / memory-region-names to required
  - Simplify allOf constraints (drop redundant else-branch items)
  - Rewrite description to describe hardware/firmware, not the binding or driver
  - Drop all irrelevant platform nodes (gic, cpus, reserved-memory)
  - Add maxItems: 1 constraint to interrupts property (Sashiko AI review)

---

 .../bindings/firmware/mbedtee,tee.yaml        | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/mbedtee,tee.yaml

diff --git a/Documentation/devicetree/bindings/firmware/mbedtee,tee.yaml b/Documentation/devicetree/bindings/firmware/mbedtee,tee.yaml
new file mode 100644
index 0000000..a8f1201
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/mbedtee,tee.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/mbedtee,tee.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MbedTEE
+
+maintainers:
+  - Xing Loong <xing.xl.loong@gmail.com>
+
+description: |
+  MbedTEE is a Trusted Execution Environment for embedded systems.
+  It communicates with the REE (Linux) via shared-memory ring
+  buffers using a fixed RPC protocol.
+
+  We're using "mbedtee" as the vendor prefix for the open-source TEE
+  project at https://github.com/mbedtee.
+
+  The REE and TEE CPUs sharing the RPC memory must be in a
+  hardware-coherent domain.
+
+  Two or three reserved-memory regions are required:
+    t2r-ring: ring buffer for TEE-to-REE notifications
+    t2r-shm:  shared memory for TEE-to-REE RPC payloads
+    r2t-ring: ring buffer for REE-to-TEE command submissions (RISC-V)
+
+  On ARM the transport uses SMC and a GIC SPI interrupt. On RISC-V
+  the transport uses shared-memory rings and IMSIC MSI; the TEE
+  polls r2t-ring for commands from the REE.
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
+        interrupts: false
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
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    firmware {
+        mbedtee {
+            compatible = "mbedtee,tee";
+            interrupts = <GIC_SPI 72 IRQ_TYPE_EDGE_RISING>;
+            memory-region = <&t2r_ring>, <&t2r_shm>;
+            memory-region-names = "t2r-ring", "t2r-shm";
+        };
+    };
+
+  - |
+    firmware {
+        mbedtee {
+            compatible = "mbedtee,tee";
+            msi-parent = <&imsic>;
+            memory-region = <&t2r_ring>, <&t2r_shm>, <&r2t_ring>;
+            memory-region-names = "t2r-ring", "t2r-shm", "r2t-ring";
+        };
+    };
-- 
2.43.0

