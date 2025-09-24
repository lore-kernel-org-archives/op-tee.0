Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F35CAC5B2
	for <op-tee@archiver.kernel.org>; Wed, 24 Sep 2025 08:34:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 99279430CE
	for <op-tee@archiver.kernel.org>; Wed, 24 Sep 2025 08:34:24 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Mel5RyJE;
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8932F41823
	for <op-tee@lists.trustedfirmware.org>; Wed, 24 Sep 2025 08:34:08 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b2ac72dbf48so85430566b.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 24 Sep 2025 01:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758702847; x=1759307647; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T2GuLi6XyMMBKMY8TiQINu19CGtecqHLNQuiswEu7fo=;
        b=Mel5RyJEw/Lpos368LWxvNJZnY7+DmAro2wJcjaD2/DOJ2cjV6V7WPkpF7wu3APflf
         FpK6IVqRFi9yEQN2xl5TCY3YuOErx+gO6C/crYlxuCf0tqx3YV6PJVJAGyGI3DJgINqK
         mP0PFo2lodYYQo+kraPAJjGqRAyhlN0AZg3EyU1r/W7YFjSZzlZmrhfiI2v6tW6iNDSw
         mSWDWrNalEYgcfySYp+tyqMxd/bKsOkVKga4JCf9jJ9EDZzMksGmx5dQhVluflo628zj
         DlTvQRMDT/CoXSn3WjkibdQnUp2gXJ9Pdt5c0c76dInTJhoNqid8aFM9fAEzZdg6OxT9
         m8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758702847; x=1759307647;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2GuLi6XyMMBKMY8TiQINu19CGtecqHLNQuiswEu7fo=;
        b=BRNw3ydw8Vdo6RED0bk1JVMoOiURSk2/TGJXsAKtYVoQ7ndzWzoqNk3BbmAqjs4itv
         XdWNG3QyF56DzHXfD9cFGCMG5oaQpANPv0I30G6hu/6I42IerpBKxuI5pAjsF/I+2Fbd
         /wOKCjZsvo2+LVibOOwZUSohR1JYpVO2pqdksuYnDL2SKC45HsbyC50tgl0kwfP1Movp
         HSW1+2T96sJVqdmHmaMUR0/n63TOMpPCXCsXrAaWqRxc+1tfupC2yvm5bTA/ID73oO23
         fkvi2zwNnIs5+q/3JFcpzIxBtie0eU3W/90/kmPbagrZG/PUMhV2t8NYNEL8KsxPThBF
         YjgA==
X-Forwarded-Encrypted: i=1; AJvYcCXam1mVBWr4W5dLgABlsVA8TTk5YoY0v8R3AIORWE4x+tw4BzYPJtnQzNGltYA1j2LzT4iuNlk=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzLBsPl4LzbTRFSah32Q8B8/TipLb1cEbk+z27/ockaF8oBiPCv
	V4C9Obszs8rnnS8NRjPfvnmmc085QBmMVqPpg5MHa1/FvgitEI8bUV0y+rPTLQ2L3Eydfg==
X-Gm-Gg: ASbGncvr79SAeTK428nSYaXXYSAc7MJBKCbxNdrqZtulAhkmBT8fwh4p4RuT5RxReeX
	Jd7c0docY6IvmLzkKSosGfqzPDdTcqcTu/+vdQDyhOOwcupJn+1H0FCeAA+yzir1lO5HpWXSNZC
	T+vi6QVVyFnOCl9fPzzkOy4HAulBV1EO5AX4bSDvmpq5JTGVH+vMZAZl684Jj4bmKQWDD/rS5rS
	Pu/Ky+Zl6x5oG6h75E7E3DAeaNpebb9Pan13oq8y/Mvrh2IkG3uPPUOg7h7wzXCXBg85bZbBA4s
	I5kHHLbRmxup8aSoSOAarh4+Y1CZe4PL39wFXOSzunmyFcacs8XEVns7M3BY1Z+S3vsYTv35BOE
	Ck5Fm0HRkbkNY6Zpe2JJinuIwY64+EbBx/CdZKigURmweRz58PeLwraY39XCIFp/+
X-Google-Smtp-Source: AGHT+IH1aDoALWFRsO0oVLqVi+ToUZna4cdMnC32Rm3fsJgeudeKUR1iGh2aJbkhuYEWll04azdH2g==
X-Received: by 2002:a17:907:7e88:b0:b2f:5c41:49c with SMTP id a640c23a62f3a-b30267964c0mr565741666b.3.1758702847411;
        Wed, 24 Sep 2025 01:34:07 -0700 (PDT)
Received: from rayden (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b338b404a3dsm46227966b.11.2025.09.24.01.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 01:34:06 -0700 (PDT)
Date: Wed, 24 Sep 2025 10:34:04 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] TEE fix2 for v6.17
Message-ID: <20250924083404.GA3747732@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Queue-Id: 8932F41823
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.42:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: EAPFBCXWLW2CGEKZZT5IRRMLZWCCG3TB
X-Message-ID-Hash: EAPFBCXWLW2CGEKZZT5IRRMLZWCCG3TB
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EAPFBCXWLW2CGEKZZT5IRRMLZWCCG3TB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello arm-soc maintainers,

Please pull this fix in the TEE subsystem.

Thanks,
Jens

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-shm-register-fix-for-v6.17

for you to fetch changes up to d5cf5b37064b1699d946e8b7ab4ac7d7d101814c:

  tee: fix register_shm_helper() (2025-09-22 08:47:00 +0200)

----------------------------------------------------------------
TEE fix2 for v6.17

Fixing incorrect error handling for a call to iov_iter_extract_pages().

----------------------------------------------------------------
Jens Wiklander (1):
      tee: fix register_shm_helper()

 drivers/tee/tee_shm.c | 8 ++++++++
 1 file changed, 8 insertions(+)
