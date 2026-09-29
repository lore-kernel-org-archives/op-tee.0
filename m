Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED6ACA5FA1
	for <op-tee@archiver.kernel.org>; Tue, 29 Sep 2026 11:33:24 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 463C44546B
	for <op-tee@archiver.kernel.org>; Tue, 29 Sep 2026 11:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790681603;
	bh=o38NYq67pIHj95OIB/9M83EPfFgbWcUBjFoKcWAFszQ=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=pQq79Q36qXmPa6NvFoHv6a+79F7cm+cZoALyYedtbH3JCWjmwS+oRAgfgadd0tU8E
	 iMk3uhEs8ElXAPjvfVsbVqdAKJQ5OOzxuXJ2cw7DVW57XPMChFD4lS6j6aK3k6oxgQ
	 XXemfZacnv3qkjCKJlDqR1rZrvZ8gJJX/ZbE1zfaFlvkXIRH+UkqbrG42G5oWenZe6
	 +UXgGlkU1HQmycPZw0jLUNHIEXIw2IQpHqA8aRxsuRAqkWQbFxRT9LDHKAi0ViRZcj
	 PTeNWNEqXkJX6+eNgiNHEGliO3Tq8WxeooSS7/AIgtebnxefFUQ5CUJGdagPC0j1VU
	 scmSlgQNrapbA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1122444A39
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 11:33:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDfq3ESV;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5955860008;
	Tue, 29 Sep 2026 11:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998C31F000FF;
	Tue, 29 Sep 2026 11:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790681595;
	bh=e+gknYVW9XCp81xeC0RXx9vcOUHAJigZEtqY/xe8b6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eDfq3ESVa10xLkpSv+CeI5FF1JUQktUhny83NdvHPN+F/Gsl0SORQ8nYLanhlRObL
	 3rtdxQBVjPAYI6hiVUnHd2NqzqZjFK+DdiO30XeURd23enxO2BENrhbozvNTo5RMYo
	 MYRqeYSyedXYG4xB4W19ElcDnoU1dp5FvngYHL6+vLcL7hF3RwBnN7qcbNHBTDS8zJ
	 G4jFmbmUNbbCax96iFWSepuDD2HCv4SUjvmjwVLpy5ix5REIGjVm+psvkgOeJbOSOT
	 dtC2VTT9NqBZqFMgmDJbtzbdP8r2tD9CXrS2Vf0OI6pkF21ISs5ROETw/aW89lfLlc
	 xH4NbBNe8Tgjg==
Date: Tue, 29 Sep 2026 12:33:07 +0100
To: sumit.garg@kernel.org
Subject: Re: [PATCH v2 0/8] arm64: Unmap FF-A lent memory from direct map
Message-ID: <aruh86rd5FMv2i9G@willie-the-truck>
References: <20260921110050.3977591-1-vdonnefort@google.com>
 <arIYtjmSKCs14SqO@sumit-xelite>
 <arKW_91EeKA-w96m@willie-the-truck>
 <are21BjeS1O3RYE3@sumit-xelite>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <are21BjeS1O3RYE3@sumit-xelite>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.50 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from,100.103.45.18:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1122444A39
X-Spamd-Bar: ------
Message-ID-Hash: VUAF7HL3CI4TFXJFJQAW7BXBWGLG5WXU
X-Message-ID-Hash: VUAF7HL3CI4TFXJFJQAW7BXBWGLG5WXU
X-MailFrom: will@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: brendan.jackman@linux.dev, Vincent Donnefort <vdonnefort@google.com>, catalin.marinas@arm.com, rppt@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VUAF7HL3CI4TFXJFJQAW7BXBWGLG5WXU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Will Deacon via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Will Deacon <will@kernel.org>

On Sat, Sep 26, 2026 at 05:43:08PM +0530, Sumit Garg wrote:
> Looks like you dropped me from your reply.

Huh, that's weird. If I hit reply-all ('g') in mutt, it moves the entire
CC list to To: and drops you. I suspect the same thing happened to Thierry
when he replied here:

https://lore.kernel.org/all/arJcN60nagFKXj2Q@orome/

I can't figure out why that's happening :/
I manually tried to fix the To: and Cc: lines in this message.

> On Tue, 22 Sep 2026 at 15:55:59 +0100, Will Deacon wrote:
> > I spoke to Brendan at LPC (?) last year but this doesn't really work
> > for arm64 because it relies on being able to unmap arbitrary parts of
> > the linear map, which isn't generally possible unless you force pte-level
> > mappings for everything, which is prohibitive for perf/power.
> 
> As per the cover letter it's about allocating pages that are not present
> in the direct map. This essentially fits the protected DMABufs use-case
> where we don't want any kernel mapping to exist at any time. Bufers
> allocated from protected DMABufs are only meant to be accessed by the
> TEE implementation or HW accelerators like in the secure media pipeline.

That sounds like it should probably build on top of this series, then.
You could allocate the DMABufs from a CMA region that has no linear alias.

> > Vincent's series tackles that by using a pool so that only that part of
> > memory requires the pte-level mappings in the linear map. That's the
> > whole point of it, so I don't think it makes sense to drop it in favour
> > of Brendan's approach (which doesn't work).
> > 
> 
> For protected DMABufs, we even don't require any pte-level mappings in
> linear map. The whole idea of mapping and unmapping is just a bottleneck
> for performance sensitive secure media pipeline use-cases. That's why if
> we can support __GFP_UNMAPPED with the memory allocator on arm64 would
> be the best fit for this use-case.

The point is that you will require pte-level mappings for the linear map
if you want to unmap from it at runtime on arm64. If you don't, then you
can end up needing to split a block mapping (e.g. pmd-level) when you
decide to unmap only part of it and there isn't a safe way to do that on
arm64 without transiently unmapping the entire block, which can lead to
fatal translation faults during that window.

> Now the question is why arm64 can't support __GFP_UNMAPPED similar to
> how Brendan is doing it for x86?

Because arm64 != x86? Presumably x86 doesn't have the strict
break-before-make requirements we have on arm64.

Will
