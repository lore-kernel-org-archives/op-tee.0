Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37445606A31C
	for <op-tee@archiver.kernel.org>; Mon,  9 Nov 2026 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=L64YomgR;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mTDmNLIg
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8492745502
	for <op-tee@archiver.kernel.org>; Mon,  9 Nov 2026 06:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794205382;
	bh=Hj3RQ9hIkRoNZEz+EiZlzqlRxuJ18b9YjImxfNGM7rE=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=L64YomgRmxqE1U3/W1X3OZzjlsqzLPQJTcrBAPR87DE8EQyIdsFLY7xdNDhlgMFqW
	 /qfZEEtUt7Vkm5gTbY19vUMJOgGyVi2GE8ath6MOzCa7pfsOy30NQ2KIlNkmn9mcxK
	 dzwXvFa6G/PlnkrnBcWfFPsikGB99OvY4FmB0DvDozY5/2Hxx3c3a2ltIrB2xJ+z4W
	 29M9wZR2fy5FBTg5IDDLAcjA+Hpq8RNncql98atBq+3HDrWpbrzyVf+DciCHIVQAT3
	 OAzEAM+eDMVOlMAbSBMZirn5vQYB9HeXOGNHzZFTq25Wi5wq/qVpdregQifsNO+ggW
	 Ta+wdsUzgUX1Q==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2F75344ED4
	for <op-tee@lists.trustedfirmware.org>; Mon,  9 Nov 2026 06:22:44 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mTDmNLIg;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 786F4618DC;
	Mon,  9 Nov 2026 06:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0B81F008A1;
	Mon,  9 Nov 2026 06:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794205363;
	bh=ZA63luVCcUm/rcUMYSE6kbch+b4UxpuSVxYdwx6UVuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mTDmNLIgFiFwQeKbp4CMfjVX+h4GlITRDvYMD8FO9glhG/g4prrJIRnsH/XA6mrqk
	 KZHT3JCdSldwDf+HAmkYhqyzNX7RIICj9z7FYzjFYp8Fuk/T7pkF0QeXLcG7AWIo9i
	 KgU8apAwsf8d7sKCxaPFkaNvCarJsW0jzSix1Pd0iao0MPfHPCmjyssAS/MB3ULpJQ
	 598v4SkCigLCevg13d7vrUze2LeVfCu9q4JUe230MOAe2131CzkMqCquO+EC35jHJw
	 bvKH9HXR2oRh463I4q+2R4nTIkUhSiLPzN98NzjIPb4tcVpYrgp+nUXVYIHhtubC95
	 40b+tagd1SqIg==
Date: Mon, 9 Nov 2026 11:52:33 +0530
To: Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v2 0/8] arm64: Unmap FF-A lent memory from direct map
Message-ID: <avFmqak7gxqCW3UB@sumit-xelite>
References: <aruh86rd5FMv2i9G@willie-the-truck>
 <ar5TPvANFUoosxGW@sumit-xelite>
 <asOAYODGZa-7EIV1@google.com>
 <asOD31rTX6dNfD1o@google.com>
 <aszdnInyJxLhSQRp@sumit-xelite>
 <as3798SFCfKFirag@google.com>
 <as4ATqhp0bPI03PA@sumit-xelite>
 <auILvMVSXk9pZh6M@google.com>
 <auQ5hCdPFz0BmvDG@sumit-xelite>
 <au2vtZFyfUVWeils@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <au2vtZFyfUVWeils@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.13 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-2.93)[99.70%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	RCVD_IN_DNSWL_MED(-0.20)[172.105.4.254:from];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[20];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2F75344ED4
X-Spamd-Bar: ---------
Message-ID-Hash: CVF7XR246LKSDXW4K4Q5C7T3A7RH3TY2
X-Message-ID-Hash: CVF7XR246LKSDXW4K4Q5C7T3A7RH3TY2
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Will Deacon <will@kernel.org>, brendan.jackman@linux.dev, catalin.marinas@arm.com, rppt@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CVF7XR246LKSDXW4K4Q5C7T3A7RH3TY2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 06 Nov 2026 at 10:45:09 +0000, Vincent Donnefort wrote:
>[...]
>
>> > > Yeah I saw that constraint too, let's leave it for future extension
>> > > then although having this reordering dependency fixed will be ideal.
>> > >
>> > > >
>> > > > So the only case it would work would be when a reserved memory has set
>> > > > "linux,cma-default".
>> > > >
>> > >
>> > > Let's rather just turn DT based default CMA pool to support PTE-level
>> > > mapping and keep it configurable via Kconfig or cmdline or DT.
>> >
>> > If we need a DT declaration anyway, a Kconfig and a cmdline option aren't really
>> > necessary.
>>
>> Agree, it rather makes sense for DT independent generic CMA pool.
>>
>> >
>> > Also, Rob wasn't very keen on having a DT option for the reserved memory and
>> > suggested to have a compatible string instead [1]. So perhaps we could have a
>> > a separate driver that handles the unmapping.
>> >
>> > 	linux,cma {
>> > 		compatible = "shared-dma-pool", "unmap-on-alloc";
>> > 		reusable;
>> > 		linux,cma-default;
>> > 		...
>> > 	}
>> >
>> > That "unmap-on-alloc" driver sets the memblock flags and register some cma hooks
>> > (to be defined) for cma_alloc/cma_free where it unmaps/re-maps into the linear
>> > map.
>> >
>> > The nice property is optee won't need to be modified anymore. The downside is
>> > the entire pool is now mapped at PTE-level.
>>
>> Sounds reasonable to me. If folks are really worried about performance
>> with generic CMA PTE-level map then OP-TEE already supports no-map based
>> reserved carveouts for protected DMABufs too.
>>
>> -Sumit
>>
>> >
>> > [1] http://lore.kernel.org/all/20260902172436.GB1440252-robh@kernel.org/
>> >
>> > --
>> > Vincent
>
>I have just looked deeper into and cma_alloc can't unmap automatically the
>default pool. Callers expect a valid linear mapping right after the alocation.
>dma_direct_alloc() and dma_direct_alloc_pages() zero the allocated page,
>dma_direct_alloc_no_mapping() runs cache maintenance on it, and the userspace
>available heap /dev/dma_heap/linux,cma zeroes it.
>
>Also, it isn't possible to use two compatible strings for the reserved memory.
>The registration stops at the first matching compatible string. Layering drivers
>won't work either.
>
>So while the pool can still be generic and serve as linux,cma-default:
>
>  linux,cma {
>      compatible = "unmappable-dma-pool";
>      reusable;
>      linux,cma-default;
>  }
>
>We can't escape providing an additional API to unmap/remap in the linear map.
>

Yeah it's fine to invoke these additional APIs post the CMA allocation
for protected DMA buffers.

-Sumit
