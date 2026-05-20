Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5719CD4F54
	for <op-tee@archiver.kernel.org>; Wed, 20 May 2026 20:50:01 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0B51344E79
	for <op-tee@archiver.kernel.org>; Wed, 20 May 2026 20:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779310201;
	bh=O8asY9iehL0nCxQ7X/jU9CAwMx7UcWlswYFwKXvB8Fc=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=CyG4KZ6Da5sYkydirtHqJrI+TooJNWHVQhtAL4n97mDnTEqGIGVshxa8y6t1BP1JE
	 a0+DNMowm+X/KG7K+PiosPbsTuLZHKIQfyx7vT6oP7nC9t0DFmBS3wbpkNcDB6cIg1
	 clKZ+p1FpHY9MiqGH9bQuecv6CDPMyIdpCzgSV4ifCGSduEp2NC0JaJdHJSbv6O+sV
	 BCjO6kkP7uYa7QxlaVh8Sa11mPIF68LNTgkw//UBv8fGT/3upEvRVlyG6kwJdNINoJ
	 gf34deRLQqoh7ot5mZclUovIRN+TpkqOlUV/0qXB/nlhwzyDVonf8jWPlMKFJ1x0tl
	 loWidVcWU2DpA==
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 47971432A9
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 20:49:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WqH+Wk3b;
	dkim-atps=neutral
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48919890a95so27949335e9.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 13:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779310193; x=1779914993; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pLV0D8OV4jhyDEJovr2ZsBSnuczUGhYNsjjzP+Stc4o=;
        b=WqH+Wk3bOrCiBk18b4iYKbiAkuhByrs5C4MnaAk618Gdom5W4bPywN8Q11gLQr6jWh
         /+1GCy3d/V0HLzmlVBlDB0WBs05PceDUiNFXm2O1VmXlmro6JRY1JtzIx0Ip085s6aRw
         uLc63qbRVLXtD31mgYdFyoCdzI8v/cHI0mOvc6n/kSaczPY9zj82SvPNFoBGUbROlmd1
         2jmLnHGGnmVj2cqul1i+xMOL/F1e/wrXCOog0miMTsct0eQlUZ9JW5n0HCIllEKPOJ56
         hoST6NcNs6Pg9wP7+6Ey37eQvEnhgbvniFXFTcUU/i4buVXCCp3sWgFRYIhdmCZgBVRr
         TqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310193; x=1779914993;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLV0D8OV4jhyDEJovr2ZsBSnuczUGhYNsjjzP+Stc4o=;
        b=sqRmxJr9bTAkoF+F+hJnbxPfnT81WiZ3SMwi3DPDBiFf0bNXF1ekHPjE6gLCLbS+It
         GFTbGRpb+kAVQvk8Wue7hbTGVBU2qBrfM29SgsGFYcgHZ7AOI+jt7Vw6fJ8QjQgo7CJ4
         taaO7ePIWcjabvYg/trtO/p9IR2BbsFfUtX0mxzkkQO6NNDJJEJeBqMR67lEil1GiJi7
         E3UuMzmygMJ72ZguXHSttvivT2b4Q9Ncw5ZCt9Q/rH4yG/y3upvCSZ7BD75H4gENBrjf
         /hyvQn0P1VIImt/Jo3gPGGrMjX11MuvGYZ71GDD90MV8Bf/PUN3C1cjqJ0uuBJG0lBxm
         Vg5A==
X-Gm-Message-State: AOJu0YydbJokdacbV0lmhp2CPoua/SaG+s8C8QkdFEXX2kvwPVzgKwmK
	VcoUWon77+mEG8xzCnXQ66qZiB1tpd/DngKdJJ4j5a8ebGT0XuJb50q1y5GngW3T3JMAUoOh9r3
	bj4H48BS3B7j7hGLomKaE2GMaXRYcKJRefojI97yzR/CRAyKYP+USj82CmzAjwWfj/sVm2ObJya
	btM+nWF4Ian/sNTlHZwQfhi52opEJegn8PKsXfoAIWg/zNKUlXOUPzLUROhu7M
X-Received: from wruh9.prod.google.com ([2002:a5d:6889:0:b0:444:bd72:fec6])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:138f:b0:488:ae6c:42c6 with SMTP id 5b1f17b1804b1-48ff4f4f44dmr311573965e9.14.1779310192858;
 Wed, 20 May 2026 13:49:52 -0700 (PDT)
Date: Wed, 20 May 2026 20:49:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260520204948.2440882-1-smostafa@google.com>
Subject: [PATCH v4 0/5] arm_ffa, KVM: Fix FF-A emad offset calculations
To: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[smostafa@google.com,3cb4oaggkbj0rlnrszezfnnfkd.bnlno-sddkhrsr.sqtrsdcehqlvzqd.nqf@flex--smostafa.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.74:from];
	ARC_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,3cb4oaggkbj0rlnrszezfnnfkd.bnlno-sddkhrsr.sqtrsdcehqlvzqd.nqf@flex--smostafa.bounces.google.com];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.74:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 47971432A9
X-Spamd-Bar: --
Message-ID-Hash: ZOLH2GYK7D2H4SDY5BD4KIKQDEGJWNW7
X-Message-ID-Hash: ZOLH2GYK7D2H4SDY5BD4KIKQDEGJWNW7
X-MailFrom: 3cB4OaggKBj0rlnrsZeZfnnfkd.bnlno-sddkhrsr.sqtrsdcehqlvZqd.nqf@flex--smostafa.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org, Mostafa Saleh <smostafa@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZOLH2GYK7D2H4SDY5BD4KIKQDEGJWNW7/>
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
v3: https://lore.kernel.org/all/20260512124442.1899107-1-sebastianene@google.com/
v2: https://lore.kernel.org/all/20260430160241.1934777-1-sebastianene@google.com/
v1: https://lore.kernel.org/all/ae9KN9nkOgDYJcGP@google.com/T/#t

Mostafa Saleh (3):
  optee: ffa: Add NULL check in optee_ffa_lend_protmem
  firmware: arm_ffa: Fix out-of-bound writes in ffa_setup_and_transmit()
  KVM: arm64: Fix bounds checking in do_ffa_mem_reclaim()

Sebastian Ene (2):
  firmware: arm_ffa: Fix Endpoint Memory Access Descriptor offset
    calculation
  KVM: arm64: Validate the offset to the mem access descriptor

 arch/arm64/kvm/hyp/nvhe/ffa.c     | 30 +++++++++++++++++++++++-------
 drivers/firmware/arm_ffa/driver.c | 21 +++++++++++++--------
 drivers/tee/optee/ffa_abi.c       |  3 +++
 include/linux/arm_ffa.h           |  2 +-
 4 files changed, 40 insertions(+), 16 deletions(-)

-- 
2.54.0.669.g59709faab0-goog

