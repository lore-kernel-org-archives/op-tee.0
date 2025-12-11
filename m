Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF378D4417C
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:05:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1A35C4FD67
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:05:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=vKeNtE83;
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 15DA2431FB
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 17:16:08 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a1c28778so4038335e9.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 09:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473367; x=1766078167; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diZjdouzEEhILOHSiCyNRKR9P2lTi1L2KPZWsItgxqs=;
        b=vKeNtE83VKQCjXWLwaotnWJlIyveBdWRAVJx6RuDMUcVTSzQO+Q0UhZhm5sGqdsOm5
         38uO4qYCXMjbGjb7VblqsIXa8yySjk3kxUrP8Mn6Kneu9Y09GhqBjvSKmoG10EDPm3H/
         OFlIJKDodt5NHa5+UYh64IccBSdfsOkVuH+eQCIoEsHCwguR4b55xSRqf2oArCmLAj6f
         W5zR9E1uyYZkxto931VkJWBXnY7MkhncSuxh8nCmq2/JDMxIqFuCLXQonfaqZUw4jOkM
         3jP4NZzTke1fzqGJAoPzV7bnMXixAE5z85kt/idCLWTaAWU82edj/1mbu7SIJdw4tMSI
         xXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473367; x=1766078167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=diZjdouzEEhILOHSiCyNRKR9P2lTi1L2KPZWsItgxqs=;
        b=kPEjyxRegMz22H+F8qBJG990JTI+JOnNAbDoUzkmYkdL1svH0i924EfjvImrw2+gWV
         szXh01Hk8g8q52YMuJ7NcKb2q2Omr+UWcEUY1tNUP3bzwQoReTLU3BOqW+dkJ2NoJ2La
         fWMigm9XqZgR4XXnQD2M53wvaSTfYljD23fyY7RpwTqgVEU1VMYp3qVcYV5Ikr01QAKC
         Jwvi5LUgzxrcz1VDseVSjOVnAr7LNIxDHX/DM5lRH8CwG9hOuszUC67s72SuZz/c0lN+
         v/d4OWV5AQBw35EXg/zSD3Tq8+txTreF041nGuOOgD9ubDVpUogT+4pfZMJOWtYxsra/
         7rmw==
X-Forwarded-Encrypted: i=1; AJvYcCVEuiJA4EHC2TJzmiTpWrU7JTyhEF4PTshMGknC2TjVLiHzIailmD11kkLVpK+iZr0Of49Sa/c=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yzs1HUKN+NMikSC2Vzl4pvBietnKzBRqMhvDrSpejQGqCKkOk2t
	tr9YJMLYigKZWk1QmwtLlIDJoJLD/AdryqFourIWCHRm039CbyH5IPQmTaJn+MtK2Zk=
X-Gm-Gg: AY/fxX5IzK+TdWZiX18F+aY6VHJsOYTkarMpR9sYh2ZUxfeVdZVDC6fY+/WTHB29zV6
	JBPgu1T92Z13R1i03g78QOJTjjs9UlztMd3vO0qGHscdHHFEIBH0G9RFL7KVXIZ7OnA37caH1tg
	gJZWRTNxsgLQ0KYlyMvJz+hB03cj3E4GlwQBSAfE01NXnml3tMcoaa5gYJTUYywd6LQIxQdZpZz
	PiMFz0N9XmayFzQcJEIwrGMXj7yo72BaZDWnAn1WG0qZrBGrbARz7dZlOM8xsz2r3q8huObP4n+
	CsZ3/MioZkZCZtqsye3P0oBCMkrwbCS+NV3I4dXEt45Me3FWuYquQSttVh0vPz4q6srh11de4Ko
	46gkhjE1wLLhqyFjAxDdbHaDSfY0vNqnmpNs5XSbbWX1KYYCwfMWMdOz1fk80fwNvMXoMLKaVbg
	j7sw7vyJWgoNzhzkW7c06LLCVOZhHy2yTgyuIrWNhFHpxRvZnb72rx3/8pLRgH2LW1zscrh3ie+
	do=
X-Google-Smtp-Source: AGHT+IGUKWVSCHYwBEoDyb8aKAI3xda4j5uLNgFsDdq/ww+IXbbby6vKzmjBu3oTuW9ZdKJm7c1h5Q==
X-Received: by 2002:a05:600c:548f:b0:477:b0b9:3131 with SMTP id 5b1f17b1804b1-47a83745633mr73090605e9.8.1765473367020;
        Thu, 11 Dec 2025 09:16:07 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47a89d8e680sm16759715e9.6.2025.12.11.09.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:16:06 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: [PATCH v1 12/17] firmware: tee_bnxt: Make use of module_tee_client_driver()
