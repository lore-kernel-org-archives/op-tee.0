Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F4DCD5BC8
	for <op-tee@archiver.kernel.org>; Tue, 26 May 2026 15:19:54 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C90CE44AE9
	for <op-tee@archiver.kernel.org>; Tue, 26 May 2026 15:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779808793;
	bh=kViNV8bt1ZUesG6y4m7RkUFq2YymwQWHXWgrRE5dr7w=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=kqpXUpAOVJX0oWYSBSb/SZcSvmi9+kmTfKVHuLAnQ3GN67GALrE0QaJkBDcmyDnT8
	 p8Vx66VNCysxPM2Pm134RjlfhxaOyaQw38kKfCbMTSUcMPcXze3p7LBpyIzSBmXB/Q
	 oObPwZzygU5v83NzIc9uEvFL9VRWuIpT+rLszQA7PrcskfuAIF2eTil2fp9+G2NMj7
	 xL2q5gaJhfkwcegt6dQfe4Ww4UYatI2TpmkIPT8aNHc52NpPGVxsD9roAIv+dNaTsb
	 sUAtIdFbEoReQImg2vZpIIUa9N6KKZBAdjgmV+rehJ/4oisQAzzYQH8VjyvXMsJ9BY
	 VSQzq5VLN3vPA==
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1ECB04326C
	for <op-tee@lists.trustedfirmware.org>; Tue, 26 May 2026 15:19:46 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=I95LFEBw;
	dkim-atps=neutral
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-45ea19f2564so5459033f8f.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 26 May 2026 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779808785; x=1780413585; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lrWlfTK5Lutt6aW80bi7cx4j7i0TUVnce7pHBOYoWwo=;
        b=I95LFEBw1gYT65un5rcgiXYTDoj/lhHKumtwkZlfD1bWZMQFPjr+OvrMXYnFqdZWpH
         nLTgCU5fCfBVtMc3/x0AuSHeKdXW1d93kMcnYSmwDUZGk9avbz3rBfN6jRiSXJzdU0Gt
         IJzPdDuTayBblDRm01UxsKKRISfzja77WcKKLw+J9ns0eVf6boOibb70pEwRDF2xGYQq
         D6q6lPgN6sNuBulxx91Pf95xKijmUtagPn8uOVfMnVfa/1Iu41qAebhUipd73FNFjjqf
         VKE0rxC/Aa6oXHATiITvmaovI2UCbZqA6MHPzA8J4vDyUruhBIKhRobpOBGO0x9Hy2MW
         +QGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779808785; x=1780413585;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lrWlfTK5Lutt6aW80bi7cx4j7i0TUVnce7pHBOYoWwo=;
        b=kANFvDiVzUYzKJO0Q2dsMMz8Otx1YAn7/6zjGz2T4fN1EjJRdtMaSdyPhT0Hu+eZbK
         1Si6oM78/vbWSH83c0ZMbPZGgGwJuDRX0/CcRGQRo+fcgF0qW6nMSO3oouNxSxgbBxTW
         v4zg835O6P6o366J8dzik9QhInWTW6bM5QZ586QOwMf+zX1wJSfi4IfIAen4ejAxeHdK
         9nwDOsOzkwxRQugW110kkH3F4Y2v0sfICSO4FTfDRIMpmEwz+kOUbuLdVPORJJ4IE5ci
         a2jZdLhZo6tYSGRMWK/JpWGCpxYHOParwDDrPn3EN64zSvXq2H1U2z1zt8sK9P6jSRm0
         o0RA==
X-Gm-Message-State: AOJu0Yye0V+jXYUrIw4nKAvMK0aMvP1Pq6IJphcCu8LLl/BVWLPvXL/E
	AylYKhRfCY/TU/SuIHLVNlOEQPvEY9SSTD2qL9NUnX2F6krNcTN5YvfYPHdIwNPUqmDYhjvBWg8
	y8B2Mix3IpEJdzTEAsqDMokCRi9IemOPL9X66tm6Pmq4Jlh9tdJV2dvHToYWZxOThpyoy8nnuie
	b4ANPI5cRpolhEMjJrSlWX+SO1tMt9+gkq+tgeBFRxIv27mdwBiBKFrB8bQNHO
