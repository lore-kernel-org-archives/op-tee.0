Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4CECAC599
	for <op-tee@archiver.kernel.org>; Tue, 16 Sep 2025 09:15:18 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C89FB41846
	for <op-tee@archiver.kernel.org>; Tue, 16 Sep 2025 09:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1758014117;
	bh=lWa38QWpQKBheh2+8pa3IIFdfHdW+eC2aXKWV7xfz+E=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ii0GX6pQHByzsZngRKK1q4N6mfzVL9fYdQWFTreBeL9T9PzFKo42KpJiByFE3sH0V
	 UIFgMB0NOuBl3UI3APKxrqy2crslAgHIy+RT1Yr5M/RnTFxSaOAb5QT34sfSRot0tm
	 C5PA28EiLwGIP+MgD7kPNpoOQ6f+fOXj/Sguc+4WY5vd/SCzrpnFl0c0+RzYB5tnLF
	 iO0IdxWwZoJqN17dvp6JIlqAnq6rj9aXmIc/IACNCXFDL1uC+uKRQJAqoDDD7QWCvg
	 c11VpGRfKYFyGJj0TUX88cmcfuuSGFbcgmE1eD7NkD11h22M3pVboN7mNH0fXnoRu2
	 vgJ/hRvD7TldA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6AD9740AEB
	for <op-tee@lists.trustedfirmware.org>; Tue, 16 Sep 2025 09:14:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N0zirtnh;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AC4E9438F4;
	Tue, 16 Sep 2025 09:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F39C4CEFD;
	Tue, 16 Sep 2025 09:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758014097;
	bh=lWa38QWpQKBheh2+8pa3IIFdfHdW+eC2aXKWV7xfz+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0zirtnhTBVOiXpUexGzhnv1iQ/q+CWOJgJKWTOLGOASvxhhj+Bv9NubaV4y7JaJS
	 MqdEdfBJoIVu4GFO2aiejrWspeBeSfhQwZvUpmVzro5c1Mo1o/AGAcZR2vkamUUWrT
	 pjKKrSIuE9Lw8jBBE+OrQ4otNtlpyRUDF8JzNqjz7EjBiKLg1DsGjYfWiTeiPR4UsP
	 plbwEvzdOEvN98EGCUvGXetxDz6fb2UrOIe02rLnfkdIfoB5986CWiDP6gx6Y5EbQZ
	 PHqGcVEOmfwzgaPxgDcr2mc+W0sdCrbzVItMt4HvYo/va3p7gP1iOtYCX3oX4EUOPJ
	 EsCIF/J2p7MFg==
Date: Tue, 16 Sep 2025 14:44:49 +0530
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: Re: [PATCH v19 4/6] dt-bindings: remoteproc: Add compatibility for
 TEE support
Message-ID: <aMkqifHSdlCs4VjA@sumit-X1>
References: <20250625094028.758016-1-arnaud.pouliquen@foss.st.com>
 <20250625094028.758016-5-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625094028.758016-5-arnaud.pouliquen@foss.st.com>
X-Rspamd-Queue-Id: 6AD9740AEB
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: WKNCUS4W5VKWD2AL4CXY6VC3LCFLLX77
X-Message-ID-Hash: WKNCUS4W5VKWD2AL4CXY6VC3LCFLLX77
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WKNCUS4W5VKWD2AL4CXY6VC3LCFLLX77/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

Hi Arnaud,

First of all apologies for such a late review comment as previously I
wasn't CCed or involved in the review of this patch-set. In case any of
my following comments have been discussed in the past then feel free to
point me at relevant discussions.

On Wed, Jun 25, 2025 at 11:40:26AM +0200, Arnaud Pouliquen wrote:
> The "st,stm32mp1-m4-tee" compatible is utilized in a system configuration
> where the Cortex-M4 firmware is loaded by the Trusted Execution Environment
> (TEE).

