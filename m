Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35467D44166
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 10:58:21 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 87C814FE88
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 10:58:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=q9kd12cW;
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CF0B445451
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 17:15:56 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42e2b90ad22so165935f8f.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 09:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473356; x=1766078156; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoDz0g7RPOFum09gAkR6MAN5nJYo7w/Vlx1iJV+OcGM=;
        b=q9kd12cWMq08BJTR+J/paQfLs2/vOkfMSMha4X8utxroWbjEEIDujAfBMZjbz/uDNN
         0JvkC0XDCGtcsawhTuK0ig41/Z8/dIV1k8iAVQostWfjZdW2mDlmzgq2n6n1Jm/C9vZw
         NQbfpx//yy18fEuc0CM9GMbGXcm8TgvXIar5M3PPw/p3Lmmx83heggyBFeALFq4j87cM
         8AOUUmar8EpJx6VeWeQwyqpduu2yLymM/D78E27UzMtymCgLbmlqda00zRfQuA/uWMix
         rLgyloSql9S9M+31LCRtvgDM8TY8f9IpascCiCOIqp99gSUGZMc7Jl1G8rPZb3SsZFWN
         QSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473356; x=1766078156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JoDz0g7RPOFum09gAkR6MAN5nJYo7w/Vlx1iJV+OcGM=;
        b=FM3YVnrY1UlUCLVE6+7H//fobraD8elmTYW5fJH1d34mTRfu7B/VOJcyAQndl3o6Cs
         50ybRUdtfwW6PKHKy8XubQ7ue2ZYBPrbFr6N5dg88W/cJ3Umi0+0h58zlGtgB7BUdDCu
         2PWu6lGqmpPTyc3uh4lwuV8WiUW4eP+9oZxB+p4A11OvqeSBAiz8VkTL1QUoQ18T2E7r
         2MTwnkPQApzda+plRL6g2UaWoAZMol/rLQa51xLGjgr25mYzJ6cudPcjxFxzfQ3YyXaP
         v18fZq6VphiFgAEA404L3vhf7n/p/Pb5aHwcurSH1G2oyT6ifxltYlIsOcLaEqQm6c6D
         losA==
X-Forwarded-Encrypted: i=1; AJvYcCWEWN2Gba+daGtk9fczEbt/PLB3FQAWszxaYf7HOTT7xo3g8et0Q7zMn6k31JOkaarjHazyyf0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy3BTav0SvnSYRHr8NwAO4wYgyeBHDv85K3lPWfMzs0hksIWegZ
	GTepSmcgyNqMn8uBLGcS7dVudkLOnD5nYi6IX3jb7ACKH2JXe0FSwRcNQhF/T6B1m/g=
X-Gm-Gg: AY/fxX4yN1AKHnYhaguOATolDCLPwPayMzUVPPymYjppusjun8zftY7Hqqv1YcweSaL
	DjSvJxuKK7h3Ly9iS3Vfya7qKP7V522mhqcd67jlGk6prHwW9J8H5bBkggl9dhtFeNpuuHbEOAG
	efOefrghSSVxsOyEFD4dmj8pY5Dbp2RzducdI1ngFgn9zkAAN4IjYVMjD5r2nENWe9FOoX6Nnue
	FCVzjY59XWXnmV/jfYowPjG4RFUL7trtYnSu9XdW7oxsFSe/FjBBvN7DdcCp16RphvLj1+Syxq4
	UaQX5VFODjKKvyVI7JrrPpyFNdLcGwnLBinV6a0qFIn3wnS8mjTvVhvCXU5MaIg0WCiFTc7vUN9
	zhlZuNtjoNO1BAErUdrHL5sJAWFJn8pezu+7OOottiAtTUN2iDjFKhGBXtOAvb2EJX9k5lWXwod
	7SmZL3UzFdeOg8DB0h4Yb+qw9HqTkSg7BMYPrWKfAVT52tw9H+NQYidvbaEDGuRUB4t/F4i5JAO
	rg=
