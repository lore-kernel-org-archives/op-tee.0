Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE92CA5FCC
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 12:34:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5AAA64538B
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 12:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790858064;
	bh=QVF2nURRP7xz9O0Kq+Vq/PtyCz1+E71O3hLTPrAnM60=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Ujs0d15UkHBv53+e693yyxetAJGSnhBNwjwH5Zs41GMhosUVKOb0lUs5s0JgEye6X
	 eVe/CQck+jb6eSPJeHhB7GgYGuDfTmS/CkOEcTD4rsjLhoNOkza4evh0wSDu8ws891
	 TWiLmWHPuFnSk6THLdNGBputZavYHRp4voOjLNGBjGL5/4NOdcKraGnyzYVl88FRo8
	 USqRmO2pMTqQL492oxll5ZwAFDbt0HJ4gZeIg7CJEpQYJad1C5ZlLxGBeXFdqAaJkV
	 UUytAkxSjlqrQEe3NwMMg/Yq9ZEySNOP8hErWTi2D5UvRd520Bu9uJAVlGbmAREvQI
	 BBz80PjA19Z2g==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 939CF43716
	for <op-tee@lists.trustedfirmware.org>; Thu,  1 Oct 2026 12:34:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=if4SvAJ1;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E3DEA401C2;
	Thu,  1 Oct 2026 12:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FD81F00898;
	Thu,  1 Oct 2026 12:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790858055;
	bh=PzSvFLGXXhDhvscc/9MFlHIrUkWd1NO5NFV4BtnVy4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=if4SvAJ18eHheJNDIHcxsy7TV/obUhX+e28ofec1ugv6Qzf1xWPauEKNX2d5q4tTp
	 lqIuMR+qdhIvYgLNPo+Xu71RRG2jvwkgCBw9d0spl9LBDZYsQtwcfML4ZVgiSM96eu
	 NziDpTlnYQuD6PZdYxCPJL8kHi9knoo5gRcjO9s2i9wA9xfxVdbp6Yvnr/0AAd0qde
	 D8UclBqsHY5y39KB5plqsT63o4jWH8xj6VEW4Hu89PvcGeID+lsA7y6rvKVYZ9Xbb6
	 3yejC5BjkVY3QrY5fE+q8ahCPjh/bI+RcEG2FarJLbEFB9YnZ35RB5mMH9dP/3yAwJ
	 NiIHnfgpTOdfw==
Date: Thu, 1 Oct 2026 18:04:06 +0530
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 0/8] arm64: Unmap FF-A lent memory from direct map
Message-ID: <ar5TPvANFUoosxGW@sumit-xelite>
Mail-Followup-To: Will Deacon <will@kernel.org>, brendan.jackman@linux.dev,
	Vincent Donnefort <vdonnefort@google.com>, catalin.marinas@arm.com,
	rppt@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org,
	jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com,
	ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org,
	danielmentz@google.com, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, op-tee@lists.trustedfirmware.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260921110050.3977591-1-vdonnefort@google.com>
 <arIYtjmSKCs14SqO@sumit-xelite>
 <arKW_91EeKA-w96m@willie-the-truck>
 <are21BjeS1O3RYE3@sumit-xelite>
 <aruh86rd5FMv2i9G@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aruh86rd5FMv2i9G@willie-the-truck>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	RCVD_IN_DNSWL_MED(-0.20)[172.234.252.31:from];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[19];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 939CF43716
X-Spamd-Bar: ---------
Message-ID-Hash: PE5JT3U7R4SGPH4ZI2MTWKPRPA2O76H5
X-Message-ID-Hash: PE5JT3U7R4SGPH4ZI2MTWKPRPA2O76H5
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: brendan.jackman@linux.dev, Vincent Donnefort <vdonnefort@google.com>, catalin.marinas@arm.com, rppt@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PE5JT3U7R4SGPH4ZI2MTWKPRPA2O76H5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Tue, 29 Sep 2026 at 12:33:07 +0100, Will Deacon wrote:
>On Sat, Sep 26, 2026 at 05:43:08PM +0530, Sumit Garg wrote:
>> Looks like you dropped me from your reply.
>
>Huh, that's weird. If I hit reply-all ('g') in mutt, it moves the entire
>CC list to To: and drops you. I suspect the same thing happened to Thierry
>when he replied here:
>
>https://lore.kernel.org/all/arJcN60nagFKXj2Q@orome/
>
>I can't figure out why that's happening :/
>I manually tried to fix the To: and Cc: lines in this message.

Thanks.

>
>> On Tue, 22 Sep 2026 at 15:55:59 +0100, Will Deacon wrote:
>> > I spoke to Brendan at LPC (?) last year but this doesn't really work
>> > for arm64 because it relies on being able to unmap arbitrary parts of
>> > the linear map, which isn't generally possible unless you force pte-level
>> > mappings for everything, which is prohibitive for perf/power.
>>
>> As per the cover letter it's about allocating pages that are not present
>> in the direct map. This essentially fits the protected DMABufs use-case
>> where we don't want any kernel mapping to exist at any time. Bufers
>> allocated from protected DMABufs are only meant to be accessed by the
>> TEE implementation or HW accelerators like in the secure media pipeline.
>
>That sounds like it should probably build on top of this series, then.

The main problem I see with this series is it tries to move from the generic
CMA allocator to a reserved FF-A CMA pool which again comes from the
DT. We already support reserved pool allocations via "no-map" which are
discovered dynamically from OP-TEE.

If we can rather support a generic CMA like allocator for arm64 which
can support unmapped allocations then I am all for it. These platform
specific reserved pools isn't a scalable solution.

>You could allocate the DMABufs from a CMA region that has no linear alias.

Allocation from generic CMA pool is already the case here:

tee_shm_alloc_dma_mem() ->
   dma_alloc_pages()

Do you mean it's just fine to unmap buffers allocated from generic CMA
region since it doesn't have any linear alias?

>
>> > Vincent's series tackles that by using a pool so that only that part of
>> > memory requires the pte-level mappings in the linear map. That's the
>> > whole point of it, so I don't think it makes sense to drop it in favour
>> > of Brendan's approach (which doesn't work).
>> >
>>
>> For protected DMABufs, we even don't require any pte-level mappings in
>> linear map. The whole idea of mapping and unmapping is just a bottleneck
>> for performance sensitive secure media pipeline use-cases. That's why if
>> we can support __GFP_UNMAPPED with the memory allocator on arm64 would
>> be the best fit for this use-case.
>
>The point is that you will require pte-level mappings for the linear map
>if you want to unmap from it at runtime on arm64. If you don't, then you
>can end up needing to split a block mapping (e.g. pmd-level) when you
>decide to unmap only part of it and there isn't a safe way to do that on
>arm64 without transiently unmapping the entire block, which can lead to
>fatal translation faults during that window.

I agree with you here, what I am rather trying to find if on arm64 there
is any possibilty to have a generic allocator for unmapped pages. That's
the use-case here as well as what Brendan't patch-set was trying to address.

>
>> Now the question is why arm64 can't support __GFP_UNMAPPED similar to
>> how Brendan is doing it for x86?
>
>Because arm64 != x86? Presumably x86 doesn't have the strict
>break-before-make requirements we have on arm64.
>

Sure, sounds like you are eluding to that the generic MM flag
__GFP_UNMAPPED being proposed can't be supported on arm64, right?

-Sumit
