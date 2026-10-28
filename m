Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06699606A31C
	for <op-tee@archiver.kernel.org>; Wed, 28 Oct 2026 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=FfbJJwy2;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkxBsnFF
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6271B45369
	for <op-tee@archiver.kernel.org>; Wed, 28 Oct 2026 15:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793199896;
	bh=ottI6OHGzXWd40ZNTksUUcUsVJPXWM3kO+CNOcGlh+k=;
	h=Subject:To:In-Reply-To:References:Date:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=FfbJJwy25e2wvwIZQcE3bt0ymGxbsoOIJjtYXkOyCly3hgV/thg3BQwxGGcB2VvoV
	 q7ZKSPdRZ4tr7bdSiLmrMh31bKtGYO56OmJ5I8pA0TKJIa/6DvQ01AYrsIsGYFbkLl
	 LxyGS7Q1v1ouUuH46FQ7wD9uhK2/nCa48qwLUS/ty3dNc1DTzwp2yVCp9Dow3lqRu8
	 Sx8oAlw/BFXlsLANB/DzT0hWMngxHrvuykwU0l2+L6Tgf6YWzqbo1qOzThiTpnWHbY
	 8k1sPkooCZAHJKhqtpWE3IIQJbdqxWjYi93fLiG+Gz53e+qa9kY8tUAAl6CiXMnkiY
	 nnFUfUrwSMAdw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BDFFC4499F
	for <op-tee@lists.trustedfirmware.org>; Wed, 28 Oct 2026 15:04:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkxBsnFF;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1147B60236;
	Wed, 28 Oct 2026 15:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D381F031E1;
	Wed, 28 Oct 2026 15:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793199873;
	bh=+Rsc9g24MtPLpVFEqmviyx5L0j/Yg5yRWd8d0hmWbnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZkxBsnFFHC/9gTRrdBEknTJoTVZswKRDlPDucehz4Dm8MSiKl46eCXT1gByUpUafd
	 jnnLlwddU9v1iqiS4g5eIh2DqyeNhaseMSbKOJPzpRj4Y1cPELGRH+v/WQSuCyAhWh
	 f/dC/tZ4EdQ13mxHFfYgAV+Y1a527tVWVLT/liknT+QPmlmamJuQQYsp9NHiqPq7xK
	 DuwaHnmvGLSZ5yhpngyULqUh69y5/4tUeRPI/7ZillyArv5BpnnLfZQPdBwRXlAS8o
	 tt8eHigoxeUfc/bo9NX5aRFDlx2pFDSsoLSIQdUALqDrV29y4gIKDqfCikxAeAVEg0
	 zeS8UrUwPaGyA==
Message-ID: <sashiko-outbox-188027@kernel.org>
Subject: Re: [PATCH v3 2/8] dma-heap: charge dma-buf memory via explicit
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
In-Reply-To: <20261027-v2_20230123_tjmercier_google_com-v3-2-78d2c4cb8647@redhat.com>
References: <20261027-v2_20230123_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com>
 <20261027-v2_20230123_tjmercier_google_com-v3-2-78d2c4cb8647@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:04:31 +0000
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.20 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	RCVD_IN_DNSWL_MED(-0.20)[172.105.4.254:from];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BDFFC4499F
X-Spamd-Bar: ----
Message-ID-Hash: TR3PTNCA5IE2R254FW3DNBRGBPPJRJQU
X-Message-ID-Hash: TR3PTNCA5IE2R254FW3DNBRGBPPJRJQU
X-MailFrom: sashiko-bot@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, echanude@redhat.com, mripard@kernel.org, media-ci@linuxtv.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TR3PTNCA5IE2R254FW3DNBRGBPPJRJQU/>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] dma-heap: missing permission check in mem_cgroup_get_from_fd()
- [High] dma-buf: system_heap: 32-bit nr_pages truncation in system_heap_al=
locate()
- [Medium] mm: memcontrol: missing EXPORT_SYMBOL_GPL() on dmabuf memcg help=
ers
- [Medium] mm: memcontrol: mem_cgroup_get_from_fd() returns NULL when memcg=
 is disabled
