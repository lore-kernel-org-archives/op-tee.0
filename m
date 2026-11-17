Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9258C606A31C
	for <op-tee@archiver.kernel.org>; Wed, 18 Nov 2026 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=S0UWAbq/
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D0683454FC
	for <op-tee@archiver.kernel.org>; Wed, 18 Nov 2026 12:12:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=S0UWAbq/;
	dkim-atps=neutral
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8499C4528C
	for <op-tee@lists.trustedfirmware.org>; Tue, 17 Nov 2026 22:54:49 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91f23ddf32fso1749156d6.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 17 Nov 2026 14:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794956089; x=1795560889; darn=lists.trustedfirmware.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k7/QLUvYDzH8xZxy3OOm+8SYpFBmpzd+eC/ISXSLxiA=;
        b=S0UWAbq/GkBqzYB9ViIbq7ppGW8N0ju47jOeQeAfIjNVlwia4yjRrylCVJX47XjpC5
         xvx+coPI7YeeVrox+2TXPQwG/vOUxogqoXBg3F9AwDlVNVY928nXWlKDJw/W2lA0fX2x
         UGkm0E5kCZ1kpD81PZUYmhzH5MOLAMe4VF4vToupy8x18CvbAOsflJIXCmxhSQZIe48e
         1qAB48JR+ZUjTaDK6VOOkT14V6HZMddmg4fi7HycpZOm74drjcO7P5RdVV+GevwDi9zW
         LqJfP3JHS/EKML1CZhr1F+zUQMExmepbUePkI+5QsvnirjueMGmUdrx6rcnB3AQOfwqu
         5CPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794956089; x=1795560889;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k7/QLUvYDzH8xZxy3OOm+8SYpFBmpzd+eC/ISXSLxiA=;
        b=fYNCzBcRXYz6hTShu1tN/XUykqmXil6TRKGu1JQIbBSGYG8qXxtQ5MyD4lSufc/Yzw
         L+uDCl2bBYS+D/YO78qYDxl7wSJgaF6L8KEiAety225w+rDDpzBdc6+5nByNkeg8oBFh
         orlLoz8MHUKx0/cPqPLOPRxNTAbqF+0hrMmDYernq7ThMxZiNSh9a0qlFa8A2Xm7ruYj
         FanThAxERwFn6JCdURmp9u7OarNKSuiQpR9e0nxH+V+1rexjYmGXr77xeadueInMVR7J
         2P2erKhscNLegfVUv2DCNAAKT26HoBpSglaM9xkBOfEfznzRxAjSRioe5lbxPyeprBE/
         G/Ow==
X-Forwarded-Encrypted: i=1; AL+hErFiMG0uWiybtwfW8kH/jt0ntOG7TOR1H5t2rEuD74DeYPQD0NgqSK9mRo0YEGG0WELnU6jVAQU=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z/+4igfxuLe3C2RKQTsohSfZihMLiP0ufZfRiZFtxvj2YLuo2ka
	6rc2QgRIU4NECaXdVnBhHbaVkIyn6oZRXw/yiWZUS5aEdbiTW6H+s7kPInNuHdL7HQ==
X-Gm-Gg: AZFdTZf6m7Xj2wPHWzKuK30SbMaASa7UO6o3AN/YteEgAce0CnHq43iOyWUmNbz1g2X
	e2hkl9T5RMNJIoDuVszw1eqyhYygA++uPi3hWpXlcNCorZvRbJZFhLxCYVIykKavqBjpwqNSCak
	eCdlWfKsiJE0D8YjAzBVbJ8PDM8wCBRo5MRJLe0xNACCN4+Nx5iEB/0pFlzJKgjDxoHERBTon5R
	G9cAzo2pLEVZnnnizAUDJ+OGgs+wlD9yFLpr3XdWSWsT8DbeWTddd+qp0PxBSWvzNrdfKZXmQOi
	yXEJzs+/gOh0zxD6IFj2rgklcMFrNmbv3wjjTCD1dRi9yNuMSZI6p/40tiNL3ZgMx73WyvJ4Lqr
	PLtwdXo1QxgOcjXdQEC/kKODOD91aDNgoeWrC3p1CGJr3/ziL8TH6XvAqTxQNhGn8G/CgGGQ9XF
	pG4703jX88AFAt0qsn3yOubqcaOgPMD1G5SVgU01f4KP10k9mMMEjn6/qRdams+OgDruoI5OHp+
	Wc5B+dqSb6JPRehOyKbuB6ENngvxa8AgLA4L6wneNr63Ajs6liz6ed9Sk+hOUajgDpx/IxR/o/e
	3eri7eKGlnTpBURadrqzTtHqikAi7w46acRdG1F+DQanw67I3I1w8KOUaFdzq5tPOCI8F6MtUHq
	ABEJ3kdg+wQHVvQ+MFU5aM5RJiwG2Vw==
