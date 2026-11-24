Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553A9606A321
	for <op-tee@archiver.kernel.org>; Tue, 24 Nov 2026 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=rkjVkdn+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NDk9Wnyu
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AA0BA45523
	for <op-tee@archiver.kernel.org>; Tue, 24 Nov 2026 13:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795525671;
	bh=2KFqOC/8b5TkRv0jTVa2WTsP5g107sO1J9lQIz8yWlg=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=rkjVkdn+aFpagiyGP+e5uT3LIKbiSn5iWjqec0nCnQj/ELz8sj1Nz8qlQoMOvZqGM
	 uTgzaNPWh02vWe015TW3eYKveTq+VjAYiQTNYBBESQ/YchCK4p3P6sNtbsv8GIuCQq
	 AyQNdgM/ljIMblfhiwT+TKbqQ8uqHUXKljq5+91kHb9IPupy2Il5Vwe862Qcc5n1w4
	 c08JiLWCdW2Wpk5ldw8kdnG/1VbnSVhGKp5AdTz0q6QDDdjTzv1sZgtLJFXEC3V2td
	 RejKbZTob0zAdKosw2kwSRfmWvdIPdfjttNoqePZ0D7JpPyBUHExksdwVmQHjwo2zy
	 MZz0XLl7dY5BA==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 82A88454F1
	for <op-tee@lists.trustedfirmware.org>; Tue, 24 Nov 2026 13:05:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NDk9Wnyu;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795525509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4bNhI6hJeicsg11UGBGd019BKF3mBPUDTgoriuuVmE=;
	b=NDk9WnyunArhpPyrV/vrkXE4962nOe7capxjJ+CAtD5nM3rx3Fpj8tQgm5LYTGUlMUU+YB
	Hcg8u3eLQ54XTrOrpzxeC2YQ1ux7d8OMNSt7wSPW0Cmre2UeWxjgeMmljXfM6SIyEaBWVP
	BB0ZbDJ3jqT00dwhZemEENUt2nM2T5w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-1ahAHUQvPoShgiVV-Han3g-1; Tue,
 24 Nov 2026 13:05:05 +0000
X-MC-Unique: 1ahAHUQvPoShgiVV-Han3g-1
X-Mimecast-MFC-AGG-ID: 1ahAHUQvPoShgiVV-Han3g_1795525501
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2333D19560B9;
	Tue, 24 Nov 2026 13:05:01 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9784195B3C4;
	Tue, 24 Nov 2026 13:04:52 +0000 (UTC)
Date: Tue, 24 Nov 2026 14:03:41 +0100
Subject: [PATCH v6 7/7] selftests/dmabuf-heaps: Add dma-buf memcg
 accounting tests
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261124-v2_20230123_tjmercier_google_com-v6-7-dce12fa03ad6@redhat.com>
References: <20261124-v2_20230123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com>
In-Reply-To: <20261124-v2_20230123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795525424; l=29696;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=2KFqOC/8b5TkRv0jTVa2WTsP5g107sO1J9lQIz8yWlg=;
 b=uA+RAwmXTjk/hw41yEZJToGyDxZz7F5ml8I1NOvOQV4z7EyGG+ldQwanToXn9TGeormQQiLvm
 QyZ6yb1ZA2hA02W2aTxw4F0mOYJdiPM5GD7LpJhkhsUGExTaCoURX7M
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: ZeWPpLscLrZw8BVuOSDcp25EYDMEhEeICL2A4XMjnFM_1795525501
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	RWL_MAILSPIKE_EXCELLENT(-0.40)[170.10.129.124:from];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:170.10.129.0/24];
	RCVD_IN_DNSWL_LOW(-0.10)[170.10.129.124:from];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[54.186.198.63:received];
	ASN(0.00)[asn:30031, ipnet:170.10.128.0/23, country:US];
	DWL_DNSWL_BLOCKED(0.00)[redhat.com:dkim];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org,lists.trustedfirmware.org,redhat.com,kernel.org];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[43];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 82A88454F1
X-Spamd-Bar: --
Message-ID-Hash: TQCULWVTEJGJ6UUY27EM5MDCWF6N7CSL
X-Message-ID-Hash: TQCULWVTEJGJ6UUY27EM5MDCWF6N7CSL
X-MailFrom: aesteve@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: airlied@gmail.com, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, Albert Esteve <aesteve@redhat.com>, echanude@redhat.com, mripard@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TQCULWVTEJGJ6UUY27EM5MDCWF6N7CSL/>
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

Add tests for the new charge_fd field in struct
dma_heap_allocation_data.

When the charge_fd feature is absent (unpatched kernel),
the probe in pidfd_alloc_supported() detects this and the
tests are skipped gracefully.

Add vmtest.sh similar to other subsystem suites, to orchestrate
building the selftests (optionally with a freshly compiled kernel)
inside a virtme-ng VM, so the tests can be run without modifying
the host system. Add a config fragment with required Kconfig symbols.

Also extend test_memcontrol suite to cover cross-cgroup dma-buf
accounting:

- test_memcg_dmabuf: a buffer charged via pidfd is accounted to
  the target cgroup's memory.stat
- test_memcg_dmabuf_xfer_at_limit: transferring a charge to a cgroup
  at its memory.max limit fails with ENOMEM and leaves the charge in
  the source cgroup
- test_memcg_dmabuf_dead_cgroup: a cgroup removed while one of its
  charged buffers is still open and is released instead of lingering
  as a dying descendant, and the charge moves to the parent and is
  released when the buffer is closed.

