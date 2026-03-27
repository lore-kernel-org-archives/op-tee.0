Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31D710ED675
	for <op-tee@archiver.kernel.org>; Fri, 27 Mar 2026 13:16:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1986F3E936
	for <op-tee@archiver.kernel.org>; Fri, 27 Mar 2026 13:16:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NyaPYEYk;
	dkim-atps=neutral
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id F22654306B
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Mar 2026 13:14:10 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a2a5236811so1295655e87.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 27 Mar 2026 06:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774617250; x=1775222050; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kz8SaXeiyhxC27qAG3dP6iPPGTlVaK8A49rXAhagzVU=;
        b=NyaPYEYkODsaDiXeJmljmX94ONVi1l1oFq+xXxpBck+wnZgmGUaQ2DPijw70CofF80
         intNHORtHPJgiuI3IN8/bxYYTtykrTLbmgGn3nvoBZyOSMdcS2kBSG3Qg+HpfGDJlhAC
         9EKFRyp4ZOO+JvThfpGKL8Rz+plHgwB4Iv2yA2N9XTZ8U1Lf1OhtV7bGTnzYp54+mglg
         3IPenGAxrlMJjB4diWgzLSgjIwyCUpfjdDbx/g0jtJrzRyqbp7ZJpPs8MUmjc1oHY60X
         Vgms0Zp+33chKsdpxUi5ZFkjLUmVMBO1+nzTt/klQs8hD6l6ZwHjiQLkoKnNYhY3OXvM
         CVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774617250; x=1775222050;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kz8SaXeiyhxC27qAG3dP6iPPGTlVaK8A49rXAhagzVU=;
        b=pq2ZYLM4XQrJntnhiqsq3kUvwCxAhjs944QIl4O8Mspk5RXG0xq47I4mgH36lyQFW9
         o1m5K9uTGq8OU6mTMcvCBz1JR1fWNM0fuyTal+L45JZ6Hy3XWlDQ/4F/5AWDpelUkfQo
         AfXT3n05NR0iPl7tOzZAEwMM7gy+Fe2W+xuakW19kR7+ca8UeEeclOR4uGmFZdpU330t
         8gglMGA1mjCas9lqskC5AhvoZVbCEUGSuflNvTMwIQwAkaXWwCI9mcIqAFUbOV3dK6H8
         sL0Y18AKghxQ0ro82ckXZVI0pMwHy0z1cxYMa1RpJEuzhz03aYpzyUsVSGTaMsxt/KU4
         y7tw==
X-Forwarded-Encrypted: i=1; AJvYcCUdsz9U/8zAWmag7Eye5gnAAAPOZw2xGBucmeXKM7bsp3M5E8oHCwja+5jrFVOzneeNWGZvX8M=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwspY3irybmBr0TZcbGlrtnHnnNH+MBswVEZFAhbF6DZujq6GEU
	59xntVBoJAxOiDPJGlSDY+bxMSns4jAe7MQtJzYXIRVld6ze+9LyDhEsY5+yjsABFIS3Zw==
X-Gm-Gg: ATEYQzxqlaKD3VYnPb6iBBFDr5tk57TmwaYtie4aBAQNcSptUCLPHTtDnb6SsFYz7mZ
	OpQGZZ8WJdmEKjEymmtWzbEyYnySpCYTfaeHlQuT+yIfqwiX+65t29TijzI0tKJXorazDQz1PFj
	jKS7bMykcuJMbXb3Ivtpdv/YJA36T7g4kjyNzrW9G3zwkElgSqgG3N5vpDa5zDG8Ko9ixNAy4oM
	I4DCZ9aarcNtTEX33DvvyrW8q7ZZqfO+pz2T6mifw8u+y50KRuH7MVWNpeoGEJn+hRi+029TYtm
	8jYuVhCskrKiuzWEJOCaAzB0qQqm81+4BeQSdxi9cTWpcdcnZ17Bwpi5QltC1xwh8/VmgFJjW6k
	o5N75dAoxVfbe6iqgmOoV2l5SDxWBZojo88Eg33dsEKblRyhr1aTa224egyvPn47uE5qWy0toxL
	L61aKAIhNMK2oKMwAKXTNYCBaEw9NWZQ/dzeNjw/iLYwhpViai0uUst6A2+F/LUdmHi4Ax/Co9N
	IjZJJQ3XGrO6AyLsD8=
X-Received: by 2002:a05:6512:3c87:b0:5a1:18b4:6c47 with SMTP id 2adb3069b0e04-5a2ab59d4d3mr790105e87.0.1774617249654;
        Fri, 27 Mar 2026 06:14:09 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2a063efd5sm1345298e87.12.2026.03.27.06.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 06:14:08 -0700 (PDT)
Date: Fri, 27 Mar 2026 14:14:07 +0100
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] TEE update for 7.1
Message-ID: <20260327131407.GA3248701@rayden>
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.52:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.167.52:from];
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
X-Rspamd-Queue-Id: F22654306B
X-Spamd-Bar: ---
Message-ID-Hash: D56VVICHMJHCJXKMHUZ6ITE7ZTXZ3EXA
X-Message-ID-Hash: D56VVICHMJHCJXKMHUZ6ITE7ZTXZ3EXA
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/D56VVICHMJHCJXKMHUZ6ITE7ZTXZ3EXA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello soc maintainers,

Please pull this small patch cleaning up kernel-doc comments in tee_core.h.

Thanks,
Jens

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-for-v7.1

for you to fetch changes up to e416e7fa417b2d2604c1526a2f9cc38da7ced166:

  tee: clean up tee_core.h kernel-doc (2026-03-13 08:22:54 +0100)

----------------------------------------------------------------
TEE update for 7.1

Clean up tee_core.h kernel-doc to eliminate build warnings

----------------------------------------------------------------
Randy Dunlap (1):
      tee: clean up tee_core.h kernel-doc

 include/linux/tee_core.h | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)
