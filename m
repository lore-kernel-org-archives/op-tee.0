Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4ED60A2614
	for <op-tee@archiver.kernel.org>; Thu, 19 Nov 2026 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=b0skgB9m;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cj27tBem
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5D17745473
	for <op-tee@archiver.kernel.org>; Thu, 19 Nov 2026 15:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795100721;
	bh=Mu6lVOUapvmsLM/653q/828N5Ibaod/nh25CpPVVBTo=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=b0skgB9mue1ZBwq+6A3JrVRQQq2QCTQ4UyWNbLZJXO2KEe4iASAZL+ShWGG+O/BaB
	 JhTxGNjSNFD0S52L7vkC7+5pnEgyFCwspLuzxRU0LQoQ1YAWNfB9K8HdIEM1EzGffX
	 H03S8rbH2v9DpYpbqLz1p0afAfjAawMI+oR9nQyDLi7K/zsKfYYlfvDen+2SmlZB9k
	 rjJ63ZcCFJYa2RcEvn3iSWgzoDu9wq67HH217JiMChpdgSlpIPaf71r7kxoPNBp7qa
	 vogZWYoCEdG78Fy5RhbaI0GMmFDfRchb4FspS9X8YouMs2xAp7FR2QDh9HBcGvTaXc
	 HeTk4xrLNq/Zg==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1420E45360
	for <op-tee@lists.trustedfirmware.org>; Thu, 19 Nov 2026 15:05:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cj27tBem;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795100716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cra6Vs20NtPqxX9EfP/IC1RWThkucYohNUCRfJABY3A=;
	b=cj27tBemFKjHc9fbRKQFoJigFreEwUype77zkSNad/Mw1sSzV1any7UU7/Er9NfbDmhjeL
	dIonnrEr2ICh/VSowh0cwEJgJbjf9V2tDYXF3oyx++zYsrJnqyPNBWw+xRmLorXW6OFwu3
	ZlQLcFeN3muhBQgCnZPEXHMRhrPQYdI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-sNdZDZQvMwSJuViiNaVDyg-1; Thu, 19 Nov 2026 10:05:14 -0500
X-MC-Unique: sNdZDZQvMwSJuViiNaVDyg-1
X-Mimecast-MFC-AGG-ID: sNdZDZQvMwSJuViiNaVDyg_1795100713
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-49337a224a8so1603351f8f.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 19 Nov 2026 07:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795100713; x=1795705513;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cra6Vs20NtPqxX9EfP/IC1RWThkucYohNUCRfJABY3A=;
        b=q46IJ6pCLCUNREFa8mZn98+SsOzDk3TwILHUfs0rB4LwGbIu6ehdxDnkBQOf8b/cCb
         HcaluzrHnmKy727LtCy3QrjhxBlA3fEdFen9MACe4TL0pEJyqX+DDYf7XtUtK1Fqapve
         Du1uzxq5XesG8GlhWeh1k1yObGoRM4ZuCH+6xZNRYDqK0v8hLZCoBOC9ii+MYxR8gOBR
         pDqhnovrRC48Pl5QiaPpcbp9LvOMXdvF67fHKOwN8livoHmJmkI7B0G4D+0NjVb4Zb5w
         MMRa23MugYkNxEhbPMzy7Lbn4qMo+1SC2/O8pX7rL0Gd0kejtBdS9EkSTiqhWAx5j3Ln
         8DMA==
X-Forwarded-Encrypted: i=1; AL+hErH+vzPDJtSAe8rSy82g9gud9ko3BEjuDpEXXgOFv8FzITYDrjJbtWcNXP2bnFrY1lQbNph0hig=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z9cVH9F65RrddsuwP6zSspsFve57cXoCad6eaTzW7lK86ga4Ag4
	HKcsPGCg0t/HILFP3ZfGg/MctKHvmtHZkRqunsOWbvQPKOvmQVhjyxY/cuCTGebeWbcTDPQ3BQX
	KnlLeqTSEa5sgvndIIQSOXuKH2jmm2DiVkB0jZrVqbe4EsRzAEkEaW4T+9uJkEqfNIgWbbrE=
X-Gm-Gg: AZFdTZcXjVkUDIe1Uix51G24fELQxkvjDhcCBoqIxfWKanSMUEf2yoYDHL/jQGesrWQ
	Z/e1U+q98GLjPsYoi6W2CDZWehy9R0LyVxHrV61F5dWUmk5U7oR6N9RN9l+Z+1v5TdHJGKNPtLZ
	Z+p8EB/TtGdLotoBeQaBzjFXDkG4FvMRV+iuHY/EnmPNteWxHYZ0KO4EQnj4JGGuejRZnluvDJX
	vUWm40OKgQ0gPOovjJgVK+VtFTCJSZXcSsdpGbaGqxAURVESw5iaTXCw4C1974R122L5gXdW8a/
	/ldWxJwVNlO7ZlPC92zX44VWSjbcfBKAAc2MDUw65Ji4HfE0wt4WQrAO6WBKQTcRcIZ2oWyOjjQ
	tQcAWBFoDo3sZDYhWiKiH37AwJbjK64zo//QdV77Q1w==
X-Received: by 2002:a05:6000:2608:b0:4a9:2728:fdfc with SMTP id ffacd0b85a97d-4a92728ff7amr4686385f8f.28.1795100713243;
        Thu, 19 Nov 2026 07:05:13 -0800 (PST)
