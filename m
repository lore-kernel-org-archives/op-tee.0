Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD68606A323
	for <op-tee@archiver.kernel.org>; Sun, 15 Nov 2026 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=Ug6VwhEc;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zlr8cphp
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 20DE5453D0
	for <op-tee@archiver.kernel.org>; Sun, 15 Nov 2026 19:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794770082;
	bh=75XuD+DXurkASGkdYBkTFeWImDwtmlf9ySWRy622ouc=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Ug6VwhEcZfCATw3JKpgd8bsJaFOYsrK4PkFOqbF+RATua6/xolpyKotdaO4CASZlc
	 t0+ANYEZ83T4diavRleaVhPgk1FQnGqlMXmnXJm/8S95H6+t+hBFuwhYxzvegVnQcu
	 uE7RRc1QPmJpccn8CML/cZ5yqUvTUXYwXHrJCD40/+hj6CRfZ/c8mEN51xdarQ7cdM
	 8+8hycfwc3D38je+MEfGILF3f67k/r0/3/TZx/WG0K73+EyG8CjAvoNyUc3sIe/yF6
	 aC5knU1o8NCfs7S6qJuv3SHkC5wjhVErOvN6zPKT1elLhNFxn7ggDeLafpPPwVETbi
	 Wafi98I8Vu2YA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 62D2E453D0
	for <op-tee@lists.trustedfirmware.org>; Sun, 15 Nov 2026 19:14:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zlr8cphp;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B2ABF41664;
	Sun, 15 Nov 2026 19:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2830B1F000C4;
	Sun, 15 Nov 2026 19:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794770075;
	bh=bTYAm4EWSRHx/ZHXwlhFob7m+xxSKwh0NNHvPVL+4a0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zlr8cphpaQd3nqY4dD/M8LKmVfhEwBhg/RXnFS8Dbd42j21budIL80Fj83ujynYBi
	 xrkpXbt/vgXXJ3zbCIgd0vytWH9UFZRo+kWYg6+zk3Dgh5sXkP6sxBNtPVRWMc7kgU
	 7c0cXcpkCgnk34WxtxAQP15i7VF+f+o9Op3gqEYw8sVFIZUZZKKEE/DiCEBd5NJmBL
	 eqWix0PI/yHN1v1kle17XH0UgF/k5g+OojdNRy9zlUqHohW/kmiciG1CH3WaxOOynl
	 GtOjVUG+IaqnqKJMnuActvv+XKVHz8jIHWFruwvUHIhP9DWwGFEUc3P4bbqJVKIINp
	 h+RZkJC+eVaDQ==
Date: Sun, 15 Nov 2026 21:14:25 +0200
To: Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v3 1/8] memblock: Introduce MEMBLOCK_PTEMAP
Message-ID: <avoEkRRM3iH70_Am@kernel.org>
References: <20261111110738.872947-1-vdonnefort@google.com>
 <20261111110738.872947-2-vdonnefort@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111110738.872947-2-vdonnefort@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.19 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-2.99)[99.94%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	RCVD_IN_DNSWL_MED(-0.20)[172.234.252.31:from];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 62D2E453D0
X-Spamd-Bar: --------
Message-ID-Hash: Y6Q7STYVYXA26LEMMGHCQBPQVPY2Y7YG
X-Message-ID-Hash: Y6Q7STYVYXA26LEMMGHCQBPQVPY2Y7YG
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org, m.szyprowski@samsung.com, jenswi@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Y6Q7STYVYXA26LEMMGHCQBPQVPY2Y7YG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Mike Rapoport via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mike Rapoport <rppt@kernel.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 11:07:31AM +0000, Vincent Donnefort wrote:
> Keeping PTE-level mappings is interesting for arm64 as it allows
> mapping/unmapping pages from the kernel direct map without the risk of
> splitting blocks which, under the break-before-make rule, may trigger
> page-faults the kernel can't handle.
> 
> However, mapping the entire direct map at PTE-level is costly. So
> instead, create a new memblock flag MEMBLOCK_PTEMAP to selectively apply
> a PTE-level mapping.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/memblock.h |  9 +++++++++
>  mm/memblock.c            | 39 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 46 insertions(+), 2 deletions(-)

-- 
Sincerely yours,
Mike.
