Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B23CA5FF0
	for <op-tee@archiver.kernel.org>; Mon,  5 Oct 2026 10:48:17 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BB3D5452C2
	for <op-tee@archiver.kernel.org>; Mon,  5 Oct 2026 10:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791197296;
	bh=ubSttLXNMaUwsbAPAyklYDd9f5MzlxSqVoEXakDEc5Q=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=NXUAzJxMYpRfzdjH2g9IWbv3V1WkVMozdLDFPQJmosFPAlZkMYFsH3t97932bbddO
	 NKA58bNBrqksOWXg+x+TTlH1vGHoY0fO6OM3tQFuN1OCujoEmHffHDS3ImrqAbbZof
	 mPyAg3XLzqQ5OHCR/+nwMSq5rYY/ndsdOVwE4YfhsJ5Cn3Y+ITHeKeUDgps1mvTqeV
	 LE08/q6BRmHnsJdF+ecgaAIfz5Lr80D6AvaLS76o/greo8DJe6wNguN8x1Kp2zhVeT
	 iIAModmYRu4FVcoM63tLzd2+Wfx7T5sZxiRckswqb7yc06jpCASBnQsZE7udr1O7bW
	 i6dOMg78NMtzw==
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4D2303E882
	for <op-tee@lists.trustedfirmware.org>; Mon,  5 Oct 2026 10:48:08 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=CV5IkpHL;
	dkim-atps=neutral
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a1722c37c9so6144945e9.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 05 Oct 2026 03:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791197287; x=1791802087; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0E0kZNEEosSgGH99aMOAH+blyCZGVgX/b9FbaeaxoPo=;
        b=CV5IkpHLpQt8f/jUACH/M2T908cNOo2IFV7O7RDPYkQUVDlXrerdj0VY/Kktll098O
         IH4SMR4F2MXXOKZVBX6sxGAW5qpDrexu0BanAgwcwiTmXh516qfCUwpGEUDTC2B580bS
         qpgdOPIbakQD+cy5GpUD2t6rWR5AaCdvc3JuYnPDUmCgjgLQ4BfgePdGIE7NUbWOQB9M
         7c93nrc62GhZnG9S/s8vcz3BOc6xi5gwAW3wXbwsFIj8bcRV+0aV+eSOtN1KZzvNTpcM
         gIgnjuSkTKbr+d5cAyfalIYLpp7wTlWXkKSQHKF2tuJadNGX6PGTHMENXgtJ83Ak+guN
         AW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791197287; x=1791802087;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0E0kZNEEosSgGH99aMOAH+blyCZGVgX/b9FbaeaxoPo=;
        b=aOzIvj1JH/KF/DmV4zL/t8kg24aWbhugtUY3ckMz2bbA6GCl8nzS5uI2nrraQDYvgR
         KXUrSrjxuoAPLWitx/1K6GtmeEcO7897qg9dgsTIYMoHXOSXB527RAQ9Dw8wCKJXEZeO
         d5qQ/9xvxwV/9LbuKViLEuEXo9AkAFZFp8KSfddJgtjSBVd9WN+Y1kJSAc7UXmhya70C
         fqS2OyEPSeg/lKvqEoZpzBGVxM56TdMFLwsSW66tzlIFWVmfXJZ40usYdtWeViINIyVu
         lybnmUreZhdIAV8p1zYbRKH2iDZO0zNZo6HyiZWQmKPuP4x5wVqq34nL0qvKAD3G9/qZ
         Ne0A==
X-Forwarded-Encrypted: i=1; AKwUvBygN97b+fOsWs1Lgwmo+gDlXqsgPBaKPy8eVnJWFDwYLsxm4IvL7qkaHQa7MDFkwm3+4OoNAWc=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++l2TQ5XJRnEygGKeJbfAj2pVnSIucX5Aljw86dAHC4TReZ39spo
	yjLKvd8KYPFB5QUmljah8Xx7Ej0hvBlhD3QYpdOr2v5Fverci+e6f1ri6KlYO/VUEA==
