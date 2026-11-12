Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F64606A31C
	for <op-tee@archiver.kernel.org>; Thu, 12 Nov 2026 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=jcPLb6jx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FViaeY/F
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9463244F86
	for <op-tee@archiver.kernel.org>; Thu, 12 Nov 2026 09:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794477426;
	bh=UTlQdAaQLyNDHqpnT0wYpr41aFuV2SCeXj+e31yjFqY=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=jcPLb6jxV2ElHg/nPFZTUDYgwKAjk9hhoK8u8pkCHihhKWnjnT6Mf/Oexq0Bwdj0a
	 xsiE2xpH+5RZBEHvj/2sA6e3mscdI1f/hycsN8/XHHV5sSCPsskIPBzn32sx2fTxoa
	 pmtvluWFKwJvF0hpBQ/JVwbe3GEovCzElaynCIjRwzoAPUvRl1CGs8i2HctwoGrMWC
	 fyaoqJ1vByViR7oo8kMR9ARk+KWSxFvptvhRTRxh+6U9zCXq0ld43rhR8MpYAmi8Yf
	 mHMQK/loY87JrrFPMurtZFMOPVKGkgoOA7YcCKZaTRBZUSIkEVYynJTuy748S5F22R
	 asbPdTnDEeXGA==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9AFDD44DC8
	for <op-tee@lists.trustedfirmware.org>; Thu, 12 Nov 2026 09:56:47 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FViaeY/F;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794477407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USgqRYo1pzMpiu0iJQxs9uW5L1POEPPKTWq3pDYoKws=;
	b=FViaeY/FWssV5yp+9X2vMzy1rtF1g/9h3EO/ivuRiEwkvhKGc+GV6XpX3Pdt3adHvSOCft
	PR04p4+QUdfLgDwDRN0xBTyOeqgaVrVvZzt3zlb44fKTvjoXCmgYTE7g6wmFC+rJOal5Pz
	e/t2ksgFtsPnHlJNx6A3TfrIFAiYObk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-PRFuc9YBPlKL6HGQZxlTjg-1; Thu, 12 Nov 2026 04:56:45 -0500
X-MC-Unique: PRFuc9YBPlKL6HGQZxlTjg-1
X-Mimecast-MFC-AGG-ID: PRFuc9YBPlKL6HGQZxlTjg_1794477404
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-490ab0a20ebso3064682f8f.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 12 Nov 2026 01:56:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794477404; x=1795082204;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=USgqRYo1pzMpiu0iJQxs9uW5L1POEPPKTWq3pDYoKws=;
        b=D3uEIP+1tHihJwB1/hmVGm0RM3tgiuH/XKV38uc5dMQAqXUcpHPW4o4AGfLEC6RXxG
         396HTa5d+WfRfsCzdRhtem4W7Mngop9+Ql4gz3WbCCi84abkSxn0FNv8IzUqIfVGDJ5v
         NSptJV3nKqsPNK94GBHTGLEfrwboCGiHBqa13Ph0vfG841qlUdI65JNkcrJu47K6Ei8R
         op8cnnv/V6/Ufjj6XQFMLY5KSs2WjNNJMZnckvh655daf2Cv2l6xmmL0pCrq/z9d2/UB
         rQzMn2WUQgZJl59XoaotrSzZBca3bwR/HXIR2LIlRje3oTg2UW2lu7XBJjTNh5dbkj1H
         e1pw==
X-Forwarded-Encrypted: i=1; AL+hErGqVMTlEaSYLtnNhLF5xFZBLBk8Xiyu5XpGrcr8/4Q0Q2lNsGSMoJ2z36gaAWmhVH4G9WKpBOE=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z8taTTAJtKIpz/2OAoXqEa8WIM7hwuhhm1h3hTqxYabCCQL3mcT
	sAtpGw/5Caf7dD0xnF1+coCaO+G1mv0Si2buBkOhHYT58MTgcHVH6IIRr/vDB0YyzCr1SeSBSLU
	qsBFpVqPyQuhZovCmZiICV59jPAXR1GXcSU105rX90eubrGjir/98JSXXPuvveAXD5rpXmGo=
