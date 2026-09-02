Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61DFC624D6
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 17:38:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0AC09451C1
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 17:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788370715;
	bh=K0EZk9cwMfrs7Zwj/Iy4FJfEhquZ9oqf9xx1PPUbS2g=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=LcS2CP1BD0SrcdFlxGIOqePKzYcIYzMKurJUdi6HvC5+crRQIhbkDoTQvHwKjQoqG
	 2g6Wr9asOry6nVI3wIbDZ6oz1wJfeEF81Q54H1c0nRF0tCUMqdIGKh4RB+DwlM69LU
	 /sG52pYy5SqvxKJe0fYBMx+ohiN0mbMxGYeUbQ5Xx9QxozXOYn/Q0wuJ2+tSYjbjwr
	 +7aXsbXRvlcFMikrUYdhUjqytnKowL5kUAkMrilT2xVYhy51TO8w7+MBLai9OQMjsv
	 vTPIHgNnBqdtsdJOdAAeGd0YlbkvNgcRT43s3TkMvh/VwW/0by5zj7Ce5J1bpagGa3
	 IaL3JD1cEuftQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 524AA44F01
	for <op-tee@lists.trustedfirmware.org>; Wed,  2 Sep 2026 17:38:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6Uzr4pq;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9D79040268;
	Wed,  2 Sep 2026 17:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629A91F000E9;
	Wed,  2 Sep 2026 17:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788370707;
	bh=fsI+nhzULsUUSIbVGLobSbdGnJMPqPjlO3ivoC99fNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T6Uzr4pq+Kb+UO4HsQ0X42ZQMwEqrNkLYI01z+d2YhKthM8zctAHyrriDmaHx4SzQ
	 aOqXsOPVcxNp5lj/SPnwfFKiaT7ZtsWIe1KheN4h+Ml8Al4W4oHiTCGKrfaq1Bw+aG
	 /vOTnHhel0XgusHtqAAQ15PacrnKnFeT6PElkPfnrsoAI71YQMp6glvP0d2VtCRYJP
	 Ikv6Em1jxZ8eUs/xdMnZmToKnAemXxHkr13Nwl/ucjDhwipTmwTr0OSYTe8se5zH/i
	 8vow2FHxR4TAQTO0V3RML/oWzxwCcFFeozjODhkhkYxpAXcQ1Ze8iSkxqp49wtEN+c
	 iRzeRHCPdTozg==
Date: Wed, 2 Sep 2026 12:38:26 -0500
To: Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v9 09/10] firmware: arm_ffa: Introduce ffa-lend-pool
Message-ID: <20260902173826.GC1440252-robh@kernel.org>
References: <20260902104712.2399797-1-vdonnefort@google.com>
 <20260902104712.2399797-10-vdonnefort@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902104712.2399797-10-vdonnefort@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 524AA44F01
X-Spamd-Bar: -------
Message-ID-Hash: CWTH23GHAPDBMOEWV4OPQZOW6IGDUPCX
X-Message-ID-Hash: CWTH23GHAPDBMOEWV4OPQZOW6IGDUPCX
X-MailFrom: robh@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CWTH23GHAPDBMOEWV4OPQZOW6IGDUPCX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Rob Herring via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Rob Herring <robh@kernel.org>

On Wed, Sep 02, 2026 at 11:47:11AM +0100, Vincent Donnefort wrote:
> When memory is lent to the Secure world via FF-A, fatal CPU speculative
> reads from Non-Secure can still occur as long as it retains a cacheable
> mapping to that memory. Introduce the "arm,ffa-lend-pool"
> reserved-memory CMA driver to unmap pages before lending
> (ffa_prepare_lend()) and restore them upon reclaim
> (ffa_lend_reclaimed()). Devices bind to the pool via the "memory-region"
> DT property or via ffa_lend_pool_attach().
> 
>   reserved-memory {
>       #address-cells = <0x2>;
>       #size-cells = <0x2>;
>       ranges;
> 
>       ffa_lend: ffa-lend-pool {
>           compatible = "arm,ffa-lend-pool";

Needs a binding schema...

>           reusable;
>           ll-map;
>           size = <0x0 0x4000000>;
>       };
>   };
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

[...]

> +static int __init ffa_lend_pool_setup(unsigned long node, struct reserved_mem *rmem)
> +{
> +	struct cma *cma;
> +	int ret;
> +
> +	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
> +	    of_get_flat_dt_prop(node, "no-map", NULL)) {
> +		pr_err("FF-A lend pool: node must be 'reusable' and not 'no-map'\n");
> +		return -EINVAL;

Your schema should enforce/check this.

[...]

> +static const struct reserved_mem_ops ffa_lend_pool_ops = {
> +	.node_init	= ffa_lend_pool_setup,
> +	.device_init	= ffa_lend_pool_device_init,
> +	.device_release = ffa_lend_pool_device_release,
> +};
> +RESERVEDMEM_OF_DECLARE(ffa_lend_pool, "arm,ffa-lend-pool", &ffa_lend_pool_ops);

Do you need this early? If not, you can create a platform driver for 
"arm,ffa-lend-pool". ramoops is implemented that way for example.

Rob
