Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02838C98328
	for <op-tee@archiver.kernel.org>; Sat, 17 Jan 2026 12:35:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 581EB432B1
	for <op-tee@archiver.kernel.org>; Sat, 17 Jan 2026 12:35:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vZuHRKWy;
	dkim-atps=neutral
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6087D432B1
	for <op-tee@lists.trustedfirmware.org>; Sat, 17 Jan 2026 12:35:26 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b8718187eb6so442398966b.2
        for <op-tee@lists.trustedfirmware.org>; Sat, 17 Jan 2026 04:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768653325; x=1769258125; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHB8mTWtkxvrvN+Vq3yTEJeDBWydoCoOf+W6FRB8+g8=;
        b=vZuHRKWyfQRZB20SClqLuvHJfnGAP0Z8smuojuyxIJxnpH7LYLjsXel0MfhLC4hYG2
         PCR7/wCcRE4ACE5eIEX5ICWEFTShgThyBfM3CtwuNtf+SqiKaFnPsxWRVPc6014Ou100
         5ZugSseJzqOy8FgJstjxU8yebtUDQS+BOPZuKJIJ26qdBASmw1vscFRIKl+RkjMOsi+Z
         nFSEohOBUfgq6TRUwwT4Wz/UDdwqx3vdwrbCHOLVCsXxGmNrQgDCpvJolFmYI0DIu90y
         TH5vFU9f4fTRXJhD9oLYZYKI5biFzs9yrHPCF8hkl/Pk+yKD3PTHCuN3xy9APcMIQuTn
         cgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768653325; x=1769258125;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHB8mTWtkxvrvN+Vq3yTEJeDBWydoCoOf+W6FRB8+g8=;
        b=B0UNjwHB2Y2Gh3eH9jjvzZnEGDGhcf2aMn3WDL/VCeNP9+rmeuqFZYpZ/VudMBcdcA
         i6EfEqttUBhhIHUfU/kqT/sGM5OBLUeieNdZ+NDpUqJ1TfdDCQMzgQ9QnY/rty6gozvZ
         mv3BRAR8oVkhSfUFgzV4iiEzMR1nPNdMtiYqo+kiUhPAswy2mRK7FhknnEG1OUXk/BDX
         6qfcIRqhjZ8Q71DSDk8Lp7fYQsQj6W8za8UjE/flc2Ywesa6zwsXRYRbFQNWrDMp+SmF
         udphNKsvAl8Po4JXRA3WHCyUL3/0HrSlBzkk28nZxX72wwJhBLAOzfaUw1fTk16JguuI
         UedQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWsChOahc+TwUCYtkk2CP9ND9GlJ2GZOis752ggrDZGF2HCASiSg94nPJxALr+krHUyp8Z+i8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxE4a//zu44F8KwDI5DI4XLdfFRzjGCAXts4Nb9K9bjTFI2+yjx
	Ik+5FqHeLOT7yVv/OztAMumcQcz2XeSNju8eAjKzcfA2eoJsV98IOTh136fUSXXToyDKew==
X-Gm-Gg: AY/fxX490DwKL2fGtUbjHMcO6kcj7V6sM3v53UyEGd+rz1vvxTQXk7kNyGrsCa/9EUI
	TXRHEMm1riAbyEZqqA96GdhOs286eIzbmx3ZyWl6x/vloQBsyl+kYumLB+4J+mSQfAkhWA7ra7O
	ez6eeLo7DtPTVjbJit9kBXGekuhfPYjUn1jJi3IuagpT+d5KjuWyHxIVRjK4r8cgpRtJelrtWd4
	zw6Y9AnGYA8JHxmV6iSdk0RdvIW7ZHxJNqOf6m0lZV+big7Fy7QJ73D5FC5vb5Znv5MdPyVKbpT
	j7vI25xIcCnQh+u1avRlin2OmskQBoC5gYIiVZyXoqTXIOtFAdloVxrKVEqL4KvUlPIawbE04/J
	p5YInnrfkzOx9NmtDONz4HammViD9CEaGUGAhBJPn7/mbyAKxoSB9x/UMTUAHnyKiY8lf0c1/jW
	tWNUEspRU222y2VozQVvDc2jY3nQ6rig7jU7nXZlduYfLhu9EoXQYBePiAF7tWzS2GutpaIMymf
	ZtSvL/J/U7rkMJFGQ==
X-Received: by 2002:a17:907:5c9:b0:b87:20eb:a66d with SMTP id a640c23a62f3a-b87932eb188mr453397666b.65.1768653325226;
        Sat, 17 Jan 2026 04:35:25 -0800 (PST)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879513e735sm530465166b.13.2026.01.17.04.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 04:35:24 -0800 (PST)
Date: Sat, 17 Jan 2026 13:35:22 +0100
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] AMDTEE update for 6.20
Message-ID: <20260117123522.GD255115@rayden>
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
X-Rspamd-Queue-Id: 6087D432B1
X-Spamd-Bar: ---
Message-ID-Hash: JRI2GJA6SUU3QXWV3NABJHM73NRDZHZL
X-Message-ID-Hash: JRI2GJA6SUU3QXWV3NABJHM73NRDZHZL
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JRI2GJA6SUU3QXWV3NABJHM73NRDZHZL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello arm-soc maintainers,

Please pull this small patch removing unused return variables in a
couple of functions in the AMDTEE driver in the TEE subsystem.

Thanks,
Jens

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/amdtee-update-for-6.20

for you to fetch changes up to a0db08f47c836251fbaccf711e12fe8428235465:

  tee: amdtee: Remove unused return variables (2026-01-14 10:20:51 +0100)

----------------------------------------------------------------
AMDTEE update for 6.20

Remove unused return variables

----------------------------------------------------------------
Thorsten Blum (1):
      tee: amdtee: Remove unused return variables

 drivers/tee/amdtee/call.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
