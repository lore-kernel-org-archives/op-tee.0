Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99127C79FA1
	for <op-tee@archiver.kernel.org>; Tue,  8 Sep 2026 10:18:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AD22744EEF
	for <op-tee@archiver.kernel.org>; Tue,  8 Sep 2026 10:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788862687;
	bh=REefT6Y4BF9qgcV86uQSOz0t9HuJ3hYnZlBIuoh/3Xs=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=2xSJyagd1jx3gUyxeEsIsUQo5xs5MM/wqDRyyIo1n/of/HcAuug14JWNOli7tk36g
	 YgzjI0F5BGTo3Q8AYoWxQqPLHULs+MPskzkBYR41QgaIn/WhWXjurFlj1BRdZlhm+N
	 mHrIjPRwBbBXnFJNOwBJbyWzyXjUnBxgwAqWWR2UckWsZe8gEqsaMAHapMfx+jWNvh
	 4IN9TmBtnNVI0yBqgxvN0i9uU1r3p6lNErY1jtutWgbXP44b1XWsN6x9e8e2Joj87A
	 x2zyYprGb4elBzRI4EqbEXXdqQRiuQoMFvMSZhAr2Qm+8Wf/p29dg5UHFOvdYOaF54
	 Nk4PW6E25AxEA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C699E44E12
	for <op-tee@lists.trustedfirmware.org>; Tue,  8 Sep 2026 10:18:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MwavFRK/;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5C2D5601DB;
	Tue,  8 Sep 2026 10:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798C01F00A3A;
	Tue,  8 Sep 2026 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788862680;
	bh=1BUq9DqNfvFJpJpxO4ESAHte1Bx4yrvo0vCrnSZ9Wno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MwavFRK/ztSyhXEhkjmbGgqiZw9sxr6mV1TbmhsRFf12TB/TYGglIbkUGeV7tUtxg
	 F148rzwylaMteqXTQlfgqCpYKWA3xLRuiSk/6ZuEdUVkyxHT5HaPDlNP0bbVm6Mp4p
	 FjSWVQUHDyaswMIHtvx1lOd10oe48Ss+ENBMUdnmWGrLP856Z/MdRVE992y9WKpPde
	 +MjO72CMnbl+RMjRI6UWUrE7V/VLv19l77g/zVYAe07/V28dqEfQXF1MRWhBgAn38K
	 WdW1TZooWTeccR2yS/OgrcO2v9FkbaEz0BGcv51hlHvuCPSmslvFgE1NzbkgrltoCJ
	 qqFQ5EJFaso2A==
Date: Tue, 8 Sep 2026 13:17:50 +0300
To: Thierry Reding <thierry.reding@kernel.org>
Subject: Re: [PATCH v9 01/10] memblock: Introduce MEMBLOCK_LLMAP
Message-ID: <ap_gztTqHQv_GD35@kernel.org>
References: <20260902104712.2399797-1-vdonnefort@google.com>
 <20260902104712.2399797-2-vdonnefort@google.com>
 <ap2_926WXr7uAYVX@kernel.org>
 <ap6I1FN_2ylRzFXH@google.com>
 <ap-74AkHSGXbFCF_@kernel.org>
 <ap_RRSM7RBONvHaR@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap_RRSM7RBONvHaR@orome>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[18];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C699E44E12
X-Spamd-Bar: --------
Message-ID-Hash: YP37JSKZDTH5VNGHW2YCQNPY3Z7KLTW7
X-Message-ID-Hash: YP37JSKZDTH5VNGHW2YCQNPY3Z7KLTW7
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Vincent Donnefort <vdonnefort@google.com>, catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YP37JSKZDTH5VNGHW2YCQNPY3Z7KLTW7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mike Rapoport via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mike Rapoport <rppt@kernel.org>

On Tue, Sep 08, 2026 at 11:18:53AM +0200, Thierry Reding wrote:
> On Tue, Sep 08, 2026 at 10:40:16AM +0300, Mike Rapoport wrote:
> > On Mon, Sep 07, 2026 at 10:50:12AM +0100, Vincent Donnefort wrote:
> > > On Sun, Sep 06, 2026 at 10:33:11PM +0300, Mike Rapoport wrote:
> > > > On Wed, Sep 02, 2026 at 11:47:03AM +0100, Vincent Donnefort wrote:
> > > > > Keeping last-level mappings is interesting on some architectures as it
> > > > > allows mapping/unmapping pages from the kernel direct map without the
> > > > > risk of splitting blocks which, under the break-before-make rule, may
> > > > > trigger page-faults the kernel can't handle.
> > > > > 
> > > > > However, mapping the entire direct map at PTE-level is costly. So
> > > > > instead, create a new memblock flag MEMBLOCK_LLMAP to enable the system
> > > > 
> > > > I believe MEMBLOCK_PTE_MAP sounds more descriptive.
> > > 
> > > The idea was to have something close from NOMAP, to emphasis it is one or the
> > > other. But PTE_MAP sounds good too.
> > 
> > Could be PTEMAP if you prefer.
> > My point was that unlike PTE, "LL" is not perceived as last-level, it
> > should be looked up.
> 
> We were discussing the concept of enabling entire block mappings to be
> removed at once from the linear map, so at that point "PTE"MAP may no
> longer be accurate.
> 
> I imagine that in some scenarios we might be able to go to PUD mappings
> for something like VPR (say systems with a fair amount of system memory
> and we want to carve out 4 GiB for VPR, split into four 1 GiB chunks).

_LEAFMAP then? ;-)
 
> Thierry



-- 
Sincerely yours,
Mike.
