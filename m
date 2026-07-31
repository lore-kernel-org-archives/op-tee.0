Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB83C55173
	for <op-tee@archiver.kernel.org>; Fri, 31 Jul 2026 20:20:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id F09D844460
	for <op-tee@archiver.kernel.org>; Fri, 31 Jul 2026 20:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1785529205;
	bh=z6ogPgFR/z+XXbOzcm5vmg73+jmN+2s6AsGK2AGXxRA=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=1p0rhHBeR8Ls53iQN5Iun5UA8DTx6hxF0lUXe4I+cd7pQsiwiklu4yFN3qTU1x0pH
	 KJ5a0CQoCcvwkjnXLhMSXdOYpdKExUCygcloWulnXULJtnLPfGexxMw+ebDZL2W/YY
	 d5d3qdmtQEqY24ldSyZ+SO2op7BaXEdAR4+4fNuk7RNOnYBaUalPp+TnGht4ApXJBC
	 0G+LTfzUZ1wsk7B6j8M99+lm7p37lbtgKSPDNovJpaLRd5lNY0+RUvbguOfq+vLSDX
	 FnHrp+FWqkFmCAfNQko+j/vN6ISOKyvFsM6AxP+hC61GyYy3WMS0UexSbMV6vbHqT6
	 z94bxy0RLUGWg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5404844460
	for <op-tee@lists.trustedfirmware.org>; Fri, 31 Jul 2026 20:19:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VYi+Wf0t;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9462144017;
	Fri, 31 Jul 2026 20:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571FE1F00AC4;
	Fri, 31 Jul 2026 20:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785529197;
	bh=gAqTgmb8nyHXOBE2Z+WAy2vf/nC7RaTwNiVzTEyUthM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VYi+Wf0tpE5oJ6sdlwlFvIHL5mE5R3eX1tXGXs6hQpPjdmIE6p801MKYyoGbRiAA2
	 uwQ5Az41PsZ7MSPlmY5BU81ClM/UOi+YXpqj+FQOzLJ+m3fDSvOznH9VLFXLYYuYvM
	 5kHkh6v5QJjsk5KeXqDWPKnVKe0XXriiin3BES5Wzhk4i7tvu+a5RgMxX6cbEgXllk
	 ime18CmGbSA+kJmCfKOXrIpEvVejG0mCpyG4f4+4eNmQpUeYmaP9qMe5dufOTpsI1t
	 Ba0tQ+mGnC0jtZjjnbMsfRMGFk+5Sz9GY/VIw7PZtkvyIqxKM3dJjiJxGg6gCFKHIY
	 N691LPdgdRPJQ==
Date: Fri, 31 Jul 2026 15:19:55 -0500
To: Xing Loong <xing.xl.loong@gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: firmware: add mbedtee,tee binding
Message-ID: <20260731201955.GA1585970-robh@kernel.org>
References: <20260720073558.799755-1-xing.xl.loong@gmail.com>
 <20260720073558.799755-3-xing.xl.loong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720073558.799755-3-xing.xl.loong@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dt];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5404844460
X-Spamd-Bar: ----
Message-ID-Hash: 2SU2KFDBBN4XHAMNREON5MLBUL5I76PO
X-Message-ID-Hash: 2SU2KFDBBN4XHAMNREON5MLBUL5I76PO
X-MailFrom: robh@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2SU2KFDBBN4XHAMNREON5MLBUL5I76PO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Rob Herring via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Rob Herring <robh@kernel.org>

