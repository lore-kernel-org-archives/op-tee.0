Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC9F606A32A
	for <op-tee@archiver.kernel.org>; Wed, 25 Nov 2026 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=O+UVUyxB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W8qzdNPy
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 22AF650354
	for <op-tee@archiver.kernel.org>; Wed, 25 Nov 2026 16:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795623263;
	bh=4FP2wKi0lgS+RN/hlESjXWlTyIU6UktbjBMjS+F51Aw=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=O+UVUyxBDgjusehl0Bbhf+FGuDss3jaVtZoqexGHcJeIfH+dSOAVhYvrcEtW17DsE
	 3sI8YxQUonpQds27hZYQZfBTiHA6WwntZNwKadhvkDsYSDc+5dnjysZWpZgHqGzbmf
	 bNxwe7PozvCU4sl7jcuJVqywQX8KpvA+jjWw06tzx8xx/RgPW7KndTT43euxU632xj
	 wwNRqhfEDq4+tm09AG8cFaFeJ5gWImiwLBlPWAi7b17nKS+2n6IyPh9siI89/OjYKi
	 DFd4UXkph9U8rX0fPfPwuri0pPirmuQMI90U6M1k8FnKktcaHPzX/u93lrxkVT65Kk
	 etKd9tdT8aqZQ==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DA531452B4
	for <op-tee@lists.trustedfirmware.org>; Wed, 25 Nov 2026 16:14:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W8qzdNPy;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795623257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LdER2mkFO0wbjr2+rc/aRUmp4/Sc5QyLtaG22Ye9JSE=;
	b=W8qzdNPyP6TXFHje/kBd0sOqgpTmQgGosZ9gBthCuCqj0OwzKnni4EDTnWrbdNmgi9csQj
	IlXATb74lRlgK8Lqf0YdU17DBCzF1/bseEe7IhLwEBlab0u/S4dZHntO9r76Ni7wSi9IRI
	UwHd5a4t2l8SzgGCcKwQ/4bpTSfvJyc=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-nbAU9bQPOKOY3MveRvBRUg-1; Wed, 25 Nov 2026 16:14:14 +0000
X-MC-Unique: nbAU9bQPOKOY3MveRvBRUg-1
X-Mimecast-MFC-AGG-ID: nbAU9bQPOKOY3MveRvBRUg_1795623253
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-466d41a1d9aso4653791fac.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 25 Nov 2026 08:14:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795623253; x=1796228053;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LdER2mkFO0wbjr2+rc/aRUmp4/Sc5QyLtaG22Ye9JSE=;
        b=pqzR5qt7kTjVXZ8ASrG1vuYIXaxWNlO30VUs/ONuuPXAGA3upic264P9WSJFS+Jz8n
         atHw0nuoaE/v9YQlTdM6Q5uVn+st4kU9Syji7zpjn19sxpPae3aZYiJQkPVoavgPTcCQ
         qCDuFxOxl2iwvN5Qdr006yxMLpw3w7PPV0EcTm1uC/IzTCVZMFS79BAno1cCAU7dzVTa
         K3l8zBSj5VzrpPJpcdiyYPnkb8TKPaceF6jx4muH/rniW5OFwfj7JNFRkBBE5Q79QXJ3
         aPvLC9ATK3SMD6AgzQcMxREJh6JCbkEe0Wh0Y65Hn0xqlGfTw2qNsmVF1EM+avG613wf
         SdUw==
X-Forwarded-Encrypted: i=1; AL+hErHyJYCwMPkqAEUGLUNPdTNna2TmNh5jFjE24FoXoJCh3WbqJ6xFgnhXdQgKLmCzzr7mUoO51LI=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z+L0EMOHulJvP1kwdUOjtjQ6MENQJ0wgJa3iu5P4iea37YpSUTC
	4ZlJeRAKaFdQHIpFEyt3FHTt6E8obMvLuePI2c1iaIkZ/DR5dIBZS6+apPeJnutGGIGCykRtCqM
	dO9+0Tf/11+n7hm4ClKxaRfEuNJG1w7eian32kN6WDSleaCbg4zbXDmQL7iyJH4JvEDfdx5BelH
	Lk7bj76NFDXVNj6S8HC5hVeo3wT3a9AJf0i6WDQ56CgobRxw==
X-Gm-Gg: AZFdTZdeMygeFzA4bbWtSYsiUCboL6l34OgHe8V/J5y7cuuQ8MAyv+yDxcC5fjWkSCq
	rNw9La+DHlcH4J27nVrgWe7sau0Tg/iZWW817ZEw713IZK1nIqeAF8UtnyZ1PtfQ02lGnqN36ut
	IYubI/IRXqJB5wlN/1z6ymncWpwxX/eW28EFoBiag0aupC/HUtZe7pfe52
X-Received: by 2002:a05:6808:c3cb:b0:577:2888:47b3 with SMTP id 5614622812f47-57a0ac33d63mr20058862b6e.44.1795623253405;
        Wed, 25 Nov 2026 08:14:13 -0800 (PST)
X-Received: by 2002:a05:6808:c3cb:b0:577:2888:47b3 with SMTP id
 5614622812f47-57a0ac33d63mr20058815b6e.44.1795623252854; Wed, 25 Nov 2026
 08:14:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124-v2_20230123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com>
 <20261124-v2_20230123_tjmercier_google_com-v6-2-dce12fa03ad6@redhat.com> <sashiko-outbox-233444@kernel.org>
