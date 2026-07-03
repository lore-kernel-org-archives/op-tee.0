Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E71C55822
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:17:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 37FB545056
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:17:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=permerror header.d=gmail.com header.i=@gmail.com header.a=rsa-sha1 header.s=20251104 header.b=sH7E0tEG;
	dkim-atps=neutral
Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EEFEA43E65
	for <op-tee@lists.trustedfirmware.org>; Fri,  3 Jul 2026 07:16:37 +0000 (UTC)
Received: by mail-oa2-f1.google.com with SMTP id 586e51a60fabf-447489dd9c7so125064fac.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 03 Jul 2026 00:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783062997; x=1783667797; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8/To5uu366iTzXiach4JBOKu6hRxUbkL3Sh+ENphnrM=;
        b=sH7E0tEGiccoLZExqoOxd8VgjJV8qh78NgMW+CcgHYNz03JCw4ugUjl8VGpI4UjWfl
         j/peasMFBbU05qxITv5G+lD6R1xxFwWbwUQ7t/SeFHkD3fZHR058nOvgo0C9DmnP+nTm
         puqE6h68I74TF2SW9ibJpl9no3yf+A+6jR40PoRh+LcuMowbLvg2wWn7zqX3OtHg/Kga
         YI7eRCJQjqMZUpjPKtVQ5W1Q2hc8agS1OcR0pxM53CstVVoqsebUNk/RymdCrnA5pIHw
         xs4RrmnSuaiJMG1rNsEQ61l0ASfUqteASA76r+JpZP+WTB0AUg8y2tnDqxMfhPgZx1Av
         r+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783062997; x=1783667797;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/To5uu366iTzXiach4JBOKu6hRxUbkL3Sh+ENphnrM=;
        b=f7fwVsZvwNM4LDJFb3gbZDFHYY6QnkWmKQMjKgZxIXNX5eenuD2utp/KfOk0g7/0e2
         2Skc1v1BqGDB6AkGwDGJ1XohLKiiat5RbNVg0FscccLfL6Eg1ETJPfllrJJ1fcYmLOR5
         HOuNuaFaJ5JSkfPLZ+cXPBrOqRys8DWyWTLTmyp+NTfRc1SlvQlbJtd0/2SMRhay0bBV
         QeCCfmeBlppud3fJb2y5wLrtn8eXN0kaXYqIq4bfBcuHJ5iZD1ibQ0yYbPgrkEapbEOT
         MfUW5dwbTiqwh6PRmgWQk1fXXFlFyrYOe/Eh1xJlSKus1NMHw3PMfR0uG2kxifxbn8lS
         vQxg==
X-Forwarded-Encrypted: i=1; AFNElJ+7a6L0b4JB0lec5/CA+QYTcdk0hNsugIWz3AAviM3F7NNJUzduj6bQuY4NSZd3WkYS94v2Guc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Ywaj2rnS1Y5jqunVWJ9SRoXHbnZUM7ELdWiYJYa6jr49jodjy55
	PcIWBsGKOQlkRweG0TrfSEYpN/vE80scc6wHhAaCnsfQD3SUR0w1tyFx
X-Gm-Gg: AfdE7ckzHwIkNHPtRxcBHcCfN3abSE47g6rLoma7pS316w0Nz2enqZzHW+MBtS5RT1P
	+IT2N8QkNgKEywAAB6SNehICTWQ4u7AHPb1NcDs2xeUC/GANY2MC6OLJr+J1gaHg9HfhaABwBGP
	zAJACkHo+Zq8VO3vj5NAauhug1t6sAMbJ0ptjAJSUgx+NYlJ2mYDuVZDC/4K2i0xdIUM6NAeSa6
	ipnYT+rFFA/lAZxysO5mzbRcKiMGaxg4t9bCfGbLHwQbt1WuBZ6irIcqLlYv8aYOJXTd+Y4TrG9
	ij/wev3DcwOl60S2nYCMAolDUeiXQYSlu1Fmxs53Az8dkJ+/PTjNwkxKMfoa2dQqt1zwnG7ki+d
	PotIcV4+PIgyyq6NrpxMzCYCbIblwAydrXebvlPE3F8/of+RXlE/YD22OfhLSPK+8zW71Mf6H/c
	DN1OJFEWA8/QEhFR1cY+LbfB+FwZXwjSw0PIp/JNyo7iaFKjhFXo8thLqWiZ7ym9Q=
X-Received: by 2002:a05:6870:2187:b0:449:bccd:79fb with SMTP id 586e51a60fabf-44cab961fb9mr6076032fac.24.1783062997063;
        Fri, 03 Jul 2026 00:16:37 -0700 (PDT)
