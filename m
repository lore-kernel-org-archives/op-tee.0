Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F8AD3B7E5
	for <op-tee@archiver.kernel.org>; Mon, 29 Dec 2025 05:39:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6E6244184A
	for <op-tee@archiver.kernel.org>; Mon, 29 Dec 2025 05:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1766986796;
	bh=hUD0ESZR0fiGX+5i+A4WD58O6b8Rleo0ARVfBQND1fg=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Vyr2lXDBYlwk8wWBvn/dhMOuS+OeIIil91331tgL3gC9UgNA+Algz4/8+Ck6CKOfY
	 EwQoqEzsKzszLO96/goh2dC/W98A78jENVHGj3Ebjmpvh3CLUcLXpe2dOJKapgD6zZ
	 2/ilA4RmKsQ2qfM1boNWTsGsypdEbq0KGS0OpeFcIBuxqEbCs7BkA/fntsw+rIjbLa
	 MOyUzLjq3siJchBmpOFee8fVLyn5FRCqN8QlxvudB+yP9IWSwVpm2ajnIt1onmV6fZ
	 qhI5sWEjASq0cIGtff0dU8LpWj6rSXQLwsBGzcujKezlFSsjj8oztM6+u4h906KL3l
	 pWg/1LFMlEOXg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DB3884184A
	for <op-tee@lists.trustedfirmware.org>; Mon, 29 Dec 2025 05:39:38 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=crfK7hGE;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 188D743B25;
	Mon, 29 Dec 2025 05:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B43C4CEF7;
	Mon, 29 Dec 2025 05:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766986778;
	bh=hUD0ESZR0fiGX+5i+A4WD58O6b8Rleo0ARVfBQND1fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=crfK7hGEKJQd+jZ/mzVVllUGC53q1JtiM6l0nfgK0VmZ+jHGITOazGfxXJsgGjzhk
	 w+SOgDsDiiDVFhcjFx1MwfiTWZ4iCOnfJ5EpkBzLLWt/b9jfx4VxULNYVllvN1APN4
	 uP9z7nLzBszdSpkTIk2HnRHyVqAYtM/5D1uVgjcTZIEUeFCGzWV1E/CK4ZZsoYLvVJ
	 Pdx7fX6aZsz1Wh0NTY94/o1DY+6Z7T2Yu3GA8BDwQ7eCMrdCy6OkzGQbPbZsxhT/rF
	 9SDLMgTzaZnjdXrCdRo8HKNS0FEwwW2jwb2iPYJjAPtXUv/IMpJLD4dKLvBVPFr6gi
	 MQpYWX6j4BHyg==
Date: Mon, 29 Dec 2025 11:09:29 +0530
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: Re: [PATCH v20 1/6] dt-bindings: firmware: Add TEE remoteproc
 service binding
Message-ID: <aVIUEafDoVQv0rHf@sumit-xelite>
References: <20251217153917.3998544-1-arnaud.pouliquen@foss.st.com>
 <20251217153917.3998544-2-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217153917.3998544-2-arnaud.pouliquen@foss.st.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.95 / 15.00];
	BAYES_HAM(-2.95)[99.79%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	TAGGED_RCPT(0.00)[dt];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DB3884184A
X-Spamd-Bar: --
Message-ID-Hash: NDKXCI4ND76P5MX3LE2J7DUCILT3BF5B
X-Message-ID-Hash: NDKXCI4ND76P5MX3LE2J7DUCILT3BF5B
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NDKXCI4ND76P5MX3LE2J7DUCILT3BF5B/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Wed, Dec 17, 2025 at 04:39:12PM +0100, Arnaud Pouliquen wrote:
> Add a device tree binding for the TEE-based remote processor control
> service implemented as an OP-TEE Trusted Application identified by
> UUID 80a4c275-0a47-4905-8285-1486a9771a08.
> 
> The TEE service node is a child of the "linaro,optee-tz" firmware node and
> acts as a container for remoteproc devices that are controlled via TEE.
> 
> In addition, the "linaro,optee-tz" binding is updated to specify the
> '#address-cells' and '#size-cells' values used for child TEE service
> nodes.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  .../arm/firmware/linaro,optee-tz.yaml         |  6 +++
>  .../bindings/remoteproc/remoteproc-tee.yaml   | 47 +++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/remoteproc-tee.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> index 5d033570b57b..ab69eecba9ad 100644
> --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> @@ -41,6 +41,12 @@ properties:
>        HVC #0, register assignments
>        register assignments are specified in drivers/tee/optee/optee_smc.h
>  
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
>  required:
>    - compatible
>    - method
> diff --git a/Documentation/devicetree/bindings/remoteproc/remoteproc-tee.yaml b/Documentation/devicetree/bindings/remoteproc/remoteproc-tee.yaml
> new file mode 100644
> index 000000000000..083ecf1f38cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/remoteproc-tee.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/remoteproc-tee.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TEE Remote Processor Control Service (UUID 80a4c275-0a47-4905-8285-1486a9771a08)
> +
> +maintainers:
> +  - Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> +
> +description: |
> +  Node describing a TEE-based remote processor control service implemented as
> +  a Trusted Application identified by UUID 80a4c275-0a47-4905-8285-1486a9771a08.
> +
> +  It is a child of the OP-TEE firmware node ("linaro,optee-tz") and acts as a
> +  container for child remoteproc devices (for example, the STM32MP15 M4 core
> +  described by "st,stm32mp1-tee").
> +
> +properties:
> +  compatible:
> +    const: rproc-service-80a4c275-0a47-4905-8285-1486a9771a08

This should just be "80a4c275-0a47-4905-8285-1486a9771a08" which is the
device/service identity on TEE bus.

-Sumit

> +
> +  reg:
> +    description: |
> +      Logical identifier of the TEE remoteproc service instance.
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^[a-zA-Z0-9,._-]+@[0-9a-fA-F]+$":
> +    type: object
> +
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +...
> -- 
> 2.43.0
> 
