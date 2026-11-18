Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A29606A332
	for <op-tee@archiver.kernel.org>; Wed, 18 Nov 2026 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=jC6Oxr2C;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DGPTWsj1
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 914B245411
	for <op-tee@archiver.kernel.org>; Wed, 18 Nov 2026 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795009128;
	bh=bISyVxnuTgRpZ6UXZVEbf+O3Bsk9IZe6/iIjh6Td4WM=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=jC6Oxr2ChoDvrg/j9LR21SrfG0yYBeTXTuQWqw0wGc6qBIwmXl2uoBgzZrwu23uRG
	 IYGUfZ0M/VbyHlRWc1rohxrFEuMotmlINxOsRD82ZTJ6Jk1Yur30ji17dcpRyHfq8p
	 T1ZHQzKo4c18PCWZdbc5/YLxOFFB56BNwDsHlRh+XoXf2dh2ma6ohSqPg2iUlXH4Pf
	 iK8lQor8emH4nk/a1y5gG5GYRQEw2uas6ZctWtzlMbPTiclAn5sXIlNza7Yek4Q8lC
	 lQZhYhd2VS1NE9npTcg8hOYYevcnK0bu6DRnuKQOZxtCWxzI1yNw+8mUeXonv7NuKM
	 tT3qEW5qiKD4A==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4662E43AD0
	for <op-tee@lists.trustedfirmware.org>; Wed, 18 Nov 2026 13:38:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DGPTWsj1;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795009123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h50xYCZDbBstrT/18dKKndyJ3XtJH6sY5/J/QnXGpDQ=;
	b=DGPTWsj1tcK7BHakniQKRg5wXJb+lKnVxEXj7BGYIhDdMMYbwh2Wr4/0Q49v/m3qW/dsds
	PXzd7CI8GoGaxh0JFgxa6zOio0f0IZ5MVYE9tBbnaiArvxV89Y8rW+ZKtFnlw/19nIqn4Z
	OXySadyFXfPUeMnq2XHkraGwVLEvGSw=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-FZ_EOIfePmmuuKDVGGIXlg-1; Wed, 18 Nov 2026 08:38:41 -0500
X-MC-Unique: FZ_EOIfePmmuuKDVGGIXlg-1
X-Mimecast-MFC-AGG-ID: FZ_EOIfePmmuuKDVGGIXlg_1795009121
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b30ffeb2f5so14474497b3.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 18 Nov 2026 05:38:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795009121; x=1795613921;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h50xYCZDbBstrT/18dKKndyJ3XtJH6sY5/J/QnXGpDQ=;
        b=q+/nbXO9ylRw5qG0q3uhU/TvFGO3Aiaz/Pvqqd3DwQ+FxdhW25wB1cWXpDnkUQ+sHn
         ECk/4DFaY0cOgV+J9zqOc2TVKSH2FczqCbzOpHFVjvHEDBL973FPv9UGffXPE4xfmb/e
         /F/HHxR8ubjjtj6FNRKVnMB1IbtllEHgQ0OPl4lnJm6baRPy8nMoihvky+B3S3PjfhG6
         sb6gsjQ9hOiZb1Vdm9NrQHZRgVDjRDPnkwnNcAV2c2zfk0FmG3OwwN3zqMygcVsC1sAA
         JUjLbpS60y7CNsylScm607t8swX7f+LRtX5UwSBqdeXltrY7Ch7f7IZX90dx1wIibWAW
         Z0TA==
X-Forwarded-Encrypted: i=1; AL+hErFX9uUboLfnqGo5IhatZNMS3bVucX8IR8hsgHqLabBeQmOUAADl2D5nAfgG/e11f0cI9YRVTKU=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z+EfsXPTxE6aqqUpLSE061Q/WgF0ToMugcJBXdpStIuEudWV+OA
	JizL/LHuYngX3pU2edHXV5vQMKgfX2MFL9Pqf9gbUOuo0QhLtnHOjqC80FNcV6DIGUxhnHokK+T
	3J6QQw+aNOWyAb1jvN0P4Gyms++elnJYwj2zqTufOy5EhJB3DfubaSOx0ywT7gf8XtRXMtW+oLV
	OLL5QyjrpFUeN4WjAM2z6HUnd+KlYIoyn8wggr4T2YWIhtfQ==
X-Gm-Gg: AZFdTZdm5mXQofjaDz43rizxipCmbxfc9PFwJDqS96makkmReK6fx6c9fIJH9DiCFIS
	ViqdQIYNdEBJBxNQE4FHWk4jpGUSg1eka2M3MvDnS4Lbb0NIj/9+eIvYFhhe4UBZaSuK5+LvEAO
	2kD4rC6gDm6+kBYRy6KVx8vIaFvqQmQB2LfeDd6yTxAqLQwheozFbsBhQl
X-Received: by 2002:a05:690c:368a:b0:873:5bb2:6bfd with SMTP id 00721157ae682-8b4fed83351mr10018107b3.39.1795009120722;
        Wed, 18 Nov 2026 05:38:40 -0800 (PST)