Received: from ubuntu24 (dsl092-249-254.sfo4.dsl.speakeasy.net. [66.92.249.254])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb54f775sm1162626fac.10.2026.07.03.00.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 00:16:36 -0700 (PDT)
Date: Fri, 3 Jul 2026 15:16:29 +0800
From: Xing Loong <xing.xl.loong@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: firmware: add mbedtee,rpc binding
Message-ID: <akdhzUQWPsUS69P5@ubuntu24>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70068ae8-ede1-41d2-899b-98ed11e19953@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:74.125.0.0/16];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:74.125.0.0/16, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.231.65:from];
	TAGGED_RCPT(0.00)[dt];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.231.65:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EEFEA43E65
X-Spamd-Bar: -
X-MailFrom: xing.xl.loong@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: RLACLOUBDHB54ICTHSQDP4DHEJGCUB4I
X-Message-ID-Hash: RLACLOUBDHB54ICTHSQDP4DHEJGCUB4I
X-Mailman-Approved-At: Wed, 05 Aug 2026 09:14:07 +0000
CC: Jens Wiklander <jenswi@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RLACLOUBDHB54ICTHSQDP4DHEJGCUB4I/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>


On 01/07/2026 16:05, Krzysztof Kozlowski wrote:
> On 01/07/2026 15:25, Xing Loong wrote:
> > Add YAML devicetree binding for the MbedTEE Trusted Execution
> 
> Drop YAML, there is no such thing as YAML binding.

Will drop.

> > Environment driver.
> 
> We don't take bindings for drivers but for hardware or firmware. Please
> describe these instead.

Will rewrite the description to describe what MbedTEE is as
firmware, not the driver or the binding.

> > The binding covers two platform configurations:
> >   - ARM/AArch64 (TrustZone, SMC): two reserved-memory regions
> >     (rpc-t2r-ring and rpc-t2r-shm) plus a GIC SPI edge interrupt
> >     for TEE-to-REE notifications.
> >   - RISC-V (IMSIC): three reserved-memory regions, adding
> >     rpc-r2t-ring for REE-to-TEE command submissions; no interrupts
> >     property (T2R notifications use IMSIC MSI allocated at runtime).
> > 
> > Signed-off-by: Xing Loong <xing.xl.loong@gmail.com>
> > ---
> >  .../bindings/firmware/mbedtee,rpc.yaml        | 221 ++++++++++++++++++
> >  1 file changed, 221 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/firmware/mbedtee,rpc.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/firmware/mbedtee,rpc.yaml b/Documentation/devicetree/bindings/firmware/mbedtee,rpc.yaml
> > new file mode 100644
> > index 0000000..08ae255
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/mbedtee,rpc.yaml
> > @@ -0,0 +1,221 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/firmware/mbedtee,rpc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MbedTEE Trusted Execution Environment
> > +
> > +maintainers:
> > +  - Xing Loong <xing.xl.loong@gmail.com>
> > +
> > +description: |
> > +  MbedTEE is a Trusted Execution Environment for embedded systems.
> > +  This binding describes the shared-memory regions used for RPC
> 
> Describe firmware, not the binding. It's redundant to say what the
> binding is about, just say what is the hardware.

Will rewrite, removing "driver", "YAML" and "This binding
describes" wording throughout.

> > +  communication between the Linux REE driver and MbedTEE OS.
> > +
> > +  The REE and TEE CPUs sharing the RPC memory must be in a
> > +  hardware-coherent domain (same CPU cluster, coherent caches).
> > +
> > +  Two or three reserved-memory regions are required:
> > +
> > +    rpc-t2r-ring  ring buffer for TEE-to-REE notifications (all platforms)
> > +    rpc-t2r-shm   shared memory for TEE-to-REE RPC payloads (all platforms)
> > +    rpc-r2t-ring  ring buffer for REE-to-TEE command submissions (RISC-V only)
> > +
> > +  On ARM/AArch64 the transport uses SMC calls; TEE-to-REE
> > +  notifications use a GIC SPI edge interrupt.
> > +
> > +  On RISC-V the TEE notifies the REE via IMSIC MSI; the REE submits
> > +  commands via shared-memory rpc-r2t-ring that the TEE polls. No
> > +  REE-to-TEE interrupt is used. No SBI ecall is involved.
> > +
> > +properties:
> > +  $nodename:
> > +    const: mbedtee
> 
> Drop, why would it be relevant?

Will drop.

> > +
> > +  compatible:
> > +    const: mbedtee,rpc
> 
> Feels way too generic. First, Google results on mbedtee are basically
> non-existing, so what sort of company is that?
> 
> Second, rpc is just not specific enough. Please carefully read writing
> bindings doc.

