Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAE0606A33D
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 21:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=cPHOcLwW;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWekXUJt
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5DFEA454D6
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 21:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793912924;
	bh=8M6KXM/gidl407BgZsE6l9e639j02CBQooR3iZ5mU4M=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=cPHOcLwWbF1fdG7sgKk1RHapP/sDir4xLjrOP2nKQAzHUvm4io3Xjmlp10pc4GBT7
	 nTkAUbaURGUI3KK1Kr7JjX+2UPMni6vp+oyQh7hNHBrmXwUGFa53IrYlK0jU4T5d3q
	 RSI4uNZvkm4VgHk3pmRsC9GNSBg9fSL8oqwjonyxmLBqqAL9RQ8lUDuif30HBBarLJ
	 r8EANv9UGEVWE+u63qmGMubbRg1WZabw/skKm5fEuZAkTmpkrWfFhsXqcNlift99uw
	 O4QjEH9BGP+XI4HVePW1cW/O1lQiZhjFPixZi47hAJdUAI2UhRxFwuqE6qR+3Z53Wa
	 BdJ9NNIw1fqjA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 958F8454C8
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 21:07:03 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWekXUJt;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EA5EB43E17;
	Thu,  5 Nov 2026 21:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073691F008A6;
	Thu,  5 Nov 2026 21:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793912822;
	bh=bqfQWE9INck3Aoq42ZNpSathvk4p8fmQAVJsjbZAm0g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GWekXUJtTW/bmKiTy4QB6lwJ7qbgw7vFuwUU+DOaOfg/TRAzLeM32R3kLak4qQeQ3
	 Qv4vJ9ieuL7oXsySpCaty+GruAFXFHyboa49jWYOSQ5CvYOGpKEnZ4EVlYgXyECMBV
	 SAYyovNMBS/4DJV9jvSExBs04MC2Ny8P8JjIrR64zZOycDnouZr851hmFFOt4+wNVA
	 fPiv0XZG2hDHC8h3Gwkazyekp82IqzHvmXnmVgCZg0iO26M0dmBWKapLrfZusp9wwT
	 zzsZcWlKHFiQMAFkueAeuPV0PQFvmCrLb3vSKAp9PJu0JxbVW/FD9XwOTh2SLxX8iP
	 /o3UyJrfNU3sg==
Date: Thu, 05 Nov 2026 21:05:36 +0000
Subject: [PATCH 05/14] x86/sgx: convert vepc mmap hook to mmap_prepare
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-late-2026-mmap_prepare-v1-5-c56aadfbab8a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1666; i=ljs@kernel.org;
 h=from:subject:message-id; bh=8M6KXM/gidl407BgZsE6l9e639j02CBQooR3iZ5mU4M=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLevF/NfkpnyQUdw7u/LIOuqb1l2agTvF3TyPxd3+spl
 1Y3rn9v1lHKwiDGxSArpsjy/Iv4/iCRsHmdF/zdYOawMoEMYeDiFICJyAcx/NONOFpeGCnRO6e7
 +3T/k1zGsxF7YoO6TcO7Xjvq/jC+sIuRocFi0+uncd+Ew6Qit/5Nqt5kFnHQtvGp8hbW+Lk53Av
 lmAA=
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
X-Rspamd-Queue-Id: 958F8454C8
X-Spamd-Bar: --------
Message-ID-Hash: YN4JWOI6KLBPXSBNAAVO7IUDNFABUKIV
X-Message-ID-Hash: YN4JWOI6KLBPXSBNAAVO7IUDNFABUKIV
X-MailFrom: ljs@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: ljs@kernel.org, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YN4JWOI6KLBPXSBNAAVO7IUDNFABUKIV/>
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
only checks that the mapping is shared and sets VMA flags, operations and
private data.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/x86/kernel/cpu/sgx/virt.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index 6a1933ddc6fc..850990519ca5 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -98,17 +98,18 @@ static const struct vm_operations_struct sgx_vepc_vm_ops = {
 	.fault = sgx_vepc_fault,
 };
 
-static int sgx_vepc_mmap(struct file *file, struct vm_area_struct *vma)
+static int sgx_vepc_mmap_prepare(struct vm_area_desc *desc)
 {
-	struct sgx_vepc *vepc = file->private_data;
+	struct sgx_vepc *vepc = desc->file->private_data;
 
-	if (!(vma->vm_flags & VM_SHARED))
+	if (!vma_desc_test(desc, VMA_SHARED_BIT))
 		return -EINVAL;
 
-	vma->vm_ops = &sgx_vepc_vm_ops;
+	desc->vm_ops = &sgx_vepc_vm_ops;
 	/* Don't copy VMA in fork() */
-	vm_flags_set(vma, VM_PFNMAP | VM_IO | VM_DONTDUMP | VM_DONTCOPY);
-	vma->vm_private_data = vepc;
+	vma_desc_set_flags(desc, VMA_PFNMAP_BIT, VMA_IO_BIT, VMA_DONTDUMP_BIT,
+			   VMA_DONTCOPY_BIT);
+	desc->private_data = vepc;
 
 	return 0;
 }
@@ -315,7 +316,7 @@ static const struct file_operations sgx_vepc_fops = {
 	.unlocked_ioctl	= sgx_vepc_ioctl,
 	.compat_ioctl	= sgx_vepc_ioctl,
 	.release	= sgx_vepc_release,
-	.mmap		= sgx_vepc_mmap,
+	.mmap_prepare	= sgx_vepc_mmap_prepare,
 };
 
 static struct miscdevice sgx_vepc_dev = {

-- 
2.56.0

