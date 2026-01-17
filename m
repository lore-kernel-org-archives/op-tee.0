Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F9CC98328
	for <op-tee@archiver.kernel.org>; Sat, 17 Jan 2026 12:30:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 617124329F
	for <op-tee@archiver.kernel.org>; Sat, 17 Jan 2026 12:30:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PCWAV5/d;
	dkim-atps=neutral
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 63C0443216
	for <op-tee@lists.trustedfirmware.org>; Sat, 17 Jan 2026 12:30:12 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-64d30dc4ed7so5445133a12.0
        for <op-tee@lists.trustedfirmware.org>; Sat, 17 Jan 2026 04:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768653011; x=1769257811; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4m/7Bfur2xzRjYnG86QrkUmg9v434JD51BbkdRFTRE=;
        b=PCWAV5/d/w6dd35JQFwRMO5yM0bd0yyjsrH29wHg4Ym5Spt58dXe6qTomjkNR4IuXX
         /8slrwFT7Hd2RocCjAXIL3AVJpY0ne0yWRBK5I913GZLlbhl/9UHl6iSBbzrlVUouuw5
         M6v9EYxXQzi7ETBi0nY2LMQ1TN5RarUpY4RQAeVKBDe51TlgZcogSKfFF7iyhOHXkYw7
         Wm7uMnmCbGlYcOhltPy4xlF168KrazEXFmenqnVQBq30cuoCn8+pEbM6bUtgq8pHE6GW
         4IIYITtAqf6Rf4w/uxpNgjaunk7RjYh7xBgkWM7FL6XWOCi9hbXFeqzPhK85++9dvjMA
         tUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768653011; x=1769257811;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y4m/7Bfur2xzRjYnG86QrkUmg9v434JD51BbkdRFTRE=;
        b=F0rZj4jOQKmNm0DC0C7GbzP3kpLhiJxV6vWZUi/0MU1wUsGGUpVabQ+DuDQFAsYm3R
         U1TDPRkBNpqMbsZln5rnDltNrA5sXerXykhfpFUo+Psn/9uXkt4J+kgxUR+ERJ5XJJbO
         nR9MXnjFse9n1LF2u391lLnAUCc1eWmRF856+g15Zgc3e00WGSP/I/wpFB4sikOBXHif
         ONmJV7/wDv7E24i+NyhGfmiisR2b7yCUyZHx48e2LtDuJysIo+Ir5yTNxU34KykdVVDg
         2og3MeVO9dgtCdVbFWuoqBj+7doqSsVZ9w/Y7uVUGBLfvDZglD+/HM48MruhXrPU/stc
         Wa2A==
X-Forwarded-Encrypted: i=1; AJvYcCUKZDgxT3G//WyEAzIp3MPak/47hHe3C+TWSH5W140s9haxHcEJfBa9xFOPs/Z6957lGGWYygw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzoVUGLFW0wVN88xCWzm531Mkm/u9EUSMMgfjf39tG5UPolohH3
	TFh4LzVKffUsNRxQvvFLkdmWqpci+crFUP4TgsWtAKKNhi2kdxfYp7TcusmFfjjK1qzjtA==
X-Gm-Gg: AY/fxX4V3ycCw/QBDXLb2CZBqtUphb1+hA3hlEtEC2oBH08yn5reddoJ9Gqd8B10+F9
	LG7BkYE4cn6PM4m1GXWU1YSd46sP/CyNDA5AN718v9gE0lcgy3IW43qiWC2TnC/lN6+3io/n4qV
	ib37p5aOrx+65Sn4g5QKcLSPfVrM1dFMCqpYfql1Qrs6yJ78gg5GL09ex8U4fFW+zTo1O29/WLV
	UDjWIVH9vBAH4lNRdz0XgKsJc20xrA/QWyoGBnH6CggBTp0rC1tYnc7LvEKrj+Fx1zH6taeVDNV
	dqwe7HntBQ7oFDXTmQj7utedmIwn2HodvOGgmVFq5CA/x/CQlLiVZPc0F7vtVmr6e0hspNNZ9ns
	ejb3DlWYyu4JOK6931Gt0t0abCt3pPvWULs54z+7tO9X04BhG2ZDMwm+2l24yzCM9M22ZEKLw95
	o7qb/V7vki8RMINPssV+yKPIYcFwvQDS2N/a3X6eoYhoj7cMAMpRZpuUw464Ha7Vlnk4T3YWOwS
	dQgdcA=
X-Received: by 2002:a17:907:948a:b0:b7a:5c1a:85e with SMTP id a640c23a62f3a-b8792e2f94cmr478693066b.23.1768653011270;
        Sat, 17 Jan 2026 04:30:11 -0800 (PST)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9f98sm553325266b.42.2026.01.17.04.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 04:30:10 -0800 (PST)
Date: Sat, 17 Jan 2026 13:30:08 +0100
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] TEE bus callbacks for 6.20
Message-ID: <20260117123008.GC255115@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.65:from];
	MIME_TRACE(0.00)[0:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.65:from];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 63C0443216
