Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C12606EEAA
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=V5q8XYn8;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyoADFGo
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 48AA1454B7
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 21:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793912896;
	bh=f+7KpJr4q75MSHX3Bd7fDuPR7a/rNIIIf/bMN+NEgYc=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=V5q8XYn8qMw2o4O2vvNHwSOYDWE0+m+1SUl7Eo3q9y9vJpv5nNiM9VBTMzmny9EL8
	 JbjT2VMh/v6ZkhJitpzxuRLR3Ln7hX3anAeQAy4WCrPKOS2QzfLMWXP5snRfNZgcq8
	 rMXNixjV0rDLQ9Cp1ALAY1EQhu1emjBaSaxhnfTYcgglQCFWmSCj7Gf+TnNAt4q3Yb
	 532FOsKm+GIMnvmuoHEe0ZO+hqP8MLnK9Pxp1J+Y/sJhXe5zcR+T5Pgw9Shi9gG7uf
	 b4MFdaNRSxiTVqRSDokKN9Zk1/SR6uw9ta6MWKVutqaGGqqBlFvTdRlCcqbnYaVxpS
	 V4VCfoX7jStxw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id F1935454C6
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 21:06:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyoADFGo;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B47AC605F7;
	Thu,  5 Nov 2026 21:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70931F008A2;
	Thu,  5 Nov 2026 21:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793912810;
	bh=lMfCHuJWDITAzVX5MILlRUAfVtlxLQX6U8OJOyztS0Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hyoADFGoZhaTWJkzXcW3KcbEavv04p8OShbOv92vBdUSDNLHC33p5UKp1V2NVcrld
	 kDlm4+Dh0N0ewg6c+CsYgrDJ3ZyQfeLnEMeGuWWhUOa1JWAqXOF3EIa9dU7hEYQurC
	 UD8uUTqIpkS8973AB0tlJQaOj0TVHyTL25qiKUL5PD3kHvTGhvyIEbBHKWXDn6uHka
	 RoxnfP2r7Ju1UsLJ3jtzSicq0aWOqHOlTJAt5o8ROmzR1tSO11ZVBsg+5OZeT4rkNp
	 9MHuwVurtm4FxobT/XptLLk7AHWfQIwdo04JpdFyuH/BI40j4CP1PTKjHXSsUS4XXm
	 oJDzW5rZ2ElnQ==
Date: Thu, 05 Nov 2026 21:05:35 +0000
Subject: [PATCH 04/14] vduse: convert IOVA domain mmap hook to mmap_prepare
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-late-2026-mmap_prepare-v1-4-c56aadfbab8a@kernel.org>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
To: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
 Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
 Scott Branden <scott.branden@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Richard Cochran <richardcochran@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527; i=ljs@kernel.org;
 h=from:subject:message-id; bh=f+7KpJr4q75MSHX3Bd7fDuPR7a/rNIIIf/bMN+NEgYc=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLevF8du8y356wo75UohnvW1WmG2azZxoEG9l+mvHw8c
 ZHxmh0fOkpZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCRiBOMDB0R1y2sCsxZCz9d
 WmjgP+cKZ4HBz+NXpWMcv1wV1woTUGNk+FWtznBzgiPz5WrBrQefRpSzaacb3N2dE78n6eYhful
 ubgA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.20 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	RCVD_IN_DNSWL_MED(-0.20)[172.105.4.254:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[suse.com,kernel.org,epam.com,linux.ibm.com,gmail.com,ellerman.id.au,microsoft.com,redhat.com,linux.alibaba.com,linux.intel.com,alien8.de,zytor.com,paul-moore.com,jms.id.au,codeconstruct.com.au,aspeedtech.com,broadcom.com,arndb.de,linuxfoundation.org,infradead.org,lunn.ch,davemloft.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[61];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: F1935454C6
X-Spamd-Bar: --------
Message-ID-Hash: RU6MJJCGMOJCZTMI4KNHBK2W5272SFBH
X-Message-ID-Hash: RU6MJJCGMOJCZTMI4KNHBK2W5272SFBH
X-MailFrom: ljs@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: ljs@kernel.org, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RU6MJJCGMOJCZTMI4KNHBK2W5272SFBH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: "Lorenzo Stoakes (ARM) via OP-TEE" <op-tee@lists.trustedfirmware.org>
Reply-To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move from the deprecated mmap hook to the new mmap_prepare hook. The hook
only sets VMA flags, operations and private data.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index b6c958224b7c..64465f690a4d 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -575,13 +575,13 @@ static const struct vm_operations_struct vduse_domain_mmap_ops = {
 	.fault = vduse_domain_mmap_fault,
 };
 
-static int vduse_domain_mmap(struct file *file, struct vm_area_struct *vma)
+static int vduse_domain_mmap_prepare(struct vm_area_desc *desc)
 {
-	struct vduse_iova_domain *domain = file->private_data;
+	struct vduse_iova_domain *domain = desc->file->private_data;
 
-	vm_flags_set(vma, VM_DONTDUMP | VM_DONTEXPAND);
-	vma->vm_private_data = domain;
-	vma->vm_ops = &vduse_domain_mmap_ops;
+	vma_desc_set_flags(desc, VMA_DONTDUMP_BIT, VMA_DONTEXPAND_BIT);
+	desc->private_data = domain;
+	desc->vm_ops = &vduse_domain_mmap_ops;
 
 	return 0;
 }
@@ -606,7 +606,7 @@ static int vduse_domain_release(struct inode *inode, struct file *file)
 
 static const struct file_operations vduse_domain_fops = {
 	.owner = THIS_MODULE,
-	.mmap = vduse_domain_mmap,
+	.mmap_prepare = vduse_domain_mmap_prepare,
 	.release = vduse_domain_release,
 };
 

-- 
2.56.0

