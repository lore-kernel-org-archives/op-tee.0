Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBEEC79F99
	for <op-tee@archiver.kernel.org>; Mon,  7 Sep 2026 17:03:48 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E19D14539D
	for <op-tee@archiver.kernel.org>; Mon,  7 Sep 2026 17:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788800628;
	bh=yci8SCVSj/c4byzd49bd5AwR54pen4y2tBI3v+juCjg=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=oXX+xgHwSKJ2z+sNiise8bPPQjMK4TeRT/YPLlozYW+VXWdV+yFYWc2SiZAOAIb/z
	 faeNNtJE9Ef5zZhCfBHegYNoRCbURdJpHrcnnt03ylyp3saFZQUDN7SBrdiiivS8As
	 fk6fReOhHBMeWXyaIRQtpAj2P++n1smgGpfvHZFZeTDswok0DfLIHC1tiR2sLmJ1B6
	 7uEKLSR0CiTeazZobCzH/HrqSVcrAWdEIsmz97TXA4Weo/B6aMvhXx9CyM/YRBRKjd
	 kP2kAh84NnK7BjkvEycdzdi3YwI5K1FiP2VBPhv7dFeeEjFDDREI4AXWXjEXaHNl+v
	 M84FTAIyzyCoA==
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BA9D0434A5
	for <op-tee@lists.trustedfirmware.org>; Mon,  7 Sep 2026 17:03:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rvtXkbZ2;
	dkim-atps=neutral
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-484362f5c4aso4735968f8f.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 07 Sep 2026 10:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788800619; x=1789405419; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D/2WLxDmERbGCh7iT/2ZThPPuDMwAWqV6GCdXRr20bA=;
        b=rvtXkbZ2EjE2A7IaMt7zdYe5u8uBsW++8DPzeCwcaCUKjoc1BrhqlIh6xW/Ynqqm+Y
         QmEEpBpWn6ePuDCf/AOi3700B0Cp2SS7sOCqva6T1eJLnlgMK6tLRY/qNkhW7M4PNmXf
         7aLsPNzhwqupUlDQSfW9279qGZiJ9xqoKF4W098QfGiPhhslgtgULFcBwaGady1NrcRU
         xAGcifcQY6tvV9uN2S5VV4g+L1Oaz7wJiv4E611D/6vWfjiv9qdfQuuzX5guMOhKoV/G
         RulpTI+Nsq96TCwBgaOtBCOO0x2lOm1W0y1O2ggylMw8YQRikkpEpdQYcjBUlyA26XtA
         GCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788800619; x=1789405419;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D/2WLxDmERbGCh7iT/2ZThPPuDMwAWqV6GCdXRr20bA=;
        b=XTH3KVv0BbvILLlyq/nZvDo42he4GW9QMn/b9o/v3bVlhQ79vJxjfuA2ND+rglNwsS
         FLHdpXYfiaJl5eTEUE1EgvU0H6rt7NO5R6S/ok92SOy1q+pw2Xc4t4XrT0Iyv6I7dRoc
         XQbp7UotTD9SvBj20m37OlIOXYEX9tYG5Qd0BMPNcVXxftjBXWoohiclcgU0eZMHLOJV
         Znsw+frbUyRbpBcExDFy8KHWRTil46KMqTftb5UeV6ADPgAwi/Q8aE1xk5NOSIrdM7qR
         +EJYv6BPe3XP4RJh5g52RiQ9l3oq7kvUP5IMxfAyw7aEylCgTpBhin8jVVhWQ2QugkmD
         P94Q==
X-Forwarded-Encrypted: i=1; AKwUvByC7U53kzFCtLYeXaY8CuwaRJpx5D/qT/6HaO/O3CYo+PeGHydgUpURd1Ui+k2Tp84unj0M2Uk=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mCNaSWRxrgPWd/pRU75IMNK0/e6372cTBV1mWqqlAloHL1RhKW
	ZBvh/lVbiHI8SLyK1Pw0S8nnOcJ4NvUeTh+ux4dPjr2SPapWlffJ5vtUEpfdABjHPQ==
