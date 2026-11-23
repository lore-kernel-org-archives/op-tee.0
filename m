Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF72606A322
	for <op-tee@archiver.kernel.org>; Mon, 23 Nov 2026 23:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=GBCBOGHy
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D4079454A0
	for <op-tee@archiver.kernel.org>; Mon, 23 Nov 2026 23:28:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=GBCBOGHy;
	dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 17BA641BD7
	for <op-tee@lists.trustedfirmware.org>; Mon, 23 Nov 2026 23:28:24 +0000 (UTC)
Received: from [192.168.159.19] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id DCBAB20B7167;
	Mon, 23 Nov 2026 15:27:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DCBAB20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795476499;
	bh=Z4q2lcvDeMyQnvMma/TSV0pjEr8kXRVVL/7uiZixGfQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GBCBOGHyS/woweuMXp/5IiE28nI/q/RWX2fOSyY1oqRdeq6mlJhA0Uy5CY+vntB9X
	 OBTSWMmuYPNMyZOn37AlljwgO2+M5LQQTDHUqK0know9vyyT8rD60yDr0IBXlfgUHN
	 T50QratbJQPYi89ozm+6Qtlk7+5eXdmnoqz5Vvmg=
Message-ID: <ba8c4cdb-ba60-4166-8d0f-812db13ee90a@linux.microsoft.com>
Date: Mon, 23 Nov 2026 15:27:55 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] mshv_vtl: convert mmap hooks to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
 <20261105-late-2026-mmap_prepare-v1-3-c56aadfbab8a@kernel.org>
Content-Language: en-US
From: Kameron Carr <kameroncarr@linux.microsoft.com>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-3-c56aadfbab8a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.20 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,microsoft.com:s:+];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	ONCE_RECEIVED(0.20)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:13.77.154.182];
	RCVD_NO_TLS_LAST(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[lists.xenproject.org,vger.kernel.org,lists.ozlabs.org,lists.linux.dev,lists.infradead.org,lists.trustedfirmware.org,suse.com,kernel.org,epam.com,linux.ibm.com,gmail.com,ellerman.id.au,microsoft.com,redhat.com,linux.alibaba.com,linux.intel.com,alien8.de,zytor.com,paul-moore.com,jms.id.au,codeconstruct.com.au,aspeedtech.com,broadcom.com,arndb.de,linuxfoundation.org,infradead.org,lunn.ch,davemloft.net];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:8075, ipnet:13.64.0.0/11, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[13.77.154.182:from,4.194.122.136:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_GT_50(0.00)[61];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DWL_DNSWL_BLOCKED(0.00)[microsoft.com:dkim];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 17BA641BD7
X-Spamd-Bar: -----
Message-ID-Hash: CJUOQ5OQS7QMAB6GWSHXEC2ZBMYOCPWN
X-Message-ID-Hash: CJUOQ5OQS7QMAB6GWSHXEC2ZBMYOCPWN
X-MailFrom: kameroncarr@linux.microsoft.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperez
 ma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Richard Cochran <richardcochran@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CJUOQ5OQS7QMAB6GWSHXEC2ZBMYOCPWN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>

On 11/5/2026 1:05 PM, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook for both
> the mshv_vtl and mshv_vtl_low devices. These only set VMA operations and
> flags.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

I don't see this causing any functional changes, but quickly ran basic
regression testing on it anyway. I couldn't find b61fa14ce; I tested
based on v7.4-rc1.

No issues seen.

Tested-by: Kameron Carr <kameroncarr@linux.microsoft.com>
Reviewed-by: Kameron Carr <kameroncarr@linux.microsoft.com>

-- 
Regards,
Kameron

> ---
>  drivers/hv/mshv_vtl_main.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index d8225242c73f..e372d4c0188d 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -832,9 +832,9 @@ static const struct vm_operations_struct mshv_vtl_vm_ops = {
>  	.fault = mshv_vtl_fault,
>  };
>  
> -static int mshv_vtl_mmap(struct file *filp, struct vm_area_struct *vma)
> +static int mshv_vtl_mmap_prepare(struct vm_area_desc *desc)
>  {
> -	vma->vm_ops = &mshv_vtl_vm_ops;
> +	desc->vm_ops = &mshv_vtl_vm_ops;
>  
>  	return 0;
>  }
> @@ -852,7 +852,7 @@ static const struct file_operations mshv_vtl_fops = {
>  	.owner = THIS_MODULE,
>  	.unlocked_ioctl = mshv_vtl_ioctl,
>  	.release = mshv_vtl_release,
> -	.mmap = mshv_vtl_mmap,
> +	.mmap_prepare = mshv_vtl_mmap_prepare,
>  };
>  
>  static void mshv_vtl_synic_mask_vmbus_sint(void *info)
> @@ -1283,10 +1283,10 @@ static const struct vm_operations_struct mshv_vtl_low_vm_ops = {
>  	.huge_fault = mshv_vtl_low_huge_fault,
>  };
>  
> -static int mshv_vtl_low_mmap(struct file *filp, struct vm_area_struct *vma)
> +static int mshv_vtl_low_mmap_prepare(struct vm_area_desc *desc)
>  {
> -	vma->vm_ops = &mshv_vtl_low_vm_ops;
> -	vm_flags_set(vma, VM_HUGEPAGE | VM_MIXEDMAP);
> +	desc->vm_ops = &mshv_vtl_low_vm_ops;
> +	vma_desc_set_flags(desc, VMA_HUGEPAGE_BIT, VMA_MIXEDMAP_BIT);
>  
>  	return 0;
>  }
> @@ -1294,7 +1294,7 @@ static int mshv_vtl_low_mmap(struct file *filp, struct vm_area_struct *vma)
>  static const struct file_operations mshv_vtl_low_file_ops = {
>  	.owner		= THIS_MODULE,
>  	.open		= mshv_vtl_low_open,
> -	.mmap		= mshv_vtl_low_mmap,
> +	.mmap_prepare	= mshv_vtl_low_mmap_prepare,
>  };
>  
>  static struct miscdevice mshv_vtl_low = {
> 
