Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CA2CC6B08
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 09:56:59 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 65FD9438BE
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 09:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791885418;
	bh=PlVvTdkWjp0YX/ia1aYjkyxCtGTcPvQfZMqeqi6ZbQU=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=hJnuA5MY7AZwv3pBHiWosRMIiwCbDwFKbzVp6UnRfKg2BJCYqVWE+6aA/CMRAeyI+
	 FApm6ATg4gYXXp+1r6aRsnAj/Z/t5I9II+oJfwvv9mwK6Bjx+k87l9OeLhmBR9kB9X
	 YqdJRD+PBZK+AgGZvV8OIr4d6+mLw7m956YCcG+tbgQmd21QZc5eidTBT8aW3fbemM
	 WQBiOjl85IrArBqNAzX74w7VaTEgaoibp8OoI4bsE+KvYq+4vlfU/zbV5zmOar/IL4
	 RcyNZsnc0lr/UNQI6Fthsb6zyh8Y1jNyBfz1ISX3HilcCYZNCEEDeZ1A36O6zVRZAH
	 EnIiKH+0Ypdxw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EE33443864
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 09:56:39 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FL6bAAK1;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 433E1600D1;
	Tue, 13 Oct 2026 09:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55F31F000FF;
	Tue, 13 Oct 2026 09:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791885399;
	bh=Q7fj9Vp+tJj7vJqMJATzo0vyG2yGkhzhjEgsT39DDVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FL6bAAK1wmdEJY0kUnZUcDtzMSWohJp9SOCaOF43QWDUhT0/iL+EQrzkosR+1+gbK
	 n3CYnRul7jUIP5IfLrkv+P8pOPh2mpHNS0Uk7wGHOYoV0XS1R0aERG9phPvMAFz/m5
	 QcZdYbCJMmhUbrAflNX57QafmAdlmP34KxetYLnLS9rdkS7h4MXNYvwBtSTDHXg93c
	 LXsP/R+zgGNL6f6XUxUQk4JWLfXvGkhLVMFwJUUaIpFMyzcLic/mA0L8NUYvPS8sHb
	 2QPEtRlQjY4pusEYwNfnlZ8LI5GQyhY4CKycn3vvy+P2KTQn0xXPvmjqDkcMg8QP74
	 qEjGgM633sPKg==
Date: Tue, 13 Oct 2026 15:26:30 +0530
To: Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v2 0/8] arm64: Unmap FF-A lent memory from direct map
Message-ID: <as4ATqhp0bPI03PA@sumit-xelite>
References: <20260921110050.3977591-1-vdonnefort@google.com>
 <arIYtjmSKCs14SqO@sumit-xelite>
 <arKW_91EeKA-w96m@willie-the-truck>
 <are21BjeS1O3RYE3@sumit-xelite>
 <aruh86rd5FMv2i9G@willie-the-truck>
 <ar5TPvANFUoosxGW@sumit-xelite>
 <asOAYODGZa-7EIV1@google.com>
 <asOD31rTX6dNfD1o@google.com>
 <aszdnInyJxLhSQRp@sumit-xelite>
 <as3798SFCfKFirag@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <as3798SFCfKFirag@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.50 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EE33443864
X-Spamd-Bar: ------
Message-ID-Hash: KJT2HJIJ6U3EJENAERHMKXE63IKEEU2C
X-Message-ID-Hash: KJT2HJIJ6U3EJENAERHMKXE63IKEEU2C
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Will Deacon <will@kernel.org>, brendan.jackman@linux.dev, catalin.marinas@arm.com, rppt@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KJT2HJIJ6U3EJENAERHMKXE63IKEEU2C/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Tue, 13 Oct 2026 at 10:37:59 +0100, Vincent Donnefort wrote:
>On Mon, Oct 12, 2026 at 06:46:12PM +0530, Sumit Garg wrote:
>> On Mon, 05 Oct 2026 at 12:02:55 +0100, Vincent Donnefort wrote:
>> > Sorry, not sure why Sumit's email was dropped...
>>
>> The problem was with my mutt config, it should be fixed now.
>>
>> >
>> > On Mon, Oct 05, 2026 at 11:48:00AM +0100, Vincent Donnefort wrote:
>> > > On Thu, Oct 01, 2026 at 06:04:06PM +0530, Sumit Garg wrote:
>> > > > On Tue, 29 Sep 2026 at 12:33:07 +0100, Will Deacon wrote:
>> > > > > On Sat, Sep 26, 2026 at 05:43:08PM +0530, Sumit Garg wrote:
>> > > > > > Looks like you dropped me from your reply.
>> > > > >
>> > > > > Huh, that's weird. If I hit reply-all ('g') in mutt, it moves the entire
>> > > > > CC list to To: and drops you. I suspect the same thing happened to Thierry
>> > > > > when he replied here:
>> > > > >
>> > > > > https://lore.kernel.org/all/arJcN60nagFKXj2Q@orome/
>> > > > >
>> > > > > I can't figure out why that's happening :/
>> > > > > I manually tried to fix the To: and Cc: lines in this message.
>> > > >
>> > > > Thanks.
>> > > >
>> > > > >
>> > > > > > On Tue, 22 Sep 2026 at 15:55:59 +0100, Will Deacon wrote:
>> > > > > > > I spoke to Brendan at LPC (?) last year but this doesn't really work
>> > > > > > > for arm64 because it relies on being able to unmap arbitrary parts of
>> > > > > > > the linear map, which isn't generally possible unless you force pte-level
>> > > > > > > mappings for everything, which is prohibitive for perf/power.
>> > > > > >
>> > > > > > As per the cover letter it's about allocating pages that are not present
>> > > > > > in the direct map. This essentially fits the protected DMABufs use-case
>> > > > > > where we don't want any kernel mapping to exist at any time. Bufers
>> > > > > > allocated from protected DMABufs are only meant to be accessed by the
>> > > > > > TEE implementation or HW accelerators like in the secure media pipeline.
>> > > > >
>> > > > > That sounds like it should probably build on top of this series, then.
>> > > >
>> > > > The main problem I see with this series is it tries to move from the generic
>> > > > CMA allocator to a reserved FF-A CMA pool which again comes from the
>> > > > DT. We already support reserved pool allocations via "no-map" which are
>> > > > discovered dynamically from OP-TEE.
>> > >
>> > > I can't think of a way around a DT declaration. We need to know what region is
>> > > PTE-level before the direct map is installed and of_reserved_mem is very handy
>> > > for that purpose. And as this PTE-level mapping is costly we certainly only want
>> > > to enable it for platforms that absolutely need it.
>> > >
>>
>> I am rather thinking of a way to turn the default CMA allocator to be
>> PTE-level mapped. Since the overall idea for this dynamic protected
>> buffers was to reuse memory efficiently, otherwise the reserved buffer
>> approach is already there to use as "no-map" via DT.
>
>When the default CMA allocator is setup, it is already too late
>(dma_contiguous_reserve() is called after map_mem()). I am not sure this can be
>reordered easily due to the dependency on dma_limits_init().

