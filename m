Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EC5C43458
	for <op-tee@archiver.kernel.org>; Tue,  7 Jul 2026 14:04:53 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0857144F84
	for <op-tee@archiver.kernel.org>; Tue,  7 Jul 2026 14:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1783433093;
	bh=2wUNMdFEMEiPLAe1GVpIniuPQq9WqUwfzlszraiTpWM=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=C+AACnzaH1tZ+k4TyW1k3ocv/owwYL/4K0SpgXzZW+6zdjvJP/jLUAhqPagoIBiVA
	 b6wVJ9bYGjPUGzn3s8S7ADMlv42nmcQEaTBu1PUtbFNeHtXMCxktr977Uo3VtXMdtL
	 +ggM3jWyGvc4k7eQJIdCw2vhwOtdMemcej2hJNhEUYs5KCFq20fKiT+AKRQ9kUA1lO
	 hrtfHNTwvLdfYR5HC8O5z+wF5tEbrJf4usyeIKd3Qxno6QGVBACFMnwih16YAWioXm
	 /7inKGBTmAXWl9o/bQB2CpvRlmodSJUnCY/N7PH2PPLeoY9kJxuvugmxjYGSrKG0J0
	 Q8d8hVAeh6lnQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0C02E43815
	for <op-tee@lists.trustedfirmware.org>; Tue,  7 Jul 2026 14:04:47 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VORi0ayZ;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 64A4041AD9;
	Tue,  7 Jul 2026 14:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B551F00A3A;
	Tue,  7 Jul 2026 14:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783433086;
	bh=sWmdVczZNzTBvgYhqBLWG38saCe5L4qLnfo2fRbcBuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VORi0ayZvl8ZkSGFQeQ8nBgFBrpg7rJs7lS5cMipb05PoCqrRz4wKHl7lV0HnRwht
	 ausRGdW5rPZMzkFasC5B6rbmnkEh386iZNFBShkAnlWhXeld5ma4dY9JlP8x9eOZfC
	 G1hbl8M8jzNRrrf8VKMlIBuaGoOf0yq0Xub8HdtATAMJasbiamW18BVAuKR0DBp7mT
	 4UtdUBw6lZ2a+qQMT1EQ5r6501wpBo231CmAQjnfp9qQDWSCsis4A5udIiI4rxUHEg
	 YMTBm3nnsu72cR0FeeeQP+JggA5Uk66UAejpVW4RUm0ylRRg4Yz5QFo32DYlBrXqRp
	 Ck452iwzZgf9g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wh6Pk-00000002RIJ-0evq;
	Tue, 07 Jul 2026 14:04:44 +0000
To: catalin.marinas@arm.com,
	oupton@kernel.org,
	sudeep.holla@kernel.org,
	will@kernel.org,
	Sebastian Ene <sebastianene@google.com>
Subject: Re: (subset) [PATCH v9 0/6] arm_ffa, KVM: Fix FF-A emad offset calculations
Date: Tue,  7 Jul 2026 15:04:37 +0100
Message-ID: <178343306571.1899612.18300071098746030610.b4-ty@kernel.org>
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
X-Spamd-Result: default: False [-7.50 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
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
X-Rspamd-Queue-Id: 0C02E43815
X-Spamd-Bar: -------
Message-ID-Hash: AN2NPRYO6QHTCEL5P4PA77IRCZ2CFYEI
X-Message-ID-Hash: AN2NPRYO6QHTCEL5P4PA77IRCZ2CFYEI
X-MailFrom: maz@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AN2NPRYO6QHTCEL5P4PA77IRCZ2CFYEI/>
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

[1/6] firmware: arm_ffa: Fix out-of-bound writes in ffa_setup_and_transmit()
      commit: 3383ffb7ef937317361713ffcc21921a7848511a
[2/6] firmware: arm_ffa: Fix Endpoint Memory Access Descriptor offset calculation
      commit: b4d961351aa84fdf0148783fb1f3a1391b8a0adb

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


