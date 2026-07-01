Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA13C43458
	for <op-tee@archiver.kernel.org>; Wed,  1 Jul 2026 14:05:22 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9F10445044
	for <op-tee@archiver.kernel.org>; Wed,  1 Jul 2026 14:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782914721;
	bh=0nvsHBmf2FE5rKBPPsN+DZAsBkoyqvfDWlJWrgesl9A=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=tUEPp/9jUL42qgUkzpwppPoXTc6eKI4K/M5VnPKejjjP3oNEYXHPia4cD1/Pm+pax
	 8nVjJZP2ltFnv09Tgjlxprhxg545O1zqmg1gWBIGD54rmx2wpr612nnFgJGrCaBTPQ
	 3he7wHavepUbfVjIRMkb+5S8tzuTaAYfpgB1miPoKQkx9lseUbd4UomYs3Eihvb2c1
	 vEouTAtlMgDJ2B6BGFDZku8XvH81iJOoXIxDdCDOkiaY4sk89Ct5rmaNy42jJ5rPcp
	 aQj0rp+FD099dMkeasRYmpAmi0GZtN2Geahp5efE6Bt0HpkfwZZXT4I9qoJEx2812y
	 GDbcAE2a6+5IA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5C36B44AEB
	for <op-tee@lists.trustedfirmware.org>; Wed,  1 Jul 2026 14:05:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HkdidmL8;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E42A06001D;
	Wed,  1 Jul 2026 14:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A6B1F000E9;
	Wed,  1 Jul 2026 14:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782914712;
	bh=KN1ZZoShUes6sGFwycYM2qI4rRpQvujeGBBYwd462qg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HkdidmL8i7jVnVEjIIcgCKSXScek/60dRiwAAP4oj30EEDyou9nVafCvtV0b4RP5P
	 6onzkAjRbCfPb+7nwMtEcqM11iptMzCwQddnSVo3pbpwJbuJSuxkJ6irwsfaosg3H8
	 GEDGaZH8D1YX8evg5Hr0wbpPaL22jF0c2eBjNDroBmoZAuhg+AYByAFvS0bOCGtafy
	 xzbTcAvQRWGD0mivnctUacPxws5yxqWSHTpw1rI92Wa6W1690Y2FNWtUiTvGNIBWLJ
	 T2jxlffovycLkIGQ62LA/zrL2J/YDc1YECLvNM2/zsHFENrUJbUr5LxWbk0rxtvG/4
	 fq79uJdC33FWg==
Message-ID: <70068ae8-ede1-41d2-899b-98ed11e19953@kernel.org>
Date: Wed, 1 Jul 2026 16:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: firmware: add mbedtee,rpc binding
To: Xing Loong <xing.xl.loong@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <20260701132514.186953-1-xing.xl.loong@gmail.com>
 <20260701132514.186953-3-xing.xl.loong@gmail.com>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260701132514.186953-3-xing.xl.loong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.50 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[dt];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linaro.org];
	RCVD_COUNT_TWO(0.00)[2];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5C36B44AEB
X-Spamd-Bar: -----
Message-ID-Hash: QJLNY4NLZN5XJMCVL7WJQ34FLMPYCQUX
X-Message-ID-Hash: QJLNY4NLZN5XJMCVL7WJQ34FLMPYCQUX
X-MailFrom: krzk@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QJLNY4NLZN5XJMCVL7WJQ34FLMPYCQUX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Krzysztof Kozlowski via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Krzysztof Kozlowski <krzk@kernel.org>

On 01/07/2026 15:25, Xing Loong wrote:
> Add YAML devicetree binding for the MbedTEE Trusted Execution

Drop YAML, there is no such thing as YAML binding.

> Environment driver.

We don't take bindings for drivers but for hardware or firmware. Please
describe these instead.

> 
> The binding covers two platform configurations:
>   - ARM/AArch64 (TrustZone, SMC): two reserved-memory regions
>     (rpc-t2r-ring and rpc-t2r-shm) plus a GIC SPI edge interrupt
>     for TEE-to-REE notifications.
>   - RISC-V (IMSIC): three reserved-memory regions, adding
>     rpc-r2t-ring for REE-to-TEE command submissions; no interrupts
>     property (T2R notifications use IMSIC MSI allocated at runtime).
> 
> Signed-off-by: Xing Loong <xing.xl.loong@gmail.com>
> ---
>  .../bindings/firmware/mbedtee,rpc.yaml        | 221 ++++++++++++++++++
>  1 file changed, 221 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/mbedtee,rpc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/mbedtee,rpc.yaml b/Documentation/devicetree/bindings/firmware/mbedtee,rpc.yaml
> new file mode 100644
> index 0000000..08ae255
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/mbedtee,rpc.yaml
> @@ -0,0 +1,221 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/mbedtee,rpc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MbedTEE Trusted Execution Environment
> +
> +maintainers:
> +  - Xing Loong <xing.xl.loong@gmail.com>
> +
> +description: |
> +  MbedTEE is a Trusted Execution Environment for embedded systems.
> +  This binding describes the shared-memory regions used for RPC

