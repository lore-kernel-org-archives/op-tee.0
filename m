Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CA8D4417C
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:02:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 148D146619
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:02:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=hFxFy0hM;
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8D9D750009
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 17:16:04 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso1755175e9.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 09:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473363; x=1766078163; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMKKApEFn5c8w14X+9lJPDLyCyjEvXThCatdwXgudow=;
        b=hFxFy0hM0P4MwnnEhmRWhDC/gkzIUSrPsoivkL38nTW97k7p1yEgVWmhH4oguhR6pU
         KG01hMbfAxO/EidRdMOgKSBI3IWieiPZKL2SdSa67w/QGvKKNUZjUZeC+ObRMjW+H/bR
         YnkWZIqELXVKoALaaVTFvBaoFGNJBZsWpYf+7eVHlfZVvsxXHtKes4+itA+vgYsBi4qI
         n8nUFD1AOiFfzacin8TCK61bBCThoY/DpIbEWBX99A0cWA1bQ3fD0ztwXloMM7/PJytC
         IU7olpOuR36ZBKZ3UEIAwRKSu7gtmnAcTjhvR6K6i4M8C2YKTVhkI3wwxxGEqMgu65IH
         exyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473363; x=1766078163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UMKKApEFn5c8w14X+9lJPDLyCyjEvXThCatdwXgudow=;
        b=ZRm6UKw1EfMuh2vxLm+nAobx9+poFt0ZgmOTrNz0uuMb5cCqopezpewhaEp69fJfOR
         NsEuoQr7N05iIp80jZGjlZxjByjnDIpuoGDESn+Jb5zVD+G5ifSVkOi2cQelZ0v50WpX
         BZT4A1ibD5WhgfapqaBneiuDxVOd5dEVENt9VGIWw5OFGCDNvEJYi7ex16DWBwVuobEU
         0uArzUqRhc2QqOwo3mJJRs//awWSJ8bA9+KY45NFna+vhhEa22rW1mWFKHiZ4YwaScQZ
         KKDlBP6Mn1hHhVzOkhjZ3mACXGtab87240EJlsLEH841PIlNrzs8FqnD0UgVzKxULR7E
         BzVw==
X-Gm-Message-State: AOJu0Yz0tXvspf2qEW4mlkP20KxjjDp82N6VTTcOivQ7OImC+5I9WDXY
	nLk/2l/NLUFNpPg6vHsUf12QVSzS7Oi1+SiI4de3yGsl43OHeNAnaO5SUHpS7lWtFhk=
X-Gm-Gg: AY/fxX401UhwQj+xtX/sVo91wRoLnlD0/WiivVuDUDf1SZDLKCl642zEIVv+eEC9w6x
	JC5UMRvFgk08gMgc5Cfy/D+/6Epjs0/qRQG0FvfzPm2JGt8NEpn9pmu1Q82a+K/macu2fpPZgEF
	jWWpyw/8Bqd7DpM1UGZvCwACGr5jmkkZ8Wv1chCzfTLEvbRXcD1rw+42lC8gZDC0uuQqCnPxqdl
	+ccoMnjY2eopsuOPfiPAG9ZviJRRYwLg+UTKOl4qtJJied1b2LOqeKVmLSCuwg4Gsb7WiAms4SB
	mWsW4E5U33TemxdSybhQWxuOmuG0qiefu8YtjdvoWhvS/V94Dgdf2wPSUM9rhD0G3yGxlMKCsSG
	XjmYbixzAFLtTna2BD9ozGhYzPPCg/wr+7p+SfgZffnIwz/VnlVIBGwv3xSfvjwaPMxQe6jxrhn
	1Cdzvt07GGk2BPOilxLN7pIlZa7kQkK1GhIISsc60a7nBHuQTEJ9Cq7HDNO6uzt+o85io31fuZs
	So=
X-Google-Smtp-Source: AGHT+IHR5wjI76zu9sSNjB/TR53h9qMqGGV22PiW6Sdd0Ha2DeU4S6wSatCpyfSEE7httE0vZDzqrQ==
X-Received: by 2002:a7b:c8c8:0:b0:477:a71c:d200 with SMTP id 5b1f17b1804b1-47a89ecc772mr21399785e9.11.1765473363525;
        Thu, 11 Dec 2025 09:16:03 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47a89da4756sm47522465e9.6.2025.12.11.09.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:16:03 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v1 09/17] efi: stmm: Make use of tee bus methods
