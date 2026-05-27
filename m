Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B643CD5BD0
	for <op-tee@archiver.kernel.org>; Wed, 27 May 2026 15:03:46 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 910094380A
	for <op-tee@archiver.kernel.org>; Wed, 27 May 2026 15:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779894225;
	bh=ByxUlFkD9YwcgGZp3oksyBn5vqJvrUeByVIcogipJNQ=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=RHAl7H0UGOgdTg3IPEVdWDD/JI7qrE0Xcm2YH+kOGgdRiOdD35zLtM3A3zhiOpo9E
	 9/ikPjlBa9Bupv8V4sX8SVKvohloVfxa2K+9x2Vxy8buPfOLaP1jZiKgtcyD/XLjLa
	 01OL6UavRxCqkOZ9phhzqjv69f2bFxN8LFKcqZ4Shf/zEYHCJNrd0tdik+5NNJVtw5
	 h5wyNKhhqcaz25IhNdJervA+i8a/opf2TaNfuoI9McKfYKj6GX71+C47y+3HHIK8Ax
	 1fC0TlIytpQAK64d0d9tyDUt2K82k8N1jv7V2mWsaQtSEdkGd4pK9UhK2R5M9yLgM7
	 l4z0p1cIQMG7Q==
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 656FB436FD
	for <op-tee@lists.trustedfirmware.org>; Wed, 27 May 2026 15:02:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ORetSiJc;
	dkim-atps=neutral
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-67e9db60e1bso10861575a12.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 27 May 2026 08:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779894160; x=1780498960; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t0KYYgCqaB1EQ6tWG+L5HeJwzgQqF0UPRi4lIJbh6P8=;
        b=ORetSiJcF63+h5I60JZUtK4m89tHYCE5s62RcqWofx3sRuR7RxFEd9E9gE8bROH5DE
         ZV7lqVvlb1oJvAntSCaw3uyL9B0WFi192Es//PFTPww3s1GXrHgRTcsT7oEC/CyUol7Q
         zssBW+hin4XYhvTf+hrErZ7cR95/tuwz+yENV+BO6ah1vcn6YxpXmA1gBZ8fnutB+AlX
         KB+EtHGC/qloktVo8UGNx31mM28qJ9ficX6G0dE+dtG55Oc///LqiQFDTFf8csMDlTgX
         TLBvqqZvwsxcNrxylNintvVCKWVyVhq93jWhmFGmbEoMzpECdszVFjfpxpoo0nz1Buax
         NEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779894160; x=1780498960;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t0KYYgCqaB1EQ6tWG+L5HeJwzgQqF0UPRi4lIJbh6P8=;
        b=aYLwligOMz3RVo6hCh8qwIGDmf+Rf4zWxzds2MzCscnU4K5obCVuwoXhXGOztBBsUD
         zF8sheuFFNSdTkVo/Cw3a02x96exqVxrsV/4qnOBlCeBQ3vtK5MtoxS8etKWBrxFumHN
         XFOMrDkPJdBbMMpYcsra1LP3FeEehvCVWsOcfzNQ+56K9uk9gTvSMlKGFpS1zlk4/hSY
         Kw0tk7ZaTw25RUidFucgtUc53LX4U8psBV+r92TdZYy3oJnXNOPQSUkMCZPhEV9oju/F
         Vo9X65UbuCD+Of5AWgQYNRV0BoUE1zSboqkGGheThy/ER4HBQReMCa2/vDV/IcsmS+mn
         VyNQ==
X-Gm-Message-State: AOJu0YxCIGj8MzuQit+LiQ/cu/U7lDJcGdve6nttCALl4Q733CqNxi+9
	Tw6XatDKizC1LPHXGiDCgzetB10HHg8QYGKnobnzKhOXSj8suQPlvCC//8gEuGOeXmspaemhvD3
	ggYfluRpZQHlU7h5QgAFUXshelGRiP41HmhRc/YBe/LY8ApQ46QAQSaMFMhOo7/fYNDZo9Hqgxb
	lsYOIPG41K25aJMg3gMzwKs5ufxbmHQ+mctS8aiXa2Uz+jMuVMLL0AdzG0yt8g
X-Received: from edho11.prod.google.com ([2002:a50:c90b:0:b0:687:b8fd:7b67])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3249:20b0:68a:57f1:44e2 with SMTP id 4fb4d7f45d1cf-68a58107b1cmr2314665a12.7.1779894160042;
 Wed, 27 May 2026 08:02:40 -0700 (PDT)
Date: Wed, 27 May 2026 15:02:30 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260527150236.1978655-1-smostafa@google.com>
Subject: [PATCH v6 0/6] arm_ffa, KVM: Fix FF-A emad offset calculations
To: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[smostafa@google.com,3kacxaggkblmd79dev0v19916z.x979a-ezz63ded.ecfdezy03c7hvcz.9c1@flex--smostafa.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[3kacxaggkblmd79dev0v19916z.x979a-ezz63ded.ecfdezy03c7hvcz.9c1@flex--smostafa.bounces.google.com:query timed out];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,3kacxaggkblmd79dev0v19916z.x979a-ezz63ded.ecfdezy03c7hvcz.9c1@flex--smostafa.bounces.google.com];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.73:from];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.73:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 656FB436FD
X-Spamd-Bar: --
Message-ID-Hash: EFIASCUZZIX7FHSNULIFRP6ELPDTEMFH
X-Message-ID-Hash: EFIASCUZZIX7FHSNULIFRP6ELPDTEMFH
X-MailFrom: 3kAcXaggKBlMD79DEv0v19916z.x979A-Ezz63DED.ECFDEzy03C7HvCz.9C1@flex--smostafa.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org, Mostafa Saleh <smostafa@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EFIASCUZZIX7FHSNULIFRP6ELPDTEMFH/>
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

All the patches aside from the first one in optee are urgent fixes as
they either impact the hypervisor security or kernel stability.

Changelog
#########
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
- For pKVM, removed the strict placement enforcement for `ep_mem_offset` as it is not
  compliant with the spec, and avoids making assumptions about the driver's memory
  layout.

Link to:
########
v5: https://lore.kernel.org/all/20260526151934.3783707-1-smostafa@google.com/
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

