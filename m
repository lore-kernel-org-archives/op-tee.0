Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99578606A31B
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=tiSLmFaY;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqwrdTgO
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D60C945477
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793877134;
	bh=jCPnpy+VsUy3kPQe/6sFfQ0sJCuX9tJ34aYltTZUzLw=;
	h=Subject:To:In-Reply-To:References:Date:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=tiSLmFaYjxUkaOnLiUJsyubICjI/qyj+JJ6kUgK/0KH3qtQqzauJhrL3pSgFvzoCd
	 5klQcynfACwcEWuEKYQqdur9KW4c/YAOfd0HTfk7lAWFIya/possks8ihfGyEUpPNB
	 +QUyuDOy07mqKx/9Y9yuFafrM05cQeljDHZ4X8Pp6Zni7KxJjUVYn0Io/sk+dI2PWu
	 k1FmkyCziqGHHeJhPlmeZlUE9Oct7crCJhu6WgFzHGOj1eng8t1+FBUROxrg+wlYgA
	 gfQc5xr1blaa1mzhWK83glhZkk+9xhxX/g8QGkpdnZkuSbByb2z++mvC12rtaCZsHe
	 jDp3lcOoDuOUQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 31BEF45462
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 11:11:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqwrdTgO;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 99C5460D91;
	Thu,  5 Nov 2026 11:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99511F00919;
	Thu,  5 Nov 2026 11:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793877114;
	bh=enixJkjvt/NjGzx2vZdqFTkXKPfd4qcXQu8lRjKJNZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LqwrdTgOAHYSfUZcCn0vb7egFoGlnn/N25DberiwXI2r9Nuan10LzGhj9TOTvc4hq
	 aRLKo586J9Jj71jjdo2VlOkAT/orK4gAlgaFE4P6O7VKEi6hdnj25pKLDWL9myPx+U
	 jWZWyOtctKFaf8lmRnasULc7fMQVuW1Wzcl2/EaENoVrDU9TS2O8CPwNdxqIvJFcAy
	 ZQ+MfX6a6r4jgl4wL0Xq+/umegY7ix5rxuuPx9Fhqe0plwgj6xjoQLP1S+mbkJuNoG
	 YcnBsyy9XWslw0oR9Jozyi+3QwJVuOhSFTMdXCQoHhIi3Gn/3uBKejCot25qhdoOJn
	 bqwniPkRTAQfg==
Message-ID: <sashiko-outbox-198916@kernel.org>
Subject: Re: [PATCH v4 1/8] memcg: Add MEMCG_DMABUF accounting
 infrastructure
To: "Albert Esteve" <aesteve@redhat.com>, "Tejun Heo" <tj@kernel.org>, "Johannes
 Weiner" <hannes@cmpxchg.org>, =?utf-8?b?TWljaGFsIEtvdXRuw70=?= <mkoutny@suse.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Michal
 Hocko" <mhocko@kernel.org>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Muchun Song" <muchun.song@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Benjamin Gaignard" <benjamin.gaignard@collabora.com>, "Brian
 Starkey" <Brian.Starkey@arm.com>, "John Stultz" <jstultz@google.com>, "T.J.
 Mercier" <tjmercier@google.com>, "Christian Brauner" <brauner@kernel.org>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Stephen Smalley" <stephen.smalley.work@gmail.com>, "Shuah
 Khan" <shuah@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 =?utf-8?b?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, "Jens Wiklander" <jenswi@kernel.org>, "Sumit
 Garg" <sumit.garg@kernel.org>
In-Reply-To: <20261104-v2_20230123_tjmercier_google_com-v4-1-1819a017000b@redhat.com>
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-1-1819a017000b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:11:52 +0000
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.20 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	RCVD_IN_DNSWL_MED(-0.20)[172.105.4.254:from];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 31BEF45462
X-Spamd-Bar: ------
Message-ID-Hash: 66HZ2MFSMH332UW6HRNMYTWVOEFZIJGZ
X-Message-ID-Hash: 66HZ2MFSMH332UW6HRNMYTWVOEFZIJGZ
X-MailFrom: sashiko-bot@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, media-ci@linuxtv.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/66HZ2MFSMH332UW6HRNMYTWVOEFZIJGZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: sashiko-bot--- via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm: memcontrol: 32-bit nr_pages truncation in dmabuf charge help=
ers
--

commit a5e6165b3e0444a33f57a14736c2174d7c009944
Author: T.J. Mercier <tjmercier@google.com>

memcg: Add MEMCG_DMABUF accounting infrastructure

This commit introduces the MEMCG_DMABUF stat counter and helper functions
to reserve, cancel, and uncharge dma-buf memory against a memory cgroup,
tracking the active charge via a memcg pointer on struct dma_buf.

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 856a7d07586cc..e53dd7eebc3b5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c

