Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C8D606A331
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=uqskpXoy;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EoGQCLGY
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6E473454C6
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 21:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793912981;
	bh=7PdtcPjX+tywnOn8AbMVtXCWtyiPBNa3B2xUfxFmHH4=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=uqskpXoykB3ckxDtw7KR+uCoRY1WdTsPJb1i443MRT0z+Ap/8EHkP9k/Ufgmhjze4
	 g42X2Uz5LTmYbmOHL9HOA5SCClXs+1EOfgomDL26zs8QoCLeKgnvd59m8zGPwmiipY
	 UAN8yA81tyk5QZfuMtVnwtAYn85OrIw2d7d7zNcbRr7fbAU/S2cBpOLXwMVbRuEOZW
	 PD5Yw40wF4Xag+1mZ3An7hM0JVRGwYgWh/RcU284a344xRWPjDmxR38x1HpldPV/69
	 yhtpNGJehmgCpYEeAfMQHukdSBr7OIqt2D8mrliEVo7vdXJWkaJM34SLJGBo2psQFg
	 PEGKrOXix976Q==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id F0373454C0
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 21:07:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EoGQCLGY;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 698154379E;
	Thu,  5 Nov 2026 21:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8983A1F0089F;
	Thu,  5 Nov 2026 21:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793912847;
	bh=K0Qe+brxG+0dZUrKAAGrAFU8X9IZH0VVnpzTIvw3ERA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EoGQCLGYUECuMK3Ryy2JPZD867vm1Nft2NyWWjYZH04COu4EW/n19poNq9sBYoVuM
	 /9L6U4I6ZY4vXlCPISOuIqoBB5h83vy6AzZrs2irL36W/r0sB/qf1ZvlmEqaeHCR98
	 Yd2HoEORahKhAsOB/TOKoJBhF5tSUb+5it9H8lS7Qhw6Evt7ES6t9E6Hi7+ZQqGPV/
	 km0fScYDuEqdFgtcf7u8IrOQsq2bqZdZcBr9xB/YyRxrFVrgKBphzww0dpecuBV/gD
	 cN1u7CBvszdIwDETsVYy/2zHoypyOCESC6YkymFo3ap/d8M1X84ZFUtyFwrTw/eilV
	 jjk9dx2yFMCwQ==
Date: Thu, 05 Nov 2026 21:05:38 +0000
Subject: [PATCH 07/14] selinuxfs: convert mmap hooks to mmap_prepare
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-late-2026-mmap_prepare-v1-7-c56aadfbab8a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2606; i=ljs@kernel.org;
 h=from:subject:message-id; bh=7PdtcPjX+tywnOn8AbMVtXCWtyiPBNa3B2xUfxFmHH4=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLevF/TIhScFGkt26v86da3Ox+Yv91Wnrv55exlR5/1b
 3xS+CHGoqOUhUGMi0FWTJHl+Rfx/UEiYfM6L/i7wcxhZQIZwsDFKQATWbaV4Z/R5fMFHr++HXFy
 /Ffm97i/eD5f7pGnC1lXqB4L2nOKY1YTw/9ss1+Cbkvu1sn7vT0cwLOC8VqV2dR7TXeLg2ew97/
 Z5cYPAA==
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	RCVD_IN_DNSWL_MED(-0.20)[172.234.252.31:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[suse.com,kernel.org,epam.com,linux.ibm.com,gmail.com,ellerman.id.au,microsoft.com,redhat.com,linux.alibaba.com,linux.intel.com,alien8.de,zytor.com,paul-moore.com,jms.id.au,codeconstruct.com.au,aspeedtech.com,broadcom.com,arndb.de,linuxfoundation.org,infradead.org,lunn.ch,davemloft.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: F0373454C0
X-Spamd-Bar: --------
Message-ID-Hash: RHX3BF7T54OMAEI26EKASNXGYLRXX4QC
X-Message-ID-Hash: RHX3BF7T54OMAEI26EKASNXGYLRXX4QC
X-MailFrom: ljs@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: ljs@kernel.org, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RHX3BF7T54OMAEI26EKASNXGYLRXX4QC/>
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

Move from the deprecated mmap hook to the new mmap_prepare hook for the
policy and status files.

The policy file only sets VMA flags and operations. The status file remaps
a single page, so use the PFN remap mmap action to do so.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 security/selinux/selinuxfs.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 310e19efff1d..e78c65685020 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -236,27 +236,25 @@ static ssize_t sel_read_handle_status(struct file *filp, char __user *buf,
 				       sizeof(struct selinux_kernel_status));
 }
 
-static int sel_mmap_handle_status(struct file *filp,
-				  struct vm_area_struct *vma)
+static int sel_mmap_prepare_handle_status(struct vm_area_desc *desc)
 {
-	struct page    *status = filp->private_data;
-	unsigned long	size = vma->vm_end - vma->vm_start;
+	struct page    *status = desc->file->private_data;
 
 	BUG_ON(!status);
 
 	/* only allows one page from the head */
-	if (vma->vm_pgoff > 0 || size != PAGE_SIZE)
+	if (desc->pgoff > 0 || vma_desc_size(desc) != PAGE_SIZE)
 		return -EIO;
 
-	return remap_pfn_range(vma, vma->vm_start,
-			       page_to_pfn(status),
-			       size, vma->vm_page_prot);
+	mmap_action_remap_full(desc, page_to_pfn(status));
+
+	return 0;
 }
 
 static const struct file_operations sel_handle_status_ops = {
 	.open		= sel_open_handle_status,
 	.read		= sel_read_handle_status,
-	.mmap		= sel_mmap_handle_status,
+	.mmap_prepare	= sel_mmap_prepare_handle_status,
 	.llseek		= generic_file_llseek,
 };
 
@@ -419,10 +417,10 @@ static const struct vm_operations_struct sel_mmap_policy_ops = {
 	.page_mkwrite = sel_mmap_policy_fault,
 };
 
-static int sel_mmap_policy(struct file *filp, struct vm_area_struct *vma)
+static int sel_mmap_prepare_policy(struct vm_area_desc *desc)
 {
-	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
-	vma->vm_ops = &sel_mmap_policy_ops;
+	vma_desc_set_flags(desc, VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT);
+	desc->vm_ops = &sel_mmap_policy_ops;
 
 	return 0;
 }
@@ -430,7 +428,7 @@ static int sel_mmap_policy(struct file *filp, struct vm_area_struct *vma)
 static const struct file_operations sel_policy_ops = {
 	.open		= sel_open_policy,
 	.read		= sel_read_policy,
-	.mmap		= sel_mmap_policy,
+	.mmap_prepare	= sel_mmap_prepare_policy,
 	.release	= sel_release_policy,
 	.llseek		= generic_file_llseek,
 };

-- 
2.56.0

