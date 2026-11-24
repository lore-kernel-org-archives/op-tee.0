Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360260A3829
	for <op-tee@archiver.kernel.org>; Tue, 24 Nov 2026 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=3pwK5cDV;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCh0V0So
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 65AFD45501
	for <op-tee@archiver.kernel.org>; Tue, 24 Nov 2026 14:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795529095;
	bh=JYQK3wK0K9TDfgdH5JvWWtvXfv1ER9V1zmvapkfLQMQ=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=3pwK5cDVAMwN98OpNresDyVpfI/LBKfJ6RYrkdX7VTCsXCsuV0Skzh+Qdhmq9+7Xb
	 Oy08OMYF/R3baMmUWZ/n0sPU41E57kYyPeKNdiZwpvp1YqHHM54JASjMoHzPmSq3r9
	 0aTUMmEG5jiV/S7TGfx6UPKSZzzTI2pyF4hSyCzijvCHBXcXtBecrfHP61yUwlORD4
	 Xo6g07Efq+S2Y/oh1rdI144kJwj9IcvOQbDOlEFPwUzhO2P+XMjrVpgjSjwAONw8Rj
	 2Cn150WHLzucKQIBMHJAuFycSn/WjuFSmKrAQTWMVwGWd/4AvYb+NGLchLqff1IGv+
	 actmsBSPava3A==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7637B45526
	for <op-tee@lists.trustedfirmware.org>; Tue, 24 Nov 2026 14:04:10 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCh0V0So;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 38DF36266D;
	Tue, 24 Nov 2026 14:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2399E1F0089E;
	Tue, 24 Nov 2026 14:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795529049;
	bh=Q5EZNv1hoZNsO5LavIHZOtKGm9yaPJJ0vpR/2Fm0XAo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oCh0V0SotsrCn9TWTvx54DUqWZ9E5lDYqEYTa/SkfK/tDZ1vzOW7K1B+iPFhd+J9N
	 IMBPfgrvCJBhLO25ivWueHZaBO3todJlUJ0FWSSUg0jzV/v3Kdf01vHxWwiC8NT3KE
	 ajXML1m9831Htpg68RVCN87q2izRhoN9KwgCRK21KifWLU8cP4xS+xyd/1jjXEispa
	 aqVYHhHGm2uNElvmmoTqoOj7YxZlaQQwUJHKVMrL0iBjaGly4K77/on649tqcw+0IA
	 JY8UEIMdEo+PH7RuljHaB/bfBS1rItq08+6Dk419a5HID7kx4JwCgJhAo1hyslk2fg
	 PozyX57TBWNCQ==
Date: Tue, 24 Nov 2026 14:02:46 +0000
Subject: [PATCH v2 03/13] mshv_vtl: convert mmap hooks to mmap_prepare
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-late-2026-mmap_prepare-v2-3-0b0d99d655f9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2186; i=ljs@kernel.org;
 h=from:subject:message-id; bh=JYQK3wK0K9TDfgdH5JvWWtvXfv1ER9V1zmvapkfLQMQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZZ4o1PGpWtp6mWtz06svzJY2dja9sXqWeFlqRVDKj9
 f9fwfsiHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZjICl9Ghr1n6kyr2U7mXtq1
 vXBDo9yCMwtuvVqu9PjO+TrncsbFO5cz/Hd3+BZswOIzW06xUO7ljlVNq98b5kUcm9Fu0HT10/m
 DSowA
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
	RCVD_IN_DNSWL_MED(-0.20)[172.105.4.254:from];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lists.xenproject.org,vger.kernel.org,lists.ozlabs.org,lists.linux.dev,lists.infradead.org,lists.trustedfirmware.org,kvack.org,linux.microsoft.com,outlook.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,suse.com,kernel.org,epam.com,linux.ibm.com,gmail.com,ellerman.id.au,microsoft.com,redhat.com,linux.alibaba.com,linux.intel.com,alien8.de,zytor.com,paul-moore.com,jms.id.au,codeconstruct.com.au,aspeedtech.com,broadcom.com,arndb.de,linuxfoundation.org,infradead.org,lunn.ch,davemloft.net];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[65];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7637B45526
X-Spamd-Bar: --------
Message-ID-Hash: AW5NHXRH7UH43Z4PJKVYDMNGF755UZMR
X-Message-ID-Hash: AW5NHXRH7UH43Z4PJKVYDMNGF755UZMR
X-MailFrom: ljs@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: ljs@kernel.org, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org, linux-mm@kvack.org, Kameron Carr <kameroncarr@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AW5NHXRH7UH43Z4PJKVYDMNGF755UZMR/>
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

Move from the deprecated mmap hook to the new mmap_prepare hook for both
the mshv_vtl and mshv_vtl_low devices. These only set VMA operations and
flags.

Tested-by: Kameron Carr <kameroncarr@linux.microsoft.com>
Reviewed-by: Kameron Carr <kameroncarr@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 drivers/hv/mshv_vtl_main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index 2d4fe24cecbf..9bfe808f71ed 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -873,9 +873,9 @@ static const struct vm_operations_struct mshv_vtl_vm_ops = {
 	.fault = mshv_vtl_fault,
 };
 
-static int mshv_vtl_mmap(struct file *filp, struct vm_area_struct *vma)
+static int mshv_vtl_mmap_prepare(struct vm_area_desc *desc)
 {
-	vma->vm_ops = &mshv_vtl_vm_ops;
+	desc->vm_ops = &mshv_vtl_vm_ops;
 
 	return 0;
 }
@@ -893,7 +893,7 @@ static const struct file_operations mshv_vtl_fops = {
 	.owner = THIS_MODULE,
 	.unlocked_ioctl = mshv_vtl_ioctl,
 	.release = mshv_vtl_release,
-	.mmap = mshv_vtl_mmap,
+	.mmap_prepare = mshv_vtl_mmap_prepare,
 };
 
 static void mshv_vtl_synic_mask_vmbus_sint(void *info)
@@ -1324,10 +1324,10 @@ static const struct vm_operations_struct mshv_vtl_low_vm_ops = {
 	.huge_fault = mshv_vtl_low_huge_fault,
 };
 
-static int mshv_vtl_low_mmap(struct file *filp, struct vm_area_struct *vma)
+static int mshv_vtl_low_mmap_prepare(struct vm_area_desc *desc)
 {
-	vma->vm_ops = &mshv_vtl_low_vm_ops;
-	vm_flags_set(vma, VM_HUGEPAGE | VM_MIXEDMAP);
+	desc->vm_ops = &mshv_vtl_low_vm_ops;
+	vma_desc_set_flags(desc, VMA_HUGEPAGE_BIT, VMA_MIXEDMAP_BIT);
 
 	return 0;
 }
@@ -1335,7 +1335,7 @@ static int mshv_vtl_low_mmap(struct file *filp, struct vm_area_struct *vma)
 static const struct file_operations mshv_vtl_low_file_ops = {
 	.owner		= THIS_MODULE,
 	.open		= mshv_vtl_low_open,
-	.mmap		= mshv_vtl_low_mmap,
+	.mmap_prepare	= mshv_vtl_low_mmap_prepare,
 };
 
 static struct miscdevice mshv_vtl_low = {

-- 
2.56.1

