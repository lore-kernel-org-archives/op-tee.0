Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5526ACC6B08
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 09:38:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6F48045239
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 09:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791884305;
	bh=8PSxlgB1MhX1jN/IO/b9YvOnW2qaH4L30mn3Qh5Ixk4=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=5NrB4zaTskQM/cpEmUBy1mjFZi9vmYtuiMEWDGSDpE9WBuZJEPVn1gYtmHf/YsELp
	 tbVXGcIK9lwFSYEgVvOMqSs+lerRfDjToUyCYWs3MXwxwDC73OUDNX9ZMEhOd7m57Q
	 1oJPnVSHQddTkHh+M0QvgUQzWnbASd2WNSUVdQpaBEscxxFa9T2I+M6o8RW8nslhIp
	 kwoDd5IVDKT1yHfd13ztSnPxtbVHQGv3TzU2k17Qiltt/U3nAVzlBi7fv7KqRAL4At
	 hyevrLm1rQPMV8GUTSz9bkMcEAf4JU/U1aGDt+xdy/JkaIVs5zd5ulgc7tjb/tzvhM
	 +0iK5kdW9KJ1A==
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AD9D844F21
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 09:38:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cWyns7c7;
	dkim-atps=neutral
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48b03f23305so2302990f8f.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 02:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791884285; x=1792489085; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oTxQfKp3tqhTG4A8e3eA1UWYq0qoe3PSOMQA99g87ls=;
        b=cWyns7c7H4P6tuwJO1p5UN/2vWctdMb0ekg4ZFeZ5I6PRSp0DrM2h4NyaIFTaemagU
         LEP3LAoKxVmvvPtkuMRQPQooweUFmhgcQWpnUh1w3tIGPsaKIi89r1jroGxDffGCwttD
         eWFpwSROn4N7bUmXoEH72qxSGBzATA0hmazu7nYYRVk547s9JNITMgXxK0N9G+dx1dJ1
         8eJ/LVEmni/Ww8Vyn7EXA7zJls5cxByCKJ7vwARyo+KRVZ/Qp82+8EWSg2jkD3BtMw+t
         +H+MeOjbCdAY2fJhTKT/ZiI0d56aC7kcBIiXVI8wFsll3EHuSgr34fnU1GJyIbWqjHD2
         I/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791884285; x=1792489085;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oTxQfKp3tqhTG4A8e3eA1UWYq0qoe3PSOMQA99g87ls=;
        b=dWn969NHc89n5cKwC6RA45wWkpes4bX5WTmofj0QUVTiI8iD80z5BxTXKUYNvXRjKj
         M2LJrvyWpKRZjPVZ48bOdzWyCBt5bjO0hCjZtJNvb8Eu2SEgZBCnem09lJqWUCvo2ALN
         A6OSg43lH5PIzGop9wWVHtEcIplBpcpqFGR4rgjDjFfbbpZABae5HdItK0DMhCs1NuiO
         fspNgv5fS+OyXaMXsqbGV0vBRwcVbW1PEtrFd+dvHB6/fhJX68t94/pWqVj5Rf1c4f4b
         YJplAx/Tf+Ta/oRYEWW/p1YS0htrxPugpH1akxZMWyRp/p7jo5vc9sg1zBDQOgwl1CXZ
         do6Q==
X-Forwarded-Encrypted: i=1; AKwUvBwhW8fqMQZzNaiXoJOAtHoFJK3VVhDoHgHMsIn4idbcT5nAIlnsaU2gKWWTlP7DWx/+xwqKbWc=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYIi2kVMR6y3zo7ZHUHiemao3DCMG2UiLeJfZbRrNiuNOJLuV+1p
	rd+yzyahoJ5LWy/R8QTZUk33k6XMJQU4FLrFwPteQix+OvTafQaJFBtSTcOp53w8Gw==
X-Gm-Gg: AYBFou1iKDCG1iFemSKMAr18cPELLG5MuH/vbzLW6AdY01pFLSQk2omh2GeQGSgDeKn
	NJz4sdDFqKPcQz9TDlBriOi8Fvbo6qfVQfuHb/45hT82NVksvQRxQIGXuO7ysyYb5VGwI55rnDy
	ojhbaGSHFDmc6yp017E9O7F/7qhKBrqEbs7RwbklfUY35I7sbtUKlMVrRcARPKJxJsUWqxaRvFq
	T/AM+z26XFFTonKGEH09AtODbeOqTlZ3dPIepmaq/2PQ/wc0MiMo1qsyl6E/91ThA+6juM3Q3KA
	AOZR+J22TWEbvTJujGTsast7P53wYud9di7zegUcIg1sB2dYm+xqs/j6lQCevxsG5yPnGDlrb7I
	Nb6pe6rpJhx1nGhMCiikExW0J+dvxUQsr+8wj8H683Hoxgy+RCRYgqXm+pEorRDP8lxpirz6npl
	hJfKZiVyfeeUUeMqvwJ4HCrtQjPdkUTjXUPhlDW2qe+K5N6xfOS35D9dKsHpsWi0CFAT+mRETjv
	ucDUXtPFJQQqS+etq10yD4ozrcvYmSvIT1KIIZAA/8=
