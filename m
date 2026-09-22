Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B819C982FA
	for <op-tee@archiver.kernel.org>; Tue, 22 Sep 2026 14:56:15 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 52ECC45251
	for <op-tee@archiver.kernel.org>; Tue, 22 Sep 2026 14:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790088974;
	bh=VFn7AGwFHOaKpg+AY+4Scgkb8JiG8OVp+BlxXZ0bbzE=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=nND5je7j2cWCN3PQGuk2i1mPOe47F8IVQIanOci0gwGggx9DVpT7WpVdr7RpV7buS
	 00n3H7MjTXrn5g4FJ+lpxmmefrGps6GigC/9Ac45qkGaQqi1QlchH7cTlIVRKhbjQl
	 b3Gu0TcNoaWD3XXVh7lB0ZWyobzcTfSn1RW9FUxCFH7EqvADygw4hmnRlA5ZTUC+ae
	 B2C2l0mZVoVscjFYKCgqSIlzoipi6E8XoBUZVD3cVOt9bWGTgIBrSP4XURmscSsHcv
	 4AIKsQ0GbkbeHXxQpo3kJEQ85XAVhSixUdGrOEfoX6h/OJqV5cc0W2QtMefEt0+5SS
	 FUfpECYyj4y0A==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9C94344F8E
	for <op-tee@lists.trustedfirmware.org>; Tue, 22 Sep 2026 14:56:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NC3hIEgS;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0B00760052;
	Tue, 22 Sep 2026 14:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8973B1F00893;
	Tue, 22 Sep 2026 14:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088965;
	bh=0yx1KVYmcOfYVjEzVIyo9QwiUPN5oXN2wUlmjKnOCc0=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=NC3hIEgSJs/USe6Ql93fEv9ZrzabtkxNqEUZB4aQ2SanG3FKZCPBc+TZiQPr4OO1+
	 O/6s4bE+yPy8fmQm4C0uovI54n6HOD5kXMGyFVDFMz0p4JyjLJeDN3FsiwdR8cE49m
	 pRL3TJMlnfzuq3j8KgbL028p7w0xufIWVgMhb9Nvb5EkJpPUqXOWSkwk2N/5ocvPwV
	 0WeurwzhpDPAgSniGFO3HvgOjhUCfPTFDJ+Tx5GVONm/+U/AHgqsjkCy0ci6hyTZia
	 6Ofp14oLq8Roe4awmztMutLjIBhCFpEenyJ3ICn2F/EiI/xkjMGnnGw3FQWXK0ozQ/
	 JPe2j74jLLNgw==
Date: Tue, 22 Sep 2026 15:55:59 +0100
To: Vincent Donnefort <vdonnefort@google.com>, catalin.marinas@arm.com,
	rppt@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org,
	jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com,
	ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org,
	danielmentz@google.com, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, op-tee@lists.trustedfirmware.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] arm64: Unmap FF-A lent memory from direct map
Message-ID: <arKW_91EeKA-w96m@willie-the-truck>
References: <20260921110050.3977591-1-vdonnefort@google.com>
 <arIYtjmSKCs14SqO@sumit-xelite>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arIYtjmSKCs14SqO@sumit-xelite>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.50 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[17];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9C94344F8E
X-Spamd-Bar: --------
Message-ID-Hash: 7I2WN5M7MUOHQ32XHCVEXFKAFP2LN4UG
X-Message-ID-Hash: 7I2WN5M7MUOHQ32XHCVEXFKAFP2LN4UG
X-MailFrom: will@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7I2WN5M7MUOHQ32XHCVEXFKAFP2LN4UG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Will Deacon via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Will Deacon <will@kernel.org>

On Tue, Sep 22, 2026 at 11:27:10AM +0530, Sumit Garg wrote:
> On Mon, 21 Sep 2026 at 12:00:42 +0100, Vincent Donnefort wrote:
> > This series is a follow-up to the discussion that has started here [1].
> > 
> > When memory is lent to the Secure world via FF-A, CPU speculative
> > accesses from NS to the lent pages can still occur as long as it retains
> > a cacheable mapping to it.
> > 
> > Ideally, lent memory would be "no-map" but that would mean giving up
> > MiBs of useful memory, so let's try to do better with the help of a CMA
> > pool.
> > 
> > On arm64, modifying the direct map at runtime is generally restricted
> > because the linear map defaults to block mapping and splitting blocks at
> > runtime may trigger fatal page fault, unless the CPU implements BBML3
> > or the entire direct map was mapped at page granularity from boot.
> > Forcing last-level mappings system-wide incurs a severe penalty we want
> > to avoid. Instead, this series introduces targeted last-level mappings
> > for designated memory regions, along with the "arm,ffa-lend-pool" CMA
> > driver to manage unmapping and remapping on lend/reclaim transitions:
> > 
> > 1. memblock:
> >   - Introduce MEMBLOCK_PTEMAP to force PTE mappings only for a specific region.
> > 
> > 2. set_memory infrastructure:
> >   - Introduce can_set_direct_map_range() to check if a specific address
> >     range is mapped with last-level entries and can be modified safely.
> >   - Introduce __set_direct_map_*() variants that bypass redundant checks
> >     when the caller has already validated the range.
> > 
> > 3. "arm,ffa-lend-pool" driver
> >   - Introduce the "arm,ffa-lend-pool" CMA reserved-memory driver, which
> >     unmaps pages prior to lending (ffa_prepare_lend()) and restores them
> >     when reclaimed (ffa_lend_reclaimed()).
> > 
> > 4. Optee support
> >   - Hook OP-TEE dynamic protected memory pools to "arm,ffa-lend-pool" for
> >     both SMC (via DT memory-region phandle) and FF-A (via
> >     ffa_lend_pool_attach()) transports.
> 
> 
> Thanks for your proposal in trying to solve this hard problem of
> unmapping pages from kernel linear map. I remember discussing this
> problem last year at LPC too.
> 
> Have you had a chance to look at a more generic MM proposal around this
> issue here [1]?
> 
> One of the major concern for me with your proposal is tying the
> protected memory allocation to fixed sized platform specific pool size
> based on DT. Then the cost of granular mappings/unmapping if the
> platforms choose to enlarge these pools.
> 
> As you maybe aware one of the major use-cases here for protected DMAbufs
> is the secure media pipeline use-case which is memory intensive
> workload. IMO, the solution proposed at [1] seems to address it although
> people have flagged rough edges there but should be addressable.
> 
> Can you try a port of [1] for arm64 since the author did all the work
> with x86 as reference?
> 
> [1] https://lore.kernel.org/all/20260726-page_alloc-unmapped-v3-0-6f5729aa9832@google.com/

I spoke to Brendan at LPC (?) last year but this doesn't really work
for arm64 because it relies on being able to unmap arbitrary parts of
the linear map, which isn't generally possible unless you force pte-level
mappings for everything, which is prohibitive for perf/power.

Vincent's series tackles that by using a pool so that only that part of
memory requires the pte-level mappings in the linear map. That's the
whole point of it, so I don't think it makes sense to drop it in favour
of Brendan's approach (which doesn't work).

Will
