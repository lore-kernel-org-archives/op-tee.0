Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61392CD6E43
	for <op-tee@archiver.kernel.org>; Fri, 29 May 2026 11:12:07 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8399C44D47
	for <op-tee@archiver.kernel.org>; Fri, 29 May 2026 11:12:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=K59/A5kr;
	dkim-atps=neutral
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7B54941BB7
	for <op-tee@lists.trustedfirmware.org>; Fri, 29 May 2026 11:11:59 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a4113ab355so9058772e87.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 29 May 2026 04:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780053118; x=1780657918; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJZr4ds5xh06/P7V3+Chp2lk69csiorD96DTJ6REhXM=;
        b=K59/A5kr50hbgElKFFElYOuCx9i7BuGTt4xKy1y6/us5VG4vhXWE3ogaWuq0hV//o6
         agxJQYifaBJBG0kbYVQIMnFmNveKhZiQxovC5JvG9DlDGUNwvkRrc+MWVSjUgewSxQIW
         KpnBXtk6Jv9GnYed/4V8lXLqwz/bieJFTvBdAtoAoUSjp17CQ8YdlhDVpmF7OZ3YFHkR
         7FPv27xSGAcnwAaSoRrW0aGJF2yW5DdpeFBqNNSTXM4Jt3eYMwQXFmjHtdI9KNd7JXnL
         OtNTf9VXSU+m16inVjVyOsiTOxN0OsFwuOpBGmdQnnNQGUa/J+GOakmrK6hhMVg1oOLg
         xP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053118; x=1780657918;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJZr4ds5xh06/P7V3+Chp2lk69csiorD96DTJ6REhXM=;
        b=dZXz39E0SnmQl3HT4MzsUuZhmATOOW5cfqLCpgKqLF0GstOUykroGyvJYx7B9oILwq
         rrkKyP5ZfNkg6RB8bM43c4Bf4AjZI13y4TnrKejSbySnJnfgYDU6xrp84RyN73PbCaB7
         L5kNYCUrKjZcowUd3jd8uHuXDtxccDar88UqE0nHY0WC8mqfU+XfXj8eHUy0fsv4BjYb
         oJ60lATIrcC5sNHYouGaKGcFfr4m1aG0GW7UIYyelZQZZ2Yp4btWBSbWyqQySJPxxfHj
         Z/FsQU/tD9X/6G6br/MFy3o15l7DR/XFHkPE8kwO8yajR7JLWIYtl0e+cdNmQ3Lq+mp9
         NGxw==
X-Forwarded-Encrypted: i=1; AFNElJ8ptS6mSg6PyzIDUzu5fN5GRiqWGr2td9h+4zBQWlPMRIoFn/TWDbKFCc+JFbVuAZovAQD6A/c=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yz2nsFno7tdpM6GnTd+fMSKw1duCzFk/PMJkXQVmQ06WkccMLHO
	5bsmWfRLwaedupePRD0ETAyGUBkzzLC8wi7ty1Ihb7KhyNtCz8GxzFSN7/IAjEj2osRt9A==
X-Gm-Gg: Acq92OGKaxGGZGYxVk0fEOJdgSmRajbhq00mYqAouodGJ+ljvneMuBFBbTLsLnm95gS
	x+wEVr551oRsk9RP6DVpEXtkgfel/ugyEHbvVbR66UkL1DO4GKQ6EmgbOSSQUxTkBbfHtCkbYsb
	KvKMGc8mOasWGhr804hTMpePcpNWNK5bG5Gs0Kwdp40a4uR5L1I6hXWGr2DazYOdaLRewceQf1r
	7iMFld2YKWBYy+rQx6QBVbUJqcmynDie4h79ZbSFLCzYmcfka4+I8n0YMP7FYVbURbj53kp+32o
	7hXmDwvEfA/O94NFT9qQ9Fd/3NllBnrgsF2gsSOFafMWtVNsljYQ5jCbfzqAUsST7A+T+p0mjZX
	bxFQFAw1B2v4n2uDd65bdris/o+kaKQ9Eo+lUm0Iil65pzUyonfSfqsSKORXGqVjZ2YjyYlrdkd
	Q5farFAOle+FHf8l6i3FdCjiVnyBsWRSkfaaZGfMUEPnWoDVtqZJLA9gor/c2Qh02epFpVs65q9
	r4BXJGzicz8SqfyrY89vfwhxLiO2o8=
X-Received: by 2002:a05:6512:2304:b0:5a8:d14c:a14d with SMTP id 2adb3069b0e04-5aa5949a3c7mr732639e87.18.1780053118287;
        Fri, 29 May 2026 04:11:58 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39660103a4csm357311fa.21.2026.05.29.04.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 04:11:56 -0700 (PDT)
Date: Fri, 29 May 2026 13:11:53 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] AMD-TEE for v7.2
Message-ID: <20260529111153.GA2532355@rayden>
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.53:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.53:from];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7B54941BB7
X-Spamd-Bar: ---
Message-ID-Hash: N24RQPMLSXFLYCS45R26UI3CFO7XEOHO
X-Message-ID-Hash: N24RQPMLSXFLYCS45R26UI3CFO7XEOHO
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/N24RQPMLSXFLYCS45R26UI3CFO7XEOHO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello soc maintainers,

Please pull this cleanup patch for the AMD-TEE driver.

Thanks,
Jens

The following changes since commit 028ef9c96e96197026887c0f092424679298aae8:

  Linux 7.0 (2026-04-12 13:48:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/amdtee-for-v7.2

for you to fetch changes up to 84a1e6179bd24dc10e47f6fa2b36f0ed345e68d8:

  tee: amdtee: store buffer ID in tee_shm->sec_world_id (2026-04-27 14:13:08 +0200)

----------------------------------------------------------------
AMD-TEE update for 7.2

Store buffer ID in tee_shm->sec_world_id and remove internal tracking
structures to align with other TEE drivers

----------------------------------------------------------------
Rijo Thomas (1):
      tee: amdtee: store buffer ID in tee_shm->sec_world_id

 drivers/tee/amdtee/amdtee_private.h | 16 ------------
 drivers/tee/amdtee/call.c           |  2 +-
 drivers/tee/amdtee/core.c           | 52 +++----------------------------------
 3 files changed, 5 insertions(+), 65 deletions(-)
