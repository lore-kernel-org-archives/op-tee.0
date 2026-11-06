Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCA2606A326
	for <op-tee@archiver.kernel.org>; Fri,  6 Nov 2026 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=nHAkEXpu;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=peb0g6dj
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2B7EF454DA
	for <op-tee@archiver.kernel.org>; Fri,  6 Nov 2026 10:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793961937;
	bh=V+6hojtppmXHHvaINIrO9yth9ch7i1jrSe/qUNjgdDY=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=nHAkEXpuEjBt1yc7oQxzHMsNJX5n5frSEPUOhWv6M1N4bho8M3qkXndvSoqEazANK
	 n1oAEspNL5BdN8MACnRW2I+yH8vX6TJwurQSz9lSXGRmAb4DbO2Tp94Ym751XIsa7F
	 YErjBcH93MQTuvsmssUoNV53vduPAYIaKiFHXTH2eTBWoReSfemY+5T1+tw80IfeZj
	 /fkisS508lkO5P9R/zgPQYCC8VppouHH9+ZcBJ/8LCkKhZenEe0c1EZvc8Gzb1m7ZH
	 Mi0zRjAWibYxb0RHEDpDgMevkqZQvQbgtY8V+5x30P0k/43l+6AS1xJtP4YWqwxjKZ
	 GLEfr0rvcwnOQ==
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DC34B44E2B
	for <op-tee@lists.trustedfirmware.org>; Fri,  6 Nov 2026 10:45:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=peb0g6dj;
	dkim-atps=neutral
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a215e64962so5094615e9.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 06 Nov 2026 02:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793961918; x=1794566718; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ysUKDhkycj13Q2P+bjvds2QR5Xb4PbnZNX+l6BEN+k=;
        b=peb0g6djr1pEs3JP2K2y/BTMLDbMAPktpTkLq9f10k9twpMOMiZ4FnN3INjfwV+5nS
         VaN0CwiX5UQngR8m0HHVTA4ecvhXHfsioYx5NY0v3nXmm/1g8Z3+YGF2K8tQj/ab3UTB
         nhvCQANllplBEt1pJcQeJM5Bg2v93F28CKErYn1HQAIMdc+wIO+OqSCAe5HQXXPA2gO3
         EXSS4UgXPfbjZstuXOMSA8U0poTo0yMzq6zyNBhYysXSZDD6RPfs94W7beTH57feI2lt
         /FpmJEy4gmciFzAlblhE2m0CjvSP0FB6ebuywIO3w43qriLORhXFbNuB4CeVVXj4enSs
         Wwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793961918; x=1794566718;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ysUKDhkycj13Q2P+bjvds2QR5Xb4PbnZNX+l6BEN+k=;
        b=Qn0THSoplPIcIGFftuamPzMHKI+No5NzI2akBSyZ72Llk/WI+XQ0HuEMS6xPYSr1ev
         T2fOmeDXQRJLCc99R2+rT6rmjxcmzyE1MZ5JBcrun5xQ3LGTrUHL/bYbFqRNo0Soiugf
         6kg6AQCEqpnWtsA6HGW+rs3sQOZXueH6BfFrCqalKd+nsDSZjHyu4aL09HJBiIxrZ7TA
         7UIZKz9F84ZGjdPGCZIAsY3+HJ4L6hjtqOAiCTl89lE3uypIcOnPcRMsx0qll/S8vT0e
         sF4+NiEWFLfldQmH4yMm53RbVz/RLr2ZL1E8c9aSftZ3qNxXpkC8pkRMhvudPaehXE0k
         Nddg==
X-Forwarded-Encrypted: i=1; AKwUvByHHN1Qw+5w3w1tCKkFiKaiktRm/B3KTBdLx7/5Uh1lzjmbogetfRMTD0zpYlZxzZxfS49wmSU=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z+B1B9WYQAa/LCjHtQynVoXipuwTKLCJbk9mCENTRZK+Ht61Q69
	h2bd5CJiQV1ZC0bEdOijt/Q0CxXQo0p2UB6EwbhJmGNRTmdeQxB/O8KAo1JyvfuuDA==
X-Gm-Gg: AYBFou1mnQ0B85BXy6ybwYy2bb+yw5nCg49Nobe6K1IUrgU1Scrv3Vkl6aI1guPc+Xg
	QZxFUTaTQt01Q3+5AAS2lOZiwG3RDKSK3JI2na3Mumr3igKvpYKkxzJG13oq6bQ4YoorAAwnHIU
	Xs+hf1/o1WSlrcRIOo382S/qNeVArnlT9Vbi4evGh9trj9IBLYMT6m53Vg94LQefvqNt4qg/v0p
	ddld6owGbetpMTspZ3x10xNQeiwjo7/gTllCdQJLIvDtN5yujHoOrTjovUPp8aJH+1NfyMwqru0
	7tzNves9OtablD41dbVSqubYqjwXyoYy0DoVu0P3GeOEbKHkfSWILdbOMd7WQdX0HTquXLPmwLV
	LMmLEzSI8QSyROkNre/SJ6TSZYK3xIisJv67z7MfaO6pnnn0FFTRcYfg+Gnur6SmZ7veoeyxKZo
	gC/9RXK2aUUU1TxaSIepzyVeTrSBBhGOBLHlf/Ib5b+lQ6SxL/xxdal9WIOMEnpHPOVt2EFXHY7
	bOnIb6NVC/ydBbeURCZjYIwg+DRb1cNRjPzTFmF6Gn080DGAfvrIxR5WqE5hOA3uVNaSaIHX/If
	TZvk5MSZGUyFJvSbPxXFGBwKrVP0ei4uzSGLS4ziM+CKbCYnBInEaTsOkECrOt9X
