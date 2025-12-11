Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC150D44166
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 10:59:54 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 33F6D43154
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 10:59:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=rid6Cmp/;
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3DF5C431FB
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 17:16:00 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42e2e445dbbso191583f8f.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 09:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473359; x=1766078159; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4l2h6ylecBmmb2NFGzo9KVhF/u4WxGR1OPEqHGghSQ=;
        b=rid6Cmp/YD9tBZHye2BoUIEHYgsqobxUKJrEZoZWC4cKUdAcKuPF05B3OLXBHLt6EH
         n5s930+PHuvHGNUPKoDuOzFOEcZi5HCMwdJDALEJIHC7vDrBJaogQopQ1lQ7agZkhMSa
         zBPuGKnD4T083ncb0iGDj+frqPtNnxvAud2YwrCKb6A2PBfIQrmut0VVJcuQnjnb6w/G
         nfkv7UeogDqO9fYNTEaWs8Qr9tzzt72BWUXGc18qmMKGErH6p6BWPu+0GdXFuMlDl8R+
         Ck1GeI8sMswu7NqsGyBTTLlOlryK6TpZHGj/f2O9wkccbfX5Czl+L1Dy+AI6iuY1rUzV
         T0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473359; x=1766078159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I4l2h6ylecBmmb2NFGzo9KVhF/u4WxGR1OPEqHGghSQ=;
        b=QYV2yWwS0El8JAvde1/bmAOSWQ3FGDy+qAtNqa4qZZj+TZD0Qqem9HsXUqP15JQMbq
         helSDg0PkmBQM1Q/wiDML6sGRXXz1K0OTmjOzOMkoy870LbMLodjirvvjp6aTwXuDuJz
         w6UieBjh7u4GrPgn6VtJjm+KvwB762HtKB7MqbM8hM+ToD38z2CfF5Hru1GfWH64oHii
         YdFGPsKMDgwtLdHBCRY9c1Zos6Y0nk4PR/wDIryhqo9+G/azI1I01IevuzDW5Y8Eb91l
         gaXNJk8Q6NXHILgaizpVzsxIFAF479LU9dKD1jvRwDNwARGnQXBu1W49QshrubZ/nhFK
         tvWg==
X-Gm-Message-State: AOJu0YxA6NF5QNZlObfdAFDlqAEGDME1A8X401WcVXqikaQis8NBIV23
	eJCahu0jyxnfwWn8KxZcx/PFkG2unL6jtnZ3OIH2H4o/WU4RUxlWlrTvc9JgBLUPDpQ=
X-Gm-Gg: AY/fxX4ni3uvVdb+Z+os5yIM0jg6dIjmn96FZAHeATqW/PnIYSE2F8R6z+8aEs+MiE4
	f9gxCncafyOrX3To3DQtc6Ct24ZrRz+1si48jwqtx8YIUMg38ay9yO3FxoUUgtnHn3lv1Y+UCJ1
	phd0U4zL1cMpFJ5vlyRO+g4cVXfFvowkCrQVOJHIveSGaWeZVJVeCKgqBYJTyb3PzPF+uS+MdS5
	7qQJwwCjt54PLVuhy0193e9eSJHMX8hoAY0viDQbKyGYAF3PhoJcKeNUYdXkAa6ib/ECEK9Yt3R
	R8QMGjlqwsLHiwabMAYB2Qt1VUEYNL3vs1CU3S0vFkrzZAvh/NCbZE3RegtpLyKgnJMMinit8Wo
	GmXhqP0WaiVWM9VF21vRWiun6IWDK2AnutnNb+QYZgVevSDM/ICySqz+nVUp42T6Z7AuGqrp5rT
	WwRq0qAYOEWQtcAyAnzKuG7IL9JQyZhQzoqz+jXxJ75hj8ddzWwSFgiQakstsXQgSq9yy6eGnHa
	2c=
X-Google-Smtp-Source: AGHT+IHznnkl74xT2z8JC40wM/v7wIF0q/FLhgvdfq6Hs39to3yRCTNdr19bDlPbZFNrY6LaQx6MyQ==
X-Received: by 2002:a05:6000:4308:b0:42b:2c53:3aa8 with SMTP id ffacd0b85a97d-42fa3af8df1mr6951355f8f.37.1765473359065;
        Thu, 11 Dec 2025 09:15:59 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42fa8a702a1sm7588863f8f.13.2025.12.11.09.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:15:58 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH v1 05/17] hwrng: optee - Make use of tee bus methods
