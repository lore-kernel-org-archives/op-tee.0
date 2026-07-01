Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67569C43458
	for <op-tee@archiver.kernel.org>; Wed,  1 Jul 2026 16:39:46 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8B7B445040
	for <op-tee@archiver.kernel.org>; Wed,  1 Jul 2026 16:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782923985;
	bh=gLQxvbQOOLcY/4e+Bw2EjCkQkfwPZzWVFEDv9j/iY/k=;
	h=Date:To:In-Reply-To:References:Subject:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=3TWsZhDm1I5nNYDYpxEFT46lH79+S6QUE5jwLpTCmPVzSY7qpsjM5hP+jYd+d4AVS
	 x9AtHd8cpbODZ/N6V0UEHsd/1WfxdgHNMHYMcMe+8hTK3FP/GoArCiska/xSuokh83
	 iSN09zgH/gVL7z1LgcpasT/fCLSfWCgcxHIh3yzXVStaiCRmFjxJolsgIcTfbDAchO
	 UNRrog/mv8v4y6zGpVwdx+5tg11/eoUN1yyIzYxO6jFUg+yoaAIi2o+o3NrqcnlR3t
	 rKSZVXJMa38D5HoG26tx7HT9gjOjrQtKBJ3PBESS9DZAuUSQSI1wFWUkSJPU6Jp4Yd
	 YPFVLVP9E7yzQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8EF2644E2F
	for <op-tee@lists.trustedfirmware.org>; Wed,  1 Jul 2026 16:39:39 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TOTlHssS;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1895F6001D;
	Wed,  1 Jul 2026 16:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA6B1F000E9;
	Wed,  1 Jul 2026 16:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782923978;
	bh=i2S2b9gwlzlrq71xUZnAbbsrQZGU2konPvu0kspaKrc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=TOTlHssS4K3aSspdhrVxeLftNotWdK7iHpbdaKmIjM4RlIP1tQpKAnW8SMm6VCRat
	 /39KMMz3+qgUW5Naj0+z7EEn2VMW7tj4PGoQW44+mu/3BS6defuPfg0W5coObmn/WU
	 AcF1n9KzA0Hh3hEUNDIjrdVU5sm0pegEydrZsMFQl2gRLji8CiW3poGMOtDItqDytl
	 mUMq3BfN/jtR1F3yM4y/+Nakjjewv7zf3/Y+OU+eWvLkQXAnuXm/4XxVbUz1D7B9DK
	 coxemdeSqIbktji1xhEiS38VZ8Am6tF49pdaGEb8EIqqpYPs3TCAhXNf8YLCiz+/TI
	 om/TA0lzfDh9g==
Date: Wed, 01 Jul 2026 11:39:37 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: Xing Loong <xing.xl.loong@gmail.com>
In-Reply-To: <20260701132514.186953-3-xing.xl.loong@gmail.com>
References: <20260701132514.186953-1-xing.xl.loong@gmail.com>
 <20260701132514.186953-3-xing.xl.loong@gmail.com>
Message-Id: <178292397672.969186.6837238120896509616.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: firmware: add mbedtee,rpc binding
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.14 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-2.64)[98.41%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8EF2644E2F
X-Spamd-Bar: ------
Message-ID-Hash: 44JZ7IDNIZVCKIBED5KIQ52IDUEWAYSQ
X-Message-ID-Hash: 44JZ7IDNIZVCKIBED5KIQ52IDUEWAYSQ
X-MailFrom: robh@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, op-tee@lists.trustedfirmware.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org, Sumit Garg <sumit.garg@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/44JZ7IDNIZVCKIBED5KIQ52IDUEWAYSQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: "Rob Herring (Arm) via OP-TEE" <op-tee@lists.trustedfirmware.org>
Reply-To: "Rob Herring (Arm)" <robh@kernel.org>


On Wed, 01 Jul 2026 21:25:13 +0800, Xing Loong wrote:
> Add YAML devicetree binding for the MbedTEE Trusted Execution
> Environment driver.
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

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/firmware/mbedtee,rpc.example.dtb: /: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/firmware/mbedtee,rpc.example.dtb: /: 'model' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260701132514.186953-3-xing.xl.loong@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

