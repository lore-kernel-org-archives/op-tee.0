Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60C8D5B16E
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:27:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1CD634FEBB
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:27:57 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=DbPs8egf;
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 431CB4FEBF
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 14:18:02 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so6063658a12.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 06:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808281; x=1766413081; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhxFEbi3upUhHH0lvs3ziMzH7rdhLkVDsyriiRkxcyM=;
        b=DbPs8egfQUYJhYFw+szzPnCwTVuGrusgSYp+Oa7roqSxOcfITJtBFUnDYhOigjU1Wi
         evmdBFeJEYoJl+20Kaz6bRDLO0J8xR1EZa7eGvErRmbKxVc4B76pu/QU8rsCwW9OEuHM
         lGRVuJFFtINy3Sv8Qv1fTWAl5B11ZPysi4NGkdoZdqKmqjxs4c6XJXz+UlYRgincTBPQ
         qgDN0WuoaCFMmx0vfgDLJ8hnXJVsmV5Ku+KDGGOUR5ysHfabx+MqtGnZliqkcErZ5gVl
         kK0mqfGexW32fAQFFO+c8ZfKGLJCmTAsZcf4I9znkX6salV6YzkbjBlDDXxCCqDim9XP
         y0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808281; x=1766413081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VhxFEbi3upUhHH0lvs3ziMzH7rdhLkVDsyriiRkxcyM=;
        b=hwhR3CSjK34dVoccfEk141zqDGF9WJkjC45yAwmj9LB4tuLE11NqTZLw1+8Xg2sREe
         EdxrdLzdr8JIbiCjO5pfNwlLkSEh0iYxcrirZAH42eqGTxBc8mgXbhViCA1hR5nmt1DT
         b73P90F6W+epEFBEVnLepX61kkq+qsa6xOOJ/zcmfIoSa/0G7r6JpRv7PZKXAS48d7Pf
         t/WzjL++tBqe+r6Be67uT2OURO9rjRXw3Q67BAuiRkcA6Et9Q+WEhSwPgvQw//KhFph1
         Mu7PtiCeMh81ir+0V5oUisvd9Fl4ZDobKV3/mWxtjJhQrghbzvy0Qm9BRylk9YPslUyJ
         LLow==
X-Forwarded-Encrypted: i=1; AJvYcCWoAubtUrnFW8kbAWs6EleBENv1wyUHTnM21WjnqATZ5NL75mcjnUyn7ZP50Jdw3tIVkZF6dx4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyaKso24nLEfz2HFXVwUj3geN25sQhTep4sVL744ue7qWvDw2e8
	2b3T4XyXRJ8sPL3+x21TrycXZ7mtfIdBT0XavF3AucFVYrfOwDYuIuTYkgtIoHJBP/Q=
X-Gm-Gg: AY/fxX7HO2HKcjZj0k4fZPFmEXNYY9lmD+0b8rbayCArYFEviNkxk183mlAzxvi94G4
	I9/6QBmgqS36Bb3+IKwQ8/kh2gjlLlIEV7DEsCzgucIfMa+uCfDG4v+ORnWRMUjz1RfyM3vVtsl
	4/ScNQ4iHde1W3cvDS9/sBY6ZI4gTLibgL2EoSNAUdxPTbAKsjo+2A9QMg64e78vgzHSSZEn0Hd
	soFj1ReseKPws0jAkyYDLWjX0XsWNjHZNu6yga2lVUmbNBQcvEAXlSskCDtWjtAcO9+4t4lnBYM
	OF33vA8gxbUFsXzNl2CEqpN+c/1kbuiPyoJJEFQVOYyxR9d5hjpcusWia9KgWofr1uG+qrybBFg
	tVtP1X2ZoaXO2wzD8JnMzXnFNqMhNjJqyTvxX8+Rkva7qJmRxQ8TyvBv6IOeNClSSEn5dGQ6vqc
	MQHGS6sUuW1PZQiZnv/xS8cyP61FXpY/YrsJi9QV35U+VLXU0QO8fytKHBHZWSOcgzOJVZ
