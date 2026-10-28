Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562B5606A323
	for <op-tee@archiver.kernel.org>; Wed, 28 Oct 2026 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=S4LL4O7P;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BOP4NQqP
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BB259453B4
	for <op-tee@archiver.kernel.org>; Wed, 28 Oct 2026 14:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793199061;
	bh=Lz7WvapjYKybe9inAE7cARypgwOjM6/WUw+3g6HhEkw=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=S4LL4O7PO2Mg+OyoZTvWHO8KgIoOlCJflVxfbF3hUPU59vJQAtB5TXi+ebGg4VEIj
	 jiixNy2O15VBnaZt+0vv3KMvyylU9RvVNvf4pMmiyB/yluqf4dUVfEz/AH2OmCO5aJ
	 3HDoUdwIMYSFDil1gLP3NHWJzX+9PyapBV9MbB1gaS/iasckX9B3oO///VRjgk0fll
	 mucjw/IPGwSXxOphQll0+kN3E8WbAkfxihnO3KncKNvAT7SpD7x5KBwXsiVXrqGLMt
	 K7NL/MzGZ0LLCSneGwrviv+564tA9mhnQBFqZxMxli4GRxqYBfagc6dBR2EAp90To8
	 3zmFH7L8n0G/Q==
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 03E9F44B14
	for <op-tee@lists.trustedfirmware.org>; Wed, 28 Oct 2026 14:50:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BOP4NQqP;
	dkim-atps=neutral
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c40e30c26a4so353441566b.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 28 Oct 2026 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793199042; x=1793803842; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HF1altOhSOliHgMv/AZ/rbBGnqwe/0k0dVHlSjsTcys=;
        b=BOP4NQqPLmLkPjKjbZ3gk976vMWEvy8P8YrznDN13ucfcvYfh/YSEWsNQD7YjBbANC
         zhlJ5zl9LH5uUBLLigdYYjraAvB+8eMN/jz4CfMKmzfGbHJfJVo3FL4+eNziBW5XH9ew
         EY3KxOwPW+8F5LiebREZ+Ddm1odBJf5Q+kkcNM5JXnAlsogMxRNca9VAP9E6tZRHJTUM
         KRWEFMrjdyE3DUgRallK3nv2CEeX3V29Z8z4H6T61ACziqJ8K61T/cn4Jh1u+OZYozYm
         C77w+guh45F1w367cVhoB4F5AaY7f2Op05lx+3mLOzS2V+KP/FaG6TWp7A/OafmsPiOa
         pVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793199042; x=1793803842;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HF1altOhSOliHgMv/AZ/rbBGnqwe/0k0dVHlSjsTcys=;
        b=lsUVCtzB/IQuhk/gg9+iMKiI9XIw+2G6k3/Nj+sbdPpA9azFvhl0MwJvcJ4+q1xbd+
         Z9YSAgC3LpTRmG2s8Bm5etl78GXjhzTQe2Az2mIabyTgBLgkAFZSL0iZHuMWELLKLNl0
         fbaWb3cv2uOT2DynB50ue4Xg87aJaGKe/f9WPcvIoBSfMybotLM9JlOwbHgU1EC3OGFZ
         AtdiTOqZ+9D9VpibLjSdinwBfctGm30D3XpFWHqAgJ6mXySv3CTQ3DJr+m7NOeOy2T3/
         8S2+RsP2/w180zydTe0wBFUIL8mnTc8JRvuDZpJrvrN22EBcXnczJh/ld5YAxivLoCSw
         Otvw==
X-Forwarded-Encrypted: i=1; AKwUvBzGJvbtTc5MeEcf+0SsaSs8FmJNUA5cz9BdIJi+6jwgknUaOzFUAp5VEZ5XDyP+UZBhEjQE4dw=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJFkKIhTKEHZmd1cGfzP7BEmeWEaf2UirGx567WdYWCrXStz2Jo
	2e1SaZMUoolv4exxJuDdSsd/7+xk/PWHaAwRtT3ZaUpFJD2fmWuyJNIB1KOAij1soA==