--

commit 961ee31303129349ee7fa6988bef4bc244f22a61
Author: Albert Esteve <aesteve@redhat.com>

dma-heap: charge dma-buf memory via explicit memcg

This commit adds a charge_fd field to struct dma_heap_allocation_data so
DMA_HEAP_IOCTL_ALLOC can resolve a target cgroup from a pidfd or cgroupfd v=
ia
mem_cgroup_get_from_fd() and charge system heap allocations to that memcg.

[ ... ]

> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/=
system_heap.c
> index c8959eadc71d1..adeea8cd328b8 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -17,6 +17,7 @@
>  #include <linux/err.h>
>  #include <linux/highmem.h>
>  #include <linux/mem_encrypt.h>
> +#include <linux/memcontrol.h>
>  #include <linux/mm.h>
>  #include <linux/set_memory.h>
>  #include <linux/module.h>
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

[Severity: High]
Can nr_pages truncate on 64-bit systems when a caller passes a large
heap_allocation->len via DMA_HEAP_IOCTL_ALLOC?

In dma_heap_ioctl_allocate(), heap_allocation->len is page-aligned into a
size_t len and only checked for zero before being passed to
system_heap_allocate() as an unsigned long:

drivers/dma-buf/dma-heap.c:dma_heap_ioctl_allocate() {
	...
	len =3D PAGE_ALIGN(heap_allocation->len);
	if (!len) {
		mem_cgroup_put(memcg);
		return ERR_PTR(-EINVAL);
	}

	dmabuf =3D heap->ops->allocate(heap, len, heap_allocation->fd_flags,
				     heap_allocation->heap_flags, memcg);
}

In system_heap_allocate(), size_remaining keeps the full 64-bit len, while
nr_pages is stored in a 32-bit unsigned int. Because __GFP_ACCOUNT is remov=
ed
from alloc_largest_available(), cgroup enforcement now relies solely on
mem_cgroup_reserve_dmabuf(memcg, GFP_KERNEL, nr_pages).

If userspace passes len >=3D (1ULL << (32 + PAGE_SHIFT)) (for example, 16 T=
iB
with 4 KiB pages), nr_pages wraps to 0 (or a small value), so
mem_cgroup_reserve_dmabuf() succeeds without charging the cgroup while the
while (size_remaining > 0) loop continues allocating uncharged physical pag=
es
until global memory exhaustion. In addition, values of nr_pages in
[0x80000000U, 0xffffffffU] are passed by mem_cgroup_commit_dmabuf() to
mod_memcg_state(), which takes a signed int val and would corrupt
MEMCG_DMABUF statistics.

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
> =20
> +	buffer =3D kzalloc_obj(*buffer);
> +	if (!buffer) {
> +		ret =3D -ENOMEM;
> +		goto cancel_charge;
> +	}
> +
>  	INIT_LIST_HEAD(&buffer->attachments);
>  	mutex_init(&buffer->lock);
>  	buffer->heap =3D heap;
> @@ -478,6 +484,9 @@ static struct dma_buf *system_heap_allocate(struct dm=
a_heap *heap,
>  		ret =3D PTR_ERR(dmabuf);
>  		goto free_pages;
>  	}
> +
> +	mem_cgroup_commit_dmabuf(dmabuf, memcg, nr_pages);
> +
>  	return dmabuf;
> =20
>  free_pages:
> @@ -498,6 +507,8 @@ static struct dma_buf *system_heap_allocate(struct dm=
a_heap *heap,
>  	list_for_each_entry_safe(page, tmp_page, &pages, lru)
>  		__free_pages(page, compound_order(page));
>  	kfree(buffer);
> +cancel_charge:
> +	mem_cgroup_cancel_dmabuf(memcg, nr_pages);

[Severity: Medium]
Will building with CONFIG_DMABUF_HEAPS_SYSTEM=3Dm and CONFIG_MEMCG=3Dy fail=
 at
modpost with undefined symbol errors for mem_cgroup_reserve_dmabuf(),
mem_cgroup_commit_dmabuf(), and mem_cgroup_cancel_dmabuf()?

In drivers/dma-buf/heaps/Kconfig, DMABUF_HEAPS_SYSTEM is tristate, so
drivers/dma-buf/heaps/system_heap.c can be compiled as a loadable module
(system_heap.ko). However, mem_cgroup_reserve_dmabuf(),
mem_cgroup_commit_dmabuf(), and mem_cgroup_cancel_dmabuf() in mm/memcontrol=
.c
do not have EXPORT_SYMBOL_GPL() annotations.

Should those symbols be exported (or should the reservation/commit/cancel
calls live in the built-in drivers/dma-buf/dma-heap.c layer as described in
the commit message)?

[ ... ]

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index bbd46ba40350b..f66254f52b999 100644
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
> +	return memcg;
> +}

