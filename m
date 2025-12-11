Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB809D44166
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 10:59:23 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2CE0A4FD58
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 10:59:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Gtf9Ht6c;
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0ED434FF75
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 17:15:59 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so3413865e9.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 09:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473358; x=1766078158; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sYBv0VIc9uiVK7zr2SScY7OQ8xufQ34jRkhj5KD4lc=;
        b=Gtf9Ht6cUn06RrqHilmW0rmnPiFxqfb7lmgJOb93FsZiZKBWxbNbixfibJjsaGS680
         mwON2VJMuBu5uw+/csqxB1wXUrvnZIHScWT2zJGq20FdIq8QGEgZzS+LXc2uJsK/6dt6
         8T7jsLcfNpuXnzsBDk4X/ULTUEpSajKlad37hKSA2WTkV7WRCJqDYt6mLbZPdvFKal2w
         owq2B5hPqQtLBSfe2OWFEQ3BHK5iedjM6WxkzGoO2NYjjCyNkIQqgbiwUBnqrHgJMjuR
         SufRgerb8I5Fmd/Z3hYytA/Ehu78i4Z0rQPEHTqHjKkSvqws/GO2LGI764xli8sQFpTk
         JE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473358; x=1766078158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2sYBv0VIc9uiVK7zr2SScY7OQ8xufQ34jRkhj5KD4lc=;
        b=kQSkLfqwM0nDKAAgMJ2Mfjtwjwy2AKbO7cJ2FssvWvbj8cxNESuXn8vBCBGN4iqqsM
         SpYi/NJEnmlQa2lBuavM44izOzMOKlWBf1cf/wc4dwy/Oda8bKS63+A8zf83RKi2EL78
         2Nba/VH4BkQqXC7qw5hN4EiBoFFdhvwsgIpEVZKGETHmt2f1llhKWG3FsTh4fuWHMh8O
         lhrojzrZW5TnXTv9JOPczeailgnKg4xgbNpD6u7Fykab4+yOJPcrE64TxLlpQ7oEMlWd
         ZpoN750Lk0vTpDfWZDXvN3cG2bDrqxczUm+NIPKb3txEP1ae0Xnl8lWwrEiWlBRFbL1k
         vSKQ==
X-Gm-Message-State: AOJu0YxA+7QwYW8KdEMxAH1AwQRiNLIBaECnxFUohQAoL/2rUfIMRUDy
	EYeTjZXxvhvwqLH56hgzSOEnOTfzY1IM/MFbk5cOpidFl3GQpuJwrlcCif/l97UckSw=
X-Gm-Gg: AY/fxX5dlKTihEuuk4Vv+RUdbDEEKnrElmGPZMqTI8O04eqy2bULdctleMa/dCfYtE3
	R9mqi6Wks4G04k/Zr/Ct+L/9UmY8b8JORAHO2z+cN3aTmJ7h8P4pCRFZHnr19SpKF/T1kxGKq+h
	3jr3LUuE54IBcV165r0uYgDfZpiD7CCi1huPEdBQj0G+iSLM1dAdVC2hmBTJAdk+1Nrs5Gp3CaJ
	7aRBoHGrTNGYbsuyZaxS0aiRbaoYmwg31TJ6+SbWYnJ/horNIwCAlMLLON6HzLhv03QteR6OoBC
	Y8j+yzVfT7aLHA/PABSG5iksPqW7bCAEjC7d7IHz8crJ/b79cr4iepty7dBDFU5jpNRV0A7z1Ic
	O57J4Iqglqz/hRcVYgNtC0lnFBtgZkEsRKZF0+bvmjDJMocA1nmxl6637EucRh36SVHWAG2EzTg
	OvMt2rbwlI0wLkr+cAg/vebsKY6T2xipYljUg5nQ7SQa581/sj+oC3UmhBZ//B4wlT9jUPSOoOa
	28=
X-Google-Smtp-Source: AGHT+IGF1uSM01yvW8d2TIvQK6LFiBzRrZVRvLXXlEpWqmt343Ufg3Z/zBmzXdNt3aJjfGwNiJhuTg==
X-Received: by 2002:a05:6000:4010:b0:42b:3978:157a with SMTP id ffacd0b85a97d-42fa3afe913mr8449237f8f.39.1765473357944;
        Thu, 11 Dec 2025 09:15:57 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42fa8b8601csm7593114f8f.22.2025.12.11.09.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:15:57 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH v1 04/17] hwrng: optee - Make use of module_tee_client_driver()
