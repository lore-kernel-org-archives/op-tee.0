Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3B6C8303F
	for <op-tee@archiver.kernel.org>; Mon, 25 Aug 2025 18:13:22 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A331A460F0
	for <op-tee@archiver.kernel.org>; Mon, 25 Aug 2025 18:13:21 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iWWM0Cny;
	dkim-atps=neutral
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4C87542E22
	for <op-tee@lists.trustedfirmware.org>; Mon, 25 Aug 2025 18:13:05 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-437816d993aso2597633b6e.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 25 Aug 2025 11:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756145584; x=1756750384; darn=lists.trustedfirmware.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X/GHGfYAe5jFHnep43BOcGWqQq3gl9wKDcj9f7aD/hU=;
        b=iWWM0Cny/hX8OQnwygaN3nQTIO7yjwnc+UWMCquuqrS3i/aS7WvwS+buiuenygzlSd
         bfqh6WVhqkvrHLNnnCQvV7piW92Z4bKXuXgY2hMe593stbRKlOWOtIv3zhPvTElNvnpd
         BgyrLdbpgREKZYQI7gGiA2JEexlm13El0VnkcYyEhw6XjtACsweRt3APNDDGcWZxq02A
         y7Wko10bXrjv5DkD6QXxuOi52QFEiZkxu8NMTgg66eOVEmZTMDRbzUXZeWVPsdnm6s/1
         Y3nK8/ImFKvJcxhoMmOLQ7K8/w8AbuyHsHyrt0OSJXtBt5sOEy0hlyHN4d+6RuryLKvr
         Arlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756145584; x=1756750384;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X/GHGfYAe5jFHnep43BOcGWqQq3gl9wKDcj9f7aD/hU=;
        b=dwc3nf+HYno4NjaAHbBZGqXYHfQEvmNXEZZeXbnULuHu7rZ/+D3yXbNk/sA8uZll2o
         kxVh0grsfzX0sljpWDUgnfRxdCoerQPi5Pq2AfTgYLSMToftscqlbzDMh9wlrFZN1mSh
         Lmp1uAth33zdhKoI4GeEJ2xZliAOJeCxM3neZ+MCKyvBJYlXHYGIE3qnuh7RKjL+p17x
         AT9A0mtwTTCGqjTO4m3aVhMVqKjzGtMJ+bvcnmGu5zYbCU2qq2LozcLvN37YkJLTRQoc
         nxxkcBs1xib7MkwYDOn/6fK6p/NMmzMXEBX0ck8C1Yweao2Igtbw58xu4iJ95i4XnfPP
         dlGQ==
X-Gm-Message-State: AOJu0YxL8EQ9FISYGDtgzab8z0VxJoXvJxj3uy5UkxSiEXwnJwA/f9uP
	NlFkWx1qwNk0PRRzHYV91KVh7+GrQp3CkBpU8bI6bjrbcjq0IYOSSSKnvXJYN3MTCjUrUnLxvAp
	EHjdlFXxRBmJOtXZo8sSrAhKl/OE9R4l0NLsq4amHwnquKBUixmJKFl8jXQ==
X-Gm-Gg: ASbGncv2NGAiWUvrEdT/Pb4ZjpauC6L4DOCNiS2g+2CpVMk+op9CcN35nMHNB0mbgXG
	8l0SOKMOLOO1ZfJJ7OC+PQIQho/WLHk+S1W3Qa4uaMvPQqVbKy3c57BsvRDNPGobV31lbUKBHKN
	mGFP9lm9PI4obtQU++8WM2uFMQfEgBx0DeuVsRn2AIuxgqOb8Zr1+LPedzH28QZmMGpQSxU2KDT
	MjRZOZy+4jJpTELr3M=
X-Google-Smtp-Source: AGHT+IE297JlSEUbpW3Lhz+l0UPFCdGKE/0G/yoVRmjWY93PgQypoIXzFkX0rDtGDVzxC5qRhZGv3HVihz5zj3md664=
X-Received: by 2002:a05:6808:4f61:b0:437:7b15:78bf with SMTP id
 5614622812f47-43785301850mr4918693b6e.45.1756145583819; Mon, 25 Aug 2025
 11:13:03 -0700 (PDT)
MIME-Version: 1.0
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 25 Aug 2025 20:12:52 +0200
X-Gm-Features: Ac12FXxt3MO4HI2SMrms_jB3bpKCa3MuLQZL-SLqWIp0MIOH7_g-dsJIWEkWuRc
Message-ID: <CAHUa44F+=ak+WnQPRK1rRFuCbjEU0CASQi4a09TQYKfyJxpUmQ@mail.gmail.com>
Subject: Linaro OP-TEE Contribution, LOC, monthly meeting August 26
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4C87542E22
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.82 / 15.00];
	BAYES_HAM(-2.82)[99.23%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.171:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.171:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: FSV6QW4YJMBEWGT5DXIXO2WQ4WLRBEWY
X-Message-ID-Hash: FSV6QW4YJMBEWGT5DXIXO2WQ4WLRBEWY
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linaro-open-discussions@op-lists.linaro.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FSV6QW4YJMBEWGT5DXIXO2WQ4WLRBEWY/>
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

- Thomas Stauffer started an interesting thread [2] on RCU stalls
- The Secure Data Path patchset [1] is at v11

Are there any other topics?

Cheers,
Jens

[1] https://lore.kernel.org/op-tee/aKa_132R8SSZHywJ@sumit-X1/T/#mc88abedd1ad9773ddae5f26bf6b4fc8ef4b9eb8d
[2] https://lore.kernel.org/op-tee/20250813060339.2977604-1-jens.wiklander@linaro.org/
