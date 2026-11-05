Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F23606A31B
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=gNFhV9E+;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFtPRv+v
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 490D5454CA
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 21:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793913096;
	bh=2RLQC1bSA3UhuwZbggzNroMh6l6JITaynZarCSoVuAM=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=gNFhV9E+lyvbzdQyoRse/Ww/njr9KhiroBkooFnXrhglsJ+QNwR7zscBgJiEkNrYJ
	 ACpIwq8fY0dPcIutlGSzFe2tA0GakGe0qeHmteTIRKakRtIFuA754L1kFS+NprZ/9R
	 aWW299UkaUUr/5aiRDSHCPAxFwygci9MjAlir+00flv7DoKI3CukC85PQkdyeGvqOt
	 vawZ9oO1L7KYx7+QZ7FRl+c1IYpuaKGniFILo4EPdNAnrYch5P2KV7EXuIWTeCKY/b
	 /K8TW0mpQVLB4NOFJEvdi53oVNPBNz47Dv8Kv3fOnLYj/FSGI1f1XHnYZpbfRRoCXH
	 uKRKqMo8lJ6Lw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EB9A4454DB
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 21:08:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFtPRv+v;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AF7D360A63;
	Thu,  5 Nov 2026 21:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DED61F008BD;
	Thu,  5 Nov 2026 21:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793912896;
	bh=RBvzqqEVktGOwLM5OpYBfN5N4ekxKtBbieuNh5yiCZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kFtPRv+vDCqA4I5+7Ba5v1oinPquBwNlu0qv3u1pswQ05uBi8FuxynMX1Au0gqEq1
	 GNXzlN8uFqSJSkJeLpBlJWDZzthZT1QYCXHTFJpJfWyomWsTXudAv/0qXIrV+l9VV5
	 VF2TBnLkW7OziZTahtTdvm/Fn5QH8mhXKLp8QhXY0Hyb/snkD00bpMyAE1rQGFuYCw
	 ngKcgCmFZhysfGBUK8uVX24hJfLxdMi0u0jCBy+ukszMXCOfZPfMf+Kqm78OIzM0tn
	 RxPiN2jic03BG/QtPw6o+SbdcC1jd9rBy5GjZqyDDQ8JEFbdtYwrd4ZQ7qVlg2U+Ut
	 GK2nqGNNO/c5g==
Date: Thu, 05 Nov 2026 21:05:42 +0000
Subject: [PATCH 11/14] tee: convert shm mmap hook to mmap_prepare
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-late-2026-mmap_prepare-v1-11-c56aadfbab8a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686; i=ljs@kernel.org;
 h=from:subject:message-id; bh=2RLQC1bSA3UhuwZbggzNroMh6l6JITaynZarCSoVuAM=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLevF/zLjZTWyx1cX6TOl+BpvzBu+qXr/bqSR+fKzhJ4
 VdhWI5PRykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACZS68PIcLlhWdCvuI8njsvz
 mpsrWjeVPPbtMH501Wkee5q85d6Dpgz/M7corpQ8r5YdLpejWb5uisP052unmkTtMXCZ9+B2usA
 hdgA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.20 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[100.00%];
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
X-Rspamd-Queue-Id: EB9A4454DB
X-Spamd-Bar: --------
Message-ID-Hash: 4S6LUT2Z5T4T2BHMXPGMKHADSALKUSBJ
X-Message-ID-Hash: 4S6LUT2Z5T4T2BHMXPGMKHADSALKUSBJ
X-MailFrom: ljs@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: ljs@kernel.org, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4S6LUT2Z5T4T2BHMXPGMKHADSALKUSBJ/>
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

Move from the deprecated mmap hook to the new mmap_prepare hook, using the
PFN remap mmap action to map the shared memory.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 drivers/tee/tee_shm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index daa4af1e089e..8fcbf0232aeb 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -567,10 +567,9 @@ static int tee_shm_fop_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static int tee_shm_fop_mmap(struct file *filp, struct vm_area_struct *vma)
+static int tee_shm_fop_mmap_prepare(struct vm_area_desc *desc)
 {
-	struct tee_shm *shm = filp->private_data;
-	size_t size = vma->vm_end - vma->vm_start;
+	struct tee_shm *shm = desc->file->private_data;
 
 	/* Refuse sharing shared memory provided by application */
 	if (shm->flags & TEE_SHM_USER_MAPPED)
@@ -580,17 +579,18 @@ static int tee_shm_fop_mmap(struct file *filp, struct vm_area_struct *vma)
 		return -EINVAL;
 
 	/* check for overflowing the buffer's size */
-	if (vma->vm_pgoff + vma_pages(vma) > shm->size >> PAGE_SHIFT)
+	if (desc->pgoff + vma_desc_pages(desc) > shm->size >> PAGE_SHIFT)
 		return -EINVAL;
 
-	return remap_pfn_range(vma, vma->vm_start, shm->paddr >> PAGE_SHIFT,
-			       size, vma->vm_page_prot);
+	mmap_action_remap_full(desc, shm->paddr >> PAGE_SHIFT);
+
+	return 0;
 }
 
 static const struct file_operations tee_shm_fops = {
 	.owner = THIS_MODULE,
 	.release = tee_shm_fop_release,
-	.mmap = tee_shm_fop_mmap,
+	.mmap_prepare = tee_shm_fop_mmap_prepare,
 };
 
 /**

-- 
2.56.0

