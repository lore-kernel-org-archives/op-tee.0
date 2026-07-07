Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B308C43458
	for <op-tee@archiver.kernel.org>; Tue,  7 Jul 2026 11:56:38 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B63A744DA6
	for <op-tee@archiver.kernel.org>; Tue,  7 Jul 2026 11:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1783425397;
	bh=VHyQyW91mk/rV9J35jEDjKnS65l+3GqidQKWJGCYFvY=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=S/CWZRPNDlS1qCZjJ9I+viW0AVYtd4vTw74mJ2w1T/l21SrI/gKJcujJP2fmGPTeV
	 xvwyXNARjIUVeqrq5EQCcVr0EA7i5QSu3vETt/m2O1uKzqoFmcWNIKAWVxd6trYE2W
	 o6M40bOMCjw5GeBbX+CPDAtmLTF6CGF5BDfbd9eL/ysx5uJc/QGZrL9Ez9bUigxJsC
	 uzOCe8PbDEAQpVlbbQ6kAom29RwIo+owCY9+RsXi8r9fciPpPt7KsQgKENlYcZHFRr
	 +q6MfYxQrzIIYBAAdUWrfGWj5KKmu/xEYjE7x43jq4ld9g1bU3yLMJ4fY8mM6wwsoJ
	 JAzisSkTpINpQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3AC7E44DA6
	for <op-tee@lists.trustedfirmware.org>; Tue,  7 Jul 2026 11:56:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kLaFw+j2;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C58A36001D;
	Tue,  7 Jul 2026 11:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D371F01559;
	Tue,  7 Jul 2026 11:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783425391;
	bh=dfqKIJOu25jIvGp/MHMBBQ/zA+78h3cOEbJXVr/juXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kLaFw+j20wmNLTAhrt8SIoCgi9fuNsefFqDsKoq3ghMgJ5Coo4Ut3x6FW3iCmq2x/
	 yQHHKkJGahcmV/iDfAtzZcAIwFnChkHsZ559TRHDa+R+17elV+tA8aXeBdG5dFX0IF
	 ZQ6rKwJAz9F6j5yse9QyvZCy6y/s4KT4of1GKlH+SOA+4ICqfwTr1Bi53BtYDcWoa3
	 +eDl9knq8FmECFBkGnqsDgov0sPFtDdzYCGEj8nl9zs3C2UmmS0slodBDe68tFbgHf
	 59y6nJoHWBs1upSEtDDn3IeWxo1Ah6xvbMFs9sI3awvukoaxp8Z/RKK0nWwnyivcpT
	 vsaHe8lUAaeCg==
Date: Tue, 7 Jul 2026 12:56:24 +0100
To: Marc Zyngier <maz@kernel.org>, sudeep.holla@kernel.org
Subject: Re: (subset) [PATCH v9 0/6] arm_ffa, KVM: Fix FF-A emad offset
 calculations
Message-ID: <akzpaD3VmMp8Dq4S@willie-the-truck>
References: <20260702103848.1647249-1-sebastianene@google.com>
 <178342187223.1892339.1923162787460489447.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178342187223.1892339.1923162787460489447.b4-ty@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,google.com,linaro.org,lists.linux.dev,lists.infradead.org,vger.kernel.org,gmail.com,lists.trustedfirmware.org,linux.ibm.com,huawei.com];
	FROM_HAS_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3AC7E44DA6
X-Spamd-Bar: ------
Message-ID-Hash: VOGZCNQZTIIYV6LKMA5EPNNSY57C75VV
X-Message-ID-Hash: VOGZCNQZTIIYV6LKMA5EPNNSY57C75VV
X-MailFrom: will@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, oupton@kernel.org, Sebastian Ene <sebastianene@google.com>, joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VOGZCNQZTIIYV6LKMA5EPNNSY57C75VV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Will Deacon via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Will Deacon <will@kernel.org>

On Tue, Jul 07, 2026 at 11:58:01AM +0100, Marc Zyngier wrote:
> On Thu, 02 Jul 2026 10:38:37 +0000, Sebastian Ene wrote:
> > This series fixes the Endpoint Memory Access Descriptor (EMAD) offset
> > calculations and adds the necessary bounds checks for both the core
> > FF-A driver and the pKVM hypervisor.
> > 
> > Prior to FF-A version 1.1, the memory region header didn't specify an
> > explicit offset for the EMADs, leading to the assumption that they
> > immediately follow the header.
> > However, from v1.1 onwards, the specification dictates using the
> > ep_mem_offset` field to determine the start of the memory access
> > array.
> > 
> > [...]
> 
> Applied to fixes, thanks!
> 
> [3/6] KVM: arm64: Fix bounds checking in do_ffa_mem_reclaim()
>       commit: 8c6db30d79528279abbeb416e4f533f1f91b8724
> [4/6] KVM: arm64: Validate the offset to the mem access descriptor
>       commit: a6b49d27c17909608d54523220bb6f3498d4a1df
> [5/6] KVM: arm64: Ensure FFA ranges are page aligned
>       commit: 6a7a181f6921db3d9aed1bba7e15547fefd7eedc
> [6/6] KVM: arm64: Zero out the stack initialized data in the FFA handler
>       commit: 2bd3c6c702f3a9e2bcb3b536b0fbbaa645005d71

Thanks, Marc!

I think Sudeep was also happy for the driver changes to go via the KVM
tree, unless you'd prefer not to pick them up [1].

Will

[1] https://lore.kernel.org/r/20260518-heavy-intelligent-partridge-ddc80b@sudeepholla