On Mon, Jul 20, 2026 at 03:35:56PM +0800, Xing Loong wrote:
> MbedTEE is a Trusted Execution Environment for embedded
> systems (https://github.com/mbedtee). It communicates with
> the REE via shared-memory ring buffers using a fixed RPC
> protocol. Two platform configurations are supported:
> 
>   - ARM/AArch64 (TrustZone, SMC): two reserved-memory
>     regions (t2r-ring and t2r-shm) plus a GIC SPI edge
>     interrupt for TEE-to-REE notifications.
>   - RISC-V (IMSIC): three reserved-memory regions, adding
>     r2t-ring for REE-to-TEE command submissions; no
>     interrupts property (T2R notifications use IMSIC MSI
>     allocated at runtime).
> 
> Signed-off-by: Xing Loong <xing.xl.loong@gmail.com>
> ---
> Changes in v3:
> - Drop all phandle stub nodes from examples.
> - Remove redundant required: - interrupts from then branch.
> - Simplify title and description.
> 
> Changes in v2:
> - Fix DT binding review comments from Krzysztof Kozlowski:
>   - Drop $nodename, "YAML devicetree binding" wording, property descriptions
>   - Rename compatible string to mbedtee,tee
>   - Rename memory regions: rpc-t2r-ring -> t2r-ring, rpc-t2r-shm -> t2r-shm,
>     rpc-r2t-ring -> r2t-ring
>   - Add memory-region / memory-region-names to required
>   - Simplify allOf constraints (drop redundant else-branch items)
>   - Rewrite description to describe hardware/firmware, not the binding or driver
>   - Drop all irrelevant platform nodes (gic, cpus, reserved-memory)
>   - Add maxItems: 1 constraint to interrupts property (Sashiko AI review)
> 
> ---
> 
>  .../bindings/firmware/mbedtee,tee.yaml        | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/mbedtee,tee.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/mbedtee,tee.yaml b/Documentation/devicetree/bindings/firmware/mbedtee,tee.yaml
> new file mode 100644
> index 0000000..a8f1201
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/mbedtee,tee.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/mbedtee,tee.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MbedTEE
> +
> +maintainers:
> +  - Xing Loong <xing.xl.loong@gmail.com>
> +
> +description: |
> +  MbedTEE is a Trusted Execution Environment for embedded systems.
> +  It communicates with the REE (Linux) via shared-memory ring
> +  buffers using a fixed RPC protocol.
> +
> +  We're using "mbedtee" as the vendor prefix for the open-source TEE
> +  project at https://github.com/mbedtee.
> +
> +  The REE and TEE CPUs sharing the RPC memory must be in a
> +  hardware-coherent domain.
> +
> +  Two or three reserved-memory regions are required:
> +    t2r-ring: ring buffer for TEE-to-REE notifications
> +    t2r-shm:  shared memory for TEE-to-REE RPC payloads
> +    r2t-ring: ring buffer for REE-to-TEE command submissions (RISC-V)

Put any details about specific properties with the property schema.

> +
> +  On ARM the transport uses SMC and a GIC SPI interrupt. On RISC-V
> +  the transport uses shared-memory rings and IMSIC MSI; the TEE
> +  polls r2t-ring for commands from the REE.
> +
> +properties:
> +  compatible:
> +    const: mbedtee,tee
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  msi-parent:
> +    maxItems: 1
> +
> +  memory-region:
> +    minItems: 2
> +    maxItems: 3
> +
> +  memory-region-names:
> +    minItems: 2
> +    maxItems: 3
> +    items:
> +      enum:
> +        - t2r-ring
> +        - t2r-shm
> +        - r2t-ring

Needs to define the order as sashiko points out. The order doesn't 
change, so it doesn't need to be defined in the if/then schemas.

> +
> +required:
> +  - compatible
> +  - memory-region
> +  - memory-region-names
> +
> +allOf:
> +  - if:
> +      required:
> +        - interrupts
> +    then:
> +      properties:
> +        msi-parent: false
> +        memory-region:
> +          maxItems: 2
> +        memory-region-names:
> +          items:
> +            - const: t2r-ring
> +            - const: t2r-shm

Just 'maxItems: 2'

> +    else:
> +      required:
> +        - msi-parent
> +      properties:
> +        interrupts: false
> +        memory-region:
> +          minItems: 3
> +        memory-region-names:
> +          items:
> +            - const: t2r-ring
> +            - const: t2r-shm
> +            - const: r2t-ring

Just 'minItems: 3'

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    firmware {
> +        mbedtee {
> +            compatible = "mbedtee,tee";
> +            interrupts = <GIC_SPI 72 IRQ_TYPE_EDGE_RISING>;
> +            memory-region = <&t2r_ring>, <&t2r_shm>;
> +            memory-region-names = "t2r-ring", "t2r-shm";
> +        };
> +    };
> +
> +  - |
> +    firmware {
> +        mbedtee {
> +            compatible = "mbedtee,tee";
> +            msi-parent = <&imsic>;
> +            memory-region = <&t2r_ring>, <&t2r_shm>, <&r2t_ring>;
> +            memory-region-names = "t2r-ring", "t2r-shm", "r2t-ring";
> +        };
> +    };
> -- 
> 2.43.0
> 
