Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35343C79F82
	for <op-tee@archiver.kernel.org>; Tue,  8 Sep 2026 07:40:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4E447452BB
	for <op-tee@archiver.kernel.org>; Tue,  8 Sep 2026 07:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788853233;
	bh=ZtFakq1jv5kY3gc+C31c5UpPcSkh4Cx4U7/nyTG5QSc=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=EqEGuTAEiUN7yEKY8jCMv6W0PsQ6KisKU8pCGhCEBHdmkNo6p+8n+A9SY1mTPT55e
	 nmX4kTQ/YXq/ZqChcL3bFq9yEGkU0EIFrNeNOM+MEqt983BvmtCcdaNSbTl6MGP0Ra
	 XwyWObJwuErzVEWilsNhj8lfI+eq0Lt7r0ba7iROw2+JUL5XEBG4BidbMsKF+SjbPV
	 qztkMLLPK8FdbydiTUEZjjcbrT55B5z54VW2Jz8TyvQ5FdVSD39/iMMUW7S29XRwPM
	 DvPWGsd44dltP2iYIptUKsrOkvV7QjfAliFOt7wb8fO3WJ3UabqQ9F9wwbR53wxW9G
	 TKumoQshEkjYQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 52DC444230
	for <op-tee@lists.trustedfirmware.org>; Tue,  8 Sep 2026 07:40:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iVpMzVBV;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C8D3B60A97;
	Tue,  8 Sep 2026 07:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FCE1F00A3A;
	Tue,  8 Sep 2026 07:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788853225;
	bh=dW0Bt6wVwx6uYNJdG4bnYanuxC0mWdhwlxmUwvkpPtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iVpMzVBVDpbbjmSmLjf9/u1y3Rr+zfuCTrDmGqoJwDmagIYgicropXMGIej4xSaxg
	 6cLeStx2+JupYI5v46SFH93vN1pLOaqi+71OxT+0bOJXF46WT8TIADUbfXr6wM0X6y
	 j1wQEMfYEqkJp0+VVHTg+hRXEBocWl2PZ2Gxdqa96QFMigsr2ZMs+aOiSh09Bl9Nce
	 OQjSjvU/RbtJveqJElRlq/Pv63+Uov2SfEkKZ+0O2mOCeEHPy0le7Mc8q36JU8dfL3
	 taQ9sUCphHLYu4/BTPtAXLlD5cjXs4iaTH5w84MhhGeyR7IHE6ys0J1mEfDUQfC1JJ
	 3Xxl0cUO8U+Uw==
Date: Tue, 8 Sep 2026 10:40:16 +0300
To: Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v9 01/10] memblock: Introduce MEMBLOCK_LLMAP
Message-ID: <ap-74AkHSGXbFCF_@kernel.org>
References: <20260902104712.2399797-1-vdonnefort@google.com>
 <20260902104712.2399797-2-vdonnefort@google.com>
 <ap2_926WXr7uAYVX@kernel.org>
 <ap6I1FN_2ylRzFXH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap6I1FN_2ylRzFXH@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.98 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-2.98)[99.89%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[18];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 52DC444230
X-Spamd-Bar: --------
Message-ID-Hash: GXHMBUKNZMCJF6OWKDWSVLS7RVB2NIDQ
X-Message-ID-Hash: GXHMBUKNZMCJF6OWKDWSVLS7RVB2NIDQ
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GXHMBUKNZMCJF6OWKDWSVLS7RVB2NIDQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mike Rapoport via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mike Rapoport <rppt@kernel.org>

On Mon, Sep 07, 2026 at 10:50:12AM +0100, Vincent Donnefort wrote:
> On Sun, Sep 06, 2026 at 10:33:11PM +0300, Mike Rapoport wrote:
> > On Wed, Sep 02, 2026 at 11:47:03AM +0100, Vincent Donnefort wrote:
> > > Keeping last-level mappings is interesting on some architectures as it
> > > allows mapping/unmapping pages from the kernel direct map without the
> > > risk of splitting blocks which, under the break-before-make rule, may
> > > trigger page-faults the kernel can't handle.
> > > 
> > > However, mapping the entire direct map at PTE-level is costly. So
> > > instead, create a new memblock flag MEMBLOCK_LLMAP to enable the system
> > 
> > I believe MEMBLOCK_PTE_MAP sounds more descriptive.
> 
> The idea was to have something close from NOMAP, to emphasis it is one or the
> other. But PTE_MAP sounds good too.

Could be PTEMAP if you prefer.
My point was that unlike PTE, "LL" is not perceived as last-level, it
should be looked up.
 
> > > to decide which region must be covered by mappings up to the last-level.
> > > 
> > > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
>
> -- 
> Vincent

-- 
Sincerely yours,
Mike.