[Severity: Critical]
What prevents an unprivileged user with access to a dma-heap device from
passing a cgroupfd (opened with O_RDONLY | O_DIRECTORY or O_PATH on any
world-readable /sys/fs/cgroup directory) or a pidfd (via pidfd_open() on
PID 1 or another user's process) as charge_fd to DMA_HEAP_IOCTL_ALLOC?

Through dma_heap_ioctl_allocate() -> mem_cgroup_get_from_fd() and
system_heap_allocate() -> mem_cgroup_reserve_dmabuf() -> try_charge_memcg(),
charging to the root cgroup (where mem_cgroup_is_root(memcg) skips page
counter charging) allows a restricted process to bypass its own memory.max
and memory.high limits, while charging to another cgroup allows exhausting
that victim cgroup's quota and triggering mem_cgroup_oom() kills inside it.

Later patches in the series ("security: dma-buf: Add dma_buf_charge_task LSM
hook", "security: dma-buf: Add dma_buf_charge_cgroup LSM hook", "selinux:
Restrict cross-cgroup dma-buf charging", and "selinux: Restrict dma-buf
direct cgroup charging") add LSM hooks and SELinux checks, but there are no
baseline DAC, capability, ptrace_may_access(), or cgroup write permission
checks when CONFIG_SECURITY is disabled, when SELinux is not active, or when
a cgroup directory has no explicit security.selinux xattr (where
selinux_dma_buf_charge_cgroup() returns 0 on -ENODATA).

Also, when charging a remote memcg via try_charge_memcg() breaches that
target cgroup's memory.high limit, try_charge_memcg() increments
current->memcg_nr_pages_over_high and calls __mem_cgroup_handle_over_high(),
which resolves get_mem_cgroup_from_mm(current->mm) and reclaims from the
allocating process's own cgroup rather than the remotely charged memcg.
Should remote charging require appropriate permissions over the target task=
 or
cgroup, and how should memory.high reclaim be handled when charging a forei=
gn
memcg?

[Severity: Medium]
In mem_cgroup_get_from_fd(), what happens on the pidfd path when
CONFIG_MEMCG=3Dy and memory cgroups are disabled at boot via
cgroup_disable=3Dmemory?

When mem_cgroup_disabled() is true, get_mem_cgroup_from_mm(mm) returns NULL,
so mem_cgroup_get_from_fd() returns NULL instead of an ERR_PTR as documented
in its kernel-doc comment.

In dma_heap_ioctl_allocate() (and in dma_buf_ioctl_xfer_charge() later in t=
he
series), IS_ERR(memcg) is false for NULL, so a pidfd charge_fd silently fal=
ls
through while a cgroupfd charge_fd fails with -ENOENT (because cgroup_css()
returns NULL when the subsystem is disabled). Should the pidfd path also
return an ERR_PTR when get_mem_cgroup_from_mm(mm) returns NULL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-v2_2023012=
3_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com?part=3D2