X-Gm-Gg: AYBFou2DdfEeXqskz7WnHGLkX3cJz/ARAl9oDVSXAe2uRSnUte+Yrl64V81m7vtRB6J
	EqLQqMeUQgO1b74AEh9D7OtpuS6QMMBJmCneWAkWiqNr+st9QoanAjF8d2ZPJvf4Kps8Y3aBBMJ
	6th3mEpsI/b4gUXroy+YGFU+eRnox5VoVYGgHbs8Fp51cObpqKcvNy2RBoS+0unXyEuMdm35YCw
	McqzbULsuI+gecGlxLFFBTmPIM//Plaq/ZDbDHBxVYI3wvS7hL1+lTQvMRrhEru6/w16q4s8as4
	S19Sas6OeHJ48afg5LbrBobmbVwbzWolx5uJOK3DXPzlS41CxqyCJceFOdwNFrQ2Wv7+7YJ6ukV
	RT+9NrAowT05bPOakWl07jPn8SF7KCe5eOGd6NuZ3S1vb+3TC+ftx8KE/IUF7i3D7ofRUniMgtZ
	yzlwG7JJ1M3t1FGwK/xtBN7lf3VLaVN7i5hbMkV3MyrmFzLP1umwATLLe2lkgPKrhIfsLmwnA+3
	eKDBmc87Tv46dwRKmEU6a7RvnEQ9NOUxDHz15+ECTs=
X-Received: by 2002:a05:600c:a112:b0:4a1:7690:d878 with SMTP id 5b1f17b1804b1-4a17690d93emr7713595e9.17.1791197286488;
        Mon, 05 Oct 2026 03:48:06 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0e1afbc44sm329471285e9.4.2026.10.05.03.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 03:48:04 -0700 (PDT)
Date: Mon, 5 Oct 2026 11:48:00 +0100
To: Will Deacon <will@kernel.org>, brendan.jackman@linux.dev,
	catalin.marinas@arm.com, rppt@kernel.org, akpm@linux-foundation.org,
	sudeep.holla@kernel.org, jenswi@kernel.org, robh@kernel.org,
	mark.rutland@arm.com, ardb@kernel.org, thierry.reding@kernel.org,
	david@kernel.org, danielmentz@google.com,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] arm64: Unmap FF-A lent memory from direct map
