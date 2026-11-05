Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54366606A31B
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=lGcvffyP;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmI46hVd
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A4FAE45477
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793877163;
	bh=HZvjJH5Ynv59oHTdXvh2e3BzagD9fZ91W8eL36fa2G4=;
	h=Subject:To:In-Reply-To:References:Date:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=lGcvffyPA7lPO3salgcteim3MMczYVYzvdwdfuj/PAYWxNbyPpn/pqP9Mc/4ReoGY
	 Thk+3PF86Xi9dRVcII3N//dzqLfT678tbEzH5r2celzGK3RSoszAYWtDAtkhgKkltV
	 u/Ir2LrdKslUF4Uk5LRsIZMv0BHGJ70XBldjr77zaJrTqjzQOn1hFxGWgKxkvTa6wh
	 1RuSZoaMEaEKL514DGJOgDF3Hb3MqKdDGjj5AqoSNcocIbUnkCOcyaja3zfeGyXxff
	 sfrwlb8KAfBwIHI8f2OXrqq3c0pf8MlJtSBhwnYOaXYMWSqwwNkhcwPWo7jYcyhqco
	 cazFfwY7AQKDw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4890E45479
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 11:11:57 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmI46hVd;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A812760F35;
	Thu,  5 Nov 2026 11:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31781F00A1F;
	Thu,  5 Nov 2026 11:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793877116;
	bh=5wL9H11c52K74bWFIToeD2nwJm/S5kppGqdHpQpDG0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VmI46hVd9YGz27GAlicu7eRmyRYfUiMYWwHh8vat5Po17sPb+MebtSuE73p/uef9a
	 bi82HORDD5FyjgH0up20UJCTFGGkKmJSiIJhj1CpUAlQZjPYR3a0JFTdFfHLHtp5Ji
	 4bT/sByYe8c8teDcHOBP1GCeUTXHVP7j4P9dcS2nbGz/XDlXp9/Zj5D7VWr15cDXmj
	 yu9Scz4G1TzD11Ho+lIbkedRD3ay0Ky0uQvMD22YMX5w+PJs51+dLSm3NpKwVT4Ya6
	 JRisBkfamAp9lvl9fIB8ZUz/qYK+JvjgN4PhmpnAMGnpq2pFYipDPdVtYp8hAAcMAM
	 9+N/0uqdac1dA==
Message-ID: <sashiko-outbox-198917@kernel.org>
Subject: Re: [PATCH v4 2/8] dma-heap: charge dma-buf memory via explicit
 memcg
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
In-Reply-To: <20261104-v2_20230123_tjmercier_google_com-v4-2-1819a017000b@redhat.com>
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-2-1819a017000b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:11:54 +0000
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.20 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
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
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4890E45479
X-Spamd-Bar: ------
Message-ID-Hash: QOYEDILFFTTTBQVFFQTEQ5YYG552D42S
X-Message-ID-Hash: QOYEDILFFTTTBQVFFQTEQ5YYG552D42S
X-MailFrom: sashiko-bot@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, media-ci@linuxtv.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QOYEDILFFTTTBQVFFQTEQ5YYG552D42S/>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] mm: memcontrol: missing permission checks in mem_cgroup_get_fr=
om_fd()
- [High] dma-buf: system_heap: 32-bit nr_pages truncation in system_heap_al=
locate()
--

commit e390a33c5307a75778a81c2ca5beff0530617904
Author: Albert Esteve <aesteve@redhat.com>

dma-heap: charge dma-buf memory via explicit memcg

This commit adds a charge_fd field to struct dma_heap_allocation_data so
that DMA_HEAP_IOCTL_ALLOC can resolve a target pidfd or cgroupfd and charge
the exported dma-buf memory to that memcg via mem_cgroup_reserve_dmabuf().
It also removes __GFP_ACCOUNT from system heap page allocations to avoid
double counting.

> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/=
system_heap.c
> index c8959eadc71d1..2bd245e1eab8f 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
[ ... ]
> @@ -388,8 +389,6 @@ static struct page *alloc_largest_available(unsigned =
long size,
>  		if (max_order < orders[i])
>  			continue;
>  		flags =3D order_flags[i];
> -		if (mem_accounting)
> -			flags |=3D __GFP_ACCOUNT;
>  		page =3D alloc_pages(flags, orders[i]);
>  		if (!page)
>  			continue;
> @@ -401,11 +400,13 @@ static struct page *alloc_largest_available(unsigne=
d long size,
>  static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>  					    unsigned long len,
>  					    u32 fd_flags,
> -					    u64 heap_flags)
> +					    u64 heap_flags,
> +					    struct mem_cgroup *memcg)
>  {
>  	struct system_heap_buffer *buffer;
>  	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>  	unsigned long size_remaining =3D len;
> +	unsigned int nr_pages =3D PAGE_ALIGN(len) >> PAGE_SHIFT;
>  	unsigned int max_order =3D orders[0];
>  	struct system_heap_priv *priv =3D dma_heap_get_drvdata(heap);
>  	bool cc_shared =3D priv->cc_shared;
> @@ -416,10 +417,15 @@ static struct dma_buf *system_heap_allocate(struct =
dma_heap *heap,
>  	struct page *page, *tmp_page;
>  	int i, ret =3D -ENOMEM;
> =20
> -	buffer =3D kzalloc_obj(*buffer);
> -	if (!buffer)
> +	if (!mem_cgroup_reserve_dmabuf(memcg, GFP_KERNEL, nr_pages))
>  		return ERR_PTR(-ENOMEM);

[Severity: High]
As reported by Sashiko on v3 [1], can truncating nr_pages to a 32-bit
unsigned int in system_heap_allocate() allow a 64-bit allocation length to
bypass memcg memory.max limits?

In dma_heap_ioctl_allocate(), heap_allocation->len (__u64) is page-aligned
into a 64-bit size_t len and only checked for wrap-around to zero before
being passed as an unsigned long len to system_heap_allocate():

drivers/dma-buf/dma-heap.c:dma_heap_ioctl_allocate() {
	len =3D PAGE_ALIGN(heap_allocation->len);
	if (!len) {
		mem_cgroup_put(memcg);
		return ERR_PTR(-EINVAL);
	}

	dmabuf =3D heap->ops->allocate(heap, len, heap_allocation->fd_flags,
				     heap_allocation->heap_flags, memcg);
}

In system_heap_allocate(), size_remaining retains the full 64-bit len while
nr_pages is truncated to unsigned int. Because __GFP_ACCOUNT is removed from
alloc_largest_available(), mem_cgroup_reserve_dmabuf() becomes the only
memcg limit check.

On a 64-bit system with 4 KiB pages (PAGE_SHIFT =3D=3D 12), if a user passes
len =3D (1ULL << 44) (or (1ULL << 44) + PAGE_SIZE), PAGE_ALIGN(len) >>
PAGE_SHIFT truncates in 32-bit unsigned int nr_pages to 0 (or 1).
mem_cgroup_reserve_dmabuf() then charges 0 (or 1) pages and succeeds inside
a restricted cgroup, while the while (size_remaining > 0) loop allocates
uncharged physical pages for the full 64-bit size_remaining until host RAM
is exhausted and the global OOM killer is triggered.

Similarly, in dma_buf_export() and mem_cgroup_uncharge_dmabuf(),
PAGE_ALIGN(size) >> PAGE_SHIFT is stored in an unsigned int nr_pages and
passed to mod_memcg_state(), which takes a signed int val and can overflow
to a negative delta when bit 31 of nr_pages is set. Should nr_pages be
unsigned long (or should len be bounds-checked before converting to page
counts)?

[ ... ]
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e53dd7eebc3b5..17fdefc56b97f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5661,6 +5661,53 @@ void mem_cgroup_flush_workqueue(void)
>  	flush_workqueue(memcg_wq);
>  }
> =20
> +/**
> + * mem_cgroup_get_from_fd - resolve a memcg from a cgroupfd or pidfd
> + * @fd: file descriptor (cgroupfd or pidfd)
> + *
> + * Tries @fd as a cgroupfd first; if that fails, tries it as a pidfd.
> + * On success returns a referenced memcg pointer. On failure returns
> + * an ERR_PTR.
> + */
> +struct mem_cgroup *mem_cgroup_get_from_fd(int fd)
> +{
> +	struct cgroup_subsys_state *css;
> +	struct mem_cgroup *memcg;
> +	struct cgroup *cgrp;
> +	struct task_struct *task;
> +	struct mm_struct *mm;
> +	unsigned int pidfd_flags;
> +
> +	cgrp =3D cgroup_get_from_fd(fd);
> +	if (!IS_ERR(cgrp)) {
> +		rcu_read_lock();
> +		css =3D cgroup_css(cgrp, &memory_cgrp_subsys);
> +		if (!css || !css_tryget_online(css)) {
> +			rcu_read_unlock();
> +			cgroup_put(cgrp);
> +			return ERR_PTR(-ENOENT);
> +		}
> +
> +		memcg =3D mem_cgroup_from_css(css);
> +		rcu_read_unlock();
> +		cgroup_put(cgrp);
> +		return memcg;
> +	}
> +
> +	task =3D pidfd_get_task(fd, &pidfd_flags);
> +	if (IS_ERR(task))
> +		return ERR_CAST(task);
> +
> +	mm =3D get_task_mm(task);
> +	put_task_struct(task);
> +	if (!mm)
> +		return ERR_PTR(-ESRCH);
> +
> +	memcg =3D get_mem_cgroup_from_mm(mm);
> +	mmput(mm);
> +	return memcg ?: ERR_PTR(-ENOENT);
> +}

[Severity: Critical]
As reported by Sashiko on v3 [2], does mem_cgroup_get_from_fd() allow an
unprivileged caller to charge dma-buf allocations to arbitrary cgroups
without permission checks?

When dma_heap_ioctl_allocate() calls mem_cgroup_get_from_fd() with a
user-supplied charge_fd, the target mem_cgroup is resolved either from a
cgroup v2 directory fd (which can be opened with O_RDONLY | O_DIRECTORY or
O_PATH on any world-readable /sys/fs/cgroup directory, including the root
cgroup) or from a pidfd obtained via pidfd_open() for any visible process
such as PID 1.

Neither path verifies DAC permissions, cgroup write access (such as
cgroup_may_write() or cgroup_attach_permissions() used by CLONE_INTO_CGROUP
in cgroup_css_set_fork()), ptrace_may_access(), or capabilities such as
CAP_SYS_ADMIN / CAP_SYS_RESOURCE.

When system_heap_allocate() then calls mem_cgroup_reserve_dmabuf(memcg,
GFP_KERNEL, nr_pages) -> try_charge(), targeting root_mem_cgroup returns 0
immediately and bypasses the caller's memory.max and memory.high limits,
while targeting another cgroup can trigger reclaim and OOM kills in that
victim cgroup. In addition, when a remote target memcg exceeds memory.high
during try_charge_memcg(), the over-high penalty and reclaim in
__mem_cgroup_handle_over_high() are applied against current->mm's memcg
rather than the remotely charged memcg.

Later commits in the series ("security: dma-buf: Add dma_buf_charge_task LSM
hook", "security: dma-buf: Add dma_buf_charge_cgroup LSM hook", "selinux:
Restrict cross-cgroup dma-buf charging", and "selinux: Restrict dma-buf
direct cgroup charging") add LSM hooks and SELinux policy checks, but still
leave no baseline DAC, capability, cgroup write permission, or
ptrace_may_access() checks when CONFIG_SECURITY is disabled, when SELinux is
not the active LSM, or when a cgroup v2 directory uses default genfscon
labeling without an explicit security.selinux kernfs xattr (where
selinux_dma_buf_charge_cgroup() sees kernfs_xattr_get() =3D=3D -ENODATA and
returns 0).

Should baseline permission checks be enforced before allowing a process to
charge memory to another task's or cgroup's memcg?

[1] https://lore.kernel.org/r/20261027-v2_20230123_tjmercier_google_com-v3-=
2-78d2c4cb8647@redhat.com
[2] https://lore.kernel.org/r/20261027-v2_20230123_tjmercier_google_com-v3-=
2-78d2c4cb8647@redhat.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-v2_2023012=
3_tjmercier_google_com-v4-0-1819a017000b@redhat.com?part=3D2
