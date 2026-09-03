Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F44C624A4
	for <op-tee@archiver.kernel.org>; Thu,  3 Sep 2026 10:03:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7D7D644ED1
	for <op-tee@archiver.kernel.org>; Thu,  3 Sep 2026 10:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788429808;
	bh=ntB9fs616qYfrLPBRKjSLmOUV5UErT3QQloiRYYK6Sk=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=yaGDsrrCxwhyhp09NxbLpgP3CgPR4cs0qQTkb3Mn+1vTGf9SjR5toY+Bar/ara7wv
	 FGvYwynKQcV/TmHF/zgzf2srMbp6/a6qa8Qu/GX1kNgNefO2J+b2u5b6d/VfKiGWgi
	 2RdQHu9rJoYtTiqKiwFeai/KWQXhkiZJkp/Pve3srEGYVsYE6bixkQnwgH3ei0ZqHN
	 Gt+8KEKZmDnns6rNQGffuudWMSWoh55LOAXEOHMjgwxb02Vj2sUo4y/FnK8z2BQEA8
	 QloqV3D9n25J7l4ipKsZ6ykwIq3WjGH+6cMMRU9poZL2tW9EB7eDEvhauRZBQNdw51
	 n8nL6YWoCJ+/g==
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1422C4493F
	for <op-tee@lists.trustedfirmware.org>; Thu,  3 Sep 2026 10:03:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GNXjRlUB;
	dkim-atps=neutral
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a65e66555cso3157272a12.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 03 Sep 2026 03:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788429799; x=1789034599; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NTFqZaE5WeXzEFHRWSBbenebslM+9RuyFvHTxQmSgMQ=;
        b=GNXjRlUBhWqgv9oWcTzj+6TDOyDMysK3TRhKsBpMWCivERhLuUafpXqMQatJWpVHL/
         v1IBFzQMz5czA8v/VsBBXW80F/xjzTXaKmCdRU9u1rSITj+LSkuOxokbMwz7nKm364Rl
         RuTKjxkFcz8CzzGlOzK5DCwHXF6xMKxmV7A5hmIxM4SUB8Wbje7+/dOYHYDI3BmYOJEx
         PMU4jWBoFSPaDXKHjxNuV1ulICnaj6iSfTbqhCicMXA++tXw/mt3CvCgqT4gsNMw76ro
         Du7ih5NQqDQTXt9tTLuTLDuY9DR3xgVXe2uVwODiZM6m5gKab49MUsqzLxxRCUXo85p+
         so8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788429799; x=1789034599;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NTFqZaE5WeXzEFHRWSBbenebslM+9RuyFvHTxQmSgMQ=;
        b=C7XdkUQSYsjAlGmI1vWghqzt/C9txBDz+2Mih/P1rwTseRcjKb0tlQOU1A8GvJqFJ+
         nbMrZh8rdMF0NbNwc99GRTl3JCDAexada3/Vewt1+0O4OWYX1M9LC+e6Yn3bAAqm0+CN
         rMn+r1DwZhhMa2EjfJy+y0buZzbh9wemyNovh+sd8e9yTxRqoXaOb5PBxlqDV5Yw18NX
         yatI5eQX/rsdtnF6hOU+AqIzEEqJUg7kjITmCwxGemFeJxlcaX1Agd2VGduEY5yjthNl
         YUXZj7mOHKZ2T7vLC1YNKsKQ/R/e1h93/ksrLBA7Th2FLrYzdvlq1fKipAQmUtYoc6Y+
         F9Pw==
X-Forwarded-Encrypted: i=1; AKwUvBzYp1hvntIMYVnxxR4kMsWJm2bbm9ntbNW8zHLOY5krCGROJpt8JJZGh++pm8KoXOv40oNEnV4=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++lGtsR+TJkdNTYOXLL/FMvFuDAJBj1ZMWAn+ncs6nJqdUJnebr/
	pMuy0ObCRmgq0N32AQ+bKyXIgsT7KI8rJr9P7mXJZFlJ0NgC7ej2FVXCysIYkEKJcg==
X-Gm-Gg: AYBFou15gzYjZup0jENK9uHv3aT2eBrP5ly3r8vbaQO6yIOG9AT+Ec9JOOM5xrtnKTt
	jX8O2feAFWgQfecUDPx4qs5BlLaXj3j3ZMMiWxWS5cB6gfvLqC3npsrtedLA9gqMQ0Eo2JR+piY
	IaSW/oajfCtTgiNdYloLwK6Ro6E08pBTErf6qwxgUrOfWFdzxlxoZykbTyW7KJ0yt4wqy2xDfuw
	/Qbw51spjJ4W0S3cOeMhifN2uwP8ayxS2eeGbMHMoGMYmV+NtQfA3q426SfYi4djWlz5eAs07vV
	NHqJX9TUXO4WE85RW800J5m0Iaj4A2KHa5+zNqKYkJ+RlNLLNVPyIYgpNkZ7QU0+ksuT+baGoVG
	Ib3FxzBeRDeDZy0mU6T/OGpLhEl43rAb1Hl7r+CC4yhPhSsICa/9xv987ik96oGlEziTNIOISJL
	gsHNXzktQvOkWE2EbN2tpoCdxA8ueffjRk3r4n9A6D6GBZBB1QMy/EFStmjOnA1kvaW727lV77l
	7BkxUV7WIRt8Y26Nw==
X-Received: by 2002:a05:6402:1ed1:b0:6a5:f4f4:5c0e with SMTP id 4fb4d7f45d1cf-6a6829afd97mr6824116a12.14.1788429798174;
        Thu, 03 Sep 2026 03:03:18 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a67f8b47f7sm2104420a12.9.2026.09.03.03.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:03:16 -0700 (PDT)
Date: Thu, 3 Sep 2026 11:03:12 +0100
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 02/10] of: reserved_mem: Introduce "ll-map" property
Message-ID: <aplF4NaoFk73d-c5@google.com>
References: <20260902104712.2399797-1-vdonnefort@google.com>
 <20260902104712.2399797-3-vdonnefort@google.com>
 <20260902172436.GB1440252-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902172436.GB1440252-robh@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.93 / 15.00];
	BAYES_HAM(-2.93)[99.68%];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.43:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.43:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1422C4493F
X-Spamd-Bar: ---
Message-ID-Hash: 4AY5QOS4NYYX6YLPGH6UYK55SJ5XRLZA
X-Message-ID-Hash: 4AY5QOS4NYYX6YLPGH6UYK55SJ5XRLZA
X-MailFrom: vdonnefort@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4AY5QOS4NYYX6YLPGH6UYK55SJ5XRLZA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

On Wed, Sep 02, 2026 at 12:24:36PM -0500, Rob Herring wrote:
> On Wed, Sep 02, 2026 at 11:47:04AM +0100, Vincent Donnefort wrote:
> > Keeping last-level mappings is interesting on some architectures as it
> > allows mapping/unmapping pages from the kernel direct map without the
> > risk of splitting blocks which, under the break-before-make rule, may
> > trigger page-faults the kernel can't handle.
> > 
> > Add an "ll-map" property for reserved-memory regions. When set, it
> > splits the underlying memblock and sets the MEMBLOCK_LLMAP flag.
> 
> Where is this documented? Any DT property must have a schema.

Ack.

> 
> Though I'm not thrilled about more flag properties. Handling all the 
> combinations of properties has proven to be painful. Can this be implied 
> from the compatible string instead?
> 
> Rob

We need this before the kernel direct map has been created (paging_init()).

I would have moved that directly into the driver lend_pool.c, but then it is
probed too late (unflatten_device_tree()).

-- 
Vincent