[ ... ]

> @@ -5658,6 +5661,73 @@ void mem_cgroup_flush_workqueue(void)
>  	flush_workqueue(memcg_wq);
>  }
> =20
> +/**
> + * mem_cgroup_reserve_dmabuf - charge a memcg for a dma-buf allocation
> + * @memcg: memcg to charge (may be %NULL)
> + * @gfp_mask: reclaim mode
> + * @nr_pages: number of pages to charge
> + *
> + * Charges @nr_pages against @memcg. Call this before allocating pages so
> + * the cgroup limit is enforced up front. On success the caller must
> + * finalize the charge with the MEMCG_DMABUF stat update, or call
> + * mem_cgroup_cancel_dmabuf() to undo it.
> + *
> + * Returns %true on success, %false if the charge would exceed the limit.
> + */
> +bool mem_cgroup_reserve_dmabuf(struct mem_cgroup *memcg, gfp_t gfp_mask,
> +			       unsigned int nr_pages)
> +{
> +	if (!memcg || mem_cgroup_disabled())
> +		return true;
> +
> +	if (try_charge(memcg, gfp_mask, nr_pages))
> +		return false;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(mem_cgroup_reserve_dmabuf);
> +
> +/**
> + * mem_cgroup_cancel_dmabuf - undo a dma-buf charge
> + * @memcg: memcg to uncharge (may be %NULL)
> + * @nr_pages: same value passed to mem_cgroup_reserve_dmabuf()
> + *
> + * Returns @nr_pages of charge to @memcg. Use when the allocation fails
> + * after mem_cgroup_reserve_dmabuf().
> + */
> +void mem_cgroup_cancel_dmabuf(struct mem_cgroup *memcg, unsigned int nr_=
pages)
> +{
> +	if (!memcg)
> +		return;
> +
> +	if (!mem_cgroup_is_root(memcg))
> +		refill_stock(memcg, nr_pages);
> +}
> +EXPORT_SYMBOL_GPL(mem_cgroup_cancel_dmabuf);
> +
> +/**
> + * mem_cgroup_uncharge_dmabuf - uncharge a dma-buf from its memcg
> + * @dmabuf: buffer to uncharge
> + *
> + * Reverses a finalized dma-buf charge. Drops the memcg
> + * reference stored in @dmabuf->memcg and clears the pointer.
> + * Safe to call when @dmabuf->memcg is %NULL.
> + */
> +void mem_cgroup_uncharge_dmabuf(struct dma_buf *dmabuf)
> +{
> +	unsigned int nr_pages;
> +	struct mem_cgroup *memcg =3D dmabuf->memcg;
> +
> +	if (!memcg)
> +		return;
> +
> +	nr_pages =3D PAGE_ALIGN(dmabuf->size) >> PAGE_SHIFT;
> +	mod_memcg_state(memcg, MEMCG_DMABUF, -nr_pages);
> +	mem_cgroup_cancel_dmabuf(memcg, nr_pages);
> +	mem_cgroup_put(memcg);
> +	dmabuf->memcg =3D NULL;
> +}

[Severity: Medium]
Can passing a 32-bit unsigned int for nr_pages in
mem_cgroup_reserve_dmabuf(), mem_cgroup_cancel_dmabuf(), and
mem_cgroup_uncharge_dmabuf() in mm/memcontrol.c (and include/linux/memcontr=
ol.h)
truncate 64-bit dma-buf sizes?

struct dma_buf stores size as a 64-bit size_t, and in the following commit
("dma-heap: charge dma-buf memory via explicit memcg"),
dma_heap_ioctl_allocate() -> system_heap_allocate() passes a 64-bit
PAGE_ALIGN(len) >> PAGE_SHIFT to mem_cgroup_reserve_dmabuf() before
entering its while (size_remaining > 0) page allocation loop without
__GFP_ACCOUNT.

If a userspace caller requests an allocation where len >=3D (1ULL << (32 +
PAGE_SHIFT)) (for example, (1ULL << 44) + PAGE_SIZE on a 4 KiB page
system), PAGE_ALIGN(len) >> PAGE_SHIFT wraps to 1 page when converted to
unsigned int nr_pages. try_charge() will then succeed against a small
memory.max limit while system_heap_allocate() proceeds to allocate
unaccounted pages using the full 64-bit size_remaining.

Additionally, in mem_cgroup_uncharge_dmabuf(), passing -nr_pages to
mod_memcg_state(memcg, MEMCG_DMABUF, -nr_pages) (which takes a signed int
val) will overflow when nr_pages exceeds INT_MAX. Should nr_pages use
unsigned long (or size_t) across these helpers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-v2_2023012=
3_tjmercier_google_com-v4-0-1819a017000b@redhat.com?part=3D1
