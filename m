Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E35D44166
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 10:58:51 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2213043154
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 10:58:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=SpGcOALH;
	dkim-atps=neutral
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E50944FF3F
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 17:15:57 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-477770019e4so3583045e9.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 09:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473357; x=1766078157; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7ZJJmdzlrCrLbhlEnenhFAo4uP9QJmazFjd0L4SbNo=;
        b=SpGcOALHHe18l9ijgeWbWttiXMmhIm9NzKJuvNc+PKJTkDr9TpgGhJpF0+2Fm0SD18
         brdjK6GNy8KdRHUYEFWuS6hXHM4Ha0tokSIQsAWH7N7JY+31TofDt9ighNPUGKHC1h4Y
         Oohr7UPgar+L+w/wL9uRBv5op+ITz0bZrA9kzIjKAjCKSuRNN4tf0Moz04vluhg5X4IJ
         nWXtNjkQDNl76wtaawIjR/908mSqn7wYuAISGTmhuXlT2Jc/4jKuG+KGxkWzF02S53eb
         moiOL0Yr0ahcQryV9BzNkRkdUXfpCt3iMLWAA+XS5riGhMcMeAOm9kvZtYMwhm98NLEA
         Cpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473357; x=1766078157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c7ZJJmdzlrCrLbhlEnenhFAo4uP9QJmazFjd0L4SbNo=;
        b=LvJecEqAR+2ghlCj4gNlq+7Kx/1BDOIqyPPoe/pUh8OIQntz5Gvi0zBoGUpNgoaFoV
         jkjWk7WFFHSuxzAGOHYLq5sGnL0TG/odpnPIBQBMHw6dwBtsP9SIBNQmYXck/sHBU77e
         KUMtuyDBj3gDs9sTxroFZSPh0R+ojzrd1ovedmhacZour2Pwsnt+OPutUyGtASm4Gsgb
         Pyplmey42RleyZzRwNBRbpToxaxUNW4e6iGU2vPeMiC6WPPhj60RphM9b9DoNzmhG/mE
         gdaa2Wyw//0unpXthjmWh16paKO8I5rDryDPMwOzF4RNLLTXOoEfJ9ClC/iJSdprlnPy
         QUMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhgn2y4XdfZgEOYWMpwwMPSqPtesMhQX74LhbOPuPpeerIbondpzXihQsGmMUoSa9y5SENmDU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzShb73y0GTf4oKx5Uk0wHBEdjlljYyefxKdgUd+6i1PZaQaQL+
	DqXps0klKtPrsXJPp7wnkui/XsrsD4h8gpwr7RX2oyKQtG963131S0RrWKuDLwF1HIg=
X-Gm-Gg: AY/fxX7lHW0Z7Tk5TXdDXCijyRavwCiz7sxiqLx9EeYDXbvm7fB6SaUclHaz3rKqZMj
	Q+2dTIAkZpx+b5zb8FjWQsIVUjW0fQguj0/jTAYLLdkrd/ThLY+HMZjclg6W8832ijyA9UQW7Z2
	xPZZGti/yvQ73ZWHEz8olfzP7Kn1dDVf5F6j1OeAoK/5WeQZhv+8Koo9EV6MhT9hKj9AmhlmHxs
	2mUp74Me2sVHeVs8rcvQ9ddK67R1YzEFHZTBU90R86j02I1/lcSjs1jf+CaJhEprUtZRJdtGN6Q
	X8Jt4VvecV/g//bRZF37C+jFYYa/WOCJ4CS9ByLjIwVlyBCFXllD0dEENDQvpasPoR6GAAMClUa
	wfP/BBzlqHhJT8vqYnAZWeEB2+AQtsp6buU6H70ae7wgHjeRIt4QLN89TLOgZkw3vp3NkxlSI8O
	QrIhOKV8eMIKZQZGw7kF+WEspG8QZguwyLeAeiZkYkaf/0CGOJ9AX1aNhotSovdThaY5exMrFq5
	cQ=
X-Google-Smtp-Source: AGHT+IE1mgSXNtTkZxTIkIVNCLHiHTWh3zcJ768KXxVhi/PFBHebJl9bcsXJ/5Lq6ADso4vAmmKvDA==
X-Received: by 2002:a05:600c:154d:b0:46e:4a30:2b0f with SMTP id 5b1f17b1804b1-47a8384dd86mr72360895e9.29.1765473356862;
        Thu, 11 Dec 2025 09:15:56 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47a89da4756sm47517785e9.6.2025.12.11.09.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:15:56 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v1 03/17] tee: Adapt documentation to cover recent additions
