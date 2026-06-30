Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD78C43458
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 10:24:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8A1EE444F4
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 10:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782815073;
	bh=xO1vPXr6jVIbv3ACOnD7BWtFjQzhqCaDlWJshtXaouc=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=mCKdTidRuXz3DhFmuCuiEyZqQAuAdtvOpnK+FkhTmvJk4pgmSl0FeLOsIXbKi01Fa
	 KXBJQXIK+9OC7NSmTKwP+IQbuE4CVB7ZQOu4Jlqr68TSXPfGr8PHzEI2fvOA1bsHmv
	 87S6g1u1bJv7I0lML2nf11mLfsfFjft8TABAFKHk8+gGDtovzqpjNjzfyKC5Rlyhjk
	 clKTlwAnbAtAYIrlA4QnSGwUZe6d3q3734ZHa/v5ozYpp5+72PoelhadmIMj6ofHfN
	 hpSemHyN+G88WKarioMihFCtcugKJhzxX15ijO8JIRl+9Ci7b/6QXulf1yRu1v/sYY
	 WBTquPnL/2HbA==
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A867744DA1
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 10:23:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=g2GUgpzl;
	dkim-atps=neutral
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b8d92a4eso33895e9.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 03:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782814984; x=1783419784; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7eQrlr1iqvdXSCnGA9eKw5Pz71hnIxvtQ5reJnEwINc=;
        b=g2GUgpzlz4oUieV2SOwP58GLYBAYCCOfZD3zN/YuiSvTALw11PLi17A6KBFbkNmklI
         tlQPUapzUOrcN4b0rVwmOU3tVztQySIGwmcuQ4yaA+k0PoRHX5exoFAkYgVzAFgxB48o
         0bWjcgVuWSnx7JOro9Xrw9tdKC7ydAEkKc0eorQDemiUaKd8wS00qXJxN+qFviuuJiOj
         MiMDEOr8sueI0YyCeULcjYlcQ7lpOG5M7OcNQkCidNeDHiyVpsKSU2uG9gmM8O7vdpm9
         ccpjqyWK6s8U2vsMLKe7HwuQESKPPTNut4d0fQc+rpC82b8srBcTwzy5Z2tJxQexC/Qu
         jptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814984; x=1783419784;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7eQrlr1iqvdXSCnGA9eKw5Pz71hnIxvtQ5reJnEwINc=;
        b=EjBexg0hd38dF8Dw93u9o0xB/sKhywhenXM5kVYBqQCApdYG/LoxIhtHHRnAl1P5d+
         bUSQvtJ9FdhNN1IeP2SXQRDPUMwwuhCvdHQGEWHRK7sFRScfVtfa2O927XJes3DbbNfE
         CZoQCaBAaTMriSuAJSDjhgBZrTE6VIugm7xPvTWuEr9nKRMj/vP6SzWpEEIM16u2pDFm
         uTxev7NXPZH7ba63EhgTa55oZPfq3Mj4xG920gUdhSbehNKW9qMZTm3CYIJJx+xdjMQp
         4MRcGoYwKw1V4oZ9B9tMH0BUh18UaLdjlqJs7qb4r4vaCyToErq9TTnCoJLA35BzaeCQ
         7fmg==
X-Forwarded-Encrypted: i=1; AFNElJ9nSm55ZFhnFQ1sep9xOqa4se1KdNGBtf7sKejEIeNSBwOq/7e4PcOKiwXIG+MDFCQAw64+qu0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yz53EBCX39vkw7ShoCiKNyhHT1AG4LhLEQjnDnVFl7UfftipyMx
	BCOEe8XJ8aASlOexrVmULuCL/uYjlS9UjNuGQZvNBcqY/C/rIzCWyXZP0J9SNzBJrw==
