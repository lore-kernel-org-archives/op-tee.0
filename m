Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F89C5DF85
	for <op-tee@archiver.kernel.org>; Wed, 19 Aug 2026 08:39:32 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1BCCA4522E
	for <op-tee@archiver.kernel.org>; Wed, 19 Aug 2026 08:39:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hilxElSJ;
	dkim-atps=neutral
Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4D33E45097
	for <op-tee@lists.trustedfirmware.org>; Wed, 19 Aug 2026 08:36:46 +0000 (UTC)
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-ca92f36c4acso183520a12.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 19 Aug 2026 01:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787128605; x=1787733405; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c/nqPj16def9ZnxDQwFpTtIBuj8LfIQAUc8OONxlNco=;
        b=hilxElSJbjzMcFJdCTf3p6pcfCXLE0mI3R0gMfI72cRtxvNDJYEFm1OV23PbmvR5Zr
         6WvJ2TgPIZIxlDK2CxoxD3LOZko0aoFY7TXqMBBhO2l5VcVIBShTGrudSuU4iS+6hc09
         RbRZMOrCDE8IE7b8Dj0OOYh6Ta2Thcpq1Aoz5Aq+S2o1weL/PCzXigjr7kbgqjmj7ikw
         y+DarfiT2UxyiYQTjYdujQajOcaLooxmemY8psKCPew8c/hwjTf5Tse0AGiFH073e2ct
         Mt0s1e6MNLSRUZphEur2ksZHg4xXoBa4X3lLjFCmDk55cKJbHKFWJVyDQR3fsdRsxuFn
         fi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787128605; x=1787733405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c/nqPj16def9ZnxDQwFpTtIBuj8LfIQAUc8OONxlNco=;
        b=Aa6XnOcNBqLqKYdSqtBMeMvRG/tzRd74a64ny77Yd6Cn9mH/SnT/fijqFn3SHhzmjx
         f273GEZjIrHN4hFozB23gM99bjzpluWA3C6MfcMnDmESx7rWq1TVVm7vxiddpnFJ/I6w
         YLDJa1Bvet6uiWBG3TNPnwNkPxwu3QmusINuTry2kEFB5AtVy75Q7goBX7QVUt4nE2/3
         UBU75prDkzE2CI/7EgotF96mGJH+hcl0FTRxSRHD0OyhaNuIfcgtfZWaVjYzWshva7d8
         bFjdIB7rMFcFyJdnJWhG8kJzE61TGSrok5WVryeN8WuPqbIr2aDPDo/Kzy/pDIm66VWK
         oHIA==
X-Forwarded-Encrypted: i=1; AHgh+RphnC7KhpFEvFLJ10X8HBaaT9c8RuPUoNRw+giD44s3lDgT7MRgbC2yz3b24qJPuDg9MepBLIA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwYjcEQY9gY7XmPiqd6DALyFvJBDmw/sVhp0pgHq9LN09svM9Wb
	kCLiD+97kkFsyODwIuNteqDUo7DXet1yC9/apSmgw58EencptKXI8VaI
X-Gm-Gg: AR+sD12gNcVhx0wXW0219NsDM05RUz8CbK6deH/an0fam1oVvLwSkxgwVWPIAHHKlgn
	p+w6A+sAStvjFVDwqCKGg7on9KmrWRtj5DYQGId9aqL4S0tAdVHvoTE5Ax3Hjip3qJg23GXiAMU
	ES3HB5lIdhX7i0xUr1lAjUP4DjIsWAVLEwlEbaeYvZ74TZmr4AEoyNfs0zg7ihOHXLVvpK9grEF
	Jqy+HE3aanzED5ooK+l/aJcqpXoO2C6X03RqWl5VUi5mrWKEFVE2zYJ9+/Iha7fN9fiRslnFS2d
	quluyGxwCwaBW+S6ZcwHdRHCMjrfoO5bBQgxatNIroLTWDVbLtblnuAb9/dobFMnJaZxoXhPFfU
	ZOBzDMazkBaqqv5XY6aIA4J2VpsrqmPCrvZhHBiwBVf7PTNoX23O49Pe3Vc7djp9DGV5VMlWkSh
	YLQLrgZpo0mcbw9aqnjUxRb8mXULOBSVulKb2AP+ZuHJxeqUN8rxcWx7JL8+G5Buw=
X-Received: by 2002:a05:6300:2284:b0:3b4:5ff3:45cb with SMTP id adf61e73a8af0-3cd00e24fb6mr6745037637.8.1787128605149;
        Wed, 19 Aug 2026 01:36:45 -0700 (PDT)
Received: from ubuntu24.. ([85.149.220.152])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc155464a0asm332268a12.14.2026.08.19.01.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:36:43 -0700 (PDT)
From: Xing Loong <xing.xl.loong@gmail.com>
To: Jens Wiklander <jenswi@kernel.org>
Subject: [PATCH v4 2/3] dt-bindings: firmware: add mbedtee,tee binding
Date: Wed, 19 Aug 2026 16:35:58 +0800
Message-ID: <20260819083559.1303348-3-xing.xl.loong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819083559.1303348-1-xing.xl.loong@gmail.com>
References: <20260819083559.1303348-1-xing.xl.loong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:74.125.0.0/16:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.trustedfirmware.org,vger.kernel.org,lists.infradead.org,gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:74.125.228.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.228.0:from];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.228.0:from];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4D33E45097
X-Spamd-Bar: -
X-MailFrom: xing.xl.loong@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: UBQOUXEPE67AC26HNIO6XPFF27BAPVKB
X-Message-ID-Hash: UBQOUXEPE67AC26HNIO6XPFF27BAPVKB
X-Mailman-Approved-At: Wed, 19 Aug 2026 08:38:33 +0000
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Xing Loong <xing.xl.loong@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UBQOUXEPE67AC26HNIO6XPFF27BAPVKB/>
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
Changes in v4:
- Move reserved-memory region descriptions into memory-region-names
  property (Rob)
- Define memory-region-names item order at top level; keep per-branch
  name count constraints (maxItems: 2 / minItems: 3) (Rob)

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
 .../bindings/firmware/mbedtee,tee.yaml        | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/mbedtee,tee.yaml

diff --git a/Documentation/devicetree/bindings/firmware/mbedtee,tee.yaml b/Documentation/devicetree/bindings/firmware/mbedtee,tee.yaml
new file mode 100644
index 0000000..a67ac43
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/mbedtee,tee.yaml
@@ -0,0 +1,102 @@
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
+  Two or three reserved-memory regions are required. On ARM the
+  transport uses SMC and a GIC SPI interrupt. On RISC-V the
+  transport uses shared-memory rings and IMSIC MSI; the TEE polls
+  r2t-ring for commands from the REE.
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
+    description: |
+      t2r-ring: ring buffer for TEE-to-REE notifications
+      t2r-shm:  shared memory for TEE-to-REE RPC payloads
+      r2t-ring: ring buffer for REE-to-TEE command submissions (RISC-V)
+    minItems: 2
+    items:
+      - const: t2r-ring
+      - const: t2r-shm
+      - const: r2t-ring
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
+          maxItems: 2
+    else:
+      required:
+        - msi-parent
+      properties:
+        interrupts: false
+        memory-region:
+          minItems: 3
+        memory-region-names:
+          minItems: 3
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