X-Received: by 2002:a05:6000:2608:b0:4a9:2728:fdfc with SMTP id ffacd0b85a97d-4a92728ff7amr4686266f8f.28.1795100712535;
        Thu, 19 Nov 2026 07:05:12 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1522:6500:ac93:c62:f076:48c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm61225f8f.59.2026.11.19.07.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:05:11 -0800 (PST)
Date: Thu, 19 Nov 2026 10:05:05 -0500
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: Re: [PATCH 14/14] vhost-vdpa: convert mmap hook to mmap_prepare
Message-ID: <20261119100450-mutt-send-email-mst@kernel.org>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
 <20261105-late-2026-mmap_prepare-v1-14-c56aadfbab8a@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-14-c56aadfbab8a@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E9H4XrLpU5CM4i60HSPVBsT2tcVnlwzzG-u2hCNT0iI_1795100713
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.70 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[redhat.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:170.10.133.0/24];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	RCVD_IN_DNSWL_LOW(-0.10)[170.10.133.124:from];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[170.10.133.124:from];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,epam.com,linux.ibm.com,gmail.com,ellerman.id.au,microsoft.com,redhat.com,linux.alibaba.com,linux.intel.com,alien8.de,zytor.com,paul-moore.com,jms.id.au,codeconstruct.com.au,aspeedtech.com,broadcom.com,arndb.de,linuxfoundation.org,infradead.org,lunn.ch,davemloft.net,lists.xenproject.org,vger.kernel.org,lists.ozlabs.org,lists.linux.dev,lists.infradead.org,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCPT_COUNT_GT_50(0.00)[60];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:30031, ipnet:170.10.132.0/23, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.71:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1420E45360
X-Spamd-Bar: ---
Message-ID-Hash: BA5CSBWBPCEZFBZT7TKY5BBJ4MAHVXGF
X-Message-ID-Hash: BA5CSBWBPCEZFBZT7TKY5BBJ4MAHVXGF
X-MailFrom: mst@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Jason Wang <jasowangio@gmail.com>, Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej =?utf-8?B?TW9zbsOhxI1
 law==?= <omosnacek@gmail.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualization@l
 ists.linux.dev, linux-sgx@vger.kernel.org, selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BA5CSBWBPCEZFBZT7TKY5BBJ4MAHVXGF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: "Michael S. Tsirkin via OP-TEE" <op-tee@lists.trustedfirmware.org>
Reply-To: "Michael S. Tsirkin" <mst@redhat.com>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAD_ENC_HEADER,BAYES_00,
	DKIM_INVALID,DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 09:05:45PM +0000, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook. The hook
> only validates the request and sets the VMA flags, operations and page
> protection.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>


feel free to merge with rest of this.

> ---
>  drivers/vhost/vdpa.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ff7d90719171..993b2d7c8927 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1573,19 +1573,19 @@ static const struct vm_operations_struct vhost_vdpa_vm_ops = {
>  	.fault = vhost_vdpa_fault,
>  };
>  
> -static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)
> +static int vhost_vdpa_mmap_prepare(struct vm_area_desc *desc)
>  {
> -	struct vhost_vdpa *v = vma->vm_file->private_data;
> +	struct vhost_vdpa *v = desc->file->private_data;
>  	struct vdpa_device *vdpa = v->vdpa;
>  	const struct vdpa_config_ops *ops = vdpa->config;
>  	struct vdpa_notification_area notify;
> -	unsigned long index = vma->vm_pgoff;
> +	unsigned long index = desc->pgoff;
>  
> -	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
> +	if (vma_desc_size(desc) != PAGE_SIZE)
>  		return -EINVAL;
> -	if ((vma->vm_flags & VM_SHARED) == 0)
> +	if (!vma_desc_test(desc, VMA_SHARED_BIT))
>  		return -EINVAL;
> -	if (vma->vm_flags & VM_READ)
> +	if (vma_desc_test(desc, VMA_READ_BIT))
>  		return -EINVAL;
>  	if (!ops->get_vq_notification)
>  		return -ENOTSUPP;
> @@ -1598,12 +1598,13 @@ static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)
>  		return -EINVAL;
>  	if (notify.addr & (PAGE_SIZE - 1))
>  		return -EINVAL;
> -	if (vma->vm_end - vma->vm_start != notify.size)
> +	if (vma_desc_size(desc) != notify.size)
>  		return -ENOTSUPP;
>  
> -	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
> -	vma->vm_ops = &vhost_vdpa_vm_ops;
> +	desc->page_prot = pgprot_noncached(desc->page_prot);
> +	vma_desc_set_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
> +			   VMA_DONTDUMP_BIT);
> +	desc->vm_ops = &vhost_vdpa_vm_ops;
>  	return 0;
>  }
>  #endif /* CONFIG_MMU */
> @@ -1615,7 +1616,7 @@ static const struct file_operations vhost_vdpa_fops = {
>  	.write_iter	= vhost_vdpa_chr_write_iter,
>  	.unlocked_ioctl	= vhost_vdpa_unlocked_ioctl,
>  #ifdef CONFIG_MMU
> -	.mmap		= vhost_vdpa_mmap,
> +	.mmap_prepare	= vhost_vdpa_mmap_prepare,
>  #endif /* CONFIG_MMU */
>  	.compat_ioctl	= compat_ptr_ioctl,
>  };
> 
> -- 
> 2.56.0

