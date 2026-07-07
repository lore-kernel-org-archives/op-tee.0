Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E07C43458
	for <op-tee@archiver.kernel.org>; Tue,  7 Jul 2026 10:58:17 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 92DC344E50
	for <op-tee@archiver.kernel.org>; Tue,  7 Jul 2026 10:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1783421896;
	bh=qyKJ1jdxX//ZantfaEkOSW3gCjQ7uvyBoJq8xDvb9v0=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Ftj3yulQxL7MpmC3tUrdLLUj2hn8be9QtEoeg7MPY4dwjlUb9MrP22Bai4IYWy6u7
	 KAY8+GOusG+lQKdjBTPjAI0MvTcf1dS2FiTP64UFoTNKLG72nrtTRQzTPbF219tBdv
	 P0+Lj9VN3aZ1uE6IjlvToCIhSQjskLmjSlj2hjRzmIA76bWA1d/G4m/CYncO7wI6hd
	 qf4Bjq8uY2tIt1u+8UGE1SNS2zC4Wki5cq35NlewFEQ6lqmsErDQuSc5JRAcHZcidS
	 Ykgkb7BShLzDwCoqZ9YtyLrxIfoJi1SZAqGVken+8dHCzPdHfHLZrjhN7h5U6F8xnU
	 9VJWnHR5le4IA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E35C643ADA
	for <op-tee@lists.trustedfirmware.org>; Tue,  7 Jul 2026 10:58:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZmoPaXEp;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 644FC618AC;
	Tue,  7 Jul 2026 10:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D591F000E9;
	Tue,  7 Jul 2026 10:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783421889;
	bh=mQON4yUhDZuxb8gaF10sc6vnH8fe+VK9AhY37O8cwS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZmoPaXEpEZQFiYzdoJqj/qbj+DnlI3yBM/H1LIY38fkCEIM4CcXvF3z2dam3dnUwa
	 qKOtg54u7hnFUSzxPotBXi+S+MyolSbY8kNFLOVqzmsx5sOVjdgag7EeoZ8rf+kW5L
	 bsR8Nz8iWCVdCckvF6WTJBvv/3exef9ZhZjXPrbix4/yeLiIJ9V/gRIfKrziOZhBHk
	 tFZctlfL3mBUojs1cno1n8Q4qrmYIcTViuaZ6cY6NXUIA+aj3B7o/wZem3ep8e6u68
	 kD2ds9xF3xjPHN9D/b1EUTNZScVRbjrm8L2WAgWoKAUmqSYXv762cRlXhCs4FV7HIz
	 Z76Lv9I/uupmg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wh3V8-00000002MtZ-2yTw;
	Tue, 07 Jul 2026 10:58:06 +0000
To: catalin.marinas@arm.com,
	oupton@kernel.org,
	sudeep.holla@kernel.org,
	will@kernel.org,
	Sebastian Ene <sebastianene@google.com>
Subject: Re: (subset) [PATCH v9 0/6] arm_ffa, KVM: Fix FF-A emad offset calculations
Date: Tue,  7 Jul 2026 11:58:01 +0100
Message-ID: <178342187223.1892339.1923162787460489447.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702103848.1647249-1-sebastianene@google.com>
References: <20260702103848.1647249-1-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org, will@kernel.org, sebastianene@google.com, jens.wiklander@linaro.org, joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.48 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-2.98)[99.92%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,google.com,gmail.com,lists.trustedfirmware.org,linux.ibm.com,kernel.org,huawei.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E35C643ADA
X-Spamd-Bar: -----
Message-ID-Hash: 73ZQ25J67CU3MF5T3FXYI7KMA22SPABL
X-Message-ID-Hash: 73ZQ25J67CU3MF5T3FXYI7KMA22SPABL
X-MailFrom: maz@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/73ZQ25J67CU3MF5T3FXYI7KMA22SPABL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Marc Zyngier via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Marc Zyngier <maz@kernel.org>

On Thu, 02 Jul 2026 10:38:37 +0000, Sebastian Ene wrote:
> This series fixes the Endpoint Memory Access Descriptor (EMAD) offset
> calculations and adds the necessary bounds checks for both the core
> FF-A driver and the pKVM hypervisor.
> 
> Prior to FF-A version 1.1, the memory region header didn't specify an
> explicit offset for the EMADs, leading to the assumption that they
> immediately follow the header.
> However, from v1.1 onwards, the specification dictates using the
> ep_mem_offset` field to determine the start of the memory access
> array.
> 
> [...]

Applied to fixes, thanks!

[3/6] KVM: arm64: Fix bounds checking in do_ffa_mem_reclaim()
      commit: 8c6db30d79528279abbeb416e4f533f1f91b8724
[4/6] KVM: arm64: Validate the offset to the mem access descriptor
      commit: a6b49d27c17909608d54523220bb6f3498d4a1df
[5/6] KVM: arm64: Ensure FFA ranges are page aligned
      commit: 6a7a181f6921db3d9aed1bba7e15547fefd7eedc
[6/6] KVM: arm64: Zero out the stack initialized data in the FFA handler
      commit: 2bd3c6c702f3a9e2bcb3b536b0fbbaa645005d71

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


