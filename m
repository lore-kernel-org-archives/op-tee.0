Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39962CA5FFD
	for <op-tee@archiver.kernel.org>; Mon,  5 Oct 2026 11:03:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7099544F0F
	for <op-tee@archiver.kernel.org>; Mon,  5 Oct 2026 11:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791198190;
	bh=XggvK/mbkYFgVJaPngBSf0EJ89oLS951tOm4dDdAJ9E=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=kyaVMpZQoLko1J4185pTG2nmwDwc47MDao+MNRC6ppxcN1t5gWPwUkSl/1meN8mGH
	 5tP+PEWdr+sxjdigWx8c5S9R5iyOoKFEVUq7bLK22eRNbHp46RBPOWPlIKdGm3oO9M
	 nNSyvrjm7FyurN8Ylk0oODPOaygGPLegorOXgak2ATABEuEtw0vOBpX6EixotHnMIr
	 43DhDNeY90gMO4apQ1/xHGlzQhdS1lsn/oe5F3WnKHxs05t0lmHR8y+NZUVYWnt9I4
	 uy+woLd7BIWFvhfNIctniUj0qEHy0qAsxqHnlXj452iJO9TfmBcw6dG3+wgJNG+Bdi
	 CB+3LtxWdHgfg==
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8658744A43
	for <op-tee@lists.trustedfirmware.org>; Mon,  5 Oct 2026 11:03:03 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tvMPKws7;
	dkim-atps=neutral
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887840c529so530942f8f.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 05 Oct 2026 04:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791198182; x=1791802982; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wpVjroXVisHfj83brLQUbqEhnPiyl/yiKfc5znuepio=;
        b=tvMPKws7CFsjLd4HnWCFU2XgjicixoSsWN80RXGsB5XNWjKpema11JpMUaKLKMwjl6
         kmv2pPhQZa447jLPFHQFRM7IFzzkcZ//5+goTxoQSU1Gvbrl2hZgEk08EiL9MYft4DIO
         HJGw4Y2N1nagsmL7a3qM2A4W+MShCAOxCMUHSsq1QiqtKqg7BC34qQguFWGnD/MQeJSQ
         AfSdXwjtttB4fHGOjIcsw5NKL35Wlr2Q9WQRimYkEYs/RzCsycsHDRJsJEElbm5pqIUS
         NEp8pnw6SJQkWVnV/Z5Y0s+U81ShkUsjSXOxrTO9KNIqJGH5/tBzYDGFqBSnHRZcJuf0
         /k7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791198182; x=1791802982;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wpVjroXVisHfj83brLQUbqEhnPiyl/yiKfc5znuepio=;
        b=S1PQCkP1hL89C6Qb7gLAQFjOWjJi8HV3QFrga0UOOlHxGdECaMixa1Yg6hC+CAcFDc
         AXaT359Y/aPvHy05bOv6kvyPTCdsuj1fF6dMUiikmPTCBLo4FuJusmxo7vOiLG2mLdgs
         gjH5yTBV+YIc4l86T4r//BYN4q4M2Mn4thoKT0OlFpJH1mtivTMAsqPUxsI6mQAUvoq1
         ZZPkYC0ic6uu9EADwJwGa6UHlNrd65hkjx1tAuPjQa75rVvYl4uY4zb6GOMT+J5/wiWw
         EtLDfbna5FQfuab/wuH8jyWl/rQTyk3kMY/+gdmgNKUupfVB35pkKB+6JEiSJDrIVmi0
         FSVw==
X-Forwarded-Encrypted: i=1; AKwUvByDxtfWr/OdNhiQ4RTri4N7hI6fzEgBp7zr/vPHtjLgx20B1ApDiyiJs8pqB6chkNyszuRrsoU=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYL9dhnYAHKf9KyOqmSzikC1cRhyzwMUquVdHDPGX8uvuVc3o7N1
	fevN2beIAJARCy1V81GcHmg1YL8Vfvv1EYiLhw1/V1XY8DVPCU3cJs+aqDkH+bVn3w==
