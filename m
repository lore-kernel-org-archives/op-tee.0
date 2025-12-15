Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF759D5B16C
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:29:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2E4274FE0E
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:29:11 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ZwB4Sd6w;
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0D2AB4FF15
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 14:18:06 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b727f452fffso540290366b.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 06:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808285; x=1766413085; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yBB10wIDhntVhF7Adi7eu+afyFDfQDzYe1DB3rR/Q0=;
        b=ZwB4Sd6wr5cMQignNLmHj7WByS7RTU6ye8E2oPAYld2Dqrr9V2v1+/cU38C77uaQi8
         0gljvkJAmj4DZ/VnIzNV9aR5R/VAj3yE+hNt4B51BBKdhHbdXrW7xlkAEgOeWcPhS9SK
         HpIbzuDFbnLY+URqSHu//NeRsy5ixBl5qdAyMdZlHvWutsQlUsIaghLQbFRv8qwQqn6a
         DOOdPOBoy1aUdhTpH7ZaQ28saxlk8dWC6cY80SYUlQH1Dpfkh6KscLrzxjfqg+HVNxvL
         bsUcP4I8667+Y7X5RotGpQPQ5+sHyBxf8f/ZewkYMEQ6uTpjhYsO8/JqcaPdGZXumw2E
         sbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808285; x=1766413085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2yBB10wIDhntVhF7Adi7eu+afyFDfQDzYe1DB3rR/Q0=;
        b=gG72bIVAbpqIrZzi7ACY09UtsYEg44MgFslTiweVCFJCiyq/E2G3URxfgD/voqRj3k
         L03Cgp5ygvobDvPvCET+X7PmjzjrXW8Hebi3xlfPSAfSK9PKZxb8QoeOliiQcRUzVifA
         LKVzivkhP+TMoGXY+KZTibI4183mLeT3IfLNCGNZP5OP3wYoqKfFEWUNY7Cl3c1A4Wt1
         CQ7f1KhCwfM2TLjW9eVzmt2vfpcJJdF8aArvM9dbVxGJDYe0zWrSeXaoF6u8oDmktHeK
         JahGWIQDdmZabsU6OiEhTdnXBkM8z9g6/MfinjZy1i7gklDpDZFHFV6xHbailx5/GmoL
         FINA==
X-Forwarded-Encrypted: i=1; AJvYcCWazMwGgTb7KeeN7EATT2cfKuSHznwN2r60JC+XBUuvz/RXHOUKCH1VO3Bjd2NCqFT6HvJIMOA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx/IyYstIfLdkDbQQgCE7liSuk7HUIaxoTRyK5ikomk9F9UGXaQ
	I3G85OJejwRpW2n0YTLTeew9wZWKjTXSmiBa2c0/xUSQKa9hfRfloH+cYaEIV1r9p+w=
X-Gm-Gg: AY/fxX49LZ4jOR7f9PnCUfzIbW9LcZoMLzXe9KOYghAdj2YhzS6oasV7jYAYSfviiaL
	IGB9T1zdck8nh4hxKgScXLIIjx7tP8Pbl2xO07OfwGHkdGRKUnAdvt4uzlWyh12MZe8v3P8RAq/
	H9tYa/kKYET/tKPQaDBGkzg/MsG6z4zoO5wUZ9uql0fhULo1uIplJs5W/h4hvyVBhqnJ2T8mgYq
	uGOjvaNbhaZdn5UjAs/pyI5VHH1UEGMDfFq5TTqTNOAkiO3oVCW0hnPyqoO0NFOF7xDj5ktWdW7
	AOF7hp0YeP4If4OT/Vr9EO2TECjxnKl+KuIUyVU7xESOtbeEyRovF+L/md6tuEn88TCpjnPWW1i
	3eba6FRDYFBYE6Dc7Qbyskg72gtMBpMyM7Zi+uZ2BOuYzhRWMjZctIX7ffO6aDZ5Sz39BgYF50g
	X3nsEFggT5eiUhiVem2WXQD19aN2e6P16zMM8OrK+zq7u1BFCbKbaN+zAxPA==
X-Google-Smtp-Source: AGHT+IFo9FOJaDLcFkLTxYDl5ZKYhlEDF+L2OGvBOrKgVtsuxe0NnsUtGKir1wRggxQLMFuuLtm7wg==
X-Received: by 2002:a17:907:d17:b0:b72:6a39:49e6 with SMTP id a640c23a62f3a-b7d217ed7b0mr1542327266b.18.1765808284912;
        Mon, 15 Dec 2025 06:18:04 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa5191fasm1381389266b.33.2025.12.15.06.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:18:04 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v2 17/17] tpm/tpm_ftpm_tee: Make use of tee bus methods
