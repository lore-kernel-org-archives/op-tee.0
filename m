Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84556CA0EEB
	for <op-tee@archiver.kernel.org>; Tue, 19 Aug 2025 12:27:01 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BCBCF430AA
	for <op-tee@archiver.kernel.org>; Tue, 19 Aug 2025 12:27:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=h45tCMZP;
	dkim-atps=neutral
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2A05D430AA
	for <op-tee@lists.trustedfirmware.org>; Tue, 19 Aug 2025 12:26:45 +0000 (UTC)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-335360f9b6aso2539441fa.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 19 Aug 2025 05:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755606404; x=1756211204; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RH/C3wXmNI2h8jF1q3m0CdjAwRtlpdk2fFUGk3Jm2jU=;
        b=h45tCMZPD5edR1lofzr1FZVQxUab+VGwLTUwj1RS84rSR37l1lPgfJYrpRHjZnrtd6
         Qog4ACqZA915guJWqIzLwGzhxkIu6LLAXKDCygDk3ty5UhOYk03xLQxl+8y0OB0DKcTS
         gNu3OzWA+sQRlhFxpS8p7uzbgvl9gVhRvweXsxfRrEurk2/xBYDgokUGuoTyfUxkiaxF
         uY4iiR7kDPtSMB+RgHw5k69n2xpwurFsje3yYQfg7lDC9HXySHn0gxBEijTtoTLDPPCc
         QybuWx0iwHcM8hk2DDn5yaWoK4cJT6ofNA8zUOTJhbbLzOPDQZ8O/BVRwpMzriYaIjjD
         h3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606404; x=1756211204;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RH/C3wXmNI2h8jF1q3m0CdjAwRtlpdk2fFUGk3Jm2jU=;
        b=LornLXAf/38zEMj6MsHZsYwq7ZRt7Ei/1PKfYtPQij9gjGv5xGMQ3HlTIejvUrSfFK
         19EeYZuC7D13Vv5r0IP2VNupmsFNwocQxF2nA8fDLFojYT75qA6MvSkxf0RwdSWoPdj/
         Bd0y8BwmsJtyNdhIN4XXKuVVNithczcBYjz8bt6XQoVglvTde1DypfJ3YcsGgN0HlaGJ
         b40QPTr7IHrC3GUX9E2b9RBR7f5ltsGMxvsBaZZhR+qEK5LbTzq90YrRx9B/JW/wQ+5v
         07se/o0KD1cXqJkU2shtciB04TvgWTv5TSHAZU+E28C7+XR05H+O6MFGm07Z56vh8wNO
         Zndw==
X-Forwarded-Encrypted: i=1; AJvYcCW5AjPzQsmDTmdouU9qOD+DUEcABfoGjydU9S0x5E37F9IHLA8AGqg9vmEMluwDjRw8GrWTBP4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzIT0rjW3K+WDttj78s5m3nBtHWs5RSbLjWpsOFAI+R6kKh0G0l
	cBVJFilwGlca/Gyw882YzgRtPO3jqOKmOq8FQ6rvQPXlHeSDFnuXco05I+7cFU8EoGg8Jg==
X-Gm-Gg: ASbGncvC5mO5uOr5CZuHunODKBTVPHZp/k1SKeKJNqp5Sn2Jo+KdScXHCsprazbWztZ
	qSXTEnDFnoY4/vgJ0snY7IdJFA//9uu2akfjIpNiIi6/erM2tgyPeelCXB0Fdtctm3jVAazYay8
	n81MuAqWPfP6ysyckFfLtVJpReSr04mvBwjpE1VxEUOZ2Z8M2N5JdYJ2In3PoWT3a4xV8+ptZj1
	Pmv8ybKIjWnH7TRl2HLTBplTaIhUqQrvmY+mb9AOaRthe2WazMW5DnSxsrGCHI08s3/2/FCp0tX
	J8gRwQsD6iXGywjzptoKV8Uj53n1AClBN7QiOUtD2WtXrzE71CL0/7hwd0HtNW/ZHb08BXncP5Y
	gvnFnkxcBdQeNXB7ekQ+z3Q==
X-Google-Smtp-Source: AGHT+IEopm7tKy//PR6tAZKXugwig1BvugMkJB89GGGoq3IMTwHV3jdUe5FZw58ERsomp4iOogHlRA==
X-Received: by 2002:a05:651c:54d:b0:333:ad65:c512 with SMTP id 38308e7fff4ca-335317ae048mr6645961fa.13.1755606403774;
        Tue, 19 Aug 2025 05:26:43 -0700 (PDT)
Received: from rayden ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a43a051sm22503801fa.18.2025.08.19.05.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:26:43 -0700 (PDT)
Date: Tue, 19 Aug 2025 14:26:41 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] TEE fixes for v6.17
Message-ID: <20250819122641.GA3486750@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Queue-Id: 2A05D430AA
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.178:from];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.178:from];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: XH3GW5IJHPVU2VPUTPYLX2GOAK47C2BH
X-Message-ID-Hash: XH3GW5IJHPVU2VPUTPYLX2GOAK47C2BH
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XH3GW5IJHPVU2VPUTPYLX2GOAK47C2BH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello arm-soc maintainers

Please pull these two small patches fixing a NULL pointer dereference and
memory leak in the TEE subsystem.

Thanks,
Jens

The following changes since commit 038d61fd642278bab63ee8ef722c50d10ab01e8f:

  Linux 6.16 (2025-07-27 14:26:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-fixes-for-v6.17

for you to fetch changes up to 50a74d0095cd23d2012133e208df45a298868870:

  tee: fix memory leak in tee_dyn_shm_alloc_helper (2025-08-04 14:28:04 +0200)

----------------------------------------------------------------
TEE fixes for v6.17

- Fixing a memory leak in the error path for tee_dyn_shm_alloc_helper()
- Fixing a NULL pointer dereference in tee_shm_put()

----------------------------------------------------------------
Pei Xiao (2):
      tee: fix NULL pointer dereference in tee_shm_put
      tee: fix memory leak in tee_dyn_shm_alloc_helper

 drivers/tee/tee_shm.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)
