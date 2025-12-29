Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A006D3B7E5
	for <op-tee@archiver.kernel.org>; Mon, 29 Dec 2025 13:12:01 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B0A6841A2C
	for <op-tee@archiver.kernel.org>; Mon, 29 Dec 2025 13:12:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=G/WS8jl9;
	dkim-atps=neutral
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3C83741A2C
	for <op-tee@lists.trustedfirmware.org>; Mon, 29 Dec 2025 13:11:27 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-65749fe614bso2442264eaf.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 29 Dec 2025 05:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767013886; x=1767618686; darn=lists.trustedfirmware.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1uQcnUZxavdR2nyWvRLbRI5klGv1xP9PJ/DDwuZnO6w=;
        b=G/WS8jl9LVxgFZSSC9web3JYQ6c9VlfEUSbPlA+OzNOyEeACDgrUZkTdIrlIF7QDW3
         DJUKAoy20kn2wdlJg3bx15UbizT+WUr9F2gpfkiUZ+Il5AlYX7giRohvknjhwFwF1pp8
         teJmoVqmCPvpErx4rL6/wK9uK9B7xA0egHbCXOCd9WgwUyoWnk7Baw7NZrZxK/CGm9zu
         gKI+3ErHt36rUUMrOvE6LeJ3fF73x6Z48AIlPL0iKvC8qkwY+JjyilYa7o8CnfoQkuug
         x8hVOT5YSG/E6uU9U6VL32apSxFxavoD3WwuFtLkiBgT4jutM4GAJmUkCrTsl8OuaoTf
         lHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767013886; x=1767618686;
        h=to:subject:message-id:x-gm-classification:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uQcnUZxavdR2nyWvRLbRI5klGv1xP9PJ/DDwuZnO6w=;
        b=FPyILKX5FXINv72d1Yyr7/VcXX7nZY3ol1M4PtAWSP5SaPAgb58ozRhuIm9PSojEyF
         8Pbp06Zgqp5O1SL8b3gmhJK4cPx7JmWO9ddCTuuaUnEgZcdL0o7OxyS9KGV2lo70lKeS
         NnLWg9y5dkWl5XdGdFuDFMREth48QFWiGqaBl7Od4PXMIVyfK2DkEzwvVqE6G6js8O28
         lqHlaHGXa2nrusfgxYB3/frhQU5T0hWF+fplwU1PERDFUzy8fUei9PmmUMbiBYO139sV
         0e5W2HjBTowdRMKqY78pkV4mr4lStu3eRFB65WKsBDiYGItsyHVv9kIZa9aOL42fnTcv
         vrMQ==
X-Gm-Message-State: AOJu0YwZg1tsKmw51qV47Q6/DmliB3EZUPQxBJmC57qLN6s9aUbHS1Xe
	FRzeS4XQdJsjpEvje/4+C7+y+ta1XfT19RyQ7ktQhcTRYzpBqZoPqXDmT2QGfusaa3K5GP/y/Dw
	Pz+yyPXzU2288TT6uzQvmDWBudVj/NM8x7/xryP5Q6RfRRCgp4R+AbW3H1kmz
X-Gm-Gg: AY/fxX7nUgIfZlJsi8TFQouv7c5dYXjei6kPUudyb8NgFbyNkGfiNHv50rscWobyiTX
	SgYoP7Jt9PNUJhp08e7eWqzGVRH7WQRtrCHO5kJ0h4COAvQhQgiNydc3BYNyL3WzzHUuAc66moU
	KMyI+c+xM5kJafQXYTVmccL+qJbhj5kf962wxfJQmGFEMu5ZQ/4Y0lKJAKDtKJt41OHzQeboLzN
	/Y89Xd31de4IJzwN0udfSqtMO9fRhrFTzWQy72HPg8TuC2ojWE8WWFIiJYXLeo/FTcyotI6OmWn
	8I83SgWHdyZCWP4XtBGiDYZQmQ==
X-Google-Smtp-Source: AGHT+IHP1dEDLS20GD7iVYqsW+QTM9JBQydLiFxqt7DCIkU1wgKhAammZzXbskq1nn+DszO1dkUb8Aal5jpT3hikAUA=
X-Received: by 2002:a05:6820:1ca7:b0:65d:a21:d1f9 with SMTP id
 006d021491bc7-65d0e964186mr16800862eaf.5.1767013886182; Mon, 29 Dec 2025
 05:11:26 -0800 (PST)
MIME-Version: 1.0
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 29 Dec 2025 14:11:14 +0100
X-Gm-Features: AQt7F2rknt0TXC_unwTA4t1ppEG2R7xQgIiShniGHh4B4GnE19u8rkHXj5Ft-L4
X-Gm-Classification: 44d3c086f6ba5cf856b29c5886f5d8ae677af5084890e073a31ea284eab6bbe5a63fd456ea5fcfe3f7aa9a019397c1c07ef638798ae09d727c947d74bf818afeAPyDSpirgJeSBehDQ+rMdnl405BcsRDuUS+z/oDT1LGIFsxnePOTog32YvV5V56KeuHnkQS5SBHX0UpLMwgtW1Q3xgjKbE0awh5viWtmi7sgfoEmJNau4YeKlL2Bm/bWsRa6OYACZqX+Q1a9uibkdwh2HBVRcTWCUPYD5dpfwOqr+JX0SchBM53VL6DGEELs6zGkM+huZ60XtzssZ4HKEw==
Message-ID: <CAHUa44EGku-CASM1LfC74DXCS_PnoMnJyWd5nHhZxUzq=8YEow@mail.gmail.com>
Subject: Preparing for OP-TEE 4.9.0
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.09 / 15.00];
	BAYES_HAM(-2.99)[99.94%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.48:from];
	MISSING_XM_UA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_ONE(0.00)[1];
	DNSWL_BLOCKED(0.00)[209.85.161.48:from];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3C83741A2C
X-Spamd-Bar: ----
Message-ID-Hash: WDXPLTJWIRQEYWW5RMABAROCYDMRTQSY
X-Message-ID-Hash: WDXPLTJWIRQEYWW5RMABAROCYDMRTQSY
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WDXPLTJWIRQEYWW5RMABAROCYDMRTQSY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

[BCC all OP-TEE maintainers]

Hi OP-TEE maintainers & contributors,

OP-TEE version 4.9.0 is now scheduled for release on 2026-01-16. So,
now is a good time to start testing the master branch across various
platforms and report or fix any bugs.

The GitHub pull request for collecting Tested-by tags or any other
comments is https://github.com/OP-TEE/optee_os/pull/7666.

I have now created the 4.9.0-rc1 tags in the various OP-TEE gits.
Please proceed with the testing.

You can find more information related to releases here:
https://optee.readthedocs.io/en/latest/general/releases.html

Thanks,
Jens