X-Received: by 2002:a05:600c:c049:b0:4a1:9a97:c88 with SMTP id 5b1f17b1804b1-4a19a971118mr97040485e9.5.1791884284684;
        Tue, 13 Oct 2026 02:38:04 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaabb8sm4646155f8f.15.2026.10.13.02.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 02:38:04 -0700 (PDT)
Date: Tue, 13 Oct 2026 10:37:59 +0100
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v2 0/8] arm64: Unmap FF-A lent memory from direct map
Message-ID: <as3798SFCfKFirag@google.com>
References: <20260921110050.3977591-1-vdonnefort@google.com>
 <arIYtjmSKCs14SqO@sumit-xelite>
 <arKW_91EeKA-w96m@willie-the-truck>
 <are21BjeS1O3RYE3@sumit-xelite>
 <aruh86rd5FMv2i9G@willie-the-truck>
 <ar5TPvANFUoosxGW@sumit-xelite>
 <asOAYODGZa-7EIV1@google.com>
 <asOD31rTX6dNfD1o@google.com>
 <aszdnInyJxLhSQRp@sumit-xelite>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aszdnInyJxLhSQRp@sumit-xelite>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_EQ_ENVFROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.45:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.45:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AD9D844F21
X-Spamd-Bar: ---
Message-ID-Hash: 2XVYUB7GBNNDNCC4TVMX3LJLGSMMH5K3
X-Message-ID-Hash: 2XVYUB7GBNNDNCC4TVMX3LJLGSMMH5K3
X-MailFrom: vdonnefort@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Will Deacon <will@kernel.org>, brendan.jackman@linux.dev, catalin.marinas@arm.com, rppt@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2XVYUB7GBNNDNCC4TVMX3LJLGSMMH5K3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

On Mon, Oct 12, 2026 at 06:46:12PM +0530, Sumit Garg wrote:
> On Mon, 05 Oct 2026 at 12:02:55 +0100, Vincent Donnefort wrote:
> > Sorry, not sure why Sumit's email was dropped...
> 
> The problem was with my mutt config, it should be fixed now.
> 
> > 
> > On Mon, Oct 05, 2026 at 11:48:00AM +0100, Vincent Donnefort wrote:
> > > On Thu, Oct 01, 2026 at 06:04:06PM +0530, Sumit Garg wrote:
> > > > On Tue, 29 Sep 2026 at 12:33:07 +0100, Will Deacon wrote:
> > > > > On Sat, Sep 26, 2026 at 05:43:08PM +0530, Sumit Garg wrote:
> > > > > > Looks like you dropped me from your reply.
> > > > >
> > > > > Huh, that's weird. If I hit reply-all ('g') in mutt, it moves the entire
> > > > > CC list to To: and drops you. I suspect the same thing happened to Thierry
> > > > > when he replied here:
> > > > >
> > > > > https://lore.kernel.org/all/arJcN60nagFKXj2Q@orome/
> > > > >
> > > > > I can't figure out why that's happening :/
> > > > > I manually tried to fix the To: and Cc: lines in this message.
> > > >
> > > > Thanks.
> > > >
> > > > >
> > > > > > On Tue, 22 Sep 2026 at 15:55:59 +0100, Will Deacon wrote:
> > > > > > > I spoke to Brendan at LPC (?) last year but this doesn't really work
> > > > > > > for arm64 because it relies on being able to unmap arbitrary parts of
> > > > > > > the linear map, which isn't generally possible unless you force pte-level
> > > > > > > mappings for everything, which is prohibitive for perf/power.
> > > > > >
> > > > > > As per the cover letter it's about allocating pages that are not present
> > > > > > in the direct map. This essentially fits the protected DMABufs use-case
> > > > > > where we don't want any kernel mapping to exist at any time. Bufers
> > > > > > allocated from protected DMABufs are only meant to be accessed by the
> > > > > > TEE implementation or HW accelerators like in the secure media pipeline.
> > > > >
> > > > > That sounds like it should probably build on top of this series, then.
> > > >
> > > > The main problem I see with this series is it tries to move from the generic
> > > > CMA allocator to a reserved FF-A CMA pool which again comes from the
> > > > DT. We already support reserved pool allocations via "no-map" which are
> > > > discovered dynamically from OP-TEE.
> > > 
> > > I can't think of a way around a DT declaration. We need to know what region is
> > > PTE-level before the direct map is installed and of_reserved_mem is very handy
> > > for that purpose. And as this PTE-level mapping is costly we certainly only want
> > > to enable it for platforms that absolutely need it.
> > > 
> 
> I am rather thinking of a way to turn the default CMA allocator to be
> PTE-level mapped. Since the overall idea for this dynamic protected
> buffers was to reuse memory efficiently, otherwise the reserved buffer
> approach is already there to use as "no-map" via DT.