Having a DT based compatible for a TEE service to me just feels like it
is redundant here. I can see you have also used a TEE bus based device
too but that is not being properly used. I know subsystems like
remoteproc, SCMI and others heavily rely on DT to hardcode properties of
system firmware which are rather better to be discovered dynamically.

So I have an open question for you and the remoteproc subsystem
maintainers being:

Is it feasible to rather leverage the benefits of a fully discoverable
TEE bus rather than relying on platform bus/ DT to hardcode firmware
properties?

> 
> For instance, this compatible is used in both the Linux and OP-TEE device
> trees:
> - In OP-TEE, a node is defined in the device tree with the
>   "st,stm32mp1-m4-tee" compatible to support signed remoteproc firmware.
>   Based on DT properties, the OP-TEE remoteproc framework is initiated to
>   expose a trusted application service to authenticate and load the remote
>   processor firmware provided by the Linux remoteproc framework, as well
>   as to start and stop the remote processor.
> - In Linux, when the compatibility is set, the Cortex-M resets should not
>   be declared in the device tree. In such a configuration, the reset is
>   managed by the OP-TEE remoteproc driver and is no longer accessible from
>   the Linux kernel.
> 
> Associated with this new compatible, add the "st,proc-id" property to
> identify the remote processor. This ID is used to define a unique ID,
> common between Linux, U-Boot, and OP-TEE, to identify a coprocessor.

This "st,proc-id" is just one such property which can rather be directly
probed from the TEE/OP-TEE service rather than hardcoding it in DT here.
I think the same will apply to other properties as well.

-Sumit

> This ID will be used in requests to the OP-TEE remoteproc Trusted
> Application to specify the remote processor.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 58 ++++++++++++++++---
>  1 file changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> index 843679c557e7..58da07e536fc 100644
> --- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> @@ -16,7 +16,12 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: st,stm32mp1-m4
> +    enum:
> +      - st,stm32mp1-m4
> +      - st,stm32mp1-m4-tee
> +    description:
> +      Use "st,stm32mp1-m4" for the Cortex-M4 coprocessor management by non-secure context
> +      Use "st,stm32mp1-m4-tee" for the Cortex-M4 coprocessor management by secure context
>  
>    reg:
>      description:
> @@ -43,6 +48,10 @@ properties:
>            - description: The offset of the hold boot setting register
>            - description: The field mask of the hold boot
>  
> +  st,proc-id:
> +    description: remote processor identifier
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
>    st,syscfg-tz:
>      deprecated: true
>      description:
> @@ -146,21 +155,43 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - resets
>  
>  allOf:
>    - if:
>        properties:
> -        reset-names:
> -          not:
> -            contains:
> -              const: hold_boot
> +        compatible:
> +          contains:
> +            const: st,stm32mp1-m4
>      then:
> +      if:
> +        properties:
> +          reset-names:
> +            not:
> +              contains:
> +                const: hold_boot
> +      then:
> +        required:
> +          - st,syscfg-holdboot
> +      else:
> +        properties:
> +          st,syscfg-holdboot: false
> +        required:
> +          - reset-names
>        required:
> -        - st,syscfg-holdboot
> -    else:
> +        - resets
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: st,stm32mp1-m4-tee
> +    then:
>        properties:
>          st,syscfg-holdboot: false
> +        reset-names: false
> +        resets: false
> +      required:
> +        - st,proc-id
>  
>  additionalProperties: false
>  
> @@ -192,5 +223,16 @@ examples:
>        st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
>        st,syscfg-m4-state = <&tamp 0x148 0xFFFFFFFF>;
>      };
> +  - |
> +    #include <dt-bindings/reset/stm32mp1-resets.h>
> +    m4@10000000 {
> +      compatible = "st,stm32mp1-m4-tee";
> +      reg = <0x10000000 0x40000>,
> +            <0x30000000 0x40000>,
> +            <0x38000000 0x10000>;
> +      st,proc-id = <0>;
> +      st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
> +      st,syscfg-m4-state = <&tamp 0x148 0xFFFFFFFF>;
> +    };
>  
>  ...
> -- 
> 2.25.1
> 
> 
