Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933AFCD98E2
	for <op-tee@archiver.kernel.org>; Wed, 17 Jun 2026 14:51:46 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BFB3044982
	for <op-tee@archiver.kernel.org>; Wed, 17 Jun 2026 14:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1781707905;
	bh=ONZSxhFlHjrCEE9Fm6phM5SqH29oxrERKV/bEQ6mXxo=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=hsAwDNo9YEC0zzl5F3iOm8UzRC49wCYoqawjh2ctsc1ltxA7YeLARQGso5uaJTtDh
	 gCUcQCm0T5hSmY/9tkAILGDGkGJ9BoiZOsJa70AWRS03yR/afuCHES0ebfZ/nZ8w96
	 lhj4O+2Majq8JDLgasCMfxce1CsGaojHwRkEEQ5VKLcMoxYUHW9fJUX6Hdg4rfb+e+
	 ffbx7sq0oGDF6pDeJCPSJsyqQFGmupgnu/YQLrQGj1BUNMKtp2ab+FLeenTsPgEKvL
	 aPD62tCo4Hwoe0zWGNzM5cac7opF48iCqTiK1c5GHAhKt5chBNQFBZ1uYJGOKzczPU
	 JXvNGZC5ZCiyw==
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5721143730
	for <op-tee@lists.trustedfirmware.org>; Wed, 17 Jun 2026 14:51:38 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=CJSLijgZ;
	dkim-atps=neutral
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-461a159d77aso805162f8f.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 17 Jun 2026 07:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781707897; x=1782312697; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DRCIDgfvyWb8F6dd51kKp09a/LacrvNUI0KU4btuiv8=;
        b=CJSLijgZ43wYVeoCgZNXqV/cGH2kQz3QQIchjYf/cCRJbiyuuCR1npCY/q3PkZRfq7
         omyKk0C6RAYDy0/sGLVTEzaQsxw2HDkP4+EslI//1H2TJGs58rq53zEK22hHZN1hS2rc
         14PvejExG5Rs81OyjWgW8tmbL+EaWCki5xHhrtAT4+syqERfRwohJFJ4GTMu3EhMr7B7
         ybeKcCvAfULIW+x4d28IaP0sIDwZ7FVv73D/ERHHngYTFaBPja0oZSUtEEeuRegsW1Uv
         M9qXUbjr9G6S7ZUmApL/aqU/pZZjDudHnNi2frpykgTGDOOPojJYF/Cz8Y8C/X+Nahb3
         di5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781707897; x=1782312697;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DRCIDgfvyWb8F6dd51kKp09a/LacrvNUI0KU4btuiv8=;
        b=C8MmXkXj0PkMhaKG4LQPwnxHA2QX64csX8eFRwOCBvRgt2Bqh+vEKZ44sx2vPlYEGp
         9lSEa+KJWNzB8JBydJUqvWIcSFTBOViMHFvs5gWX+s/fqufDMNdO2KaNvt2ieIw/tXjx
         hdmN7DlOJ6Rab6Imzp253JgkNpBAcja9fEhis0KtY8UHeUd0NRBZGfW2AzLfQtXdv9TK
         Vgc5z7fmIOzzN2KVeBPOOKPn3OYWe8QE7/a5yWjQFBY+C3HNDwUvr9p2/9s/YLpc3lS5
         7gXSpk7Zbwwa+9GNlOG5krgbsQO2Eon8PtUnXHddaKcUzRcZaFQgt+veQYQL6RmfEGnP
         w08w==
X-Forwarded-Encrypted: i=1; AFNElJ+qq/KzL3jcZtTvpH5X77wdHazK9TTC4wvfr7fbHMUs1HRwMmxi5ss7aQ/MkIujsi55jIslxCs=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yyt9/+g0E06YAeLIzuQVRUz+q36IoWT9P0zTsjwymTN032jfAk5
	5YkqijFegmraa7fsObUpkAbPm3BOs6DXobJ5UzLZiG603CmC0NYBGUMG3xHIxOcm0QJ8ZZ5Jn0p
	bg2kXDkKd3UsTcc2iNhcTsjWSTcEpbg==
X-Received: from wrsi9.prod.google.com ([2002:adf:fdc9:0:b0:43d:677d:1980])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:edcf:0:b0:461:bfd6:510c with SMTP id ffacd0b85a97d-46235e9ae48mr6358501f8f.3.1781707896957;
 Wed, 17 Jun 2026 07:51:36 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:51:23 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260617145130.3729015-1-sebastianene@google.com>
Subject: [PATCH v7 0/7] arm_ffa, KVM: Fix FF-A emad offset calculations
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
	FORGED_SENDER(0.30)[sebastianene@google.com,3elqyagwkaauxjgfxynfsjsjlttlqj.htr@flex--sebastianene.bounces.google.com];
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
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,3elqyagwkaauxjgfxynfsjsjlttlqj.htr@flex--sebastianene.bounces.google.com];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.74:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.74:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5721143730
X-Spamd-Bar: /
Message-ID-Hash: MV5GK5ML2BDMGJHTPTN27Q7N3YLPQLHG
X-Message-ID-Hash: MV5GK5ML2BDMGJHTPTN27Q7N3YLPQLHG
X-MailFrom: 3eLQyagwKAAUxjgfxynfsjsjlttlqj.htr@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MV5GK5ML2BDMGJHTPTN27Q7N3YLPQLHG/>
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

Mostafa Saleh (4):
  optee: ffa: Add NULL check in optee_ffa_lend_protmem
  firmware: arm_ffa: Fix out-of-bound writes in ffa_setup_and_transmit()
  KVM: arm64: Fix bounds checking in do_ffa_mem_reclaim()
  KVM: arm64: Ensure FFA ranges are page aligned

Sebastian Ene (3):
  firmware: arm_ffa: Fix Endpoint Memory Access Descriptor offset
    calculation
  KVM: arm64: Validate the offset to the mem access descriptor
  KVM: arm64: Zero out the stack initialized data in the FFA handler

 arch/arm64/kvm/hyp/nvhe/ffa.c     | 47 ++++++++++++++++++++++---------
 drivers/firmware/arm_ffa/driver.c | 25 ++++++++++------
 drivers/tee/optee/ffa_abi.c       |  3 ++
 include/linux/arm_ffa.h           |  2 +-
 4 files changed, 54 insertions(+), 23 deletions(-)

-- 
2.54.0.1136.gdb2ca164c4-goog