X-Google-Smtp-Source: AGHT+IHC8ujpn/jRAp3uyUfhPlLVYnf8gdfe5eEvlFd2Ct3yaq9KShqsTrao9oJk1KAsuZl7TA5Hxw==
X-Received: by 2002:a17:907:7b82:b0:b70:68d7:ac0c with SMTP id a640c23a62f3a-b7d238ddd7emr957125366b.42.1765808281128;
        Mon, 15 Dec 2025 06:18:01 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa57190dsm1442761666b.49.2025.12.15.06.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:18:00 -0800 (PST)
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
Subject: [PATCH v2 15/17] KEYS: trusted: Make use of tee bus methods
Date: Mon, 15 Dec 2025 15:16:45 +0100
Message-ID: <ad8aaa343c1e8523659259290f63aea8be906977.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1963; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=GGyKb0nPpNUP9YxvKC/UL/zntZq4nlTFqMxQrMaeHc8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhwtaw6vWGcyIGKsWICqFr37WWt86tvJxrvx 1eTqfVDJZqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYcAAKCRCPgPtYfRL+ Th3cB/9e3Pv5r3zMgBKsAgjAsHEhpC0EgCY2oqRVfxKl8HHNjl+lB20MGJ2Q8pSnEUNYokQO3QL mOTOzUqSZn9hAaGG/5LKUE70SRu5xo1OgksDBfRcBInzXTVG7RDE0gQMoPbW3O/QimI6W2kQfJx KesCYRfngtF0s9Jq1wiZvB24whWT0ZvkV2bFXypQVF3Ta77WO8PtMmx3Bk+0u+EkLt3e/pfof0U NylFPVRHjBIX4DRRlA9oRL2MT4Npc9hTQBUo9iUHIoOxuI3uaEzDXB/69vwGC5Y1KsCDA+XS5Ma emNcInkIoXdw9B5y8cwnaf8ckyn6/3KiWopHnE+ahW+5sT3k
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.44:from];
	RCVD_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[baylibre.com];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[46.5.122.62:received];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.44:from];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 431CB4FEBF
X-Spamd-Bar: /
Message-ID-Hash: RRABYJWR3CS7QUNBCKYEPBYAOOAXB5ZG
X-Message-ID-Hash: RRABYJWR3CS7QUNBCKYEPBYAOOAXB5ZG
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RRABYJWR3CS7QUNBCKYEPBYAOOAXB5ZG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

