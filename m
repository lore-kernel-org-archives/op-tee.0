Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE7E10ED675
	for <op-tee@archiver.kernel.org>; Fri, 27 Mar 2026 13:19:20 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5E6D144260
	for <op-tee@archiver.kernel.org>; Fri, 27 Mar 2026 13:19:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UIpPArNk;
	dkim-atps=neutral
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4542643E3F
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Mar 2026 13:19:13 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59dea72099eso2606128e87.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 27 Mar 2026 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774617552; x=1775222352; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lNPO0O5wBEOqvcK8fttMdKDC05vxT3rrIFTuOlOpTto=;
        b=UIpPArNkxTJZLepXTMrmkDlueCy4HkXrfNnWdUDeiScBODD7jQtp9/PqIN0Up9SEWd
         xOk9QMvGEqxYJg4pXoElbrgckzs9e1/LRzPRniDqk8NBu+U6ANzsyA/7DGPWahasF062
         HJsB31ZqynANJkbWRQFKqSJOCJiTypuMaav4cAGgi6AgqdkrUzUvk6B2FJmkVKlAwmDo
         1SJN2q5dcRjmebM8wUznoSq/SW206FMZLrV+RPwzZGnD8maaHlk88AhM5Yw0MpHYtymh
         RM5LR74pYyhnaWLP/3PYLUsN6SOMYjzHuptNO5moOBrA+KmzVw2ste4cv3X/fo2jfEpE
         tRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774617552; x=1775222352;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNPO0O5wBEOqvcK8fttMdKDC05vxT3rrIFTuOlOpTto=;
        b=hGFONPoDm1R3zxpSy8arJM9o3XEgqkpQh6wo9Cj3hGqfkOEO3jAIeAaCNz/8KViejv
         cotu2acmxLiV70V91Vt/jBs2gGIeXB5GF9NWBpcGT3usMnb6ovzoHlIv55AfRpZqhYAH
         XTxRuD90xuSqElhYUvQ3sgikHU+m2tfsp/f8imbN/vtOybH2slehj4dNrQK7V2n4XBP1
         1W8QmQ33obegshGXIaS9BAMCVf4BmKKUGDTROv9FlvsD5GdVZefvTN7Mk83tpTQ4+0QE
         96ur/YKcVXDi2CPE8xrm2B1O+2XkibX2vKs2UwsDXJcvKjrx8f3NGeYoYlsX0O18Phpl
         a96g==
X-Forwarded-Encrypted: i=1; AJvYcCU71KKwh51W+ul4Sjmxj6OM73c48n/U/jTkZoCzSCZyjewC4ekKatwZ0L4aDRDqbg3lQbj6gG4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwH5R8qHJH0Bup5qc8T4nvjDFedp/foOpHOfHCnTs/OFpe4sDlv
	V4G7/i6RRAN12kyXkvdKxjnwPeOY95+vi2vRm8fCQ3BAW/NoEsHB2gcL22y8kJ6KC9e9Qw==
X-Gm-Gg: ATEYQzzB5MQx7vAuzHvt5yQzm7In9IYvvVqgNWHexvQFMmfBpcwCJmn/QgNfUjJArjG
	94VDUdpzP0VlgHlBVf4GLptDfS7+4Z+6r5W5jknJguuBcKECRJLi2i4gXjopsEmAp7I++N9IDPj
	zv6DpsIrVYno/Sifu+XApd1Ic6fmlW0aPnvxcjbgM3WvnNynzgIvKspkP07/Y0XlH0sjmz8rk/a
	I+L3dLKPVACYMpfNHq5cyhgK6K7pcSu5xzOk0dkbuAg6+gR5/8Xp1wzGlNG6eT0aPlOY3ViWboK
	4ut0CCi43etVMmwaiSEaywAo8C8FOB8p1XOH9jlOhgaZS3Z/Y80FEeb+PzLbuplsXVIYltxew39
	xq9fY8WcTn05IDAba/mEXZazncwx2N/enI34c8SYddvRXBtjRN+TYORUWILSng1hH0JjHtUhbUG
	NLcIO8npgyV7L7MnHjjIvLdYlTQ5PASg3S4cxR+L/p0BVGk3CRmFgzUSKH6VzUCwtDBhoumXq9K
	vFpcR29b4k58YugpCY=
X-Received: by 2002:a05:6512:3b8f:b0:5a2:a355:aa4e with SMTP id 2adb3069b0e04-5a2ab927773mr1250457e87.31.1774617551953;
        Fri, 27 Mar 2026 06:19:11 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2a36b5af5sm1175274e87.49.2026.03.27.06.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 06:19:11 -0700 (PDT)
Date: Fri, 27 Mar 2026 14:19:09 +0100
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] OP-TEE update for 7.1
Message-ID: <20260327131909.GA3249645@rayden>
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
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.50:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.167.50:from];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4542643E3F
X-Spamd-Bar: ---
Message-ID-Hash: WHGASUGDA7VJX4NTBXTMJTINJAII5R5V
X-Message-ID-Hash: WHGASUGDA7VJX4NTBXTMJTINJAII5R5V
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WHGASUGDA7VJX4NTBXTMJTINJAII5R5V/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello soc maintainers,

Please pull this small patch simlifying the OP-TEE context matching logic.

Thanks,
Jens

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/optee-for-v7.1

for you to fetch changes up to 8c6e843f1c26a0b12720cab02f785c46450b6adc:

  optee: simplify OP-TEE context match (2026-03-04 08:33:31 +0100)

----------------------------------------------------------------
OP-TEE update for 7.1

Simplify TEE implementor ID match logic

----------------------------------------------------------------
Rouven Czerwinski (1):
      optee: simplify OP-TEE context match

 drivers/tee/optee/device.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)
