Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E01CD6E43
	for <op-tee@archiver.kernel.org>; Fri, 29 May 2026 11:14:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AE47944D88
	for <op-tee@archiver.kernel.org>; Fri, 29 May 2026 11:14:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GR+R40dq;
	dkim-atps=neutral
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5665D43703
	for <op-tee@lists.trustedfirmware.org>; Fri, 29 May 2026 11:14:34 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa5e0d57e5so6946e87.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 29 May 2026 04:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780053273; x=1780658073; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aUWS+ulikr9mXU6r3GU0bKgLHNbnuSLeHZpkedcrUM4=;
        b=GR+R40dqzwKFXkA7FsjEhcCAOXiyhigE9ftBh6p6Sm/OHG23M442olaKP4F3axZk/c
         f3PbwzVv53QyV3qvpXuz/Wma3+lF/pCQFkyyLg5DBQNnr8+TMA5I5K+mM+bkUp7ncW2U
         /fBNZGBc79959PH9D3t0vdqqL7cccUP+zvj2O2tOqQZwFFLDtRdfT4bJ0aFWGFd8h1pI
         ljQiXDFjJt/oukTNN7rgSBlUCQDzyWJJRkV9J+qGLM+nphi8ACRTlj6K8XhKDIWr1vP+
         lAJujoYzbDPbHcnPL7TwPSEMNlFYCGXNpQJ7+MskXBQJgL9gf2ZBsEuTIW2D7+3ZPS56
         GyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053273; x=1780658073;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUWS+ulikr9mXU6r3GU0bKgLHNbnuSLeHZpkedcrUM4=;
        b=hXOYsC5SmXs4r8MMzZA8obt/KP2ybaFG2hGWGAdMKorQfo6FtlMrRPcYF0ol+wi9it
         Vst5oQ0TYhFbHXV40PzaFlifToRASbqaSPm7oVaKhJzLqw8znc/4AqrHOsFoVn1emKQd
         Es2K/KwrpzDyvoWao8/Uq7H5cIlLMFspuOvKWTc1X1Rv4gcgzUNQzAPuIl6G7fwncBuy
         k/JBk0dmxpwoq966FTJnDE7DPcQCSE7kZTl9RujEX3vEhr7w7lihHDgkV6DP5GPDkqVE
         0mNFPvBwMfXaI8SteOCvST3T9axZqRwIQ17o1TvlbXPFFmK9laiSftpllfCzzOrjZYOk
         k9bw==
X-Forwarded-Encrypted: i=1; AFNElJ+VDxkVTa+e+GpDHA9xfTF6BPt+PEzFkex/fSZIUqXh8IVBKviVLPxYxo0GH6T+Eiyh7yBk1Dw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzMv3hu/mfWtqSa4MT3gNAkuh7OCJN866II3K6QSk5QMRS7kI5F
	2qN+6s6Rnj9vuuMPRgUlh0pQP6Fq6q4p2aisnojuNsu1NkZTYxeHj5YR1lmPEnQ2lNX9GA==
X-Gm-Gg: Acq92OGYsjBUa4RCqnawOqQ6uaG6LK1tlh6KQ22/52UTpQHUTLOFQo20VJzkS+B43j2
	4yJ5SzK/VAU3SdoOg2V/lU4ewVR1PUjiGfXSEbooQYG1VmJQXwoYCGyRjfXNrBPia7gl0GuebzY
	cnjlIaCQnYF/gA7tncS4LOEh4I+ic2/u4pVC9t5OgYZsO2Tbk9HLjY400oUHthsSG+hH9luVuxZ
	mFo7W+MQ8P6deha7OaseaXWfBC3hPA+xj2sRg1XosUXmEq9gnBE/IF6m3OTWG7SzQ0a3QLSyYuX
	31C3e2NNnaBidW4PZTlAVnrBdnG/WxpkyASjkCZ4IDSMZnCWkhN2hnxDdz0XhD6ihbHRdvtnRM+
	BzuLiY4Uni0dw4+MoxuKivP/SLUVSzqb8o9e/cMuXnH9vc01xvHHK26R1PdTJen8S8LocHp/fA5
	a9yh7aCISckcnr+O1hzmlWMUEEwOwDjG5zzO3q2Y8qEZyjjeFqn90Ldkp7AWa99NaQFAYNUzDcH
	itILVX1cXRGdnts+HlQ0jgw/G95lsE=
X-Received: by 2002:a05:6512:a8b:b0:5a8:94c2:d49a with SMTP id 2adb3069b0e04-5aa59492581mr730998e87.27.1780053273106;
        Fri, 29 May 2026 04:14:33 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b068bd4sm221122e87.15.2026.05.29.04.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 04:14:32 -0700 (PDT)
Date: Fri, 29 May 2026 13:14:30 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] OP-TEE for v7.2
Message-ID: <20260529111430.GB2532355@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.51:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.51:from];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5665D43703
X-Spamd-Bar: ---
Message-ID-Hash: I3ULFPOMML3O7BPNAE5DMFZVJQP2I3W2
X-Message-ID-Hash: I3ULFPOMML3O7BPNAE5DMFZVJQP2I3W2
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/I3ULFPOMML3O7BPNAE5DMFZVJQP2I3W2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello soc maintainers,

Please pull these two patches for the OP-TEE driver.

Thanks,
Jens

The following changes since commit 028ef9c96e96197026887c0f092424679298aae8:

  Linux 7.0 (2026-04-12 13:48:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/optee-for-v7.2

for you to fetch changes up to 3faa6774ffc5973af39ac9c4f1fe93aa92ec9407:

  tee: optee: fix kernel-doc warnings (2026-04-27 14:13:14 +0200)

----------------------------------------------------------------
OP-TEE updates for 7.2

- Fix kernel-doc warnings in optee_private.h and optee_msg.h
- Allow MT_NORMAL_TAGGED shared memory to support ARM64 MTE buffers

----------------------------------------------------------------
Hirokazu Honda (1):
      tee: optee: Allow MT_NORMAL_TAGGED shared memory

Rodrigo Zaiden (1):
      tee: optee: fix kernel-doc warnings

 drivers/tee/optee/call.c          |   3 +-
 drivers/tee/optee/optee_msg.h     |  50 +++++++++-------
 drivers/tee/optee/optee_private.h | 120 ++++++++++++++++++++------------------
 3 files changed, 94 insertions(+), 79 deletions(-)
