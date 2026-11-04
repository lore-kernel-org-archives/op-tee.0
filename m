Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085BB606A326
	for <op-tee@archiver.kernel.org>; Wed,  4 Nov 2026 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=49HVak1y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LfjRSLaJ
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5620F45466
	for <op-tee@archiver.kernel.org>; Wed,  4 Nov 2026 11:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793790714;
	bh=tLPI2RsSKhsOZqNWFIvgktu7E/VbWAcyepTlyll79Zs=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=49HVak1yGimmaX8dV5LbFVfc5nRhTpHK3faMsUaLAOSU594JzgQRf3Tkpun25QK9k
	 veXbOlHCnp4a9WEhom7vISIwjn0wUe1HnuQ5lVsuaVKfFK3VTg5cwiQpfW0JPxfVXR
	 /CKCJrFAFMovG+WtLq2mFXT1hQ3OLE/MqdY212tAAbee7MDgRXoQjOM8CyF/XhX426
	 HToOyJwpPPDULJjBBj5qM8Kj9WTa9NbcgW1jH8ur2SBiAMXqtXpcFdxgI53tmycKh6
	 b9/qWxoxR4lLdGW9dLg6cxAzu7JsPGHfj+U2dF8s7Kp8mNW2SPpcvmysibDvOIJTnj
	 +pbbQkWFl1Pnw==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 974A84547A
	for <op-tee@lists.trustedfirmware.org>; Wed,  4 Nov 2026 11:10:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LfjRSLaJ;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793790609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7n4fmWUky+vs4idCDlxPFi6+bwonkuAntrLXf3wBF2s=;
	b=LfjRSLaJXwNZ9qq4pTi5VvVNrnnKvm5eWZoMsxOC+BxPxwcyVNO1bpwV5ENhmBVZOtNyFv
	ut3gZzTp324T5yxeefkKkPSVleOb0Tdnb8cQ34dZF1jc9PZw0ie0hMGOzbZ0kJcvCWXvRN
	teyw+iObBsXI6uuuknHjBiqNr3uY6Gg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-_JEk64hCPe6_t6DOQDy98A-1; Wed,
 04 Nov 2026 06:10:05 -0500
X-MC-Unique: _JEk64hCPe6_t6DOQDy98A-1
X-Mimecast-MFC-AGG-ID: _JEk64hCPe6_t6DOQDy98A_1793790599
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 339DE1955F75;
	Wed,  4 Nov 2026 11:09:59 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8F3D195608D;
	Wed,  4 Nov 2026 11:09:51 +0000 (UTC)
Date: Wed, 04 Nov 2026 12:09:13 +0100
Subject: [PATCH v4 4/8] security: dma-buf: Add dma_buf_charge_task LSM hook
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261104-v2_20230123_tjmercier_google_com-v4-4-1819a017000b@redhat.com>
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
In-Reply-To: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
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
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793790554; l=4963;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=tLPI2RsSKhsOZqNWFIvgktu7E/VbWAcyepTlyll79Zs=;
 b=OpfXZ5pArGbvxwctGkok63VwznmiQv3Kga5Ax0dbd07KXxBEYL59v+Q7plTvYbWPAprFy1Jjt
 2+uSIAOQQLUA5Np7R+aTopHWrrcSAkcmUos6/IvZSsViDc0BmpW5/X0
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: WnicrcXrZLDdXrcrKeW5YCSLAXjBjScWMjmGYz7nGVk_1793790599
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.90 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[redhat.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	RWL_MAILSPIKE_EXCELLENT(-0.40)[170.10.129.124:from];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:170.10.129.0/24];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:30031, ipnet:170.10.128.0/23, country:US];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[170.10.129.124:from];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 974A84547A
X-Spamd-Bar: ----
Message-ID-Hash: HRS7THOQ5OZEJYFXOJMMXCPOHVVWCNZ2
X-Message-ID-Hash: HRS7THOQ5OZEJYFXOJMMXCPOHVVWCNZ2
X-MailFrom: aesteve@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, Albert Esteve <aesteve@redhat.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HRS7THOQ5OZEJYFXOJMMXCPOHVVWCNZ2/>
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

DMA_HEAP_IOCTL_ALLOC accepts a charge_fd field that,
when set, causes the allocation to be charged to an arbitrary
process's cgroup rather than the caller's.

Without an access-control point, any process that holds a handle
to a dma-heap device node can charge unlimited memory to any other
process's cgroup, potentially exhausting that cgroup's limit and
triggering OOM kills independent of the victim's own activity or
privileges.

