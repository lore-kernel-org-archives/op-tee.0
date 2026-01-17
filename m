Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE64C98322
	for <op-tee@archiver.kernel.org>; Sat, 17 Jan 2026 12:04:23 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2B6CE41B60
	for <op-tee@archiver.kernel.org>; Sat, 17 Jan 2026 12:04:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mESc+g2Y;
	dkim-atps=neutral
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D547A41B60
	for <op-tee@lists.trustedfirmware.org>; Sat, 17 Jan 2026 12:04:05 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-38316d0c26eso24270851fa.2
        for <op-tee@lists.trustedfirmware.org>; Sat, 17 Jan 2026 04:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768651444; x=1769256244; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nj7efHtLNEBGO8kfZHLQ8akJVqyLIMmEIozQ44ZjMkY=;
        b=mESc+g2Yu0UdHlhtC6FwSKkKx9ygO5Agvb8y6U0gVyMRowP0cRvYZ3FitIa89RUcvj
         sMXMMDQPq79eg+OOIcaRurWec4s+EGqa6XjDvwvm8j8uXPbcW271XjVfAhbqgino28rg
         O6MbCGySftLhm9yDNdJDygHdTkMRYQ5iacthLmpVWlDBYAnfRhEJ9whDkSuJUtGqx9qw
         JqlWei+LjV85+ImxbC/IpgEbxqeGCeyvdNxVsYkHt7GLPnrUflKEMb/xeY6TGYp5cHcU
         W58PEkb4DgmKoE+9isoVtFoNpA5ogHaZHqPqSYsETZjeiXMu0kKrC9CHwctf7f358430
         otKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768651444; x=1769256244;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nj7efHtLNEBGO8kfZHLQ8akJVqyLIMmEIozQ44ZjMkY=;
        b=v/vTUhFBURMhB7cuVpKiKc8s90Y5Gyon8T1fuDnzN1CaIT8ZL3wDtdO2TCK+Q8Q9ml
         m9bloHk9AAAzyWxzQWZE5uU7oiDN+vzmBgPW41YalPQi72orovcQ8kJPL+hY1SPUOm+7
         Qf0GjqZFoki4xMJtLkez9BWWQfILCnYxmIEz/tSKTcDkL/4b96gZPMVO+d40A3JR4p6c
         UKHn5cQG/Zv7JO6Hjn2efITRqRdbi6TtAZEAs/OfHuDS/DlfEDbffLdJu7vWmgxr7k6k
         G0K/1qcLZ9kcOIuQTkdhgGlWETN64fT1ls8FMBq6fUzr9HLOw+Mo5hnOoHleBT8BklXr
         AOeg==
X-Forwarded-Encrypted: i=1; AJvYcCUWg1ZSk60lcRjq1x8iGyOytOe4y3R+OBpvnJe799NIJOr6yrvBo1hGxJDI2Gc80I+lDiJOoZE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzrvU2kRw0G2ZQSoufmam/8nu8xBaW3eXSc2kCFEfyTPNhSQ7Vv
	wmw6Pc0r1B3VeaKrkD2SNvyD+i9b7D3I/bgZIefBd6id2mzO89d+Zgk7h8Con3mNLF9mtA==
X-Gm-Gg: AY/fxX5+WnFXAPlDsDaK71sPyP3FFjgQv8sFMlVBZu/omwfI9JbxIRCc3PcbHVT09Jb
	p2SVkjk6yu6zuKKJRQBdTl4HpskztP8A5WjCfpL1d4J/voR6A1lMf7vcKIYPYtBwPjwEHZJ8MOG
	HgnqcDjeVwdhnPwYhyg1Eh2Ky6RyHnUvTEDqQHkaHbqv9VskUrCaD5RDBPnOu7yj1vp8E7JuNd+
	7+nl/0ttm6CmpDuVqLAlmclHX6sqKsyWr1FWi3/SD41JPinY9JiEzlMNVZd+g7c1G8sSNtmIVdO
	iDzg2WCXmj2zdeVaolbt+e/Enx+aUMuvXNfSri7KlisJyQtSflF9ka+8w5DWZ+nakuDdhInVmsZ
	w0XZPkbetKa5w+QDR3hXHgRlVSuxXmZXNADRQAx+X15nY/oPt+jyjyKRMLCWHciwgTzPegWc29I
	tz4/wZY4N0TvFTmWsCsQn6rmq10YuUzP0WfOo6ssjMqebyQMsx/Mtdq+emaJgwEdgWRvVEOoBUi
	0iAJSk=
X-Received: by 2002:a05:6512:378a:10b0:59b:b037:489e with SMTP id 2adb3069b0e04-59bb037493amr1321693e87.4.1768651444486;
        Sat, 17 Jan 2026 04:04:04 -0800 (PST)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384fb9ab8sm15890091fa.48.2026.01.17.04.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 04:04:03 -0800 (PST)
Date: Sat, 17 Jan 2026 13:04:01 +0100
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] OP-TEE update for 6.20
Message-ID: <20260117120401.GB255115@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.194:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.208.194:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D547A41B60
X-Spamd-Bar: ---
Message-ID-Hash: NF2J4XOJM77NBZSUUVPJNA2VCDKVGJHD
X-Message-ID-Hash: NF2J4XOJM77NBZSUUVPJNA2VCDKVGJHD
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NF2J4XOJM77NBZSUUVPJNA2VCDKVGJHD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello arm-soc maintainers,

Please pull these three small updates for OP-TEE driver in the TEE
subsystem, and for the OP-TEE mailing list.

Thanks,
Jens

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/optee-update-for-6.20

for you to fetch changes up to 94ea7063fae835e800768d3b0507f0994ef03878:

  optee: make read-only array attr static const (2026-01-16 10:35:05 +0100)

----------------------------------------------------------------
OP-TEE update for 6.20

- A micro optimization by making a local array static const
- Update OP-TEE mailing list as moderated
- Update an outdated comment for cmd_alloc_suppl()

----------------------------------------------------------------
Colin Ian King (1):
      optee: make read-only array attr static const

Geert Uytterhoeven (1):
      MAINTAINERS: Mark the OP-TEE mailing list moderated

Julia Lawall (1):
      optee: update outdated comment

 MAINTAINERS             | 6 +++---
 drivers/tee/optee/rpc.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)