All of them are skipped on unpatched kernels or when
/dev/dma_heap/system is absent.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 tools/testing/selftests/cgroup/Makefile            |   2 +-
 tools/testing/selftests/cgroup/test_memcontrol.c   | 447 ++++++++++++++++++++-
 tools/testing/selftests/dmabuf-heaps/config        |   1 +
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 237 ++++++++++-
 tools/testing/selftests/dmabuf-heaps/vmtest.sh     | 226 +++++++++++
 5 files changed, 909 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index e01584c2189a..9edfc9f1de5c 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -Wall -pthread
+CFLAGS += -Wall -pthread $(KHDR_INCLUDES)
 
 all: ${HELPER_PROGS}
 
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index bb673012dcf0..f612726bd9af 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -18,8 +18,15 @@
 #include <netdb.h>
 #include <errno.h>
 #include <sys/mman.h>
+#include <sys/prctl.h>
 #include <sys/sysinfo.h>
 
+#include <linux/dma-buf.h>
+#include <linux/dma-heap.h>
+#include <signal.h>
+#include <sys/ioctl.h>
+
+#include "../pidfd/pidfd.h"
 #include "kselftest.h"
 #include "cgroup_util.h"
 
@@ -27,6 +34,13 @@
 #define MEMCG_FLUSH_BYTES	\
 	(2 * sysconf(_SC_PAGESIZE) * MEMCG_CHARGE_BATCH * get_nprocs())
 
+#define DMA_HEAP_SYSTEM		"/dev/dma_heap/system"
+#define ONE_MEG			(1024 * 1024)
+
+#define MEMCG_SOCKSTAT_WAIT_RETRIES        30
+#define MEMCG_DMABUF_WAIT_RETRIES          30
+#define MEMCG_DMABUF_DEAD_WAIT_RETRIES     80
+
 static bool has_localevents;
 static bool has_recursiveprot;
 static int page_size;
@@ -1797,6 +1811,417 @@ static int test_memcg_inotify_delete_dir(const char *root)
 	return ret;
 }
 
