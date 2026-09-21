Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689A9C982E6
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 15:21:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7B919451CA
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 15:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790004068;
	bh=YGYSZXZAOKyI+SQaZzhWKnu+5MVOSTM6FqMOOPMWjOI=;
	h=Date:To:In-Reply-To:References:Subject:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=mrpkPRUSnud9NGHbAQZSkNnrBQ+gLqP+NrUpFtf9sFdntccwlNqva4rEZJtFaM3YS
	 iyU2iiUhsJ707cVfwaq/Fj3RGNTzn8uZj4aBFQLWkzMtoLcjBEYdy/H0Vp0gXgH9NQ
	 oBBeu320l2+uX8rkWi3dSwWhE/sHZFN/0JRkVgWeF6T1Lkmb7eajl/toIN21D5P+o4
	 d2LwDAQ1tgiMk/1gSnCWMmB18i603MZrJj8fZc4LWVTBZdQZJ73mc4RYOi3Hvy88Xp
	 aqusaorhec4p0ZDE81vXTy5SbfAlw85gHe6zu1OlN8yH4GuH3FbHc19ZwdJhfjgxKf
	 Sw7bJgMNHZzdA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 664B744F6B
	for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 15:21:01 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBxIhJsP;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C047E40F3E;
	Mon, 21 Sep 2026 15:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BD81F000FF;
	Mon, 21 Sep 2026 15:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790004060;
	bh=sYN6gB7Ijq5F3mQPt8j/w5U9BHlrr8gpwOqMcp1ScAg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=OBxIhJsPI6FsskimLCHHwrb8YKf6UPRxsiFCq59DToJg9t5AnuMw/QWSc+aBld6qV
	 NB3NNeRcUt3wKYVht8mQrwSIZ7/mOEejWEpr1fF/Dwd3BpiED8bv/PAPMsLaXsNGJl
	 q2NGUlDPTERSUs4uxPzUsiSo/mS/VKDXMhwjsqHr7hWE48gYYswEiAI8J5HyCcHPA0
	 EPSKVPrlwvmniMaY3C8eAC48YqmZNW9dFf1Lrsc/M2n4fFGXj3kV2L62rgB4CPVW//
	 4lFlmRyZkfTB24GFesazvM4qSuSQ8ITvwJTIy8phGp6Q5YPcDWnSUIR3Tfkim3WJvW
	 aGFFPbZg+71jA==
Date: Mon, 21 Sep 2026 10:20:58 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: Vincent Donnefort <vdonnefort@google.com>
In-Reply-To: <20260921110050.3977591-8-vdonnefort@google.com>
References: <20260921110050.3977591-1-vdonnefort@google.com>
 <20260921110050.3977591-8-vdonnefort@google.com>
Message-Id: <179000402021.412547.18161897733601725746.robh@kernel.org>
Subject: Re: [PATCH v2 7/8] dt-bindings: reserved-memory: Add Arm FF-A lend
 pool
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.91 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-2.91)[99.60%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 664B744F6B
X-Spamd-Bar: -------
Message-ID-Hash: KQYAUGL4AXQJDDPC6Y5F5GO4KWOI5AJP
X-Message-ID-Hash: KQYAUGL4AXQJDDPC6Y5F5GO4KWOI5AJP
X-MailFrom: robh@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: sumit.garg@kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, sudeep.holla@kernel.org, thierry.reding@kernel.org, david@kernel.org, rppt@kernel.org, jenswi@kernel.org, linux-mm@kvack.org, danielmentz@google.com, catalin.marinas@arm.com, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, will@kernel.org, ardb@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KQYAUGL4AXQJDDPC6Y5F5GO4KWOI5AJP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: "Rob Herring (Arm) via OP-TEE" <op-tee@lists.trustedfirmware.org>
Reply-To: "Rob Herring (Arm)" <robh@kernel.org>


On Mon, 21 Sep 2026 12:00:49 +0100, Vincent Donnefort wrote:
> Add bindings for the "arm,ffa-lend-pool" reserved-memory CMA pool.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> ---
>  .../reserved-memory/arm,ffa-lend-pool.yaml    | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/arm,ffa-lend-pool.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/reserved-memory/arm,ffa-lend-pool.example.dtb: ffa-lend-pool (arm,ffa-lend-pool): {'compatible': ['arm,ffa-lend-pool'], 'reusable': True, 'size': 67108864, '$nodename': ['ffa-lend-pool']} is valid under each of {'if': {'required': ['iommu-addresses']}, 'then': {'required': ['reg']}}, {'required': ['size']}
	from schema $id: http://devicetree.org/schemas/reserved-memory/arm,ffa-lend-pool.yaml
Documentation/devicetree/bindings/reserved-memory/arm,ffa-lend-pool.example.dtb: ffa-lend-pool (arm,ffa-lend-pool): Unevaluated properties are not allowed ('reusable', 'size' were unexpected)
	from schema $id: http://devicetree.org/schemas/reserved-memory/arm,ffa-lend-pool.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260921110050.3977591-8-vdonnefort@google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