When the default CMA allocator is setup, it is already too late
(dma_contiguous_reserve() is called after map_mem()). I am not sure this can be
reordered easily due to the dependency on dma_limits_init().

So the only case it would work would be when a reserved memory has set
"linux,cma-default". 

-- 
Vincent

> 
> If we can have "cma_unmap" cmdline option alongside "cma" then it can
> turn the existing default CMA allocator to support unmapping buffers.
> Not requiring a DT change at all, although we can have the DT property
> for the default pool too if platforms want to opt for.
> 
> > > >
> > > > If we can rather support a generic CMA like allocator for arm64 which
> > > > can support unmapped allocations then I am all for it. These platform
> > > > specific reserved pools isn't a scalable solution.
> > > 
> > > What do you mean by generic CMA allocator here? An extension to
> > > shared-dma-pool? Or having the CMA automatically doing the unmap/map on
> > > cma_alloc() cma_release()?
> > > 
> > > Right now I have created an API for the unmapping/remapping part. It adds a
> > > burden on the caller, but the alternative solution is introducing post-alloc
> > > pre-dealloc callbacks in the CMA, which looked a bit overkilled to me when
> > > the users of that "ffa-pool" are only optee and the nvidia video dma-buf heap.
> > > 
> 
> I am not too worried about where the actual implementation lives but
> looks like CMA driver to be the better place. I think use-cases like
> guest_memfd proposed as a user for __GFP_UNMAPPED on arm64 will also be
> looking for this feature.
> 
> -Sumit
> 
> > > 
> > > >
> > > > > You could allocate the DMABufs from a CMA region that has no linear alias.
> > > >
> > > > Allocation from generic CMA pool is already the case here:
> > > >
> > > > tee_shm_alloc_dma_mem() ->
> > > >   dma_alloc_pages()
> > > >
> > > > Do you mean it's just fine to unmap buffers allocated from generic CMA
> > > > region since it doesn't have any linear alias?
> > > >
> > > > >
> > > > > > > Vincent's series tackles that by using a pool so that only that part of
> > > > > > > memory requires the pte-level mappings in the linear map. That's the
> > > > > > > whole point of it, so I don't think it makes sense to drop it in favour
> > > > > > > of Brendan's approach (which doesn't work).
> > > > > > >
> > > > > >
> > > > > > For protected DMABufs, we even don't require any pte-level mappings in
> > > > > > linear map. The whole idea of mapping and unmapping is just a bottleneck
> > > > > > for performance sensitive secure media pipeline use-cases. That's why if
> > > > > > we can support __GFP_UNMAPPED with the memory allocator on arm64 would
> > > > > > be the best fit for this use-case.
> > > > >
> > > > > The point is that you will require pte-level mappings for the linear map
> > > > > if you want to unmap from it at runtime on arm64. If you don't, then you
> > > > > can end up needing to split a block mapping (e.g. pmd-level) when you
> > > > > decide to unmap only part of it and there isn't a safe way to do that on
> > > > > arm64 without transiently unmapping the entire block, which can lead to
> > > > > fatal translation faults during that window.
> > > >
> > > > I agree with you here, what I am rather trying to find if on arm64 there
> > > > is any possibilty to have a generic allocator for unmapped pages. That's
> > > > the use-case here as well as what Brendan't patch-set was trying to address.
> > > >
> > > > >
> > > > > > Now the question is why arm64 can't support __GFP_UNMAPPED similar to
> > > > > > how Brendan is doing it for x86?
> > > > >
> > > > > Because arm64 != x86? Presumably x86 doesn't have the strict
> > > > > break-before-make requirements we have on arm64.
> > > > >
> > > >
> > > > Sure, sounds like you are eluding to that the generic MM flag
> > > > __GFP_UNMAPPED being proposed can't be supported on arm64, right?
> > > >
> > > > -Sumit
> > 
> > -- 
> > Vincent