X-Received: by 2002:a05:600c:3b02:b0:4a1:fe55:88ef with SMTP id 5b1f17b1804b1-4b6df5eab2emr32006075e9.20.1793961917300;
        Fri, 06 Nov 2026 02:45:17 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b73d28cb10sm16111895e9.0.2026.11.06.02.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 02:45:14 -0800 (PST)
Date: Fri, 6 Nov 2026 10:45:09 +0000
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v2 0/8] arm64: Unmap FF-A lent memory from direct map
Message-ID: <au2vtZFyfUVWeils@google.com>
References: <are21BjeS1O3RYE3@sumit-xelite>
 <aruh86rd5FMv2i9G@willie-the-truck>
 <ar5TPvANFUoosxGW@sumit-xelite>
 <asOAYODGZa-7EIV1@google.com>
 <asOD31rTX6dNfD1o@google.com>
 <aszdnInyJxLhSQRp@sumit-xelite>
 <as3798SFCfKFirag@google.com>
 <as4ATqhp0bPI03PA@sumit-xelite>
 <auILvMVSXk9pZh6M@google.com>
 <auQ5hCdPFz0BmvDG@sumit-xelite>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auQ5hCdPFz0BmvDG@sumit-xelite>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.73 / 15.00];
	BAYES_HAM(-2.73)[98.82%];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20260707];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.43:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.43:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DC34B44E2B
X-Spamd-Bar: ---
Message-ID-Hash: RFYJVDJP7JDRTW5MXXYPCBRXQCCCFH4B
X-Message-ID-Hash: RFYJVDJP7JDRTW5MXXYPCBRXQCCCFH4B
X-MailFrom: vdonnefort@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Will Deacon <will@kernel.org>, brendan.jackman@linux.dev, catalin.marinas@arm.com, rppt@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RFYJVDJP7JDRTW5MXXYPCBRXQCCCFH4B/>
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

[...]

> > > Yeah I saw that constraint too, let's leave it for future extension
> > > then although having this reordering dependency fixed will be ideal.
> > > 
> > > >
> > > > So the only case it would work would be when a reserved memory has set
> > > > "linux,cma-default".
> > > >
> > > 
> > > Let's rather just turn DT based default CMA pool to support PTE-level
> > > mapping and keep it configurable via Kconfig or cmdline or DT.
> > 
> > If we need a DT declaration anyway, a Kconfig and a cmdline option aren't really
> > necessary.
> 
> Agree, it rather makes sense for DT independent generic CMA pool.
> 
> > 
> > Also, Rob wasn't very keen on having a DT option for the reserved memory and
> > suggested to have a compatible string instead [1]. So perhaps we could have a
> > a separate driver that handles the unmapping.
> > 
> > 	linux,cma {
> > 		compatible = "shared-dma-pool", "unmap-on-alloc";
> > 		reusable;
> > 		linux,cma-default;
> > 		...
> > 	}
> > 
> > That "unmap-on-alloc" driver sets the memblock flags and register some cma hooks
> > (to be defined) for cma_alloc/cma_free where it unmaps/re-maps into the linear
> > map.
> > 
> > The nice property is optee won't need to be modified anymore. The downside is
> > the entire pool is now mapped at PTE-level.
> 
> Sounds reasonable to me. If folks are really worried about performance
> with generic CMA PTE-level map then OP-TEE already supports no-map based
> reserved carveouts for protected DMABufs too.
> 
> -Sumit
> 
> > 
> > [1] http://lore.kernel.org/all/20260902172436.GB1440252-robh@kernel.org/
> > 
> > -- 
> > Vincent

I have just looked deeper into and cma_alloc can't unmap automatically the
default pool. Callers expect a valid linear mapping right after the alocation.
dma_direct_alloc() and dma_direct_alloc_pages() zero the allocated page,
dma_direct_alloc_no_mapping() runs cache maintenance on it, and the userspace
available heap /dev/dma_heap/linux,cma zeroes it.

Also, it isn't possible to use two compatible strings for the reserved memory.
The registration stops at the first matching compatible string. Layering drivers
won't work either.

So while the pool can still be generic and serve as linux,cma-default:

  linux,cma {
      compatible = "unmappable-dma-pool";
      reusable;
      linux,cma-default;
  }

We can't escape providing an additional API to unmap/remap in the linear map. 

-- 
Vincent