Describe firmware, not the binding. It's redundant to say what the
binding is about, just say what is the hardware.

> +  communication between the Linux REE driver and MbedTEE OS.
> +
> +  The REE and TEE CPUs sharing the RPC memory must be in a
> +  hardware-coherent domain (same CPU cluster, coherent caches).
> +
> +  Two or three reserved-memory regions are required:
> +
> +    rpc-t2r-ring  ring buffer for TEE-to-REE notifications (all platforms)
> +    rpc-t2r-shm   shared memory for TEE-to-REE RPC payloads (all platforms)
> +    rpc-r2t-ring  ring buffer for REE-to-TEE command submissions (RISC-V only)
> +
> +  On ARM/AArch64 the transport uses SMC calls; TEE-to-REE
> +  notifications use a GIC SPI edge interrupt.
> +
> +  On RISC-V the TEE notifies the REE via IMSIC MSI; the REE submits
> +  commands via shared-memory rpc-r2t-ring that the TEE polls. No
> +  REE-to-TEE interrupt is used. No SBI ecall is involved.
> +
> +properties:
> +  $nodename:
> +    const: mbedtee

Drop, why would it be relevant?

> +
> +  compatible:
> +    const: mbedtee,rpc

Feels way too generic. First, Google results on mbedtee are basically
non-existing, so what sort of company is that?

Second, rpc is just not specific enough. Please carefully read writing
bindings doc.

> +
> +  interrupts:
> +    description:
> +      GIC interrupt used by the TEE to notify the REE of pending RPC
> +      responses (ARM/AArch64 only). Not present on RISC-V platforms which
> +      use IMSIC platform MSI interrupts allocated dynamically at runtime.

Please read writing bindings doc.

> +
> +  msi-parent:
> +    maxItems: 1
> +    description:
> +      IMSIC MSI controller used by the Linux driver to allocate the

Again drivers...

> +      TEE-to-REE notification interrupt on RISC-V platforms. Not present on
> +      ARM/AArch64 platforms, which use the interrupts property.
> +
> +  memory-region:
> +    minItems: 2
> +    maxItems: 3
> +    description:
> +      References to reserved-memory regions for REE<->TEE communication.
> +      Entries must match memory-region-names order.

Obvious. Please do not come with your own style of bindings.

> +
> +  memory-region-names:
> +    minItems: 2
> +    maxItems: 3

Why is this flexible?

> +    items:
> +      enum:
> +        - rpc-t2r-ring

rpc is redundant, drop

> +        - rpc-t2r-shm
> +        - rpc-r2t-ring
> +
> +required:
> +  - compatible
> +
> +allOf:
> +  - if:
> +      required:
> +        - interrupts
> +    then:
> +      required:
> +        - interrupts
> +        - memory-region
> +        - memory-region-names
> +      properties:
> +        msi-parent: false
> +        memory-region:
> +          minItems: 2
> +          maxItems: 2
> +        memory-region-names:
> +          items:
> +            - const: rpc-t2r-ring
> +            - const: rpc-t2r-shm
> +    else:
> +      required:
> +        - msi-parent
> +        - memory-region
> +        - memory-region-names

So memory-region is always required?

> +      properties:
> +        memory-region:
> +          minItems: 3
> +          maxItems: 3
> +        memory-region-names:
> +          items:
> +            - const: rpc-t2r-ring
> +            - const: rpc-t2r-shm
> +            - const: rpc-r2t-ring

Your top level schema said that. You only need minItems.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    /* ARM TrustZone (SMC) */
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    / {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      gic: interrupt-controller@2f000000 {
> +        compatible = "arm,gic-v3";
> +        reg = <0 0x2f000000 0 0x10000>,
> +              <0 0x2f100000 0 0x200000>;
> +        interrupt-controller;
> +        #interrupt-cells = <3>;
> +      };
> +
> +      reserved-memory {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        ranges;
> +
> +        mbedtee_t2r_ring: rpc-t2r-ring@85f10000 {
> +          reg = <0 0x85f10000 0 0x20000>;
> +          no-map;
> +        };
> +
> +        mbedtee_t2r_shm: rpc-t2r-shm@85f30000 {
> +          reg = <0 0x85f30000 0 0x40000>;
> +          no-map;
> +        };
> +      };

None of the above is relevant, drop.


> +
> +      firmware {
> +        mbedtee {
> +          compatible = "mbedtee,rpc";
> +          interrupt-parent = <&gic>;
> +          interrupts = <GIC_SPI 72 IRQ_TYPE_EDGE_RISING>;
> +          memory-region = <&mbedtee_t2r_ring>, <&mbedtee_t2r_shm>;
> +          memory-region-names = "rpc-t2r-ring", "rpc-t2r-shm";
> +        };
> +      };
> +    };
> +


Best regards,
Krzysztof