X-Gm-Gg: AYBFou0Z/ggonsnfwGO0EN84RQrk9fIQc1Izg3wBRgP4JAL5UAi+3HCTWKo22FDvFvm
	drNNcFDQ0pT9uM/PbcFtTUf0TTX7xROP5Y4Jn28UFQyFiMLl0p+OlVZkRQwImuNvSZxPy/bY+Yz
	48UFv6feJKM6k4b87aW/w/PBe9ERUneiwDS+A2Rdvza5Eu2xU7RpFrtNdljhcHD9OGohnOrN3sq
	MnQ1Zq7j8sFRZ0LSCgYgUxNY5vVIjHSdB6WKZ+2ORUZR5iX0vcxGSie398tG0/pqYrx4bSRqYwP
	h2KBqtCKz/eGkj6OUDsoN7WBK2sr7eZsc3EAMS0WyFhCJoIV+wN0djnxOZMGGptkuKv8TTBagRE
	Gls/ZJx5+3sfrBeF2VzwrC8QUum0RCa2Qhak4q7XdD6JFaW1kdR+fzmLK3ypfHFr0iED/zOWLqT
	/EhzlaqYbNGLtlZnU9rz6bDHz8t3tDWeJ2qhqRRiPub/+izQm6I5W54bA2IBsxtuvSbld/HUuEP
	8iUSXSjASy/oGpNAV3vPc5x5IRpkG/aV08K34495jSlvs4Ait9qRcfwj7WzvipdLy6BF8y908UW
	Iv0d1wta0TbuHgDxIX8aN3qkdMSXAjVRFNZ/bjFrpL7T61z3f8TEINC3/v8EwYS9pXCAD8OGanr
	Pr7qMXBVa1ZE=
X-Received: by 2002:a17:906:99c9:b0:c29:4b57:503e with SMTP id a640c23a62f3a-c49c620c08emr153260566b.1.1793199040959;
        Wed, 28 Oct 2026 07:50:40 -0700 (PDT)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd35004asm607338466b.4.2026.10.28.07.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:50:40 -0700 (PDT)
Date: Wed, 28 Oct 2026 14:50:36 +0000
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v2 0/8] arm64: Unmap FF-A lent memory from direct map
Message-ID: <auILvMVSXk9pZh6M@google.com>
References: <arIYtjmSKCs14SqO@sumit-xelite>
 <arKW_91EeKA-w96m@willie-the-truck>
 <are21BjeS1O3RYE3@sumit-xelite>
 <aruh86rd5FMv2i9G@willie-the-truck>
 <ar5TPvANFUoosxGW@sumit-xelite>
 <asOAYODGZa-7EIV1@google.com>
 <asOD31rTX6dNfD1o@google.com>
 <aszdnInyJxLhSQRp@sumit-xelite>
 <as3798SFCfKFirag@google.com>
 <as4ATqhp0bPI03PA@sumit-xelite>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as4ATqhp0bPI03PA@sumit-xelite>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[google.com:s=20260707];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_EQ_ENVFROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.218.43:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.43:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 03E9F44B14
