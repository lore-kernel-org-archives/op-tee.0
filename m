Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B361606A31B
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=0V06dRMZ;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bE1mtiJS
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CC3E1454BE
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 21:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793912839;
	bh=isNjWX1+rq7D/LCFpxyPlaDLPeXkCD+W3Ok7FRCKcJw=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=0V06dRMZuNzsVyVESijrLZEiyVjoH4/UzlAtym08nv9i645oTn+VMrYW+fLcU+gfH
	 2e5rCqR9imRbTMO0Ytl+muJnIMOHnqoTMHV8IzZ+lrJX7OLKjE4X5lf4qdGjhBEQ/5
	 QHpDQ1k8OPtBi0+UR7ZNLq5HFK7OPXC1Yt1VBkPoCni3Z2ysujs5mJ6D4szgpRFxvn
	 BZlmXRgERJmVmCbx1vn5pdYeAK3S5GQzvtTmODXR7UUShdMoDMg9yN6gM0FfOZZukE
	 NXgqnAtFAnsfGR+mGBcL3wK7SmX9hzr5LhJ37wErN7fQXFxKFyOXT9lUrH2lI5uXvf
	 /QoD/gCMPOU2Q==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 16B0C454C7
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 21:06:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bE1mtiJS;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 340EF40474;
	Thu,  5 Nov 2026 21:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7721F008A2;
	Thu,  5 Nov 2026 21:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793912786;
	bh=ndCCV29odaVqmbn+iX3MfTT/qeX9oKJWHuVF4KdBH5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bE1mtiJSdVH/EQ/is2LWkUZ/C3yxYBYfLOhHqUTt/CwFIy/gYmtLkJHHuxmtn0qas
	 yO9fbotB7tujrxXdc0dnkvxIV/RhktA0O7/IfKUxqgjQUPFOkQ5XnXZtbaWRijR9Vy
	 rvAxbTT+4e6PNwgjL8QIvMIHw/zcPa1VPCvof+TgcikwT7sEhMMTQsb3zg5PapYZUW
	 2Lseo41qjhjCwu9T0ZH9xcwi/0hu1ZabSEnBK24mSHLfxURPoVykJcET2IhZ4Wtq9c
	 Hnu7ks+Oht5PHDx5NhOAkrNMXAA5S32BMROuJexLAy02FIr8+q5JXl7F26smYgLgC3
	 Q7zdGqQgYr71w==
Date: Thu, 05 Nov 2026 21:05:33 +0000
Subject: [PATCH 02/14] KVM: PPC: Book3S: convert spapr TCE mmap hook to
 mmap_prepare
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-late-2026-mmap_prepare-v1-2-c56aadfbab8a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158; i=ljs@kernel.org;
 h=from:subject:message-id; bh=isNjWX1+rq7D/LCFpxyPlaDLPeXkCD+W3Ok7FRCKcJw=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLevF+9xW/CppYO03VXA+4cXPbxVIsu56wVs7KfZZ3ol
 1lwXPt+bkcpC4MYF4OsmCLL8y/i+4NEwuZ1XvB3g5nDygQyhIGLUwAm8pOXkWGz4+UDqey9qzes
 Xb+fSYpFRlBEUvKQQ1qUfs3xhguqITcY/vus+TRh5qs94ifijyrfz1sVcMt/v+Lr5WJTS9on9iz
 /dooNAA==
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
X-Rspamd-Queue-Id: 16B0C454C7
X-Spamd-Bar: --------
Message-ID-Hash: XOR2MHIZW7WBZHHXDT3Z3FAUBIOWE5ZJ
X-Message-ID-Hash: XOR2MHIZW7WBZHHXDT3Z3FAUBIOWE5ZJ
X-MailFrom: ljs@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: ljs@kernel.org, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XOR2MHIZW7WBZHHXDT3Z3FAUBIOWE5ZJ/>
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
only sets the VMA operations.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/powerpc/kvm/book3s_64_vio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index c5f3f5b29d89..05f6f2c9a432 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -247,9 +247,9 @@ static const struct vm_operations_struct kvm_spapr_tce_vm_ops = {
 	.fault = kvm_spapr_tce_fault,
 };
 
-static int kvm_spapr_tce_mmap(struct file *file, struct vm_area_struct *vma)
+static int kvm_spapr_tce_mmap_prepare(struct vm_area_desc *desc)
 {
-	vma->vm_ops = &kvm_spapr_tce_vm_ops;
+	desc->vm_ops = &kvm_spapr_tce_vm_ops;
 	return 0;
 }
 
@@ -282,7 +282,7 @@ static int kvm_spapr_tce_release(struct inode *inode, struct file *filp)
 }
 
 static const struct file_operations kvm_spapr_tce_fops = {
-	.mmap           = kvm_spapr_tce_mmap,
+	.mmap_prepare	= kvm_spapr_tce_mmap_prepare,
 	.release	= kvm_spapr_tce_release,
 };
 

-- 
2.56.0

