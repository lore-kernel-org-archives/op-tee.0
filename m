Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2053ED5B16C
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:19:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 77BD34FE9B
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:19:42 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=WeBzvQx6;
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2E85345294
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 14:17:39 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so6943429a12.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 06:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808258; x=1766413058; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYbyn8/EnLRxLtN5kn4exRhzxKPrsMPkbxoYT9sJDCo=;
        b=WeBzvQx6tK+Fv4NM+BMJpWBZtG6wwtuOMOCsaL8w0USYAYgB365ZZuRo3h6jsXdFNQ
         no76jMe1WvyCzoeNgmPDjMf69/O86nRCQY4gLQtQqQxXEZgXctNuuhkr2DcVSfsS/Sie
         26+0vZCggtn2JguS9UQqzRr/1Q9hZiFNmxwcEGArMTsEH84Zi5LTG7hEOG0v6OQtElu2
         3ayLt7QXBHU3cgdHmE0MpCwXaN6gKWcV5MpoZdGjcu6RNATR/3vcK26c7odCLu/kJV/p
         It5CKTMSgTeljh45QD6UGKP9KD48FtsA4aBM4EuQy8Ua37t4vZezQCE1yXtqdc40s6dw
         HHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808258; x=1766413058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pYbyn8/EnLRxLtN5kn4exRhzxKPrsMPkbxoYT9sJDCo=;
        b=ry+lAGHBp8Et/BgBZpc+52sVi3bmJ2bcJzC/9w/OZara5RUvzdHi/wZuhO5qUFEzzW
         ZvN82Yf7UqoQVkvuK/vlc4RcVcHYBoO2vZC//RNClibTkDSRAdRvzTL8kF9RNCq0SKBS
         0MVhhN0QxOeTlI3LHXxc9LYVKnE93z5+iBKl0y4TsdTJA8mrzy6tGo0ncj+TdlBqI1w7
         5X6ObH2D7so8KSMotv9NqmffhnzD64dGBmPtZZ7aO2I8oVUNHG7uGBlSkOcq789Cehpk
         xcwGw3UAzmg82reJdA/ovlzGAxhqanY5534OS0T89bLqFc2zZ27IeVvIrZTpKYU5aqZn
         sVaA==
X-Forwarded-Encrypted: i=1; AJvYcCVkZqUm2Cnyq5/RYk5cuT1KZ31kmcK3Mf1DGjdJ0EflKf5I3YzUl6ZW/qF81Rizu/worS8mJiQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy6Sh454P1XKodqIGPpDsRuh1dOPUARb4zGe0lQhagN2yNpwx0z
	lmxLCs2iSLYLvTdC8egYvHCQ6TlimMaIduNfVzL1dYM5Erzc30wR/nde3i7wT13VYzU=
X-Gm-Gg: AY/fxX7GqLxE4n9gd7XuqxT/fnWZ9cChFqpsctJYobbMysdYrZs06ZhuoJ47SQX0JtT
	T2WfIIuYWivssRS8gKcdE4ddNbrGRGY2p5m9DSoYQ25LANZ7iX8pe9rD7oMfPRonRaSIcT1fawo
	ltsknII7H8QxaE5jiQ7VcZ4TByFBkhGZZKbCb2yOYbShc+G0uGcCM0vniVvQoUKnISM3j/l9bi8
	3W6omwni6H6CzVAOViNiUJC/Ur3eKYoxXGVM4ekFgGaZv3/OFQ+tWyv1gQxm+Ad3IQjla4u3JyD
	fbH7FEDZsfS7KgsDfv4v0tPy8Dl4yzg2F3T3R20JHWGP6H74z6iHhlj4XxZqZdUmA7CKVnCC3Y4
	xR5mUNiO8ohkTv2ePGXxcPoP9GVypCEOr64oTOLIunWUNy8Ug+np3MwGKw5tf6eIVSgFNQLdFuU
	Dl7mbWqgF7gMYibuDHdr/Nb/sR9UBcH3Ig5o2Ruo5fzL5USA6iWq9JBKVDrw==