X-Received: by 2002:a05:690c:368a:b0:873:5bb2:6bfd with SMTP id
 00721157ae682-8b4fed83351mr10017817b3.39.1795009119849; Wed, 18 Nov 2026
 05:38:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117-v2_20230123_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com>
 <4356992ac4fb7876fb5759189ba4b492@paul-moore.com>
In-Reply-To: <4356992ac4fb7876fb5759189ba4b492@paul-moore.com>
Date: Wed, 18 Nov 2026 14:38:28 +0100
X-Gm-Features: Aa3M54php6hihR6Ihi3l34Ri9nQdKaLYB3Ss2kJeRmi5f3v9ab0vBjDa0q2nnvI
Message-ID: <CADSE00JyTwrbNh4r8PZWLqOHWpepyHkaL+9fkc+AbVRmCc-f-g@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] memcg: dma-buf cgroup accounting and charge transfer
To: Paul Moore <paul@paul-moore.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qtqivUjozDm84yeIEhj6sAlVfn3L595AcAt3TYVhCIU_1795009121
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
	ASN(0.00)[asn:30031, ipnet:170.10.128.0/23, country:US];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,namei.org,hallyn.com,gmail.com,infradead.org,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org,lists.trustedfirmware.org,redhat.com];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.128.198:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4662E43AD0
X-Spamd-Bar: ----
Message-ID-Hash: D4BXBOLBYZJYHGF2UHTRV7O6MZMVBAGH
X-Message-ID-Hash: D4BXBOLBYZJYHGF2UHTRV7O6MZMVBAGH
X-MailFrom: aesteve@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, Christian Brauner <brauner@kernel.org>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sum
 it.garg@kernel.org>, Philipp Stanner <phasta@kernel.org>, airlied@gmail.com, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, echanude@redhat.com, mripard@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/D4BXBOLBYZJYHGF2UHTRV7O6MZMVBAGH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Albert Esteve via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Albert Esteve <aesteve@redhat.com>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 11:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Nov 17, 2026 Albert Esteve <aesteve@redhat.com> wrote:
