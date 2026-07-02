Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE884C43458
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 15:27:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2744D4503D
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 15:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1783006061;
	bh=00nLy8MHONEe2/MDd6GcLVMZbNylKTJzr+Z++oYeX2U=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=oWKriUBlmD++zY7+9kGIepOHllEwoVudV0E+0jdA6rb8Ymn+ppEVBKDkzVXNZsAp8
	 8jJmFMnBf4n+3egyn1jayZzdwBQWShjJ6YcA5oD3/PZr40mlx9zv7EIrErlboMM8+F
	 xna6VW11GtISsMMgM4Kc0rQOnRt5OnhktmgK+pfSoX+2hMROrL04h6JxSSdxsz8rsz
	 JNTW+BVv1jxJsTtdQofjwhns75FS4hp2lmk1/qpjqxAx//C6tRxDI02siEMJXhL02c
	 jGD9BrSy7W5ScinirouYCt3rgkFjyk4+Dg4DhY1v4/16fmq/YVn2t2+N9R/WzOKsOG
	 JCwf5gmRrbxbw==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CE2C644DBB
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Jul 2026 15:27:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzVzO9rx;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1319540374;
	Thu,  2 Jul 2026 15:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543E81F000E9;
	Thu,  2 Jul 2026 15:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783006054;
	bh=cEk3W3lizBUZfsulzFqYmAOYLzNf3b65ISLECKrKSas=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dzVzO9rxa+s+zlk9tebkHcboJ/TilCie+zjXBszJVjzUhbyOW9LnSEPQhUTC4IN5v
	 JzNozJRLVaWij5NqMhTShnnRa/nSszoa2Ijf4gx+o/Dksaclx9MG5jdLAkcFv4ICg9
	 EBnRanjvFSexO2ZkF7UjGqEuePNMUd7CcjZ2EfSvbaWi5/fLYBgGIyi1uQFM1oRGG3
	 i/XIPGNtcD3DBnL9AJebvJ6KW/loqa6KXfqsQm9AEdu4sw5BnzqdVW/xSSTGvr4giI
	 8MqwLt7QSRIHq9lV09czgPadJJAvL1uE7HODeNVKx8j5zb87qcGLbeWTUSVyLApmWi
	 siNRPYnRHCrZQ==
Message-ID: <f5f6aa5f-8c28-43eb-b254-17816f976f19@kernel.org>
Date: Thu, 2 Jul 2026 17:27:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: firmware: add mbedtee,tee binding
To: Xing Loong <xing.xl.loong@gmail.com>, Jens Wiklander <jenswi@kernel.org>
References: <20260701132514.186953-1-xing.xl.loong@gmail.com>
 <20260702151115.544016-1-xing.xl.loong@gmail.com>
 <20260702151115.544016-3-xing.xl.loong@gmail.com>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260702151115.544016-3-xing.xl.loong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.46 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-2.96)[99.83%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[dt];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CE2C644DBB
X-Spamd-Bar: -----
Message-ID-Hash: DVJETOVZB7Z4GCEA4SGLBADHRJXGMF2Q
X-Message-ID-Hash: DVJETOVZB7Z4GCEA4SGLBADHRJXGMF2Q
X-MailFrom: krzk@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DVJETOVZB7Z4GCEA4SGLBADHRJXGMF2Q/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Krzysztof Kozlowski via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Krzysztof Kozlowski <krzk@kernel.org>

On 02/07/2026 17:11, Xing Loong wrote:
> +
> +  On RISC-V the TEE signals the REE via IMSIC MSI; the REE submits
> +  commands via r2t-ring that the TEE polls. No REE-to-TEE interrupt
> +  is used. No SBI ecall is involved.
> +
> +properties:
> +  compatible:
> +    const: mbedtee,tee


No, you need to respond to feedback instead of sending the same code
called v2. You received comments for a reason. Sending v2 now hides all
this comments and people might think discussion is resolved. This is
very bad practice.

Also,
Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets. See also:
https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830

...

> +
> +examples:
> +  - |
> +    /* ARM TrustZone (SMC) */
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    firmware {
> +      mbedtee {
> +        compatible = "mbedtee,tee";
> +        interrupts = <GIC_SPI 72 IRQ_TYPE_EDGE_RISING>;
> +        memory-region = <&mbedtee_t2r_ring>, <&mbedtee_t2r_shm>;
> +        memory-region-names = "t2r-ring", "t2r-shm";
> +      };
> +    };
> +
> +    /* memory-region phandle targets */
> +    mbedtee_t2r_ring: t2r-ring {};
> +    mbedtee_t2r_shm: t2r-shm {};

I asked you to drop all these irrelevant entries.

> +
> +  - |
> +    /* RISC-V IMSIC (ring-buffer polling REE->TEE, MSI TEE->REE) */
> +
> +    firmware {
> +      mbedtee {
> +        compatible = "mbedtee,tee";
> +        msi-parent = <&imsic>;
> +        memory-region = <&rv_t2r_ring>, <&rv_t2r_shm>,
> +                        <&rv_r2t_ring>;
> +        memory-region-names = "t2r-ring", "t2r-shm",
> +                              "r2t-ring";
> +      };
> +    };
> +
> +    /* msi-parent phandle target */
> +    imsic: imsic {
> +      msi-controller;
> +      #msi-cells = <0>;
> +    };

Also drop.

> +
> +    /* memory-region phandle targets */
> +    rv_t2r_ring: t2r-ring {};
> +    rv_t2r_shm: t2r-shm {};
> +    rv_r2t_ring: r2t-ring {};

Also not relevant.

I will not continue the review. Please go back to v1 and continue the
discussion.

I consider this version NAKed.


Best regards,
Krzysztof
