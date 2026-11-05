Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703E9606A31B
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=xNGjt03+;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJnEdLY/
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C4CE0454AC
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 21:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793913010;
	bh=uh2Od35/LsvovUiSJhdcBoUQz0og1zoAftz4JcEDodw=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=xNGjt03+8BD5CxBlGgsdnpv2RSmT49jF2ccaNofvWhNcj0zQ9Fb2lSQ/soLyyD3g5
	 UUqInEDWlK+k/Np8A61QXM1oIjdSry9+54ktoCSKzGPJv0r+9na+EJ4vHcmYCblQJJ
	 YxDNgukwOAB+SGRQwOKRzsehkiLPFheuSFnYYdwd3e7rXNRKm5d9qqxRbCazBoFtFX
	 LDgWBySAyGOvwJd69OoL3G6P4jtpf0piGRrn+kcM+KuxRwcf1lF9StF1kVDT91olBQ
	 Cry2QAwzu0f7re9TYtyVF4WyyZRmiQ+1yV1TCBbvbgn/c5cRcdCdieC8QrH9fstc5Z
	 8MB0uq68Qso1g==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 53014454CC
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 21:07:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJnEdLY/;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9FF3D439D4;
	Thu,  5 Nov 2026 21:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3BE1F008A2;
	Thu,  5 Nov 2026 21:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793912859;
	bh=8poJEEODdqpnj3NMXG7P61yssgyxm5Fvw3WLCRHvkPM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JJnEdLY/zYN4DtzCvHaF3aYEDTJDbnUNcVAnof1QRCeGAgIIK28vUSZ89mm0DVgQW
	 OZgvxlyxVwupAuJXa6fkzCza5MJNC5CF4+UERI+9chyH32S4KmfH+oQjkhWmNEnkdd
	 NTmlWt8u9sG20yc7yM1IhHIB4PmnviY+RktBJ2Ws3RZfCWOEYw7MPWhPLvtrNgSrJJ
	 CWHFd6q8LuEoPzf2MHgA9gMWZF6dm1M8eBYIEPRBAUhnXPyYf3T9oHdEZwrT2iaQPm
	 QADKRVvIXSwjbnMPyLbtsx5qrxDCRLncA81Gon5WQXHiJDFej/hta0SbkuIGntrRJ5
	 jkSY/KYBGfMXg==
Date: Thu, 05 Nov 2026 21:05:39 +0000
Subject: [PATCH 08/14] xen: convert xenstore interface mmap hooks to
 mmap_prepare
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-late-2026-mmap_prepare-v1-8-c56aadfbab8a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2905; i=ljs@kernel.org;
 h=from:subject:message-id; bh=uh2Od35/LsvovUiSJhdcBoUQz0og1zoAftz4JcEDodw=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLevF+TGLFqhuIqraPTpP99SytgzPSUeCxyfgWbx3LzR
 b22OlPtOkpZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCRc4EMf6WepYU9X7CEe6LH
 mj+/A6Q+9k5zOmhSeGibH4fHZZXNfb2MDIdflcc7aDTorpSZ8Pb8zNq5Hef3JWZNCZGbx8VxZPM
 tdW4A
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
X-Rspamd-Queue-Id: 53014454CC
X-Spamd-Bar: --------
Message-ID-Hash: 7E3RHRPVTTHXBRHKQLREJ32AJZDEKYQG
X-Message-ID-Hash: 7E3RHRPVTTHXBRHKQLREJ32AJZDEKYQG
X-MailFrom: ljs@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: ljs@kernel.org, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7E3RHRPVTTHXBRHKQLREJ32AJZDEKYQG/>
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
xenfs xsd_kva file and the xenbus_backend device, both of which remap the
xenstore interface page.

Use the PFN remap mmap action to do so, retaining the -EAGAIN error on
failure via the action error override.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 drivers/xen/xenbus/xenbus_dev_backend.c | 14 ++++++--------
 drivers/xen/xenfs/xenstored.c           | 14 ++++++--------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_dev_backend.c b/drivers/xen/xenbus/xenbus_dev_backend.c
index edba5fecde4d..3e4cb267f411 100644
--- a/drivers/xen/xenbus/xenbus_dev_backend.c
+++ b/drivers/xen/xenbus/xenbus_dev_backend.c
@@ -89,27 +89,25 @@ static long xenbus_backend_ioctl(struct file *file, unsigned int cmd,
 	}
 }
 
-static int xenbus_backend_mmap(struct file *file, struct vm_area_struct *vma)
+static int xenbus_backend_mmap_prepare(struct vm_area_desc *desc)
 {
-	size_t size = vma->vm_end - vma->vm_start;
+	size_t size = vma_desc_size(desc);
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if ((size > PAGE_SIZE) || (vma->vm_pgoff != 0))
+	if ((size > PAGE_SIZE) || (desc->pgoff != 0))
 		return -EINVAL;
 
-	if (remap_pfn_range(vma, vma->vm_start,
-			    virt_to_pfn(xen_store_interface),
-			    size, vma->vm_page_prot))
-		return -EAGAIN;
+	mmap_action_remap_full(desc, virt_to_pfn(xen_store_interface));
+	desc->action.error_override = -EAGAIN;
 
 	return 0;
 }
 
 static const struct file_operations xenbus_backend_fops = {
 	.open = xenbus_backend_open,
-	.mmap = xenbus_backend_mmap,
+	.mmap_prepare = xenbus_backend_mmap_prepare,
 	.unlocked_ioctl = xenbus_backend_ioctl,
 };
 
diff --git a/drivers/xen/xenfs/xenstored.c b/drivers/xen/xenfs/xenstored.c
index f59235f9f8a2..0cf57c286adb 100644
--- a/drivers/xen/xenfs/xenstored.c
+++ b/drivers/xen/xenfs/xenstored.c
@@ -31,24 +31,22 @@ static int xsd_kva_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int xsd_kva_mmap(struct file *file, struct vm_area_struct *vma)
+static int xsd_kva_mmap_prepare(struct vm_area_desc *desc)
 {
-	size_t size = vma->vm_end - vma->vm_start;
+	size_t size = vma_desc_size(desc);
 
-	if ((size > PAGE_SIZE) || (vma->vm_pgoff != 0))
+	if ((size > PAGE_SIZE) || (desc->pgoff != 0))
 		return -EINVAL;
 
-	if (remap_pfn_range(vma, vma->vm_start,
-			    virt_to_pfn(xen_store_interface),
-			    size, vma->vm_page_prot))
-		return -EAGAIN;
+	mmap_action_remap_full(desc, virt_to_pfn(xen_store_interface));
+	desc->action.error_override = -EAGAIN;
 
 	return 0;
 }
 
 const struct file_operations xsd_kva_file_ops = {
 	.open = xsd_kva_open,
-	.mmap = xsd_kva_mmap,
+	.mmap_prepare = xsd_kva_mmap_prepare,
 	.read = xsd_read,
 	.release = xsd_release,
 };

-- 
2.56.0