VGhlIHRlZSBidXMgZ290IGRlZGljYXRlZCBjYWxsYmFja3MgZm9yIHByb2JlIGFuZCByZW1vdmUu
DQpNYWtlIHVzZSBvZiB0aGVzZS4gVGhpcyBmaXhlcyBhIHJ1bnRpbWUgd2FybmluZyBhYm91dCB0
aGUgZHJpdmVyIG5lZWRpbmcNCnRvIGJlIGNvbnZlcnRlZCB0byB0aGUgYnVzIG1ldGhvZHMuDQoN
ClJldmlld2VkLWJ5OiBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQG9zcy5xdWFsY29tbS5jb20+DQpT
aWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQGJheWxpYnJl
LmNvbT4NCi0tLQ0KIHNlY3VyaXR5L2tleXMvdHJ1c3RlZC1rZXlzL3RydXN0ZWRfdGVlLmMgfCAx
MiArKysrKy0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA3IGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvc2VjdXJpdHkva2V5cy90cnVzdGVkLWtleXMvdHJ1c3Rl
ZF90ZWUuYyBiL3NlY3VyaXR5L2tleXMvdHJ1c3RlZC1rZXlzL3RydXN0ZWRfdGVlLmMNCmluZGV4
IDNjZWE5YTM3Nzk1NS4uNmU0NjVjOGJlZjVlIDEwMDY0NA0KLS0tIGEvc2VjdXJpdHkva2V5cy90
cnVzdGVkLWtleXMvdHJ1c3RlZF90ZWUuYw0KKysrIGIvc2VjdXJpdHkva2V5cy90cnVzdGVkLWtl
eXMvdHJ1c3RlZF90ZWUuYw0KQEAgLTIwMiw5ICsyMDIsOSBAQCBzdGF0aWMgaW50IG9wdGVlX2N0
eF9tYXRjaChzdHJ1Y3QgdGVlX2lvY3RsX3ZlcnNpb25fZGF0YSAqdmVyLCBjb25zdCB2b2lkICpk
YXRhKQ0KIAkJcmV0dXJuIDA7DQogfQ0KIA0KLXN0YXRpYyBpbnQgdHJ1c3RlZF9rZXlfcHJvYmUo
c3RydWN0IGRldmljZSAqZGV2KQ0KK3N0YXRpYyBpbnQgdHJ1c3RlZF9rZXlfcHJvYmUoc3RydWN0
IHRlZV9jbGllbnRfZGV2aWNlICpybmdfZGV2aWNlKQ0KIHsNCi0Jc3RydWN0IHRlZV9jbGllbnRf
ZGV2aWNlICpybmdfZGV2aWNlID0gdG9fdGVlX2NsaWVudF9kZXZpY2UoZGV2KTsNCisJc3RydWN0
IGRldmljZSAqZGV2ID0gJnJuZ19kZXZpY2UtPmRldjsNCiAJaW50IHJldDsNCiAJc3RydWN0IHRl
ZV9pb2N0bF9vcGVuX3Nlc3Npb25fYXJnIHNlc3NfYXJnOw0KIA0KQEAgLTI0NCwxMyArMjQ0LDEx
IEBAIHN0YXRpYyBpbnQgdHJ1c3RlZF9rZXlfcHJvYmUoc3RydWN0IGRldmljZSAqZGV2KQ0KIAly
ZXR1cm4gcmV0Ow0KIH0NCiANCi1zdGF0aWMgaW50IHRydXN0ZWRfa2V5X3JlbW92ZShzdHJ1Y3Qg
ZGV2aWNlICpkZXYpDQorc3RhdGljIHZvaWQgdHJ1c3RlZF9rZXlfcmVtb3ZlKHN0cnVjdCB0ZWVf
Y2xpZW50X2RldmljZSAqZGV2KQ0KIHsNCiAJdW5yZWdpc3Rlcl9rZXlfdHlwZSgma2V5X3R5cGVf
dHJ1c3RlZCk7DQogCXRlZV9jbGllbnRfY2xvc2Vfc2Vzc2lvbihwdnRfZGF0YS5jdHgsIHB2dF9k
YXRhLnNlc3Npb25faWQpOw0KIAl0ZWVfY2xpZW50X2Nsb3NlX2NvbnRleHQocHZ0X2RhdGEuY3R4
KTsNCi0NCi0JcmV0dXJuIDA7DQogfQ0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGVlX2NsaWVu
dF9kZXZpY2VfaWQgdHJ1c3RlZF9rZXlfaWRfdGFibGVbXSA9IHsNCkBAIC0yNjEsMTEgKzI1OSwx
MSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHRlZV9jbGllbnRfZGV2aWNlX2lkIHRydXN0ZWRfa2V5
X2lkX3RhYmxlW10gPSB7DQogTU9EVUxFX0RFVklDRV9UQUJMRSh0ZWUsIHRydXN0ZWRfa2V5X2lk
X3RhYmxlKTsNCiANCiBzdGF0aWMgc3RydWN0IHRlZV9jbGllbnRfZHJpdmVyIHRydXN0ZWRfa2V5
X2RyaXZlciA9IHsNCisJLnByb2JlCQk9IHRydXN0ZWRfa2V5X3Byb2JlLA0KKwkucmVtb3ZlCQk9
IHRydXN0ZWRfa2V5X3JlbW92ZSwNCiAJLmlkX3RhYmxlCT0gdHJ1c3RlZF9rZXlfaWRfdGFibGUs
DQogCS5kcml2ZXIJCT0gew0KIAkJLm5hbWUJCT0gRFJJVkVSX05BTUUsDQotCQkucHJvYmUJCT0g
dHJ1c3RlZF9rZXlfcHJvYmUsDQotCQkucmVtb3ZlCQk9IHRydXN0ZWRfa2V5X3JlbW92ZSwNCiAJ
fSwNCiB9Ow0KIA0KLS0gDQoyLjQ3LjMNCg0K
