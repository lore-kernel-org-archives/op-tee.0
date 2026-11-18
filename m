Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA84D606A332
	for <op-tee@archiver.kernel.org>; Wed, 18 Nov 2026 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=nX0FdrEY;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=feIg5nbJ
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1C828454F1
	for <op-tee@archiver.kernel.org>; Wed, 18 Nov 2026 08:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794991267;
	bh=WrojXc/5AKsoGyc/KbAcHZBkMOfXrhQAg8AN+JwO0rI=;
	h=Subject:To:In-Reply-To:References:Date:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=nX0FdrEYBZ/TwwuoZlC1Zlb5QpTY3CkO+J+ubL/c22rrkhXZbymRPNn4sboFaatwJ
	 Yfz37UBYoiowBGWASjUKe8EjJ2tGDWe1pjlvD+TRYf3rh5kxpQar96fXgXDHlRiWtC
	 4QRNpkQwaJCTsPdaQJeRRmQG4i6z2WTKJLoaSf0vQr4gEQdlbEk3Z7tOIVEq8IApzF
	 h+VMtZR+guKv1nOhyUBBB+UndybWzI9wbclibhpfy4Brc7B8ZNcA8gPhwEGOTE2SZl
	 e4nhQKlQg4SNYHQC7EytQ536aEzpgyIu908mdbYZu8fEn3kiHsM9ywl9hSQu0QoCxp
	 D3lL6aFw6jlGg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5CD0D44E57
	for <op-tee@lists.trustedfirmware.org>; Wed, 18 Nov 2026 08:41:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=feIg5nbJ;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D4BD561B42;
	Wed, 18 Nov 2026 08:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E482C1F000C4;
	Wed, 18 Nov 2026 08:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991261;
	bh=IdaKqlzukNksjVfifP64arAvMVrVLyE39e40pX+LyqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=feIg5nbJbO2b2EYanKLYw5Jz9X/ZlURQvCTbD7uE9fauni3bxe2rCTl2/yUzQyBVb
	 7N/dtTDt+OZdv/ucKM67qfnajtCQk5rXqLj3S/dzbkmVTnae8KwIxEKTtVE4iyHYNX
	 oiWr2uBh2obHcaWCHy8n2xa4Wr0CpRuRdjx6JuI1EUnt7TT016ncPAYdiSc8IxXSz1
	 LZjDLyZ8ZZqjpvZ/ZjHcGGfRDpm3FetVsbRM9EFQITvGcr3GU8DaCYPa8IWeisXr5r
	 YnpjKB2wbQ/D6KezcCLNv/azt+46FcmWceScj3Ed5hPZALEtiDZEQQCMPFbab60o76
	 5z/Ha5rErJTKA==
Message-ID: <sashiko-outbox-220468@kernel.org>
Subject: Re: [PATCH v5 2/8] dma-heap: charge dma-buf memory via explicit
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
In-Reply-To: <20261117-v2_20230123_tjmercier_google_com-v5-2-1ce975f2a9ad@redhat.com>
References: <20261117-v2_20230123_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com>
 <20261117-v2_20230123_tjmercier_google_com-v5-2-1ce975f2a9ad@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:40:59 +0000
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.20 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	RCVD_IN_DNSWL_MED(-0.20)[172.105.4.254:from];
	MIME_GOOD(-0.10)[text/plain];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_CC(0.00)[gmail.com,lists.freedesktop.org,kvack.org,vger.kernel.org,lists.trustedfirmware.org,redhat.com,kernel.org,linuxtv.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5CD0D44E57
X-Spamd-Bar: -----
Message-ID-Hash: Q3NGMYVJLJRKTSWXWPJKUX2ILBCKQKRY
X-Message-ID-Hash: Q3NGMYVJLJRKTSWXWPJKUX2ILBCKQKRY
X-MailFrom: sashiko-bot@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: airlied@gmail.com, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, echanude@redhat.com, mripard@kernel.org, media-ci@linuxtv.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Q3NGMYVJLJRKTSWXWPJKUX2ILBCKQKRY/>
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

commit 7e6b5f51c2c9a154a8386e2fbe69f7c3fe1c4a27
Author: Albert Esteve <aesteve@redhat.com>

dma-heap: charge dma-buf memory via explicit memcg

This commit adds a charge_fd field to struct dma_heap_allocation_data so
DMA_HEAP_IOCTL_ALLOC can resolve a target cgroup from a pidfd or cgroupfd
and charge system-heap dma-buf allocations to that cgroup's obj_cgroup.

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 45e82cda7c441..adc0abcf80fae 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
[ ... ]
> @@ -3168,6 +3169,88 @@ struct obj_cgroup *get_obj_cgroup_from_folio(const=
 struct folio *folio)
[ ... ]
> +struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
> +{
[ ... ]
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
> +			rcu_read_unlock();\n> +			return ERR_PTR(-ENOENT);
> +		}
> +		rcu_read_unlock();
> +	}

[Severity: Low]
Can this one-shot task_css() and css_tryget_online() lookup spuriously fail
with -ENOENT?

CPU0                                  CPU1
get_obj_cgroup_from_fd()
  rcu_read_lock()
  css =3D task_css(task, ...)
                                      cgroup_migrate_execute()
                                        css_set_move_task(task, ...)
                                      cgroup_destroy_locked()
                                        kill_css_finish()
  css_tryget_online(css)  <-- false
  return ERR_PTR(-ENOENT)

Also, pidfd_get_task() on a process pidfd returns the thread-group leader;
if that leader has exited (PF_EXITING) in a multi-threaded process whose
remaining threads migrated and whose old cgroup was offlined, the leader
stays associated with the offline css even though get_obj_cgroup_from_memcg=
()
can walk up to its online ancestor.  Using task_get_css(task, memory_cgrp_i=
d)
before put_task_struct(task) avoids both issues:

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-v2_2023012=
3_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com?part=3D2
