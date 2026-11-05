Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A577606A32D
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=wzJccLjt;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KFA+ZicK
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5240043E4A
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 21:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793915026;
	bh=wNcZM/gts0mKhbI3gAZI3ISYmgzZQknwCiVy/fjN82I=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=wzJccLjto+cHB00ePDv+fmjc8a7Mzxpf2Jyzi0tlAj/0+OGG3JJXmjh6BMrAtc1nw
	 1Dub8YDQBU0zrK+2eEGPux8w9j1bmKYxkaMJlZjclCF63dOsPB9Ruve7wAfoZpnSYo
	 +XGKG8rN3qXFfoZDC6XSErRpF8tRQqXag9ffzo9FWtVUSnZV8d5DA2r1LNe7VuKtnI
	 M5ANMNioPGgb494xxAY5NMsAM7EM4e/Br+YRpwSFx89xqe5aSeyAK/Nc9yQrjJP+aG
	 6pHHsH7HgzgQ7/MHxOE2VzjihLb63fYT3x8JeyHxcm1ntnJQdLsIAgMlovsdtT4EM+
	 jIjxxqY7uRyxw==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with UTF8SMTPS id 76E5043E4A
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 21:43:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KFA+ZicK;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id AC45343451;
	Thu,  5 Nov 2026 21:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0AE881F0089F;
	Thu,  5 Nov 2026 21:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793915007;
	bh=nnsNMtUi8B/PfO4GG0OW4lr6jLs4u50NUe2xEiA6RC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KFA+ZicKHpTxqbxZeNU9rKNH0zDIw+G9WkxRcTelADPJIyDG9z+SV38MG0CjPlcEC
	 1gjbq2m9ysrv8pBHAJrvqPnMERLZq6W4rxcogl2DlIDB44RylaSdblCTSEXNnxfcbK
	 l3RbrI5Oxv1bkdw/nOHwLpMlw6rPe3TmPXrqXYMaHNImuFIqgFREHKoGTzOn5W2eUw
	 HnogndejHth27NGEbdc3qPN/i0WWKweuYdEdmiZr5RDjCfk6/mEdy1F9Yu6XlveCU2
	 QfoEW83U8XIbYRbkOdJsXHQEOAAPFI6k6EpuBWa/BFfpmagRIXSu+HdiZvkzWIUa8b
	 kW/HsHhM4i4og==
Date: Thu, 5 Nov 2026 23:43:23 +0200
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: Re: [PATCH 05/14] x86/sgx: convert vepc mmap hook to mmap_prepare
Message-ID: <auz4e81zm0mTMknq@kernel.org>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
 <20261105-late-2026-mmap_prepare-v1-5-c56aadfbab8a@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-5-c56aadfbab8a@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.20 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	RCVD_IN_DNSWL_MED(-0.20)[172.234.252.31:from];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,epam.com,linux.ibm.com,gmail.com,ellerman.id.au,microsoft.com,redhat.com,linux.alibaba.com,linux.intel.com,alien8.de,zytor.com,paul-moore.com,jms.id.au,codeconstruct.com.au,aspeedtech.com,broadcom.com,arndb.de,linuxfoundation.org,infradead.org,lunn.ch,davemloft.net,lists.xenproject.org,vger.kernel.org,lists.ozlabs.org,lists.linux.dev,lists.infradead.org,lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[60];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 76E5043E4A
X-Spamd-Bar: --------
Message-ID-Hash: I32Y26W3UJY6J2TBIJQ7CTPWCMPIFLXZ
X-Message-ID-Hash: I32Y26W3UJY6J2TBIJQ7CTPWCMPIFLXZ
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej =?utf-8?B?TW9zbsOhx
 I1law==?= <omosnacek@gmail.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualization
 @lists.linux.dev, linux-sgx@vger.kernel.org, selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/I32Y26W3UJY6J2TBIJQ7CTPWCMPIFLXZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAD_ENC_HEADER,BAYES_00,
	DKIM_INVALID,DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 09:05:36PM +0000, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook. The hook
> only checks that the mapping is shared and sets VMA flags, operations and
> private data.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  arch/x86/kernel/cpu/sgx/virt.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
> index 6a1933ddc6fc..850990519ca5 100644
> --- a/arch/x86/kernel/cpu/sgx/virt.c
> +++ b/arch/x86/kernel/cpu/sgx/virt.c
> @@ -98,17 +98,18 @@ static const struct vm_operations_struct sgx_vepc_vm_ops = {
>  	.fault = sgx_vepc_fault,
>  };
>  
> -static int sgx_vepc_mmap(struct file *file, struct vm_area_struct *vma)
> +static int sgx_vepc_mmap_prepare(struct vm_area_desc *desc)
>  {
> -	struct sgx_vepc *vepc = file->private_data;
> +	struct sgx_vepc *vepc = desc->file->private_data;
>  
> -	if (!(vma->vm_flags & VM_SHARED))
> +	if (!vma_desc_test(desc, VMA_SHARED_BIT))
>  		return -EINVAL;
>  
> -	vma->vm_ops = &sgx_vepc_vm_ops;
> +	desc->vm_ops = &sgx_vepc_vm_ops;
>  	/* Don't copy VMA in fork() */
> -	vm_flags_set(vma, VM_PFNMAP | VM_IO | VM_DONTDUMP | VM_DONTCOPY);
> -	vma->vm_private_data = vepc;
> +	vma_desc_set_flags(desc, VMA_PFNMAP_BIT, VMA_IO_BIT, VMA_DONTDUMP_BIT,
> +			   VMA_DONTCOPY_BIT);
> +	desc->private_data = vepc;
>  
>  	return 0;
>  }
> @@ -315,7 +316,7 @@ static const struct file_operations sgx_vepc_fops = {
>  	.unlocked_ioctl	= sgx_vepc_ioctl,
>  	.compat_ioctl	= sgx_vepc_ioctl,
>  	.release	= sgx_vepc_release,
> -	.mmap		= sgx_vepc_mmap,
> +	.mmap_prepare	= sgx_vepc_mmap_prepare,
>  };
>  
>  static struct miscdevice sgx_vepc_dev = {
> 
> -- 
> 2.56.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