Date: Mon, 15 Dec 2025 15:16:47 +0100
Message-ID: <7bb98eeb8a478ca69344499f2e58016bbf787313.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2647; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=2qrjsylMFa+SF9mw2N00GCNY0QrYs1HpZggQBT0ZSoQ=; b=owGbwMvMwMXY3/A7olbonx/jabUkhkwHidK6wz4Hj+uVpPCJP5L6dz43PaivJl/576HsdzNjg k+37LfqZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAiV9vY/3CuuRiqe+tigNLE zW45WUxXPM81bz1gJrHHjzPDZK1B5bmtKv0qDikNS332dTGsMM//cnzPnpCOHQ7b4s7nH6mRmNy h2Mr/K351jGpfltHDY9ILs3wuRTxbu+Ii42WVR1GT2ty3suyNDFdYEn0110V2pcbl/dKPN87dqd tVumRqJ1e5zFVJJyuxd7a/HVIFc3OEoyM+20c+1czzlzAT0W24NKnw5VERz6W8h1/u7+zpUwk4I 2Adqs7xJPfTFi+zWTVPpngmFjzIfuiumqiWvGEeo8SL9W9dCiPecLhITH/aEhMUOelChlO7fWOt mVtRUWyZW5roy12OJz7cMP9TLG3FZ6Uj0jzlQpXK+psA
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.42:from];
	FREEMAIL_TO(0.00)[linaro.org,gmx.de,kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	DMARC_NA(0.00)[baylibre.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[46.5.122.62:received,209.85.218.42:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0D2AB4FF15
X-Spamd-Bar: --
Message-ID-Hash: KVL4I5JF2YGGPGWCF5CHCDFGROXMHYQK
X-Message-ID-Hash: KVL4I5JF2YGGPGWCF5CHCDFGROXMHYQK
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jason Gunthorpe <jgg@ziepe.ca>, Sumit Garg <sumit.garg@kernel.org>, linux-integrity@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KVL4I5JF2YGGPGWCF5CHCDFGROXMHYQK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

VGhlIHRlZSBidXMgZ290IGRlZGljYXRlZCBjYWxsYmFja3MgZm9yIHByb2JlIGFuZCByZW1vdmUu
DQpNYWtlIHVzZSBvZiB0aGVzZS4gVGhpcyBmaXhlcyBhIHJ1bnRpbWUgd2FybmluZyBhYm91dCB0
aGUgZHJpdmVyIG5lZWRpbmcNCnRvIGJlIGNvbnZlcnRlZCB0byB0aGUgYnVzIG1ldGhvZHMuDQoN
ClJldmlld2VkLWJ5OiBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQG9zcy5xdWFsY29tbS5jb20+DQpS
ZXZpZXdlZC1ieTogSmFya2tvIFNha2tpbmVuIDxqYXJra29Aa2VybmVsLm9yZz4NClNpZ25lZC1v
ZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAYmF5bGlicmUuY29tPg0K
LS0tDQogZHJpdmVycy9jaGFyL3RwbS90cG1fZnRwbV90ZWUuYyB8IDI2ICsrKysrKysrKysrKysr
KysrKystLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDcgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV9mdHBtX3RlZS5jIGIv
ZHJpdmVycy9jaGFyL3RwbS90cG1fZnRwbV90ZWUuYw0KaW5kZXggZTVmYmM3MGIwZWNhLi4yMDI5
NGQxOTUzYTMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV9mdHBtX3RlZS5jDQor
KysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV9mdHBtX3RlZS5jDQpAQCAtMTY5LDcgKzE2OSw3IEBA
IHN0YXRpYyBpbnQgZnRwbV90ZWVfbWF0Y2goc3RydWN0IHRlZV9pb2N0bF92ZXJzaW9uX2RhdGEg
KnZlciwgY29uc3Qgdm9pZCAqZGF0YSkNCiAgKiBSZXR1cm46DQogICoJT24gc3VjY2VzcywgMC4g
T24gZmFpbHVyZSwgLWVycm5vLg0KICAqLw0KLXN0YXRpYyBpbnQgZnRwbV90ZWVfcHJvYmUoc3Ry
dWN0IGRldmljZSAqZGV2KQ0KK3N0YXRpYyBpbnQgZnRwbV90ZWVfcHJvYmVfZ2VuZXJpYyhzdHJ1
Y3QgZGV2aWNlICpkZXYpDQogew0KIAlpbnQgcmM7DQogCXN0cnVjdCB0cG1fY2hpcCAqY2hpcDsN
CkBAIC0yNTEsMTEgKzI1MSwxOCBAQCBzdGF0aWMgaW50IGZ0cG1fdGVlX3Byb2JlKHN0cnVjdCBk
ZXZpY2UgKmRldikNCiAJcmV0dXJuIHJjOw0KIH0NCiANCitzdGF0aWMgaW50IGZ0cG1fdGVlX3By
b2JlKHN0cnVjdCB0ZWVfY2xpZW50X2RldmljZSAqdGNkZXYpDQorew0KKwlzdHJ1Y3QgZGV2aWNl
ICpkZXYgPSAmdGNkZXYtPmRldjsNCisNCisJcmV0dXJuIGZ0cG1fdGVlX3Byb2JlX2dlbmVyaWMo
ZGV2KTsNCit9DQorDQogc3RhdGljIGludCBmdHBtX3BsYXRfdGVlX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQogew0KIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2
Ow0KIA0KLQlyZXR1cm4gZnRwbV90ZWVfcHJvYmUoZGV2KTsNCisJcmV0dXJuIGZ0cG1fdGVlX3By
b2JlX2dlbmVyaWMoZGV2KTsNCiB9DQogDQogLyoqDQpAQCAtMjY1LDcgKzI3Miw3IEBAIHN0YXRp
YyBpbnQgZnRwbV9wbGF0X3RlZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
ICAqIFJldHVybjoNCiAgKgkwIGFsd2F5cy4NCiAgKi8NCi1zdGF0aWMgaW50IGZ0cG1fdGVlX3Jl
bW92ZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQorc3RhdGljIHZvaWQgZnRwbV90ZWVfcmVtb3ZlX2dl
bmVyaWMoc3RydWN0IGRldmljZSAqZGV2KQ0KIHsNCiAJc3RydWN0IGZ0cG1fdGVlX3ByaXZhdGUg
KnB2dF9kYXRhID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQogDQpAQCAtMjg1LDE1ICsyOTIsMjAg
QEAgc3RhdGljIGludCBmdHBtX3RlZV9yZW1vdmUoc3RydWN0IGRldmljZSAqZGV2KQ0KIAl0ZWVf
Y2xpZW50X2Nsb3NlX2NvbnRleHQocHZ0X2RhdGEtPmN0eCk7DQogDQogCS8qIG1lbW9yeSBhbGxv
Y2F0ZWQgd2l0aCBkZXZtX2t6YWxsb2MoKSBpcyBmcmVlZCBhdXRvbWF0aWNhbGx5ICovDQorfQ0K
IA0KLQlyZXR1cm4gMDsNCitzdGF0aWMgdm9pZCBmdHBtX3RlZV9yZW1vdmUoc3RydWN0IHRlZV9j
bGllbnRfZGV2aWNlICp0Y2RldikNCit7DQorCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZ0Y2Rldi0+
ZGV2Ow0KKw0KKwlmdHBtX3RlZV9yZW1vdmVfZ2VuZXJpYyhkZXYpOw0KIH0NCiANCiBzdGF0aWMg
dm9pZCBmdHBtX3BsYXRfdGVlX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
IHsNCiAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCiANCi0JZnRwbV90ZWVfcmVt
b3ZlKGRldik7DQorCWZ0cG1fdGVlX3JlbW92ZV9nZW5lcmljKGRldik7DQogfQ0KIA0KIC8qKg0K
QEAgLTMzNSwxMSArMzQ3LDExIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGVlX2NsaWVudF9kZXZp
Y2VfaWQgb3B0ZWVfZnRwbV9pZF90YWJsZVtdID0gew0KIE1PRFVMRV9ERVZJQ0VfVEFCTEUodGVl
LCBvcHRlZV9mdHBtX2lkX3RhYmxlKTsNCiANCiBzdGF0aWMgc3RydWN0IHRlZV9jbGllbnRfZHJp
dmVyIGZ0cG1fdGVlX2RyaXZlciA9IHsNCisJLnByb2JlCQk9IGZ0cG1fdGVlX3Byb2JlLA0KKwku
cmVtb3ZlCQk9IGZ0cG1fdGVlX3JlbW92ZSwNCiAJLmlkX3RhYmxlCT0gb3B0ZWVfZnRwbV9pZF90
YWJsZSwNCiAJLmRyaXZlcgkJPSB7DQogCQkubmFtZQkJPSAib3B0ZWUtZnRwbSIsDQotCQkucHJv
YmUJCT0gZnRwbV90ZWVfcHJvYmUsDQotCQkucmVtb3ZlCQk9IGZ0cG1fdGVlX3JlbW92ZSwNCiAJ
fSwNCiB9Ow0KIA0KLS0gDQoyLjQ3LjMNCg0K
