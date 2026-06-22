Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EC1CDB46F
	for <op-tee@archiver.kernel.org>; Mon, 22 Jun 2026 13:35:24 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8FB9F44F1F
	for <op-tee@archiver.kernel.org>; Mon, 22 Jun 2026 13:35:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=z42vacvz;
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BED4A43941
	for <op-tee@lists.trustedfirmware.org>; Mon, 22 Jun 2026 13:35:16 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-691c5776f35so6068634a12.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 22 Jun 2026 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782135315; x=1782740115; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ac3eItdwTjEGd0PWKIr5oxQPzgo6ahr6wJiN5owXcRQ=;
        b=z42vacvze9wnLng/N9pa7IEwp8cRePSBLg1vdHt6JGdF5F3QapydVJlrJSDlgmn5Yr
         OIHqfdmCGR8bBrhGF00sgoloPU/4Ug50Xu+u9kbYYKLo1oy5z3eBPRK5EADkjnr49HgY
         6W7XMG8/l2fM2l/mkwlb4HYGP7MVdZSdMx/Je/Ayr6moPYIu/o71m1JQKJragxpPIjku
         wBfXV+rYO05hn+DPsgYyXdyQoBIm9MEriTWObRRtCbdFQBBgcdK54maXQX1JcEKWhxUT
         4O+UHiG9VyKti5Q3BYoGPTTfJf33kKZSjdShwyZopqGYRnSogGCO80bS8n99qGrWrdYx
         420Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782135315; x=1782740115;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ac3eItdwTjEGd0PWKIr5oxQPzgo6ahr6wJiN5owXcRQ=;
        b=gpVrKQ3NDngKFGrIZ0XR9A2/twBLjF00TFoxqAyrKxNG3Cj9MoKagCbFO1IhnyzPTw
         DKsDzIq3lNrunoODbnZLZfWWXrK0GhhH9K77Z/Js01Vr2YmGd5dav7bJYgINBuz3c0Uf
         giKKmfpC+4wDpA42UQ3I0CEiE3ciQXD4ufzgTS/SoCqbpwJ8IXlSO2kS15XhMppBpNNL
         Z4i+kYd0b9iKz170Ws3GFjIo0g20+CcpqtU6gKFWhc4qILy3L9kxyjS/LHXizJ+h4cEa
         +gg2qoZbyP3XiZpiJqNO6FJxlaYWU7eSvB4lZfw5RxqBXeiqI0WIFXJsgwek6iiDltwR
         XfgQ==
X-Forwarded-Encrypted: i=1; AFNElJ9UotnCxbmJ6kA7rbIOyXXTp5fHYJhxWT9H0j4dSdjgdAp2c/5pTKz4/ZQGcH8TopLRSnaaQa4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyPURO/iw6ENojwxNWyrlrwWACKYiFTiNjjYomeuTF2IetLAUe+
	g2C2UXD4XRmRYjAVFufKUkWAcZUEhSCYQvvd1uYrZBlGWq2vKe33C74Jdm+2iJjanqQQLQ==
X-Gm-Gg: AfdE7cnVt0NcbXh1DP4rXRsfo8NnOpfeMIzBovw53Mu1FteL6d+Z76Vcxv66iAnAEiE
	xvf00JPRDdJ/xEJrhEhbJyKYf9sqVGup5X1WoeKpd0itbGH7+C2PEUV3CXYrk8jnhAges9qHDkG
	6ydP35tMMdxj2g/wM3L522XlIzF9yoYhau3gRBW+budFTyRK38NeZdjs1FmHFM18KFVPUIfjcYE
	UvKvVmEopeFsJrDhKcb4Yfr4reVqdbeMzkfPTNgH79VNGEjtrSMSJ63/CieRM/otq3+VOXE8B0a
	RAMwGDmuinWCxyyFXY2WQ+GqLHWSsQA2lVs/2+sZd/tNC9gZuSa9bBeCD8nrOurDQZNZIYedddl
	cK686mK0Vg8ZAV/dXx/WHcRgJH7/tpNOip4Qb9cGDu+cQAS7KaNM5U6spz5TAJD3cE54DeS0SvK
	rJgiS9BH6j5zK879bcWnP/nTHuIJTa7Ye9P9AJ7KyEV8PRDsA8jv5hSfYE2OlT8Z5D5x0MJsHCW
	ohH4rid5w==
X-Received: by 2002:a17:907:cb81:b0:bee:b5f2:6385 with SMTP id a640c23a62f3a-c097adb77b2mr704001366b.11.1782135315395;
        Mon, 22 Jun 2026 06:35:15 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c610e48ddsm374099366b.50.2026.06.22.06.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:35:14 -0700 (PDT)
Date: Mon, 22 Jun 2026 15:35:13 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] TEE update for v7.2
Message-ID: <20260622133513.GA2789405@rayden>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.46:from];
	MIME_TRACE(0.00)[0:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.46:from];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BED4A43941
X-Spamd-Bar: ---
Message-ID-Hash: 4LQVFPPVMIPEBMK254KDQYMTMDIHUTCF
X-Message-ID-Hash: 4LQVFPPVMIPEBMK254KDQYMTMDIHUTCF
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4LQVFPPVMIPEBMK254KDQYMTMDIHUTCF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello soc maintainers,

Please pull this small patch updating my email address to a @kernel.org
address. I lose access to my Linaro address next week.

Thanks,
Jens

The following changes since commit 8cd9520d35a6c38db6567e97dd93b1f11f185dc6:

  Linux 7.1 (2026-06-14 15:58:38 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-update-for-v7.2

for you to fetch changes up to 314c243b201b678fa89226b1eaea51a71340454e:

  MAINTAINERS: .mailmap: update Jens Wiklander's email address (2026-06-22 15:24:51 +0200)

----------------------------------------------------------------
Update update Jens Wiklander's email address

----------------------------------------------------------------
Jens Wiklander (1):
      MAINTAINERS: .mailmap: update Jens Wiklander's email address

 .mailmap    | 1 +
 MAINTAINERS | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)