Add security_dma_buf_charge_task(), called in mem_cgroup_get_from_fd()
when charge_fd refers to another process. The hook receives
the credentials of the allocating process (from) and the credentials
of the process whose cgroup will be charged (to), giving security
modules a controlled enforcement point for cross-cgroup dma-buf
attribution policy.

When CONFIG_SECURITY is not set the hook compiles to an inline
returning 0, adding no overhead to the fast path.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  7 +++++++
 mm/memcontrol.c               | 11 +++++++++++
 security/security.c           | 16 ++++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 65c9609ec207..0f1138e16dbe 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -43,6 +43,7 @@ LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
 	 const kernel_cap_t *permitted)
 LSM_HOOK(int, 0, capable, const struct cred *cred, struct user_namespace *ns,
 	 int cap, unsigned int opts)
+LSM_HOOK(int, 0, dma_buf_charge_task, const struct cred *from, const struct cred *to)
 LSM_HOOK(int, 0, quotactl, int cmds, int type, int id, const struct super_block *sb)
 LSM_HOOK(int, 0, quota_on, struct dentry *dentry)
 LSM_HOOK(int, 0, syslog, int type)
diff --git a/include/linux/security.h b/include/linux/security.h
index 153e9043058f..89a35eb07b8c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -350,6 +350,7 @@ int security_capable(const struct cred *cred,
 		       struct user_namespace *ns,
 		       int cap,
 		       unsigned int opts);
+int security_dma_buf_charge_task(const struct cred *from, const struct cred *to);
 int security_quotactl(int cmds, int type, int id, const struct super_block *sb);
 int security_quota_on(struct dentry *dentry);
 int security_syslog(int type);
@@ -701,6 +702,12 @@ static inline int security_capable(const struct cred *cred,
 	return cap_capable(cred, ns, cap, opts);
 }
 
+static inline int security_dma_buf_charge_task(const struct cred *from,
+					       const struct cred *to)
+{
+	return 0;
+}
+
 static inline int security_quotactl(int cmds, int type, int id,
 				     const struct super_block *sb)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3e717b5663c8..dd276e1230cc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -59,6 +59,7 @@
 #include <linux/lockdep.h>
 #include <linux/resume_user_mode.h>
 #include <linux/psi.h>
+#include <linux/security.h>
 #include <linux/seq_buf.h>
 #include <linux/sched/isolation.h>
 #include <linux/kmemleak.h>
@@ -5672,11 +5673,13 @@ void mem_cgroup_flush_workqueue(void)
 struct mem_cgroup *mem_cgroup_get_from_fd(int fd)
 {
 	struct cgroup_subsys_state *css;
+	const struct cred *tcred;
 	struct mem_cgroup *memcg;
 	struct cgroup *cgrp;
 	struct task_struct *task;
 	struct mm_struct *mm;
 	unsigned int pidfd_flags;
+	int ret;
 
 	cgrp = cgroup_get_from_fd(fd);
 	if (!IS_ERR(cgrp)) {
@@ -5698,6 +5701,14 @@ struct mem_cgroup *mem_cgroup_get_from_fd(int fd)
 	if (IS_ERR(task))
 		return ERR_CAST(task);
 
+	tcred = get_task_cred(task);
+	ret = security_dma_buf_charge_task(current_cred(), tcred);
+	put_cred(tcred);
+	if (ret) {
+		put_task_struct(task);
+		return ERR_PTR(ret);
+	}
+
 	mm = get_task_mm(task);
 	put_task_struct(task);
 	if (!mm)
diff --git a/security/security.c b/security/security.c
index 2ee276ab15c5..4a16e4076aab 100644
--- a/security/security.c
+++ b/security/security.c
@@ -660,6 +660,22 @@ int security_capable(const struct cred *cred,
 	return call_int_hook(capable, cred, ns, cap, opts);
 }
 
+/**
+ * security_dma_buf_charge_task() - Check if cross-cgroup dma-heap charging is allowed
+ * @from: credentials of the allocating process
+ * @to: credentials of the process to charge
+ *
+ * Check whether the process with credentials @from is allowed to allocate
+ * dma-heap memory and charge it to the cgroup of the process with credentials
+ * @to.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_dma_buf_charge_task(const struct cred *from, const struct cred *to)
+{
+	return call_int_hook(dma_buf_charge_task, from, to);
+}
+
 /**
  * security_quotactl() - Check if a quotactl() syscall is allowed for this fs
  * @cmds: commands

-- 
2.55.0

