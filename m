Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA767C61DD6
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 17:24:45 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EB7384532C
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788369885;
	bh=O2HTZ8oMi/55GiW97GxYG2jCA376NJNvFoe5bFDZISQ=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=gaypfuewf03JGJyrCCYUV8J4TPzsW5MbqtT3t27EI9PZ2zwoJxAXuVajzBAfvWN6W
	 WzYjJKbgPiLybnprqZPFHOrftprdGsk+WT2ChLR+yJuB5CdBrb0cGqLA4JTCh014ib
	 xYNcm0xkvMcSI+Lx8zrm1wQSKF0Al/eacpgAqSZ9US9dpBfRKsXr69CJswpLtrJmYX
	 AnyQ9Lo28wCw84hN72r1vJz/CbEzDHcVmAeINZ13sLA8SkdEIsPMYw4vJG/CpwGRel
	 Vd4PCbTeVXkCSwynRDhExYuXb7RZhkoEBfmJCNd6MvZgr1+ChlmW+azjTkD28UA6YN
	 ZfjCgBs2dhvGw==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0610D44FD4
	for <op-tee@lists.trustedfirmware.org>; Wed,  2 Sep 2026 17:24:38 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXiOsd0I;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4BF7E40273;
	Wed,  2 Sep 2026 17:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1164D1F000E9;
	Wed,  2 Sep 2026 17:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788369877;
	bh=l3/1naZ1RhLgUWY856SAbE6LeQ8PQwzS4dxBvl1l3nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DXiOsd0IOwaWcqNMcESpWf4hFCXAp8Wnr0mmhtnowdnpJUppd8Az9ulZWwyJ2Uu4R
	 wkSOKrsgXyrCbsZ4Ej8dCHAUO3I/4HPgFL476eGN0P/8NbBkNtGVWoaVvzxq629JSE
	 MNyjdmuBfdWD9tp2ye9BdSsE7IZfLQ6ow1ntz6mprCCXuVX0AkCxGb50BYmQW7oBbd
	 MPaDcJNFaSVqAkwRbQfma7hfoYES0jZcC+6XyiyrsPbnOzs3CpqliBh6dejcYwxVGB
	 pQAl1sebDUlr62/dzSyXwzrWVKPVJmhKguUHvxr/r+W7Qs+BOd/D226mZ36jtpIbUb
	 BuzrSWHmpSLjQ==
Date: Wed, 2 Sep 2026 12:24:36 -0500
To: Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v9 02/10] of: reserved_mem: Introduce "ll-map" property
Message-ID: <20260902172436.GB1440252-robh@kernel.org>
References: <20260902104712.2399797-1-vdonnefort@google.com>
 <20260902104712.2399797-3-vdonnefort@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902104712.2399797-3-vdonnefort@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.82 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	BAYES_HAM(-1.82)[93.94%];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received,172.234.252.31:from];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0610D44FD4
X-Spamd-Bar: ------
Message-ID-Hash: JOVDEHFJQHHCGDM4T2QO3MFPE2CTT567
X-Message-ID-Hash: JOVDEHFJQHHCGDM4T2QO3MFPE2CTT567
X-MailFrom: robh@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JOVDEHFJQHHCGDM4T2QO3MFPE2CTT567/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Rob Herring via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Rob Herring <robh@kernel.org>

On Wed, Sep 02, 2026 at 11:47:04AM +0100, Vincent Donnefort wrote:
> Keeping last-level mappings is interesting on some architectures as it
> allows mapping/unmapping pages from the kernel direct map without the
> risk of splitting blocks which, under the break-before-make rule, may
> trigger page-faults the kernel can't handle.
> 
> Add an "ll-map" property for reserved-memory regions. When set, it
> splits the underlying memblock and sets the MEMBLOCK_LLMAP flag.

Where is this documented? Any DT property must have a schema.

Though I'm not thrilled about more flag properties. Handling all the 
combinations of properties has proven to be painful. Can this be implied 
from the compatible string instead?

Rob
