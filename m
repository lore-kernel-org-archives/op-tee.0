Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB01D489A3
	for <op-tee@archiver.kernel.org>; Fri, 16 Jan 2026 13:09:59 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B6754436CA
	for <op-tee@archiver.kernel.org>; Fri, 16 Jan 2026 13:09:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=V7bP5HgH;
	dkim-atps=neutral
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C83E74314A
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Jan 2026 13:09:18 +0000 (UTC)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6610b241d19so1006158eaf.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 16 Jan 2026 05:09:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768568957; cv=none;
        d=google.com; s=arc-20240605;
        b=P6tYl3ToX6feQDD4eXTYWkI+A1LZldXfJXrMKfiV4owJvQDDYQrnCorTUQHNzzUPfM
         HfwT5kw3tTFwYdTVpCQyJsDCVjHewyAiFiigvUybOxChN5Y6VH3kohFTszUim2fgtAZo
         SnYXIm6V3/ah/XOOVyJsIzgmIC0Ne5rE8CuFLvjAFhnqh9uHNcYBDRI/a//625jv82Z+
         W0Fy69hXJ1fyQ23Wr+N7wU2juTP44GCv2SADDbmQsZ4fb4p+YOhDd0wHQ4+D8fO8Jmr9
         D10PQ1O4XJI2lnsEm7xJ3Xpe4TG62kxk/Pv/+CY7DShGmmTtcTFIVnOoIF2xMJFbVGis
         0OHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=po5D3Q+1qXv2x+OgIgZaCm+pXu+QVc/vG+5MO0Ey/Gc=;
        fh=ti7oct0RsDXw6/2Q+S6sHhPG2CPVT/IQ9Yun4xZhon4=;
        b=fO84Yx99279YZ8jVZryPzl1RcSFxgg4KQ4MMIzq8bb02KcvX2yknVPt5EDVhfT0YWG
         k4qrUpPCClQrDwcPfvRCY/QxuS4BuhgJ7Dj9IUsULl3lbvL06zBZJ1tYvbrnYqLovD1C
         xxjsfdJU+Yw/t9iYJA7rWSezDvRdAYkCvUlkJ2DyZVlUvBjs4nuPkoAdErO8VzLGcccL
         SQTgftvqVrsEe6rIINJoER816bpkdrrMIBJVAevfLuhL2xT7JNV8nNcHzi3JifnpmRur
         pu2kXXQo058y8OyF0Acz5VClJk7S9NowN/v2Lxcw+HTkiWTOtoQIUlAkLG/orSaFMy3Z
         qBiA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768568957; x=1769173757; darn=lists.trustedfirmware.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=po5D3Q+1qXv2x+OgIgZaCm+pXu+QVc/vG+5MO0Ey/Gc=;
        b=V7bP5HgH0p8Sb91bKXe+mkIAgzxn0E4MNBaQegj7q5SsUJAYkuDkU/OaX0Ra3y+3pA
         DEZMcvP5b6yA4oyfV8OZROpnqm95/SomFdWt//DxI8zjtw0SZKB87t42jvILI4iJU2c8
         vwe3Es3yggI1wbZCvJxVQfKfvV+3Tpdy6i0lTEgjPNQSIN06Cm3eKA+A1MiQVPq2x/Di
         A6fdZO/O9ZYugo8S5TiqMgjL1tbr9u+dnXx6x054XWtoo2ZKseY6OkpligIEld5Ptfs/
         1BG/0OAkMORCwYgID0724UQscCX1TYJsXTDRCppgpzyPn6BXd+xKhgveWY8QscO7Gzop
         yu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768568957; x=1769173757;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=po5D3Q+1qXv2x+OgIgZaCm+pXu+QVc/vG+5MO0Ey/Gc=;
        b=JRTN0isTspqqaAmDZ0nOe69ALig1DHNla+95apvYLaloSYz0CxlHHwRwmm0JTRqIxx
         mJrvyd3FMUooAfJ46bjWqQvYkrU+CTuRAoU3r4mj9sKKyQfs5OpytK308qcYlx7U6pDx
         uPUVtt3xeXf5ZNimLRyMTjYNx/HeG02Cl6n6KoDxl55LlDzQCf+DVj9EmDil896iBK85
         IQvXcKt1xgmQ4uCaAd33E440IbPubGesq3s+SJK6+Rd7+LzeDXzW9OJxl/cSn9AV0L1P
         0E/YrKIvYwVBGNU+r7Gr/GBp2x6Dpc8s07snzI5ooQbA7aWW+KknhWwQtpN3y+scIHB9
         HIeA==
X-Gm-Message-State: AOJu0YyhuI0tYVmlZKesqprlN2zJCsHn/U4NA9GuWcqIishzUDO1avE/
	fpIyacYUuHS4Jfc3v+o5XH0/keTY3FqCWuFAbRlKeMpC/731jDVkjWntkQ35bKrXNfTOdXeXtvE
	tp/MgWi2v7BUBszDASnqpfou2CPlaRoc6cCEWbdcuiG+LZ82ty9B+uKk3CD7e3Ls=
X-Gm-Gg: AY/fxX6AZIHg8NJPNmnDrItz8oxcVxoI8KhXw2amIbnZY6uWhbFEc6yZ2mTwcrM9ZUT
	mt4rGB9moccHs8qIEnYIdZXsfwbNVBbNnkwKTS9tmC6TFbIUUvA4/COdxncZAKHCUWzAjU9wltA
	u5g4vMz4rOEzylq3GefypZRVF96mftuduICHtNi4RyPQdPDbnfFSgI+1xgGu69wHmZM3cBh6k1d
	KS9i5deK1GSRP+JWJjFCup5GqXcucfcrGmprDaLExZMJCsEuNO5u+EsvNS96zcTihfQRW2B55YN
	+CeCIBMbVucmr6OmJ3UYir8CXg==
X-Received: by 2002:a05:6820:216:b0:661:145c:c418 with SMTP id
 006d021491bc7-66117914036mr1402132eaf.1.1768568957536; Fri, 16 Jan 2026
 05:09:17 -0800 (PST)
MIME-Version: 1.0
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 16 Jan 2026 14:09:06 +0100
X-Gm-Features: AZwV_QhHg5DivEGZYIPFsHuQIltwgOy6phiGBfQ0g__6yBQOClfanSmS1wXCji0
Message-ID: <CAHUa44Euiu1COV9NKwWycMSn7xhb4foFWLOMFkHGFR+4MjjZnA@mail.gmail.com>
Subject: OP-TEE 4.9.0 has been released
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.59 / 15.00];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	BAYES_HAM(-0.49)[79.81%];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.42:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_ONE(0.00)[1];
	DNSWL_BLOCKED(0.00)[209.85.161.42:from];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C83E74314A
X-Spamd-Bar: --
Message-ID-Hash: B2LM5PYQRF745JSML6AO2OFVSHXZ7ZUM
X-Message-ID-Hash: B2LM5PYQRF745JSML6AO2OFVSHXZ7ZUM
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/B2LM5PYQRF745JSML6AO2OFVSHXZ7ZUM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

I'm pleased to announce that OP-TEE version 4.9.0 is now available.
The list of changes can be found in the changelog [1].

A big thank you to everyone who participated with contributions and
helping out with testing the release [2].

[1] https://github.com/OP-TEE/optee_os/blob/4.9.0/CHANGELOG.md
[2] https://github.com/OP-TEE/optee_os/commit/c2b0684fcd89929976a8726e6e3af922b48dd2c7

Regards,
Jens
