Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C00D5B16C
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:26:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 204914FEB7
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:26:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Y4K3s1uo;
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id ED5F94FEB4
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 14:17:57 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7277324204so564496766b.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 06:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808277; x=1766413077; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iqJF7orvlMqhIrghvfFQasl/uMqZ7gfWiSQOSJzmXI=;
        b=Y4K3s1uochNm55WhOMO1CWJ9IqlmQAyTCjT2gFLyJ+R46VakBlfTkrREUlENvYvMKv
         ZmByHVuzuoyFB3inqwzRd4YSt5ku1JL1Q7dpCwtw3w0NUn9GsgxLeIqimKdVcsnBcmyP
         mY1tqGo0m6m4ni16uXXOJ29y4k16BwcnOjdnEYDlTWauXN2Cid1rTyrzwEgZMInkNjI2
         G13vZ4cGiVVlZIMgZIbtfKCaIpJiyNseu5ci4IbRqeWDayPvmSnx9NvT2RppblAehWkA
         WAPPTClkz9XiIPzsv0f3IDZCTONRu4wwsrH9VnK4binqZvuKSQBxd4RuMiSHFfjksYPe
         +FnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808277; x=1766413077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7iqJF7orvlMqhIrghvfFQasl/uMqZ7gfWiSQOSJzmXI=;
        b=I3UtyW37qD1eaEeSkGo+3946FFS8r8qfDjHmOyEdb9l7LBNym0aADgFPhIIOS0GBbM
         eDvTimgnF1/Tp2goDJ3nIZmMLLaDXXFSIAnG5IHiAoZPBhxBBuCl7L/OYYbWH6fF5ZK3
         ssW6WWohf6hKJx8RkOq+uBF7ULuCW4lhqdboLb7WB8hnWNe4IN0Q89SOND24ZgmbIvYn
         /cpzdOOKgb1NSlGdmYBcDQgubMCDkqHYGFmm0P4YPe7KqVaY9q4niZziysQz4fewgCYX
         93L3Tb6SD9GwANhGYL33FevEgnqnRK6bXxzRtHHXLlt6Q6yb4xgIzIsce5h/IsnapNo4
         kftw==
X-Forwarded-Encrypted: i=1; AJvYcCXs6pZdN9vw7DU6f2+uvIo6c1yJQUHHs/ZtfXUKlXC0ZOeNWcmuWs2pjwD3Of6PEJ+GvVJZpsE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyKFV9FcdaPyCHycwf/x4PwJSbV/c/PN2GN4WtMDklzG7uyEbAM
	cjcj2jHtJVM36kM2tbXUPthVRMNiVnFcVRnhXk89dmLHLzcZZiRea2b5ncNjkMtDDww=
X-Gm-Gg: AY/fxX7j/p5ziDkZDTCs+clov5FFJpKjJA9gynpTZJODYR6rG4kazgb1N6k3eN+ZeQ2
	f8tKyFdfX+somBwuFBs9kjs2y9tLhguhfGkrpa5FD1G6oBi3lAeBcq5uXHN8wZowXCkvC68mvDk
	TQSkbN1s/oqDhOjNI3DjgOZmrNcnuee/H8CdoCdrJd/4HlEKFYtY0uHPgeNB6VFnQ6rOEHPjMQT
	0YEAtw1SvqigWKAFoXrpYpm2lw9+gzKfauE04/ZFcxwkInGFGWmxlm7qMSG589DoOmOiUL7Fnxd
	16M+iT+9RAoprbsdJNetCOCJczniDFZY7mDJkU0Pjj1mA1qJWbd2lZ88TV452Xo47f+msXzT1zn
	p2ppDp0Hq53hOrsqo0swVuhjpBLp0z60ZMUpmj27GpCdaN7MpvVgniNlSL/BwuGmb9tx5M9prBi
	4NLl+cu2FiXbVrukBF2TTUKSmqzBnIixIhp8TGKTNRlNU/traiAseozPPh0g==
