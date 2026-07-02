Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC54C43602
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 10:39:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 57C6344E14
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 10:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782988743;
	bh=40zV5nNeu4DWVyIoe1XkZE2dt6wRM/YAhZpzs4jqqs4=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=pcXpqTmJg3ngtJPDKP+7L1i+fhfm0iVyDF4ZZChOW1ODIzQVoZ/8w7nBxmXClfliQ
	 f88n1u/4ykLFDARouA3DwIxQasDg/7qelsUKBRzOS28+qpRl35MKw4lxKNw5Trsalo
	 6AGayzOpps9Qnb/mn8N20zeTJMlAo+CIaao0SmMS/I/ZT7EtO/fUGJZ1oN/AUKD0QW
	 fA+TLMGiFQ2j7x7JUs/za1EcLhGpAWR7Hw2lDk4wsm8PpnC3fVdutmDevcSW/pgqFz
	 7AEjpnGKYoJQGXZGFn+LIQjoe1RkEgWGddkR+6YThnN4vfK2bXAuNd+LaseavyLPXj
	 su/z5GG881uCg==
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4E84F43B5A
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Jul 2026 10:38:57 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WQJ66Vpu;
	dkim-atps=neutral
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c1288e572c9so176154066b.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Jul 2026 03:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782988736; x=1783593536; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rYY7gICYK6mnr7SZ0h8JVgwFO2ykA+NhgpS4kfMsPR0=;
        b=WQJ66Vpua7abG5gkK6spNbDW6Y2Inx7bJcTUJdp4vTOXh3gKewEUskfFZCc09SuyUM
         tnp+rRPQbpAWaBd4kJWPwspMC32H0Qv6VdTDMGM8KP+Cq2vQHM96Be0LtBYwV7oHLFHP
         R36q4/vD5UzFk1GKkdB3IUcjWY3/mX5Wo5ke+WvgQQlu6IL+OJXYBod4TTfMttbZst88
         gZqlu57eEpFpxTTNfcs0Yg/MRWcLMYGaDjQ58+b3lW3pjom2huIJVn23BiD7D5bLcHQK
         Y1TyjGmb4wGnfdAs2vII8khrolDzKr7KzmxMuNmvBMUIJ9YqLnU5FKsmiEUWkT9bTee/
         h1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782988736; x=1783593536;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rYY7gICYK6mnr7SZ0h8JVgwFO2ykA+NhgpS4kfMsPR0=;
        b=nre+J0UxVp5rLxjwrjONNj5KO8u6Ezi06I1vMT+Hj6K31Npu4xzCAisduVO6B55P3F
         DjuYiP/pMWUyDkRTDCci6kpdyb6n+dTFsRtkTu8Icbo7VvsfXlJOpXbbfQxZsEXuNrd6
         9PLlvTrI79GpN5PRTINSFiq+LZyQQ9+CUVZ4hsng9R1UgYwUvByjO0I2Y/M622DAFKNn
         jy47B89epKCgmYiJwzT9OU5W1rEiQRTFY+C0nrfLvQdZYC8S6PHgRPCb/LkvKDp5aukz
         7Jjydntv+BBxAnQx3F8cS9vRJbrwRuD62ohtgrsNrPqsd5XQpP2cYFqd0V7QgRSNSBC1
         zFWw==
X-Forwarded-Encrypted: i=1; AHgh+RomwOP9tj7UVFXGZ+hXZU+pDyc0RIUxWj5gpH58dGieJFbl8nIy5Wk7mCeSqJZ1nOzms8jwFlE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwohM325Nu8ZTfIuXWN3jqIVsXkqg6eQDOJfitjWPQD2P4Fzg2I
	kLQlx0zy6ARx2TVLH50yuap64Goe6sCnCcdgH5XmWz9sqxNdUfVo/n+uNjcCrUVGkHvweZ/YgFd
	aewqJAeAkJIfUh5K8K3m2lZMsJ+g/pA==
X-Received: from ejn3.prod.google.com ([2002:a17:906:583:b0:c12:a94f:8b78])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:46cc:b0:c12:93ed:47dc with SMTP id a640c23a62f3a-c12ae7bb5efmr165217966b.40.1782988735859;
 Thu, 02 Jul 2026 03:38:55 -0700 (PDT)
Date: Thu,  2 Jul 2026 10:38:37 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702103848.1647249-1-sebastianene@google.com>
Subject: [PATCH v9 0/6] arm_ffa, KVM: Fix FF-A emad offset calculations
To: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org,
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.80 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[sebastianene@google.com,3vz9gagwkalaiurqijyqduduweewbu.sec@flex--sebastianene.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.73:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,google.com,kernel.org,gmail.com,lists.trustedfirmware.org,linux.ibm.com,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,3vz9gagwkalaiurqijyqduduweewbu.sec@flex--sebastianene.bounces.google.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_BLOCKED(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.73:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4E84F43B5A
X-Spamd-Bar: /
Message-ID-Hash: 3G4YQICOF6MR4JUVXEUDXTMA2IZQDYIS
X-Message-ID-Hash: 3G4YQICOF6MR4JUVXEUDXTMA2IZQDYIS
X-MailFrom: 3vz9GagwKALAiURQijYQdUdUWeeWbU.Sec@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3G4YQICOF6MR4JUVXEUDXTMA2IZQDYIS/>
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
v8->v9:
- addressed Sashiko double ffa_rx_release in "KVM: arm64: Fix bounds
  checking in do_ffa_mem_reclaim()"

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

v8: https://lore.kernel.org/all/20260630102058.3219867-2-sebastianene@google.com/
v7: https://lore.kernel.org/all/20260617145130.3729015-1-sebastianene@google.com/
v6: https://lore.kernel.org/all/20260527150236.1978655-1-smostafa@google.com/
v5: https://lore.kernel.org/all/20260526151934.3783707-1-smostafa@google.com/
v4: https://lore.kernel.org/all/20260520204948.2440882-1-smostafa@google.com/
v3: https://lore.kernel.org/all/20260512124442.1899107-1-sebastianene@google.com/
v2: https://lore.kernel.org/all/20260430160241.1934777-1-sebastianene@google.com/
v1: https://lore.kernel.org/all/ae9KN9nkOgDYJcGP@google.com/T/#t

Mostafa Saleh (3):
  firmware: arm_ffa: Fix out-of-bound writes in ffa_setup_and_transmit()
  KVM: arm64: Fix bounds checking in do_ffa_mem_reclaim()
  KVM: arm64: Ensure FFA ranges are page aligned

Sebastian Ene (3):
  firmware: arm_ffa: Fix Endpoint Memory Access Descriptor offset
    calculation
  KVM: arm64: Validate the offset to the mem access descriptor
  KVM: arm64: Zero out the stack initialized data in the FFA handler

 arch/arm64/kvm/hyp/nvhe/ffa.c     | 44 +++++++++++++++++++++----------
 drivers/firmware/arm_ffa/driver.c | 25 ++++++++++++------
 include/linux/arm_ffa.h           |  9 ++++++-
 3 files changed, 55 insertions(+), 23 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