+static int memcg_dmabuf_child(const char *cgroup, void *arg)
+{
+	pid_t *parent_pid = arg;
+
+	prctl(PR_SET_PDEATHSIG, SIGKILL);
+	if (getppid() != *parent_pid)
+		return 0;
+
+	pause();
+	return 0;
+}
+
+/*
+ * This test allocates a dma-buf via DMA_HEAP_IOCTL_ALLOC with a pidfd
+ * pointing to a child process in a separate cgroup, then checks that
+ * memory.stat[dmabuf] in the child's cgroup rises by the allocation size
+ * and returns to zero after the buffer fd is closed.
+ */
+static int test_memcg_dmabuf(const char *root)
+{
+	char *parent = NULL, *child_cg = NULL;
+	int ret = KSFT_FAIL;
+	int heap_fd = -1, dmabuf_fd = -1, pidfd = -1;
+	pid_t child_pid, parent_pid = getpid();
+	int child_status;
+	long dmabuf_stat;
+	struct dma_heap_allocation_data alloc = {
+		.len      = ONE_MEG,
+		.fd_flags = O_RDWR | O_CLOEXEC,
+	};
+
+	if (access(DMA_HEAP_SYSTEM, R_OK | W_OK)) {
+		ret = KSFT_SKIP;
+		goto cleanup;
+	}
+
+	parent = cg_name(root, "dmabuf_memcg_test");
+	if (!parent)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup_parent;
+
+	if (cg_write(parent, "cgroup.subtree_control", "+memory"))
+		goto cleanup_parent;
+
+	child_cg = cg_name(parent, "child");
+	if (!child_cg)
+		goto cleanup_parent;
+
+	if (cg_create(child_cg))
+		goto cleanup_parent;
+
+	child_pid = cg_run_nowait(child_cg, memcg_dmabuf_child, &parent_pid);
+	if (child_pid < 0)
+		goto cleanup_child;
+
+	if (cg_wait_for_proc_count(child_cg, 1))
+		goto cleanup_kill;
+
+	pidfd = sys_pidfd_open(child_pid, 0);
+	if (pidfd < 0) {
+		ret = KSFT_SKIP;
+		goto cleanup_kill;
+	}
+
+	heap_fd = open(DMA_HEAP_SYSTEM, O_RDWR);
+	if (heap_fd < 0) {
+		ret = KSFT_SKIP;
+		goto cleanup_pidfd;
+	}
+
+	alloc.charge_fd = (__u32)pidfd;
+	if (ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc) < 0) {
+		if (errno == EINVAL || errno == ENOTTY || errno == EOPNOTSUPP)
+			ret = KSFT_SKIP;
+		goto cleanup_heap;
+	}
+	dmabuf_fd = (int)alloc.fd;
+
+	dmabuf_stat = cg_read_key_long(child_cg, "memory.stat", "dmabuf ");
+	if (dmabuf_stat == -1) {
+		ret = KSFT_SKIP;
+		goto cleanup_dmabuf;
+	}
+	if (dmabuf_stat != ONE_MEG)
+		dmabuf_stat = cg_read_key_long_poll(child_cg, "memory.stat",
+						    "dmabuf ", ONE_MEG,
+						    MEMCG_DMABUF_WAIT_RETRIES,
+						    DEFAULT_WAIT_INTERVAL_US);
+	if (dmabuf_stat != ONE_MEG) {
+		fprintf(stderr, "Expected dmabuf stat %d, got %ld\n",
+			ONE_MEG, dmabuf_stat);
+		goto cleanup_dmabuf;
+	}
+
+	close(dmabuf_fd);
+	dmabuf_fd = -1;
+
+	dmabuf_stat = cg_read_key_long_poll(child_cg, "memory.stat",
+					    "dmabuf ", 0,
+					    MEMCG_DMABUF_WAIT_RETRIES,
+					    DEFAULT_WAIT_INTERVAL_US);
+	if (dmabuf_stat != 0) {
+		fprintf(stderr, "Expected dmabuf stat 0 after close, got %ld\n",
+			dmabuf_stat);
+		goto cleanup_heap;
+	}
+
+	ret = KSFT_PASS;
+
+cleanup_dmabuf:
+	if (dmabuf_fd >= 0)
+		close(dmabuf_fd);
+cleanup_heap:
+	close(heap_fd);
+cleanup_pidfd:
+	close(pidfd);
+cleanup_kill:
+	kill(child_pid, SIGTERM);
+	waitpid(child_pid, &child_status, 0);
+cleanup_child:
+	cg_destroy(child_cg);
+	free(child_cg);
+cleanup_parent:
+	cg_destroy(parent);
+	free(parent);
+cleanup:
+	return ret;
+}
+
+/*
+ * Allocate a dma-buf in cgroup A, set memory.max on cgroup B below the
+ * buffer size, then attempt DMA_BUF_IOCTL_XFER_CHARGE to B. The transfer
+ * must fail with ENOMEM and the charge must remain in A.
+ */
+static int test_memcg_dmabuf_xfer_at_limit(const char *root)
+{
+	char *parent = NULL, *cg_a = NULL, *cg_b = NULL;
+	int ret = KSFT_FAIL;
+	int heap_fd = -1, dmabuf_fd = -1, cg_b_fd = -1;
+	pid_t child_pid, parent_pid = getpid();
+	int child_status;
+	long stat_a;
+	struct dma_heap_allocation_data alloc = {
+		.len      = ONE_MEG,
+		.fd_flags = O_RDWR | O_CLOEXEC,
+	};
+	struct dma_buf_transfer_charge xfer = { 0 };
+
+	if (access(DMA_HEAP_SYSTEM, R_OK | W_OK)) {
+		ret = KSFT_SKIP;
+		goto cleanup;
+	}
+
+	parent = cg_name(root, "dmabuf_xfer_limit_test");
+	if (!parent)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup_parent;
+
+	if (cg_write(parent, "cgroup.subtree_control", "+memory"))
+		goto cleanup_parent;
+
+	cg_a = cg_name(parent, "cg_a");
+	cg_b = cg_name(parent, "cg_b");
+	if (!cg_a || !cg_b)
+		goto cleanup_cgs;
+
+	if (cg_create(cg_a) || cg_create(cg_b))
+		goto cleanup_cgs;
+
+	if (cg_write(cg_b, "memory.max", "524288"))
+		goto cleanup_cgs;
+
+	child_pid = cg_run_nowait(cg_a, memcg_dmabuf_child, &parent_pid);
+	if (child_pid < 0)
+		goto cleanup_cgs;
+
+	if (cg_wait_for_proc_count(cg_a, 1))
+		goto cleanup_kill;
+
+	heap_fd = open(DMA_HEAP_SYSTEM, O_RDWR);
+	if (heap_fd < 0) {
+		ret = KSFT_SKIP;
+		goto cleanup_kill;
+	}
+
+	alloc.charge_fd = (__u32)sys_pidfd_open(child_pid, 0);
+	if ((int)alloc.charge_fd < 0) {
+		ret = KSFT_SKIP;
+		goto cleanup_heap;
+	}
+
+	if (ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc) < 0) {
+		close(alloc.charge_fd);
+		goto cleanup_heap;
+	}
+	close(alloc.charge_fd);
+	dmabuf_fd = (int)alloc.fd;
+
+	stat_a = cg_read_key_long(cg_a, "memory.stat", "dmabuf ");
+	if (stat_a == -1) {
+		ret = KSFT_SKIP;
+		goto cleanup_dmabuf;
+	}
+	if (stat_a != ONE_MEG)
+		stat_a = cg_read_key_long_poll(cg_a, "memory.stat",
+					       "dmabuf ", ONE_MEG,
+					       MEMCG_DMABUF_WAIT_RETRIES,
+					       DEFAULT_WAIT_INTERVAL_US);
+	if (stat_a != ONE_MEG) {
+		fprintf(stderr, "Charge not in A after alloc: expected %d, got %ld\n",
+			ONE_MEG, stat_a);
+		goto cleanup_dmabuf;
+	}
+
+	cg_b_fd = open(cg_b, O_RDONLY | O_DIRECTORY);
+	if (cg_b_fd < 0)
+		goto cleanup_dmabuf;
+
+	xfer.charge_fd = (__u32)cg_b_fd;
+	if (ioctl(dmabuf_fd, DMA_BUF_IOCTL_XFER_CHARGE, &xfer) == 0) {
+		fprintf(stderr, "xfer_charge should have failed at limit\n");
+		goto cleanup_cgfd;
+	}
+	if (errno != ENOMEM) {
+		fprintf(stderr, "Expected ENOMEM, got %s\n", strerror(errno));
+		goto cleanup_cgfd;
+	}
+
+	stat_a = cg_read_key_long_poll(cg_a, "memory.stat",
+				       "dmabuf ", ONE_MEG,
+				       MEMCG_DMABUF_WAIT_RETRIES,
+				       DEFAULT_WAIT_INTERVAL_US);
+	if (stat_a != ONE_MEG) {
+		fprintf(stderr, "Charge leaked from A: expected %d, got %ld\n",
+			ONE_MEG, stat_a);
+		goto cleanup_cgfd;
+	}
+
+	ret = KSFT_PASS;
+
+cleanup_cgfd:
+	close(cg_b_fd);
+cleanup_dmabuf:
+	if (dmabuf_fd >= 0)
+		close(dmabuf_fd);
+cleanup_heap:
+	close(heap_fd);
+cleanup_kill:
+	kill(child_pid, SIGTERM);
+	waitpid(child_pid, &child_status, 0);
+cleanup_cgs:
+	if (cg_a) {
+		cg_destroy(cg_a);
+		free(cg_a);
+	}
+	if (cg_b) {
+		cg_destroy(cg_b);
+		free(cg_b);
+	}
+cleanup_parent:
+	cg_destroy(parent);
+	free(parent);
+cleanup:
+	return ret;
+}
+
+/*
+ * Allocate a dma-buf charged to a cgroup, then remove that cgroup while
+ * the buffer is still open. The charge is held by an object cgroup,
+ * which is reparented, so the removed cgroup must be released instead of
+ * lingering as a dying descendant until the buffer is closed.
+ */
+static int test_memcg_dmabuf_dead_cgroup(const char *root)
+{
+	char *parent = NULL, *child_cg = NULL;
+	int ret = KSFT_FAIL;
+	int heap_fd = -1, dmabuf_fd = -1, cg_fd = -1;
+	long dmabuf_stat, dying;
+	struct dma_heap_allocation_data alloc = {
+		.len      = ONE_MEG,
+		.fd_flags = O_RDWR | O_CLOEXEC,
+	};
+
+	if (access(DMA_HEAP_SYSTEM, R_OK | W_OK)) {
+		ret = KSFT_SKIP;
+		goto cleanup;
+	}
+
+	parent = cg_name(root, "dmabuf_dead_cgroup_test");
+	if (!parent)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup_parent;
+
+	if (cg_write(parent, "cgroup.subtree_control", "+memory"))
+		goto cleanup_parent;
+
+	child_cg = cg_name(parent, "child");
+	if (!child_cg)
+		goto cleanup_parent;
+
+	if (cg_create(child_cg))
+		goto cleanup_child;
+
+	heap_fd = open(DMA_HEAP_SYSTEM, O_RDWR);
+	if (heap_fd < 0) {
+		ret = KSFT_SKIP;
+		goto cleanup_child;
+	}
+
+	cg_fd = open(child_cg, O_RDONLY | O_DIRECTORY);
+	if (cg_fd < 0)
+		goto cleanup_heap;
+
+	alloc.charge_fd = (__u32)cg_fd;
+	if (ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc) < 0) {
+		if (errno == EINVAL || errno == ENOTTY || errno == EOPNOTSUPP)
+			ret = KSFT_SKIP;
+		goto cleanup_cgfd;
+	}
+	/* The buffer holds the charge; the fd must not hold the cgroup. */
+	close(cg_fd);
+	cg_fd = -1;
+	dmabuf_fd = (int)alloc.fd;
+
+	dmabuf_stat = cg_read_key_long(child_cg, "memory.stat", "dmabuf ");
+	if (dmabuf_stat == -1) {
+		ret = KSFT_SKIP;
+		goto cleanup_dmabuf;
+	}
+	if (dmabuf_stat != ONE_MEG)
+		dmabuf_stat = cg_read_key_long_poll(child_cg, "memory.stat",
+						    "dmabuf ", ONE_MEG,
+						    MEMCG_DMABUF_WAIT_RETRIES,
+						    DEFAULT_WAIT_INTERVAL_US);
+	if (dmabuf_stat != ONE_MEG) {
+		fprintf(stderr, "Expected dmabuf stat %d, got %ld\n",
+			ONE_MEG, dmabuf_stat);
+		goto cleanup_dmabuf;
+	}
+
+	if (cg_destroy(child_cg)) {
+		fprintf(stderr, "Failed to remove charged cgroup\n");
+		goto cleanup_dmabuf;
+	}
+
+	dying = cg_read_key_long_poll(parent, "cgroup.stat",
+				      "nr_dying_descendants ", 0,
+				      MEMCG_DMABUF_DEAD_WAIT_RETRIES,
+				      DEFAULT_WAIT_INTERVAL_US);
+	if (dying) {
+		fprintf(stderr, "Removed cgroup still dying with buffer open\n");
+		goto cleanup_dmabuf;
+	}
+
+	/* The charge must have moved to the parent with the cgroup. */
+	dmabuf_stat = cg_read_key_long(parent, "memory.stat", "dmabuf ");
+	if (dmabuf_stat != ONE_MEG)
+		dmabuf_stat = cg_read_key_long_poll(parent, "memory.stat",
+						    "dmabuf ", ONE_MEG,
+						    MEMCG_DMABUF_WAIT_RETRIES,
+						    DEFAULT_WAIT_INTERVAL_US);
+	if (dmabuf_stat != ONE_MEG) {
+		fprintf(stderr, "Charge not in parent after removal: expected %d, got %ld\n",
+			ONE_MEG, dmabuf_stat);
+		goto cleanup_dmabuf;
+	}
+
+	/* Uncharge through the reparented object cgroup. */
+	close(dmabuf_fd);
+	dmabuf_fd = -1;
+
+	dmabuf_stat = cg_read_key_long(parent, "memory.stat", "dmabuf ");
+	if (dmabuf_stat != 0)
+		dmabuf_stat = cg_read_key_long_poll(parent, "memory.stat",
+						    "dmabuf ", 0,
+						    MEMCG_DMABUF_WAIT_RETRIES,
+						    DEFAULT_WAIT_INTERVAL_US);
+	if (dmabuf_stat != 0) {
+		fprintf(stderr, "Expected dmabuf stat 0 after close, got %ld\n",
+			dmabuf_stat);
+		goto cleanup_heap;
+	}
+
+	ret = KSFT_PASS;
+
+cleanup_dmabuf:
+	if (dmabuf_fd >= 0)
+		close(dmabuf_fd);
+cleanup_cgfd:
+	if (cg_fd >= 0)
+		close(cg_fd);
+cleanup_heap:
+	close(heap_fd);
+cleanup_child:
+	if (child_cg) {
+		cg_destroy(child_cg);
+		free(child_cg);
+	}
+cleanup_parent:
+	cg_destroy(parent);
+	free(parent);
+cleanup:
+	return ret;
+}
+
 #define T(x) { x, #x }
 struct memcg_test {
 	int (*fn)(const char *root);
@@ -1818,13 +2243,20 @@ struct memcg_test {
 	T(test_memcg_oom_group_score_events),
 	T(test_memcg_inotify_delete_file),
 	T(test_memcg_inotify_delete_dir),
+	T(test_memcg_dmabuf),
+	T(test_memcg_dmabuf_xfer_at_limit),
+	T(test_memcg_dmabuf_dead_cgroup),
 };
 #undef T
 
 int main(int argc, char **argv)
 {
 	char root[PATH_MAX];
-	int i, proc_status;
+	int i, proc_status, count = ARRAY_SIZE(tests);
+	const char *filter = NULL;
+
+	if (argc > 1)
+		filter = argv[1];
 
 	page_size = sysconf(_SC_PAGE_SIZE);
 	if (page_size <= 0)
@@ -1855,8 +2287,19 @@ int main(int argc, char **argv)
 		ksft_exit_skip("Failed to query cgroup mount option\n");
 	has_localevents = proc_status;
 
-	ksft_set_plan(ARRAY_SIZE(tests));
+	if (filter) {
+		count = 0;
+		for (i = 0; i < ARRAY_SIZE(tests); i++) {
+			if (!strcmp(tests[i].name, filter))
+				count++;
+		}
+		if (!count)
+			ksft_exit_fail_msg("unknown test '%s'\n", filter);
+	}
+	ksft_set_plan(count);
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (filter && strcmp(tests[i].name, filter))
+			continue;
 		switch (tests[i].fn(root)) {
 		case KSFT_PASS:
 			ksft_test_result_pass("%s\n", tests[i].name);
diff --git a/tools/testing/selftests/dmabuf-heaps/config b/tools/testing/selftests/dmabuf-heaps/config
index be091f1cdfa0..94c8f33b71a2 100644
--- a/tools/testing/selftests/dmabuf-heaps/config
+++ b/tools/testing/selftests/dmabuf-heaps/config
@@ -1,3 +1,4 @@
+CONFIG_MEMCG=y
 CONFIG_DMABUF_HEAPS=y
 CONFIG_DMABUF_HEAPS_SYSTEM=y
 CONFIG_DRM_VGEM=y
diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index 1d49df671919..44e3f33acf87 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -3,6 +3,7 @@
 #include <dirent.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
@@ -10,11 +11,16 @@
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/syscall.h>
 #include <sys/types.h>
+#include <sys/wait.h>
 
 #include <linux/dma-buf.h>
 #include <linux/dma-heap.h>
+#include <linux/limits.h>
 #include <drm/drm.h>
+#include "../pidfd/pidfd.h"
 #include "kselftest.h"
 
 #define DEVPATH "/dev/dma_heap"
@@ -320,6 +326,8 @@ static int dmabuf_heap_alloc_newer(int fd, size_t len, unsigned int flags,
 		__u32 fd;
 		__u32 fd_flags;
 		__u64 heap_flags;
+		__u32 charge_fd;
+		__u32 __padding;
 		__u64 garbage1;
 		__u64 garbage2;
 		__u64 garbage3;
@@ -328,6 +336,8 @@ static int dmabuf_heap_alloc_newer(int fd, size_t len, unsigned int flags,
 		.fd = 0,
 		.fd_flags = O_RDWR | O_CLOEXEC,
 		.heap_flags = flags,
+		.charge_fd = 0,
+		.__padding = 0,
 		.garbage1 = 0xffffffff,
 		.garbage2 = 0x88888888,
 		.garbage3 = 0x11111111,
@@ -496,6 +506,227 @@ static void test_alloc_no_fd_leak_on_efault(char *heap_name)
 	ksft_test_result(fd_before == fd_after,
 			 "fd leak on EFAULT: before=%d after=%d\n",
 			 fd_before, fd_after);
+
+out:
+	close(heap_fd);
+}
+
+static int dmabuf_heap_alloc_pidfd(int fd, size_t len, unsigned int heap_flags,
+				   unsigned int charge_fd, int *dmabuf_fd)
+{
+	struct dma_heap_allocation_data data = {
+		.len = len,
+		.fd = 0,
+		.fd_flags = O_RDWR | O_CLOEXEC,
+		.heap_flags = heap_flags,
+		.charge_fd = charge_fd,
+	};
+	int ret;
+
+	if (!dmabuf_fd)
+		return -EINVAL;
+
+	ret = ioctl(fd, DMA_HEAP_IOCTL_ALLOC, &data);
+	if (ret < 0)
+		return ret;
+	*dmabuf_fd = (int)data.fd;
+	return ret;
+}
+
+/*
+ * Probe whether the kernel honours charge_fd in DMA_HEAP_IOCTL_ALLOC.
+ */
+static bool pidfd_alloc_supported(int heap_fd)
+{
+	int devnull_fd, dmabuf_fd = -1, ret;
+
+	devnull_fd = open("/dev/null", O_RDONLY);
+	if (devnull_fd < 0)
+		return false;
+
+	ret = dmabuf_heap_alloc_pidfd(heap_fd, ONE_MEG, 0, devnull_fd, &dmabuf_fd);
+	if (dmabuf_fd >= 0) {
+		close(dmabuf_fd);
+		dmabuf_fd = -1;
+	}
+	close(devnull_fd);
+	return ret < 0;
+}
+
+/*
+ * Test: allocate charging the calling process's own cgroup via a self pidfd.
+ */
+static void test_alloc_pidfd_self(char *heap_name)
+{
+	int heap_fd = -1, pidfd = -1, dmabuf_fd = -1, ret;
+
+	heap_fd = dmabuf_heap_open(heap_name);
+
+	if (!pidfd_alloc_supported(heap_fd)) {
+		ksft_test_result_skip("charge_fd not supported by this kernel\n");
+		goto out;
+	}
+
+	pidfd = sys_pidfd_open(getpid(), 0);
+	if (pidfd < 0) {
+		ksft_test_result_skip("pidfd_open not available\n");
+		goto out;
+	}
+
+	ret = dmabuf_heap_alloc_pidfd(heap_fd, ONE_MEG, 0, pidfd, &dmabuf_fd);
+	ksft_test_result(!ret, "Allocation with self pidfd %d\n", ret);
+	if (dmabuf_fd >= 0)
+		close(dmabuf_fd);
+	close(pidfd);
+out:
+	close(heap_fd);
+}
+
+/*
+ * Test: allocate charging a child process's cgroup via a child pidfd.
+ */
+static void test_alloc_pidfd_child(char *heap_name)
+{
+	int heap_fd = -1, pidfd = -1, dmabuf_fd = -1;
+	pid_t child_pid, parent_pid;
+	int status, ret;
+
+	heap_fd = dmabuf_heap_open(heap_name);
+
+	if (!pidfd_alloc_supported(heap_fd)) {
+		ksft_test_result_skip("charge_fd not supported by this kernel\n");
+		goto out;
+	}
+
+	parent_pid = getpid();
+	child_pid = fork();
+	if (child_pid == 0) {
+		prctl(PR_SET_PDEATHSIG, SIGKILL);
+		if (getppid() != parent_pid)
+			_exit(0);
+		pause();
+		_exit(0);
+	}
+	if (child_pid < 0)
+		ksft_exit_fail_msg("fork failed: %s\n", strerror(errno));
+
+	pidfd = sys_pidfd_open(child_pid, 0);
+	if (pidfd < 0) {
+		kill(child_pid, SIGTERM);
+		waitpid(child_pid, &status, 0);
+		ksft_test_result_skip("pidfd_open for child failed\n");
+		goto out;
+	}
+
+	ret = dmabuf_heap_alloc_pidfd(heap_fd, ONE_MEG, 0, pidfd, &dmabuf_fd);
+	ksft_test_result(!ret, "Allocation with child pidfd %d\n", ret);
+	if (dmabuf_fd >= 0)
+		close(dmabuf_fd);
+	close(pidfd);
+	kill(child_pid, SIGTERM);
+	waitpid(child_pid, &status, 0);
+out:
+	close(heap_fd);
+}
+
+static int open_self_cgroupfd(void)
+{
+	char cgroup_path[PATH_MAX];
+	char line[PATH_MAX];
+	int ret = -1;
+	FILE *f;
+
+	f = fopen("/proc/self/cgroup", "r");
+	if (!f)
+		return -1;
+	while (fgets(line, sizeof(line), f)) {
+		if (strncmp(line, "0::", 3))
+			continue;
+		line[strcspn(line, "\n")] = '\0';
+		if (snprintf(cgroup_path, sizeof(cgroup_path),
+			     "/sys/fs/cgroup%s", line + 3) < PATH_MAX)
+			ret = 0;
+		break;
+	}
+	fclose(f);
+
+	if (ret)
+		return -1;
+
+	return open(cgroup_path, O_RDONLY | O_DIRECTORY);
+}
+
+/*
+ * Test: allocate charging the calling process's own cgroup via a cgroupfd.
+ */
+static void test_alloc_cgroupfd_self(char *heap_name)
+{
+	int heap_fd = -1, cgroup_fd = -1, dmabuf_fd = -1, ret;
+
+	heap_fd = dmabuf_heap_open(heap_name);
+
+	if (!pidfd_alloc_supported(heap_fd)) {
+		ksft_test_result_skip("charge_fd not supported by this kernel\n");
+		goto out;
+	}
+
+	cgroup_fd = open_self_cgroupfd();
+	if (cgroup_fd < 0) {
+		ksft_test_result_skip("cannot open self cgroupfd\n");
+		goto out;
+	}
+
+	ret = dmabuf_heap_alloc_pidfd(heap_fd, ONE_MEG, 0, cgroup_fd, &dmabuf_fd);
+	ksft_test_result(!ret, "Allocation with cgroupfd %d\n", ret);
+	if (dmabuf_fd >= 0)
+		close(dmabuf_fd);
+	close(cgroup_fd);
+out:
+	close(heap_fd);
+}
+
+/*
+ * Test: transfer a dma-buf's charge to self cgroup via DMA_BUF_IOCTL_XFER_CHARGE.
+ */
+static void test_xfer_charge_cgroupfd_self(char *heap_name)
+{
+	int heap_fd = -1, cgroup_fd = -1, dmabuf_fd = -1, ret;
+	struct dma_buf_transfer_charge xfer = { 0 };
+
+	heap_fd = dmabuf_heap_open(heap_name);
+
+	if (!pidfd_alloc_supported(heap_fd)) {
+		ksft_test_result_skip("charge_fd not supported by this kernel\n");
+		goto out;
+	}
+
+	ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
+	if (ret) {
+		ksft_test_result_fail("Allocation failed %d\n", ret);
+		goto out;
+	}
+
+	cgroup_fd = open_self_cgroupfd();
+	if (cgroup_fd < 0) {
+		ksft_test_result_skip("cannot open self cgroupfd\n");
+		close(dmabuf_fd);
+		goto out;
+	}
+
+	xfer.charge_fd = cgroup_fd;
+	ret = ioctl(dmabuf_fd, DMA_BUF_IOCTL_XFER_CHARGE, &xfer);
+	if (!ret)
+		ksft_test_result_pass("XFER_CHARGE to self cgroupfd\n");
+	else if (errno == EOPNOTSUPP)
+		ksft_test_result_skip("buffer not memcg-charged (mem_accounting=0?)\n");
+	else if (errno == ENOTTY || errno == EINVAL)
+		ksft_test_result_skip("XFER_CHARGE not supported: %s\n",
+				      strerror(errno));
+	else
+		ksft_test_result_fail("XFER_CHARGE failed: %s\n", strerror(errno));
+
+	close(cgroup_fd);
+	close(dmabuf_fd);
 out:
 	close(heap_fd);
 }
@@ -530,7 +761,7 @@ int main(void)
 		return KSFT_SKIP;
 	}
 
-	ksft_set_plan(12 * numer_of_heaps());
+	ksft_set_plan(16 * numer_of_heaps());
 
 	while ((dir = readdir(d))) {
 		if (!strncmp(dir->d_name, ".", 2))
@@ -546,6 +777,10 @@ int main(void)
 		test_alloc_compat(dir->d_name);
 		test_alloc_errors(dir->d_name);
 		test_alloc_no_fd_leak_on_efault(dir->d_name);
+		test_alloc_pidfd_self(dir->d_name);
+		test_alloc_pidfd_child(dir->d_name);
+		test_alloc_cgroupfd_self(dir->d_name);
+		test_xfer_charge_cgroupfd_self(dir->d_name);
 	}
 	closedir(d);
 
diff --git a/tools/testing/selftests/dmabuf-heaps/vmtest.sh b/tools/testing/selftests/dmabuf-heaps/vmtest.sh
new file mode 100755
index 000000000000..3574b71ca83e
--- /dev/null
+++ b/tools/testing/selftests/dmabuf-heaps/vmtest.sh
@@ -0,0 +1,226 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2026 Red Hat
+#
+# Dependencies:
+#		* virtme-ng
+#		* qemu	(used by virtme-ng)
+
+readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
+readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)
+readonly CGROUP_DIR="${KERNEL_CHECKOUT}/tools/testing/selftests/cgroup"
+
+source "${SCRIPT_DIR}"/../kselftest/ktap_helpers.sh
+
+readonly DMABUF_HEAP_TEST="${SCRIPT_DIR}"/dmabuf-heap
+readonly MEMCONTROL_TEST="${CGROUP_DIR}"/test_memcontrol
+readonly TMP_DIR=$(mktemp -d /tmp/dmabuf-vmtest.XXXXXXXX)
+
+VERBOSE=false
+BUILD=false
+BUILD_HOST=""
+BUILD_HOST_PODMAN_CONTAINER_NAME=""
+SHELL_MODE=false
+
+usage() {
+	echo
+	echo "$0 [OPTIONS]"
+	echo
+	echo "Options"
+	echo "  -b: build the kernel from the current source tree and use it for the VM"
+	echo "  -H: hostname for remote build host (used with -b)"
+	echo "  -p: podman container name for remote build host (used with -b)"
+	echo "      Example: -H beefyserver -p vng"
+	echo "  -s: drop into an interactive shell in the VM instead of running tests"
+	echo "  -v: enable verbose vng/qemu output"
+	echo
+
+	exit 1
+}
+
+die() {
+	echo "$*" >&2
+	exit "${KSFT_FAIL}"
+}
+
+cleanup() {
+	rm -rf "${TMP_DIR}"
+}
+
+check_deps() {
+	for dep in vng make; do
+		if [[ ! -x $(command -v "${dep}") ]]; then
+			echo -e "skip:    dependency ${dep} not found!\n"
+			exit "${KSFT_SKIP}"
+		fi
+	done
+
+	if ${SHELL_MODE}; then
+		return
+	fi
+
+	if [[ ! -x "${DMABUF_HEAP_TEST}" ]]; then
+		printf "skip:    %s not found!" "${DMABUF_HEAP_TEST}"
+		printf " Please build the kselftest dmabuf-heaps target (or use -b).\n"
+		exit "${KSFT_SKIP}"
+	fi
+
+	if [[ ! -x "${MEMCONTROL_TEST}" ]]; then
+		printf "skip:    %s not found!" "${MEMCONTROL_TEST}"
+		printf " Please build the kselftest cgroup target (or use -b).\n"
+		exit "${KSFT_SKIP}"
+	fi
+}
+
+check_vng() {
+	local tested_versions=("1.36" "1.37")
+	local version
+	local ok=0
+
+	version="$(vng --version)"
+	for tv in "${tested_versions[@]}"; do
+		if [[ "${version}" == *"${tv}"* ]]; then
+			ok=1
+			break
+		fi
+	done
+
+	if [[ "${ok}" -eq 0 ]]; then
+		printf "warning: vng version '%s' has not been tested and may " "${version}" >&2
+		printf "not function properly.\n\tThe following versions have been tested: " >&2
+		echo "${tested_versions[@]}" >&2
+	fi
+}
+
+build_selftests() {
+	make -C "${KERNEL_CHECKOUT}" headers_install \
+		INSTALL_HDR_PATH="${TMP_DIR}/usr" -j"$(nproc)"
+
+	local khdr="-isystem ${TMP_DIR}/usr/include"
+
+	if ! make -C "${SCRIPT_DIR}" KHDR_INCLUDES="${khdr}" -j"$(nproc)"; then
+		die "failed to build dmabuf-heaps selftests"
+	fi
+
+	if ! make -C "${CGROUP_DIR}" KHDR_INCLUDES="${khdr}" \
+		"${MEMCONTROL_TEST}" -j"$(nproc)"; then
+		die "failed to build cgroup/test_memcontrol selftest"
+	fi
+}
+
+handle_build() {
+	if ! ${BUILD}; then
+		return
+	fi
+
+	if [[ ! -d "${KERNEL_CHECKOUT}" ]]; then
+		echo "-b requires vmtest.sh called from the kernel source tree" >&2
+		exit 1
+	fi
+
+	pushd "${KERNEL_CHECKOUT}" &>/dev/null
+
+	if ! vng --kconfig --config "${SCRIPT_DIR}/config"; then
+		die "failed to generate .config for kernel source tree (${KERNEL_CHECKOUT})"
+	fi
+
+	local vng_args=("-v" "--config" "${SCRIPT_DIR}/config" "--build")
+
+	if [[ -n "${BUILD_HOST}" ]]; then
+		vng_args+=("--build-host" "${BUILD_HOST}")
+	fi
+
+	if [[ -n "${BUILD_HOST_PODMAN_CONTAINER_NAME}" ]]; then
+		vng_args+=("--build-host-exec-prefix" \
+			   "podman exec -ti ${BUILD_HOST_PODMAN_CONTAINER_NAME}")
+	fi
+
+	if ! vng "${vng_args[@]}"; then
+		die "failed to build kernel from source tree (${KERNEL_CHECKOUT})"
+	fi
+
+	build_selftests
+
+	popd &>/dev/null
+}
+
+make_runner() {
+	# virtme-ng shares the host filesystem, so TMP_DIR is accessible
+	# inside the VM at the same absolute path.
+	cat > "${TMP_DIR}/run_tests.sh" <<-EOF
+	#!/bin/sh
+	set -u
+
+	# Enable memory controller for child cgroups
+	echo +memory > /sys/fs/cgroup/cgroup.subtree_control 2>/dev/null
+
+	PASS=0; FAIL=0; SKIP=0; N=0
+
+	run() {
+		name="\$1"; shift
+		N=\$((N+1))
+		"\$@"; rc=\$?
+		if   [ \$rc -eq 0 ]; then echo "ok \$N \$name";        PASS=\$((PASS+1))
+		elif [ \$rc -eq 4 ]; then echo "ok \$N \$name # SKIP"; SKIP=\$((SKIP+1))
+		else                      echo "not ok \$N \$name";    FAIL=\$((FAIL+1))
+		fi
+	}
+
+	run "dmabuf-heap charge_fd ioctl"	${DMABUF_HEAP_TEST}
+	run "memcontrol dma-buf memcg"	${MEMCONTROL_TEST} test_memcg_dmabuf
+	run "memcontrol dma-buf xfer limit" \
+		${MEMCONTROL_TEST} test_memcg_dmabuf_xfer_at_limit
+	echo "# PASS=\$PASS SKIP=\$SKIP FAIL=\$FAIL"
+	[ \$FAIL -eq 0 ]
+	EOF
+	chmod +x "${TMP_DIR}/run_tests.sh"
+}
+
+run_vm() {
+	local verbose_opt=""
+	local kernel_opt=""
+
+	${VERBOSE} && verbose_opt="--verbose"
+
+	# If we are running from within the kernel source tree, use the kernel
+	# source tree as the kernel to boot, otherwise use the running kernel.
+	if [[ "$(realpath "$(pwd)")" == "${KERNEL_CHECKOUT}"* ]]; then
+		kernel_opt="${KERNEL_CHECKOUT}"
+	fi
+
+	if ${SHELL_MODE}; then
+		echo "Starting interactive shell in VM. Exit to stop VM."
+		vng --run ${kernel_opt} ${verbose_opt} --user root --memory 512M \
+			--append "dma_heap.mem_accounting=1" \
+			-- bash --noprofile --norc
+		exit "${KSFT_PASS}"
+	fi
+
+	vng --run ${kernel_opt} ${verbose_opt} --user root --memory 512M \
+		--append "dma_heap.mem_accounting=1" \
+		--exec "${TMP_DIR}/run_tests.sh"
+}
+
+while getopts :hvsbH:p: o
+do
+	case $o in
+	v) VERBOSE=true;;
+	b) BUILD=true;;
+	s) SHELL_MODE=true;;
+	H) BUILD_HOST=$OPTARG;;
+	p) BUILD_HOST_PODMAN_CONTAINER_NAME=$OPTARG;;
+	h|*) usage;;
+	esac
+done
+shift $((OPTIND-1))
+
+trap cleanup EXIT
+
+check_deps
+check_vng
+handle_build
+make_runner
+
+echo "Booting VM and running tests..."
+run_vm

-- 
2.55.0

