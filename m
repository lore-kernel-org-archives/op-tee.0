Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B7D60A2610
	for <op-tee@archiver.kernel.org>; Tue, 24 Nov 2026 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=mRqr/ID8;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PNip109e
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EEBDC456E6
	for <op-tee@archiver.kernel.org>; Tue, 24 Nov 2026 14:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795529328;
	bh=dRLES62L0oNx/h8n7oOxCXbdn7WuTRK+ZkJqntS+Ejg=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=mRqr/ID8vlXk4/e8aVumCJtX1Tdh9E/8pqKrOA5trs8dJl4RgFcEJDAozGvYqwBNI
	 n/IugvLcNo53i9Xu7W+KO+fLG954sFccO4/nXEOQTHGCH4sUtwdl+zWtH7D5CHeG4N
	 Z/sIH+Yi+2T3IhFFsWRP45MZMMH01fZWPJzB69VL8rtpQCSs2dZBL2Cga0TFMsHFxM
	 A7ZBZEs9ptLgK2xL3pQjxf+l4lmGZzcdAiOf4mtAvFpI5aW8/KUbQqdBmU4xHNhRjO
	 RJr15czkNOu7UiiT/7r7mrSD3RnAtEGnOKCG9Wm1NoDZGABZiLl0sq2FYUtu2DDVvr
	 7pmafk2yMpQaA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0F74F5035A
	for <op-tee@lists.trustedfirmware.org>; Tue, 24 Nov 2026 14:06:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PNip109e;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6863040755;
	Tue, 24 Nov 2026 14:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C24F1F000F0;
	Tue, 24 Nov 2026 14:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795529177;
	bh=7FUmabyr4uQL+774Pvtn0Hclc0nu9L2r9AtaFETc/GA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PNip109e1v8AW41xU7g1LBDLiTkaFRP8f4lZPkWTaQTZjRjFkQGMj8SHSlPBNZ2hH
	 laeFtadOphJlM/Zu0+Ptde0v4sw3DIojGjlR2m3Qeu4CzKMRUAYso+tGP3tNzqdpUU
	 3sU6lzTKuQWYqrxkL5hORf1O/+Hd+Wm4c8OvqIXcRd+ed0pWiVLiUh9729Yx9jx6Fi
	 dgXnxqAfIA8dZQ6o3EwPJ+IUCAlYnXIx9hj5ELXrFUEkSnPqlONUQf1SpQ6qeJt9wO
	 D7Z8L5+AC0tRE+/U+WmavqRwYF54su3iDaH7Xb22dOtX1vDC/N8NGim9zMmqD/7g1W
	 xIohsVS5dOzsw==
Date: Tue, 24 Nov 2026 14:02:54 +0000
Subject: [PATCH v2 11/13] misc: bcm-vk: convert mmap hook to mmap_prepare
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-late-2026-mmap_prepare-v2-11-0b0d99d655f9@kernel.org>
References: <20261124-late-2026-mmap_prepare-v2-0-0b0d99d655f9@kernel.org>
In-Reply-To: <20261124-late-2026-mmap_prepare-v2-0-0b0d99d655f9@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
 Juergen Gross <jgross@suse.com>,
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2129; i=ljs@kernel.org;
 h=from:subject:message-id; bh=dRLES62L0oNx/h8n7oOxCXbdn7WuTRK+ZkJqntS+Ejg=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZZ0rUZakxBThbH2CZem92EdvkV4oicReY36/xvsBfp
 jlz6+lPHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZjI0nBGho3CNY3Z605Z/zPu
 KRDaKl1vlbg8hjs3tHkrV62rTZVdHSPDdePvS9YekA+OrkzRyBNLVHkfcy3a4bNpv8ypohR7gQP
 sAA==
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	RCVD_IN_DNSWL_MED(-0.20)[172.234.252.31:from];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,suse.com,kernel.org,epam.com,linux.ibm.com,gmail.com,ellerman.id.au,microsoft.com,redhat.com,linux.alibaba.com,linux.intel.com,alien8.de,zytor.com,paul-moore.com,jms.id.au,codeconstruct.com.au,aspeedtech.com,broadcom.com,arndb.de,linuxfoundation.org,infradead.org,lunn.ch,davemloft.net];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[63];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0F74F5035A
X-Spamd-Bar: --------
Message-ID-Hash: ARL24JLBQ6RL5ESWJP7BVS76QRIXLSYC
X-Message-ID-Hash: ARL24JLBQ6RL5ESWJP7BVS76QRIXLSYC
X-MailFrom: ljs@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: ljs@kernel.org, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ARL24JLBQ6RL5ESWJP7BVS76QRIXLSYC/>
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
I/O PFN remap mmap action to map the BAR.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 drivers/misc/bcm-vk/bcm_vk_dev.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index 88ee3a417616..25a2b46ebad9 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1201,9 +1201,9 @@ static long bcm_vk_reset(struct bcm_vk *vk, struct vk_reset __user *arg)
 	return ret;
 }
 
-static int bcm_vk_mmap(struct file *file, struct vm_area_struct *vma)
+static int bcm_vk_mmap_prepare(struct vm_area_desc *desc)
 {
-	struct bcm_vk_ctx *ctx = file->private_data;
+	struct bcm_vk_ctx *ctx = desc->file->private_data;
 	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk, miscdev);
 	unsigned long pg_size;
 
@@ -1212,16 +1212,16 @@ static int bcm_vk_mmap(struct file *file, struct vm_area_struct *vma)
 
 	pg_size = ((pci_resource_len(vk->pdev, VK_MMAPABLE_BAR) - 1)
 		    >> PAGE_SHIFT) + 1;
-	if (vma->vm_pgoff + vma_pages(vma) > pg_size)
+	if (desc->pgoff + vma_desc_pages(desc) > pg_size)
 		return -EINVAL;
 
-	vma->vm_pgoff += (pci_resource_start(vk->pdev, VK_MMAPABLE_BAR)
-			  >> PAGE_SHIFT);
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	desc->pgoff += (pci_resource_start(vk->pdev, VK_MMAPABLE_BAR)
+			>> PAGE_SHIFT);
+	desc->page_prot = pgprot_noncached(desc->page_prot);
+
+	mmap_action_ioremap_full(desc, desc->pgoff);
 
-	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-				  vma->vm_end - vma->vm_start,
-				  vma->vm_page_prot);
+	return 0;
 }
 
 static long bcm_vk_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -1262,7 +1262,7 @@ static const struct file_operations bcm_vk_fops = {
 	.write = bcm_vk_write,
 	.poll = bcm_vk_poll,
 	.release = bcm_vk_release,
-	.mmap = bcm_vk_mmap,
+	.mmap_prepare = bcm_vk_mmap_prepare,
 	.unlocked_ioctl = bcm_vk_ioctl,
 };
 

-- 
2.56.1