Will rename to "mbedtee,tee". mbedtee is an open-source TEE
project (https://github.com/mbedtee), not a company. Patch 1/3 adds
the corresponding "mbedtee" entry to vendor-prefixes.yaml.

> > +
> > +  interrupts:
> > +    description:
> > +      GIC interrupt used by the TEE to notify the REE of pending RPC
> > +      responses (ARM/AArch64 only). Not present on RISC-V platforms which
> > +      use IMSIC platform MSI interrupts allocated dynamically at runtime.
> 
> Please read writing bindings doc.

Will drop the description.  Will add maxItems: 1 instead.

> > +
> > +  msi-parent:
> > +    maxItems: 1
> > +    description:
> > +      IMSIC MSI controller used by the Linux driver to allocate the
> 
> Again drivers...

Will drop the description.  Will keep only maxItems: 1.

> > +      TEE-to-REE notification interrupt on RISC-V platforms. Not present on
> > +      ARM/AArch64 platforms, which use the interrupts property.
> > +
> > +  memory-region:
> > +    minItems: 2
> > +    maxItems: 3
> > +    description:
> > +      References to reserved-memory regions for REE<->TEE communication.
> > +      Entries must match memory-region-names order.
> 
> Obvious. Please do not come with your own style of bindings.

Will drop the description.  Understood, will follow the standard
style used by existing bindings.

> > +
> > +  memory-region-names:
> > +    minItems: 2
> > +    maxItems: 3
> 
> Why is this flexible?

Will constrain it via the allOf: if/then branches (ARM: fixed at 2,
RISC-V: fixed at 3).

> > +    items:
> > +      enum:
> > +        - rpc-t2r-ring
> 
> rpc is redundant, drop

Will drop the "rpc-" prefix.  Will use t2r-ring, t2r-shm, r2t-ring.

> > +        - rpc-t2r-shm
> > +        - rpc-r2t-ring
> > +
> > +required:
> > +  - compatible
> > +
> > +allOf:
> > +  - if:
> > +      required:
> > +        - interrupts
> > +    then:
> > +      required:
> > +        - interrupts
> > +        - memory-region
> > +        - memory-region-names
> > +      properties:
> > +        msi-parent: false
> > +        memory-region:
> > +          minItems: 2
> > +          maxItems: 2
> > +        memory-region-names:
> > +          items:
> > +            - const: rpc-t2r-ring
> > +            - const: rpc-t2r-shm
> > +    else:
> > +      required:
> > +        - msi-parent
> > +        - memory-region
> > +        - memory-region-names
> 
> So memory-region is always required?

Yes.  Will move memory-region and memory-region-names to the
top-level required: list to make this explicit.  The interrupts and
msi-parent properties will also be made mutually exclusive per
platform (msi-parent: false on ARM, interrupts: false on RISC-V).

> > +      properties:
> > +        memory-region:
> > +          minItems: 3
> > +          maxItems: 3
> > +        memory-region-names:
> > +          items:
> > +            - const: rpc-t2r-ring
> > +            - const: rpc-t2r-shm
> > +            - const: rpc-r2t-ring
> 
> Your top level schema said that. You only need minItems.

Will drop the redundant constraints from the else branch.

> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    /* ARM TrustZone (SMC) */
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    / {
> > +      #address-cells = <2>;
> > +      #size-cells = <2>;
> > +
> > +      gic: interrupt-controller@2f000000 {
> > +        compatible = "arm,gic-v3";
> > +        reg = <0 0x2f000000 0 0x10000>,
> > +              <0 0x2f100000 0 0x200000>;
> > +        interrupt-controller;
> > +        #interrupt-cells = <3>;
> > +      };
> > +
> > +      reserved-memory {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +        ranges;
> > +
> > +        mbedtee_t2r_ring: rpc-t2r-ring@85f10000 {
> > +          reg = <0 0x85f10000 0 0x20000>;
> > +          no-map;
> > +        };
> > +
> > +        mbedtee_t2r_shm: rpc-t2r-shm@85f30000 {
> > +          reg = <0 0x85f30000 0 0x40000>;
> > +          no-map;
> > +        };
> > +      };
> 
> None of the above is relevant, drop.

Will drop all platform infrastructure nodes.  Will follow the
minimal example pattern seen in linaro,optee-tz.yaml.

> > +
> > +      firmware {
> > +        mbedtee {
> > +          compatible = "mbedtee,rpc";
> > +          interrupt-parent = <&gic>;
> > +          interrupts = <GIC_SPI 72 IRQ_TYPE_EDGE_RISING>;
> > +          memory-region = <&mbedtee_t2r_ring>, <&mbedtee_t2r_shm>;
> > +          memory-region-names = "rpc-t2r-ring", "rpc-t2r-shm";
> > +        };
> > +      };
> > +    };
> > +
> 
> Best regards,
> Krzysztof

Thanks for the thorough review.  Will send v3 after incorporating
all of the above.

Best regards,
Xing Loong