X-Google-Smtp-Source: AGHT+IEPjHTBezRQ3PDr8F60Bso0OUB75ZXwyfvhYmt5eGS3puxlFDVYpAwYmpGEYvObi0dAnABghw==
X-Received: by 2002:a17:907:6e90:b0:b73:78f3:15c1 with SMTP id a640c23a62f3a-b7d23b92012mr1014789266b.52.1765808276856;
        Mon, 15 Dec 2025 06:17:56 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa29eb48sm1444020266b.1.2025.12.15.06.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:56 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH v2 13/17] firmware: tee_bnxt: Make use of tee bus methods
Date: Mon, 15 Dec 2025 15:16:43 +0100
Message-ID: <96f7df595a96f631b40c2c0a6fcf8bf7217d02f4.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2314; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Kkjk2HQyXaBvr0FeLY8PHK1oOoMWNcJDWQq+WFZGpZA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhsfHXkwvq5lo/liy5xLt/2zfSDHM/HASEZs rSXC1P7uA6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYbAAKCRCPgPtYfRL+ TjIHCACKt2PBL1ggi18gXW89o2wjtHLVPQLHCVpHjtN5rjdFvrbEnb8GMhyPmXCkVmVoss7QFdW UbeQereVoPtirVXXeCZWy9g9T0WSKPbeURogL5yJ2CUFbRV2xnjlstiWQSVm8Kqzp+SWAZYvYR6 Jztwhm3a/vQfJOJNAs+QMLGr29GLfItZLW+6/mxmfWWm/PF5PYmA21k/UylJImDTGlrdDl7dqRS jWesv1pzELsMZ/EHQnDEoPByjLvWWtbbrLxTZeTrZ+rN3pJcjTYAsDtLb2/VHlwBg2B397iMbbw yyAwbQOxcIWjlvWNJA4Li96zLkxmhy9Rrt6Lw5ZiJ62bSLDC
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
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.52:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,gmail.com,broadcom.com];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[baylibre.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.52:from];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[46.5.122.62:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: ED5F94FEB4
X-Spamd-Bar: --
Message-ID-Hash: JP6R5QASNT2BXSCNXLOYQK2QMRFEO5EL
X-Message-ID-Hash: JP6R5QASNT2BXSCNXLOYQK2QMRFEO5EL
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, linux-mips@vger.kernel.org, netdev@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JP6R5QASNT2BXSCNXLOYQK2QMRFEO5EL/>
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
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvZmlybXdhcmUvYnJvYWRjb20vdGVlX2JueHRfZncuYyB8IDE2
ICsrKysrKystLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA5IGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9icm9hZGNvbS90ZWVf
Ym54dF9mdy5jIGIvZHJpdmVycy9maXJtd2FyZS9icm9hZGNvbS90ZWVfYm54dF9mdy5jDQppbmRl
eCBmYmRmMWFhOTdjODIuLmE3MDZjODRlYjJiNiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZmlybXdh
cmUvYnJvYWRjb20vdGVlX2JueHRfZncuYw0KKysrIGIvZHJpdmVycy9maXJtd2FyZS9icm9hZGNv
bS90ZWVfYm54dF9mdy5jDQpAQCAtMTgxLDkgKzE4MSw5IEBAIHN0YXRpYyBpbnQgb3B0ZWVfY3R4
X21hdGNoKHN0cnVjdCB0ZWVfaW9jdGxfdmVyc2lvbl9kYXRhICp2ZXIsIGNvbnN0IHZvaWQgKmRh
dGEpDQogCXJldHVybiAodmVyLT5pbXBsX2lkID09IFRFRV9JTVBMX0lEX09QVEVFKTsNCiB9DQog
DQotc3RhdGljIGludCB0ZWVfYm54dF9md19wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQorc3Rh
dGljIGludCB0ZWVfYm54dF9md19wcm9iZShzdHJ1Y3QgdGVlX2NsaWVudF9kZXZpY2UgKmJueHRf
ZGV2aWNlKQ0KIHsNCi0Jc3RydWN0IHRlZV9jbGllbnRfZGV2aWNlICpibnh0X2RldmljZSA9IHRv
X3RlZV9jbGllbnRfZGV2aWNlKGRldik7DQorCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZibnh0X2Rl
dmljZS0+ZGV2Ow0KIAlpbnQgcmV0LCBlcnIgPSAtRU5PREVWOw0KIAlzdHJ1Y3QgdGVlX2lvY3Rs
X29wZW5fc2Vzc2lvbl9hcmcgc2Vzc19hcmc7DQogCXN0cnVjdCB0ZWVfc2htICpmd19zaG1fcG9v
bDsNCkBAIC0yMzEsMTcgKzIzMSwxNSBAQCBzdGF0aWMgaW50IHRlZV9ibnh0X2Z3X3Byb2JlKHN0
cnVjdCBkZXZpY2UgKmRldikNCiAJcmV0dXJuIGVycjsNCiB9DQogDQotc3RhdGljIGludCB0ZWVf
Ym54dF9md19yZW1vdmUoc3RydWN0IGRldmljZSAqZGV2KQ0KK3N0YXRpYyB2b2lkIHRlZV9ibnh0
X2Z3X3JlbW92ZShzdHJ1Y3QgdGVlX2NsaWVudF9kZXZpY2UgKmJueHRfZGV2aWNlKQ0KIHsNCiAJ
dGVlX3NobV9mcmVlKHB2dF9kYXRhLmZ3X3NobV9wb29sKTsNCiAJdGVlX2NsaWVudF9jbG9zZV9z
ZXNzaW9uKHB2dF9kYXRhLmN0eCwgcHZ0X2RhdGEuc2Vzc2lvbl9pZCk7DQogCXRlZV9jbGllbnRf
Y2xvc2VfY29udGV4dChwdnRfZGF0YS5jdHgpOw0KIAlwdnRfZGF0YS5jdHggPSBOVUxMOw0KLQ0K
LQlyZXR1cm4gMDsNCiB9DQogDQotc3RhdGljIHZvaWQgdGVlX2JueHRfZndfc2h1dGRvd24oc3Ry
dWN0IGRldmljZSAqZGV2KQ0KK3N0YXRpYyB2b2lkIHRlZV9ibnh0X2Z3X3NodXRkb3duKHN0cnVj
dCB0ZWVfY2xpZW50X2RldmljZSAqYm54dF9kZXZpY2UpDQogew0KIAl0ZWVfc2htX2ZyZWUocHZ0
X2RhdGEuZndfc2htX3Bvb2wpOw0KIAl0ZWVfY2xpZW50X2Nsb3NlX3Nlc3Npb24ocHZ0X2RhdGEu
Y3R4LCBwdnRfZGF0YS5zZXNzaW9uX2lkKTsNCkBAIC0yNTgsMTIgKzI1NiwxMiBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IHRlZV9jbGllbnRfZGV2aWNlX2lkIHRlZV9ibnh0X2Z3X2lkX3RhYmxlW10g
PSB7DQogTU9EVUxFX0RFVklDRV9UQUJMRSh0ZWUsIHRlZV9ibnh0X2Z3X2lkX3RhYmxlKTsNCiAN
CiBzdGF0aWMgc3RydWN0IHRlZV9jbGllbnRfZHJpdmVyIHRlZV9ibnh0X2Z3X2RyaXZlciA9IHsN
CisJLnByb2JlCQk9IHRlZV9ibnh0X2Z3X3Byb2JlLA0KKwkucmVtb3ZlCQk9IHRlZV9ibnh0X2Z3
X3JlbW92ZSwNCisJLnNodXRkb3duCT0gdGVlX2JueHRfZndfc2h1dGRvd24sDQogCS5pZF90YWJs
ZQk9IHRlZV9ibnh0X2Z3X2lkX3RhYmxlLA0KIAkuZHJpdmVyCQk9IHsNCiAJCS5uYW1lCQk9IEtC
VUlMRF9NT0ROQU1FLA0KLQkJLnByb2JlCQk9IHRlZV9ibnh0X2Z3X3Byb2JlLA0KLQkJLnJlbW92
ZQkJPSB0ZWVfYm54dF9md19yZW1vdmUsDQotCQkuc2h1dGRvd24JPSB0ZWVfYm54dF9md19zaHV0
ZG93biwNCiAJfSwNCiB9Ow0KIA0KLS0gDQoyLjQ3LjMNCg0K
