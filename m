Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B980E606A89E
	for <op-tee@archiver.kernel.org>; Tue, 17 Nov 2026 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=sxudXE/n;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CGXjMRJ5
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 162C7454FC
	for <op-tee@archiver.kernel.org>; Tue, 17 Nov 2026 08:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794904849;
	bh=/FTBu3VeGFZ/GL8VA4Y+q7eGQysJ2fGG5ZHZQLuY62k=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=sxudXE/nhWA5DiL/5CxmRauNFeVUqEH1j+GrRMAAVqBoc8PAnH4dzkxMFA1pzsDXE
	 B340wgfIqTDVHL2v306S2pfuGnxNbMc2/aLSYFUml6RT7u1veJZMC6yqaFb2MAjkZz
	 NIj86dgPxCKZNRUvoJytt9ABbjPi6t211SLBo863gmty5fpiVWknvnBWQXsNvufvCX
	 xIfcnSZ2Kert+zRHwK35mYirxB3RSNMYjoqG6AfrAbfmwt6efr7erEcdo7lTEeB9ic
	 KTMSuoX8jGHBNzUKQvU2rNQbTQ+1Em79S3M0zA/nFwaw4SEmqyFOVblwywNPGL+5Nk
	 UEfIHFEG7IFTw==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DE9D6454C9
	for <op-tee@lists.trustedfirmware.org>; Tue, 17 Nov 2026 08:39:59 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CGXjMRJ5;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794904799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sh1ahDjYuAFYnx7fwIWsePESngyiAQOY9R5kRpnXVBk=;
	b=CGXjMRJ5Kywdhv9SU3Z27jldo9QXhWscKC5spB3QqvzZ6Z5ERYrK7qzlmVzOxv6bLo9taN
	nFCzs+7z1Ql5CB/l6HDrnGWYZ6JX17viYPmrZNQlkI4cEa7atPD3xlMlbiUy4HlkCtwRhk
	83tUs4aDiBIL1tWPFb1bQYkKQ/m+200=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-2WgYNuWtN7aXzt1Wb7jnOg-1; Tue,
 17 Nov 2026 03:39:55 -0500
X-MC-Unique: 2WgYNuWtN7aXzt1Wb7jnOg-1
X-Mimecast-MFC-AGG-ID: 2WgYNuWtN7aXzt1Wb7jnOg_1794904791
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81CC319560B1;
	Tue, 17 Nov 2026 08:39:50 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0B7C1956047;
	Tue, 17 Nov 2026 08:39:41 +0000 (UTC)
Date: Tue, 17 Nov 2026 09:39:17 +0100
Subject: [PATCH v5 2/8] dma-heap: charge dma-buf memory via explicit memcg
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261117-v2_20230123_tjmercier_google_com-v5-2-1ce975f2a9ad@redhat.com>
References: <20261117-v2_20230123_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com>
In-Reply-To: <20261117-v2_20230123_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
 Philipp Stanner <phasta@kernel.org>,
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794904759; l=16461;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=/FTBu3VeGFZ/GL8VA4Y+q7eGQysJ2fGG5ZHZQLuY62k=;
 b=LJSLzDMhKtfWvvHCtoRUvRrx6LwRKwus9jeTaCwY6sWxEQ/8hptiMWPiaB9eUeD9hz9j7N6Kc
 q7uuVoXTu83AJiiAWauQ9G8iUVSoqvGg6aa9gghDx9RkI4a9QLEhLgE
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 4QURdjFS1Y5Y7C6NoADA7hGDse2g2cdWKwLuPEFqXW0_1794904791
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[redhat.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:170.10.133.0/24];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	RWL_MAILSPIKE_GOOD(-0.10)[170.10.133.124:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:30031, ipnet:170.10.132.0/23, country:US];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org,lists.trustedfirmware.org,redhat.com,kernel.org];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[170.10.133.124:from];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DE9D6454C9
X-Spamd-Bar: ----
Message-ID-Hash: AMDIT7JP2MAXTOCVEY4HB7HJXMDNPUDR
X-Message-ID-Hash: AMDIT7JP2MAXTOCVEY4HB7HJXMDNPUDR
X-MailFrom: aesteve@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: airlied@gmail.com, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, Albert Esteve <aesteve@redhat.com>, echanude@redhat.com, mripard@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AMDIT7JP2MAXTOCVEY4HB7HJXMDNPUDR/>
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