Date: Thu, 11 Dec 2025 18:14:59 +0100
Message-ID: <83301effbb923117122f5f076edbfdad1f947386.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=9/MWuHZltbfrljfghNMjsFGbpJYDdAIf/qKdNwaHWyQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvwglYVLSe7x2hJUzJuiko+CB65bc9zowSFvy IrqbvBxWmWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8IAAKCRCPgPtYfRL+ TjUkB/0RRiOrgJTBYNMrNgeZXzR7aDDF6ecj9C1B+6tXZ7EDmvu8w1XfWPampNGADTlFFns02Y2 LcJ0fjr5W8rEgvvRvmeDkmqIlZDW1J7Z9k0ShbGUoFVmleBaweG7398LO15X4tX3jJcOBzM94+f CfiOZAwcVz/lm2J3pH1msmxQJRWnmsB4T2q1dcBBMcwK+fH38MUrcB9sQ0VujUDfH4GGttfGC0B tIGIcWaG0JZeEBzxS3WiBsIiiZBFQeYyMtV5HaGpas8QjbvkfSJlACbwShtObNGb5zbOpskW+qR rZZE6YursT3IFX7j7pUMcFZthadnRzFHjaS0aAf/8pw+LVJe
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.47:from];
	DMARC_NA(0.00)[baylibre.com];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.47:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	BLOCKLISTDE_FAIL(0.00)[2003:f6:5f00:6608:b665:17f2:bd01:7279:query timed out,209.85.221.47:query timed out];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3DF5C431FB
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 6P24A62TBS4T7N5JKVMWBJAIQUMQH6ZK
X-Message-ID-Hash: 6P24A62TBS4T7N5JKVMWBJAIQUMQH6ZK
X-Mailman-Approved-At: Fri, 12 Dec 2025 10:56:47 +0000
CC: op-tee@lists.trustedfirmware.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6P24A62TBS4T7N5JKVMWBJAIQUMQH6ZK/>
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
cmUuY29tPg0KLS0tDQogZHJpdmVycy9jaGFyL2h3X3JhbmRvbS9vcHRlZS1ybmcuYyB8IDEyICsr
KysrLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvaHdfcmFuZG9tL29wdGVlLXJuZy5jIGIv
ZHJpdmVycy9jaGFyL2h3X3JhbmRvbS9vcHRlZS1ybmcuYw0KaW5kZXggNmVlNzQ4YzBjZjU3Li41
YTNmYTBiMzg0OTcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2NoYXIvaHdfcmFuZG9tL29wdGVlLXJu
Zy5jDQorKysgYi9kcml2ZXJzL2NoYXIvaHdfcmFuZG9tL29wdGVlLXJuZy5jDQpAQCAtMjExLDkg
KzIxMSw5IEBAIHN0YXRpYyBpbnQgb3B0ZWVfY3R4X21hdGNoKHN0cnVjdCB0ZWVfaW9jdGxfdmVy
c2lvbl9kYXRhICp2ZXIsIGNvbnN0IHZvaWQgKmRhdGEpDQogCQlyZXR1cm4gMDsNCiB9DQogDQot
c3RhdGljIGludCBvcHRlZV9ybmdfcHJvYmUoc3RydWN0IGRldmljZSAqZGV2KQ0KK3N0YXRpYyBp
bnQgb3B0ZWVfcm5nX3Byb2JlKHN0cnVjdCB0ZWVfY2xpZW50X2RldmljZSAqcm5nX2RldmljZSkN
CiB7DQotCXN0cnVjdCB0ZWVfY2xpZW50X2RldmljZSAqcm5nX2RldmljZSA9IHRvX3RlZV9jbGll
bnRfZGV2aWNlKGRldik7DQorCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZybmdfZGV2aWNlLT5kZXY7
DQogCWludCByZXQgPSAwLCBlcnIgPSAtRU5PREVWOw0KIAlzdHJ1Y3QgdGVlX2lvY3RsX29wZW5f
c2Vzc2lvbl9hcmcgc2Vzc19hcmc7DQogDQpAQCAtMjYxLDEyICsyNjEsMTAgQEAgc3RhdGljIGlu
dCBvcHRlZV9ybmdfcHJvYmUoc3RydWN0IGRldmljZSAqZGV2KQ0KIAlyZXR1cm4gZXJyOw0KIH0N
CiANCi1zdGF0aWMgaW50IG9wdGVlX3JuZ19yZW1vdmUoc3RydWN0IGRldmljZSAqZGV2KQ0KK3N0
YXRpYyB2b2lkIG9wdGVlX3JuZ19yZW1vdmUoc3RydWN0IHRlZV9jbGllbnRfZGV2aWNlICp0ZWVf
ZGV2KQ0KIHsNCiAJdGVlX2NsaWVudF9jbG9zZV9zZXNzaW9uKHB2dF9kYXRhLmN0eCwgcHZ0X2Rh
dGEuc2Vzc2lvbl9pZCk7DQogCXRlZV9jbGllbnRfY2xvc2VfY29udGV4dChwdnRfZGF0YS5jdHgp
Ow0KLQ0KLQlyZXR1cm4gMDsNCiB9DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCB0ZWVfY2xpZW50
X2RldmljZV9pZCBvcHRlZV9ybmdfaWRfdGFibGVbXSA9IHsNCkBAIC0yNzgsMTEgKzI3NiwxMSBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IHRlZV9jbGllbnRfZGV2aWNlX2lkIG9wdGVlX3JuZ19pZF90
YWJsZVtdID0gew0KIE1PRFVMRV9ERVZJQ0VfVEFCTEUodGVlLCBvcHRlZV9ybmdfaWRfdGFibGUp
Ow0KIA0KIHN0YXRpYyBzdHJ1Y3QgdGVlX2NsaWVudF9kcml2ZXIgb3B0ZWVfcm5nX2RyaXZlciA9
IHsNCisJLnByb2JlCQk9IG9wdGVlX3JuZ19wcm9iZSwNCisJLnJlbW92ZQkJPSBvcHRlZV9ybmdf
cmVtb3ZlLA0KIAkuaWRfdGFibGUJPSBvcHRlZV9ybmdfaWRfdGFibGUsDQogCS5kcml2ZXIJCT0g
ew0KIAkJLm5hbWUJCT0gRFJJVkVSX05BTUUsDQotCQkucHJvYmUJCT0gb3B0ZWVfcm5nX3Byb2Jl
LA0KLQkJLnJlbW92ZQkJPSBvcHRlZV9ybmdfcmVtb3ZlLA0KIAl9LA0KIH07DQogDQotLSANCjIu
NDcuMw0KDQo=