X-Gm-Gg: AYBFou3+N3rsDT3M3DnRmpUB764XIQwU9G6qQC31U8MET5S5ePjIRr5lFLiBgMr7aLe
	ilpY+mZqXjlOIq8uV/DuFWj+0SZP7DuW9ADfib98UOe4rE9Q/w8BIqBeq3qz9JSdZKOf2uxDltX
	q4twLOpDXYnqFjRuii8wr/VcqkQkUjkQNttTHgRnbHHTDMmRCMbpF1kFSYShSdtHpEE0xYkMA5U
	GKcSp8aWkZKE8xve2xKM11m+ckv7WD0NVdsGuOfyLC2EZq7UyVHANpMrntyXpOwDkFoULTnsfHn
	2V083z5FCiIAK5SHCEGySk7e2KZE4h1IcO3Ly/m4mz03ObJVT4VlKFvYCl+GsbV7bXLiXQZYyeO
	nj5qKcVbkL/dnmTJbtReyGVBmifr9OD9H297JC+14QKumV3QY2SaOtoabFpkBqV3G8byB9ZY41H
	0hsvCG5GIM8+R84SMpn9teICfZNRjWdBqcM+XlOFISD5U6yJ1szMvj9CrpwVG4sHCdGju6B7Z3g
	rAyMDF4WYDdLBVNnsmUXK4KQlLMm0eSwK0RbbRz1WU=
X-Received: by 2002:a05:6000:2906:b0:487:13a9:80d with SMTP id ffacd0b85a97d-48b12733c50mr18086704f8f.10.1791198180653;
        Mon, 05 Oct 2026 04:03:00 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c6227fa65sm2880630f8f.16.2026.10.05.04.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 04:02:58 -0700 (PDT)
Date: Mon, 5 Oct 2026 12:02:55 +0100
To: Will Deacon <will@kernel.org>, brendan.jackman@linux.dev,
	catalin.marinas@arm.com, rppt@kernel.org, akpm@linux-foundation.org,
	sudeep.holla@kernel.org, jenswi@kernel.org, robh@kernel.org,
	mark.rutland@arm.com, ardb@kernel.org, thierry.reding@kernel.org,
	david@kernel.org, danielmentz@google.com,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] arm64: Unmap FF-A lent memory from direct map
