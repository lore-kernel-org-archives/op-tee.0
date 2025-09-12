Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5599BCA101F
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 09:16:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8D58F4FDF4
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 09:16:29 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MKWissVS;
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5CEB342D0E
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 09:16:15 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0473327e70so275705366b.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 02:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757668574; x=1758273374; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlgUHzzUxcsBtMaCAdoxtWQY7ynJqMN0gA8+gbW0228=;
        b=MKWissVS6XGZuWR6U/FnUHojsqQF++ihmStqh7BARH+12MX+GMrMi9+jRemaCNa51y
         sMMQM3c0aOXi1An+L+LTSGNWy4GddqdWCC24F41k1nREneXZjOqWNRViP6xUBKVNP8Iv
         wxr+6FZxDtDZy/tFlxEJ3kRDeOXIDyQpoDTi/H8w8IMFoaICWBgyjo8LG3c65aZO8RTQ
         iP5vs/X+d5PProF0MJB+b/9H0HVr0lwuo/PDVQO+q22/TpwZoyQwhnB3lNG6C8mnfUIi
         NVZST87mR5leVqckRDgCmBWwH4csItcGoLDKy46UQCRTaq29lphncrS4/bt/rUvshq7z
         nsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757668574; x=1758273374;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlgUHzzUxcsBtMaCAdoxtWQY7ynJqMN0gA8+gbW0228=;
        b=oFHD/Dg90jaIbaxAUTKdU5E0R7CHKV6ApRg5krsv4ZXq9CpCO5pOkwqygi1JjcjDJs
         lSbL+3dt4ASomlcoeU9vwgtatB9Y3I7x9zCr8LI3mj6LmrbYX/w+Y9SgmryWXQoqeoKV
         SxcCuie1kLJ4QEaE1ykdI8DpdHmfLnaD2ICk2Poo3v7e1KkpTcAV+V7V/gu67JcxhMOP
         0CgGW3WbgWuoaBw2knnfFSf95DYCOxe4bpc+bTtMkeAbwxbez/8R3Gku2TohmllpJVeD
         58mmg2T5cytPPN6JipAsnO4SEbhww4xbLjjOHrL3LmLSlAJqheD6VLq6lYpA46Q7CUoH
         X8Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVelxGhcdS3nXnYsIepnEEMZyvT62p+WO2uewJ4CPGVJMDJPRdbi2ufwsPOTKJPZVtuUWHpXx0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YximTat9xxj11zo8H6wO7oA15tWWRLChCMLDKxRdVwcYgvxdk80
	MIm+peEawqR3637EcuxjWARFdv+c7++zt8PuKkVTD+JOPJAepq1Z3wB/LD3Ih8NB5OM/Rw==
X-Gm-Gg: ASbGncs7hphXFentjMcZu2iEfM0LFqV7Rj1TQkLxcqeV4AzKlcpMpIQrk/7nTPr3v9q
	N7RvN3WkGB+T0g75qUGr/UIoIU87P6mZRU2O8G7+G2UznqssDRHtaU4JCKRWZv1B3S9lKF5bZYt
	lmxecVnRTVkxk6Uxg1ILyzphI26x85MqKxJlleavEFqA8Ai9j9JoQhwQYsdF2V/bzFR1Dh59moa
	0vIIg17kbCXAYMRaH8deJ/g8F2Tvv2Q1cA8xQfp/UcRZgMG/kRU5cjDzSO5csIFWZnLpK+uKivM
	tOujmAHlXDw/yRD1PcSuHOrEfawl4RywNgQnaW4SY596UqxC4e7VsqrSLXNDs7UIFI20A75FTAa
	i/T0Deb8Kag33AuGl+PNwbxVbtm+deMrqsdSj5f3YEbUq5nv/S10M0TXptiK8rX731Kx3+VPNVc
	0=
X-Google-Smtp-Source: AGHT+IHW8XMyz6nqW7u3TYUw66sukf98+XYt67qdK2NQa7FJLPadrkYMrrqcrPARFvnU1xfgiv01KA==
X-Received: by 2002:a17:906:794c:b0:b04:302c:fe14 with SMTP id a640c23a62f3a-b07c35c2af1mr200439466b.21.1757668574166;
        Fri, 12 Sep 2025 02:16:14 -0700 (PDT)
Received: from rayden (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334eb58sm319624566b.100.2025.09.12.02.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 02:16:13 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:16:11 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] TEE use SHA-1 library for v6.18
Message-ID: <20250912091611.GA1442659@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Queue-Id: 5CEB342D0E
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.50:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.50:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: XYZDARQUXR54RIATMHFPNL44KHEJ7CHX
X-Message-ID-Hash: XYZDARQUXR54RIATMHFPNL44KHEJ7CHX
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XYZDARQUXR54RIATMHFPNL44KHEJ7CHX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello arm-soc maintainers,

Please pull this small patch for the TEE subssytem. It simplifies the
code by using the SHA-1 library instead of crypto_shash.

Thanks,
Jens

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-sha1-lib-for-v6.18

for you to fetch changes up to dfb2a4f76ff7f60d6e2a55b6a973dd42930adf50:

  tee: Use SHA-1 library instead of crypto_shash (2025-08-13 14:29:49 +0200)

----------------------------------------------------------------
Use SHA-1 library instead of crypto_shash

----------------------------------------------------------------
Eric Biggers (1):
      tee: Use SHA-1 library instead of crypto_shash

 drivers/tee/Kconfig    |  3 +--
 drivers/tee/tee_core.c | 55 +++++++++-----------------------------------------
 2 files changed, 10 insertions(+), 48 deletions(-)