Date: Thu, 11 Dec 2025 18:14:58 +0100
Message-ID: <a2560b5a16c01dc1f63437ce0d60b3ee9c7cb3b8.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=ED4QDS/p5ezOJu9uewMwjvvUOpx4P5cPN2q3KMWraJk=; b=owGbwMvMwMXY3/A7olbonx/jabUkhkyrP7KF1stD5hcvn3powhP5/7MvcLiIFF7SWuTDpJSzc /eHO6JHOhmNWRgYuRhkxRRZ7BvXZFpVyUV2rv13GWYQKxPIFAYuTgGYSMx29v9FwWuOs71I5nqu zmoe1RIq1nFZ7ejRsCy9NXscWbR2XpUws+Hlsz25wu1CQILcllxh+3c77n/y/nc9Kpyx86AQ15+ XBV+5+tOmeHamRL1ke2K5govz1RU/rSdqd93lS6x6v/y692p72jxN0asM+/6nTnSoCDpjxXrukO Y+QfOw2ylu5ur635IjjLYZzzxW57VVyUHq2NrkfcdDTu/6lRGmXRzI8lRli3CHTeyaWdwft2tGb bvK89DmqPUd9lPM03T73New+71p+bqmNEu4N5OtxtLXb3J3g6Vkiz1nh5LK6hqDp35/JXzcg+V/ ez80OeqTJNSuWCjMeeIY63tB120PLJps9A+ESm8Vzq8EAA==
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.42:from];
	DMARC_NA(0.00)[baylibre.com];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.42:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	BLOCKLISTDE_FAIL(0.00)[2003:f6:5f00:6608:b665:17f2:bd01:7279:query timed out,209.85.128.42:query timed out];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0ED434FF75
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: QS6FYY6WZ6UOAP42GL4M476WUGD6BNKK
X-Message-ID-Hash: QS6FYY6WZ6UOAP42GL4M476WUGD6BNKK
X-Mailman-Approved-At: Fri, 12 Dec 2025 10:56:47 +0000
CC: op-tee@lists.trustedfirmware.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QS6FYY6WZ6UOAP42GL4M476WUGD6BNKK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

UmVkdWNlIGJvaWxlcnBsYXRlIGJ5IHVzaW5nIHRoZSBuZXdseSBpbnRyb2R1Y2VkIG1vZHVsZV90
ZWVfY2xpZW50X2RyaXZlcigpLg0KVGhhdCB0YWtlcyBjYXJlIG9mIGFzc2lnbmluZyB0aGUgZHJp
dmVyJ3MgYnVzLCBzbyB0aGUgZXhwbGljaXQgYXNzaWduaW5nDQppbiB0aGlzIGRyaXZlciBjYW4g
YmUgZHJvcHBlZC4NCg0KU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5l
LWtvZW5pZ0BiYXlsaWJyZS5jb20+DQotLS0NCiBkcml2ZXJzL2NoYXIvaHdfcmFuZG9tL29wdGVl
LXJuZy5jIHwgMTQgKy0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL2h3X3JhbmRv
bS9vcHRlZS1ybmcuYyBiL2RyaXZlcnMvY2hhci9od19yYW5kb20vb3B0ZWUtcm5nLmMNCmluZGV4
IDk2YjVkNTQ2ZDEzNi4uNmVlNzQ4YzBjZjU3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jaGFyL2h3
X3JhbmRvbS9vcHRlZS1ybmcuYw0KKysrIGIvZHJpdmVycy9jaGFyL2h3X3JhbmRvbS9vcHRlZS1y
bmcuYw0KQEAgLTI4MSwyNCArMjgxLDEyIEBAIHN0YXRpYyBzdHJ1Y3QgdGVlX2NsaWVudF9kcml2
ZXIgb3B0ZWVfcm5nX2RyaXZlciA9IHsNCiAJLmlkX3RhYmxlCT0gb3B0ZWVfcm5nX2lkX3RhYmxl
LA0KIAkuZHJpdmVyCQk9IHsNCiAJCS5uYW1lCQk9IERSSVZFUl9OQU1FLA0KLQkJLmJ1cwkJPSAm
dGVlX2J1c190eXBlLA0KIAkJLnByb2JlCQk9IG9wdGVlX3JuZ19wcm9iZSwNCiAJCS5yZW1vdmUJ
CT0gb3B0ZWVfcm5nX3JlbW92ZSwNCiAJfSwNCiB9Ow0KIA0KLXN0YXRpYyBpbnQgX19pbml0IG9w
dGVlX3JuZ19tb2RfaW5pdCh2b2lkKQ0KLXsNCi0JcmV0dXJuIGRyaXZlcl9yZWdpc3Rlcigmb3B0
ZWVfcm5nX2RyaXZlci5kcml2ZXIpOw0KLX0NCi0NCi1zdGF0aWMgdm9pZCBfX2V4aXQgb3B0ZWVf
cm5nX21vZF9leGl0KHZvaWQpDQotew0KLQlkcml2ZXJfdW5yZWdpc3Rlcigmb3B0ZWVfcm5nX2Ry
aXZlci5kcml2ZXIpOw0KLX0NCi0NCi1tb2R1bGVfaW5pdChvcHRlZV9ybmdfbW9kX2luaXQpOw0K
LW1vZHVsZV9leGl0KG9wdGVlX3JuZ19tb2RfZXhpdCk7DQorbW9kdWxlX3RlZV9jbGllbnRfZHJp
dmVyKG9wdGVlX3JuZ19kcml2ZXIpOw0KIA0KIE1PRFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsNCiBN
T0RVTEVfQVVUSE9SKCJTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQGxpbmFyby5vcmc+Iik7DQotLSAN
CjIuNDcuMw0KDQo=
