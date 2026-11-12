Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273D5606A32A
	for <op-tee@archiver.kernel.org>; Thu, 12 Nov 2026 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=U9Og3G7G;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gybSGp1G
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7C44945513
	for <op-tee@archiver.kernel.org>; Thu, 12 Nov 2026 11:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794481750;
	bh=wyvkEdPCyp9OPNHJW5mZykyY0wURrxL1p3P/UHLFzYo=;
	h=Subject:To:In-Reply-To:References:Date:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=U9Og3G7GnVvRxFGdh967QsQIC/TmIjpW6qBq1WHzQDCuRpDbVziebAw8AKjY5kdY6
	 /rwKgp/hxcaKdokRS4FsUyHBEMLkHbHQaltGXjTJU0eyHiF+CGvbulRl+JrSjiKErL
	 IJ6Th3KwysnR/29Zwt2VMHhqROtZNIAQWPGO47Cbxu+TlLbWYGZdxaxmDy0DFOPqzj
	 Q915egG2XS7Cn3a3nkeAJqbCd5sucTSu3KHiA1EYwKsG/sDuqOiUYwRBcPjIxpayiz
	 FQHPiraxpM7reAtV+ImRICpzZc2/iXBVMcXbH8LgUcsV3mFjpmlaB9fYRRHEfzepj0
	 e2RNag+E+BucA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7E07844DC8
	for <op-tee@lists.trustedfirmware.org>; Thu, 12 Nov 2026 11:08:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gybSGp1G;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CFDC463629;
	Thu, 12 Nov 2026 11:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0D01F00A08;
	Thu, 12 Nov 2026 11:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794481730;
	bh=x7/yo1OPdWR339CVYUNb7xk1ugkvuCHgmsFdu8cHfQw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gybSGp1GQVcSoAD0/nMnlL4xCkjDD/owJ0OT/ZXq36W4QzTVudl98Da2U5XkVpaUT
	 Dyg80nmewRXnWJoDApapHFnH50KAz8uOy5BOkYFXBtTWbnfKYPYoT0zt2WexL/+lIH
	 xpTO3A24lM5QcqLnEwRVCJ86dX08yZ5YbheZEIh9XWCZGJrBwYatUAwzToGu48W5dO
	 YVtTUAlimwKFl4+chCr4l/2q8XKa8hh77lbZuQTee2G6z0FnvXyJj2/4tkh2t9UMxS
	 2yxUE1KPGQ7a3gI7zbRsa7Xa0nrkoz8q1deganigCT36hZjs1TpGWDoBN+KHJOoP1f
	 7O8zkh6l6gM+w==
Message-ID: <sashiko-outbox-210994@kernel.org>
Subject: Re: [PATCH v3 5/8] dma-mapping: Introduce lendable-dma-pool
To: "Vincent Donnefort" <vdonnefort@google.com>, catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org, akpm@linux-foundation.org, m.szyprowski@samsung.com, jenswi@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261111110738.872947-6-vdonnefort@google.com>
References: <20261111110738.872947-1-vdonnefort@google.com>
 <20261111110738.872947-6-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 11:08:48 +0000
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.20 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	MISSING_MIME_VERSION(2.00)[];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	RCVD_IN_DNSWL_MED(-0.20)[172.105.4.254:from];
	MIME_GOOD(-0.10)[text/plain];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7E07844DC8
X-Spamd-Bar: ------
Message-ID-Hash: IK4FJQVZULBXXK72Z3422GWKKDBYZG3K
X-Message-ID-Hash: IK4FJQVZULBXXK72Z3422GWKKDBYZG3K
X-MailFrom: sashiko-bot@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IK4FJQVZULBXXK72Z3422GWKKDBYZG3K/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: sashiko-bot--- via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] dma-mapping: linux,cma-default lendable pool bypassed in
  dma_alloc_contiguous()
--

commit b8e3981ec38ba68b29bb5ed6b932c6f83a300db4
Author: Vincent Donnefort <vdonnefort@google.com>

dma-mapping: Introduce lendable-dma-pool

This commit introduces the "lendable-dma-pool" reserved-memory CMA driver
along with dma_zap_direct_map() and dma_restore_direct_map() to unmap DMA
pages from the kernel direct map before lending them to a secure world and
restore them upon reclaim.

> diff --git a/kernel/dma/lendable.c b/kernel/dma/lendable.c
> new file mode 100644
> index 0000000000000..85ac3ad10df03
> --- /dev/null
> +++ b/kernel/dma/lendable.c
> @@ -0,0 +1,243 @@

[ ... ]

> +int dma_zap_direct_map(struct device *dev, struct page *page, size_t siz=
e)
> +{
> +	unsigned int nr_pages =3D size >> PAGE_SHIFT;
> +	bool from_lendable, has_lendable;
> +	struct cma *cma;
> +	int ret;
> +
> +	if (!size || !PAGE_ALIGNED(size))
> +		return -EINVAL;
> +
> +	cma =3D dev_get_cma_area(dev);
> +	has_lendable =3D cma_is_lendable(cma);
> +	from_lendable =3D has_lendable && cma_has_range(cma, page, nr_pages);
> +
> +	if (!from_lendable && !can_set_direct_map())
> +		return has_lendable ? -EFAULT : -ENODEV;

[Severity: Medium]
Can dma_zap_direct_map() fail with -EFAULT for pages allocated via
dma_alloc_pages() or dma_alloc_coherent() when a lendable pool is
configured as "linux,cma-default" without a per-device memory-region?

When dev->cma_area is NULL, dev_get_cma_area(dev) returns
dma_contiguous_default_area, so has_lendable is true.  However,
dma_alloc_contiguous() skips dma_contiguous_default_area for single-page
allocations (returning NULL so the caller falls back to the buddy
allocator) and prefers dma_contiguous_numa_area[nid] when
CONFIG_DMA_NUMA_CMA is enabled:

kernel/dma/contiguous.c:dma_alloc_contiguous() {
    ...
	if (dev->cma_area)
		return cma_alloc_aligned(dev->cma_area, size, gfp);
	if (size <=3D PAGE_SIZE)
		return NULL;

#ifdef CONFIG_DMA_NUMA_CMA
	if (nid !=3D NUMA_NO_NODE && !(gfp & (GFP_DMA | GFP_DMA32))) {
		struct cma *cma =3D dma_contiguous_numa_area[nid];
    ...
}

As a result, those pages do not come from dma_contiguous_default_area,
cma_has_range() returns false, and dma_zap_direct_map() returns -EFAULT
whenever can_set_direct_map() is false.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111110738.8729=
47-1-vdonnefort@google.com?part=3D5
