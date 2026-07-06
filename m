Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B35C43458
	for <op-tee@archiver.kernel.org>; Mon,  6 Jul 2026 06:11:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CAE5E44E1E
	for <op-tee@archiver.kernel.org>; Mon,  6 Jul 2026 06:11:15 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=UYl/AdgG;
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C715444AE4
	for <op-tee@lists.trustedfirmware.org>; Mon,  6 Jul 2026 06:11:10 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47de008b020so287796f8f.1
        for <op-tee@lists.trustedfirmware.org>; Sun, 05 Jul 2026 23:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783318269; x=1783923069; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/bdFv9adbMBAAE/BgNz8t6NqJlo5QjKeLb9DjrAdvM=;
        b=UYl/AdgGYESsNhztYMWZkyRrRV1iDaS/WMne9yBh1AhcmzacwC7IxCq14T/6MQe+P6
         d58Cu+yZZkkW/7SI6CFbi48vRYXV0oGeRUX9Pw5wMa40MqxF28CP+P8/mgpRIwDtSVtr
         CoV4QnA7FlppZ9ggXmmR3pjBaCzs5aLnut+o7YI6qjNZLyHCnAE+TKpCnjKBBBqwgJKi
         r1QfZSW77M4jOOFBwAm8qr0/UGyfF0fUsp7hBhToaENePRMgJzomyJlFiYGfk8a5UR2Q
         +pjUL8crR4EACjfVbz+rcixvmnMD6IBzud5wRx+KU6k7zztyWhDRqamuJjBIADCag5o7
         v4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783318269; x=1783923069;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5/bdFv9adbMBAAE/BgNz8t6NqJlo5QjKeLb9DjrAdvM=;
        b=ZTzL/JyQ/s/4s3XPeGn/t8nZQ+Z4LEzK1HB3N0zMRejdN9fT1ktqYxLsJ5G17yM/Qc
         DF+8ioIbke3G81OwmcdniHMpMx365JxRVRwtFkNlI7/aFZAhDfRy2JEXX2636CTTQeae
         GPqadVyl7SXk0E3vD7MYZKZA8EJfy/cy8H6XL0X2Ap7aTotujvoVtFGYaDaizaEl4fmi
         wfuI7ILYp2PDDNI1KWOgh+7zqseI8BGjcmko6MWRGBAB7c8l9gda6InDYm44auBi+O9P
         SIiaVppxNWMkuqJAhhuSORL93OyYe+TAYu0AqkeUeSoA93+nzg82jLH/BjYdlul7Y0mQ
         wlRg==
X-Forwarded-Encrypted: i=1; AHgh+RqJEFCcUFk4n0ddVuBwXu+q2F/1KywUwpYu49yFa77MAVhvtHGIXgSJH/W2urNQor3n3S1PSqM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxCQtb3TnDh47RhSHURoOoJ2Rh7w2Mg1YYyl5JX0hR6kps2yHby
	6SjesKZjnNc3K9OdVxQfk69fjsYSFkf0E4kUzdtKNHrkLBrt2TUliH1/Q5jeyimLBnA=
X-Gm-Gg: AfdE7clUQvQL43LXOHJQb4UA6/MtXuH1G8DyXVjDLw/jnKblOSqG9S8HecfHr7hoqky
	ipsMu1NRATbzXehxuzIiwDD68KtO4j9RwcFQRsKKoS+PZE6Wx/XminyLKjRDeZ3NSD05lnAlxrC
	SYLoGT1te43GE2LPD2iwbWCdlIWE9GJ1djMv04tpRz4WDMroOJXwghAqEd3j6nj8Srf8pqzi6qc
	rLGVFayFoM2jMAPevlKR33D6ScTN5Gl8RL8NMGnnfm+xYngTuzlD+beUkLQ3BzSKSgAwh9h21Dv
	+2Gpef1O8ZFgRxY/b4DKDuiFEXi1wtlLG7aUsu0bns1rn/xhiv2pVp0fw9xS6MB3c6bLrYtGhMC
	MazW6Mjb/0BfToeo2ISBJE7np5IN71v9C9pe+nVpltKS02bMIMSi33MDEi+ilbqHCPaJwoHCxSL
	V7OZrxL8gPQ5a61diywqSLcuk6IUyGF7K8g7/wmq+GK0XTXdzbUZA=
X-Received: by 2002:a05:6000:1845:b0:46e:65ac:cfb3 with SMTP id ffacd0b85a97d-47aba8c65b3mr10526224f8f.1.1783318269412;
        Sun, 05 Jul 2026 23:11:09 -0700 (PDT)
Received: from [172.27.130.2] (97e782b0.skybroadband.com. [151.231.130.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ad69519c2sm22660353f8f.37.2026.07.05.23.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 23:11:08 -0700 (PDT)
Message-ID: <aafa0a02-6e10-457d-94d5-ee591e923bd0@riscstar.com>
Date: Mon, 6 Jul 2026 07:11:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: jens.wiklander@linaro.org, marouene.boubakri@nxp.com
From: Dave Patel <dave.patel@riscstar.com>
Subject: [Patch] review request for [RFC]
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.00 / 15.00];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	BAYES_SPAM(0.00)[40.23%];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.53:from];
	DWL_DNSWL_BLOCKED(0.00)[gappssmtp.com:dkim];
	DMARC_POLICY_ALLOW(0.00)[riscstar.com,none];
	R_SPF_ALLOW(0.00)[+ip4:209.85.128.0/17];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_ALLOW(0.00)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.221.53:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C715444AE4
X-Spamd-Bar: /
Message-ID-Hash: 223U5XGGVBPH2YXFPIZHOW7MMB623MI4
X-Message-ID-Hash: 223U5XGGVBPH2YXFPIZHOW7MMB623MI4
X-MailFrom: dave.patel@riscstar.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Robin Randhawa <robin.randhawa@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, Peter Lin <peter.lin@sifive.com>, Scott Bambrough <scott@riscstar.com>, dave.patel@riscstar.com, Ray Mao <raymond.mao@riscstar.com>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/223U5XGGVBPH2YXFPIZHOW7MMB623MI4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello Maro, Jens,
                 I have submitted a PR for review.
Kindly find the link below.

https://github.com/OP-TEE/optee_os/pull/7870

Thanks and Kind Regards
Dave
