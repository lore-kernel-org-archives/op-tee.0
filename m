Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F3BCA0EE6
	for <op-tee@archiver.kernel.org>; Tue, 19 Aug 2025 12:29:36 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7CD6145A26
	for <op-tee@archiver.kernel.org>; Tue, 19 Aug 2025 12:29:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ugpp017/;
	dkim-atps=neutral
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4D234430AA
	for <op-tee@lists.trustedfirmware.org>; Tue, 19 Aug 2025 12:29:21 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55e041f6da0so198557e87.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 19 Aug 2025 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755606560; x=1756211360; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UipPaNtmeiclDOI6M9CPZuTeZBFQiA+rXuvCoDGD8Ek=;
        b=ugpp017/BFMLrEK7RZhszC9oMbgRhey0zwsCWC6lJptX4bhwvYKbLyvn8NzjZyFmtW
         cwefyVUK4UBfE0/VQZCTqKaK3m6jqHVXDRrsl6whI693/EjbKZ4YRf4/5REY0WQpTjA6
         54IWdLtiNszJYqJ6txcBiKck51uYRSkDJZHTnULs6CBm0FCi4huIzxIuNXXiGN1NnpDL
         0q8r2nddQ0YqFTDdLCVWiXFCeGh++pQt9sW3X2Clz4Ws5NbEW+X40Rm9OTtknLH8t09I
         TIrqiOwCPe7EG0a/IYEFsl0grTgOAxD5/r8bcZkrmlj/4s5yfCxkAyTFtF4FWB468SxU
         wZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606560; x=1756211360;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UipPaNtmeiclDOI6M9CPZuTeZBFQiA+rXuvCoDGD8Ek=;
        b=XMMLCuydPpE/VqNexCRHLHnZPDlkiJA4gw9iKP02G0RB3vF1GL8UZXvqTEomuuMz9R
         3NvDAJoeb+zCFuIfMqGjfrYakRzwIwEe5McijY74oBIWtiDb1TdvVFxkG7baMsUWDNAv
         UtOufl7UBzCNv0EaJLDKBV2Dld4xnB7eLuphgBkEM4xFvEcaw38sXOpUiZUrzc+JHLIb
         JtQmQFIQgo2LPIgyUcjABFJy6I4Ol14rQkkpFspmOrQcmWG2Kfnrr22WmcMaKrtUOs1l
         7Vap2XGblMhbGB+GefSyCdk/5W6UYipOaFtD/ZHrM1MW5RPpqH29fDnG2EsUeTNdEIhV
         ZYdw==
X-Forwarded-Encrypted: i=1; AJvYcCXzx6Q4nqvp/HKnG+6gEz+3ZDDnFXE2o2wzwYqeeQq2UOCAeLqHNbtta7H7iZxyxtfJ/F+vM2I=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YySeQqadkU9iCInylux8qGeERFivFUnZY2B0/E2w9uRZu0gudTI
	9BmD85PeDEaa5tqyNT9CJAVwzOdTCADLuJuM0tvYA4Wi674Cwib9VG9XxRqLV9rdGF/OrpQIiqJ
	/isaLOuA=
X-Gm-Gg: ASbGnctsYbaXAaF4e/dtSOkxV6RdxGHV3RkzCa6/KXLPOe0Mic3zrtkdz0MEI/eNhGi
	kiRgCGuJnlUYIUTTps5LHqKNvWzUBr/7yroT6ZXVx4sZTa1TBS03iZCJBM2ZnGdQ74IQWX5PYGv
	sXEt+hlhCi9qKcQtq8e1LrA+Ftff0Cgsem7mtkSThvEJpZmHZkCSPvKGE819AMGmHYS+o3btAPK
	UhrhubtCwjaaM0zUiee/OcF977VClT/YlXflNq6TZoIvI7wRQkEOaRmYUQE+1xxJydPT+jjnoU9
	eWGRgGjC8/URSzXOQLuya42NqAYovEXDJQHaYqUXxgBBZNAoJJB8w5oLMtQx6+YHoLhGUTU5Q5E
	Lc9I6+slOk+YGeCz1brzWeA==
X-Google-Smtp-Source: AGHT+IFha8J313pxWbqhKQOw7U03tO4cI6VgHA9135xIQnSuHavKRTIlRfvQUn8KhNwo4cxLJh4h8A==
X-Received: by 2002:a05:6512:6318:b0:55c:c98b:39d3 with SMTP id 2adb3069b0e04-55e0086a835mr622415e87.52.1755606559962;
        Tue, 19 Aug 2025 05:29:19 -0700 (PDT)
Received: from rayden ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef35145csm2136867e87.26.2025.08.19.05.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:29:19 -0700 (PDT)
Date: Tue, 19 Aug 2025 14:29:17 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] OP-TEE typo fix for v6.17
Message-ID: <20250819122917.GB3486750@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Queue-Id: 4D234430AA
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.53:from];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[209.85.167.53:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: FFV6TVSMBEN5OZT54HLUEQTR52YRNM2Q
X-Message-ID-Hash: FFV6TVSMBEN5OZT54HLUEQTR52YRNM2Q
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FFV6TVSMBEN5OZT54HLUEQTR52YRNM2Q/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello arm-soc maintainers,

Please pull this small patch fixing a recently introduced typo in the
OP-TEE driver.

Thanks,
Jens

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/optee-typo-fix-for-v6.17

for you to fetch changes up to 75dbd4304afe574fcfc4118a5b78776a9f48fdc4:

  tee: optee: ffa: fix a typo of "optee_ffa_api_is_compatible" (2025-08-18 15:05:49 +0200)

----------------------------------------------------------------
OP-TEE driver fix for v6.17

Fixing a typo in a function name.

----------------------------------------------------------------
Sungbae Yoo (1):
      tee: optee: ffa: fix a typo of "optee_ffa_api_is_compatible"

 drivers/tee/optee/ffa_abi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
