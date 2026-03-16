Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71EFF013C5
	for <op-tee@archiver.kernel.org>; Mon, 16 Mar 2026 07:42:12 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0D56F41A40
	for <op-tee@archiver.kernel.org>; Mon, 16 Mar 2026 07:42:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Dmlfhac/;
	dkim-atps=neutral
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EC00C41A40
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Mar 2026 07:41:53 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a12cd0bcd8so4887332e87.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 16 Mar 2026 00:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773646913; x=1774251713; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9f0vpOSz6vqueLKXbDkbiM4ufWrBYHfcY6Ykd+DFfA=;
        b=Dmlfhac/7/EMzRkUq867jE1/WZOPtGBURhmXq2T3bz0MMDihH5M4dDJmvlwj3VF9JV
         hSQnx1oPpnm390VQ45uwV6J5ZUGpj67LCtI88IpxYC7lrW22pIym5j/41dZ3r5j9HMKp
         62kiufPfgHiEGmLNwrJfnBQpxofTOEGj1/PqW3Uvd4El+4Y9mQk7TOyxhVwJFSxPgDrW
         fM1wyb/fnEaF2j41EddSmznzHUahwRz2d0RVQvw0TF1renmYSkexjzeChLrtmtdHULK8
         8tB+WOBOM1O9NlTFPeIp0GaBiddlS9lJLpIqVSVBiK/JY0ot6nMEiChCkVPtDwdV/LX1
         m+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773646913; x=1774251713;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9f0vpOSz6vqueLKXbDkbiM4ufWrBYHfcY6Ykd+DFfA=;
        b=B3L0nZAi96jMqWVZub/TOP+231fCRJS7gxfK3pEr0U8fOI9FfXJpXnskgi7OBsXsyu
         2zxr+W820l4dIoCJkYOc+X3tZjlTunvN9l3WlMLnKrrdmOoD50gKgh4KoD3P6/vMSym3
         TkbYEMrcSdm3VdTzi7oujuX5cVatAh7NQvYpcuNLjKFXLtEY83WSPJujC1P7YrBO0LqT
         Pyt38taZq5d7c9MhLiOzUGuz9VAHYFRltVMbw4Lhrlqj3KbnhFZnc9JpE88gf0tI4Pnq
         xYQ0b0yIb6dRpRlLJ0/k74NZimf8xseqvn9ZXPn5bA57t9bT1VtsDVNmQOqgGkgwdpOF
         6QTg==
X-Forwarded-Encrypted: i=1; AJvYcCUKvGLPQ85SYmr8Ou1AKazq9B+ebZViHUvexVp4EoSn5Pocj/zJbIp55dyerPI5dol422ZePfs=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxBGOInEgaodwNU22ivmjNhJhK7obSJdNoG2bpNwUCR6vl3m4PP
	gdg8aZ1CnVGk9k1ve+ZGxDIjHjUtmGNwZvWfS0v0Cxnc924chauCgMk0WhOCpjF742aP+w==
X-Gm-Gg: ATEYQzwEd5MdM+ibzdWYlGeaBjsPsg09hRi7TKFjfij/V4ImUvIm3sn9Rf+ffkPijZ5
	/sivQeeDkTDMz6sFOG+EDKCt5SdO/IuLy3zSxz0Kq0oXZuTsYT76DbkHXIz+3T08wPMwmpoOO1F
	zgEcZhY82CJH/Bv3kaqRKBDduVXdZSlv2Drzse9q2RZhNNm0nW9l00+B939afQKWUVbYgw8DTwJ
	CfUr50zUO44zLZ1rkp9IC91+XDeCHvpR8dwW1vBKmjsuO5++FK7sS6x/sEaBhUfRd4phQB1tVyo
	u2/AUunKa8fulHuLqzbjBCk3tgjU/OWSjuOggFWF+yfJORE5pi+1WMvIF6vNobOSqzzY6TLpl38
	8zNVm2/5H2S6N3dFZkEx9Qx2rfV0BAQR5URYqB99Y1n/1tg9bAgfYonDVNsWG1KcbcbUWX6V3rz
	YPIEkdwQ6B2DPdVd4bUoh/8Ls6T3NfViY7Ez7rbmXCt7eiy+HCoMa2nzOUGDJVhHzxBC1H8zoZW
	cuO4qoB5opvwfZtnH4=
X-Received: by 2002:a05:6512:3443:b0:5a1:2738:faa1 with SMTP id 2adb3069b0e04-5a16271006bmr2643778e87.17.1773646912633;
        Mon, 16 Mar 2026 00:41:52 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a171a41c8csm97838e87.62.2026.03.16.00.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 00:41:52 -0700 (PDT)
Date: Mon, 16 Mar 2026 08:41:50 +0100
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] TEE shared memory fix for 7.0
Message-ID: <20260316074150.GA2474723@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.48:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_DN_NONE(0.00)[];
	DNSWL_BLOCKED(0.00)[79.136.84.34:received,209.85.167.48:from];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EC00C41A40
X-Spamd-Bar: ---
Message-ID-Hash: MTLFRBQJWJEY64MJURKVUQGGZCN343WL
X-Message-ID-Hash: MTLFRBQJWJEY64MJURKVUQGGZCN343WL
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MTLFRBQJWJEY64MJURKVUQGGZCN343WL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello arm-soc maintainers,

Please pull this patch removing the refcounting of kernel pages within
the TEE shared memory helper. 

Thanks,
Jens

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-fix-for-v7.0

for you to fetch changes up to 08d9a4580f71120be3c5b221af32dca00a48ceb0:

  tee: shm: Remove refcounting of kernel pages (2026-03-03 09:03:04 +0100)

----------------------------------------------------------------
TEE shared memory update for 7.0

Remove refcounting of kernel pages in register_shm_helper() to support
slab allocations.

----------------------------------------------------------------
Matthew Wilcox (1):
      tee: shm: Remove refcounting of kernel pages

 drivers/tee/tee_shm.c | 27 ---------------------------
 1 file changed, 27 deletions(-)