X-Spamd-Bar: ---
Message-ID-Hash: PWNB3CSEH4KLT2TJL4M7KZLNICMVWOSH
X-Message-ID-Hash: PWNB3CSEH4KLT2TJL4M7KZLNICMVWOSH
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PWNB3CSEH4KLT2TJL4M7KZLNICMVWOSH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGVsbG8gYXJtLXNvYyBtYWludGFpbmVycywNCg0KUGxlYXNlIHB1bGwgdGhlc2UgdXBkYXRlcyBh
ZGRpbmcgVEVFIGJ1cyBjYWxsYmFja3MgdG8gbGV0IHRoZSB1c2VycyBvZg0KdGhlIGJ1cyBnZXQg
cmlkIG9mIHRoZSBzdHJ1Y3QgZGV2aWNlX2RyaXZlciBjYWxsYmFja3MgLnByb2JlKCksDQoucmVt
b3ZlKCkgYW5kIC5zaHV0ZG93bigpLg0KDQpUaGUgbWFpbnRhaW5lcnMgZm9yIHRoZSB1cGRhdGVk
IGRyaXZlcnMgdXNpbmcgdGhlIFRFRSBidXMgaGF2ZSBhZ3JlZWQgdG8NCnRha2UgdGhlc2UgY2hh
bmdlcyB2aWEgbXkgdHJlZSwgd2l0aCB0aGUgZXhjZXB0aW9uIG9mIHRoZSBtYWludGFpbmVyIGZv
cg0KZHJpdmVycy9maXJtd2FyZS9icm9hZGNvbS90ZWVfYm54dF9mdy5jLCB3aG8gaGFzIHJlbWFp
bmVkIHNpbGVudCBkdXJpbmcNCnRoZSByZXZpZXcuIEhvd2V2ZXIsIHRoZSBjaGFuZ2VzIGluIHRo
ZSBkcml2ZXJzIGFyZSBzdHJhaWdodCBmb3J3YXJkIHNvDQppdCdzIGJldHRlciB0byB0YWtlIHRo
ZXNlIHBhdGNoZXMgdG9vIHJhdGhlciB0aGFuIGV4Y2x1ZGluZyB0aGVtLg0KDQpGdXJ0aGVyIGRl
dGFpbHMgYXJlIGluIHRoZSBsYXN0IHBhdGNoIHNldDoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L29wLXRlZS9jb3Zlci4xNzY1NzkxNDYzLmdpdC51LmtsZWluZS1rb2VuaWdAYmF5bGlicmUuY29t
Lw0KDQpUaGFua3MsDQpKZW5zDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQg
OGYwYjRjY2U0NDgxZmIyMjY1MzY5N2NjZWQ4ZDBkMDQwMjdjYjFlODoNCg0KICBMaW51eCA2LjE5
LXJjMSAoMjAyNS0xMi0xNCAxNjowNTowNyArMTIwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUg
R2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L2plbnN3aS9saW51eC10ZWUuZ2l0IHRhZ3MvdGVlLWJ1cy1jYWxsYmFjay1m
b3ItNi4yMA0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gZTgyZDA0NzdmZDgwNzA3
MjIxYzNkMTEwZjU2ZDA1NTA2ZGUyNjk4YzoNCg0KICB0cG0vdHBtX2Z0cG1fdGVlOiBGaXgga2Rv
YyBhZnRlciBmdW5jdGlvbiByZW5hbWVzICgyMDI2LTAxLTE1IDEwOjI4OjMzICswMTAwKQ0KDQot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQpURUUgYnVzIGNhbGxiYWNrIGZvciA2LjIwDQoNCi0gTW92ZSBmcm9tIGdlbmVyaWMg
ZGV2aWNlX2RyaXZlciB0byBURUUgYnVzLXNwZWNpZmljIGNhbGxiYWNrcw0KLSBBZGQgbW9kdWxl
X3RlZV9jbGllbnRfZHJpdmVyKCkgYW5kIHJlZ2lzdHJhdGlvbiBoZWxwZXJzIHRvIHJlZHVjZQ0K
ICBib2lsZXJwbGF0ZQ0KLSBDb252ZXJ0IHNldmVyYWwgY2xpZW50IGRyaXZlcnMgKFRQTSwgS0VZ
UywgZmlybXdhcmUsIEVGSSwgaHdybmcsDQogIGFuZCBSVEMpDQotIFVwZGF0ZSBkb2N1bWVudGF0
aW9uIGFuZCBmaXgga2VybmVsLWRvYyB3YXJuaW5ncw0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpVd2UgS2xlaW5lLUvD
tm5pZyAoMTgpOg0KICAgICAgdGVlOiBBZGQgc29tZSBoZWxwZXJzIHRvIHJlZHVjZSBib2lsZXJw
bGF0ZSBmb3IgdGVlIGNsaWVudCBkcml2ZXJzDQogICAgICB0ZWU6IEFkZCBwcm9iZSwgcmVtb3Zl
IGFuZCBzaHV0ZG93biBidXMgY2FsbGJhY2tzIHRvIHRlZV9jbGllbnRfZHJpdmVyDQogICAgICB0
ZWU6IEFkYXB0IGRvY3VtZW50YXRpb24gdG8gY292ZXIgcmVjZW50IGFkZGl0aW9ucw0KICAgICAg
cnRjOiBvcHRlZTogTWlncmF0ZSB0byB1c2UgdGVlIHNwZWNpZmljIGRyaXZlciByZWdpc3RyYXRp
b24gZnVuY3Rpb24NCiAgICAgIHJ0Yzogb3B0ZWU6IE1ha2UgdXNlIG9mIHRlZSBidXMgbWV0aG9k
cw0KICAgICAgaHdybmc6IG9wdGVlIC0gTWFrZSB1c2Ugb2YgbW9kdWxlX3RlZV9jbGllbnRfZHJp
dmVyKCkNCiAgICAgIGh3cm5nOiBvcHRlZSAtIE1ha2UgdXNlIG9mIHRlZSBidXMgbWV0aG9kcw0K
ICAgICAgZWZpOiBzdG1tOiBNYWtlIHVzZSBvZiBtb2R1bGVfdGVlX2NsaWVudF9kcml2ZXIoKQ0K
ICAgICAgZWZpOiBzdG1tOiBNYWtlIHVzZSBvZiB0ZWUgYnVzIG1ldGhvZHMNCiAgICAgIGZpcm13
YXJlOiBhcm1fc2NtaTogb3B0ZWU6IE1ha2UgdXNlIG9mIG1vZHVsZV90ZWVfY2xpZW50X2RyaXZl
cigpDQogICAgICBmaXJtd2FyZTogYXJtX3NjbWk6IE1ha2UgdXNlIG9mIHRlZSBidXMgbWV0aG9k
cw0KICAgICAgZmlybXdhcmU6IHRlZV9ibnh0OiBNYWtlIHVzZSBvZiBtb2R1bGVfdGVlX2NsaWVu
dF9kcml2ZXIoKQ0KICAgICAgZmlybXdhcmU6IHRlZV9ibnh0OiBNYWtlIHVzZSBvZiB0ZWUgYnVz
IG1ldGhvZHMNCiAgICAgIEtFWVM6IHRydXN0ZWQ6IE1pZ3JhdGUgdG8gdXNlIHRlZSBzcGVjaWZp
YyBkcml2ZXIgcmVnaXN0cmF0aW9uIGZ1bmN0aW9uDQogICAgICBLRVlTOiB0cnVzdGVkOiBNYWtl
IHVzZSBvZiB0ZWUgYnVzIG1ldGhvZHMNCiAgICAgIHRwbS90cG1fZnRwbV90ZWU6IE1ha2UgdXNl
IG9mIHRlZSBzcGVjaWZpYyBkcml2ZXIgcmVnaXN0cmF0aW9uDQogICAgICB0cG0vdHBtX2Z0cG1f
dGVlOiBNYWtlIHVzZSBvZiB0ZWUgYnVzIG1ldGhvZHMNCiAgICAgIHRwbS90cG1fZnRwbV90ZWU6
IEZpeCBrZG9jIGFmdGVyIGZ1bmN0aW9uIHJlbmFtZXMNCg0KIERvY3VtZW50YXRpb24vZHJpdmVy
LWFwaS90ZWUucnN0ICAgICAgICAgICAgIHwgMTggKy0tLS0tDQogZHJpdmVycy9jaGFyL2h3X3Jh
bmRvbS9vcHRlZS1ybmcuYyAgICAgICAgICAgfCAyNiArKy0tLS0tLS0NCiBkcml2ZXJzL2NoYXIv
dHBtL3RwbV9mdHBtX3RlZS5jICAgICAgICAgICAgICB8IDM1ICsrKysrKysrLS0tLQ0KIGRyaXZl
cnMvZmlybXdhcmUvYXJtX3NjbWkvdHJhbnNwb3J0cy9vcHRlZS5jIHwgMzIgKysrKy0tLS0tLS0N
CiBkcml2ZXJzL2Zpcm13YXJlL2Jyb2FkY29tL3RlZV9ibnh0X2Z3LmMgICAgICB8IDMwICsrKy0t
LS0tLS0NCiBkcml2ZXJzL2Zpcm13YXJlL2VmaS9zdG1tL3RlZV9zdG1tX2VmaS5jICAgICB8IDI1
ICsrLS0tLS0tLQ0KIGRyaXZlcnMvcnRjL3J0Yy1vcHRlZS5jICAgICAgICAgICAgICAgICAgICAg
IHwgMjcgKysrLS0tLS0tDQogZHJpdmVycy90ZWUvdGVlX2NvcmUuYyAgICAgICAgICAgICAgICAg
ICAgICAgfCA4NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9saW51eC90
ZWVfZHJ2LmggICAgICAgICAgICAgICAgICAgICAgfCAxMiArKysrDQogc2VjdXJpdHkva2V5cy90
cnVzdGVkLWtleXMvdHJ1c3RlZF90ZWUuYyAgICAgfCAxNyArKystLS0NCiAxMCBmaWxlcyBjaGFu
Z2VkLCAxNjYgaW5zZXJ0aW9ucygrKSwgMTQwIGRlbGV0aW9ucygtKQ0K
