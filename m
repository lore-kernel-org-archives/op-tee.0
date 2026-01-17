Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AAFC98321
	for <op-tee@archiver.kernel.org>; Sat, 17 Jan 2026 12:44:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 11F7E434B2
	for <op-tee@archiver.kernel.org>; Sat, 17 Jan 2026 12:44:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vCxFwONh;
	dkim-atps=neutral
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7E090434A8
	for <op-tee@lists.trustedfirmware.org>; Sat, 17 Jan 2026 12:44:16 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b8714a52072so436172766b.3
        for <op-tee@lists.trustedfirmware.org>; Sat, 17 Jan 2026 04:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768653855; x=1769258655; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjASni1JbbDfnj9ABEBCCy+TcLbgU6NbFpe/N6dpxxY=;
        b=vCxFwONhLCLP/DJwWS0SQBg9fq9jRPt0lhgk4HV+iBnoNKFygW3ArVTWxTxR+FgfHf
         3Q3PKkU1mGzdi3Fl/5JYqtkkxxaznGgL+SRKbpHEmg11HXMELtGKfKUdKTv7zZIkEOt3
         yNo7Q8FpcPhy5Ds97ad4UptfKn2fyviteNN+jeb2fgwfAq1u4Q55OGNTY73BOrp2COER
         ZhzFTx72vSfBS1lC72ZtIhdOvlIEhfWEEM5q3nV2pxkLeEHkcvPpizJHNHFGef9ygJlR
         FDSbrrSRN7YcR8EUz5nmhA/Vosq/Td/umTgDltLeekvj3EcExxbY8Jm9oRQkjBewR7EH
         hcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768653855; x=1769258655;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjASni1JbbDfnj9ABEBCCy+TcLbgU6NbFpe/N6dpxxY=;
        b=hwMnlxNv9a8C9Mno7npFHfKPm6XCbF4v118zEQ/ZfiYsFqrIje1Lw2Vi1ZSak6PRwL
         A5nlCJF3Ts2QxSxKvK/Dlo+SzwoNtlQgnE2SPWJw65OrT4vxPc4r5DCovpDCEL0Uty73
         90oj2q2aHxyRfDcTyUehKPkaYoJPs+Qjd32ur1Pz4lO02aCSdipO1HYaUwcpTOUhUhCQ
         ZxNoEJzwpe5D0XA4+3IJXWOv0qHWTCZBmrbjPrRey/9QGHPULUrsE4RDBvDHRKiHnxpe
         UrjE2+9dRHUPhc2H1OkrP2db7232bj1dbBEBij0ExzWyqx4ci/G8Myhng6HkcrnCmw2g
         3nxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqid6JV0YlLrraBz9QQA5auFq2dUFhkMcZI9tjv6SQ5dwMCHOlBskNsVHf62EfLQBhkzHFRqI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw+U8m9ujDaP5YGiYdBDVb7l9fwLAbAGr27EKDxJxs+MbcmY0JK
	vaer9N9XhfWQJtI7HTjYQvDYehgQ47t5VuodmCQB5y8qtPw/LpwE/6MSQ6q8/oe6rLGhng==
X-Gm-Gg: AY/fxX7iNHjMymqcoATnczB5mOwOOWBWrN1fHJoHvNwacqiiUXC6XpNgpiw1Zyjyexi
	UcS4F647lDN/VFTfxvR8LbWZPete179leigxxX5CPGNl7mQdyPb1DBfAUISowNyLAJ0HfviDyE3
	MRcABmKgOpvD0F9r8Y1pXg1wSvDfW1QlP7mg6LkX+B2CXHneMmraUVA9dHZo0esqvYbum2JjiMA
	XbuJgwvqWCqb9AM8EmVW0+A9cV/yO+Qx3a9LqNTFlI8QZffBt34KgD30tcvU5r5gNna+HE9fEfc
	NvWH203XtISAfuoLohI1M+rdaXkbrONJS/PHPaSkHYoZ+7ouPFNYY+1xOTOv5ZavHP9Vkzy2OHJ
	tgb9LDxwHpWCdChla1eW549lAaFjOW93G6R8GtCcYLrduko2GUmorvN/0UQ35r5xQuNW7oOXHc1
	BHdwMcb77ZinMopFAIX3dTxKU5I3dMVylrkViM2vHjL0mExemZLo29X2KJ9qWjcpOOmIF/RvtF6
	+MAp3w=
X-Received: by 2002:a17:907:7288:b0:b87:711f:97b9 with SMTP id a640c23a62f3a-b8796b241dbmr579955466b.31.1768653855366;
        Sat, 17 Jan 2026 04:44:15 -0800 (PST)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a31bffsm523837566b.68.2026.01.17.04.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 04:44:14 -0800 (PST)
Date: Sat, 17 Jan 2026 13:44:13 +0100
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] TEE sysfs for 6.20
Message-ID: <20260117124413.GA262260@rayden>
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
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.67:from];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7E090434A8
X-Spamd-Bar: ---
Message-ID-Hash: QFSI4XR37YJJX4WLWC7SKDJP6CF5DKV2
X-Message-ID-Hash: QFSI4XR37YJJX4WLWC7SKDJP6CF5DKV2
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QFSI4XR37YJJX4WLWC7SKDJP6CF5DKV2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello arm-soc maintainers,

Please pull these two patches adding a generic TEE revision sysfs
attribute and implement support for OP-TEE.

Thanks,
Jens

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-sysfs-for-6.20

for you to fetch changes up to c19faf5a62315d5e0e65dde49b7b59e30330b9c2:

  tee: optee: store OS revision for TEE core (2026-01-15 10:35:14 +0100)

----------------------------------------------------------------
TEE sysfs for 6.20

- Add an optional generic sysfs attribute for TEE revision
- Implement revision reporting for OP-TEE using both SMC and FF-A ABIs

----------------------------------------------------------------
Aristo Chen (2):
      tee: add revision sysfs attribute
      tee: optee: store OS revision for TEE core

 Documentation/ABI/testing/sysfs-class-tee | 10 ++++++
 drivers/tee/optee/core.c                  | 23 +++++++++++++
 drivers/tee/optee/ffa_abi.c               | 54 +++++++++++++++++++++++--------
 drivers/tee/optee/optee_private.h         | 19 +++++++++++
 drivers/tee/optee/smc_abi.c               | 15 +++++++--
 drivers/tee/tee_core.c                    | 51 ++++++++++++++++++++++++++++-
 include/linux/tee_core.h                  |  9 ++++++
 7 files changed, 163 insertions(+), 18 deletions(-)