Message-ID: <asOAYODGZa-7EIV1@google.com>
References: <20260921110050.3977591-1-vdonnefort@google.com>
 <arIYtjmSKCs14SqO@sumit-xelite>
 <arKW_91EeKA-w96m@willie-the-truck>
 <are21BjeS1O3RYE3@sumit-xelite>
 <aruh86rd5FMv2i9G@willie-the-truck>
 <ar5TPvANFUoosxGW@sumit-xelite>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar5TPvANFUoosxGW@sumit-xelite>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:74.125.0.0/16];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:15169, ipnet:74.125.225.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.225.140:from];
	DWL_DNSWL_BLOCKED(0.00)[google.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.225.140:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[34.140.183.197:received];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4D2303E882
X-Spamd-Bar: ---
Message-ID-Hash: TJNWVIG7GK3Q5QSIBLJ3623OKI46MXGE
X-Message-ID-Hash: TJNWVIG7GK3Q5QSIBLJ3623OKI46MXGE
X-MailFrom: vdonnefort@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TJNWVIG7GK3Q5QSIBLJ3623OKI46MXGE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

On Thu, Oct 01, 2026 at 06:04:06PM +0530, Sumit Garg wrote:
> On Tue, 29 Sep 2026 at 12:33:07 +0100, Will Deacon wrote:
> > On Sat, Sep 26, 2026 at 05:43:08PM +0530, Sumit Garg wrote:
> > > Looks like you dropped me from your reply.
> > 
> > Huh, that's weird. If I hit reply-all ('g') in mutt, it moves the entire
> > CC list to To: and drops you. I suspect the same thing happened to Thierry
> > when he replied here:
> > 
> > https://lore.kernel.org/all/arJcN60nagFKXj2Q@orome/
> > 
> > I can't figure out why that's happening :/
> > I manually tried to fix the To: and Cc: lines in this message.
> 
> Thanks.
> 
> > 
> > > On Tue, 22 Sep 2026 at 15:55:59 +0100, Will Deacon wrote:
> > > > I spoke to Brendan at LPC (?) last year but this doesn't really work
> > > > for arm64 because it relies on being able to unmap arbitrary parts of
> > > > the linear map, which isn't generally possible unless you force pte-level
> > > > mappings for everything, which is prohibitive for perf/power.
> > > 
> > > As per the cover letter it's about allocating pages that are not present
> > > in the direct map. This essentially fits the protected DMABufs use-case
> > > where we don't want any kernel mapping to exist at any time. Bufers
> > > allocated from protected DMABufs are only meant to be accessed by the
> > > TEE implementation or HW accelerators like in the secure media pipeline.
> > 
> > That sounds like it should probably build on top of this series, then.
> 
> The main problem I see with this series is it tries to move from the generic
> CMA allocator to a reserved FF-A CMA pool which again comes from the
> DT. We already support reserved pool allocations via "no-map" which are
> discovered dynamically from OP-TEE.

I can't think of a way around a DT declaration. We need to know what region is
PTE-level before the direct map is installed and of_reserved_mem is very handy
for that purpose. And as this PTE-level mapping is costly we certainly only want
to enable it for platforms that absolutely need it.

> 
> If we can rather support a generic CMA like allocator for arm64 which
> can support unmapped allocations then I am all for it. These platform
> specific reserved pools isn't a scalable solution.

What do you mean by generic CMA allocator here? An extension to
shared-dma-pool? Or having the CMA automatically doing the unmap/map on
cma_alloc() cma_release()?

Right now I have created an API for the unmapping/remapping part. It adds a
burden on the caller, but the alternative solution is introducing post-alloc
pre-dealloc callbacks in the CMA, which looked a bit overkilled to me when
the users of that "ffa-pool" are only optee and the nvidia video dma-buf heap.

-- 
Vincent

> 
> > You could allocate the DMABufs from a CMA region that has no linear alias.
> 
> Allocation from generic CMA pool is already the case here:
> 
> tee_shm_alloc_dma_mem() ->
>   dma_alloc_pages()
> 
> Do you mean it's just fine to unmap buffers allocated from generic CMA
> region since it doesn't have any linear alias?
> 
> > 
> > > > Vincent's series tackles that by using a pool so that only that part of
> > > > memory requires the pte-level mappings in the linear map. That's the
> > > > whole point of it, so I don't think it makes sense to drop it in favour
> > > > of Brendan's approach (which doesn't work).
> > > >
> > > 
> > > For protected DMABufs, we even don't require any pte-level mappings in
> > > linear map. The whole idea of mapping and unmapping is just a bottleneck
> > > for performance sensitive secure media pipeline use-cases. That's why if
> > > we can support __GFP_UNMAPPED with the memory allocator on arm64 would
> > > be the best fit for this use-case.
> > 
> > The point is that you will require pte-level mappings for the linear map
> > if you want to unmap from it at runtime on arm64. If you don't, then you
> > can end up needing to split a block mapping (e.g. pmd-level) when you
> > decide to unmap only part of it and there isn't a safe way to do that on
> > arm64 without transiently unmapping the entire block, which can lead to
> > fatal translation faults during that window.
> 
> I agree with you here, what I am rather trying to find if on arm64 there
> is any possibilty to have a generic allocator for unmapped pages. That's
> the use-case here as well as what Brendan't patch-set was trying to address.
> 
> > 
> > > Now the question is why arm64 can't support __GFP_UNMAPPED similar to
> > > how Brendan is doing it for x86?
> > 
> > Because arm64 != x86? Presumably x86 doesn't have the strict
> > break-before-make requirements we have on arm64.
> > 
> 
> Sure, sounds like you are eluding to that the generic MM flag
> __GFP_UNMAPPED being proposed can't be supported on arm64, right?
> 
> -Sumit