Yeah I saw that constraint too, let's leave it for future extension
then although having this reordering dependency fixed will be ideal.

>
>So the only case it would work would be when a reserved memory has set
>"linux,cma-default".
>

Let's rather just turn DT based default CMA pool to support PTE-level
mapping and keep it configurable via Kconfig or cmdline or DT.

-Sumit

>>
>> If we can have "cma_unmap" cmdline option alongside "cma" then it can
>> turn the existing default CMA allocator to support unmapping buffers.
>> Not requiring a DT change at all, although we can have the DT property
>> for the default pool too if platforms want to opt for.
>>
>> > > >
>> > > > If we can rather support a generic CMA like allocator for arm64 which
>> > > > can support unmapped allocations then I am all for it. These platform
>> > > > specific reserved pools isn't a scalable solution.
>> > >
>> > > What do you mean by generic CMA allocator here? An extension to
>> > > shared-dma-pool? Or having the CMA automatically doing the unmap/map on
>> > > cma_alloc() cma_release()?
>> > >
>> > > Right now I have created an API for the unmapping/remapping part. It adds a
>> > > burden on the caller, but the alternative solution is introducing post-alloc
>> > > pre-dealloc callbacks in the CMA, which looked a bit overkilled to me when
>> > > the users of that "ffa-pool" are only optee and the nvidia video dma-buf heap.
>> > >
>>
>> I am not too worried about where the actual implementation lives but
>> looks like CMA driver to be the better place. I think use-cases like
>> guest_memfd proposed as a user for __GFP_UNMAPPED on arm64 will also be
>> looking for this feature.
>>
>> -Sumit
>>
>> > >
>> > > >
>> > > > > You could allocate the DMABufs from a CMA region that has no linear alias.
>> > > >
>> > > > Allocation from generic CMA pool is already the case here:
>> > > >
>> > > > tee_shm_alloc_dma_mem() ->
>> > > >   dma_alloc_pages()
>> > > >
>> > > > Do you mean it's just fine to unmap buffers allocated from generic CMA
>> > > > region since it doesn't have any linear alias?
>> > > >
>> > > > >
>> > > > > > > Vincent's series tackles that by using a pool so that only that part of
>> > > > > > > memory requires the pte-level mappings in the linear map. That's the
>> > > > > > > whole point of it, so I don't think it makes sense to drop it in favour
>> > > > > > > of Brendan's approach (which doesn't work).
>> > > > > > >
>> > > > > >
>> > > > > > For protected DMABufs, we even don't require any pte-level mappings in
>> > > > > > linear map. The whole idea of mapping and unmapping is just a bottleneck
>> > > > > > for performance sensitive secure media pipeline use-cases. That's why if
>> > > > > > we can support __GFP_UNMAPPED with the memory allocator on arm64 would
>> > > > > > be the best fit for this use-case.
>> > > > >
>> > > > > The point is that you will require pte-level mappings for the linear map
>> > > > > if you want to unmap from it at runtime on arm64. If you don't, then you
>> > > > > can end up needing to split a block mapping (e.g. pmd-level) when you
>> > > > > decide to unmap only part of it and there isn't a safe way to do that on
>> > > > > arm64 without transiently unmapping the entire block, which can lead to
>> > > > > fatal translation faults during that window.
>> > > >
>> > > > I agree with you here, what I am rather trying to find if on arm64 there
>> > > > is any possibilty to have a generic allocator for unmapped pages. That's
>> > > > the use-case here as well as what Brendan't patch-set was trying to address.
>> > > >
>> > > > >
>> > > > > > Now the question is why arm64 can't support __GFP_UNMAPPED similar to
>> > > > > > how Brendan is doing it for x86?
>> > > > >
>> > > > > Because arm64 != x86? Presumably x86 doesn't have the strict
>> > > > > break-before-make requirements we have on arm64.
>> > > > >
>> > > >
>> > > > Sure, sounds like you are eluding to that the generic MM flag
>> > > > __GFP_UNMAPPED being proposed can't be supported on arm64, right?
>> > > >
>> > > > -Sumit
>> >
>> > --
>> > Vincent
>
