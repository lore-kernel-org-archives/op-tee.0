Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE73D5B16E
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:23:27 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AC1BA4FEB7
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:23:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Pk93Iy6y;
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 13C6F4FE9E
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 14:17:48 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b727f452fffso540242066b.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 06:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808267; x=1766413067; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lBoMkq+p5dQ2OsBBFnXVtnCRh4ggCKmjrfxDYkmgHo=;
        b=Pk93Iy6y6nMXOfQN9k2j7DPKnz8A2XXu9m0Z4iclL16zjjBLO3KO57KUx7DIG7rWED
         BXuEIEjYdASVxf+SNAcgoOHse+rfBHN/SGaVoWZPibajU/oZkZw/eoU06c8HsTafX47t
         7S+ipbSDa7NAXH8EqpTVzSWx7ZsHdlkt5YHGIoz83yA+K1NehRHaCGFW+UFHbNtI2kMr
         QYwMz44+EnfqTluOKLpoK2OlM0EHSUveV6DCLigFEYctnO5YfgcqryCeuKVZS02jPoiL
         l6ux25/NcG+VtiJxRyv7VWW/BPtr4I/vrPjfUujOJsYKfhzdkJetWzAOs+1oEEVH+B68
         phGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808267; x=1766413067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/lBoMkq+p5dQ2OsBBFnXVtnCRh4ggCKmjrfxDYkmgHo=;
        b=aWCuOR70UGk3Vtzt41iMgm13WMG8pRN/vB8KsC6cP8X7cIZK4TonadvqEL6dqIIHpk
         7fZpO7HbBO3G3kkhW8Ti0RnXsFqFgjDngBRY4HDBfbUdLxbvujdnADabstmec1jOz1gD
         t/UTkNBmNYcE9+yAswtWHlFv4xQxP4rItQPbHINmHbzp+wfLrsyYjFGE8XpJd6O1c6Tr
         v/6AOQ5wz+e46ZgQ646CFxGwlB9cYYA2/NlKK9TtdID/e9IHSzIXG3UgF8bL3uoj1cGG
         OIFlsIXcqRjMP613SJ7MD9J9RDSkfgKdJnzOxcf9799sLqMa71PuYHTG3WO96m8G5k9Q
         NXyA==
X-Forwarded-Encrypted: i=1; AJvYcCX9maa/+WZBNVXJxlvUynleK2Fxw7XxSU5wcn+2fVNmlcBGMfGgZo/GHZrKxRYdEpRR7jtr3iQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxuP5pqC1GPg9Pe0v+B27UqZJQMxJtks0zSO6YxhOijbTVyku+i
	NOqU6jwEI+kUiWmZlstW+bXEFOjKmRaosRNH/4w2Vpk9EaFamxfwgISJ34/ed7YQfKI=
X-Gm-Gg: AY/fxX784mXRI48wGBolbH88SeOaYcjBpUoQnLk/gZecTJfji+njaoegBSQE8BBX7pI
	JbmP48jzNjeUCYDe0utPUdWhA3mZ6Gp1xTV+AOTyx/xuxF0HbvZZxAJsieeTb5N+la7ZHjgOrBw
	B1wchePrvxTBxmd0z0W7Jky7orfOfM0Tk8vIAZJmzMtx87Tn7mZ+fInJMRrcBQzhgWpFKzp5QBU
	Hle34zOBGOwcrok3rvjEDng+05yjYuYZBzt0nDTGFI5NHjddMJbaPNB5JzvNkbZmWW0zqqskyTb
	DpfUMsKcpqDum3AES+i+N9pubrQQkR47wOizaU2UCP2UTcqTAANkCiHqpWNeEMjgxr8cIYycCPG
	Iy7+N2ke8jEXPyu/SY1h1u0s0u7/Thaw8Ye3vl+DXNKy/+BKE0xfoKb1xDRB+J1K2Lb3ktaFWi5
	9d70VO56RVEvq+iUkZBdjn4wSNTYi3BhHrxIHe4pHKjQbwQVGrPLGS4VPTtjsoneu/t07S
X-Google-Smtp-Source: AGHT+IEwhpzpbutxcSFXZMLWPGgvdTBRCn78tGwOj7IZhNrS+hZ8IxpcNZHWAUSqv1MI4HUnh3hlrQ==
X-Received: by 2002:a17:907:dab:b0:b07:87f1:fc42 with SMTP id a640c23a62f3a-b7d217ed7d2mr1308406266b.16.1765808266933;
        Mon, 15 Dec 2025 06:17:46 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7fbd7a55dfsm554177066b.25.2025.12.15.06.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:46 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Subject: [PATCH v2 08/17] efi: stmm: Make use of module_tee_client_driver()
