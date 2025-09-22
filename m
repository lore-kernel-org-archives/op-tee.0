Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325FECAC592
	for <op-tee@archiver.kernel.org>; Mon, 22 Sep 2025 13:47:15 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6532F431C8
	for <op-tee@archiver.kernel.org>; Mon, 22 Sep 2025 13:47:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lQPfysbP;
	dkim-atps=neutral
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A42A240B34
	for <op-tee@lists.trustedfirmware.org>; Mon, 22 Sep 2025 13:46:59 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-62344ae5bacso1736275eaf.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 22 Sep 2025 06:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758548818; x=1759153618; darn=lists.trustedfirmware.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sVEDkJgt58rzA5Bt4gBbdrOhi+4tpe3Dm88nt9Un4og=;
        b=lQPfysbPKmKIoND9e0wt/obUkPH2yc/ebeC1b048GryYj3ZCzkw50MnBZGGfNzdBke
         6BI0jpsPdtIBFwOkhqJEpCtVq28YBZgmyNv36Aybvlk30W/mubEkK9HVAtRGrs6ik65S
         18Wqh16rSFgGdeSN007MSe1S7VVF3k2ckvV9Kc03YDfFGSIW5JNhNaTx/09mZcRH9td9
         yzO+MFo7CwI5ujPpcNlmn0K6L0/zq0x3H8DJqK9kbFVlb6sWQCkrwx9MPd6zfU0AsRD7
         HdZhwOZ17pU5Ejoa73NGJO0LOxK2yAts4sLnn5BmAFal9+EXfOiS2cLLz2TwxnWKfWDy
         3ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548818; x=1759153618;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sVEDkJgt58rzA5Bt4gBbdrOhi+4tpe3Dm88nt9Un4og=;
        b=MRvhcN+bplH9MiIdQ+Cz6RpRMHDqomVqKPBxF8WH11kwgvdkmdaiiqnR8QvllsUv7R
         OWAqN3AcpNQCzog9m4ri7575sriUJQQOBiAVJBwFtjHv3UVLGz8NVF4doBUuIXTkgNSJ
         vmqUvEps4RpT12dJ2yxHjuIsIQcaDaZMKEfpAjqssPXtR0sBdbg3HGZ0YWKy/6eGw+oU
         XMHm2wCKd5ruaf9KQrrTCNG3f7tGbeizK0laCgmCHQSXZe2MKYdcIebdM7KwXpQQRcOX
         YJMudswA2QvS+bS3FdEYbn5CjvBJDp9AWL2hieo2sNgNzD8uHLJeTPz1+fvSY/zmmVyT
         4S4g==
X-Gm-Message-State: AOJu0Yym4yH93krQBV3qLHNK1gWG+Yegj25dMZASSQMbTnZd+Hq9WBmO
	LDpZ7xtLGocjRhPqZUwbCah6cVGR4v7KnHR0VjWT5NLamXjiOfwcdbFiR5z+Zso5Anr//3y9Ur2
	46289RWqAR21OeHSoKG+uEvl8wQoPZiZan0w38KECrHcZvC8zBGUqGYw1zks6
X-Gm-Gg: ASbGnctJmWaD6IuUdtETsZ3gd3ZZahMgD1ya99DE0i28IDl5PM3P9/pmfQUWVinjEMc
	zIe4NrNBnQXvHVBJXAEhTOq3r9WvkpTG20JCO0qHlLWZ26qwKOPpgfzoh9c7WE4q2/2W/aXkil1
	FX4ANsTnB1Q9No9AIWvhKF39IToYw0w4SwjHi2OhX1iQDXVuwqAMR3I04dJ82A3kl77UtJP9OAy
	Fn3Z3Dr
X-Google-Smtp-Source: AGHT+IG6GlmwKFsd9Qn8UdSVUE8cZ6F4iZFwowzRpUZ9OIZwgJ8J14V+f0n+2jOk3MmS5vPrePDsmSKxc+MiNnLVqUw=
X-Received: by 2002:a05:6808:218d:b0:438:273f:d09f with SMTP id
 5614622812f47-43d6b6f27d0mr7709494b6e.5.1758548818211; Mon, 22 Sep 2025
 06:46:58 -0700 (PDT)
MIME-Version: 1.0
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 22 Sep 2025 15:46:46 +0200
X-Gm-Features: AS18NWCG24xuRRt4iisZZdDBDteJZDmrbx_znqNYZ2EpMr_SOm2C9gDehRcbibQ
Message-ID: <CAHUa44Hq3Faux3FbWeapagv_hx7RTX5U_-pNaxQf1FGX06ahjw@mail.gmail.com>
Subject: Linaro OP-TEE Contribution, LOC, monthly meeting September 23
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A42A240B34
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.48:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.48:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: W6LHMOU452EQFARBHAVB45MP6FOQOGIT
X-Message-ID-Hash: W6LHMOU452EQFARBHAVB45MP6FOQOGIT
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linaro-open-discussions@op-lists.linaro.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/W6LHMOU452EQFARBHAVB45MP6FOQOGIT/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

Tomorrow, Tuesday, it's time for another LOC monthly meeting. For time
and connection details, see the calendar at
https://www.trustedfirmware.org/meetings/

- Pull request for the Secure Data Path patchset [1], accepted by arm-soc [2]
- Pull request for the QCOMTEE driver patchset [3] has not been
accepted yet. It also has a few error reports or patches pending since
it was included in Linux-next

Are there any other topics?

Cheers,
Jens

[1] https://lore.kernel.org/op-tee/20250912101752.GA1453408@rayden/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?id=820429d53bd7
[3] https://lore.kernel.org/op-tee/20250915174957.GA2040478@rayden/
