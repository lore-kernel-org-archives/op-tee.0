Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90907D4417C
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:03:39 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DE42C4FD32
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:03:38 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=QDJVtNL8;
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2093A45451
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 17:16:09 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477aa218f20so2918735e9.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 09:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473368; x=1766078168; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5Ml4HJmxurjzbFHuGXuWnrdRmEuv/7EaCb1T3xZqb4=;
        b=QDJVtNL8loVnYXfYnwpEJvQYWq5YS7U2qF7wv7z1mhLiap3euMwxNS6U+T3AFEicKu
         u1rxMOilQL9MtotD6P5cq8Y7VfJGpJsQBiKdaxkjaLJyFFU9H2xOgo8ut246c3yRpN61
         bOYdG4upRfcu7C87wosd7EME0eK2Uy1EGlgL/M6zMlkm1zJxL71mdVRPf4jgO1jXHEwr
         2is1eygM+S+R8MENZi+D8nDai1+4eWMboMJ4iY9bNOFeES7ygTJ/yJC1OVyZs2uKO3Ul
         3UGLFKzqUe3RqchZWxBxGOwIzH6VaxV3AOC19xlKlLcs7eTgQkyCEL6FtfovHVTPKvQ+
         GkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473368; x=1766078168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s5Ml4HJmxurjzbFHuGXuWnrdRmEuv/7EaCb1T3xZqb4=;
        b=OaoJ5sw6dC9auNZTC2ZNTJGrep9AzIkYkmaGbqV3TZ9O+LDjqoav/Xhh2T01ks41mm
         0DVbIBzofr0+eDL4BoUyluZ/2IJ+4/2EQK3PULg+dorsNL2CLqiv88xPpky2Bshk87+p
         mlQSRFbdfkRGmBgF3GAD4JIe4/ZXkVTgyLL3558/XcVTYJ4UnxpY8dV/DhzEmG9uSjrH
         yJ1NHjzxqmTs+gVXv/a1OFbf+w6kofXvS0EUFNhRWEhrTxxSGNTJ/bJ0Ly6TgGwmyOf1
         5G/8btXLdu1Va/WlLdlo3RG21+tlCi8nMOphlgsE6wAhSsd3bzyYTJZYfd/n3EXrMw3S
         1Mbw==
X-Forwarded-Encrypted: i=1; AJvYcCU4KIn4gbsOjBGeUIjWoqXfZdtv+nDhQoWDRPJKHH8M4EvLuaoiNEK4IE5Hx8PaBJruh5bKjmw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwghBBTalYGQmVcsxOQ/MMklzKy+D9bzwmJUcxbQXM40eEuWr04
	A6DrauvCZZSqSOF1Jt2d7RoMz0O5PmOm6/57b4SY1GGc8EuBNmqWU9Bgn1xWgpPQS5g=
X-Gm-Gg: AY/fxX7bB3Wj4SDd8wyAruPYkp/IKuHazkvv4EpruSpuGIL0cnGCOpm938sCiHUASVh
	oQ2qgIzHI0yDOY5ggpKEeMrIPmYhbjp9pu1QWxvJ6w4Y/FyE6K1vcEl3z5gaZp57IdviU4Wlr/c
	gh8wAfXFXGnujkt6s1RKl3ffogf98+99Vd7KuM+rffq5s7sgB+vYhw9T5IvXf7LXiKSsx9DVg2Z
	sbCGh01cfXVTglE/AtdGlQoYbqzk14Kya17fVbjgOLaSoQvVonFykHJIVhQEECa7AnAuU2523NI
	DnNSiQFyVum/pEeyWRC1y1wjzvWKYwTcSCGd9sSYm3P1apEPNvX73o5p4TYSlxjA6FLHMOOHKoA
	/Dnl9ziz9UIW4InTFQ+qfsauGhOJwsezlKH7OnEKfG5l0Tmedrvybk8KkBDyX/8UAQFLNd7xRE/
	m94QecIlmPDJq6UeFmgeVMuh0hGoiZygufDBv2R6CLIsMZJwN4v5U+43YNYy2dbcqFMk6FVAagy
	4A=
