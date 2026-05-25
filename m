Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81BACD5BD0
	for <op-tee@archiver.kernel.org>; Mon, 25 May 2026 13:02:14 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 17A8343035
	for <op-tee@archiver.kernel.org>; Mon, 25 May 2026 13:02:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HavMCrsW;
	dkim-atps=neutral
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3335A43035
	for <op-tee@lists.trustedfirmware.org>; Mon, 25 May 2026 13:02:08 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-69d79fc48d2so2555579eaf.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 25 May 2026 06:02:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779714127; cv=none;
        d=google.com; s=arc-20240605;
        b=GPFskM4dlcWkCqmlk9mN4vLdWihM17kmg7qexjmE411PIBk0HWFXby7XE1jtaguTCc
         ixYnbdM2JLZ7F5H4ups8x3AQrsTfhwAKgm9szRzchlCrPpvbX9/BGEYh/7ecBxfgfQ1o
         ziQON0jgI1ze6pdCH2UlvseMZgi2VwZhdCUAKc5ZVnfzsHJ45OL6WzfwVxkjBqUoCZt0
         qp+6MoHFTY3NPHx61qr3cgX7hYdH/3SF1UcS+PRZyBKbWgbA0ryNHKe40QRmBod8/nO3
         APbiyzl3WoNIRtTTwgfexUobAP4ZRkWSzEXKGo4D/LbY/XJbhX9c0hOUwlXIP83pSNS9
         1peg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=yQMcFEmR/aL0BcDNyLAcAVGfdZkYwkKgxLNNe7BqkFA=;
        fh=h3kY0GXiFaI5Go/7H8n5Dp/iY05qzVPPzJdGA/Bb43A=;
        b=LSdvh66Nsdww7gKvmkPOsoc5IHsUbMD+XAXM80gAzhDyYbCZ7SN6ZnRIQ8EGZXac29
         va4Ze/W3rVckrxH2WHgf+sKMnZxO9CHKmZc213NNwGRj9ciliwHMXnsmSSGKxl2iazlX
         niEf35F30hg3m8bPXXpz4Em7v/Gho0En0hGTl8Qzt2PEdkSQe7csjVV6XGDThY/l0UB/
         zlKjiZGlLg5zGuysPLhs2brF/gYMTtIFa2Wm6gRYL3hnPbBHnTstqR2Ei+6f2rH0KGOf
         /PVlWYU0VjsD6mFAAV1uEhFS352S1uEoG+l8HQ2+jBT3KYpBiRPWaFlifUC9G6ECV5cM
         8Svg==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779714127; x=1780318927; darn=lists.trustedfirmware.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yQMcFEmR/aL0BcDNyLAcAVGfdZkYwkKgxLNNe7BqkFA=;
        b=HavMCrsWODo4a4R/ZAvzrOiovMfpzu6cvr7enWsR9Hd9Fah4z6lnsbP+bh6/eFeCBp
         Q1gyYBiWZ2tr8RuYpTL9tMQWRNydY3Xm7ajmN59UhZL3tf9FW5uBV+rlMjLJQVps0+2l
         p09yXXcBKAiNuFxDZZqNxdn/3B3a2623hpTfyGM58AtXpgSUfBXs5IgXUywpzVa/Eelf
         0O1NXO8xSmw/H3Sbfza+wkWy4cWvOmVGu4UPukpymPvKlm9/07+lGsQ838diBzal8H6j
         wyx1bDaEKDEcPH4bUeFElwcPRSpGcYS8uRmk2UazMc3QnZtA2UjpLX5GmdlkW3SriBGi
         8fGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779714127; x=1780318927;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQMcFEmR/aL0BcDNyLAcAVGfdZkYwkKgxLNNe7BqkFA=;
        b=sE0/ZUuq3Yz/kFLCJUrTPR4lufj/+iVB3kyyqsCkAGXYJpkJrGrTM4+9J4l1yHcGYm
         CgUCvvc09LPzPM+qW4um6O6Tz80ReQu5UFaN0qg5QmFWtpgKGY3ix3EJ7cJBgukiqITp
         WayV/5Gi+LrckE9+hXZqDib/aGKN4LkNZQYm5dqPoMsGd732mdJ4mLs6xJuOjmhRnItm
         Nhh7L06vsk/MHPvgMcdlQdKcJbC8OmwHPAit2fjwSoMEoLTsiWDvON/ZNiaj0tChjXzc
         EnFrq5+BwEwVu1Wci0EbBLr0D46n7txLT3CszsI5dex/zcJN5W1vh/d8bpqslfiUw3Me
         RpVQ==