X-Received: by 2002:a05:6214:4981:b0:921:9ed:ee6 with SMTP id 6a1803df08f44-92114dd0d06mr10225486d6.20.1794956088668;
        Tue, 17 Nov 2026 14:54:48 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d53b7fsm5495766d6.26.2026.11.17.14.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:54:48 -0800 (PST)
Date: Tue, 17 Nov 2026 17:54:47 -0500
Message-ID: <4356992ac4fb7876fb5759189ba4b492@paul-moore.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261117_1552/pstg-lib:20261117_1552/pstg-pwork:20261117_1552
From: Paul Moore <paul@paul-moore.com>
To: Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>,
	Christian Brauner <brauner@kernel.org>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
	Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
	Philipp Stanner <phasta@kernel.org>
Subject: Re: [PATCH v5 0/8] memcg: dma-buf cgroup accounting and charge
 transfer
References: <20261117-v2_20230123_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com>
In-Reply-To: <20261117-v2_20230123_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	BAYES_HAM(-1.16)[88.79%];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org,lists.trustedfirmware.org,redhat.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,namei.org,hallyn.com,gmail.com,infradead.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	DNSWL_BLOCKED(0.00)[209.85.219.51:from,71.126.255.178:received];
	ALIAS_RESOLVED(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.219.51:from];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8499C4528C
