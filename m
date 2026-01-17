Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B8CC98321
	for <op-tee@archiver.kernel.org>; Sat, 17 Jan 2026 11:53:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 413F2434B2
	for <op-tee@archiver.kernel.org>; Sat, 17 Jan 2026 11:53:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VHyxhlpc;
	dkim-atps=neutral
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A729541B60
	for <op-tee@lists.trustedfirmware.org>; Sat, 17 Jan 2026 11:53:15 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b876798b97eso472486966b.1
        for <op-tee@lists.trustedfirmware.org>; Sat, 17 Jan 2026 03:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768650794; x=1769255594; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0P5243+rodLfxkc/81GyeliVeBxXMza+5jtgneXbcuE=;
        b=VHyxhlpcGMbAqvzlhaz7yTJF8Wae0qN4N3xWlBCEz4meWvtQNjwMnd7B+oH+8Dk+C9
         0qBJK01S7+4I0SHkH+0COkHmyPHzFiLwk6HEF9d+hXFVG8pz7e7kMpIYtJh3ZCSlNvtN
         7jKawEDtekMpjMjgk/pRIUsn4XNzpa62M+KGM80jHh1jlcomZ2CWXbjdOvG6+Pp9g98U
         TrhuxRya/OW96WRSb6zniy47keGtkasWcoduumN6RighaDSp1DHB9SueXx1x7w0na/fP
         wMhjf6GyNQREr6TeNaUuWx8EVqj4mj8udv9iOCPUPJn2oWs3cLhepP3RfnGhYEt00i20
         Lj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768650794; x=1769255594;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0P5243+rodLfxkc/81GyeliVeBxXMza+5jtgneXbcuE=;
        b=MrwyNHxs2xRoEvzcShiLDu06KsDZIVc9v0W7+iiwRSmtnrWJCdLrZQjwMDfa96WPp0
         ulrIqOzVHCpocm3omK8VMZ22D51BDy9LFI9cka/OxM518twq5Z1IlVZ2WyTkL54mzoL5
         3GBMwOj54EfwuG13sXh/hNfGJsPFsdqsMQK7/XJWUllm2uviZaUrl0wpmdufhDus4qs0
         fXNCI7QmiWnLWf7XLvb/0shDZmgwPCAbO87Mb47kiIXWj2t13KjvMWwUmOZW+aRfgLhw
         5o3WKQwy/RLkR5gZhAoppv2Z54gtZ6ByXKHk4Tuk/YAhoGJLy/4WOgUvZ+CV325FF4rZ
         Kd2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLvGGeS63HfVNlB2n6k8Z7sGvyYezI9Nw7wcPpH9G1OIejkNj23ymNqjjXOEp2RR9m+rzKA1o=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwOWo++1iwuk5/D9n7DGbC+octX5cA8vEVh23ZglNXThD2qOBzK
	JncWsnPH82jKcVfjp6RaIV57NAhezS3t7XHDPoI7S+R2/SbJgf2w9zFjDvSVQNKa8t3Etw==
X-Gm-Gg: AY/fxX4bWyGAfIewJ9/qE7/P7dJ29suUKDO1xAeFtVBxxex0nI0kKi1Hfdj6n9WuKUU
	TsHwogh0DTB94jzKYaF2xMx/DFp08jFYMS3LgA45/ZYUyddk5LE+kvAmawVxfInZ+O8gJSon2zG
	CQzvhSnFnpN+Qapl6IXcXoLq0Ekoxzbi0rlfFsS9RxV/itRnhZLiMp8mxMdtZD0izfAgXzr3XTA
	rqYU2fTufHAyGm8Km8Os8j3K0O8EREU63nARevlJ//vEINybLQgq6QJ059tdxQOhsO1FV3HmBkU
	5zCJ+bLAnFdRlRpCotfL7BDSRlXuQIGeeUJEoRrvvzL5kmS10deluDjAnJk72js5PFq3Bg9biOM
	+xGDDuDO0O4eDrpzfXflYEhp7Azt255UxhRFi0aSIrREyGzg9xe2UR84awT5kS/eJy4qAbcVJJL
	LNcvbySxNhy1uaDJP2ziiELw6X+h42zAJt4TjXpkviVFWXgpuZXwqf+SN2mBfcyrC9UKLnoCPWJ
	Z7If1Y=
X-Received: by 2002:a17:906:7305:b0:b87:fc5:40bf with SMTP id a640c23a62f3a-b8792d489ddmr548226266b.5.1768650794555;
        Sat, 17 Jan 2026 03:53:14 -0800 (PST)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a18c3fsm513158566b.58.2026.01.17.03.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 03:53:13 -0800 (PST)
Date: Sat, 17 Jan 2026 12:53:12 +0100
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] QCOMTEE fixes for 6.20
Message-ID: <20260117115312.GA255115@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.67:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.67:from];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[79.136.84.34:received];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A729541B60
X-Spamd-Bar: ---
Message-ID-Hash: LZULMDQSLYJ2QRUFDXXGS2HJNCAWADPN
X-Message-ID-Hash: LZULMDQSLYJ2QRUFDXXGS2HJNCAWADPN
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LZULMDQSLYJ2QRUFDXXGS2HJNCAWADPN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello arm-soc maintainers,

Please pull thes three small fixes for the QCOMTEE driver in the TEE
subsystem.

Thanks,
Jens

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/qcomtee-fixes-for-6.20

for you to fetch changes up to 1c05d9a4cab2abfb93ebce5edaa17752126b6d35:

  tee: qcomtee: user: Fix confusing cleanup.h syntax (2026-01-05 10:21:09 +0100)

----------------------------------------------------------------
QCOMTEE fixes for 6.20

Small cleanups for the qcomtee driver to align with recommended coding
practices for the cleanup.h infrastructure.

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      tee: qcomtee: call: Fix confusing cleanup.h syntax
      tee: qcomtee: mem: Fix confusing cleanup.h syntax
      tee: qcomtee: user: Fix confusing cleanup.h syntax

 drivers/tee/qcomtee/call.c     | 17 ++++++++---------
 drivers/tee/qcomtee/mem_obj.c  |  4 ++--
 drivers/tee/qcomtee/user_obj.c |  8 ++++----
 3 files changed, 14 insertions(+), 15 deletions(-)