Date: Mon, 15 Dec 2025 15:16:38 +0100
Message-ID: <6a56ee61e485703d548e9e44d53b2920b4e43ca6.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=yB7VDr3EZSkvb6JHyGDNmAwFJZy2w/A1L0P7+9qGdqk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhgZ97MgwPHXb+Xx9vet2pJx/fRw7XXThLnp 2crAvT8GvSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYYAAKCRCPgPtYfRL+ ToTlCACS5iflL8JzBfIHFC4dd9QU1VLCJ23/o3MwueoTbG3c0T+3+Ab5eAFzodoVurAYliob5pu dCvIygjW7D5m9ySrn4/XgKkHiY54AGvSbmsSNrVesGd4oFJGf3Nbo3TsaUZZWYnmY0+ypytx3sC jYoNu+MOi8Cr8BnQTHvWqdqh3lzQzJ8TOJIedFd0Wdh/LeHfoC6mf8mhe6wrufJ5R6QAS3sVl5y 1KnEG5sqI8XvYvgx261qZIjrxPtBeaWahLjOKNLFkGpC7HWMfBbAVP8nVWNbNXWRUZ3IVjMiJlW 5seuM+gr+TKUjwts24xtV5LeZbaCTzjo6uZIsnOl+ujpHHdr
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.80 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.42:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	DMARC_NA(0.00)[baylibre.com];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,kernel.org,gmail.com,foss.st.com,oss.qualcomm.com,siemens.com,baylibre.com];
	ALIAS_RESOLVED(0.00)[];
	DNSWL_BLOCKED(0.00)[46.5.122.62:received];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 13C6F4FE9E
X-Spamd-Bar: /
Message-ID-Hash: YCHEX4QUUPCCVDN5OWMJK7BQGP4VSZ2H
X-Message-ID-Hash: YCHEX4QUUPCCVDN5OWMJK7BQGP4VSZ2H
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YCHEX4QUUPCCVDN5OWMJK7BQGP4VSZ2H/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

UmVkdWNlIGJvaWxlcnBsYXRlIGJ5IHVzaW5nIHRoZSBuZXdseSBpbnRyb2R1Y2VkIG1vZHVsZV90
ZWVfY2xpZW50X2RyaXZlcigpLg0KVGhhdCB0YWtlcyBjYXJlIG9mIGFzc2lnbmluZyB0aGUgZHJp
dmVyJ3MgYnVzLCBzbyB0aGUgZXhwbGljaXQgYXNzaWduaW5nDQppbiB0aGlzIGRyaXZlciBjYW4g
YmUgZHJvcHBlZC4NCg0KUmV2aWV3ZWQtYnk6IFN1bWl0IEdhcmcgPHN1bWl0LmdhcmdAb3NzLnF1
YWxjb21tLmNvbT4NClNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1r
b2VuaWdAYmF5bGlicmUuY29tPg0KLS0tDQogZHJpdmVycy9maXJtd2FyZS9lZmkvc3RtbS90ZWVf
c3RtbV9lZmkuYyB8IDE0ICstLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUv
ZWZpL3N0bW0vdGVlX3N0bW1fZWZpLmMgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9zdG1tL3RlZV9z
dG1tX2VmaS5jDQppbmRleCA2NWMwZmUxYmEyNzUuLjU5MDM4MTE4NThiNiAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZmlybXdhcmUvZWZpL3N0bW0vdGVlX3N0bW1fZWZpLmMNCisrKyBiL2RyaXZlcnMv
ZmlybXdhcmUvZWZpL3N0bW0vdGVlX3N0bW1fZWZpLmMNCkBAIC01ODQsMjQgKzU4NCwxMiBAQCBz
dGF0aWMgc3RydWN0IHRlZV9jbGllbnRfZHJpdmVyIHRlZV9zdG1tX2VmaV9kcml2ZXIgPSB7DQog
CS5pZF90YWJsZQk9IHRlZV9zdG1tX2VmaV9pZF90YWJsZSwNCiAJLmRyaXZlcgkJPSB7DQogCQku
bmFtZQkJPSAidGVlLXN0bW0tZWZpIiwNCi0JCS5idXMJCT0gJnRlZV9idXNfdHlwZSwNCiAJCS5w
cm9iZQkJPSB0ZWVfc3RtbV9lZmlfcHJvYmUsDQogCQkucmVtb3ZlCQk9IHRlZV9zdG1tX2VmaV9y
ZW1vdmUsDQogCX0sDQogfTsNCiANCi1zdGF0aWMgaW50IF9faW5pdCB0ZWVfc3RtbV9lZmlfbW9k
X2luaXQodm9pZCkNCi17DQotCXJldHVybiBkcml2ZXJfcmVnaXN0ZXIoJnRlZV9zdG1tX2VmaV9k
cml2ZXIuZHJpdmVyKTsNCi19DQotDQotc3RhdGljIHZvaWQgX19leGl0IHRlZV9zdG1tX2VmaV9t
b2RfZXhpdCh2b2lkKQ0KLXsNCi0JZHJpdmVyX3VucmVnaXN0ZXIoJnRlZV9zdG1tX2VmaV9kcml2
ZXIuZHJpdmVyKTsNCi19DQotDQotbW9kdWxlX2luaXQodGVlX3N0bW1fZWZpX21vZF9pbml0KTsN
Ci1tb2R1bGVfZXhpdCh0ZWVfc3RtbV9lZmlfbW9kX2V4aXQpOw0KK21vZHVsZV90ZWVfY2xpZW50
X2RyaXZlcih0ZWVfc3RtbV9lZmlfZHJpdmVyKTsNCiANCiBNT0RVTEVfTElDRU5TRSgiR1BMIik7
DQogTU9EVUxFX0FVVEhPUigiSWxpYXMgQXBhbG9kaW1hcyA8aWxpYXMuYXBhbG9kaW1hc0BsaW5h
cm8ub3JnPiIpOw0KLS0gDQoyLjQ3LjMNCg0K