X-Gm-Gg: AYBFou2uCARpfJJ+G6swzb7gfLdabcZpIhgD2Uix8qh7BPZpIN75WwzKH8BOqY98e1i
	mauO6OhdEpej8T32FSZJgOWk7reIVbCx6gQ8mg8je6eBqEaEUSBHNTKReHddVgGi50RlzgBqihv
	fcwIZbEmeBuKgvVwUarRvpWPOOwoPwJ6BqIUNhcpA1y53tUqeGYq+Z7qgFTihM2gIocx3xdlQfm
	cVGFQ5Xv5szg1GWNA+NE7CGsinmus22GJKCY5YHUSuGd7kHeYMya576oXgEkV8WCBPYsx+AR7B7
	OnU3DAHA+pVz5GkUxC+NQK8qTWRABVHQqWbi5PNPNrHU+nvIfTUGSiiQXElejRZ6lvvwqiiJe0Y
	BKwVtHScgrhkX+mawWmbgWWC4wFZnAPzfgy6zo67W7M0=
X-Received: by 2002:a05:6000:4210:b0:48d:ff0d:cfa5 with SMTP id ffacd0b85a97d-499c8a7b6aamr8720956f8f.47.1794477404091;
        Thu, 12 Nov 2026 01:56:44 -0800 (PST)
X-Received: by 2002:a05:6000:4210:b0:48d:ff0d:cfa5 with SMTP id ffacd0b85a97d-499c8a7b6aamr8720905f8f.47.1794477403631;
        Thu, 12 Nov 2026 01:56:43 -0800 (PST)
