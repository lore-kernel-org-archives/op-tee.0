Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92C3CFD31C
	for <op-tee@archiver.kernel.org>; Mon, 24 Nov 2025 07:31:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 20A164FFC7
	for <op-tee@archiver.kernel.org>; Mon, 24 Nov 2025 07:31:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DsApaOzq;
	dkim-atps=neutral
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B119142F67
	for <op-tee@lists.trustedfirmware.org>; Mon, 24 Nov 2025 07:31:41 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-65791c35134so1271112eaf.1
        for <op-tee@lists.trustedfirmware.org>; Sun, 23 Nov 2025 23:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763969500; x=1764574300; darn=lists.trustedfirmware.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SXfTjcbBUVxmgblzhyO1TYrzsrNzon8FKo3cFdBALAs=;
        b=DsApaOzqTfsErQPVZcX4jFXdNLeDd0MgbYB3KZ02aZ9zk+7sCvy8YUkzxbYs82piuA
         8TAS7z6C08g0kryBcmcoqsT5S1gbUZfsgdDkS+c4SAdykhefOa2Rga4vev7wzX3gy0bE
         ZXLei8mp7f55fE/S0xExUToisu4P+qCESMGwTooHPTKBfLGBSxPkRGiY1sIdeNmD9w0q
         6mM+zI1N3rkW6bHLUTe9GBl4OYZySxIBhFzNbjaEbmsKcKbkXUOxueFWjZDPOwZwdYul
         npOaayLRJEh1oYDpHEuvQgYccczk6wD9PZEMt5k8rh8RMf2kiPjxQPAed0sIK01LRwCe
         NLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763969500; x=1764574300;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXfTjcbBUVxmgblzhyO1TYrzsrNzon8FKo3cFdBALAs=;
        b=YaiWEU6j+Py0VLzaElclrqZbv9JLxPh5ctHAm7HusuRLzFqE+h87D0mG3tvq6GIJTz
         Lr+kD2DyTb8PyFTqWbmsypWqS2ymw0z8XE9Fb6EB0/uRCRwI/FLmcqur2NIaiBFrFA5G
         cKXArPhMN5ttsvLk7prgvf5C60u7e/Ux0vQr6kBnv8kIqmtSmLlS7RegMw8YY+FEGIPC
         mp691RtOoNx693NQZaQIZJMf/C1JR8vbh2F1NNJBCiTFTNKwhGYAIoSOXAM0cNSLbaGz
         rAP8wxKFSuS5k7rSM+4XYA2Js5SkRZmnGNaNbLd7MwO7z+UjkH6YfK++4oXH9N3kDxGG
         r5Kw==
X-Gm-Message-State: AOJu0YzMx0LL6pfZuxA+lhDlCo/ZYeOwxhK0HFoUBKXerIT2V+/O46ti
	F3SbURNzC84TcMtqDEr4U+vdivUE2duWvDaltMfncBvMhGLn3UptIWHFzC9p8uDtkSYrFZOYC3j
	AOfISvTLqpHavRt8szuzi/nd9vnwvQ1hUEV261uK7vGs7I6xblaXdz+REodKZ
X-Gm-Gg: ASbGncsaX8SYv0R9e2k1KXgdeJy8roveT83moRz/Gz5AMp+6p35k5ln/G9kkEEGllg7
	ptABgfNvLbthaa30qF5wO+DUuPlNUbKkahkvyZuXJyEv2wLPi6HGpVZwocWn561P9UuwWbIpYff
	CNnUuTceC51MqelPd32u02EYZngE/tq4gVOT7diYj/tk3+5GtZqUZWwKINCzlrOm+5ngOW6HWTH
	MkIOuUwkAzv/y1lRfnJv40j2JdV8vW2s0xPnO0xPSgbXZluKx/BweN/EG5UBv+k0C9UUA==
X-Google-Smtp-Source: AGHT+IExgS3qogUEnYZPwXjKfKBi3TYIK50t4bnELCg8wynHFTN73qsMZYcI/XRQMCZbSmol3F4b/DlZVCf1xWlIgTM=
X-Received: by 2002:a05:6820:178b:b0:657:6bba:676c with SMTP id
 006d021491bc7-65790b0061emr4092451eaf.4.1763969500337; Sun, 23 Nov 2025
 23:31:40 -0800 (PST)
MIME-Version: 1.0
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 24 Nov 2025 08:31:28 +0100
X-Gm-Features: AWmQ_bl_IOkpkAEEPMuX4JZd5i3c1YWIIVq5B9ofyMr01EM4YtGVXWSktJ07V1I
Message-ID: <CAHUa44FjeKTfcUd5vcxHOSDCgihdvOuijw8430h2hpqstu_U_A@mail.gmail.com>
Subject: Linaro OP-TEE Contribution, LOC, monthly meeting November 25
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Bar: ---
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B119142F67
X-Spamd-Result: default: False [-3.78 / 15.00];
	BAYES_HAM(-2.68)[98.58%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.44:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.44:from];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: YD76LFMJLV5OTZN3ZGPEFYMZ3ZBYV7M6
X-Message-ID-Hash: YD76LFMJLV5OTZN3ZGPEFYMZ3ZBYV7M6
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linaro-open-discussions@op-lists.linaro.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YD76LFMJLV5OTZN3ZGPEFYMZ3ZBYV7M6/>
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

I have a couple of small things for the agenda:
- A recent patch [1] on the mailing list proposes to export the OP-TEE
version info printed by the driver during boot in sysfs
- Do we have any questions or issues with the proposed CFG_* variable
improvements from the last LOC?

Are there any other topics?

Please note that the LOC in December will be cancelled.

[1] https://lore.kernel.org/op-tee/20251121141230.489294-1-jj251510319013@gmail.com/T/#u

Cheers,
Jens