X-Google-Smtp-Source: AGHT+IFX5qkS45BdG6KrFISTn3JdM74C2f1uOGK7ovoJCi0e2RbWzgAqkhMepwXzD+6oAtSN/zVJ+g==
X-Received: by 2002:a5d:584d:0:b0:42b:5567:857f with SMTP id ffacd0b85a97d-42fa3b06460mr7996197f8f.50.1765473355683;
        Thu, 11 Dec 2025 09:15:55 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42fa8b8a941sm6801232f8f.34.2025.12.11.09.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:15:55 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v1 02/17] tee: Add probe, remove and shutdown bus callbacks to tee_client_driver
Date: Thu, 11 Dec 2025 18:14:56 +0100
Message-ID: <7f73b2ee784c0b78fa3bfee3aaa3b95f47041178.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=4197; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=c9YlOyDcWBkhTT0+VL5SCAt+Rn9uz/WnQRKclVZqJbo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvwYajd9lnTeUjp8JrSQ61m2kOr2I918qzpFH CQQdN5WOW+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8GAAKCRCPgPtYfRL+ TtqnB/0e0Ca02BcMczYkBj0OW13MuyK6WFiPs3pZVKv3Ke16TmDMPoDgqSqGLVv/Ux/i26e1yw/ ncuZFvjNEgvn07QlnvsZ67ym5blbk78GUUaC+WSEHDGMfSpS2DhBOfjCHeYdIpNdqJo3sWfmMqd gK1hAzuzjM7NnoQN4OZqCd3fZ2SyXd3qN8vpd9KkQesXGtz3T3fwa1PPy0BaNOJiGjKKFW7YeFO Czq2FSz1NUlf2qPMb+gCsKfql//YY662lUM45hGXe5RRNrj/wzT3kUtY7Eo+MaYP7fz4m1dbNvq QXF3sdbFE6Bw9SdkuT/WnhX1PQ8xs4+Mxg1xlEnwmPmUDxik
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.51:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.51:from];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	BLOCKLISTDE_FAIL(0.00)[209.85.221.51:query timed out,2003:f6:5f00:6608:b665:17f2:bd01:7279:query timed out];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CF0B445451
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 4M2NCBMV3CBDYRVOTUKWJHGOGEQEBTZH
X-Message-ID-Hash: 4M2NCBMV3CBDYRVOTUKWJHGOGEQEBTZH
X-Mailman-Approved-At: Fri, 12 Dec 2025 10:56:47 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4M2NCBMV3CBDYRVOTUKWJHGOGEQEBTZH/>
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
ZWVfY29yZS5jDQppbmRleCA1MTM3OWY3ZmM1ZDUuLjg5MTY0ZDM1ZmM1YyAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvdGVlL3RlZV9jb3JlLmMNCisrKyBiL2RyaXZlcnMvdGVlL3RlZV9jb3JlLmMNCkBA
IC0xMzk4LDE5ICsxMzk4LDg3IEBAIHN0YXRpYyBpbnQgdGVlX2NsaWVudF9kZXZpY2VfdWV2ZW50
KGNvbnN0IHN0cnVjdCBkZXZpY2UgKmRldiwNCiAJcmV0dXJuIGFkZF91ZXZlbnRfdmFyKGVudiwg
Ik1PREFMSUFTPXRlZTolcFViIiwgZGV2X2lkKTsNCiB9DQogDQorc3RhdGljIGludCB0ZWVfY2xp
ZW50X2RldmljZV9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQorew0KKwlzdHJ1Y3QgdGVlX2Ns
aWVudF9kZXZpY2UgKnRjZGV2PSB0b190ZWVfY2xpZW50X2RldmljZShkZXYpOw0KKwlzdHJ1Y3Qg
dGVlX2NsaWVudF9kcml2ZXIgKmRydiA9IHRvX3RlZV9jbGllbnRfZHJpdmVyKGRldi0+ZHJpdmVy
KTsNCisNCisJaWYgKGRydi0+cHJvYmUpDQorCQlyZXR1cm4gZHJ2LT5wcm9iZSh0Y2Rldik7DQor
CWVsc2UNCisJCXJldHVybiAwOw0KK30NCisNCitzdGF0aWMgdm9pZCB0ZWVfY2xpZW50X2Rldmlj
ZV9yZW1vdmUoc3RydWN0IGRldmljZSAqZGV2KQ0KK3sNCisJc3RydWN0IHRlZV9jbGllbnRfZGV2
aWNlICp0Y2Rldj0gdG9fdGVlX2NsaWVudF9kZXZpY2UoZGV2KTsNCisJc3RydWN0IHRlZV9jbGll
bnRfZHJpdmVyICpkcnYgPSB0b190ZWVfY2xpZW50X2RyaXZlcihkZXYtPmRyaXZlcik7DQorDQor
CWlmIChkcnYtPnJlbW92ZSkNCisJCWRydi0+cmVtb3ZlKHRjZGV2KTsNCit9DQorDQorc3RhdGlj
IHZvaWQgdGVlX2NsaWVudF9kZXZpY2Vfc2h1dGRvd24oc3RydWN0IGRldmljZSAqZGV2KQ0KK3sN
CisJc3RydWN0IHRlZV9jbGllbnRfZGV2aWNlICp0Y2Rldj0gdG9fdGVlX2NsaWVudF9kZXZpY2Uo
ZGV2KTsNCisJc3RydWN0IHRlZV9jbGllbnRfZHJpdmVyICpkcnYgPSB0b190ZWVfY2xpZW50X2Ry
aXZlcihkZXYtPmRyaXZlcik7DQorDQorCWlmIChkZXYtPmRyaXZlciAmJiBkcnYtPnJlbW92ZSkN
CisJCWRydi0+cmVtb3ZlKHRjZGV2KTsNCit9DQorDQogY29uc3Qgc3RydWN0IGJ1c190eXBlIHRl
ZV9idXNfdHlwZSA9IHsNCiAJLm5hbWUJCT0gInRlZSIsDQogCS5tYXRjaAkJPSB0ZWVfY2xpZW50
X2RldmljZV9tYXRjaCwNCiAJLnVldmVudAkJPSB0ZWVfY2xpZW50X2RldmljZV91ZXZlbnQsDQor
CS5wcm9iZQkJPSB0ZWVfY2xpZW50X2RldmljZV9wcm9iZSwNCisJLnJlbW92ZQkJPSB0ZWVfY2xp
ZW50X2RldmljZV9yZW1vdmUsDQorCS5zaHV0ZG93bgk9IHRlZV9jbGllbnRfZGV2aWNlX3NodXRk
b3duLA0KIH07DQogRVhQT1JUX1NZTUJPTF9HUEwodGVlX2J1c190eXBlKTsNCiANCitzdGF0aWMg
aW50IHRlZV9jbGllbnRfZGV2aWNlX3Byb2JlX2xlZ2FjeShzdHJ1Y3QgdGVlX2NsaWVudF9kZXZp
Y2UgKnRjZGV2KQ0KK3sNCisJc3RydWN0IGRldmljZSAqZGV2ID0gJnRjZGV2LT5kZXY7DQorCXN0
cnVjdCBkZXZpY2VfZHJpdmVyICpkcml2ZXIgPSBkZXYtPmRyaXZlcjsNCisNCisJcmV0dXJuIGRy
aXZlci0+cHJvYmUoZGV2KTsNCit9DQorDQorc3RhdGljIHZvaWQgdGVlX2NsaWVudF9kZXZpY2Vf
cmVtb3ZlX2xlZ2FjeShzdHJ1Y3QgdGVlX2NsaWVudF9kZXZpY2UgKnRjZGV2KQ0KK3sNCisJc3Ry
dWN0IGRldmljZSAqZGV2ID0gJnRjZGV2LT5kZXY7DQorCXN0cnVjdCBkZXZpY2VfZHJpdmVyICpk
cml2ZXIgPSBkZXYtPmRyaXZlcjsNCisNCisJZHJpdmVyLT5yZW1vdmUoZGV2KTsNCit9DQorDQor
c3RhdGljIHZvaWQgdGVlX2NsaWVudF9kZXZpY2Vfc2h1dGRvd25fbGVnYWN5KHN0cnVjdCB0ZWVf
Y2xpZW50X2RldmljZSAqdGNkZXYpDQorew0KKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmdGNkZXYt
PmRldjsNCisJc3RydWN0IGRldmljZV9kcml2ZXIgKmRyaXZlciA9IGRldi0+ZHJpdmVyOw0KKw0K
Kwlkcml2ZXItPnNodXRkb3duKGRldik7DQorfQ0KKw0KIGludCBfX3RlZV9jbGllbnRfZHJpdmVy
X3JlZ2lzdGVyKHN0cnVjdCB0ZWVfY2xpZW50X2RyaXZlciAqdGVlX2RyaXZlciwNCiAJCQkJIHN0
cnVjdCBtb2R1bGUgKm93bmVyKQ0KIHsNCiAJdGVlX2RyaXZlci0+ZHJpdmVyLm93bmVyID0gb3du
ZXI7DQogCXRlZV9kcml2ZXItPmRyaXZlci5idXMgPSAmdGVlX2J1c190eXBlOw0KIA0KKwkvKg0K
KwkgKiBEcml2ZXJzIHRoYXQgaGF2ZSBjYWxsYmFja3Mgc2V0IGZvciB0ZWVfZHJpdmVyLT5kcml2
ZXIgbmVlZCB1cGRhdGluZw0KKwkgKiB0byB1c2UgdGhlIGNhbGxiYWNrcyBpbiB0ZWVfZHJpdmVy
IGluc3RlYWQuIGRyaXZlcl9yZWdpc3RlcigpIHdhcm5zDQorCSAqIGFib3V0IHRoYXQsIHNvIG5v
IG5lZWQgdG8gd2FybiBoZXJlLCB0b28uDQorCSAqLw0KKwlpZiAoIXRlZV9kcml2ZXItPnByb2Jl
ICYmIHRlZV9kcml2ZXItPmRyaXZlci5wcm9iZSkNCisJCXRlZV9kcml2ZXItPnByb2JlID0gdGVl
X2NsaWVudF9kZXZpY2VfcHJvYmVfbGVnYWN5Ow0KKwlpZiAoIXRlZV9kcml2ZXItPnJlbW92ZSAm
JiB0ZWVfZHJpdmVyLT5kcml2ZXIucmVtb3ZlKQ0KKwkJdGVlX2RyaXZlci0+cmVtb3ZlPSB0ZWVf
Y2xpZW50X2RldmljZV9yZW1vdmVfbGVnYWN5Ow0KKwlpZiAoIXRlZV9kcml2ZXItPnNodXRkb3du
ICYmIHRlZV9kcml2ZXItPmRyaXZlci5wcm9iZSkNCisJCXRlZV9kcml2ZXItPnNodXRkb3duID0g
dGVlX2NsaWVudF9kZXZpY2Vfc2h1dGRvd25fbGVnYWN5Ow0KKw0KIAlyZXR1cm4gZHJpdmVyX3Jl
Z2lzdGVyKCZ0ZWVfZHJpdmVyLT5kcml2ZXIpOw0KIH0NCiBFWFBPUlRfU1lNQk9MX0dQTChfX3Rl
ZV9jbGllbnRfZHJpdmVyX3JlZ2lzdGVyKTsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Rl
ZV9kcnYuaCBiL2luY2x1ZGUvbGludXgvdGVlX2Rydi5oDQppbmRleCA4NTBjMDNiMmNkZWEuLmU1
NjFhMjZmNTM3YSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvdGVlX2Rydi5oDQorKysgYi9p
bmNsdWRlL2xpbnV4L3RlZV9kcnYuaA0KQEAgLTMxNSw2ICszMTUsOSBAQCBzdHJ1Y3QgdGVlX2Ns
aWVudF9kZXZpY2Ugew0KICAqIEBkcml2ZXI6CQlkcml2ZXIgc3RydWN0dXJlDQogICovDQogc3Ry
dWN0IHRlZV9jbGllbnRfZHJpdmVyIHsNCisJaW50ICgqcHJvYmUpKHN0cnVjdCB0ZWVfY2xpZW50
X2RldmljZSAqKTsNCisJdm9pZCAoKnJlbW92ZSkoc3RydWN0IHRlZV9jbGllbnRfZGV2aWNlICop
Ow0KKwl2b2lkICgqc2h1dGRvd24pKHN0cnVjdCB0ZWVfY2xpZW50X2RldmljZSAqKTsNCiAJY29u
c3Qgc3RydWN0IHRlZV9jbGllbnRfZGV2aWNlX2lkICppZF90YWJsZTsNCiAJc3RydWN0IGRldmlj
ZV9kcml2ZXIgZHJpdmVyOw0KIH07DQotLSANCjIuNDcuMw0KDQo=