In-Reply-To: <sashiko-outbox-233444@kernel.org>
Date: Wed, 25 Nov 2026 17:13:58 +0100
X-Gm-Features: Aa3M54qC4BhV46Zvi5xNNVUyWvQwOqnECHDuj67-iKiUZ4P0AUQ6JhGMrN001Kw
Message-ID: <CADSE00KEAYZ+saAoTY81VNhNyevsWFD_nSDNgsPVfvvLBsE5vQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] dma-heap: charge dma-buf memory via explicit memcg
To: sashiko-reviews@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f_SD2noZg6IiK1SOffZXmcODDxPrCVKXtkAvPd45vxg_1795623253
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[redhat.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	RWL_MAILSPIKE_EXCELLENT(-0.40)[170.10.129.124:from];
	R_SPF_ALLOW(-0.20)[+ip4:170.10.129.0/24];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	RCVD_IN_DNSWL_LOW(-0.10)[170.10.129.124:from];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:30031, ipnet:170.10.128.0/23, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[37];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org,lists.freedesktop.org,kvack.org,vger.kernel.org,lists.trustedfirmware.org,redhat.com,linuxtv.org];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.72:received];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DA531452B4
X-Spamd-Bar: ----
Message-ID-Hash: PG24X2YSN4GIXW6P4UCX3M4FHMZKMZED
X-Message-ID-Hash: PG24X2YSN4GIXW6P4UCX3M4FHMZKMZED
X-MailFrom: aesteve@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, Jens Wiklander <j
 enswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Philipp Stanner <phasta@kernel.org>, airlied@gmail.com, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, echanude@redhat.com, mripard@kernel.org, media-ci@linuxtv.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PG24X2YSN4GIXW6P4UCX3M4FHMZKMZED/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Albert Esteve via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Albert Esteve <aesteve@redhat.com>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 2:05=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] mm: memcontrol: task_css() race with migration in
>   get_obj_cgroup_from_fd()
> --
>
> commit 62e5304eba9bb9d84f6229eddf1a9273649483b8
> Author: Albert Esteve <aesteve@redhat.com>
>
> dma-heap: charge dma-buf memory via explicit memcg
>
> This commit adds a charge_fd field to struct dma_heap_allocation_data so
> DMA_HEAP_IOCTL_ALLOC can resolve a target cgroupfd or pidfd via
> get_obj_cgroup_from_fd() and charge system heap allocations to that
> cgroup.
>
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index e4a9af2fdaa3b..7826bc21bea9e 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> [ ... ]
> > @@ -3171,6 +3172,88 @@ struct obj_cgroup *get_obj_cgroup_from_folio(con=
st struct folio *folio)
> >       return objcg;
> >  }
> >
> [ ... ]
> > +struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
> > +{
> > +     struct cgroup_subsys_state *css;
> > +     struct obj_cgroup *objcg;
> > +     struct mem_cgroup *memcg;
> > +     struct task_struct *task;
> > +     unsigned int pidfd_flags;
> > +
> > +     if (mem_cgroup_disabled())
> > +             return ERR_PTR(-EOPNOTSUPP);
> > +
> > +     CLASS(fd_raw, f)(fd);
> > +     if (fd_empty(f))
> > +             return ERR_PTR(-EBADF);
> > +
> > +     css =3D css_tryget_online_from_dir(fd_file(f)->f_path.dentry,
> > +                                      &memory_cgrp_subsys);
> > +     if (!IS_ERR(css) && !cgroup_on_dfl(css->cgroup)) {
> > +             css_put(css);
> > +             css =3D ERR_PTR(-EBADF);
> > +     }
> > +
> > +     if (IS_ERR(css)) {
> > +             if (PTR_ERR(css) !=3D -EBADF)
> > +                     return ERR_CAST(css);
> > +
> > +             /* fd is a pidfd */
> > +             task =3D pidfd_get_task(fd, &pidfd_flags);
> > +             if (IS_ERR(task))
> > +                     return ERR_CAST(task);
> > +
> > +             rcu_read_lock();
> > +             css =3D task_css(task, memory_cgrp_id);
> > +             put_task_struct(task);
> > +             if (!css || !css_tryget_online(css)) {
> > +                     rcu_read_unlock();
> > +                     return ERR_PTR(-ENOENT);
> > +             }
> > +             rcu_read_unlock();
> > +     }
>
> [Severity: Low]
> Can the pidfd lookup in get_obj_cgroup_from_fd() spuriously fail with
> -ENOENT when the target task is concurrently migrated or has an exited
> thread-group leader?
>
> Between task_css() and css_tryget_online(), the task can be migrated to
> another cgroup and its previous cgroup offlined, causing the one-shot
> css_tryget_online() on the stale css to fail.  Also, pidfd_get_task() on
> a process pidfd returns the thread-group leader, which in a
> multi-threaded process may already have PF_EXITING set and remain
> attached to an offline css even while its obj_cgroup has been reparented
> to an online ancestor that get_obj_cgroup_from_memcg() walks up to:
>
> include/linux/cgroup.h:task_get_css() {
>         rcu_read_lock();
>         while (true) {
>                 css =3D task_css(task, subsys_id);
>                 /*
>                  * Can't use css_tryget_online() here.  A task which has
>                  * PF_EXITING set may stay associated with an offline css=
.
>                  * If such task calls this function, css_tryget_online()
>                  * will keep failing.
>                  */
>                 if (likely(css_tryget(css)))
>                         break;
>                 cpu_relax();
>         }
>         rcu_read_unlock();
>         return css;
> }

Valid. I will apply this for the next version.

>
> Using task_get_css(task, memory_cgrp_id) before put_task_struct(task)
> would avoid both failure modes.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-v2_20230=
123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com?part=3D2
>