X-Gm-Message-State: AOJu0YwA9VWta4DeqpPDZjnzq2w+w9GhLK4wTl6hNgAKF7+BK8ztAO22
	4I69XpuOVE/xwZqEdG5s4dZclLUOY6AcBoLCE9OpzQaasRa0yzlh8DHTptgEDaO3UJ8NHJitH5P
	IQRS3ytUKzCfjQ8onxrwnHK4yVjIEt+etJBSDvb0QKZWoH5wPk1vDbFMBXQ==
X-Gm-Gg: Acq92OF3tEoVRSX6GiztEpotP3eXcKsbhbG/ZQu6Qm5SiUt/HskPcxYI9xevwEoierA
	fghz/5DXSInbkXoHYpf51ifUx0cV7kRzNljW8tiaJxO5tcFUrX7y/ciTWFMMGI1sMuaaWbivRVk
	AkPEFVzZwWxvO+lqivVO4EZj9WuP4yjWZtI52Zt+w/tsi3/0BY26S6YE1xKT5p17matLynWjh+i
	XlwrHcWFKYT7zDMMUMoEalpKX3H2etWdcrcgfN8XlocYzzaPBeTCsZYZjC8ojLH/pFK7RUnF6+K
	e++7J7DDgGVYvvxnSNwcBTjqrM/XCTNCLGIbJA==
X-Received: by 2002:a05:6820:80c2:b0:696:8e8b:2097 with SMTP id
 006d021491bc7-69d7eb4d41cmr7761535eaf.21.1779714127018; Mon, 25 May 2026
 06:02:07 -0700 (PDT)
MIME-Version: 1.0
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 25 May 2026 15:01:55 +0200
X-Gm-Features: AVHnY4L3ZoJazPReBTCnIBrqnpWpWPKgAOV_aiUjDZ5jRgWgYzTpFW0Ed2FnD70
Message-ID: <CAHUa44GNE3wMTD-pu0fwyXquyAywiR6FjZBG53j=du-pb+8u1A@mail.gmail.com>
Subject: OP-TEE Contributions Forum, monthly meeting May 26
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.97 / 15.00];
	BAYES_HAM(-2.87)[99.43%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.41:from];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.41:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3335A43035
X-Spamd-Bar: ----
Message-ID-Hash: OI3C53IQNCZBR6L27LAQ3VH6PXAJH2RP
X-Message-ID-Hash: OI3C53IQNCZBR6L27LAQ3VH6PXAJH2RP
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linaro-open-discussions@op-lists.linaro.org, Marco Felsch <m.felsch@pengutronix.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OI3C53IQNCZBR6L27LAQ3VH6PXAJH2RP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

Tomorrow, Tuesday, it's time for another OP-TEE contributors' monthly
meeting. For time and connection details, see the calendar at
https://www.trustedfirmware.org/meetings/

Regarding Kconfig support:https://github.com/OP-TEE/optee_os/pull/7714
It appears that the transition will take quite some time. We'll have a
window when some variables have transitioned to be managed by Kconfig,
but others remain managed by the makefiles. Do we care that variables
passed on the command line may work differently, depending on whether
they are managed by makefiles or Kconfig? Can something be done about
it?

Any other topics?

Cheers,
Jens
