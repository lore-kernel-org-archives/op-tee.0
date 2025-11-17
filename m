Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B90CE8D6B
	for <op-tee@archiver.kernel.org>; Mon, 17 Nov 2025 09:47:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5C3014FFAF
	for <op-tee@archiver.kernel.org>; Mon, 17 Nov 2025 09:47:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oOjI4ZSL;
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 918C8431CF
	for <op-tee@lists.trustedfirmware.org>; Mon, 17 Nov 2025 09:47:15 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b736ffc531fso441205366b.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 17 Nov 2025 01:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763372834; x=1763977634; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YX6kr6+19XslUofmNeGq4cx7X1qn7tZjzeeGnGtGTw=;
        b=oOjI4ZSL87TRRDgJmx1QeFaiIdO706j1meuyXoBDY8eOFBRfQRsK2IY961w0ugaTDR
         RRMNFOuBojr3CVEYB6B0joUtdwubDr3dIZ4mwwx0NyRXJXH6fq45VZYkl0orqdw3UoVN
         QZjLLvdcV3jYZfaU5/tWrbiZhnbYG9YRZLCM3d4YiOrEQkra9s7xcBV92uN2/adQ1caA
         HQzXT7HOhjSrqRuBKn7x4hPiZl8M9VLw7Fj45Mqztfy+TQFTZxhnJMxGxxSxxuJnFLvU
         PyMt0b2E/raBhKBQGuzJv+J09D4PAtCsl+Kimm9jRlaXlpRb/XnnMsoSRAjxO+5jPb6z
         RMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763372834; x=1763977634;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YX6kr6+19XslUofmNeGq4cx7X1qn7tZjzeeGnGtGTw=;
        b=mcoPTDJ6dTUOXE2MJeOUWx2nZiDi1oPspqv70j4z2MUh/1XN7Xzzq7fu3ixfYK/rEE
         puQbB/uoIaAzO/cEQFX60A1DOqSKaSXBa5yZTjUHFQ1txIjN4AcN/5ej8hYC/mPMosvs
         3DRUwtQon8Hf9x+5StUiwittnuUCSeCpk7xyDb/N87B76H4AtD5N3F7RlpHMG3VFhW/v
         d5pRH2dNz4iAqAtfszvkQGYqm/TN6ZXffQvQccxryZyEogduYXt71Ls1gT5mny8sMfoz
         PXDyTkbLp9idreuUHe9MDjg3QgX4hP9gMoYpUkJ7dDQvLFoRlnUMW5kZ1EE7KMLnyIJS
         US8A==
X-Forwarded-Encrypted: i=1; AJvYcCVCDLPYRI9BWjH5GHIJXUqBJucOob96w5u2R0+A/ckyVZYe/F9cOfpz+SbTXSpRiXRclYaXLiE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yzpq2fiWTSurhVFomdJTGRzJwSbyNTe4R7C6z7guAtqRsq4w1Ra
	ASh2I0RHDJAgssS79xMmjEKId0GcsSxYb+mXtUSeUmxIbUbmY8Xk0SWxh+No23zHycK39Q==
X-Gm-Gg: ASbGncvibvVUgSgoHjpy2vLAPupOI9e4przMUxHRvTIxkMgQ06NBmiNt8IiUAuu9EjG
	8fzeEqUy3LSyLYs9XUdX8g+xWJX5y8zlzWUmTNZr5+fwLs5bscjCXeK6varSKwwgWYTwOmAAppl
	SiNYeAyyCRLr44BZQzD3rJo70G8Gdu7XGlV7QGYt0QFu1Zb9mwbNOgxejkxIVZ3E3PKsKjI6NRo
	O9le3FwWSw26tzVr1oGvETWq4V8tXo+U5XoPr8gvg+I9FoCDmHzdFBx5GC40LTcv5FAkuq+96Ii
	flIpAGEhkTo/Vorivhj/vHU50RtN4TXB8UUoeriwyEU8QWszVq5D0qTzKEvamxe7REFU+wqY52D
	Z51QsixrDa9VFPoWr8wn4Ts2n7p0t5mDyhHGo4OigzfNpX5asYw8osq1XFoonOLqdqw7WLvTYuk
	GfrLQulBPKu0do3FZkTnJlYsMdFu61ByHVD0q9y5/TOSzPSgo=
X-Google-Smtp-Source: AGHT+IF2HhVKUCA/YV7sJ/UAv1rFG5dvGnJkrWqXvb2Eo4NtlDORIZmywkF9DCiaEbJydYdXVpovPQ==
X-Received: by 2002:a17:907:25cb:b0:b49:5103:c0b4 with SMTP id a640c23a62f3a-b736796a66fmr1326019066b.56.1763372834471;
        Mon, 17 Nov 2025 01:47:14 -0800 (PST)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd809d2sm1048448866b.42.2025.11.17.01.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 01:47:13 -0800 (PST)
Date: Mon, 17 Nov 2025 10:47:12 +0100
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] QCOMTEE fixes2 for v6.18
Message-ID: <20251117094712.GA1518418@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spamd-Bar: ---
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 918C8431CF
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.49:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.218.49:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: EBMGKYXB76BLPPISP3DVBLSZMDUVVZCL
X-Message-ID-Hash: EBMGKYXB76BLPPISP3DVBLSZMDUVVZCL
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EBMGKYXB76BLPPISP3DVBLSZMDUVVZCL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello arm-soc maintainers,

Please pull these two small fixes for the QCOMTEE driver in the TEE
subsystem.

Thanks,
Jens

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/qcomtee-fixes2-for-6.18

for you to fetch changes up to e19d7f7e92e061707252eab2b71d2c3be09b2e96:

  tee: qcomtee: initialize result before use in release worker (2025-11-17 10:19:29 +0100)

----------------------------------------------------------------
QCOMTEE fixes2 for v6.18

- initialize result before use in in error path
- fix uninitialized pointers with free attribute

----------------------------------------------------------------
Ally Heev (1):
      tee: qcomtee: fix uninitialized pointers with free attribute

Amirreza Zarrabi (1):
      tee: qcomtee: initialize result before use in release worker

 drivers/tee/qcomtee/call.c | 2 +-
 drivers/tee/qcomtee/core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