Date: Thu, 11 Dec 2025 18:15:03 +0100
Message-ID: <9e3d9ab0f7987f313237b51911865f0cccae8eb5.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1589; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=qEDk8mMFP/XEe464QAjK/gPzKwVOi+IAVX6mgf9QBHw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvwrs/+p/EDhPyVo0hsuMP6NMvstZvfqWF6GI tijtgKig1OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8KwAKCRCPgPtYfRL+ TsBoB/wNEFSwNDkrKKSZy5aBqOoPmgOHHGWeulZsknyP3eoMH8etCfP7O5OsQJHFzYBTbcaeW6u ullpwQB4VirhqNZF9P+gKDCKywT9I9jIWFaS7dkKKzEQ1YCt0H4nGxR094WM6gq4PAUWPdnjGzY LC1E95XggFZrSmDz+c4c61Ifzcg7EpDMDlkoaDDSz8D5QHMKZG/uGMMQAujC5kP8C0yREbR+diO ZGXnzGlKJr+qOIIXYrnvnZLxZJFd8X9AaDf16BFDO7erlIo8VpODXbUJkxIT3/VgPeZx3SWUTql a9O+gvtyLIm9AgLef3J5+UoIw4BpKfDQAJByZVX6gOhes9a2
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.70 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[baylibre.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,kernel.org,gmail.com,foss.st.com,oss.qualcomm.com,siemens.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[2003:f6:5f00:6608:b665:17f2:bd01:7279:query timed out,209.85.128.48:query timed out];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.48:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.48:from]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8D9D750009
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: AFU5CMGY7T2UP77H64IFRV36EW3XEOFN
X-Message-ID-Hash: AFU5CMGY7T2UP77H64IFRV36EW3XEOFN
X-Mailman-Approved-At: Fri, 12 Dec 2025 10:56:47 +0000
CC: op-tee@lists.trustedfirmware.org, linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AFU5CMGY7T2UP77H64IFRV36EW3XEOFN/>
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
cmUuY29tPg0KLS0tDQogZHJpdmVycy9maXJtd2FyZS9lZmkvc3RtbS90ZWVfc3RtbV9lZmkuYyB8
IDExICsrKysrLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL3N0bW0vdGVlX3N0
bW1fZWZpLmMgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9zdG1tL3RlZV9zdG1tX2VmaS5jDQppbmRl
eCA1OTAzODExODU4YjYuLjdiMDRkZDY0OTYyOSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZmlybXdh
cmUvZWZpL3N0bW0vdGVlX3N0bW1fZWZpLmMNCisrKyBiL2RyaXZlcnMvZmlybXdhcmUvZWZpL3N0
bW0vdGVlX3N0bW1fZWZpLmMNCkBAIC01MjAsOCArNTIwLDkgQEAgc3RhdGljIHZvaWQgdGVlX3N0
bW1fcmVzdG9yZV9lZml2YXJzX2dlbmVyaWNfb3BzKHZvaWQpDQogCWVmaXZhcnNfZ2VuZXJpY19v
cHNfcmVnaXN0ZXIoKTsNCiB9DQogDQotc3RhdGljIGludCB0ZWVfc3RtbV9lZmlfcHJvYmUoc3Ry
dWN0IGRldmljZSAqZGV2KQ0KK3N0YXRpYyBpbnQgdGVlX3N0bW1fZWZpX3Byb2JlKHN0cnVjdCB0
ZWVfY2xpZW50X2RldmljZSAqdGVlX2RldikNCiB7DQorCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZ0
ZWVfZGV2LT5kZXY7DQogCXN0cnVjdCB0ZWVfaW9jdGxfb3Blbl9zZXNzaW9uX2FyZyBzZXNzX2Fy
ZzsNCiAJZWZpX3N0YXR1c190IHJldDsNCiAJaW50IHJjOw0KQEAgLTU3MSwyMSArNTcyLDE5IEBA
IHN0YXRpYyBpbnQgdGVlX3N0bW1fZWZpX3Byb2JlKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJcmV0
dXJuIDA7DQogfQ0KIA0KLXN0YXRpYyBpbnQgdGVlX3N0bW1fZWZpX3JlbW92ZShzdHJ1Y3QgZGV2
aWNlICpkZXYpDQorc3RhdGljIHZvaWQgdGVlX3N0bW1fZWZpX3JlbW92ZShzdHJ1Y3QgdGVlX2Ns
aWVudF9kZXZpY2UgKmRldikNCiB7DQogCXRlZV9zdG1tX3Jlc3RvcmVfZWZpdmFyc19nZW5lcmlj
X29wcygpOw0KLQ0KLQlyZXR1cm4gMDsNCiB9DQogDQogTU9EVUxFX0RFVklDRV9UQUJMRSh0ZWUs
IHRlZV9zdG1tX2VmaV9pZF90YWJsZSk7DQogDQogc3RhdGljIHN0cnVjdCB0ZWVfY2xpZW50X2Ry
aXZlciB0ZWVfc3RtbV9lZmlfZHJpdmVyID0gew0KIAkuaWRfdGFibGUJPSB0ZWVfc3RtbV9lZmlf
aWRfdGFibGUsDQorCS5wcm9iZQkJPSB0ZWVfc3RtbV9lZmlfcHJvYmUsDQorCS5yZW1vdmUJCT0g
dGVlX3N0bW1fZWZpX3JlbW92ZSwNCiAJLmRyaXZlcgkJPSB7DQogCQkubmFtZQkJPSAidGVlLXN0
bW0tZWZpIiwNCi0JCS5wcm9iZQkJPSB0ZWVfc3RtbV9lZmlfcHJvYmUsDQotCQkucmVtb3ZlCQk9
IHRlZV9zdG1tX2VmaV9yZW1vdmUsDQogCX0sDQogfTsNCiANCi0tIA0KMi40Ny4zDQoNCg==