X-Spamd-Bar: ---
Message-ID-Hash: IPM32GXXENGXSDF3GPX52EGVPQJ4ZVZD
X-Message-ID-Hash: IPM32GXXENGXSDF3GPX52EGVPQJ4ZVZD
X-MailFrom: vdonnefort@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Will Deacon <will@kernel.org>, brendan.jackman@linux.dev, catalin.marinas@arm.com, rppt@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IPM32GXXENGXSDF3GPX52EGVPQJ4ZVZD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 13, 2026 at 03:26:30PM +0530, Sumit Garg wrote:
> On Tue, 13 Oct 2026 at 10:37:59 +0100, Vincent Donnefort wrote:
> > On Mon, Oct 12, 2026 at 06:46:12PM +0530, Sumit Garg wrote:
> > > On Mon, 05 Oct 2026 at 12:02:55 +0100, Vincent Donnefort wrote:
> > > > Sorry, not sure why Sumit's email was dropped...
> > > 
> > > The problem was with my mutt config, it should be fixed now.
> > > 
> > > >
> > > > On Mon, Oct 05, 2026 at 11:48:00AM +0100, Vincent Donnefort wrote:
> > > > > On Thu, Oct 01, 2026 at 06:04:06PM +0530, Sumit Garg wrote:
> > > > > > On Tue, 29 Sep 2026 at 12:33:07 +0100, Will Deacon wrote:
> > > > > > > On Sat, Sep 26, 2026 at 05:43:08PM +0530, Sumit Garg wrote:
> > > > > > > > Looks like you dropped me from your reply.
> > > > > > >
> > > > > > > Huh, that's weird. If I hit reply-all ('g') in mutt, it moves the entire
> > > > > > > CC list to To: and drops you. I suspect the same thing happened to Thierry
> > > > > > > when he replied here:
> > > > > > >
> > > > > > > https://lore.kernel.org/all/arJcN60nagFKXj2Q@orome/
> > > > > > >
> > > > > > > I can't figure out why that's happening :/
> > > > > > > I manually tried to fix the To: and Cc: lines in this message.
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > >
> > > > > > > > On Tue, 22 Sep 2026 at 15:55:59 +0100, Will Deacon wrote:
> > > > > > > > > I spoke to Brendan at LPC (?) last year but this doesn't really work
> > > > > > > > > for arm64 because it relies on being able to unmap arbitrary parts of
> > > > > > > > > the linear map, which isn't generally possible unless you force pte-level
> > > > > > > > > mappings for everything, which is prohibitive for perf/power.
> > > > > > > >
> > > > > > > > As per the cover letter it's about allocating pages that are not present
> > > > > > > > in the direct map. This essentially fits the protected DMABufs use-case
> > > > > > > > where we don't want any kernel mapping to exist at any time. Bufers
> > > > > > > > allocated from protected DMABufs are only meant to be accessed by the
> > > > > > > > TEE implementation or HW accelerators like in the secure media pipeline.
> > > > > > >
> > > > > > > That sounds like it should probably build on top of this series, then.
> > > > > >
> > > > > > The main problem I see with this series is it tries to move from the generic
> > > > > > CMA allocator to a reserved FF-A CMA pool which again comes from the
> > > > > > DT. We already support reserved pool allocations via "no-map" which are
> > > > > > discovered dynamically from OP-TEE.
> > > > >
> > > > > I can't think of a way around a DT declaration. We need to know what region is
> > > > > PTE-level before the direct map is installed and of_reserved_mem is very handy
> > > > > for that purpose. And as this PTE-level mapping is costly we certainly only want
> > > > > to enable it for platforms that absolutely need it.
> > > > >
> > > 
> > > I am rather thinking of a way to turn the default CMA allocator to be
> > > PTE-level mapped. Since the overall idea for this dynamic protected
> > > buffers was to reuse memory efficiently, otherwise the reserved buffer
> > > approach is already there to use as "no-map" via DT.
> > 
> > When the default CMA allocator is setup, it is already too late
> > (dma_contiguous_reserve() is called after map_mem()). I am not sure this can be
> > reordered easily due to the dependency on dma_limits_init().
> 
> Yeah I saw that constraint too, let's leave it for future extension
> then although having this reordering dependency fixed will be ideal.
> 
> > 
> > So the only case it would work would be when a reserved memory has set
> > "linux,cma-default".
> > 
> 
> Let's rather just turn DT based default CMA pool to support PTE-level
> mapping and keep it configurable via Kconfig or cmdline or DT.

If we need a DT declaration anyway, a Kconfig and a cmdline option aren't really
necessary.

Also, Rob wasn't very keen on having a DT option for the reserved memory and
suggested to have a compatible string instead [1]. So perhaps we could have a
a separate driver that handles the unmapping.

	linux,cma {
		compatible = "shared-dma-pool", "unmap-on-alloc";
		reusable;
		linux,cma-default;
		...
 	}

That "unmap-on-alloc" driver sets the memblock flags and register some cma hooks
(to be defined) for cma_alloc/cma_free where it unmaps/re-maps into the linear
map.

The nice property is optee won't need to be modified anymore. The downside is
the entire pool is now mapped at PTE-level.