X-Google-Smtp-Source: AGHT+IH2YAK0HCE3AKMihYwZpmjmWE6HYGsq9gAMwxcv1jzlhc75cjnc7OqoPvVUExhp0Mdl2kklIQ==
X-Received: by 2002:a17:907:7f27:b0:b79:c879:fe71 with SMTP id a640c23a62f3a-b7d23a47753mr1098582566b.19.1765808258026;
        Mon, 15 Dec 2025 06:17:38 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa29beabsm1433409166b.4.2025.12.15.06.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:37 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 02/17] tee: Add probe, remove and shutdown bus callbacks to tee_client_driver
Date: Mon, 15 Dec 2025 15:16:32 +0100
Message-ID: <667477a172a4296ee060508a5778be7b0d2ca375.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=4205; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=qF1IcEKbJFmyVmb3aXHXWHWAtPeq4SU+toAkI6ZHppU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhQbqdn/HuaqlN6kLv5W75bm0Ws8yfNZJCnV lmMCiioe2eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYUAAKCRCPgPtYfRL+ ThZ4B/0Z1HxbnrrtOrIAoOjKPDeR10PHx55cuFqJa8OlpcOghtKk5foX2Knev9V32xsuzOx1TdP wIT3KfWcT2pi1yhhSDI9W+qeGXYZALUNRgLE/L75wGZ3wD1tzUo70QkfHZI7u+D6yYNe35495FE WJvkfziyIEV7peL8U710+JK4KsEZUNZjg1JJJ/23maTVZ/yU1jaEYc1JlSuVbeQ4NXLh4nMdhPB 0S09YShtrY01kAvtF1Of4uNdeO3S4VuNoGy9QJQoq6mCzLk0wEH8P7H/Vb80OUj3HTICm6FNlUA rEmq2rxB7ct+dtHlCBA3sua5ap4LwbCrX+fS3GFs7LQy5qS1
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.51:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.51:from];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[baylibre.com];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[46.5.122.62:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2E85345294
X-Spamd-Bar: --
Message-ID-Hash: X6L2DNDHIXYFPOY7T7X6E64X2MTQIUVK
X-Message-ID-Hash: X6L2DNDHIXYFPOY7T7X6E64X2MTQIUVK
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/X6L2DNDHIXYFPOY7T7X6E64X2MTQIUVK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SW50cm9kdWNlIGEgYnVzIHNwZWNpZmljIHByb2JlLCByZW1vdmUgYW5kIHNodXRkb3duIGZ1bmN0
aW9uLiBGb3Igbm93DQp0aGlzIG9ubHkgYWxsb3dzIHRvIGdldCByaWQgb2YgYSBjYXN0IG9mIHRo
ZSBnZW5lcmljIGRldmljZSB0byBhDQp0ZWVfY2xpZW50IGRldmljZSBpbiB0aGUgZHJpdmVycyBh
bmQgY2hhbmdlcyB0aGUgcmVtb3ZlIHByb3RvdHlwZSB0bw0KcmV0dXJuIHZvaWQtLS1hIG5vbi16
ZXJvIHJldHVybiB2YWx1ZSBpcyBpZ25vcmVkIGFueWhvdy4NCg0KVGhlIG9iamVjdGl2ZSBpcyB0
byBnZXQgcmlkIG9mIHVzZXJzIG9mIHN0cnVjdCBkZXZpY2VfZHJpdmVyIGNhbGxiYWNrcw0KLnBy
b2JlKCksIC5yZW1vdmUoKSBhbmQgLnNodXRkb3duKCkgdG8gZXZlbnR1YWxseSByZW1vdmUgdGhl
c2UuIFVudGlsDQphbGwgdGVlX2NsaWVudCBkcml2ZXJzIGFyZSBjb252ZXJ0ZWQgdGhpcyByZXN1
bHRzIGluIGEgcnVudGltZSB3YXJuaW5nDQphYm91dCB0aGUgZHJpdmVycyBuZWVkaW5nIGFuIHVw
ZGF0ZSBiZWNhdXNlIHRoZXJlIGlzIGEgYnVzIHByb2JlDQpmdW5jdGlvbiBhbmQgYSBkcml2ZXIg
cHJvYmUgZnVuY3Rpb24uDQoNClNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1Lmts
ZWluZS1rb2VuaWdAYmF5bGlicmUuY29tPg0KLS0tDQogZHJpdmVycy90ZWUvdGVlX2NvcmUuYyAg
fCA2OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUv
bGludXgvdGVlX2Rydi5oIHwgIDMgKysNCiAyIGZpbGVzIGNoYW5nZWQsIDcxIGluc2VydGlvbnMo
KykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGVlL3RlZV9jb3JlLmMgYi9kcml2ZXJzL3RlZS90
ZWVfY29yZS5jDQppbmRleCA1MTM3OWY3ZmM1ZDUuLmEwMTU3MzA2NjRjNyAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvdGVlL3RlZV9jb3JlLmMNCisrKyBiL2RyaXZlcnMvdGVlL3RlZV9jb3JlLmMNCkBA
IC0xMzk4LDE5ICsxMzk4LDg3IEBAIHN0YXRpYyBpbnQgdGVlX2NsaWVudF9kZXZpY2VfdWV2ZW50
KGNvbnN0IHN0cnVjdCBkZXZpY2UgKmRldiwNCiAJcmV0dXJuIGFkZF91ZXZlbnRfdmFyKGVudiwg
Ik1PREFMSUFTPXRlZTolcFViIiwgZGV2X2lkKTsNCiB9DQogDQorc3RhdGljIGludCB0ZWVfY2xp
ZW50X2RldmljZV9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQorew0KKwlzdHJ1Y3QgdGVlX2Ns
aWVudF9kZXZpY2UgKnRjZGV2ID0gdG9fdGVlX2NsaWVudF9kZXZpY2UoZGV2KTsNCisJc3RydWN0
IHRlZV9jbGllbnRfZHJpdmVyICpkcnYgPSB0b190ZWVfY2xpZW50X2RyaXZlcihkZXYtPmRyaXZl
cik7DQorDQorCWlmIChkcnYtPnByb2JlKQ0KKwkJcmV0dXJuIGRydi0+cHJvYmUodGNkZXYpOw0K
KwllbHNlDQorCQlyZXR1cm4gMDsNCit9DQorDQorc3RhdGljIHZvaWQgdGVlX2NsaWVudF9kZXZp
Y2VfcmVtb3ZlKHN0cnVjdCBkZXZpY2UgKmRldikNCit7DQorCXN0cnVjdCB0ZWVfY2xpZW50X2Rl
dmljZSAqdGNkZXYgPSB0b190ZWVfY2xpZW50X2RldmljZShkZXYpOw0KKwlzdHJ1Y3QgdGVlX2Ns
aWVudF9kcml2ZXIgKmRydiA9IHRvX3RlZV9jbGllbnRfZHJpdmVyKGRldi0+ZHJpdmVyKTsNCisN
CisJaWYgKGRydi0+cmVtb3ZlKQ0KKwkJZHJ2LT5yZW1vdmUodGNkZXYpOw0KK30NCisNCitzdGF0
aWMgdm9pZCB0ZWVfY2xpZW50X2RldmljZV9zaHV0ZG93bihzdHJ1Y3QgZGV2aWNlICpkZXYpDQor
ew0KKwlzdHJ1Y3QgdGVlX2NsaWVudF9kZXZpY2UgKnRjZGV2ID0gdG9fdGVlX2NsaWVudF9kZXZp
Y2UoZGV2KTsNCisJc3RydWN0IHRlZV9jbGllbnRfZHJpdmVyICpkcnYgPSB0b190ZWVfY2xpZW50
X2RyaXZlcihkZXYtPmRyaXZlcik7DQorDQorCWlmIChkZXYtPmRyaXZlciAmJiBkcnYtPnNodXRk
b3duKQ0KKwkJZHJ2LT5zaHV0ZG93bih0Y2Rldik7DQorfQ0KKw0KIGNvbnN0IHN0cnVjdCBidXNf
dHlwZSB0ZWVfYnVzX3R5cGUgPSB7DQogCS5uYW1lCQk9ICJ0ZWUiLA0KIAkubWF0Y2gJCT0gdGVl
X2NsaWVudF9kZXZpY2VfbWF0Y2gsDQogCS51ZXZlbnQJCT0gdGVlX2NsaWVudF9kZXZpY2VfdWV2
ZW50LA0KKwkucHJvYmUJCT0gdGVlX2NsaWVudF9kZXZpY2VfcHJvYmUsDQorCS5yZW1vdmUJCT0g
dGVlX2NsaWVudF9kZXZpY2VfcmVtb3ZlLA0KKwkuc2h1dGRvd24JPSB0ZWVfY2xpZW50X2Rldmlj
ZV9zaHV0ZG93biwNCiB9Ow0KIEVYUE9SVF9TWU1CT0xfR1BMKHRlZV9idXNfdHlwZSk7DQogDQor
c3RhdGljIGludCB0ZWVfY2xpZW50X2RldmljZV9wcm9iZV9sZWdhY3koc3RydWN0IHRlZV9jbGll
bnRfZGV2aWNlICp0Y2RldikNCit7DQorCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZ0Y2Rldi0+ZGV2
Ow0KKwlzdHJ1Y3QgZGV2aWNlX2RyaXZlciAqZHJpdmVyID0gZGV2LT5kcml2ZXI7DQorDQorCXJl
dHVybiBkcml2ZXItPnByb2JlKGRldik7DQorfQ0KKw0KK3N0YXRpYyB2b2lkIHRlZV9jbGllbnRf
ZGV2aWNlX3JlbW92ZV9sZWdhY3koc3RydWN0IHRlZV9jbGllbnRfZGV2aWNlICp0Y2RldikNCit7
DQorCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZ0Y2Rldi0+ZGV2Ow0KKwlzdHJ1Y3QgZGV2aWNlX2Ry
aXZlciAqZHJpdmVyID0gZGV2LT5kcml2ZXI7DQorDQorCWRyaXZlci0+cmVtb3ZlKGRldik7DQor
fQ0KKw0KK3N0YXRpYyB2b2lkIHRlZV9jbGllbnRfZGV2aWNlX3NodXRkb3duX2xlZ2FjeShzdHJ1
Y3QgdGVlX2NsaWVudF9kZXZpY2UgKnRjZGV2KQ0KK3sNCisJc3RydWN0IGRldmljZSAqZGV2ID0g
JnRjZGV2LT5kZXY7DQorCXN0cnVjdCBkZXZpY2VfZHJpdmVyICpkcml2ZXIgPSBkZXYtPmRyaXZl
cjsNCisNCisJZHJpdmVyLT5zaHV0ZG93bihkZXYpOw0KK30NCisNCiBpbnQgX190ZWVfY2xpZW50
X2RyaXZlcl9yZWdpc3RlcihzdHJ1Y3QgdGVlX2NsaWVudF9kcml2ZXIgKnRlZV9kcml2ZXIsDQog
CQkJCSBzdHJ1Y3QgbW9kdWxlICpvd25lcikNCiB7DQogCXRlZV9kcml2ZXItPmRyaXZlci5vd25l
ciA9IG93bmVyOw0KIAl0ZWVfZHJpdmVyLT5kcml2ZXIuYnVzID0gJnRlZV9idXNfdHlwZTsNCiAN
CisJLyoNCisJICogRHJpdmVycyB0aGF0IGhhdmUgY2FsbGJhY2tzIHNldCBmb3IgdGVlX2RyaXZl
ci0+ZHJpdmVyIG5lZWQgdXBkYXRpbmcNCisJICogdG8gdXNlIHRoZSBjYWxsYmFja3MgaW4gdGVl
X2RyaXZlciBpbnN0ZWFkLiBkcml2ZXJfcmVnaXN0ZXIoKSB3YXJucw0KKwkgKiBhYm91dCB0aGF0
LCBzbyBubyBuZWVkIHRvIHdhcm4gaGVyZSwgdG9vLg0KKwkgKi8NCisJaWYgKCF0ZWVfZHJpdmVy
LT5wcm9iZSAmJiB0ZWVfZHJpdmVyLT5kcml2ZXIucHJvYmUpDQorCQl0ZWVfZHJpdmVyLT5wcm9i
ZSA9IHRlZV9jbGllbnRfZGV2aWNlX3Byb2JlX2xlZ2FjeTsNCisJaWYgKCF0ZWVfZHJpdmVyLT5y
ZW1vdmUgJiYgdGVlX2RyaXZlci0+ZHJpdmVyLnJlbW92ZSkNCisJCXRlZV9kcml2ZXItPnJlbW92
ZSA9IHRlZV9jbGllbnRfZGV2aWNlX3JlbW92ZV9sZWdhY3k7DQorCWlmICghdGVlX2RyaXZlci0+
c2h1dGRvd24gJiYgdGVlX2RyaXZlci0+ZHJpdmVyLnByb2JlKQ0KKwkJdGVlX2RyaXZlci0+c2h1
dGRvd24gPSB0ZWVfY2xpZW50X2RldmljZV9zaHV0ZG93bl9sZWdhY3k7DQorDQogCXJldHVybiBk
cml2ZXJfcmVnaXN0ZXIoJnRlZV9kcml2ZXItPmRyaXZlcik7DQogfQ0KIEVYUE9SVF9TWU1CT0xf
R1BMKF9fdGVlX2NsaWVudF9kcml2ZXJfcmVnaXN0ZXIpOw0KZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvdGVlX2Rydi5oIGIvaW5jbHVkZS9saW51eC90ZWVfZHJ2LmgNCmluZGV4IDg1MGMwM2Iy
Y2RlYS4uZTU2MWEyNmY1MzdhIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC90ZWVfZHJ2LmgN
CisrKyBiL2luY2x1ZGUvbGludXgvdGVlX2Rydi5oDQpAQCAtMzE1LDYgKzMxNSw5IEBAIHN0cnVj
dCB0ZWVfY2xpZW50X2RldmljZSB7DQogICogQGRyaXZlcjoJCWRyaXZlciBzdHJ1Y3R1cmUNCiAg
Ki8NCiBzdHJ1Y3QgdGVlX2NsaWVudF9kcml2ZXIgew0KKwlpbnQgKCpwcm9iZSkoc3RydWN0IHRl
ZV9jbGllbnRfZGV2aWNlICopOw0KKwl2b2lkICgqcmVtb3ZlKShzdHJ1Y3QgdGVlX2NsaWVudF9k
ZXZpY2UgKik7DQorCXZvaWQgKCpzaHV0ZG93bikoc3RydWN0IHRlZV9jbGllbnRfZGV2aWNlICop
Ow0KIAljb25zdCBzdHJ1Y3QgdGVlX2NsaWVudF9kZXZpY2VfaWQgKmlkX3RhYmxlOw0KIAlzdHJ1
Y3QgZGV2aWNlX2RyaXZlciBkcml2ZXI7DQogfTsNCi0tIA0KMi40Ny4zDQoNCg==
