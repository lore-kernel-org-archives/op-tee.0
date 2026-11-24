Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CFD606A327
	for <op-tee@archiver.kernel.org>; Tue, 24 Nov 2026 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=rliKGJub;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HNGO7IFr
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0FA814551F
	for <op-tee@archiver.kernel.org>; Tue, 24 Nov 2026 13:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795525643;
	bh=YotIlLIQVfYmQv+JgAWzs3C/IOGV77S7HbDgbIH2No8=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=rliKGJubb/HktMTJGer0v+z8gnZHCw21LRYs9Ds/rhUF0lA+qUynBeNbOkpgS/F4W
	 9pcByUu4EzHCjCxFegbgoNFcKstBuoo2pQWi1MFhPmYfiHn8Dox9yUJlO0u7JqLG35
	 oCfh4SycVNeAelZqlNeZlPs5ZCFlXxC1SK1x3phKhUYYo0awE24NunNlfcjit6nEGr
	 E8xdi083ZopV01UVAiP9WGjxkzgMugqtuCZUXph2AgpHoVzkEgQS18LHfgC3TTgeoe
	 hp9ucVH3g4p/jhRxXMnoCBrv2JxXSgkdXGikGAoWO2rRviFMNu13V9wjc0K8pQJnFL
	 TIkci4KIrAI9w==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EA97245518
	for <op-tee@lists.trustedfirmware.org>; Tue, 24 Nov 2026 13:05:01 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HNGO7IFr;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795525501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHqrrJBOJPwHyma5saYtPMd/5tcAtG5XUpif2stsI6c=;
	b=HNGO7IFraGD9fzEV7z8IdZP5Y8emmQxGIGslHpQairpXquJ1QMsAQztQBMequN+JEUm38y
	UE9ZRY8b2ZgVvW4E/oVi7aqYSsAt08g5Jkyk0735aMinYQQZQ/gCFUzQ99+wrA6XO9SJlG
	NX32eEzkiVpShw5Wil0260a3nz+4uc8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-BuLl_dL3PCyUJAUnKT7uEg-1; Tue,
 24 Nov 2026 13:04:58 +0000
X-MC-Unique: BuLl_dL3PCyUJAUnKT7uEg-1
X-Mimecast-MFC-AGG-ID: BuLl_dL3PCyUJAUnKT7uEg_1795525492
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 757D51955D95;
	Tue, 24 Nov 2026 13:04:52 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 813331956087;
	Tue, 24 Nov 2026 13:04:43 +0000 (UTC)
Date: Tue, 24 Nov 2026 14:03:40 +0100
Subject: [PATCH v6 6/7] selinux: Restrict cross-cgroup memcg charging
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261124-v2_20230123_tjmercier_google_com-v6-6-dce12fa03ad6@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795525424; l=3935;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=YotIlLIQVfYmQv+JgAWzs3C/IOGV77S7HbDgbIH2No8=;
 b=A8ZhZL+LOltwrvn/pwh8qPMWB3/tqr5B+k52OMOYOOPUTvlBfStesFciDdy/y5QlDSbMqekrk
 BA9isnKzIXNDSV2bMjiKaCybQwGp4+Ojvq+S9lSmMQ7HkEnb7VZacH2
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 0Wj3wJ4ci2JH_IMb5gxqNWsR2JH1gDkNL6XpBjTAMEA_1795525492
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
X-Rspamd-Queue-Id: EA97245518
X-Spamd-Bar: --
Message-ID-Hash: 73OFSUIYD2VEU4HMZM26E6A3WCLOMCGR
X-Message-ID-Hash: 73OFSUIYD2VEU4HMZM26E6A3WCLOMCGR
X-MailFrom: aesteve@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: airlied@gmail.com, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, Albert Esteve <aesteve@redhat.com>, echanude@redhat.com, mripard@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/73OFSUIYD2VEU4HMZM26E6A3WCLOMCGR/>
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

The security_current_memcg_charge_task() and
security_current_memcg_charge_cgroup() hooks allow security modules to
control which processes may charge or transfer memcg memory to another
process's cgroup, named by a pidfd, or to an arbitrary cgroup named by
a cgroupfd, both passed in charge_fd. Without a policy implementation,
either hook is a no-op and the restriction is not enforced.

On SELinux-managed systems the only limit is CAP_SYS_RESOURCE. A
domain that holds both dma-heap access (today's only exporter that
opts-in) and that capability, can charge memory to any cgroup outside
its own subtree. Since the capability is all-or-nothing, SELinux
policy cannot express which targets such a domain may charge to.

Implement both selinux_memcg_charge_task() and
selinux_memcg_charge_cgroup() using avc_has_perm() with a new cgroup
object class and a new charge_to permission. Both charge_fd flavours
ultimately charge a cgroup, so one permission covers them and the
target type keeps the distinction: for the pidfd path the target is
the referred task's SID, as there is no cgroup object to take a label
from; for the cgroupfd path it is the cgroup directory's inode SID,
which comes from the genfscon entry for cgroupfs unless the directory
is relabeled.

The checks run when the charge target is resolved, before the
CAP_SYS_RESOURCE baseline is evaluated, and apply to every explicit
charge_fd target, including the caller's own subtree, so policy needs
a rule even for self-charging. Policy authors can then grant
cross-cgroup charging selectively, for example:

  allow allocator_app_t client_app_t:cgroup charge_to;
  allow allocator_app_t cgroup_t:cgroup charge_to;

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 security/selinux/hooks.c            | 19 +++++++++++++++++++
 security/selinux/include/classmap.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6c4c64d6e904..76a714107ae4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2204,6 +2204,23 @@ static int selinux_capable(const struct cred *cred, struct user_namespace *ns,
 	return cred_has_capability(cred, cap, opts, ns == &init_user_ns);
 }
 
+static int selinux_memcg_charge_task(const struct cred *to)
+{
+	const struct cred *cred = current_cred();
+
+	return avc_has_perm(cred_sid(cred), cred_sid(to),
+			    SECCLASS_CGROUP, CGROUP__CHARGE_TO, NULL);
+}
+
+static int selinux_memcg_charge_cgroup(const struct file *file)
+{
+	const struct cred *cred = current_cred();
+	struct inode_security_struct *isec = inode_security(file_inode(file));
+
+	return avc_has_perm(cred_sid(cred), isec->sid, SECCLASS_CGROUP,
+			    CGROUP__CHARGE_TO, NULL);
+}
+
 static int selinux_quotactl(int cmds, int type, int id, const struct super_block *sb)
 {
 	const struct cred *cred = current_cred();
@@ -7683,6 +7700,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capget, selinux_capget),
 	LSM_HOOK_INIT(capset, selinux_capset),
 	LSM_HOOK_INIT(capable, selinux_capable),
+	LSM_HOOK_INIT(memcg_charge_task, selinux_memcg_charge_task),
+	LSM_HOOK_INIT(memcg_charge_cgroup, selinux_memcg_charge_cgroup),
 	LSM_HOOK_INIT(quotactl, selinux_quotactl),
 	LSM_HOOK_INIT(quota_on, selinux_quota_on),
 	LSM_HOOK_INIT(syslog, selinux_syslog),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 90cb61b16425..1f1f2fc4d35d 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -181,6 +181,7 @@ const struct security_class_mapping secclass_map[] = {
 	{ "user_namespace", { "create", NULL } },
 	{ "memfd_file",
 	  { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } },
+	{ "cgroup", { "charge_to", NULL } },
 	/* last one */ { NULL, {} }
 };
 

-- 
2.55.0