X-Google-Smtp-Source: AGHT+IE0Pak8/lbklEkRDCW8Y7zvjMkJReE6ZBMN8ZhmPk/MHipynV8W1+LPXu/33++KhGMjio+QMA==
X-Received: by 2002:a05:600c:4e49:b0:477:7c7d:d9b7 with SMTP id 5b1f17b1804b1-47a837a27d0mr82898065e9.33.1765473368108;
        Thu, 11 Dec 2025 09:16:08 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47a89f1e947sm52522015e9.3.2025.12.11.09.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:16:07 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: [PATCH v1 13/17] firmware: tee_bnxt: Make use of tee bus methods
Date: Thu, 11 Dec 2025 18:15:07 +0100
Message-ID: <f0b513d92355a53d30d8fdfcbbf7250457ec470e.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2259; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=/zcdGCyO/zJVJHXiHKgniHKKW+1n+is3abvzUXVsx+4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvw1dE1CQuBYvGVTWVxDbTjDXphCrVIig97hx yKXj9t/eKmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8NQAKCRCPgPtYfRL+ TheQB/4y6MUCe6HoDloGZNlxErv3xbN/7CcKgAqBSZLsIY2AnM58rwFoeQpZtwcQFoh5vJPSjgf JBd0iBFOoJIXWK17LWD7nmG917NzAWX+Wu/btEbP3SY6iMZUDMVV4bJetR0Jc6BsXVSSDctjtvK Wttn4wjRwmSXr37rfytMHye+tBx1MRouulCVZmRT/nlyVKM5exWD/kri89uXya5zgLcg5nCOtv1 YLdPhUPsb+e4eMZCwwGm2Fs9BsRAHgMzTEkvtTFdkMrYQVEW56gsHqQVr1JTTMZIqzxahoq4XxO y42vX36v0uM2lxdFmFJgCeRVpXKcZvCeC4wvz6BzZgdB5Mh7
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.44:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	BLOCKLISTDE_FAIL(0.00)[2003:f6:5f00:6608:b665:17f2:bd01:7279:server fail,209.85.128.44:server fail];
	FREEMAIL_TO(0.00)[linaro.org,broadcom.com,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.128.44:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2093A45451
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: YQYC3CJBBUIN23DQB5YLPSDSCYDNXYEE
X-Message-ID-Hash: YQYC3CJBBUIN23DQB5YLPSDSCYDNXYEE
X-Mailman-Approved-At: Fri, 12 Dec 2025 10:57:12 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YQYC3CJBBUIN23DQB5YLPSDSCYDNXYEE/>
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
cmUuY29tPg0KLS0tDQogZHJpdmVycy9maXJtd2FyZS9icm9hZGNvbS90ZWVfYm54dF9mdy5jIHwg
MTYgKysrKysrKy0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDkg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2Jyb2FkY29tL3Rl
ZV9ibnh0X2Z3LmMgYi9kcml2ZXJzL2Zpcm13YXJlL2Jyb2FkY29tL3RlZV9ibnh0X2Z3LmMNCmlu
ZGV4IGZiZGYxYWE5N2M4Mi4uYTcwNmM4NGViMmI2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9maXJt
d2FyZS9icm9hZGNvbS90ZWVfYm54dF9mdy5jDQorKysgYi9kcml2ZXJzL2Zpcm13YXJlL2Jyb2Fk
Y29tL3RlZV9ibnh0X2Z3LmMNCkBAIC0xODEsOSArMTgxLDkgQEAgc3RhdGljIGludCBvcHRlZV9j
dHhfbWF0Y2goc3RydWN0IHRlZV9pb2N0bF92ZXJzaW9uX2RhdGEgKnZlciwgY29uc3Qgdm9pZCAq
ZGF0YSkNCiAJcmV0dXJuICh2ZXItPmltcGxfaWQgPT0gVEVFX0lNUExfSURfT1BURUUpOw0KIH0N
CiANCi1zdGF0aWMgaW50IHRlZV9ibnh0X2Z3X3Byb2JlKHN0cnVjdCBkZXZpY2UgKmRldikNCitz
dGF0aWMgaW50IHRlZV9ibnh0X2Z3X3Byb2JlKHN0cnVjdCB0ZWVfY2xpZW50X2RldmljZSAqYm54
dF9kZXZpY2UpDQogew0KLQlzdHJ1Y3QgdGVlX2NsaWVudF9kZXZpY2UgKmJueHRfZGV2aWNlID0g
dG9fdGVlX2NsaWVudF9kZXZpY2UoZGV2KTsNCisJc3RydWN0IGRldmljZSAqZGV2ID0gJmJueHRf
ZGV2aWNlLT5kZXY7DQogCWludCByZXQsIGVyciA9IC1FTk9ERVY7DQogCXN0cnVjdCB0ZWVfaW9j
dGxfb3Blbl9zZXNzaW9uX2FyZyBzZXNzX2FyZzsNCiAJc3RydWN0IHRlZV9zaG0gKmZ3X3NobV9w
b29sOw0KQEAgLTIzMSwxNyArMjMxLDE1IEBAIHN0YXRpYyBpbnQgdGVlX2JueHRfZndfcHJvYmUo
c3RydWN0IGRldmljZSAqZGV2KQ0KIAlyZXR1cm4gZXJyOw0KIH0NCiANCi1zdGF0aWMgaW50IHRl
ZV9ibnh0X2Z3X3JlbW92ZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQorc3RhdGljIHZvaWQgdGVlX2Ju
eHRfZndfcmVtb3ZlKHN0cnVjdCB0ZWVfY2xpZW50X2RldmljZSAqYm54dF9kZXZpY2UpDQogew0K
IAl0ZWVfc2htX2ZyZWUocHZ0X2RhdGEuZndfc2htX3Bvb2wpOw0KIAl0ZWVfY2xpZW50X2Nsb3Nl
X3Nlc3Npb24ocHZ0X2RhdGEuY3R4LCBwdnRfZGF0YS5zZXNzaW9uX2lkKTsNCiAJdGVlX2NsaWVu
dF9jbG9zZV9jb250ZXh0KHB2dF9kYXRhLmN0eCk7DQogCXB2dF9kYXRhLmN0eCA9IE5VTEw7DQot
DQotCXJldHVybiAwOw0KIH0NCiANCi1zdGF0aWMgdm9pZCB0ZWVfYm54dF9md19zaHV0ZG93bihz
dHJ1Y3QgZGV2aWNlICpkZXYpDQorc3RhdGljIHZvaWQgdGVlX2JueHRfZndfc2h1dGRvd24oc3Ry
dWN0IHRlZV9jbGllbnRfZGV2aWNlICpibnh0X2RldmljZSkNCiB7DQogCXRlZV9zaG1fZnJlZShw
dnRfZGF0YS5md19zaG1fcG9vbCk7DQogCXRlZV9jbGllbnRfY2xvc2Vfc2Vzc2lvbihwdnRfZGF0
YS5jdHgsIHB2dF9kYXRhLnNlc3Npb25faWQpOw0KQEAgLTI1OCwxMiArMjU2LDEyIEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgdGVlX2NsaWVudF9kZXZpY2VfaWQgdGVlX2JueHRfZndfaWRfdGFibGVb
XSA9IHsNCiBNT0RVTEVfREVWSUNFX1RBQkxFKHRlZSwgdGVlX2JueHRfZndfaWRfdGFibGUpOw0K
IA0KIHN0YXRpYyBzdHJ1Y3QgdGVlX2NsaWVudF9kcml2ZXIgdGVlX2JueHRfZndfZHJpdmVyID0g
ew0KKwkucHJvYmUJCT0gdGVlX2JueHRfZndfcHJvYmUsDQorCS5yZW1vdmUJCT0gdGVlX2JueHRf
ZndfcmVtb3ZlLA0KKwkuc2h1dGRvd24JPSB0ZWVfYm54dF9md19zaHV0ZG93biwNCiAJLmlkX3Rh
YmxlCT0gdGVlX2JueHRfZndfaWRfdGFibGUsDQogCS5kcml2ZXIJCT0gew0KIAkJLm5hbWUJCT0g
S0JVSUxEX01PRE5BTUUsDQotCQkucHJvYmUJCT0gdGVlX2JueHRfZndfcHJvYmUsDQotCQkucmVt
b3ZlCQk9IHRlZV9ibnh0X2Z3X3JlbW92ZSwNCi0JCS5zaHV0ZG93bgk9IHRlZV9ibnh0X2Z3X3No
dXRkb3duLA0KIAl9LA0KIH07DQogDQotLSANCjIuNDcuMw0KDQo=