Message-ID: <asOD31rTX6dNfD1o@google.com>
References: <20260921110050.3977591-1-vdonnefort@google.com>
 <arIYtjmSKCs14SqO@sumit-xelite>
 <arKW_91EeKA-w96m@willie-the-truck>
 <are21BjeS1O3RYE3@sumit-xelite>
 <aruh86rd5FMv2i9G@willie-the-truck>
 <ar5TPvANFUoosxGW@sumit-xelite>
 <asOAYODGZa-7EIV1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asOAYODGZa-7EIV1@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:74.125.0.0/16];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.225.99:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:74.125.225.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[19];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[google.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[74.125.225.99:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8658744A43
X-Spamd-Bar: ----
Message-ID-Hash: JPWVZQFYIODRTYFHMCOAD7SBPFOU7AYM
X-Message-ID-Hash: JPWVZQFYIODRTYFHMCOAD7SBPFOU7AYM
X-MailFrom: vdonnefort@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: sumit.garg@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JPWVZQFYIODRTYFHMCOAD7SBPFOU7AYM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

Sorry, not sure why Sumit's email was dropped...

On Mon, Oct 05, 2026 at 11:48:00AM +0100, Vincent Donnefort wrote:
> On Thu, Oct 01, 2026 at 06:04:06PM +0530, Sumit Garg wrote:
> > On Tue, 29 Sep 2026 at 12:33:07 +0100, Will Deacon wrote:
> > > On Sat, Sep 26, 2026 at 05:43:08PM +0530, Sumit Garg wrote:
> > > > Looks like you dropped me from your reply.
> > > 
> > > Huh, that's weird. If I hit reply-all ('g') in mutt, it moves the entire
> > > CC list to To: and drops you. I suspect the same thing happened to Thierry
> > > when he replied here:
> > > 
> > > https://lore.kernel.org/all/arJcN60nagFKXj2Q@orome/
> > > 
> > > I can't figure out why that's happening :/
> > > I manually tried to fix the To: and Cc: lines in this message.
> > 
> > Thanks.
> > 
> > > 
> > > > On Tue, 22 Sep 2026 at 15:55:59 +0100, Will Deacon wrote:
> > > > > I spoke to Brendan at LPC (?) last year but this doesn't really work
> > > > > for arm64 because it relies on being able to unmap arbitrary parts of
> > > > > the linear map, which isn't generally possible unless you force pte-level
> > > > > mappings for everything, which is prohibitive for perf/power.
> > > > 
> > > > As per the cover letter it's about allocating pages that are not present
> > > > in the direct map. This essentially fits the protected DMABufs use-case
> > > > where we don't want any kernel mapping to exist at any time. Bufers
> > > > allocated from protected DMABufs are only meant to be accessed by the
> > > > TEE implementation or HW accelerators like in the secure media pipeline.
> > > 
> > > That sounds like it should probably build on top of this series, then.
> > 
> > The main problem I see with this series is it tries to move from the generic
> > CMA allocator to a reserved FF-A CMA pool which again comes from the
> > DT. We already support reserved pool allocations via "no-map" which are
> > discovered dynamically from OP-TEE.
> 
> I can't think of a way around a DT declaration. We need to know what region is
> PTE-level before the direct map is installed and of_reserved_mem is very handy
> for that purpose. And as this PTE-level mapping is costly we certainly only want
> to enable it for platforms that absolutely need it.
> 
> > 
> > If we can rather support a generic CMA like allocator for arm64 which
> > can support unmapped allocations then I am all for it. These platform
> > specific reserved pools isn't a scalable solution.
> 
> What do you mean by generic CMA allocator here? An extension to
> shared-dma-pool? Or having the CMA automatically doing the unmap/map on
> cma_alloc() cma_release()?
> 
> Right now I have created an API for the unmapping/remapping part. It adds a
> burden on the caller, but the alternative solution is introducing post-alloc
> pre-dealloc callbacks in the CMA, which looked a bit overkilled to me when
> the users of that "ffa-pool" are only optee and the nvidia video dma-buf heap.
> 
> -- 
> Vincent
> 
> > 
> > > You could allocate the DMABufs from a CMA region that has no linear alias.
> > 
> > Allocation from generic CMA pool is already the case here:
> > 
> > tee_shm_alloc_dma_mem() ->
> >   dma_alloc_pages()
> > 
> > Do you mean it's just fine to unmap buffers allocated from generic CMA
> > region since it doesn't have any linear alias?
> > 
> > > 
> > > > > Vincent's series tackles that by using a pool so that only that part of
> > > > > memory requires the pte-level mappings in the linear map. That's the
> > > > > whole point of it, so I don't think it makes sense to drop it in favour
> > > > > of Brendan's approach (which doesn't work).
> > > > >
> > > > 
> > > > For protected DMABufs, we even don't require any pte-level mappings in
> > > > linear map. The whole idea of mapping and unmapping is just a bottleneck
> > > > for performance sensitive secure media pipeline use-cases. That's why if
> > > > we can support __GFP_UNMAPPED with the memory allocator on arm64 would
> > > > be the best fit for this use-case.
> > > 
> > > The point is that you will require pte-level mappings for the linear map
> > > if you want to unmap from it at runtime on arm64. If you don't, then you
> > > can end up needing to split a block mapping (e.g. pmd-level) when you
> > > decide to unmap only part of it and there isn't a safe way to do that on
> > > arm64 without transiently unmapping the entire block, which can lead to
> > > fatal translation faults during that window.
> > 
> > I agree with you here, what I am rather trying to find if on arm64 there
> > is any possibilty to have a generic allocator for unmapped pages. That's
> > the use-case here as well as what Brendan't patch-set was trying to address.
> > 
> > > 
> > > > Now the question is why arm64 can't support __GFP_UNMAPPED similar to
> > > > how Brendan is doing it for x86?
> > > 
> > > Because arm64 != x86? Presumably x86 doesn't have the strict
> > > break-before-make requirements we have on arm64.
> > > 
> > 
> > Sure, sounds like you are eluding to that the generic MM flag
> > __GFP_UNMAPPED being proposed can't be supported on arm64, right?
> > 
> > -Sumit

-- 
Vincent