X-Gm-Gg: AfdE7clhCjFzdifqfiZfcx4f+ZLymDHk9XY3YDnPbXgCN+MFZOGnic27/plp+fXK2Ag
	Ojgj1T9MfxnKc8QI9+LO44hTtWo5MbaSiS9YtvhpOKmYKCQp6MuaRdKdPGMRVvRd57DnfXJbvRt
	nPECJRMAb62LFKOwQKNRTOQWPFKAPy0/o2bY8iIDbt+LdWuDH+A3byTvHYPVjTIPXplz/O5JJpt
	ba8n0OAXduZuoL6VXbApjnehxnGLsw8QZGq7wXuFhIAx+11U2yn6OGfjw/QRiNHTYhWM26MmFe9
	QbX09e+ATw3PilbFc7hC83DsT6pM7PtETDM+npiy0OcOlFqi2twYQmWm00hpKH3I5KS4jWL1BNF
	13iYCXZ+aJ5r4f4vSeLalqRRIVMt+/5Qo0fsvvcgXUXMZioWqm4rr0X0Kk2jkRzHZLZevj5jGvq
	NtYeYAHkSXIVUtiMvQj6va4YZBrbDqtQg1Y7CCM1r+JneuIu9QoEPTNQscQZjK8A==
X-Received: by 2002:a05:600c:4314:b0:493:b86f:c913 with SMTP id 5b1f17b1804b1-493bd77921amr14605e9.1.1782814984019;
        Tue, 30 Jun 2026 03:23:04 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8cd8bccsm63196105e9.8.2026.06.30.03.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:23:03 -0700 (PDT)
Date: Tue, 30 Jun 2026 10:22:59 +0000
To: Sebastian Ene <sebastianene@google.com>
Subject: Re: [PATCH v7 6/7] KVM: arm64: Ensure FFA ranges are page aligned
Message-ID: <akOZAwBn0JkbyzX4@google.com>
References: <20260617145130.3729015-1-sebastianene@google.com>
 <20260617145130.3729015-7-sebastianene@google.com>
 <ajQmN-UQD3uJJddJ@google.com>
 <akORop8Z9Levu9Sr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akORop8Z9Levu9Sr@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.98%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[google.com,arm.com,kernel.org,linaro.org,lists.linux.dev,lists.infradead.org,vger.kernel.org,gmail.com,lists.trustedfirmware.org,linux.ibm.com,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.48:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.48:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A867744DA1
X-Spamd-Bar: --
Message-ID-Hash: TJJVJVFB5CTZBLF4WHSLTW6HNIROYAUR
X-Message-ID-Hash: TJJVJVFB5CTZBLF4WHSLTW6HNIROYAUR
X-MailFrom: smostafa@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Vincent Donnefort <vdonnefort@google.com>, catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org, will@kernel.org, joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, seiden@linux.ibm.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TJJVJVFB5CTZBLF4WHSLTW6HNIROYAUR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mostafa Saleh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mostafa Saleh <smostafa@google.com>

> Hey Vincent,
> 
> > I failed to parse this 
> > 
> > But I see 
> > 
> > /* The base IPA of the constituent memory region, aligned to 4 kiB */ 
> > 
> > So it sounds fair to prevent oversharing when PAGE_SIZE > 4KiB
> > 
> 
> I think the problem is when you have a mismatch between FFA_PAGE_SIZE
> and the system PAGE_SIZE. We expect a fixed FFA_PAGE_SIZE of 4kb and
> this is enforced by :
> https://elixir.bootlin.com/linux/v7.1.2/source/arch/arm64/kvm/hyp/nvhe/ffa.c#L761
> 
> if FFA_PAGE_SIZE = 4kb and PAGE_SIZE = 16kb you can end up annotating more pages with FF-A then
> needed when the range->address is unaligned.
> 
> It took me a while to understand this so I guess it is better to rephrase the commit msg.

The problem here is that we only check alignment for size and not
the address.
And the code later (__pkvm_host_unshare_ffa()) uses pfn which
truncates the extra bits.
So, in case we have an unaligned address and an aligned the size, it
will round down the address while the actual size spans an extra page.

For example if base = 0xFFF and size = 0x1000. pKVM will share
(0-0x1000) while the actual range spans till 0x1FFF causing FFA
to access an extra page that was not shared by pKVM.

Thanks,
Mostafa