X-Received: from wmbem24.prod.google.com ([2002:a05:600c:8218:b0:490:51ba:4f8])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4511:b0:490:6869:46c3 with SMTP id 5b1f17b1804b1-490686947bemr126353045e9.30.1779808784404;
 Tue, 26 May 2026 08:19:44 -0700 (PDT)
Date: Tue, 26 May 2026 15:19:28 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526151934.3783707-1-smostafa@google.com>
Subject: [PATCH v5 0/6] arm_ffa, KVM: Fix FF-A emad offset calculations
To: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[smostafa@google.com,3elovaggkbjmhbdhipupvddvat.rdbde-ittaxhih.igjhitsuxgblpgt.dgv@flex--smostafa.bounces.google.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[15];
	NEURAL_HAM(-0.00)[-0.238];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.74:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,3elovaggkbjmhbdhipupvddvat.rdbde-ittaxhih.igjhitsuxgblpgt.dgv@flex--smostafa.bounces.google.com];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[google.com:dkim];
	DNSWL_BLOCKED(0.00)[209.85.221.74:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1ECB04326C
X-Spamd-Bar: --
Message-ID-Hash: KTG7KMFY4FCWMMHLNMOOFC2L6XGP4TPV
X-Message-ID-Hash: KTG7KMFY4FCWMMHLNMOOFC2L6XGP4TPV
X-MailFrom: 3ELoVaggKBjMhbdhiPUPVddVaT.Rdbde-iTTaXhih.igjhiTSUXgblPgT.dgV@flex--smostafa.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org, Mostafa Saleh <smostafa@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KTG7KMFY4FCWMMHLNMOOFC2L6XGP4TPV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mostafa Saleh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mostafa Saleh <smostafa@google.com>

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
1. Updating the core `arm_ffa` firmware driver to correctly calculate the descriptor
   offset using `ep_mem_offset` rather than defaulting to `sizeof(struct ffa_mem_region)`.
   It also introduces bounds checking against `max_fragsize`.
2. Enhancing the pKVM hypervisor validation logic to no longer strictly enforce that
   the descriptor strictly follows the header, aligning it with the driver behavior
   and the FF-A specification, while also ensuring the offset falls within the mailbox
   buffer bounds.

While addressing these bugs, Sashiko uncovered other issues that were
fixed in the same series.

Changelog
#########
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
- For pKVM, removed the strict placement enforcement for `ep_mem_offset` as it is not
  compliant with the spec, and avoids making assumptions about the driver's memory
  layout.

Link to:
########
v4: https://lore.kernel.org/all/20260520204948.2440882-1-smostafa@google.com/
v3: https://lore.kernel.org/all/20260512124442.1899107-1-sebastianene@google.com/
v2: https://lore.kernel.org/all/20260430160241.1934777-1-sebastianene@google.com/
v1: https://lore.kernel.org/all/ae9KN9nkOgDYJcGP@google.com/T/#t


Mostafa Saleh (4):
  optee: ffa: Add NULL check in optee_ffa_lend_protmem
  firmware: arm_ffa: Fix out-of-bound writes in ffa_setup_and_transmit()
  KVM: arm64: Fix bounds checking in do_ffa_mem_reclaim()
  KVM: arm64: Ensure FFA ranges are page aligned

Sebastian Ene (2):
  firmware: arm_ffa: Fix Endpoint Memory Access Descriptor offset
    calculation
  KVM: arm64: Validate the offset to the mem access descriptor

 arch/arm64/kvm/hyp/nvhe/ffa.c     | 38 ++++++++++++++++++++++---------
 drivers/firmware/arm_ffa/driver.c | 21 ++++++++++-------
 drivers/tee/optee/ffa_abi.c       |  3 +++
 include/linux/arm_ffa.h           |  2 +-
 4 files changed, 44 insertions(+), 20 deletions(-)

-- 
2.54.0.746.g67dd491aae-goog

