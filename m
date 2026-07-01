Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4554C55174
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:15:13 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E86D7452A1
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:15:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=permerror header.d=gmail.com header.i=@gmail.com header.a=rsa-sha1 header.s=20251104 header.b=aMAhf+jF;
	dkim-atps=neutral
Received: from mail-oo2-f0.google.com (mail-oo2-f0.google.com [74.125.231.128])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9EA9F44DA1
	for <op-tee@lists.trustedfirmware.org>; Wed,  1 Jul 2026 13:31:31 +0000 (UTC)
Received: by mail-oo2-f0.google.com with SMTP id 006d021491bc7-6a141094948so71073eaf.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 01 Jul 2026 06:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782912691; x=1783517491; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELOPtvzNiOcxwPccfGZqo+Tk2G5SqUaj+xktV7uuecc=;
        b=aMAhf+jFEdbBdtwflHNdgxfeLxDDAAwa/6pvBQ4fGozcTYWH9Tq2g31nc51jXTJYyn
         eVJLzeTMDZhsEQE+hlgOMVkUw11Uobs+YPXkLvYY+n8Y+tCxYhUl4YqOq/E/zL62y7u+
         4ZjsIE+Gf7+P2Q1Y4xFP6xWBHPwL8GCW5jMpPGgF8ab0giW8qy65uSnG1vYetQdcdH8i
         QXXEtJqPT9PXPSsPnCViSmC9gYlX5HNbNQERp1ANm6uZe6u7E+5QZAC4BLA0bM7Bn8uA
         l6bUm3J+UPRIA/4VOJjVeuXfHUx6EbzO7b2BrM2s7UAEGgHEj8l9iAaQr/kM5WMLvFIP
         8XHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782912691; x=1783517491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ELOPtvzNiOcxwPccfGZqo+Tk2G5SqUaj+xktV7uuecc=;
        b=Zf/955O3eqydMLXnWuxuanrWZBU+1SZlRe3WaexcbAbPVN/mhnUsY+azMGHk96xdSp
         wYWYnBJd0Yo1TWb4FMUzq0tnU8vEl4rjjcw7I7cyDlumJUxa5/s0/++icYOt5F2iWEfR
         byOUklZAzjF9kcHNyw3ddMKX6P95soFmNlL7VsSuOk6TghjL801kJxYPryQtdNWMlUTP
         3rvU3abVwlna66aLOoLEf9czeUJDyli5L8LDXm2n/YySfn7sukXXAML325Lq0oWct4tl
         wT2lk563iybbewEPTWuWk5WgqVdWy3RSoRE8zco8k+bgqw0XyRQPTfsZJktI/0VrTDeS
         pcIw==
X-Forwarded-Encrypted: i=1; AFNElJ9uYO+N6p4/YTcZglKfmbEa46axJO3pTdfHlh5RA4pJqyVNMLL5eH0WWes/yFHjNy4WRfuzu5g=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyrUkx+MFoGB9z8e1X2fLrx+Vw2wUejL4ACWrjISepnxPixiNLz
	uqmY9moqLbnEw3ijbcB4z4r0YRRcbASA9KrdtrFvb62mlpNeWWPhA4u2yV249YlvMPA8Hepd
X-Gm-Gg: AfdE7cnysteU3ZOdsWIZt1gx5AJAx9OdxZHVWvDdwZzOfMkp9vlPbB89xsQ8OdxDcs6
	DSLr1opMIC1GJ0HC1kGMH1Xwg3VsqSTSgvRxGtQ1H6jpr3tynrvIA9d7u4LkDPr5xPJ4CPz53na
	XLmIcaKak+TCJiO/8WcN8soH37CmdH3WpwdqDcKjf8/es0zdAxdfZb3zWRcdtHahch/qJifSqnQ
	CQeBhgLwrHoH8nKZVxPNMqXl1/zKwgwggh2mf+/ONdZ52Tb0Dgw/+4X7/D3qlqcZ5TTYbK1XV72
	LtworrBjJq7rXOd4yXOvwlKoOMPYyHag3wdCsuy4OuANrVLMkOj5sLm21tA6jrkvyzt3j/PsrIE
	jlo+O5gTgxov6OkyIH/mRkKqVgYmBZyt9EyjouyVXU6+yVyNgtBpkLkcg/6IVZ8Iw6iabkEaWut
	voHY0C2boYly6Os+cjOD272MFg8KKDctweset9/8t8ZF60ZQ/GSQlXeZM=
X-Received: by 2002:a05:6830:3e01:b0:7dc:e336:c828 with SMTP id 46e09a7af769-7eb48af3f30mr859806a34.10.1782912361959;
        Wed, 01 Jul 2026 06:26:01 -0700 (PDT)