> >
> > Shared-memory allocator services (e.g., Android's gralloc)
> > allocate dma-bufs on behalf of client processes in different
> > cgroups. Today those allocations are charged to the allocator's
> > own cgroup, leaving client cgroups with no visibility into their
> > actual memory consumption and defeating resource limits.
> >
> > This series adds memory cgroup accounting for dma-buf allocations,
> > building on T.J. Mercier's earlier series [1] and incorporating
> > feedback from previous versions and LPC discussions [2].
> >
> > Patch 1 introduces the MEMCG_DMABUF stat and the
> > obj_cgroup_reserve_dmabuf()/obj_cgroup_cancel_dmabuf() and
> > mem_cgroup_commit_dmabuf()/mem_cgroup_uncharge_dmabuf() helpers
> > in mm/memcontrol.c
> >
> > Patch 2 wires up the charging policy: dma_buf_export() stores
> > exp_info.objcg and updates the stat, a new charge_fd field in
> > DMA_HEAP_IOCTL_ALLOC accepts a pidfd or cgroupfd to identify
> > the target cgroup, and __GFP_ACCOUNT is removed from system-heap
> > allocations to avoid double counting.
> >
> > Patch 3 adds DMA_BUF_IOCTL_XFER_CHARGE, a general ioctl on any
> > dma-buf fd to transfer charges post-allocation. This covers the
> > double-hop allocator case (SurfaceFlinger -> gralloc -> kernel)
> > and works for buffers from any exporter that opts in. Charging
> > is gated by dmabuf->objcg being set at export time, ensuring that
> > transfer is only applied for buffers backed by system memory where
> > size reflects actual bytes. If the receiving cgroup lacks capacity
> > for the charge, the ioctl returns -ENOMEM and the original charge
> > is preserved.
> >
> > Patches 4-7 add access control for cross-cgroup charging. Letting
> > userspace decide who to charge needs to be a privileged operation
> > because it has material impact on OOM decision and resource limits.
> > Charging outside the caller's own memcg subtree requires
> > CAP_SYS_RESOURCE. On top of that, LSM hooks gate the two charge_fd
> > flavours: security_memcg_charge_task() gates the pidfd path (target
> > identified by task credentials) and security_memcg_charge_cgroup()
> > gates the cgroupfd path (target identified by cgroup directory label),
> > with SELinux implementations using process2:charge_to and
> > cgroup:charge_to permissions.
>
> I'm probably misunderstanding the description here, but in both cases
> (the pidfd or cgroupfd case), ultimately the cgroup is charged, yes?  In
> the cgroupfd case it is more direct, but in the pidfd case it is still
> the cgroup associated with the process identified by pidfd, yes?

Your understanding is correct here.

>
> If that's the case - and it very well may not be (!) - it probably makes
> more sense to combine the two SELinux access controls into one.  Yes, the
> LSM hooks and callbacks would likely need to be different due to the
> mechanics of it, but the permission check "cgroup/charge" could be the
> same.

Combining SELinux access controls makes sense to me. I kept them split
because I wanted to preserve granularity between the two flavours, and
process2 seemed like a natural fit for the pidfd path, but I guess it
can still be achieved with a single permission through the target
types.

I'll rework for v6. So, in the pidfd case the check target would
remain the process's domain:

   allow allocator_t client_t:cgroup charge_to;

where allocator_t is the domain requesting the charge (i.e., the
central allocator), and client_t is the domain of the process the
pidfd refers to. The groupfd path would check the cgroup directory
label like so:

  allow allocator_t cgroup_t:cgroup charge_to;

Would that be ok?

>
> > Patch 8 adds selftests. The tests and vmtest script were mostly
> > written by an LLM, closely following the style of the surrounding
> > tests and the virtme-ng setup. All code has been reviewed and tested.
>
> I think we need to have selinux-testsuite tests to go along with
> this, especially as this would be the first patchset to add cgroup
> controls.  Historically I've pushed back on piecemeal cgroup additions,
> pushing for some basic design of how to manage access controls for
> resource management first, but since evidently no one wants to do that,
> we really do need tests.
>
> https://github.com/SELinuxProject/selinux-testsuite

Agreed! I was already playing with it between the last version and
this one. I have some tests drafted, more or less. I was unfamiliar
with the testsuite, so instead of offloading the work to an LLM, I
tried to follow along and proceeded too slowly.

I will link a PR when sending the next version.

>
> > Known limitations:
> >
> > - Single-owner model: a dma-buf carries one memcg charge regardless
> >   of how many processes share it.
>
> Once again, I'm sure I'm misunderstanding things, but are you saying
> that multiple cgroups can end up sharing the same dma-buf despite
> only one of the cgroups taking the accounting hit?

Yes, you are correct. A dma-buf (its fd) can be shared by multiple
processes from multiple cgroups, but only one holds the charge. With
this series it can be transferred, but never shared.

Sharing could be a follow-up series. Perhaps splitting the charge
equally? But sharing is a big problem on its own, so I preferred to
keep it out of this series.

>
> Hopefully the charged cgroup is deterministic?

Yes, the charged cgroup is deterministic: it is set at allocation, and
only moves via an explicit ioctl.

>
> > - Only memcg accounting. CMA heaps would additionally need dmem
> >   controller integration.
>
> Do you have a rough idea of how that would work?  I ask only because I'm
> interested in seeing if that would require an additional LSM hook or if
> there is some way we could leverage the same hook(s) used here.

Rough idea, yes. Today, no dma-buf allocation charges dmem at all, and
of course no target charging either. The first goal for CMA is simply
getting those heaps accounted. In that regard, Eric Chanudet has a
series making CMA allocations memcg-accountable with per-area counter
[1], and is working on extending that approach to dmem. It's a bit on
hold waiting for the feedback on this series.

But afaik the cross-cgroup charging and central allocator problem is
mainly a system-memory one. Whether dmem ever needs the same
cross-cgroup attribution (e.g., DRM central allocator wanting to
charge clients' dmem budgets) is not clear to me.

Nonetheless, if it does, the internals should be mostly the same;
everything, including the permission checks is controller-agnostic.
Only the controller performing the charge changes. I expect no
additional hook is required.

[1] https://lore.kernel.org/all/20260821-cma-memcg-regions-v1-0-d21b165b844=
0@redhat.com/

>
> > - If a transfer of an uncharged buffer fails, the buffer remains
> >   charged to the original cgroup. The allocator (userspace) is
> >   expected to handle this (retry, free, ...).
> > - The LSM hooks are intentionally narrow. Broader cgroup access control=
s
> >   (e.g. for the memfd/kexec handover case [2]) could be a separate effo=
rt
> >   reusing the same pattern.
> > - Only system heap sets exp_info.objcg today. Other exporters
> >   (DRM, V4L2, etc.) can opt in by setting it, but are not
> >   covered by this series.
> > - Related to the above: lazy backing-store allocation is not supported.
> >   This can be extended later, e.g., by adding a flag on the dma-buf
> >   struct for explicitly marking when memory is committed.
>
> Similar to the CMA case, any rough ideas on what this would look like?

Yes, again I have a rough idea. We already separate reserve and commit
operations, so the idea is to delay when a charge is committed. For
that we can use a flag in the dma-buf struct to mark when the memory
is committed. The limit is still enforced up front (so a lazy exporter
cannot overcommit), and the stat reflects the actual allocation.

The permission model is also unchanged for this case. The flag only
affects when the stat will reflect the charge.

Thanks!
Albert.

>
> > Note on TTM/GPU accounting [3]: that effort charges system memory
> > allocated for GPU buffers per page, with its own stats (gpu_active
> > and gpu_reclaim). This series charges at the dma-buf level, for
> > memory with no memory.stat category of its own; exporters whose
> > memory is already charged by their allocator must not opt in, so
> > the two do not overlap.
> >
> > [1] https://lore.kernel.org/cgroups/20230109213809.418135-1-tjmercier@g=
oogle.com/
> > [2] https://lpc.events/event/20/contributions/2416/
> > [3] https://lore.kernel.org/all/20260706052330.1110909-1-airlied@gmail.=
com/
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
>
> --
> paul-moore.com
>

