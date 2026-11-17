Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F60606A880
	for <op-tee@archiver.kernel.org>; Tue, 17 Nov 2026 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=2QvQ+hei;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KXJBnw9W
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B01B7454C6
	for <op-tee@archiver.kernel.org>; Tue, 17 Nov 2026 08:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794904937;
	bh=YRGBhFlRTNQesmC+53+mQbdidsg9pxvs3IaHY8atbxE=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=2QvQ+heiKH4my+FcnCC8Om4IBOv2BNsoq7C5zs6tmPkT6m5onbRN+/a0izG4R0NKq
	 jLQA6fSIfVEriXDldia7Tzk2EjzxQzCdpr11ZhIdCDMUCEYU9x8F1BR5NOcC+HtVhI
	 y1l0JMAUliMwAVtIy9ou0lNfkhG7aASfBV+eU/eGWVRD+FDF4ILmKZmPwO+RvWytr8
	 8jQsexXt7+rmtdDle4pSS1GxjUZlJ2plNyAmc+V828ghJhUI8AdlljCoJG3kS1d2dk
	 nOr7MtqKkfhvVmQAUQo6K4UeJTRQai/qE3TiZDN0yzcYDKju5eNNTvS5MDNyQplkKx
	 gRE0eCF+6mwJA==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 93EA745503
	for <op-tee@lists.trustedfirmware.org>; Tue, 17 Nov 2026 08:40:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KXJBnw9W;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794904828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7W5OA0Pfbz4DWlJkfLR5cfYObFa/4T5Fl7aOVgxV27Y=;
	b=KXJBnw9WhP6evSODNZJFhQj4zmdv9LShwodQDKH8rbwl2sqXQ7f/YNxsj0dBFxwPTX2OnM
	ucPeoB8J2G8ys6pJ+e4zFcu1muMzDVVuV06qsrehhEGMSTva0mR+ZFQrnxGXdpamQJP8tm
	MxQoMSu9LpTLxGK3UhU61lTec/zxdg8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-MmJI-5eQP4ytDa1v37736Q-1; Tue,
 17 Nov 2026 03:40:23 -0500
X-MC-Unique: MmJI-5eQP4ytDa1v37736Q-1
X-Mimecast-MFC-AGG-ID: MmJI-5eQP4ytDa1v37736Q_1794904818
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41F481956069;
	Tue, 17 Nov 2026 08:40:18 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52BF31956047;
	Tue, 17 Nov 2026 08:40:09 +0000 (UTC)
Date: Tue, 17 Nov 2026 09:39:20 +0100
Subject: [PATCH v5 5/8] lsm: Add memcg_charge_cgroup LSM hook
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261117-v2_20230123_tjmercier_google_com-v5-5-1ce975f2a9ad@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794904759; l=4811;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=YRGBhFlRTNQesmC+53+mQbdidsg9pxvs3IaHY8atbxE=;
 b=fR/PjTXILA5LyYPNu/ieXF3ZRz0p6iADYUtxuVFqK1tRqToEfnvX2KwPchBPH5m+5SN0ZyaDG
 9BKFzARlj9EAUEPaiTvCvkWTrbM5E9dAbj9bDBZOT7GuinwCoc1oqZF
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: i3I8HPUHuDizeYVL-2yESdYc3aOZjIw-l480apn036M_1794904818
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
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
X-Rspamd-Queue-Id: 93EA745503
X-Spamd-Bar: ----
Message-ID-Hash: L35J67KOKTL257KBTCEVAVZHE2ZKKX7Z
X-Message-ID-Hash: L35J67KOKTL257KBTCEVAVZHE2ZKKX7Z
X-MailFrom: aesteve@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: airlied@gmail.com, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, Albert Esteve <aesteve@redhat.com>, echanude@redhat.com, mripard@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/L35J67KOKTL257KBTCEVAVZHE2ZKKX7Z/>
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

Similar to how security_memcg_charge_task adds an access-control
point for pidfd for the charge_fd of a DMA_HEAP_IOCTL_ALLOC or
DMA_BUF_IOCTL_XFER_CHARGE ioctl, we need a new access-control point
for the case where charge_fd represents a cgroupfd.

