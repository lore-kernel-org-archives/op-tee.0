Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8538D606A327
	for <op-tee@archiver.kernel.org>; Wed, 25 Nov 2026 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=pvMEYEwO;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7CgCBaT
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D1F274D9C0
	for <op-tee@archiver.kernel.org>; Wed, 25 Nov 2026 13:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795611932;
	bh=z+bnhn7gR5bsFProZ31Yg/u6c4cqos4JHWDrsElpIMM=;
	h=Subject:To:In-Reply-To:References:Date:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=pvMEYEwOa9R+XTKSxhlAgVa7Pl3VbTb34l8kFUGhIXbtWPaUcMG1v0FPu0sTcJCAG
	 NH+O4Ef2kKkzQgbwpkcoFMc6ZO6/t8kOv4UXQ95GkRdYut9aUxgBUjEBRw20SuS/WV
	 bfRXAuNXoDjo57EbblQXJo8iHth8Y2EEepyff5ysr3yNSVirGS5B2nzQRLzyxsIqZl
	 m5I79XjgKYNYt6IvSnCo8zUGYROLD9pRi8j7c/YpVa9GYLyZDivJToV+anTrOWSo8f
	 SXaLAxrrhHNJmmZiX/y/KkoMLlicofeZRVcKkAbNNAA01I+9EAnUDCFz+QSyf2wWPe
	 cIEHU4UAx+gcA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9DC1D43264
	for <op-tee@lists.trustedfirmware.org>; Wed, 25 Nov 2026 13:05:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7CgCBaT;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0094460DA7;
	Wed, 25 Nov 2026 13:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E65F1F000C0;
	Wed, 25 Nov 2026 13:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795611926;
	bh=mk8/GrdShzBimqotJLwmFPdZ5k/yU8pDK1zQzPphDwE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O7CgCBaTStMB4v1DHVH43pVcRsQYovYl0Zz21echw/YbsR9o2vyApTc95kjPxcrwy
	 S2FzqBpCClDMF9wNZ/Ew8c5qFKJrr+QzSjRt0v5GRpuEefLzYP+9pSMSiofX3su4uj
	 XPlTKPfIcFa97GGBlZhso19bbpFvn6mTriSpKdORjSj2n+3jPhBolSUjsHSC1IcPU8
	 +OL3Mb7QkfBN1vyPAo6fyqfoLVQ+zclgNL6OQSqOk8+l5qdm0dlHjGUW3Qqg5WYpdR
	 b8GgxvNGAt8LNwKw/G8td8mkfZ/iHRMuG/h/QZnQV3x+ZAxvRsBq0nXwPVY4YySt7e
	 SMZOtPVstK1xA==
Message-ID: <sashiko-outbox-233444@kernel.org>
Subject: Re: [PATCH v6 2/7] dma-heap: charge dma-buf memory via explicit
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
 Garg" <sumit.garg@kernel.org>, "Philipp Stanner" <phasta@kernel.org>
In-Reply-To: <20261124-v2_20230123_tjmercier_google_com-v6-2-dce12fa03ad6@redhat.com>
References: <20261124-v2_20230123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com>
 <20261124-v2_20230123_tjmercier_google_com-v6-2-dce12fa03ad6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 13:05:24 +0000
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.20 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	RCVD_IN_DNSWL_MED(-0.20)[172.105.4.254:from];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.freedesktop.org,kvack.org,vger.kernel.org,lists.trustedfirmware.org,redhat.com,kernel.org,linuxtv.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9DC1D43264
X-Spamd-Bar: ------
Message-ID-Hash: 2YUTNPWHM4I4O2ZA5FDZK4CCLQVQOV76
X-Message-ID-Hash: 2YUTNPWHM4I4O2ZA5FDZK4CCLQVQOV76
X-MailFrom: sashiko-bot@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: airlied@gmail.com, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, echanude@redhat.com, mripard@kernel.org, media-ci@linuxtv.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2YUTNPWHM4I4O2ZA5FDZK4CCLQVQOV76/>
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
- [Low] mm: memcontrol: task_css() race with migration in
  get_obj_cgroup_from_fd()
--

commit 62e5304eba9bb9d84f6229eddf1a9273649483b8
Author: Albert Esteve <aesteve@redhat.com>

dma-heap: charge dma-buf memory via explicit memcg

This commit adds a charge_fd field to struct dma_heap_allocation_data so
DMA_HEAP_IOCTL_ALLOC can resolve a target cgroupfd or pidfd via
get_obj_cgroup_from_fd() and charge system heap allocations to that
cgroup.

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e4a9af2fdaa3b..7826bc21bea9e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
[ ... ]
> @@ -3171,6 +3172,88 @@ struct obj_cgroup *get_obj_cgroup_from_folio(const=
 struct folio *folio)
>  	return objcg;
>  }
> =20
[ ... ]
> +struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
> +{
> +	struct cgroup_subsys_state *css;
> +	struct obj_cgroup *objcg;
> +	struct mem_cgroup *memcg;
> +	struct task_struct *task;
> +	unsigned int pidfd_flags;
> +
> +	if (mem_cgroup_disabled())
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	CLASS(fd_raw, f)(fd);
> +	if (fd_empty(f))
> +		return ERR_PTR(-EBADF);
> +
> +	css =3D css_tryget_online_from_dir(fd_file(f)->f_path.dentry,
> +					 &memory_cgrp_subsys);
> +	if (!IS_ERR(css) && !cgroup_on_dfl(css->cgroup)) {
> +		css_put(css);
> +		css =3D ERR_PTR(-EBADF);
> +	}
> +
> +	if (IS_ERR(css)) {
> +		if (PTR_ERR(css) !=3D -EBADF)
> +			return ERR_CAST(css);
> +
> +		/* fd is a pidfd */
> +		task =3D pidfd_get_task(fd, &pidfd_flags);
> +		if (IS_ERR(task))
> +			return ERR_CAST(task);
> +
> +		rcu_read_lock();
> +		css =3D task_css(task, memory_cgrp_id);
> +		put_task_struct(task);
> +		if (!css || !css_tryget_online(css)) {
> +			rcu_read_unlock();
> +			return ERR_PTR(-ENOENT);
> +		}
> +		rcu_read_unlock();
> +	}

[Severity: Low]
Can the pidfd lookup in get_obj_cgroup_from_fd() spuriously fail with
-ENOENT when the target task is concurrently migrated or has an exited
thread-group leader?

Between task_css() and css_tryget_online(), the task can be migrated to
another cgroup and its previous cgroup offlined, causing the one-shot
css_tryget_online() on the stale css to fail.  Also, pidfd_get_task() on
a process pidfd returns the thread-group leader, which in a
multi-threaded process may already have PF_EXITING set and remain
attached to an offline css even while its obj_cgroup has been reparented
to an online ancestor that get_obj_cgroup_from_memcg() walks up to:

include/linux/cgroup.h:task_get_css() {
	rcu_read_lock();
	while (true) {
		css =3D task_css(task, subsys_id);
		/*
		 * Can't use css_tryget_online() here.  A task which has
		 * PF_EXITING set may stay associated with an offline css.
		 * If such task calls this function, css_tryget_online()
		 * will keep failing.
		 */
		if (likely(css_tryget(css)))
			break;
		cpu_relax();
	}
	rcu_read_unlock();
	return css;
}

Using task_get_css(task, memory_cgrp_id) before put_task_struct(task)
would avoid both failure modes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-v2_2023012=
3_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com?part=3D2
