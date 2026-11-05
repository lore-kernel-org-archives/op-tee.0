Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A14606A326
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=cLjkssye;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QWUcIhBC
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7DE6A454C6
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 21:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793913152;
	bh=BtWkGlsdqRPyaFO3thb1+okxq61by8V/MZsK3ybf8bQ=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=cLjkssyeLhanuZkkuLiIgHLtDF4MRAsBVwY85Hk+rSsad25VQpAV0kjSWG2tM1z+Y
	 Oh0dPOex9HHzJgoskL3h9P7hvo8x68AxW8fcA3Q1M2ElMMuxCB6W7qVofJM5O30LdZ
	 ASOSgYo4ZwNTczQN6Tb5+Lx/N9r8y+jN5Ww8eJywt5Sv1Mjng25UbgzFT3XR+y55CN
	 R8sbdTM/dQTYtcXtyip2+whfVxM+SqABwdBG0lFlkUH2dYIL+ixJIeBCse8ImG90vQ
	 iDGn7co5EBnkveuUL6b7kY7tLZFNwK5YFv+J+xm6YfG/ICMABX4T/2WrIVxrAK6cbb
	 tIQo+PIlOc2nA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 67DC4454BD
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 21:08:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QWUcIhBC;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 28EDF60213;
	Thu,  5 Nov 2026 21:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4791F0089F;
	Thu,  5 Nov 2026 21:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793912920;
	bh=jwg42VGqWUt+sFFBng+mWbW24dAsrwHOUVsOhHWbSTw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QWUcIhBCGRma05CYBvlYAlcfi/meLWyeZtyVRMCsgC3eidcnSypogMH20WwSI92Vo
	 nUGOi0jOdOYQqRYbLuOn/e0wcApgbleVdCLsQVo3EKEbJwqtnb3wGYHGhtB20rZjFf
	 9cjWxmaAFDIk2PBAlcaRnTwCrwWQltxESQCDifUxijmFVrqzmV2MXoVZMTDDrJXm3G
	 3PjQF3mPdpLpyAUsd37oELANXqbeLiCVaA1MHfyYV/F300h88r1ZwlODccLQGzTUET
	 2T2/8rqNR+g7IR+53ri5dnAH76IBDmer8fSCNE/o5xkxllHyUDCt6gi9PZAsjUiLhR
	 fpGgLWaXY4uuQ==
Date: Thu, 05 Nov 2026 21:05:44 +0000
Subject: [PATCH 13/14] ptp: vmclock: convert mmap hook to mmap_prepare
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-late-2026-mmap_prepare-v1-13-c56aadfbab8a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2068; i=ljs@kernel.org;
 h=from:subject:message-id; bh=BtWkGlsdqRPyaFO3thb1+okxq61by8V/MZsK3ybf8bQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLevF8b8Ux/Tdcunl1xE7s19f5O+zJ7caTksSU+544kX
 NlyL3Eyb0cpC4MYF4OsmCLL8y/i+4NEwuZ1XvB3g5nDygQyhIGLUwAmkviF4X/5tD9fZqudmJGc
 eDXc+YjW+oBjJk1fYudKmvfOKpRJm3mE4a+0h0vYimsND/h+/73g4/Cy0C26a9UBpbxFppN2bn7
 cZ80GAA==
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
X-Rspamd-Queue-Id: 67DC4454BD
X-Spamd-Bar: --------
Message-ID-Hash: LFJRL6YV46XQYYI3B2CMBSWEY3SNMWLX
X-Message-ID-Hash: LFJRL6YV46XQYYI3B2CMBSWEY3SNMWLX
X-MailFrom: ljs@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: ljs@kernel.org, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LFJRL6YV46XQYYI3B2CMBSWEY3SNMWLX/>
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
I/O PFN remap mmap action to map the clock page and retaining the -EAGAIN
error on failure via the action error override.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 drivers/ptp/ptp_vmclock.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index bb0e14bac9f2..e44433430044 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -364,27 +364,26 @@ struct vmclock_file_state {
 	atomic_t seq;
 };
 
-static int vmclock_miscdev_mmap(struct file *fp, struct vm_area_struct *vma)
+static int vmclock_miscdev_mmap_prepare(struct vm_area_desc *desc)
 {
-	struct vmclock_file_state *fst = fp->private_data;
+	struct vmclock_file_state *fst = desc->file->private_data;
 	struct vmclock_state *st = fst->st;
 
-	if ((vma->vm_flags & (VM_READ|VM_WRITE)) != VM_READ)
+	if (!vma_desc_test(desc, VMA_READ_BIT) ||
+	    vma_desc_test(desc, VMA_WRITE_BIT))
 		return -EROFS;
 
 	/*
 	 * Restrict the read-only mapping so it cannot be upgraded to
 	 * writable later with mprotect().
 	 */
-	vm_flags_clear(vma, VM_MAYWRITE);
+	vma_desc_clear_flags(desc, VMA_MAYWRITE_BIT);
 
-	if (vma->vm_end - vma->vm_start != PAGE_SIZE || vma->vm_pgoff)
+	if (vma_desc_size(desc) != PAGE_SIZE || desc->pgoff)
 		return -EINVAL;
 
-	if (io_remap_pfn_range(vma, vma->vm_start,
-			       st->res.start >> PAGE_SHIFT, PAGE_SIZE,
-			       vma->vm_page_prot))
-		return -EAGAIN;
+	mmap_action_ioremap_full(desc, st->res.start >> PAGE_SHIFT);
+	desc->action.error_override = -EAGAIN;
 
 	return 0;
 }
@@ -484,7 +483,7 @@ static const struct file_operations vmclock_miscdev_fops = {
 	.owner = THIS_MODULE,
 	.open = vmclock_miscdev_open,
 	.release = vmclock_miscdev_release,
-	.mmap = vmclock_miscdev_mmap,
+	.mmap_prepare = vmclock_miscdev_mmap_prepare,
 	.read = vmclock_miscdev_read,
 	.poll = vmclock_miscdev_poll,
 };

-- 
2.56.0