On embedded platforms a central process often allocates dma-buf
memory on behalf of client applications. Without a way to
attribute the charge to the requesting client's cgroup, the
cost lands on the allocator, making per-cgroup memory limits
ineffective for the actual consumers.

Add charge_fd to struct dma_heap_allocation_data. When set to
a valid pidfd or cgroupfd, DMA_HEAP_IOCTL_ALLOC resolves the target
task's or cgroup's memcg and charges the buffer there via
obj_cgroup_reserve_dmabuf() inside heap's allocate() callback.
In the system heap, the object cgroup is passed through
dma_buf_export_info so that dma_buf_export() stores it and updates
the MEMCG_DMABUF stat. Without charge_fd, and with the mem_accounting
module parameter enabled, the buffer is charged to the allocator's own
cgroup. The __GFP_ACCOUNT flag is removed from system heap allocations
to avoid double counting. CMA and TEE heaps accept the objcg in the
callback but ignore it.

Resolving a charge target outside the caller's own memcg subtree
requires CAP_SYS_RESOURCE. Without it, any process could charge the
root cgroup to escape its own limits, or push reclaim and OOM onto
unrelated cgroups. Charging within the caller's subtree cannot escape
limits, since descendant usage counts toward the ancestor, and needs
no privilege.

Usage examples:

  1. Central allocator charging to a client at allocation time.
     The allocator knows the client's PID (e.g., from binder's
     sender_pid) and uses pidfd to attribute the charge:

       pid_t client_pid = txn->sender_pid;
       int pidfd = pidfd_open(client_pid, 0);

       struct dma_heap_allocation_data alloc = {
           .len         = buffer_size,
           .fd_flags    = O_RDWR | O_CLOEXEC,
           .charge_fd   = pidfd,
       };
       ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
       close(pidfd);
       /* alloc.fd is now charged to client's cgroup */

  2. Default allocation (no pidfd, mem_accounting=1).
     When charge_fd is not set and the mem_accounting module
     parameter is enabled, the buffer is charged to the allocator's
     own cgroup:

       struct dma_heap_allocation_data alloc = {
           .len      = buffer_size,
           .fd_flags = O_RDWR | O_CLOEXEC,
       };
       ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
       /* charged to current process's cgroup */

Current limitations:

 - Single-owner model: a dma-buf carries one memcg charge regardless of
   how many processes share it. Means only the first owner (and exporter)
   of the shared buffer bears the charge.
 - Only memcg accounting supported. While this makes sense for system
   heap buffers, other heaps (e.g., CMA heaps) will require selectively
   charging also for the dmem controller.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  6 ++-
 drivers/dma-buf/dma-buf.c               |  3 ++
 drivers/dma-buf/dma-heap.c              | 27 +++++++++--
 drivers/dma-buf/heaps/cma_heap.c        |  3 +-
 drivers/dma-buf/heaps/system_heap.c     | 19 ++++++--
 drivers/tee/tee_heap.c                  |  3 +-
 include/linux/dma-buf.h                 |  5 ++
 include/linux/dma-heap.h                |  4 +-
 include/linux/memcontrol.h              | 11 +++++
 include/uapi/linux/dma-heap.h           |  7 +++
 mm/memcontrol.c                         | 83 +++++++++++++++++++++++++++++++++
 11 files changed, 158 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index f1f6808c5600..c6bf2e435d74 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1667,8 +1667,10 @@ The following nested keys are defined.
 		structures.
 
 	  dmabuf (npn)
-		Amount of memory used for exported DMA buffers allocated by the cgroup.
-		Stays with the allocating cgroup regardless of how the buffer is shared.
+		Amount of memory used for exported DMA buffers allocated by or on
+		behalf of the cgroup, this currently includes system heap
+		allocations. Stays with the cgroup regardless of how the buffer
+		is shared.
 
 	  workingset_refault_anon
 		Number of refaults of previously evicted anonymous pages.
diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 06462faf762e..88e0802fa05f 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -750,6 +750,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 	dmabuf->size = exp_info->size;
 	dmabuf->exp_name = exp_info->exp_name;
 	dmabuf->owner = exp_info->owner;