Add security_memcg_charge_cgroup(), called in get_obj_cgroup_from_fd()
when charge_fd refers to a cgroup2. The hook receives the credentials
of the requesting process (cred) and the open file of the cgroup
directory to charge (file), giving security modules a controlled
enforcement point for cross-cgroup memcg attribution policy.

The file is passed instead of the cgroup so that a module can
label-check the object the cgroupfd actually names.
get_obj_cgroup_from_fd() resolves the memory css from that same file
with css_tryget_online_from_dir(), so the fd cannot be swapped between
the check and the charge.

When CONFIG_SECURITY is not set the hook compiles to an inline
returning 0, adding no overhead to the fast path.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  8 ++++++++
 mm/memcontrol.c               |  9 ++++++++-
 security/security.c           | 20 ++++++++++++++++++++
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 93c8bb5642f5..3b254b4e60ec 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -44,6 +44,7 @@ LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
 LSM_HOOK(int, 0, capable, const struct cred *cred, struct user_namespace *ns,
 	 int cap, unsigned int opts)
 LSM_HOOK(int, 0, memcg_charge_task, const struct cred *from, const struct cred *to)
+LSM_HOOK(int, 0, memcg_charge_cgroup, const struct cred *cred, const struct file *file)
 LSM_HOOK(int, 0, quotactl, int cmds, int type, int id, const struct super_block *sb)
 LSM_HOOK(int, 0, quota_on, struct dentry *dentry)
 LSM_HOOK(int, 0, syslog, int type)
diff --git a/include/linux/security.h b/include/linux/security.h
index b21823225ed0..d1cd6c324ffd 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -353,6 +353,8 @@ int security_capable(const struct cred *cred,
 		       int cap,
 		       unsigned int opts);
 int security_memcg_charge_task(const struct cred *from, const struct cred *to);
+int security_memcg_charge_cgroup(const struct cred *cred,
+				 const struct file *file);
 int security_quotactl(int cmds, int type, int id, const struct super_block *sb);
 int security_quota_on(struct dentry *dentry);
 int security_syslog(int type);
@@ -717,6 +719,12 @@ static inline int security_memcg_charge_task(const struct cred *from,
 	return 0;
 }
 
+static inline int security_memcg_charge_cgroup(const struct cred *cred,
+					       const struct file *file)
+{
+	return 0;
+}
+
 static inline int security_quotactl(int cmds, int type, int id,
 				     const struct super_block *sb)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2e6fcbe14d43..693f0b2877bf 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3220,7 +3220,14 @@ struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
 		css = ERR_PTR(-EBADF);
 	}
 
-	if (IS_ERR(css)) {
+	if (!IS_ERR(css)) {
+		/* fd is a cgroupfd */
+		ret = security_memcg_charge_cgroup(current_cred(), fd_file(f));
+		if (ret) {
+			css_put(css);
+			return ERR_PTR(ret);
+		}
+	} else {
 		if (PTR_ERR(css) != -EBADF)
 			return ERR_CAST(css);
 
diff --git a/security/security.c b/security/security.c
index e198e00b6a40..925b6c003059 100644
--- a/security/security.c
+++ b/security/security.c
@@ -689,6 +689,26 @@ int security_memcg_charge_task(const struct cred *from, const struct cred *to)
 	return call_int_hook(memcg_charge_task, from, to);
 }
 
+/**
+ * security_memcg_charge_cgroup() - Check if charging memory to a cgroup is allowed
+ * @cred: credentials of the process requesting the charge
+ * @file: open file of the cgroup directory to charge
+ *
+ * Check whether the process with credentials @cred is allowed to charge
+ * memory to the cgroup referenced by @file. Called when userspace passes a
+ * cgroupfd to identify the charge target instead of a pidfd. @file is the
+ * file the cgroup was resolved from, so the check applies to the object
+ * that is actually charged. It must have been already validated by the
+ * caller.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_memcg_charge_cgroup(const struct cred *cred,
+				 const struct file *file)
+{
+	return call_int_hook(memcg_charge_cgroup, cred, file);
+}
+
 /**
  * security_quotactl() - Check if a quotactl() syscall is allowed for this fs
  * @cmds: commands

-- 
2.55.0