[1] http://lore.kernel.org/all/20260902172436.GB1440252-robh@kernel.org/

-- 
Vincent

> 
> -Sumit
> 
> > > 
> > > If we can have "cma_unmap" cmdline option alongside "cma" then it can
> > > turn the existing default CMA allocator to support unmapping buffers.
> > > Not requiring a DT change at all, although we can have the DT property
> > > for the default pool too if platforms want to opt for.
> > > 
> > > > > >
> > > > > > If we can rather support a generic CMA like allocator for arm64 which
> > > > > > can support unmapped allocations then I am all for it. These platform
> > > > > > specific reserved pools isn't a scalable solution.
> > > > >
> > > > > What do you mean by generic CMA allocator here? An extension to
> > > > > shared-dma-pool? Or having the CMA automatically doing the unmap/map on
> > > > > cma_alloc() cma_release()?
> > > > >
> > > > > Right now I have created an API for the unmapping/remapping part. It adds a
> > > > > burden on the caller, but the alternative solution is introducing post-alloc
> > > > > pre-dealloc callbacks in the CMA, which looked a bit overkilled to me when
> > > > > the users of that "ffa-pool" are only optee and the nvidia video dma-buf heap.
> > > > >
> > > 
> > > I am not too worried about where the actual implementation lives but
> > > looks like CMA driver to be the better place. I think use-cases like
> > > guest_memfd proposed as a user for __GFP_UNMAPPED on arm64 will also be
> > > looking for this feature.
> > > 
> > > -Sumit
> > > 
> > > > >
> > > > > >
> > > > > > > You could allocate the DMABufs from a CMA region that has no linear alias.
> > > > > >
> > > > > > Allocation from generic CMA pool is already the case here:
> > > > > >
> > > > > > tee_shm_alloc_dma_mem() ->
> > > > > >   dma_alloc_pages()
> > > > > >
> > > > > > Do you mean it's just fine to unmap buffers allocated from generic CMA
> > > > > > region since it doesn't have any linear alias?
> > > > > >
> > > > > > >
> > > > > > > > > Vincent's series tackles that by using a pool so that only that part of
> > > > > > > > > memory requires the pte-level mappings in the linear map. That's the
> > > > > > > > > whole point of it, so I don't think it makes sense to drop it in favour
> > > > > > > > > of Brendan's approach (which doesn't work).
> > > > > > > > >
> > > > > > > >
> > > > > > > > For protected DMABufs, we even don't require any pte-level mappings in
> > > > > > > > linear map. The whole idea of mapping and unmapping is just a bottleneck
> > > > > > > > for performance sensitive secure media pipeline use-cases. That's why if
> > > > > > > > we can support __GFP_UNMAPPED with the memory allocator on arm64 would
> > > > > > > > be the best fit for this use-case.
> > > > > > >
> > > > > > > The point is that you will require pte-level mappings for the linear map
> > > > > > > if you want to unmap from it at runtime on arm64. If you don't, then you
> > > > > > > can end up needing to split a block mapping (e.g. pmd-level) when you
> > > > > > > decide to unmap only part of it and there isn't a safe way to do that on
> > > > > > > arm64 without transiently unmapping the entire block, which can lead to
> > > > > > > fatal translation faults during that window.
> > > > > >
> > > > > > I agree with you here, what I am rather trying to find if on arm64 there
> > > > > > is any possibilty to have a generic allocator for unmapped pages. That's
> > > > > > the use-case here as well as what Brendan't patch-set was trying to address.
> > > > > >
> > > > > > >
> > > > > > > > Now the question is why arm64 can't support __GFP_UNMAPPED similar to
> > > > > > > > how Brendan is doing it for x86?
> > > > > > >
> > > > > > > Because arm64 != x86? Presumably x86 doesn't have the strict
> > > > > > > break-before-make requirements we have on arm64.
> > > > > > >
> > > > > >
> > > > > > Sure, sounds like you are eluding to that the generic MM flag
> > > > > > __GFP_UNMAPPED being proposed can't be supported on arm64, right?
> > > > > >
> > > > > > -Sumit
> > > >
> > > > --
> > > > Vincent
> > 