+	dmabuf->objcg = exp_info->objcg;
 	spin_lock_init(&dmabuf->name_lock);
 	init_waitqueue_head(&dmabuf->poll);
 	dmabuf->cb_in.poll = dmabuf->cb_out.poll = &dmabuf->poll;
@@ -771,6 +772,8 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 
 	DMA_BUF_TRACE(trace_dma_buf_export, dmabuf);
 
+	mem_cgroup_commit_dmabuf(dmabuf);
+
 	return dmabuf;
 
 err_file:
diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 8a6c2b6e0cc6..2f53bc95a45a 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -10,6 +10,7 @@
 #include <linux/device.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-heap.h>
+#include <linux/memcontrol.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/list.h>
@@ -78,6 +79,7 @@ static struct dma_buf *dma_heap_ioctl_allocate(struct file *file, void *data)
 	struct dma_heap_allocation_data *heap_allocation = data;
 	struct dma_heap *heap = file->private_data;
 	struct dma_buf *dmabuf;
+	struct obj_cgroup *objcg = NULL;
 	int fd;
 	size_t len;
 
@@ -90,15 +92,34 @@ static struct dma_buf *dma_heap_ioctl_allocate(struct file *file, void *data)
 	if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
 		return ERR_PTR(-EINVAL);
 
+	if (heap_allocation->__padding != 0)
+		return ERR_PTR(-EINVAL);
+
+	if (heap_allocation->charge_fd) {
+		objcg = get_obj_cgroup_from_fd(heap_allocation->charge_fd);
+		if (IS_ERR(objcg))
+			return ERR_CAST(objcg);
+	}
+
+	if (!objcg && mem_accounting && !mem_cgroup_disabled())
+		objcg = get_obj_cgroup_from_current();
+
 	len = PAGE_ALIGN(heap_allocation->len);
-	if (!len)
+	if (!len) {
+		obj_cgroup_put(objcg);
 		return ERR_PTR(-EINVAL);
+	}
 
 	dmabuf = heap->ops->allocate(heap, len, heap_allocation->fd_flags,
-				     heap_allocation->heap_flags);
+				     heap_allocation->heap_flags, objcg);
 