Date: Thu, 11 Dec 2025 18:14:57 +0100
Message-ID: <cce3ff1b96641295a669fe9805a7435c7ae0b89f.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=8zVhKFZP7IOwG2HejecPI/IgKt38gHvxnCsmDQ6Sszk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvwbYEpgUrQTB/R/2GTeWL815mB0BAhAQpj3E kRFR2HG5BWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8GwAKCRCPgPtYfRL+ TggTCACRua3Ow2uFKSN9NaHuIpY/1x6Vn+D8N3yqVWCzpXWfLFn0uYy3wim+63CPJUM7UVA/4GG CTqizdb/AgYzcCV6kuZmneAZ9YyoafvSMTU/buBSxjBzOa0W5yXwPyy3JDER2as71IIEowULq+s b6kE8ShtIlEa70Kyh/GY2/7UxkXvpjUFRe1xwPVQ8QyBdU5i87OiD3/tbOOA6Hi0ewyo2srDxD+ kdbprxutTs0tAuSs6yk1jhuLR5iJDQI3Gx0u5DvehnehxvSr1Rjh/3brqVAUpltlzvxQJlYSF/l bwblBx0k1eEMf//lYAMx3mI65i2KwOywW7qxZgQTiCfN6mbw
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.65:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.65:from];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	BLOCKLISTDE_FAIL(0.00)[209.85.128.65:query timed out,2003:f6:5f00:6608:b665:17f2:bd01:7279:query timed out];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E50944FF3F
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 4EF43BFKBG4CJDLQGSOFR2T5MELI3SJX
X-Message-ID-Hash: 4EF43BFKBG4CJDLQGSOFR2T5MELI3SJX
X-Mailman-Approved-At: Fri, 12 Dec 2025 10:56:47 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4EF43BFKBG4CJDLQGSOFR2T5MELI3SJX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

VGhlIHByZXZpb3VzIGNvbW1pdHMgaW50cm9kdWNlZCBzb21lIGhlbHBlcnMgdG8gcmVkdWNlIGJv
aWxlcnBsYXRlDQphbmQgYnVzIHNwZWNpZmljIGNhbGxiYWNrcyBmb3IgcHJvYmUgYW5kIHJlbW92
ZS4NCg0KQWRhcHQgdGhlIHJlZmVyZW5jZSBleGFtcGxlIHRvIG1ha2UgdXNlIG9mIHRoZXNlLg0K
DQpTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQGJheWxp
YnJlLmNvbT4NCi0tLQ0KIERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS90ZWUucnN0IHwgMTggKysr
LS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMTUgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdGVlLnJz
dCBiL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS90ZWUucnN0DQppbmRleCA1ZWFlYjgxMDM5ODgu
LjRkNThhYzA3MTJjMSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS90ZWUu
cnN0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdGVlLnJzdA0KQEAgLTQzLDI0ICs0
MywxMiBAQCBzbmlwcGV0IHdvdWxkIGxvb2sgbGlrZTo6DQogCU1PRFVMRV9ERVZJQ0VfVEFCTEUo
dGVlLCBjbGllbnRfaWRfdGFibGUpOw0KIA0KIAlzdGF0aWMgc3RydWN0IHRlZV9jbGllbnRfZHJp
dmVyIGNsaWVudF9kcml2ZXIgPSB7DQorCQkucHJvYmUJCT0gY2xpZW50X3Byb2JlLA0KKwkJLnJl
bW92ZQkJPSBjbGllbnRfcmVtb3ZlLA0KIAkJLmlkX3RhYmxlCT0gY2xpZW50X2lkX3RhYmxlLA0K
IAkJLmRyaXZlcgkJPSB7DQogCQkJLm5hbWUJCT0gRFJJVkVSX05BTUUsDQotCQkJLmJ1cwkJPSAm
dGVlX2J1c190eXBlLA0KLQkJCS5wcm9iZQkJPSBjbGllbnRfcHJvYmUsDQotCQkJLnJlbW92ZQkJ
PSBjbGllbnRfcmVtb3ZlLA0KIAkJfSwNCiAJfTsNCiANCi0Jc3RhdGljIGludCBfX2luaXQgY2xp
ZW50X2luaXQodm9pZCkNCi0Jew0KLQkJcmV0dXJuIGRyaXZlcl9yZWdpc3RlcigmY2xpZW50X2Ry
aXZlci5kcml2ZXIpOw0KLQl9DQotDQotCXN0YXRpYyB2b2lkIF9fZXhpdCBjbGllbnRfZXhpdCh2
b2lkKQ0KLQl7DQotCQlkcml2ZXJfdW5yZWdpc3RlcigmY2xpZW50X2RyaXZlci5kcml2ZXIpOw0K
LQl9DQotDQotCW1vZHVsZV9pbml0KGNsaWVudF9pbml0KTsNCi0JbW9kdWxlX2V4aXQoY2xpZW50
X2V4aXQpOw0KKwltb2R1bGVfdGVlX2NsaWVudF9kcml2ZXIoY2xpZW50X2RyaXZlcik7DQotLSAN
CjIuNDcuMw0KDQo=
