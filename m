Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8B2C71157
	for <op-tee@archiver.kernel.org>; Tue, 17 Jun 2025 07:32:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EE4A142F89
	for <op-tee@archiver.kernel.org>; Tue, 17 Jun 2025 07:32:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Bd07tbf2;
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CD4783E96B
	for <op-tee@lists.trustedfirmware.org>; Tue, 17 Jun 2025 07:32:14 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso10804762a12.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 17 Jun 2025 00:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750145534; x=1750750334; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DitCPFk6i35uURXkN5+J10Jk6mGckO0efyDQ/Ffatgo=;
        b=Bd07tbf2M5RgP6wT+dzH+dvCX+PrzO2z+DGgXPgiJMjqgKhnKENlotlI/bNywElW8W
         8LmlZNDHVZ2ZdaxALjJnhya09iZh8npIFixMX8wjjo8n5big9khtt+eSdyM69Qqny3xP
         Al6rd2TbIlcjcvcjakzCJxc7dXhPIB6cYL84kDmZpYOglYAn+awApY2+wrQQW1rlKHKJ
         CKZF70TqyE0FfHMwPtfEoyjLiacuf16oisN1fzx6pOD4fX4q5xsghT+OrK3hDU6ETFP1
         rSOLVoExRKjuBpKWANVAJrJHGeqUslxjGBUPa+x1jh+6WVb6guDRylSC2lkXxTAY4kWU
         dLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750145534; x=1750750334;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DitCPFk6i35uURXkN5+J10Jk6mGckO0efyDQ/Ffatgo=;
        b=AcBW3lFMxoiwXeWci2wFsPDU8IXJ7bPbKW1nNuhtY5rZ2qIdeA3JirW2LyN0bNoDEQ
         U6xqWC5aIgL0iaBFExA0Gi6b0aNFOEwlsrtMDs1sCpkbA81mQ0tnJ6ZPl206nU5yloCh
         PcOtaovm3cPVxuNfFiMacKUnPI9nAm/gzEobPMPLH5FwQnZ3KGB+nh+WwcVTCkSBo3v5
         ErOmCDmrvau4sAzkmLXnN5RUn0L/aRnwVRMv5jou8DsoR+IWLBTjTnPJcsH6kI1WM6kX
         Y8BKWcHLiXd8fbCdquFoeLAGhPFLH5rYS7eddJUsCtdlWt9+4Myl7QMZQAUzbFHc0D5o
         Y8pg==
X-Forwarded-Encrypted: i=1; AJvYcCUGLNmLIGy1ojcbUxEkjx2GpD5xlu59p2KYabjopVBClGwyIMaLnasZH+gYt56ttZJ3N5Pzh7o=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzYzsQRcvVot/uDbz2GqkHZCfw5NDYny/Aui0HoRO6/1jbSONWS
	mRMfeHMpMtBKzL+ObXdkA+cGfGSfDniJFKM3JuzEp9YokBR0mqJ2IQ6QpeG2tVH/RD1Eyg==
X-Gm-Gg: ASbGncv8j0O0pHWgggZV/g6bB3pZ4fPCfh77MpbO4JUqYudzfXz01xPotVp4tBCupA6
	3l0u4O+Zjzii88y2J2uNswrBw7myghi++/HqpUq8F8ItyNJbdoGMM6wJelrzGL3rcMKcA/aPyDc
	JEIuu2k8Mh6rJhZYktk5NBnhsgWcnbEn/hIKxpbYyvsadPWD3cegu5l16ekhpLn7UcbO0P/W8Db
	iW9I3WqejQqGM6uE2xEbX6SCRggEs2MNtF0dsjNiGHBQz5L2WoDuVqx94YhGoSUMwhqLX2ghTB9
	1a0PH1MgdqIz30PtqT8l39aVIV5EQAqbbA9Bv3i2ppf+J4Wmz6DLhR2Kov9RPqxzbCD0p7QBnzJ
	Cc2+Vj+sFw7jatpvEKPKNo/G2uR3/
X-Google-Smtp-Source: AGHT+IH9/yGt1B2R5aOqGlO4giU7a4MpvEhipVbdlnV+bODahZF4ciyHZm2yTFfr8OIZsO0wiR54nQ==
X-Received: by 2002:a05:6402:4402:b0:607:d234:7d8f with SMTP id 4fb4d7f45d1cf-608d09af98emr11886262a12.33.1750145533721;
        Tue, 17 Jun 2025 00:32:13 -0700 (PDT)
Received: from rayden (h-98-128-140-123.A175.priv.bahnhof.se. [98.128.140.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b4a5e72csm7605436a12.48.2025.06.17.00.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 00:32:13 -0700 (PDT)
Date: Tue, 17 Jun 2025 09:32:11 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] OP-TEE fix for 6.16
Message-ID: <20250617073211.GA1005592@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CD4783E96B
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[209.85.208.50:from];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.50:from];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: TXOOWJ4BY5VH2UFXLMKNNZ5M27C4QM55
X-Message-ID-Hash: TXOOWJ4BY5VH2UFXLMKNNZ5M27C4QM55
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TXOOWJ4BY5VH2UFXLMKNNZ5M27C4QM55/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello arm-soc maintainers,

Please pull this patch for the optee driver. It relates to the FF-A driver
PR https://lore.kernel.org/all/20250609105207.1185570-1-sudeep.holla@arm.com
but it makes sense on its own and can be applied independently.

Thanks,
Jens

The following changes since commit 0ff41df1cb268fc69e703a08a57ee14ae967d0ca:

  Linux 6.15 (2025-05-25 16:09:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/optee-fix-for-v6.16

for you to fetch changes up to 312d02adb959ea199372f375ada06e0186f651e4:

  optee: ffa: fix sleep in atomic context (2025-06-12 12:04:57 +0200)

----------------------------------------------------------------
A fix in the OP-TEE driver for v6.16

Fixing a sleep in atomic context in the FF-A notification callback by
adding a work queue to process in a non-atomic context.

----------------------------------------------------------------
Jens Wiklander (1):
      optee: ffa: fix sleep in atomic context

 drivers/tee/optee/ffa_abi.c       | 41 ++++++++++++++++++++++++++++++---------
 drivers/tee/optee/optee_private.h |  2 ++
 2 files changed, 34 insertions(+), 9 deletions(-)
