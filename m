Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B14D5B16E
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:27:18 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BF49045294
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:27:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=zSiXwK8+;
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 540814FE8C
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 14:18:00 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b73161849e1so789523266b.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 06:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808279; x=1766413079; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+EJpP28ACswVH+s22Escdl3RH0kKfptytDh+TM4ml8=;
        b=zSiXwK8+uAnaSExw35TVF+6+mkeFAisrWfmKt2jubD+Q1CTcD7nwdF8awfSaQtkDc3
         Xdb+JOe/drv6/cm5Mbigl0Bq8c6FCXWLRGGNdp2iXHp/x0Z8OfOfgfsaTXlvRWnW2d0L
         Buvt8x+dZPQpT5EO1v1RfsI9vgFbnlEQ8XSLinSABcKXEIkV5SOxx8zNdE19uWqtLQU7
         Ur0TFV0TqKmqju3xL5zV+dVASoF0fbmwHVuzZyEQvU84Ndvg36gv6NxNI0es81FJfPUi
         wNoe2rsEfXDFoTENLc6yo7AbmZ7naUbLkL6fa+3g8Nd0BGu5ajT1xpF7YsFLyMSodhFS
         BY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808279; x=1766413079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+EJpP28ACswVH+s22Escdl3RH0kKfptytDh+TM4ml8=;
        b=IFPXZDQe+K6VDNKkRtn0jku9HI+wA2g+gRvg3ctoZ3aF8On4nbXWw2XBRxbp+q8wt0
         ydSCXuJgzBny+5pQPWsaoSRN198gclA50IFywrBhtQyEyQj4zhNS9qF4Kx0XHFfCHR6I
         PA+JyrKuJcdO63KxC/hkCYFhUtZm1n8vQr/uvDy51e0eGJZd/cWdH1RhUgGlPQ6NTc28
         65k2f9/jWH1ix4r/fmVwyB1DBtdQ+S9NKy/aYijCFkxuLhXAcC5p6IqE6yfTh4Xary/O
         twfO/ZFZbd0RKMZMCqFxByRPsZsI+PYiR2cbRC8tyftPkzk8b+ZXAeez2mXnmnM+h8QJ
         dAsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBjBAEQti1mD6I+74SEF9yWe+pufWSwkU2cIYJmsGF+wKTbGNns5htnY2UyBbJHoSOghhoYQk=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzuLiW1x+74EwxSo5QK2rE1YqRJIFR86OppqQDnmT6wT/LbhA2P
	cP9D4uvrs3S131VIPBTKJm15GtRhEKmmRtdDFhyOLf6Auryzx+kehYmM/RvtuFP7dZ0=
X-Gm-Gg: AY/fxX7oHQGT5RakhcYhyr9nqsuS0CZhlIb0QH5R3BIlZICgMBP7D0FEt4JlFu11y7x
	8P5P/BY93B5xLfi/ShRpDdd4ku7fMY1K2qlmCUuAl4cMslJIN20QsscrXmclmkRP+Hx5V7/NZML
	1OI7AaGqrAiUH2XWmdh9dRzUzMVBru6saMlFCXRGf5tlGUyOhBxrswx6TlBDKNXQpqzXz9CjBvX
	UB0c0o7iqi/B3jdJDFwa08cSMTgi7ZCWNS1075+/rVjkTr2ETK1o0kFrzr6pWFGhDl3vBP4Fmtu
	WUTi2pipwzgQgXpQEw+qx1TD9H+8E2AsCQYHP3vyfSht+ZDbNvjGDKLpN7jrq1kMjZrAe417Rov
	7ybNQT+eQ6Hu0Fyp4T924mJg2v5GHNVPs61KLaowbbUnPDGZ5Warm5ysLvXToG3dIYank8iqZdU
	/al/ExvRtQooiwWxY4M2VzxgK7NTFL2deu6fk+9oqLviF9YO0S+N520gK37Q==
X-Google-Smtp-Source: AGHT+IEK116a+hzlpDVrTZCFE6XuiyE4/HJN0uW0RxfmRWXh+Z7K4wAXn5iM/HwRNMkehyWwuERbtA==
X-Received: by 2002:a17:907:944a:b0:b7c:f5b6:bb52 with SMTP id a640c23a62f3a-b7d23a22c68mr1176743866b.43.1765808279239;
        Mon, 15 Dec 2025 06:17:59 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa29e060sm1447274266b.2.2025.12.15.06.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:58 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH v2 14/17] KEYS: trusted: Migrate to use tee specific driver registration function
Date: Mon, 15 Dec 2025 15:16:44 +0100
Message-ID: <687c004c32718ba7044ffa9165f33842267a745d.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1462; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Zg7mCOEZ4Z6I10BCWu77BY4uJ1KchHXm6/KivSfImCk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhuRfKfm9AOVl8Q/VvcEeDtJDpwUt6Lmf7cq XA9w6mZtvWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYbgAKCRCPgPtYfRL+ TsZpCACirKqeCOo4fBLSL2yhYE15pWpKfHROUGgAZZeKbVTJC+rvy2kfsHLSn29V5iUFd6n/aBB RLMpQStbyHgc70HfHAyCuTdZObAa7h3bTSPGnjOjmLZigHIKG8/6g3+CqxBL8pTOH97z5DxZWNX VvkFx7JbUtReVr6BFh73Afq+MQ+f5TAL8pAFAgaE/nIFZCpM/LtSoIbp2blmkVrNpNEeNa0PYfd RA5nfTVhDCElUIctzgjpURVdvtEdKi8neQAbH6MIaiIU0cei0mA1FAKf6PQmApjRoegk+gVMHbu EBwmm55AFygfkyiAxcXwwxwcne/wKbaG9kvdFW74ByDZmhIM
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.218.48:from];
	RCVD_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[baylibre.com];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[46.5.122.62:received];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.48:from];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 540814FE8C