Received: from localhost ([139.47.30.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498362eb158sm15464916f8f.36.2026.11.12.01.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 01:56:43 -0800 (PST)
Date: Thu, 12 Nov 2026 10:56:42 +0100
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [Linaro-mm-sig] [PATCH v4 2/8] dma-heap: charge dma-buf memory
 via explicit memcg
Message-ID: <avWNWnXCXm1sUYch@aesteve-thinkpadp1gen8.rmtes.csb>
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-2-1819a017000b@redhat.com>
 <3fdad4e17008cd59bc528ab22e34c0c913a6d50f.camel@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3fdad4e17008cd59bc528ab22e34c0c913a6d50f.camel@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _RAE20N2rfphskDy90P3lvZEyOS7jsZm_hAMPkAp6S0_1794477404
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.70 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[redhat.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:170.10.133.0/24];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	RCVD_IN_DNSWL_LOW(-0.10)[170.10.133.124:from];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[170.10.133.124:from];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org,lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:30031, ipnet:170.10.132.0/23, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.70:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9AFDD44DC8
X-Spamd-Bar: ----
Message-ID-Hash: P46VEMTGQD74EHNMXFARZBAH4C57VX5H
X-Message-ID-Hash: P46VEMTGQD74EHNMXFARZBAH4C57VX5H
X-MailFrom: aesteve@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>, Jens Wiklander
  <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/P46VEMTGQD74EHNMXFARZBAH4C57VX5H/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Albert Esteve via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Albert Esteve <aesteve@redhat.com>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 08:42:18AM +0100, Thomas Hellstr=F6m wrote:
> On Wed, 2026-11-04 at 12:09 +0100, Albert Esteve wrote:
> > On embedded platforms a central process often allocates dma-buf
> > memory on behalf of client applications. Without a way to
> > attribute the charge to the requesting client's cgroup, the
> > cost lands on the allocator, making per-cgroup memory limits
> > ineffective for the actual consumers.
> >=20
> > Add charge_fd to struct dma_heap_allocation_data. When set to
> > a valid pidfd or cgroupfd, DMA_HEAP_IOCTL_ALLOC resolves the target
> > task's or cgroup's memcg and charges the buffer there via
> > mem_cgroup_reserve_dmabuf() inside dma_heap_ioctl_allocate(). The
> > resolved memcg is passed through dma_buf_export_info so that
> > dma_buf_export() stores it and updates the MEMCG_DMABUF stat.
> > Without charge_fd, and with the mem_accounting module parameter
> > enabled, the buffer is charged to the allocator's own cgroup.
> > The __GPF_ACCOUNT flag is removed from system heap allocations
> > to avoid double counting.
> >=20
> > Usage examples:
> >=20
> > =A0 1. Central allocator charging to a client at allocation time.
> > =A0=A0=A0=A0 The allocator knows the client's PID (e.g., from binder's
> > =A0=A0=A0=A0 sender_pid) and uses pidfd to attribute the charge:
> >=20
> > =A0=A0=A0=A0=A0=A0 pid_t client_pid =3D txn->sender_pid;
> > =A0=A0=A0=A0=A0=A0 int pidfd =3D pidfd_open(client_pid, 0);
> >=20
> > =A0=A0=A0=A0=A0=A0 struct dma_heap_allocation_data alloc =3D {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .len=A0=A0=A0=A0=A0=A0=A0=A0 =3D buffer_=
size,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fd_flags=A0=A0=A0 =3D O_RDWR | O_CLOEXE=
C,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .charge_fd=A0=A0 =3D pidfd,
> > =A0=A0=A0=A0=A0=A0 };
> > =A0=A0=A0=A0=A0=A0 ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> > =A0=A0=A0=A0=A0=A0 close(pidfd);
> > =A0=A0=A0=A0=A0=A0 /* alloc.fd is now charged to client's cgroup */
> >=20
> > =A0 2. Default allocation (no pidfd, mem_accounting=3D1).
> > =A0=A0=A0=A0 When charge_fd is not set and the mem_accounting module
> > =A0=A0=A0=A0 parameter is enabled, the buffer is charged to the allocat=
or's
> > =A0=A0=A0=A0 own cgroup:
> >=20
> > =A0=A0=A0=A0=A0=A0 struct dma_heap_allocation_data alloc =3D {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .len=A0=A0=A0=A0=A0 =3D buffer_size,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fd_flags =3D O_RDWR | O_CLOEXEC,
> > =A0=A0=A0=A0=A0=A0 };
> > =A0=A0=A0=A0=A0=A0 ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> > =A0=A0=A0=A0=A0=A0 /* charged to current process's cgroup */
> >=20
> > Current limitations:
> >=20
> > =A0- Single-owner model: a dma-buf carries one memcg charge regardless
> > of
> > =A0=A0 how many processes share it. Means only the first owner (and
> > exporter)
> > =A0=A0 of the shared buffer bears the charge.
> > =A0- Only memcg accounting supported. While this makes sense for system
> > =A0=A0 heap buffers, other heaps (e.g., CMA heaps) will require
> > selectively
> > =A0=A0 charging also for the dmem controller.
> >=20
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> > =A0Documentation/admin-guide/cgroup-v2.rst |=A0 5 ++--
> > =A0drivers/dma-buf/dma-buf.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
|=A0 5 ++++
> > =A0drivers/dma-buf/dma-heap.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | =
28 +++++++++++++++++---
> > =A0drivers/dma-buf/heaps/cma_heap.c=A0=A0=A0=A0=A0=A0=A0 |=A0 3 ++-
> > =A0drivers/dma-buf/heaps/system_heap.c=A0=A0=A0=A0 | 21 +++++++++++----
> > =A0drivers/tee/tee_heap.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0 3 ++-
> > =A0include/linux/dma-buf.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0 4 +++
> > =A0include/linux/dma-heap.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0 3 ++-
> > =A0include/linux/memcontrol.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
=A0 7 +++++
> > =A0include/uapi/linux/dma-heap.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 7 +=
++++
> > =A0mm/memcontrol.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 | 47
> > +++++++++++++++++++++++++++++++++
> > =A011 files changed, 120 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst
> > b/Documentation/admin-guide/cgroup-v2.rst
> > index a3265a4a953e..66ddba678784 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1663,8 +1663,9 @@ The following nested keys are defined.
> > =A0		structures.
> > =A0
> > =A0	=A0 dmabuf (npn)
> > -		Amount of memory used for exported DMA buffers
> > allocated by the cgroup.
> > -		Stays with the allocating cgroup regardless of how
> > the buffer is shared.
> > +		Amount of memory used for exported DMA buffers
> > allocated by or on
> > +		behalf of the cgroup. Stays with the allocating
> > cgroup regardless
> > +		of how the buffer is shared.
>=20
> This doesn't sound right. Graphics buffers exported as DMA buffers are
> typically charged elsewhere, like gpu_active, and a transfer of their
> charge would likely stay in that key? To be consistent, shouldn't this
> be related to dma-heap memory and called dmaheap or something similar.

Although this work initially targeted dma heaps only, in its current
form is meant to stay generic (while solving the central allocator
problem). The memory exported as dma-bufs has no memory.stat of its
own, and an exporter allocating plain pages (e.g., V4L2) has nowhere
else to report it.

> We should have a tighter definition of exactly what memory is to be
> registered here.

Yes, I will be more specific and clearly state that an exporter
whose memory is already accounted must not opt in. That also
naturally disallows transfers.

>=20
> Also says "Stays with the allocating cgroup regardless of how the
> buffer is shared", which isn't correct after the series? Perhaps that's
> changed in a later patch.

I missed updating the text after having added XFER_CHARGE to the
series. I'll fix the wording in this patch and mention the transfer
in the next one.

BR,
Albert

>=20
> Thanks,
> Thomas
>=20
>=20
>=20
>=20
> > =A0
> > =A0	=A0 workingset_refault_anon
> > =A0		Number of refaults of previously evicted anonymous
> > pages.
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 1c6b9cee7ac2..837666273550 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -714,6 +714,7 @@ struct dma_buf *dma_buf_export(const struct
> > dma_buf_export_info *exp_info)
> > =A0	struct dma_resv *resv =3D exp_info->resv;
> > =A0	struct file *file;
> > =A0	size_t alloc_size =3D sizeof(struct dma_buf);
> > +	unsigned int nr_pages =3D PAGE_ALIGN(exp_info->size) >>
> > PAGE_SHIFT;
> > =A0	int ret;
> > =A0
> > =A0	if (WARN_ON(!exp_info->priv || !exp_info->ops
> > @@ -750,6 +751,7 @@ struct dma_buf *dma_buf_export(const struct
> > dma_buf_export_info *exp_info)
> > =A0	dmabuf->size =3D exp_info->size;
> > =A0	dmabuf->exp_name =3D exp_info->exp_name;
> > =A0	dmabuf->owner =3D exp_info->owner;
> > +	dmabuf->memcg =3D exp_info->memcg;
> > =A0	spin_lock_init(&dmabuf->name_lock);
> > =A0	init_waitqueue_head(&dmabuf->poll);
> > =A0	dmabuf->cb_in.poll =3D dmabuf->cb_out.poll =3D &dmabuf->poll;
> > @@ -771,6 +773,9 @@ struct dma_buf *dma_buf_export(const struct
> > dma_buf_export_info *exp_info)
> > =A0
> > =A0	DMA_BUF_TRACE(trace_dma_buf_export, dmabuf);
> > =A0
> > +	if (dmabuf->memcg)
> > +		mod_memcg_state(dmabuf->memcg, MEMCG_DMABUF,
> > nr_pages);
> > +
> > =A0	return dmabuf;
> > =A0
> > =A0err_file:
> > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > index 8a6c2b6e0cc6..7bd416ae2c23 100644
> > --- a/drivers/dma-buf/dma-heap.c
> > +++ b/drivers/dma-buf/dma-heap.c
> > @@ -10,6 +10,8 @@
> > =A0#include <linux/device.h>
> > =A0#include <linux/dma-buf.h>
> > =A0#include <linux/dma-heap.h>
> > +#include <linux/memcontrol.h>
> > +#include <linux/sched/mm.h>
> > =A0#include <linux/err.h>
> > =A0#include <linux/export.h>
> > =A0#include <linux/list.h>
> > @@ -78,6 +80,7 @@ static struct dma_buf
> > *dma_heap_ioctl_allocate(struct file *file, void *data)
> > =A0	struct dma_heap_allocation_data *heap_allocation =3D data;
> > =A0	struct dma_heap *heap =3D file->private_data;
> > =A0	struct dma_buf *dmabuf;
> > +	struct mem_cgroup *memcg =3D NULL;
> > =A0	int fd;
> > =A0	size_t len;
> > =A0
> > @@ -90,15 +93,34 @@ static struct dma_buf
> > *dma_heap_ioctl_allocate(struct file *file, void *data)
> > =A0	if (heap_allocation->heap_flags &
> > ~DMA_HEAP_VALID_HEAP_FLAGS)
> > =A0		return ERR_PTR(-EINVAL);
> > =A0
> > +	if (heap_allocation->__padding !=3D 0)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (heap_allocation->charge_fd) {
> > +		memcg =3D mem_cgroup_get_from_fd(heap_allocation-
> > >charge_fd);
> > +		if (IS_ERR(memcg))
> > +			return ERR_CAST(memcg);
> > +	}
> > +
> > +	if (!memcg && mem_accounting)
> > +		memcg =3D get_mem_cgroup_from_mm(current->mm);
> > +
> > =A0	len =3D PAGE_ALIGN(heap_allocation->len);
> > -	if (!len)
> > +	if (!len) {
> > +		mem_cgroup_put(memcg);
> > =A0		return ERR_PTR(-EINVAL);
> > +	}
> > =A0
> > =A0	dmabuf =3D heap->ops->allocate(heap, len, heap_allocation-
> > >fd_flags,
> > -				=A0=A0=A0=A0 heap_allocation->heap_flags);
> > +				=A0=A0=A0=A0 heap_allocation->heap_flags,
> > memcg);
> > =A0
> > -	if (IS_ERR(dmabuf))
> > +	if (IS_ERR(dmabuf)) {
> > +		mem_cgroup_put(memcg);
> > =A0		return dmabuf;
> > +	}
> > +
> > +	if (memcg && !dmabuf->memcg)
> > +		mem_cgroup_put(memcg);
> > =A0
> > =A0	fd =3D get_unused_fd_flags(heap_allocation->fd_flags);
> > =A0	if (fd < 0) {
> > diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-
> > buf/heaps/cma_heap.c
> > index 3fb4b946c91a..04de88b468a8 100644
> > --- a/drivers/dma-buf/heaps/cma_heap.c
> > +++ b/drivers/dma-buf/heaps/cma_heap.c
> > @@ -281,7 +281,8 @@ static const struct dma_buf_ops cma_heap_buf_ops
> > =3D {
> > =A0static struct dma_buf *cma_heap_allocate(struct dma_heap *heap,
> > =A0					 unsigned long len,
> > =A0					 u32 fd_flags,
> > -					 u64 heap_flags)
> > +					 u64 heap_flags,
> > +					 struct mem_cgroup *memcg)
> > =A0{
> > =A0	struct cma_heap *cma_heap =3D dma_heap_get_drvdata(heap);
> > =A0	struct cma_heap_buffer *buffer;
> > diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-
> > buf/heaps/system_heap.c
> > index c8959eadc71d..2bd245e1eab8 100644
> > --- a/drivers/dma-buf/heaps/system_heap.c
> > +++ b/drivers/dma-buf/heaps/system_heap.c
> > @@ -17,6 +17,7 @@
> > =A0#include <linux/err.h>
> > =A0#include <linux/highmem.h>
> > =A0#include <linux/mem_encrypt.h>
> > +#include <linux/memcontrol.h>
> > =A0#include <linux/mm.h>
> > =A0#include <linux/set_memory.h>
> > =A0#include <linux/module.h>
> > @@ -388,8 +389,6 @@ static struct page
> > *alloc_largest_available(unsigned long size,
> > =A0		if (max_order < orders[i])
> > =A0			continue;
> > =A0		flags =3D order_flags[i];
> > -		if (mem_accounting)
> > -			flags |=3D __GFP_ACCOUNT;
> > =A0		page =3D alloc_pages(flags, orders[i]);
> > =A0		if (!page)
> > =A0			continue;
> > @@ -401,11 +400,13 @@ static struct page
> > *alloc_largest_available(unsigned long size,
> > =A0static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
> > =A0					=A0=A0=A0 unsigned long len,
> > =A0					=A0=A0=A0 u32 fd_flags,
> > -					=A0=A0=A0 u64 heap_flags)
> > +					=A0=A0=A0 u64 heap_flags,
> > +					=A0=A0=A0 struct mem_cgroup
> > *memcg)
> > =A0{
> > =A0	struct system_heap_buffer *buffer;
> > =A0	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> > =A0	unsigned long size_remaining =3D len;
> > +	unsigned int nr_pages =3D PAGE_ALIGN(len) >> PAGE_SHIFT;
> > =A0	unsigned int max_order =3D orders[0];
> > =A0	struct system_heap_priv *priv =3D dma_heap_get_drvdata(heap);
> > =A0	bool cc_shared =3D priv->cc_shared;
> > @@ -416,10 +417,15 @@ static struct dma_buf
> > *system_heap_allocate(struct dma_heap *heap,
> > =A0	struct page *page, *tmp_page;
> > =A0	int i, ret =3D -ENOMEM;
> > =A0
> > -	buffer =3D kzalloc_obj(*buffer);
> > -	if (!buffer)
> > +	if (!mem_cgroup_reserve_dmabuf(memcg, GFP_KERNEL, nr_pages))
> > =A0		return ERR_PTR(-ENOMEM);
> > =A0
> > +	buffer =3D kzalloc_obj(*buffer);
> > +	if (!buffer) {
> > +		ret =3D -ENOMEM;
> > +		goto cancel_charge;
> > +	}
> > +
> > =A0	INIT_LIST_HEAD(&buffer->attachments);
> > =A0	mutex_init(&buffer->lock);
> > =A0	buffer->heap =3D heap;
> > @@ -473,11 +479,14 @@ static struct dma_buf
> > *system_heap_allocate(struct dma_heap *heap,
> > =A0	exp_info.size =3D buffer->len;
> > =A0	exp_info.flags =3D fd_flags;
> > =A0	exp_info.priv =3D buffer;
> > +	if (memcg)
> > +		exp_info.memcg =3D memcg;
> > =A0	dmabuf =3D dma_buf_export(&exp_info);
> > =A0	if (IS_ERR(dmabuf)) {
> > =A0		ret =3D PTR_ERR(dmabuf);
> > =A0		goto free_pages;
> > =A0	}
> > +
> > =A0	return dmabuf;
> > =A0
> > =A0free_pages:
> > @@ -498,6 +507,8 @@ static struct dma_buf
> > *system_heap_allocate(struct dma_heap *heap,
> > =A0	list_for_each_entry_safe(page, tmp_page, &pages, lru)
> > =A0		__free_pages(page, compound_order(page));
> > =A0	kfree(buffer);
> > +cancel_charge:
> > +	mem_cgroup_cancel_dmabuf(memcg, nr_pages);
> > =A0
> > =A0	return ERR_PTR(ret);
> > =A0}
> > diff --git a/drivers/tee/tee_heap.c b/drivers/tee/tee_heap.c
> > index 007c00156520..83e2fbd6960b 100644
> > --- a/drivers/tee/tee_heap.c
> > +++ b/drivers/tee/tee_heap.c
> > @@ -167,7 +167,8 @@ static const struct dma_buf_ops tee_heap_buf_ops
> > =3D {
> > =A0
> > =A0static struct dma_buf *tee_dma_heap_alloc(struct dma_heap *heap,
> > =A0					=A0 unsigned long len, u32
> > fd_flags,
> > -					=A0 u64 heap_flags)
> > +					=A0 u64 heap_flags,
> > +					=A0 struct mem_cgroup *memcg)
> > =A0{
> > =A0	struct tee_dma_heap *h =3D dma_heap_get_drvdata(heap);
> > =A0	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index 23ec0ff23fba..85dd747c9b36 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -505,6 +505,9 @@ struct dma_buf_attachment {
> > =A0 * @flags:	mode flags for the file
> > =A0 * @resv:	reservation-object, NULL to allocate default one
> > =A0 * @priv:	Attach private data of allocator to this buffer
> > + * @memcg:	memcg to charge for this buffer's memory. Set only
> > for
> > + *		buffers backed by system memory where @size reflects
> > the
> > + *		actual allocation in bytes.
> > =A0 *
> > =A0 * This structure holds the information required to export the
> > buffer. Used
> > =A0 * with dma_buf_export() only.
> > @@ -517,6 +520,7 @@ struct dma_buf_export_info {
> > =A0	int flags;
> > =A0	struct dma_resv *resv;
> > =A0	void *priv;
> > +	struct mem_cgroup *memcg;
> > =A0};
> > =A0
> > =A0/**
> > diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
> > index 648328a64b27..2d69f8432bd2 100644
> > --- a/include/linux/dma-heap.h
> > +++ b/include/linux/dma-heap.h
> > @@ -23,7 +23,8 @@ struct dma_heap_ops {
> > =A0	struct dma_buf *(*allocate)(struct dma_heap *heap,
> > =A0				=A0=A0=A0 unsigned long len,
> > =A0				=A0=A0=A0 u32 fd_flags,
> > -				=A0=A0=A0 u64 heap_flags);
> > +				=A0=A0=A0 u64 heap_flags,
> > +				=A0=A0=A0 struct mem_cgroup *memcg);
> > =A0};
> > =A0
> > =A0/**
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 4d1e82cf0833..f8ec751b7d7b 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -671,6 +671,8 @@ int mem_cgroup_charge_hugetlb(struct folio*
> > folio, gfp_t gfp);
> > =A0int mem_cgroup_swapin_charge_folio(struct folio *folio, unsigned
> > short id,
> > =A0				=A0=A0 struct mm_struct *mm, gfp_t gfp);
> > =A0
> > +struct mem_cgroup *mem_cgroup_get_from_fd(int fd);
> > +
> > =A0bool mem_cgroup_reserve_dmabuf(struct mem_cgroup *memcg, gfp_t gfp,
> > =A0			=A0=A0=A0=A0=A0=A0 unsigned int nr_pages);
> > =A0
> > @@ -1178,6 +1180,11 @@ static inline int
> > mem_cgroup_swapin_charge_folio(struct folio *folio,
> > =A0	return 0;
> > =A0}
> > =A0
> > +static inline struct mem_cgroup *mem_cgroup_get_from_fd(int fd)
> > +{
> > +	return ERR_PTR(-EOPNOTSUPP);
> > +}
> > +
> > =A0static inline bool mem_cgroup_reserve_dmabuf(struct mem_cgroup
> > *memcg,
> > =A0					=A0=A0=A0=A0 gfp_t gfp,
> > =A0					=A0=A0=A0=A0 unsigned int nr_pages)
> > diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-
> > heap.h
> > index a4cf716a49fa..bfcd1c25bc7e 100644
> > --- a/include/uapi/linux/dma-heap.h
> > +++ b/include/uapi/linux/dma-heap.h
> > @@ -29,6 +29,11 @@
> > =A0 *			handle to the allocated dma-buf
> > =A0 * @fd_flags:		file descriptor flags used when allocating
> > =A0 * @heap_flags:		flags passed to heap
> > + * @charge_fd:		optional pidfd or cgroupfd whose cgroup
> > should be
> > + *			charged for this allocation; 0 means charge
> > the calling
> > + *			process's cgroup when the mem_accounting
> > module parameter
> > + *			is enabled, or skip charging otherwise
> > + * @__padding:		reserved, must be zero
> > =A0 *
> > =A0 * Provided by userspace as an argument to the ioctl
> > =A0 */
> > @@ -37,6 +42,8 @@ struct dma_heap_allocation_data {
> > =A0	__u32 fd;
> > =A0	__u32 fd_flags;
> > =A0	__u64 heap_flags;
> > +	__u32 charge_fd;
> > +	__u32 __padding;
> > =A0};
> > =A0
> > =A0#define DMA_HEAP_IOC_MAGIC		'H'
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index e53dd7eebc3b..17fdefc56b97 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5661,6 +5661,53 @@ void mem_cgroup_flush_workqueue(void)
> > =A0	flush_workqueue(memcg_wq);
> > =A0}
> > =A0
> > +/**
> > + * mem_cgroup_get_from_fd - resolve a memcg from a cgroupfd or pidfd
> > + * @fd: file descriptor (cgroupfd or pidfd)
> > + *
> > + * Tries @fd as a cgroupfd first; if that fails, tries it as a
> > pidfd.
> > + * On success returns a referenced memcg pointer. On failure returns
> > + * an ERR_PTR.
> > + */
> > +struct mem_cgroup *mem_cgroup_get_from_fd(int fd)
> > +{
> > +	struct cgroup_subsys_state *css;
> > +	struct mem_cgroup *memcg;
> > +	struct cgroup *cgrp;
> > +	struct task_struct *task;
> > +	struct mm_struct *mm;
> > +	unsigned int pidfd_flags;
> > +
> > +	cgrp =3D cgroup_get_from_fd(fd);
> > +	if (!IS_ERR(cgrp)) {
> > +		rcu_read_lock();
> > +		css =3D cgroup_css(cgrp, &memory_cgrp_subsys);
> > +		if (!css || !css_tryget_online(css)) {
> > +			rcu_read_unlock();
> > +			cgroup_put(cgrp);
> > +			return ERR_PTR(-ENOENT);
> > +		}
> > +
> > +		memcg =3D mem_cgroup_from_css(css);
> > +		rcu_read_unlock();
> > +		cgroup_put(cgrp);
> > +		return memcg;
> > +	}
> > +
> > +	task =3D pidfd_get_task(fd, &pidfd_flags);
> > +	if (IS_ERR(task))
> > +		return ERR_CAST(task);
> > +
> > +	mm =3D get_task_mm(task);
> > +	put_task_struct(task);
> > +	if (!mm)
> > +		return ERR_PTR(-ESRCH);
> > +
> > +	memcg =3D get_mem_cgroup_from_mm(mm);
> > +	mmput(mm);
> > +	return memcg ?: ERR_PTR(-ENOENT);
> > +}
> > +
> > =A0/**
> > =A0 * mem_cgroup_reserve_dmabuf - charge a memcg for a dma-buf
> > allocation
> > =A0 * @memcg: memcg to charge (may be %NULL)

