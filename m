Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAF0D4417D
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:06:14 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AC5F0448F4
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:06:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Vi1cwW9H;
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9B42E5002F
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 17:16:13 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42e2e3c0dccso222548f8f.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 09:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473372; x=1766078172; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7slVLIofatSoTo54gYSEEiPQgSIuIVsTlq2fZY6I/RA=;
        b=Vi1cwW9HKVIESfx/dPerbDWtQmTTm0SYB2zAdTOJTSIfONRGTdrIBC4QZleJaCx7bS
         cRuv4lymcRpJtK14u87Stk00vwfuJuHoxFMyhiFGORhH09btp6/Kj56ngiAqXVAnYWv9
         5AAjoPqbqCrljpdjSA625QFvAQiUAUTqajx+KNRDFHtshU35JrwMBlzcuLSN8Q+MlEjz
         QGqtf74UARBoEAMAQZ53T75hhohtKh4f3/9MMrfWhfejrzdWWzevCL8oTIr/NNqjecQS
         1yMElwYoJT0bjd1D03HE+N1Q9xaPZp8JmPvSUzHr0ig9LfNNte8gVXesuVOzxMs+Jub6
         0HWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473373; x=1766078173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7slVLIofatSoTo54gYSEEiPQgSIuIVsTlq2fZY6I/RA=;
        b=vurB06a6ut6bLZBRWpLvlncmbWpRLHOHtiAQHWTHRM0Q0tB1VUTttqHssmspjY+RAQ
         Pk9d6jLZ6VmcUwmGHboKpAMDf+96lMJzRi70Yo8uiZBYQ6fa6qKsEW4n+puXgEn6mAzw
         A+lG11NGzaneX0hG4ddZcO+yyWe0VYvZBdHJ1Kf57r/Fx5HEPSiIl553134+F6KcjWCr
         K01j9n7WZfaG/rYIneBn/hCTEsu4MP+biVKt7eUi9JKfJYESAdVvI4DdtQROMT+yGlFq
         D3UjIf24LtE/IS112RC3CsUw6mch+hOI0+EiMBGkX29/q583ltq9nTWbWJwODxo7ofIa
         1hQw==
X-Forwarded-Encrypted: i=1; AJvYcCUEOITnQkGBdpK4OMBHQVufy64S2Fc1xsjM6nfKifHzyDHsk6DG8HDrvNIVHXEGSIofKbnZspE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzjD7lJxOCdhL8bNNkqtCV5a1WVkXt9JQPoESrA5xxgZomA9l2y
	9q56O6aAaGeUhQcHe6IUovt77UBiKx7rbo1bnw/GX05B0t8c5UKJw64OhVDs7NSHxx8=
X-Gm-Gg: AY/fxX6WScRzFSsZUIwxPKGm1EnL7N1LouN9Z2/TwWYJLP9WysDlhA2IjQxRF6utZZT
	LbanCI3rLRIDUKY3eyTrtQQsDQj+NCg/Wbaf5pNcB1fl2OP/uEFmQ4HC78fWc72cPNZljKzUa9x
	mBOgzB20vxoinQE/nxXj8AWydhdEApWQ4kUdlyouymPXgPaSNnvI6TEOR20ypE9qXTDY+UWxxmp
	xY9j4m5TwO93XeM3qQs1+PJ6Z5fP7mitOG9aUaVs9HgIVg/HoHmyzOzHcGQILKfIauaaj70ekmw
	7/AeSa1lD2zP7VrL9AvwxmydOnVeAByUXend/BwJG2Qif2WCk0DmqQEj81bPt2jae3ChQN13WJM
	wTk/am/a+Zq8SgrGSnI/nBLxIQlAZAWDjW9EAeX7zmV3ltm5oTVGqiRH+aKyQFgZA4ZJ5CJMD8j
	5g9VsbEQtMN78V6zFm42EPpFNEO1olOKNBbqR+zUdxAhC/2kLly3+ds3FdVnkWU51QwZmhxABTO
	G4=
X-Google-Smtp-Source: AGHT+IGJvbFZQsknQaRH6NGcKkb8LTeqvHIo6DvlNxlXfRNU3KD3pAM+iHJV5Xd8AsZ/8DUR/5v8wQ==
X-Received: by 2002:a05:6000:2489:b0:429:8bfe:d842 with SMTP id ffacd0b85a97d-42fa39cf06dmr7635910f8f.4.1765473372543;
        Thu, 11 Dec 2025 09:16:12 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42fa8b8a941sm6802514f8f.34.2025.12.11.09.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:16:12 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v1 17/17] tpm/tpm_ftpm_tee: Make use of tee bus methods