X-Spamd-Bar: /
Message-ID-Hash: RN4S77CYUKEE2TCLBSN5U4AZA2M4FK47
X-Message-ID-Hash: RN4S77CYUKEE2TCLBSN5U4AZA2M4FK47
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RN4S77CYUKEE2TCLBSN5U4AZA2M4FK47/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

VGhlIHRlZSBzdWJzeXN0ZW0gcmVjZW50bHkgZ290IGEgc2V0IG9mIGRlZGljYXRlZCBmdW5jdGlv
bnMgdG8gcmVnaXN0ZXINCihhbmQgdW5yZWdpc3RlcikgYSB0ZWUgZHJpdmVyLiBNYWtlIHVzZSBv
ZiB0aGVtLiBUaGVzZSBjYXJlIGZvciBzZXR0aW5nIHRoZQ0KZHJpdmVyJ3MgYnVzIChzbyB0aGUg
ZXhwbGljaXQgYXNzaWdubWVudCBjYW4gYmUgZHJvcHBlZCkgYW5kIHRoZSBkcml2ZXINCm93bmVy
ICh3aGljaCBpcyBhbiBpbXByb3ZlbWVudCB0aGlzIGRyaXZlciBiZW5lZml0cyBmcm9tKS4NCg0K
UmV2aWV3ZWQtYnk6IFN1bWl0IEdhcmcgPHN1bWl0LmdhcmdAb3NzLnF1YWxjb21tLmNvbT4NClNp
Z25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAYmF5bGlicmUu
Y29tPg0KLS0tDQogc2VjdXJpdHkva2V5cy90cnVzdGVkLWtleXMvdHJ1c3RlZF90ZWUuYyB8IDUg
KystLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvc2VjdXJpdHkva2V5cy90cnVzdGVkLWtleXMvdHJ1c3RlZF90ZWUuYyBi
L3NlY3VyaXR5L2tleXMvdHJ1c3RlZC1rZXlzL3RydXN0ZWRfdGVlLmMNCmluZGV4IGFhM2Q0Nzdk
ZTZkYi4uM2NlYTlhMzc3OTU1IDEwMDY0NA0KLS0tIGEvc2VjdXJpdHkva2V5cy90cnVzdGVkLWtl
eXMvdHJ1c3RlZF90ZWUuYw0KKysrIGIvc2VjdXJpdHkva2V5cy90cnVzdGVkLWtleXMvdHJ1c3Rl
ZF90ZWUuYw0KQEAgLTI2NCw3ICsyNjQsNiBAQCBzdGF0aWMgc3RydWN0IHRlZV9jbGllbnRfZHJp
dmVyIHRydXN0ZWRfa2V5X2RyaXZlciA9IHsNCiAJLmlkX3RhYmxlCT0gdHJ1c3RlZF9rZXlfaWRf
dGFibGUsDQogCS5kcml2ZXIJCT0gew0KIAkJLm5hbWUJCT0gRFJJVkVSX05BTUUsDQotCQkuYnVz
CQk9ICZ0ZWVfYnVzX3R5cGUsDQogCQkucHJvYmUJCT0gdHJ1c3RlZF9rZXlfcHJvYmUsDQogCQku
cmVtb3ZlCQk9IHRydXN0ZWRfa2V5X3JlbW92ZSwNCiAJfSwNCkBAIC0yNzIsMTIgKzI3MSwxMiBA
QCBzdGF0aWMgc3RydWN0IHRlZV9jbGllbnRfZHJpdmVyIHRydXN0ZWRfa2V5X2RyaXZlciA9IHsN
CiANCiBzdGF0aWMgaW50IHRydXN0ZWRfdGVlX2luaXQodm9pZCkNCiB7DQotCXJldHVybiBkcml2
ZXJfcmVnaXN0ZXIoJnRydXN0ZWRfa2V5X2RyaXZlci5kcml2ZXIpOw0KKwlyZXR1cm4gdGVlX2Ns
aWVudF9kcml2ZXJfcmVnaXN0ZXIoJnRydXN0ZWRfa2V5X2RyaXZlcik7DQogfQ0KIA0KIHN0YXRp
YyB2b2lkIHRydXN0ZWRfdGVlX2V4aXQodm9pZCkNCiB7DQotCWRyaXZlcl91bnJlZ2lzdGVyKCZ0
cnVzdGVkX2tleV9kcml2ZXIuZHJpdmVyKTsNCisJdGVlX2NsaWVudF9kcml2ZXJfdW5yZWdpc3Rl
cigmdHJ1c3RlZF9rZXlfZHJpdmVyKTsNCiB9DQogDQogc3RydWN0IHRydXN0ZWRfa2V5X29wcyB0
cnVzdGVkX2tleV90ZWVfb3BzID0gew0KLS0gDQoyLjQ3LjMNCg0K
