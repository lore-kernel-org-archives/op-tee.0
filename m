Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7397CDE019
	for <op-tee@archiver.kernel.org>; Fri, 14 Nov 2025 07:36:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0813A50067
	for <op-tee@archiver.kernel.org>; Fri, 14 Nov 2025 07:36:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BTShtI+8;
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D899F43184
	for <op-tee@lists.trustedfirmware.org>; Fri, 14 Nov 2025 07:36:32 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so2640291a12.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 13 Nov 2025 23:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763105792; x=1763710592; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yz/684pSy+bY02PwcaHx+E+9NyXhxklBLKKFKYytCFk=;
        b=BTShtI+8xNAxTg1dmp8db4GP/xnbr5Q6V0CcyuYQZSqyVhPXf1gOUtczqROLInX9aS
         19AHjwuoBXd2aFYITPF6tJd83Kgzx8DF6k3kXhpWHKjbX49Vgzl9vHm77DGXHxugjwXi
         9UKpvWTNIR/V4PUT6DmlIj3wRaO0qSh0+u29slec4okqSACgeEo3Mdudy/l22L3N7kz1
         o8Knh0XwkkjYVepOezLkt1OhU0fBchPU11LGwxUv8UJRuX0ueeO0RNNRcbpiaPhc8+X2
         zHS9qwq3P0GkHpNkdZGMrXoNGp9qWL66lrVGQoOD+LFku4LWWpdNShPSKBCtjhWYnbId
         NViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763105792; x=1763710592;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yz/684pSy+bY02PwcaHx+E+9NyXhxklBLKKFKYytCFk=;
        b=SNs1oMphhRUvWd1nX7TI7+VzquCGt7Ocizos0WSuaQQVcvRHQtBA7hYPxhXbcBOuCn
         K9nlg2JW8vLQO21nus3VYgN1yNiCP84pI/fbPIJDHaK26eFKX5VOtlF7Hh1KqnGMFAfH
         wzUfDep61nWgBZEXhHESoGSmh0MOEvViqMYqz7xNhY0OjxCQ6KPiABAh1Sy+t3WwCLji
         xzaHJ6m8vc9z3AiiteTY3YJiPCwMEoLVObIGGwPQzkVcLDBEcGXKr6DgPxo7FGfDiic7
         vTqMcJ+qAUOv/IOv5fLYCNBruLjuvGbVUFgF+urf07OFFDIN9HL7FGftnkexi4nR4fKc
         IQIg==
X-Forwarded-Encrypted: i=1; AJvYcCX2JHhrVGuorEomHtl+Nxbmy/cELy8pI9OPiwEXXskLQLgs9JaZdlWgdPp2DMh1XyRHEGTtino=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YznHNHPpsQsWgrBmWVqeOJVdAJHvx01jr2zb9uTX0ajGvrF0PIi
	s5ASnH1rGeU8wuzqKVF7RJPE+zrQPBRcCW18UO6xLbrxdaVVDlsazs/PVGF4XUeOykkRFg==
X-Gm-Gg: ASbGncvLGFtOJZf6wzKr4v9LJ8NQAS+JKDkbYRAp9hGRAdNIMrUFZUx9gXC76q9Mp7e
	Z8q4iKKaYEbyUDEw0cJsW4Z2fFGJE4hNrCjpC7hLBqzPrn7vMP7XV6CknYfvHcDE4CCJVOENdDY
	9xnHjFMvMEMV42cQ5qwqYFMivJ235T27YtkjfnA+8udTTPTWZacqC2rlxGYWG8vtIpE2XdVlCk9
	quiAwEdI349HXSj0WdUhBo/hKhNUhvU04xu4tTxM9DvAop0Vix3UjStO9XPgU59zIq42PY1LP4C
	RDMGvdIzSVuqcC/pan5j/GbiUhNlnYG5nNsO2TsG135AbqeF5qXONMBsLsC8t1Bewh4sgyiEzAg
	uo2vXKKtL2UFWbGAGLLj8cqrG2jTztTJohgS6zPvMhT87Y9ELYQDu8wD/2A21kZArS8TH3mdc4j
	HbCLHNUM4/YFcHRBHSrjaWHcRbaLs39rRm7LYwWMAA3L6nCFMxVbVkvM+YLg==
X-Google-Smtp-Source: AGHT+IGSZ9Pfg9I1aYJchH6nzU/jmPshXQ7LpycBwmgkQ3vgmvK0r8raDtyAUd3OD4e0RW3jLmtaXg==
X-Received: by 2002:a05:6402:2694:b0:637:ee0d:383d with SMTP id 4fb4d7f45d1cf-64350e002a3mr1798322a12.3.1763105791806;
        Thu, 13 Nov 2025 23:36:31 -0800 (PST)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a3d8775sm3093364a12.5.2025.11.13.23.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 23:36:30 -0800 (PST)
Date: Fri, 14 Nov 2025 08:36:27 +0100
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] TEE fix for v6.18
Message-ID: <20251114073627.GA1362600@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spamd-Bar: ---
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D899F43184
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.52:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.52:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: BO6LNDC4RX7BOHYNBXOF6CGIGAUZD3DH
X-Message-ID-Hash: BO6LNDC4RX7BOHYNBXOF6CGIGAUZD3DH
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BO6LNDC4RX7BOHYNBXOF6CGIGAUZD3DH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello arm-soc maintainers,

Please pull this small kernel-doc fix for the TEE subsystem.

Thanks,
Jens

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-fix-for-v6.18

for you to fetch changes up to aaf46c6a6df6052881c2e75cba65aeb6f1cfa88a:

  tee: <uapi/linux/tee.h: fix all kernel-doc issues (2025-11-10 09:47:54 +0100)

----------------------------------------------------------------
TEE kernel-doc fixes for v6.18

----------------------------------------------------------------
Randy Dunlap (1):
      tee: <uapi/linux/tee.h: fix all kernel-doc issues

 include/uapi/linux/tee.h | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)