X-Gm-Gg: AYBFou1obtb28i692SCtzA5zk7ZW00Kyb6aqgkc8r079I5Ea2JtTGvQMpBR1Av9ve3C
	PvtT65HwiAe65HOrVfBvL+sPKyNcxxHWF6Oyz9rQt5KqqtRmobslL0S2YuktF4PDuqgEwqrrXmZ
	qWcNtVt+o+EPBIQbZ8twbSqVpwwvKcrdDYqVsIGet41V/7+LD4dZWNVXU/qaMS+3zYzAFABmVpZ
	/xoQDi8fTD93N8ip8t8DrAKDZ5UhMAedGp4IfYgRpqe1FW5JFJTJZC6PYZ5bCqXb5ZEDi4sTk3q
	UqGZtbo2QGjEM4+0EiViXuksj+JQZjA/3P4dGGeFUT29F0vos7icFIKMJit+6vHs1OB16+81TJQ
	w6tTSMRL0V9UI0eA+rMycedZ062c8rm84h6z4qj4E+vz9rnX2iwPY7hRCZUCKN3qQazZ/1RJNkW
	Ej5GWPR3d9F+V4EhfB9LHlFSkcEsLtihlrZ6NAaubo0raJOUuuF/vPYxt5EgIRVFW8Qaj19pL2X
	fdeYe1Dih3mvElKkmFKmVB5Rx9OX1Qv
X-Received: by 2002:a05:6000:605:b0:485:8b66:f5 with SMTP id ffacd0b85a97d-4858b660161mr42549469f8f.18.1788800618759;
        Mon, 07 Sep 2026 10:03:38 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883927a3sm23089736f8f.11.2026.09.07.10.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 10:03:38 -0700 (PDT)
Date: Mon, 7 Sep 2026 18:03:34 +0100
To: Thierry Reding <thierry.reding@kernel.org>
Subject: Re: [PATCH v9 02/10] of: reserved_mem: Introduce "ll-map" property
Message-ID: <ap7uZuGraZ2N58c_@google.com>
References: <20260902104712.2399797-1-vdonnefort@google.com>
 <20260902104712.2399797-3-vdonnefort@google.com>
 <20260902172436.GB1440252-robh@kernel.org>
 <aplF4NaoFk73d-c5@google.com>
 <ap7CAowlFTFhSFP9@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap7CAowlFTFhSFP9@orome>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.43:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.221.43:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BA9D0434A5
X-Spamd-Bar: ---
Message-ID-Hash: JJ3L7KG3ZEZEEOT7BZOWYIPKXXVEHYWA
X-Message-ID-Hash: JJ3L7KG3ZEZEEOT7BZOWYIPKXXVEHYWA
X-MailFrom: vdonnefort@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Rob Herring <robh@kernel.org>, catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JJ3L7KG3ZEZEEOT7BZOWYIPKXXVEHYWA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

On Mon, Sep 07, 2026 at 04:00:19PM +0200, Thierry Reding wrote:
> On Thu, Sep 03, 2026 at 11:03:12AM +0100, Vincent Donnefort wrote:
> > On Wed, Sep 02, 2026 at 12:24:36PM -0500, Rob Herring wrote:
> > > On Wed, Sep 02, 2026 at 11:47:04AM +0100, Vincent Donnefort wrote:
> > > > Keeping last-level mappings is interesting on some architectures as it
> > > > allows mapping/unmapping pages from the kernel direct map without the
> > > > risk of splitting blocks which, under the break-before-make rule, may
> > > > trigger page-faults the kernel can't handle.
> > > > 
> > > > Add an "ll-map" property for reserved-memory regions. When set, it
> > > > splits the underlying memblock and sets the MEMBLOCK_LLMAP flag.
> > > 
> > > Where is this documented? Any DT property must have a schema.
> > 
> > Ack.
> > 
> > > 
> > > Though I'm not thrilled about more flag properties. Handling all the 
> > > combinations of properties has proven to be painful. Can this be implied 
> > > from the compatible string instead?
> > > 
> > > Rob
> > 
> > We need this before the kernel direct map has been created (paging_init()).
> > 
> > I would have moved that directly into the driver lend_pool.c, but then it is
> > probed too late (unflatten_device_tree()).
> 
> Any of the node_*() callbacks from struct reserved_mem_ops get called
> prior to paging_init(), so these could be used to manually set the
> memblock flags in the corresponding drivers.
> 
> Thierry

Ha yes my bad, early_init_fdt_scan_reserved_mem() is calling ->node_init()

So I should be able to drop this patch entirely to do set memblock_set_llmap()
(or memblock_set_pte_map()) directly ino the that new FF-A lend_pool driver.

-- 
Vincent
