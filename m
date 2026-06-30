Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D10C43458
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 10:21:27 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1669144E66
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 10:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782814887;
	bh=+FdCcdGSvbG17UvdLzYD759HRlwSCrGh4SVfz6aKQ34=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=SbBJCarFLBcDg+bnqyQSjXGhbuU/IBqHjfV1xIudnpI/fFbnPGgoTmuKjw4zwgh6a
	 Kx+wac0FPXAqoRXI1HqdNlR30gg1VmfIYcrJjgY6K8saVsTc+fn340fBCd9ReWA6So
	 cTv01xpFMfQ9/dkQS1AWs/QUWLPe3o4umahvy9+EFx116edg9RH6sJaWQ8nakXXu5T
	 roRivWbfwOp8D+curHwIByckc0fWERN3auyIZvEBMEenVQEtQ5yrxHaFDApKf2sHF+
	 SOFejSz6Yf77xXfOeGCbqgzA93NcwrwuL6x7j4ywrhicnLz0FrFJcqWG9ZhlCWQu/v
	 hvuZUyVxsNzEw==
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 11E2743A64
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 10:21:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=szvYFjjy;
	dkim-atps=neutral
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4924725bec9so26287235e9.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 03:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782814879; x=1783419679; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OJzLaDJYkTsSZ24JLp6E5r3GjL3vXjqVNcTnlWofIQg=;
        b=szvYFjjykP6T85zu54VhXm1L1jIhuYHhG7khm5AA+bYlxfwawdD7sBdelGgd+Ppq0L
         qEkSyh8pZQ+E3TfZEYvnEN3PAdiG4D4eTySXaL7Y8t9Ll28d7LXfChxDKEuTo8vHCBrU
         RV7smG5jGzWrF8I6udlGI8qit/xw3T89sO2QLGeZhOTly4ygeki7UlXNMlqayy13dGdh
         RMcwZ0+FbXcn/w3LUmwazgWjBRX/sR5u0xTlsIoesNamsDzIiXk83XEj8z1x+rhKsdsu
         /rcEFNkx7yLqLpL1oMeySHeRcQiUFz+xPcvpzM2ytTfDbq//kPxS05NsG84+REg/s23U
         bDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814879; x=1783419679;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJzLaDJYkTsSZ24JLp6E5r3GjL3vXjqVNcTnlWofIQg=;
        b=PEWa7wB+hvzrD4HoN28K7gDSq8ysncNixI2gQbFiLcyMFr5GA3MtxsnBM0npqF+rzL
         qa0wsDPvyKRKrrCSqTc53Yk2ek69mEmgXNa8YfGcUUkDtc+4p6rrXy254gMRYwWiurI2
         53PiTalukDvM38YHF91vBDIrHdj7OX+lixs9Iu6SluRwr0uUL7Q8xDWLUi4Q+8+EPVlK
         KP35GgzvwSesezwuGdyf6jjZIUhrN/q6IuNYobnFrbTTj67A70EC5UNjrcJRmcnjSnAw
         qxPWAlJMkWCjBwStD+Er3K02eQsoN7A9y5aeklJ2CikqhlB2UH4wqeoAIN+f+w+BiRNl
         11nQ==
X-Forwarded-Encrypted: i=1; AFNElJ9PmP40BJaKXxjyxVyV46ALoOVXM+hx1k1XvK9RL82+dpr/Zw1pcyJyJTe+7jwbjiIWnJpye88=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwRLhJDO3TO4kcEJS5KtD3PPFYcIuMSr8p1XE5TFtKaakyAdHC5
	svQLUmE2Je5aqWV/QOx3pUJsIHzDWDobVW7T/tGDU6qxfkv7qwDfk01pIK3YY2j6UJAxPCFAA8N
	8a7aBlwNR5CUigDdSuAZOqD1U3jWmuQ==
X-Received: from wrux9.prod.google.com ([2002:a5d:6509:0:b0:46c:cc8e:4391])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3546:b0:493:2805:ae06 with SMTP id 5b1f17b1804b1-493b827cae2mr44265025e9.2.1782814878460;
 Tue, 30 Jun 2026 03:21:18 -0700 (PDT)