Date: Thu, 11 Dec 2025 18:15:06 +0100
Message-ID: <5b520fd96f8b385acc280226f548913c9ee98011.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1383; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=u+iIVeAYKLIIY8APv+qwbM4v5dD7Dwi5f/EPantu/m8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvwzZJpnWSisd7DkoPNb7IKu3CNNzmY0kgG26 G88eoSnRsqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8MwAKCRCPgPtYfRL+ Tgg/CACLTMdXNNR7oub78YhSrxPLhhHLys5JO5AfQdc7fc3upwrr/QfvoJ9HBdditXtvbVcJ/oY g/aKUVLH+ObNA20u8STng/Jqr6WmHu3+GJrzaYryu3q8tTvwVJlR7W4K3bCvLeoJlGWghCd0XUd FP0J12bY4/zvrbxOdPrNLXyt+33F/T7KeaRzpGa/tG++NAAEJ9uIRD8FtHdDD93eua0b0/k3H5M oqYEsIJgtT+71HZ99ufbhcjvi/oJ7BIiTodO2UafKakUtFAHlILcJl/OmOUiWWSqY/GlzMbBL8t gI1at+MmI2xPdyew1CWuPWaSSZyKwMElpp8S1sao/LcW0gHv
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.19 / 15.00];
	BAYES_HAM(-2.99)[99.97%];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_NA(0.00)[baylibre.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.47:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	BLOCKLISTDE_FAIL(0.00)[2003:f6:5f00:6608:b665:17f2:bd01:7279:server fail,209.85.128.47:query timed out];
	FREEMAIL_TO(0.00)[linaro.org,broadcom.com,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.47:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 15DA2431FB
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: XSOMPTBHW5BMFPFS665J2YXIVA7W2NKQ
X-Message-ID-Hash: XSOMPTBHW5BMFPFS665J2YXIVA7W2NKQ
X-Mailman-Approved-At: Fri, 12 Dec 2025 10:57:13 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XSOMPTBHW5BMFPFS665J2YXIVA7W2NKQ/>
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
LWtvZW5pZ0BiYXlsaWJyZS5jb20+DQotLS0NCiBkcml2ZXJzL2Zpcm13YXJlL2Jyb2FkY29tL3Rl
ZV9ibnh0X2Z3LmMgfCAxNCArLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMTMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJl
L2Jyb2FkY29tL3RlZV9ibnh0X2Z3LmMgYi9kcml2ZXJzL2Zpcm13YXJlL2Jyb2FkY29tL3RlZV9i
bnh0X2Z3LmMNCmluZGV4IDQwZTMxODNhM2QxMS4uZmJkZjFhYTk3YzgyIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9maXJtd2FyZS9icm9hZGNvbS90ZWVfYm54dF9mdy5jDQorKysgYi9kcml2ZXJzL2Zp
cm13YXJlL2Jyb2FkY29tL3RlZV9ibnh0X2Z3LmMNCkBAIC0yNjEsMjUgKzI2MSwxMyBAQCBzdGF0
aWMgc3RydWN0IHRlZV9jbGllbnRfZHJpdmVyIHRlZV9ibnh0X2Z3X2RyaXZlciA9IHsNCiAJLmlk
X3RhYmxlCT0gdGVlX2JueHRfZndfaWRfdGFibGUsDQogCS5kcml2ZXIJCT0gew0KIAkJLm5hbWUJ
CT0gS0JVSUxEX01PRE5BTUUsDQotCQkuYnVzCQk9ICZ0ZWVfYnVzX3R5cGUsDQogCQkucHJvYmUJ
CT0gdGVlX2JueHRfZndfcHJvYmUsDQogCQkucmVtb3ZlCQk9IHRlZV9ibnh0X2Z3X3JlbW92ZSwN
CiAJCS5zaHV0ZG93bgk9IHRlZV9ibnh0X2Z3X3NodXRkb3duLA0KIAl9LA0KIH07DQogDQotc3Rh
dGljIGludCBfX2luaXQgdGVlX2JueHRfZndfbW9kX2luaXQodm9pZCkNCi17DQotCXJldHVybiBk
cml2ZXJfcmVnaXN0ZXIoJnRlZV9ibnh0X2Z3X2RyaXZlci5kcml2ZXIpOw0KLX0NCi0NCi1zdGF0
aWMgdm9pZCBfX2V4aXQgdGVlX2JueHRfZndfbW9kX2V4aXQodm9pZCkNCi17DQotCWRyaXZlcl91
bnJlZ2lzdGVyKCZ0ZWVfYm54dF9md19kcml2ZXIuZHJpdmVyKTsNCi19DQotDQotbW9kdWxlX2lu
aXQodGVlX2JueHRfZndfbW9kX2luaXQpOw0KLW1vZHVsZV9leGl0KHRlZV9ibnh0X2Z3X21vZF9l
eGl0KTsNCittb2R1bGVfdGVlX2NsaWVudF9kcml2ZXIodGVlX2JueHRfZndfZHJpdmVyKTsNCiAN
CiBNT0RVTEVfQVVUSE9SKCJWaWthcyBHdXB0YSA8dmlrYXMuZ3VwdGFAYnJvYWRjb20uY29tPiIp
Ow0KIE1PRFVMRV9ERVNDUklQVElPTigiQnJvYWRjb20gYm54dCBmaXJtd2FyZSBtYW5hZ2VyIik7
DQotLSANCjIuNDcuMw0KDQo=