-	if (IS_ERR(dmabuf))
+	if (IS_ERR(dmabuf)) {
+		obj_cgroup_put(objcg);
 		return dmabuf;
+	}
+
+	if (!dmabuf->objcg)
+		obj_cgroup_put(objcg);
 
 	fd = get_unused_fd_flags(heap_allocation->fd_flags);
 	if (fd < 0) {
diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 3fb4b946c91a..6c08dc25b177 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -281,7 +281,8 @@ static const struct dma_buf_ops cma_heap_buf_ops = {
 static struct dma_buf *cma_heap_allocate(struct dma_heap *heap,
 					 unsigned long len,
 					 u32 fd_flags,
-					 u64 heap_flags)
+					 u64 heap_flags,
+					 struct obj_cgroup *objcg)
 {
 	struct cma_heap *cma_heap = dma_heap_get_drvdata(heap);
 	struct cma_heap_buffer *buffer;
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index c8959eadc71d..ad94bb5be736 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/highmem.h>
 #include <linux/mem_encrypt.h>
+#include <linux/memcontrol.h>
 #include <linux/mm.h>
 #include <linux/set_memory.h>
 #include <linux/module.h>
@@ -388,8 +389,6 @@ static struct page *alloc_largest_available(unsigned long size,
 		if (max_order < orders[i])
 			continue;
 		flags = order_flags[i];
-		if (mem_accounting)
-			flags |= __GFP_ACCOUNT;
 		page = alloc_pages(flags, orders[i]);
 		if (!page)
 			continue;
@@ -401,11 +400,13 @@ static struct page *alloc_largest_available(unsigned long size,
 static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 					    unsigned long len,
 					    u32 fd_flags,
-					    u64 heap_flags)
+					    u64 heap_flags,
+					    struct obj_cgroup *objcg)
 {
 	struct system_heap_buffer *buffer;
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	unsigned long size_remaining = len;
+	unsigned long nr_pages = PAGE_ALIGN(len) >> PAGE_SHIFT;
 	unsigned int max_order = orders[0];
 	struct system_heap_priv *priv = dma_heap_get_drvdata(heap);
 	bool cc_shared = priv->cc_shared;
@@ -416,10 +417,15 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 	struct page *page, *tmp_page;
 	int i, ret = -ENOMEM;
 
-	buffer = kzalloc_obj(*buffer);
-	if (!buffer)
+	if (!obj_cgroup_reserve_dmabuf(objcg, GFP_KERNEL, nr_pages))
 		return ERR_PTR(-ENOMEM);
 
+	buffer = kzalloc_obj(*buffer);
+	if (!buffer) {
+		ret = -ENOMEM;
+		goto cancel_charge;
+	}
+
 	INIT_LIST_HEAD(&buffer->attachments);
 	mutex_init(&buffer->lock);
 	buffer->heap = heap;
@@ -473,6 +479,7 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 	exp_info.size = buffer->len;
 	exp_info.flags = fd_flags;
 	exp_info.priv = buffer;
+	exp_info.objcg = objcg;
 	dmabuf = dma_buf_export(&exp_info);
 	if (IS_ERR(dmabuf)) {
 		ret = PTR_ERR(dmabuf);
@@ -498,6 +505,8 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 	list_for_each_entry_safe(page, tmp_page, &pages, lru)
 		__free_pages(page, compound_order(page));
 	kfree(buffer);
+cancel_charge:
+	obj_cgroup_cancel_dmabuf(objcg, nr_pages);
 
 	return ERR_PTR(ret);
 }
diff --git a/drivers/tee/tee_heap.c b/drivers/tee/tee_heap.c
index 007c00156520..83fd14a0aaec 100644
--- a/drivers/tee/tee_heap.c
+++ b/drivers/tee/tee_heap.c
@@ -167,7 +167,8 @@ static const struct dma_buf_ops tee_heap_buf_ops = {
 
 static struct dma_buf *tee_dma_heap_alloc(struct dma_heap *heap,
 					  unsigned long len, u32 fd_flags,
-					  u64 heap_flags)
+					  u64 heap_flags,
+					  struct obj_cgroup *objcg)
 {
 	struct tee_dma_heap *h = dma_heap_get_drvdata(heap);
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 2f56afd1f830..ff4678d00d8c 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -505,6 +505,10 @@ struct dma_buf_attachment {
  * @flags:	mode flags for the file
  * @resv:	reservation-object, NULL to allocate default one
  * @priv:	Attach private data of allocator to this buffer
+ * @objcg:	object cgroup to charge for this buffer's memory. Set only for
+ *		buffers backed by system memory, not accounted elsewhere, where
+ *		@size reflects the actual allocation in bytes. The buffer takes
+ *		over the caller's reference.
  *
  * This structure holds the information required to export the buffer. Used
  * with dma_buf_export() only.
@@ -517,6 +521,7 @@ struct dma_buf_export_info {
 	int flags;
 	struct dma_resv *resv;
 	void *priv;
+	struct obj_cgroup *objcg;
 };
 
 /**
diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
index 648328a64b27..b5a42b49c68d 100644
--- a/include/linux/dma-heap.h
+++ b/include/linux/dma-heap.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 
 struct dma_heap;
+struct obj_cgroup;
 
 /**
  * struct dma_heap_ops - ops to operate on a given heap
@@ -23,7 +24,8 @@ struct dma_heap_ops {
 	struct dma_buf *(*allocate)(struct dma_heap *heap,
 				    unsigned long len,
 				    u32 fd_flags,
-				    u64 heap_flags);
+				    u64 heap_flags,
+				    struct obj_cgroup *objcg);
 };
 
 /**
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 46fbb418bf39..8e016d9b91bc 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1812,6 +1812,7 @@ void __memcg_kmem_uncharge_page(struct page *page, int order);
  */
 struct obj_cgroup *current_obj_cgroup(void);
 struct obj_cgroup *get_obj_cgroup_from_folio(const struct folio *folio);
+struct obj_cgroup *get_obj_cgroup_from_fd(int fd);
 
 static inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 {
@@ -1919,6 +1920,16 @@ static inline struct obj_cgroup *get_obj_cgroup_from_folio(const struct folio *f
 	return NULL;
 }
 
+static inline struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline struct obj_cgroup *get_obj_cgroup_from_current(void)
+{
+	return NULL;
+}
+
 static inline bool memcg_bpf_enabled(void)
 {
 	return false;
diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-heap.h
index a4cf716a49fa..bfcd1c25bc7e 100644
--- a/include/uapi/linux/dma-heap.h
+++ b/include/uapi/linux/dma-heap.h
@@ -29,6 +29,11 @@
  *			handle to the allocated dma-buf
  * @fd_flags:		file descriptor flags used when allocating
  * @heap_flags:		flags passed to heap
+ * @charge_fd:		optional pidfd or cgroupfd whose cgroup should be
+ *			charged for this allocation; 0 means charge the calling
+ *			process's cgroup when the mem_accounting module parameter
+ *			is enabled, or skip charging otherwise
+ * @__padding:		reserved, must be zero
  *
  * Provided by userspace as an argument to the ioctl
  */
@@ -37,6 +42,8 @@ struct dma_heap_allocation_data {
 	__u32 fd;
 	__u32 fd_flags;
 	__u64 heap_flags;
+	__u32 charge_fd;
+	__u32 __padding;
 };
 
 #define DMA_HEAP_IOC_MAGIC		'H'
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 45e82cda7c44..adc0abcf80fa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -49,6 +49,7 @@
 #include <linux/slab.h>
 #include <linux/swapops.h>
 #include <linux/spinlock.h>
+#include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/seq_file.h>
 #include <linux/vmpressure.h>
@@ -3168,6 +3169,88 @@ struct obj_cgroup *get_obj_cgroup_from_folio(const struct folio *folio)
 	return objcg;
 }
 
+/*
+ * Charging outside the caller's own memcg subtree can escape its limits
+ * or push reclaim and OOM onto other cgroups.
+ */
+static bool mem_cgroup_may_charge(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *self = get_mem_cgroup_from_current();
+	bool ret = mem_cgroup_is_descendant(memcg, self);
+
+	mem_cgroup_put(self);
+	return ret || capable(CAP_SYS_RESOURCE);
+}
+
+/**
+ * get_obj_cgroup_from_fd - resolve an object cgroup from a cgroupfd or pidfd
+ * @fd: file descriptor (cgroupfd or pidfd)
+ *
+ * Tries @fd as a cgroupfd first; if that fails, tries it as a pidfd. Only
+ * cgroup2 directories are accepted as cgroupfds, any other fd is tried as a
+ * pidfd.
+ *
+ * Resolving a memcg outside the caller's own subtree requires CAP_SYS_RESOURCE.
+ *
+ * On success returns a referenced objcg pointer. On failure returns
+ * an ERR_PTR.
+ */
+struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
+{
+	struct cgroup_subsys_state *css;
+	struct obj_cgroup *objcg;
+	struct mem_cgroup *memcg;
+	struct task_struct *task;
+	unsigned int pidfd_flags;
+
+	if (mem_cgroup_disabled())
+		return ERR_PTR(-EOPNOTSUPP);
+
+	CLASS(fd_raw, f)(fd);
+	if (fd_empty(f))
+		return ERR_PTR(-EBADF);
+
+	css = css_tryget_online_from_dir(fd_file(f)->f_path.dentry,
+					 &memory_cgrp_subsys);
+	if (!IS_ERR(css) && !cgroup_on_dfl(css->cgroup)) {
+		css_put(css);
+		css = ERR_PTR(-EBADF);
+	}
+
+	if (IS_ERR(css)) {
+		if (PTR_ERR(css) != -EBADF)
+			return ERR_CAST(css);
+
+		/* fd is a pidfd */
+		task = pidfd_get_task(fd, &pidfd_flags);
+		if (IS_ERR(task))
+			return ERR_CAST(task);
+
+		rcu_read_lock();
+		css = task_css(task, memory_cgrp_id);
+		put_task_struct(task);
+		if (!css || !css_tryget_online(css)) {
+			rcu_read_unlock();
+			return ERR_PTR(-ENOENT);
+		}
+		rcu_read_unlock();
+	}
+
+	memcg = mem_cgroup_from_css(css);
+	if (!mem_cgroup_may_charge(memcg)) {
+		mem_cgroup_put(memcg);
+		return ERR_PTR(-EPERM);
+	}
+
+	objcg = get_obj_cgroup_from_memcg(memcg, numa_node_id());
+	mem_cgroup_put(memcg);
+
+	if (!objcg)
+		return ERR_PTR(-ENOENT);
+
+	return objcg;
+}
+
 #ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
 static inline void account_kmem_nmi_safe(struct mem_cgroup *memcg, int val)
 {

-- 
2.55.0