X-Spamd-Bar: /
X-MailFrom: paul@paul-moore.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 3F2BMQ7Y73SVCKF2WIAWLABOXJO7IOGU
X-Message-ID-Hash: 3F2BMQ7Y73SVCKF2WIAWLABOXJO7IOGU
X-Mailman-Approved-At: Wed, 18 Nov 2026 12:12:47 +0000
CC: airlied@gmail.com, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, Albert Esteve <aesteve@redhat.com>, echanude@redhat.com, mripard@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3F2BMQ7Y73SVCKF2WIAWLABOXJO7IOGU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Nov 17, 2026 Albert Esteve <aesteve@redhat.com> wrote:
> 
> Shared-memory allocator services (e.g., Android's gralloc)
> allocate dma-bufs on behalf of client processes in different
> cgroups. Today those allocations are charged to the allocator's
> own cgroup, leaving client cgroups with no visibility into their
> actual memory consumption and defeating resource limits.
> 
> This series adds memory cgroup accounting for dma-buf allocations,
> building on T.J. Mercier's earlier series [1] and incorporating
> feedback from previous versions and LPC discussions [2].
> 
> Patch 1 introduces the MEMCG_DMABUF stat and the
> obj_cgroup_reserve_dmabuf()/obj_cgroup_cancel_dmabuf() and
> mem_cgroup_commit_dmabuf()/mem_cgroup_uncharge_dmabuf() helpers
> in mm/memcontrol.c
> 
> Patch 2 wires up the charging policy: dma_buf_export() stores
> exp_info.objcg and updates the stat, a new charge_fd field in
> DMA_HEAP_IOCTL_ALLOC accepts a pidfd or cgroupfd to identify
> the target cgroup, and __GFP_ACCOUNT is removed from system-heap
> allocations to avoid double counting.
> 
> Patch 3 adds DMA_BUF_IOCTL_XFER_CHARGE, a general ioctl on any
> dma-buf fd to transfer charges post-allocation. This covers the
> double-hop allocator case (SurfaceFlinger -> gralloc -> kernel)
> and works for buffers from any exporter that opts in. Charging
> is gated by dmabuf->objcg being set at export time, ensuring that
> transfer is only applied for buffers backed by system memory where
> size reflects actual bytes. If the receiving cgroup lacks capacity
> for the charge, the ioctl returns -ENOMEM and the original charge
> is preserved.
> 
> Patches 4-7 add access control for cross-cgroup charging. Letting
> userspace decide who to charge needs to be a privileged operation
> because it has material impact on OOM decision and resource limits.
> Charging outside the caller's own memcg subtree requires
> CAP_SYS_RESOURCE. On top of that, LSM hooks gate the two charge_fd
> flavours: security_memcg_charge_task() gates the pidfd path (target
> identified by task credentials) and security_memcg_charge_cgroup()
> gates the cgroupfd path (target identified by cgroup directory label),
> with SELinux implementations using process2:charge_to and
> cgroup:charge_to permissions.

I'm probably misunderstanding the description here, but in both cases
(the pidfd or cgroupfd case), ultimately the cgroup is charged, yes?  In
the cgroupfd case it is more direct, but in the pidfd case it is still
the cgroup associated with the process identified by pidfd, yes?

If that's the case - and it very well may not be (!) - it probably makes
more sense to combine the two SELinux access controls into one.  Yes, the
LSM hooks and callbacks would likely need to be different due to the
mechanics of it, but the permission check "cgroup/charge" could be the
same.

> Patch 8 adds selftests. The tests and vmtest script were mostly
> written by an LLM, closely following the style of the surrounding
> tests and the virtme-ng setup. All code has been reviewed and tested.

I think we need to have selinux-testsuite tests to go along with
this, especially as this would be the first patchset to add cgroup
controls.  Historically I've pushed back on piecemeal cgroup additions,
pushing for some basic design of how to manage access controls for
resource management first, but since evidently no one wants to do that,
we really do need tests.

https://github.com/SELinuxProject/selinux-testsuite

> Known limitations:
> 
> - Single-owner model: a dma-buf carries one memcg charge regardless
>   of how many processes share it.

Once again, I'm sure I'm misunderstanding things, but are you saying
that multiple cgroups can end up sharing the same dma-buf despite
only one of the cgroups taking the accounting hit?

Hopefully the charged cgroup is deterministic?

> - Only memcg accounting. CMA heaps would additionally need dmem
>   controller integration.

Do you have a rough idea of how that would work?  I ask only because I'm
interested in seeing if that would require an additional LSM hook or if
there is some way we could leverage the same hook(s) used here.

> - If a transfer of an uncharged buffer fails, the buffer remains
>   charged to the original cgroup. The allocator (userspace) is
>   expected to handle this (retry, free, ...).
> - The LSM hooks are intentionally narrow. Broader cgroup access controls
>   (e.g. for the memfd/kexec handover case [2]) could be a separate effort
>   reusing the same pattern.
> - Only system heap sets exp_info.objcg today. Other exporters
>   (DRM, V4L2, etc.) can opt in by setting it, but are not
>   covered by this series.
> - Related to the above: lazy backing-store allocation is not supported.
>   This can be extended later, e.g., by adding a flag on the dma-buf
>   struct for explicitly marking when memory is committed.

Similar to the CMA case, any rough ideas on what this would look like?

> Note on TTM/GPU accounting [3]: that effort charges system memory
> allocated for GPU buffers per page, with its own stats (gpu_active
> and gpu_reclaim). This series charges at the dma-buf level, for
> memory with no memory.stat category of its own; exporters whose
> memory is already charged by their allocator must not opt in, so
> the two do not overlap.
> 
> [1] https://lore.kernel.org/cgroups/20230109213809.418135-1-tjmercier@google.com/
> [2] https://lpc.events/event/20/contributions/2416/
> [3] https://lore.kernel.org/all/20260706052330.1110909-1-airlied@gmail.com/
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>

--
paul-moore.com
