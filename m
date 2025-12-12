Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26329D41D74
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 01:39:36 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5FA4F4618B
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 01:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765503575;
	bh=Rz6mYmYPM3LGI9FUI2Vag1OS+r7/wF5Tfx278FfBGoQ=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=YxWo0XR5Gmd5gDsBfEPqmyl9CUuRncUG3oddGDSUfVKY7/KMubuACwqfUug7WUxwA
	 9RgiHaj+NluYhahgG2OimnJiPS1w4xgg1/I7U6lT4pp7qYV0hV15L03gOD7gBRzL0D
	 8lfwHPR+zPZMEBKlvO+HiuotmaJ2b2SYh3Aj+aUAAY2IX8OjJLqhIS9TWW1pFScRHQ
	 8aZiMwOsDnschYuAPu4GHfUWe85BBw2ZEo9u5BzQC5usOQvhWecgEuPxGfcRb4dZsO
	 XGswHwKwgQ8BhEQecvajUEreB7iodkinIxWlcEUmJiK+r/f3pGljJpi91h+ZDypCIr
	 dMgyHHVKSNF5A==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 456C24322B
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Dec 2025 01:39:24 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ik7jLDgq;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8648F40916;
	Fri, 12 Dec 2025 01:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8293C4CEF7;
	Fri, 12 Dec 2025 01:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765503563;
	bh=Rz6mYmYPM3LGI9FUI2Vag1OS+r7/wF5Tfx278FfBGoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ik7jLDgq1VVyn2fCkoUruaqw1b1UgMIgImPl2aH8THpUnU1sf79hJTI1zErWYLQ71
	 iuowr7jD0qAq4JcPCCNdR4UpjAJH1pf8sAbE7/F/zHsc8eWdkHDZAa9/LfbreX4Kz1
	 CMDqALV67oASBiZMW2tFdI8ve4QmnC+0/CHoY4QRUILF+wwRfUtdXX9eiPLOTpgl7W
	 Zx1GBEqOLaYrJtbhsmpAzkCqGD8EBWJOUtqNsG5QxHsFUR0txjFFm1hvKH7U4puYYN
	 28lpzLLsE9U7d0/Qg0Px7KdMDXL1ySqGQr21VkHsYdkVWBtV7OLefeV1PU9O7mgVL6
	 /ZkMcHtb+nagQ==
Date: Fri, 12 Dec 2025 10:39:19 +0900
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] tee: qcomtee: call: Fix confusing cleanup.h syntax
Message-ID: <aTtyR5J3AqXoE7to@sumit-X1>
References: <20251208020844.5310-4-krzysztof.kozlowski@oss.qualcomm.com>
 <aTtn-x0hh18V7n7J@sumit-X1>
 <b29c97cd-cade-40ef-8e6d-d164b1d16059@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b29c97cd-cade-40ef-8e6d-d164b1d16059@oss.qualcomm.com>
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[172.234.252.31:server fail];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 456C24322B
Message-ID-Hash: 5DCZLCRPK2XVO4MYHWDQPMD4WXRHUPUN
X-Message-ID-Hash: 5DCZLCRPK2XVO4MYHWDQPMD4WXRHUPUN
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5DCZLCRPK2XVO4MYHWDQPMD4WXRHUPUN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Fri, Dec 12, 2025 at 02:07:40AM +0100, Krzysztof Kozlowski wrote:
> On 12/12/2025 01:55, Sumit Garg wrote:
> > On Mon, Dec 08, 2025 at 03:08:45AM +0100, Krzysztof Kozlowski wrote:
> >> Initializing automatic __free variables to NULL without need (e.g.
> >> branches with different allocations), followed by actual allocation is
> >> in contrary to explicit coding rules guiding cleanup.h:
> >>
> >> "Given that the "__free(...) = NULL" pattern for variables defined at
> >> the top of the function poses this potential interdependency problem the
> >> recommendation is to always define and assign variables in one statement
> >> and not group variable definitions at the top of the function when
> >> __free() is used."
> >>
> >> Code does not have a bug, but is less readable and uses discouraged
> >> coding practice, so fix that by moving declaration to the place of
> >> assignment.
> > 
> > Okay I see but..
> > 
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> >> ---
> >>  drivers/tee/qcomtee/call.c | 17 ++++++++---------
> >>  1 file changed, 8 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> >> index 65f9140d4e1f..8f8830f0df26 100644
> >> --- a/drivers/tee/qcomtee/call.c
> >> +++ b/drivers/tee/qcomtee/call.c
> >> @@ -395,9 +395,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
> >>  				 struct tee_ioctl_object_invoke_arg *arg,
> >>  				 struct tee_param *params)
> >>  {
> >> -	struct qcomtee_object_invoke_ctx *oic __free(kfree) = NULL;
> >>  	struct qcomtee_context_data *ctxdata = ctx->data;
> >> -	struct qcomtee_arg *u __free(kfree) = NULL;
> >>  	struct qcomtee_object *object;
> >>  	int i, ret, result;
> >>  
> >> @@ -412,12 +410,14 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
> >>  	}
> >>  
> >>  	/* Otherwise, invoke a QTEE object: */
> >> -	oic = qcomtee_object_invoke_ctx_alloc(ctx);
> >> +	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
> >> +		qcomtee_object_invoke_ctx_alloc(ctx);
> >>  	if (!oic)
> >>  		return -ENOMEM;
> >>  
> >>  	/* +1 for ending QCOMTEE_ARG_TYPE_INV. */
> >> -	u = kcalloc(arg->num_params + 1, sizeof(*u), GFP_KERNEL);
> >> +	struct qcomtee_arg *u __free(kfree) = kcalloc(arg->num_params + 1, sizeof(*u),
> >> +						      GFP_KERNEL);
> > 
> > ..this makes the code less readable with variable declarations floating
> 
> Which is intentional.
> 
> > within the function. I would rather favor to not use the cleanup.h construct
> > but use explicit kfree() invocations instead like it's done in all other
> > allocations in the TEE subsystem.
> 
> Sure, fair. I just don't get why introducing cleanup.h without actually
> accepting its explicitly documented style...
> 

TBH, it is likely overlooked during review of the QTEE driver. Having a
builtin warning for the undesired syntax would help the reviewers here.

-Sumit