Date: Tue, 30 Jun 2026 10:20:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630102058.3219867-2-sebastianene@google.com>
Subject: [PATCH v8 0/6] arm_ffa, KVM: Fix FF-A emad offset calculations
To: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org,
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[sebastianene@google.com,3nphdagwkadclxutlmbtgxgxzhhzex.vhf@flex--sebastianene.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linaro.org,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,google.com,kernel.org,gmail.com,lists.trustedfirmware.org,linux.ibm.com,huawei.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,3nphdagwkadclxutlmbtgxgxzhhzex.vhf@flex--sebastianene.bounces.google.com];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.74:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.74:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 11E2743A64
X-Spamd-Bar: /
Message-ID-Hash: 33K2USBR4RBLQG3NP6PF5BG73SOILJJZ
X-Message-ID-Hash: 33K2USBR4RBLQG3NP6PF5BG73SOILJJZ
X-MailFrom: 3nphDagwKADclXUTlmbTgXgXZhhZeX.Vhf@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/33K2USBR4RBLQG3NP6PF5BG73SOILJJZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sebastian Ene via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sebastian Ene <sebastianene@google.com>

Hi all,

This series fixes the Endpoint Memory Access Descriptor (EMAD) offset
calculations and adds the necessary bounds checks for both the core
FF-A driver and the pKVM hypervisor.

Prior to FF-A version 1.1, the memory region header didn't specify an
explicit offset for the EMADs, leading to the assumption that they
immediately follow the header.
However, from v1.1 onwards, the specification dictates using the
ep_mem_offset` field to determine the start of the memory access
array.

The patches in this series address this by:
1. Updating the core `arm_ffa` firmware driver to correctly calculate
the descriptor
   offset using `ep_mem_offset` rather than defaulting to `sizeof(struct
ffa_mem_region)`.
   It also introduces bounds checking against `max_fragsize`.
2. Enhancing the pKVM hypervisor validation logic to no longer strictly
enforce that
   the descriptor strictly follows the header, aligning it with the
driver behavior
   and the FF-A specification, while also ensuring the offset falls
within the mailbox
   buffer bounds.

While addressing these bugs, Sashiko uncovered other issues that were
fixed in the same series.

All the patches aside from the first one in optee are urgent fixes as
they either impact the hypervisor security or kernel stability.

Changelog
#########
v7->v8:
- dropped the patch "optee: ffa: Add NULL check in
  optee_ffa_lend_protmem" from the series as it was queued by Jens
- rephrased the commit message for "KVM: arm64: Ensure FFA ranges are
  page aligned"
- introduced a helper macro to get the size of the ffa memory region
  based on the used version.

v6->v7:
- taking the patches from Mostafa and sending a new version with the
  collected tags
- Added overflow checks when doing `ep_offset + emad_size` in the arm
  ff-a driver
- Move the length check before the ffa_mem_reclaim
- fix compatibility break with ff-a version 1.0 reported by Sashiko
- add one more patch to fix an issue with the FFA_VERSION call
  that can lead to leaking pKVM stack un-initialized data to
  a host when -ftrivial-auto-var-init=zero is not used.

v5->v6:
- Add fixes tag
- Small clean up make variable declaration reverse christmas tree.

v4->v5:
- Collect Sudeep Rbs
- Add extra patch to check base address alignment.
- Remove WARN_ONs in KVM code
- Use ffa_emad_size_get() instead of hardcoded size in KVM code.

v3 -> v4:
- Address review comments and fix Sashiko bugs

v2 -> v3:
- Fixed typo in nvhe/ffa.c (missing sizeof)

v1 -> v2:
- For pKVM, removed the strict placement enforcement for `ep_mem_offset`
  as it is not
  compliant with the spec, and avoids making assumptions about the
driver's memory
  layout.

Link to:
########
v6:
https://lore.kernel.org/all/20260527150236.1978655-1-smostafa@google.com/
v5:
https://lore.kernel.org/all/20260526151934.3783707-1-smostafa@google.com/
v4:
https://lore.kernel.org/all/20260520204948.2440882-1-smostafa@google.com/
v3:
https://lore.kernel.org/all/20260512124442.1899107-1-sebastianene@google.com/
v2:
https://lore.kernel.org/all/20260430160241.1934777-1-sebastianene@google.com/
v1: https://lore.kernel.org/all/ae9KN9nkOgDYJcGP@google.com/T/#t

*** BLURB HERE ***

Mostafa Saleh (3):
  firmware: arm_ffa: Fix out-of-bound writes in ffa_setup_and_transmit()
  KVM: arm64: Fix bounds checking in do_ffa_mem_reclaim()
  KVM: arm64: Ensure FFA ranges are page aligned

Sebastian Ene (3):
  firmware: arm_ffa: Fix Endpoint Memory Access Descriptor offset
    calculation
  KVM: arm64: Validate the offset to the mem access descriptor
  KVM: arm64: Zero out the stack initialized data in the FFA handler

 arch/arm64/kvm/hyp/nvhe/ffa.c     | 45 +++++++++++++++++++++----------
 drivers/firmware/arm_ffa/driver.c | 25 +++++++++++------
 include/linux/arm_ffa.h           |  9 ++++++-
 3 files changed, 56 insertions(+), 23 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