Received: from ubuntu24.. (dsl092-249-254.sfo4.dsl.speakeasy.net. [66.92.249.254])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ec34f898sm4938144a34.27.2026.07.01.06.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 06:26:01 -0700 (PDT)
From: Xing Loong <xing.xl.loong@gmail.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 2/3] dt-bindings: firmware: add mbedtee,rpc binding
Date: Wed,  1 Jul 2026 21:25:13 +0800
Message-ID: <20260701132514.186953-3-xing.xl.loong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701132514.186953-1-xing.xl.loong@gmail.com>
References: <20260701132514.186953-1-xing.xl.loong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: add header
X-Spamd-Result: default: False [5.85 / 15.00];
	URL_BACKSLASH_PATH(4.00)[0.0.0.0,1.171.63.0];
	URL_NUMERIC_IP(3.00)[0.0.0.0,1.171.63.0];
	BAYES_HAM(-2.15)[95.94%];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:74.125.0.0/16];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,lists.trustedfirmware.org,vger.kernel.org,lists.infradead.org,gmail.com];
	GREYLIST(0.00)[pass,body];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:74.125.0.0/16, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.231.128:from];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.231.128:from];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.835];
	TAGGED_RCPT(0.00)[dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9EA9F44DA1
X-Spamd-Bar: +++++
X-MailFrom: xing.xl.loong@gmail.com
X-Mailman-Rule-Hits: header-match-op-tee.lists.trustedfirmware.org-0
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Message-ID-Hash: 4P4ZA62AUYKLP54DKXDKB7EI2WABNVBN
X-Message-ID-Hash: 4P4ZA62AUYKLP54DKXDKB7EI2WABNVBN
X-Mailman-Approved-At: Wed, 05 Aug 2026 09:13:16 +0000
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Xing Loong <xing.xl.loong@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4P4ZA62AUYKLP54DKXDKB7EI2WABNVBN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
X-Spam: Yes

Add YAML devicetree binding for the MbedTEE Trusted Execution
Environment driver.

The binding covers two platform configurations:
  - ARM/AArch64 (TrustZone, SMC): two reserved-memory regions
    (rpc-t2r-ring and rpc-t2r-shm) plus a GIC SPI edge interrupt
    for TEE-to-REE notifications.
  - RISC-V (IMSIC): three reserved-memory regions, adding
    rpc-r2t-ring for REE-to-TEE command submissions; no interrupts
    property (T2R notifications use IMSIC MSI allocated at runtime).

Signed-off-by: Xing Loong <xing.xl.loong@gmail.com>
---
 .../bindings/firmware/mbedtee,rpc.yaml        | 221 ++++++++++++++++++
 1 file changed, 221 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/mbedtee,rpc.yaml

diff --git a/Documentation/devicetree/bindings/firmware/mbedtee,rpc.yaml b/Documentation/devicetree/bindings/firmware/mbedtee,rpc.yaml
new file mode 100644
index 0000000..08ae255
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/mbedtee,rpc.yaml
@@ -0,0 +1,221 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/mbedtee,rpc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MbedTEE Trusted Execution Environment
+
+maintainers:
+  - Xing Loong <xing.xl.loong@gmail.com>
+
+description: |
+  MbedTEE is a Trusted Execution Environment for embedded systems.
+  This binding describes the shared-memory regions used for RPC
+  communication between the Linux REE driver and MbedTEE OS.
+
+  The REE and TEE CPUs sharing the RPC memory must be in a
+  hardware-coherent domain (same CPU cluster, coherent caches).
+
+  Two or three reserved-memory regions are required:
+
+    rpc-t2r-ring  ring buffer for TEE-to-REE notifications (all platforms)
+    rpc-t2r-shm   shared memory for TEE-to-REE RPC payloads (all platforms)
+    rpc-r2t-ring  ring buffer for REE-to-TEE command submissions (RISC-V only)
+
+  On ARM/AArch64 the transport uses SMC calls; TEE-to-REE
+  notifications use a GIC SPI edge interrupt.
+
+  On RISC-V the TEE notifies the REE via IMSIC MSI; the REE submits
+  commands via shared-memory rpc-r2t-ring that the TEE polls. No
+  REE-to-TEE interrupt is used. No SBI ecall is involved.
+
+properties:
+  $nodename:
+    const: mbedtee
+
+  compatible:
+    const: mbedtee,rpc
+
+  interrupts:
+    description:
+      GIC interrupt used by the TEE to notify the REE of pending RPC
+      responses (ARM/AArch64 only). Not present on RISC-V platforms which
+      use IMSIC platform MSI interrupts allocated dynamically at runtime.
+
+  msi-parent:
+    maxItems: 1
+    description:
+      IMSIC MSI controller used by the Linux driver to allocate the
+      TEE-to-REE notification interrupt on RISC-V platforms. Not present on
+      ARM/AArch64 platforms, which use the interrupts property.
+
+  memory-region:
+    minItems: 2
+    maxItems: 3
+    description:
+      References to reserved-memory regions for REE<->TEE communication.
+      Entries must match memory-region-names order.
+
+  memory-region-names:
+    minItems: 2
+    maxItems: 3
+    items:
+      enum:
+        - rpc-t2r-ring
+        - rpc-t2r-shm
+        - rpc-r2t-ring
+
+required:
+  - compatible
+
+allOf:
+  - if:
+      required:
+        - interrupts
+    then:
+      required:
+        - interrupts
+        - memory-region
+        - memory-region-names
+      properties:
+        msi-parent: false
+        memory-region:
+          minItems: 2
+          maxItems: 2
+        memory-region-names:
+          items:
+            - const: rpc-t2r-ring
+            - const: rpc-t2r-shm
+    else:
+      required:
+        - msi-parent
+        - memory-region
+        - memory-region-names
+      properties:
+        memory-region:
+          minItems: 3
+          maxItems: 3
+        memory-region-names:
+          items:
+            - const: rpc-t2r-ring
+            - const: rpc-t2r-shm
+            - const: rpc-r2t-ring
+
+additionalProperties: false
+
+examples:
+  - |
+    /* ARM TrustZone (SMC) */
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    / {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      gic: interrupt-controller@2f000000 {
+        compatible = "arm,gic-v3";
+        reg = <0 0x2f000000 0 0x10000>,
+              <0 0x2f100000 0 0x200000>;
+        interrupt-controller;
+        #interrupt-cells = <3>;
+      };
+
+      reserved-memory {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges;
+
+        mbedtee_t2r_ring: rpc-t2r-ring@85f10000 {
+          reg = <0 0x85f10000 0 0x20000>;
+          no-map;
+        };
+
+        mbedtee_t2r_shm: rpc-t2r-shm@85f30000 {
+          reg = <0 0x85f30000 0 0x40000>;
+          no-map;
+        };
+      };
+
+      firmware {
+        mbedtee {
+          compatible = "mbedtee,rpc";
+          interrupt-parent = <&gic>;
+          interrupts = <GIC_SPI 72 IRQ_TYPE_EDGE_RISING>;
+          memory-region = <&mbedtee_t2r_ring>, <&mbedtee_t2r_shm>;
+          memory-region-names = "rpc-t2r-ring", "rpc-t2r-shm";
+        };
+      };
+    };
+
+  - |
+    /* RISC-V IMSIC (ring-buffer polling REE->TEE, MSI TEE->REE) */
+    / {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      cpus {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cpu@0 {
+          device_type = "cpu";
+          reg = <0>;
+
+          cpu0_intc: interrupt-controller {
+            compatible = "riscv,cpu-intc";
+            interrupt-controller;
+            #interrupt-cells = <1>;
+          };
+        };
+      };
+
+      imsic: interrupt-controller@28000000 {
+        compatible = "qemu,imsics", "riscv,imsics";
+        reg = <0 0x28000000 0 0x1000>;
+        interrupts-extended = <&cpu0_intc 9>;
+        interrupt-controller;
+        #interrupt-cells = <0>;
+        msi-controller;
+        #msi-cells = <0>;
+        riscv,num-ids = <255>;
+      };
+
+      reserved-memory {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges;
+
+        rv_t2r_ring: rpc-t2r-ring@5f10000 {
+          reg = <0 0x5f10000 0 0x20000>;
+          no-map;
+        };
+
+        rv_t2r_shm: rpc-t2r-shm@5f30000 {
+          reg = <0 0x5f30000 0 0x40000>;
+          no-map;
+        };
+
+        rv_r2t_ring: rpc-r2t-ring@5f70000 {
+          reg = <0 0x5f70000 0 0x20000>;
+          no-map;
+        };
+      };
+
+      /*
+       * The riscv container avoids a duplicate /firmware/mbedtee path
+       * with the ARM example above when the DT checker concatenates
+       * examples into a single .dts.
+       */
+      riscv {
+        firmware {
+          mbedtee {
+            compatible = "mbedtee,rpc";
+            msi-parent = <&imsic>;
+            memory-region = <&rv_t2r_ring>, <&rv_t2r_shm>,
+                            <&rv_r2t_ring>;
+            memory-region-names = "rpc-t2r-ring", "rpc-t2r-shm",
+                                  "rpc-r2t-ring";
+          };
+        };
+      };
+    };
-- 
2.43.0