Date: Thu, 11 Dec 2025 18:15:11 +0100
Message-ID: <eaf8216e8a6c3dabce5a82be5765d67c66318791.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2542; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Svc6/wu5PiStY9NpUW3zypfWEAb+rgVj8zt7WVDcjFU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvxANVuZTA+Vs41/jfUCca0wp0pub3aHXza8N 0dKzZ+eSCOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8QAAKCRCPgPtYfRL+ Tj+NB/9VP2U8NFQ0NoJVMJc3zyFqZ1tv3cfVRRg/zerpzGxs0TU0wiMUcNVrwY/foFivXYxySWi sBBzEr3Nbh81+LLjnzbnBZWMmMlR/LDg1eZEKjt9oRRqblTq9vKa0v2Jw+zGSBVjfHWCWEroVcL Ah0WQompRwLVbSfLGUP50lh/teI82ay9QXe9Jr6R843myqJnsCWcPFMxUOQycE0aHwvXkmyVv5M +Uk45OlbqDsep5AzX+PLGbJu8QgBpdkwDf3qwzB881AWz3UvzneB0Aj7IqtjA3LqayVrwPiatzs uythHyB0xKp+f2PNjUzkiaZYKpKSSugZ3rVhqqVXLMZFQwez
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.46:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	BLOCKLISTDE_FAIL(0.00)[209.85.221.46:server fail];
	FREEMAIL_TO(0.00)[linaro.org,gmx.de,kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.221.46:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9B42E5002F
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: GZOZCB3QAZB7RBFUE3D2445D6BVDYJCN
X-Message-ID-Hash: GZOZCB3QAZB7RBFUE3D2445D6BVDYJCN
X-Mailman-Approved-At: Fri, 12 Dec 2025 10:57:13 +0000
CC: Jason Gunthorpe <jgg@ziepe.ca>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GZOZCB3QAZB7RBFUE3D2445D6BVDYJCN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

VGhlIHRlZSBidXMgZ290IGRlZGljYXRlZCBjYWxsYmFja3MgZm9yIHByb2JlIGFuZCByZW1vdmUu
DQpNYWtlIHVzZSBvZiB0aGVzZS4gVGhpcyBmaXhlcyBhIHJ1bnRpbWUgd2FybmluZyBhYm91dCB0
aGUgZHJpdmVyIG5lZWRpbmcNCnRvIGJlIGNvbnZlcnRlZCB0byB0aGUgYnVzIG1ldGhvZHMuDQoN
ClNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAYmF5bGli
cmUuY29tPg0KLS0tDQogZHJpdmVycy9jaGFyL3RwbS90cG1fZnRwbV90ZWUuYyB8IDI2ICsrKysr
KysrKysrKysrKysrKystLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyks
IDcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV9mdHBt
X3RlZS5jIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fZnRwbV90ZWUuYw0KaW5kZXggZTVmYmM3MGIw
ZWNhLi4yMDI5NGQxOTUzYTMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV9mdHBt
X3RlZS5jDQorKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV9mdHBtX3RlZS5jDQpAQCAtMTY5LDcg
KzE2OSw3IEBAIHN0YXRpYyBpbnQgZnRwbV90ZWVfbWF0Y2goc3RydWN0IHRlZV9pb2N0bF92ZXJz
aW9uX2RhdGEgKnZlciwgY29uc3Qgdm9pZCAqZGF0YSkNCiAgKiBSZXR1cm46DQogICoJT24gc3Vj
Y2VzcywgMC4gT24gZmFpbHVyZSwgLWVycm5vLg0KICAqLw0KLXN0YXRpYyBpbnQgZnRwbV90ZWVf
cHJvYmUoc3RydWN0IGRldmljZSAqZGV2KQ0KK3N0YXRpYyBpbnQgZnRwbV90ZWVfcHJvYmVfZ2Vu
ZXJpYyhzdHJ1Y3QgZGV2aWNlICpkZXYpDQogew0KIAlpbnQgcmM7DQogCXN0cnVjdCB0cG1fY2hp
cCAqY2hpcDsNCkBAIC0yNTEsMTEgKzI1MSwxOCBAQCBzdGF0aWMgaW50IGZ0cG1fdGVlX3Byb2Jl
KHN0cnVjdCBkZXZpY2UgKmRldikNCiAJcmV0dXJuIHJjOw0KIH0NCiANCitzdGF0aWMgaW50IGZ0
cG1fdGVlX3Byb2JlKHN0cnVjdCB0ZWVfY2xpZW50X2RldmljZSAqdGNkZXYpDQorew0KKwlzdHJ1
Y3QgZGV2aWNlICpkZXYgPSAmdGNkZXYtPmRldjsNCisNCisJcmV0dXJuIGZ0cG1fdGVlX3Byb2Jl
X2dlbmVyaWMoZGV2KTsNCit9DQorDQogc3RhdGljIGludCBmdHBtX3BsYXRfdGVlX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogew0KIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAm
cGRldi0+ZGV2Ow0KIA0KLQlyZXR1cm4gZnRwbV90ZWVfcHJvYmUoZGV2KTsNCisJcmV0dXJuIGZ0
cG1fdGVlX3Byb2JlX2dlbmVyaWMoZGV2KTsNCiB9DQogDQogLyoqDQpAQCAtMjY1LDcgKzI3Miw3
IEBAIHN0YXRpYyBpbnQgZnRwbV9wbGF0X3RlZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KICAqIFJldHVybjoNCiAgKgkwIGFsd2F5cy4NCiAgKi8NCi1zdGF0aWMgaW50IGZ0
cG1fdGVlX3JlbW92ZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQorc3RhdGljIHZvaWQgZnRwbV90ZWVf
cmVtb3ZlX2dlbmVyaWMoc3RydWN0IGRldmljZSAqZGV2KQ0KIHsNCiAJc3RydWN0IGZ0cG1fdGVl
X3ByaXZhdGUgKnB2dF9kYXRhID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQogDQpAQCAtMjg1LDE1
ICsyOTIsMjAgQEAgc3RhdGljIGludCBmdHBtX3RlZV9yZW1vdmUoc3RydWN0IGRldmljZSAqZGV2
KQ0KIAl0ZWVfY2xpZW50X2Nsb3NlX2NvbnRleHQocHZ0X2RhdGEtPmN0eCk7DQogDQogCS8qIG1l
bW9yeSBhbGxvY2F0ZWQgd2l0aCBkZXZtX2t6YWxsb2MoKSBpcyBmcmVlZCBhdXRvbWF0aWNhbGx5
ICovDQorfQ0KIA0KLQlyZXR1cm4gMDsNCitzdGF0aWMgdm9pZCBmdHBtX3RlZV9yZW1vdmUoc3Ry
dWN0IHRlZV9jbGllbnRfZGV2aWNlICp0Y2RldikNCit7DQorCXN0cnVjdCBkZXZpY2UgKmRldiA9
ICZ0Y2Rldi0+ZGV2Ow0KKw0KKwlmdHBtX3RlZV9yZW1vdmVfZ2VuZXJpYyhkZXYpOw0KIH0NCiAN
CiBzdGF0aWMgdm9pZCBmdHBtX3BsYXRfdGVlX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KIHsNCiAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCiANCi0JZnRw
bV90ZWVfcmVtb3ZlKGRldik7DQorCWZ0cG1fdGVlX3JlbW92ZV9nZW5lcmljKGRldik7DQogfQ0K
IA0KIC8qKg0KQEAgLTMzNSwxMSArMzQ3LDExIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGVlX2Ns
aWVudF9kZXZpY2VfaWQgb3B0ZWVfZnRwbV9pZF90YWJsZVtdID0gew0KIE1PRFVMRV9ERVZJQ0Vf
VEFCTEUodGVlLCBvcHRlZV9mdHBtX2lkX3RhYmxlKTsNCiANCiBzdGF0aWMgc3RydWN0IHRlZV9j
bGllbnRfZHJpdmVyIGZ0cG1fdGVlX2RyaXZlciA9IHsNCisJLnByb2JlCQk9IGZ0cG1fdGVlX3By
b2JlLA0KKwkucmVtb3ZlCQk9IGZ0cG1fdGVlX3JlbW92ZSwNCiAJLmlkX3RhYmxlCT0gb3B0ZWVf
ZnRwbV9pZF90YWJsZSwNCiAJLmRyaXZlcgkJPSB7DQogCQkubmFtZQkJPSAib3B0ZWUtZnRwbSIs
DQotCQkucHJvYmUJCT0gZnRwbV90ZWVfcHJvYmUsDQotCQkucmVtb3ZlCQk9IGZ0cG1fdGVlX3Jl
bW92ZSwNCiAJfSwNCiB9Ow0KIA0KLS0gDQoyLjQ3LjMNCg0K
