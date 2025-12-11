Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E4DD4417D
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:02:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B6D4B4FEB0
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:02:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=3IQFr6ht;
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 41D4E5000A
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 17:16:10 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so3564115e9.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 09:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473369; x=1766078169; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tX/pvRZ03DwrZb4C0GHe6B+z8lS6Bu0suU9z+WmGCw=;
        b=3IQFr6ht3fM6/CZNKa9d9jV1lDPpl/7IxuCGJv6/VjdaV3mPIXMixL0nAIsYxEv8gH
         TeBq/0ewjMFrMtelIVi9GZwnInLZYUdHCrHpEVqE0DsrNdevGMYP+W43fdFlUfEQ5wsK
         HTexkNDq/0Sg/EeeMRN1tZotrsOpEXKYTNRXVYZYz/VNqC0yzyGTMWyNxuWrPPKEzArh
         Tss4/CZSuryEXuyIBC51d0Tw1RCPTPIqVgkgEoypls8JSp+dciixKVMEIrspuVDz7isO
         qtRVWNTNMQ/4gozDHes33EmB3s2oaU5DX5TUfBkDrcaMii+aCJA3K1l2oGB429Islcgl
         AFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473369; x=1766078169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8tX/pvRZ03DwrZb4C0GHe6B+z8lS6Bu0suU9z+WmGCw=;
        b=lhacRfaS++Ln+xoZg8dNwZ2XCTegWwkdvlXGkwGvG5GzN4eFF5MuTyIYzypp1V5Mtz
         aVTPSjvY/mKwtWA+U1jc8blBhtZOOs83z6tnyH5JTKZYVqg+WHE82NY+qisINFaN8S6r
         +8eu0F/qT7/makV7lVnE+PM4VehdTcaATJrOwTrBWAW1Ff/TlKLaIj1yBZwzjIEDtHYh
         OSIC6UyIIA9DJGPl690Kxou/qz+8Qlt15lk2Q3eF15AuetteG+iz1iExAdbZ16AWY77K
         BMpdP14IU67Sk6CdEWYJPT5KAPJjn84UVo4GlOZ9sKZKavuEVYvryvcqGZwHlJ1UijpK
         Nvnw==
X-Gm-Message-State: AOJu0YzX5u89VJrCoskpITFdJMNH//CZWw5Ue0wj9bRAbUevSZ1ojm2P
	2PzA1yiU/t7wiAivvmTL4VxQ7jZvuQM35694zcxhCZCmk3wNDt0etz5T1yG1KJbiRd4=
X-Gm-Gg: AY/fxX5SHWfIvtt3Q9mLAfmsS2FQFWbE780EAznyicYbEOYXL6xijEoch9kHZ4WpATh
	FacyQnb0WB3Vol/0Il/n6nw+YlHx/8+vCBrvJB73zGarvT661DKGagZzHcpe3GhktitLOHnyoBY
	RMeWtXU5V6Koufk3jZq70tcWPO7hDV7LvXYuOiZUzQ8pjmrx1MSC9HKMexFJmXOgoxtgwgTxCZs
	DlKShZXmBYLmR5vEpwcDzLxTY0EcEIiv7m4ZbhXITb7g3DaLELoYcPoVz1qcNAfK0ODV04aY/rs
	f4Pfb6X/evOAnkDLtTvWm9sAtvnKZH1YIKAv7mnFb+Ws/Df12A2XfJCL67Gr5+jJg0JkQZgv6G7
	f4f9k7viQOtEs0OcNh525gteTE/FmLIuME9PAEVHrzeuPZ/cZ3BKiRPKvCX2kP075hPIL+zT8b3
	tQclFCDVSDlfjzEGbmf/nV/iPb4RChvgdUVQ0TGhSn1TRtTvBvurFSLXkaMnZcdQjyPETZghWgM
	SY=
X-Google-Smtp-Source: AGHT+IHGBUOwE9r4ORaulvN3C5ZVCojqUo6qjWJCQQ7Y+7ElotvWRIvUrk2Iy3v9fIQm2AQbku9BvA==
X-Received: by 2002:a05:600c:8010:b0:479:3046:6bb3 with SMTP id 5b1f17b1804b1-47a837aca24mr61787215e9.23.1765473369183;
        Thu, 11 Dec 2025 09:16:09 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47a89f0e42asm44521885e9.14.2025.12.11.09.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:16:08 -0800 (PST)
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
Subject: [PATCH v1 14/17] KEYS: trusted: Migrate to use tee specific driver registration function
Date: Thu, 11 Dec 2025 18:15:08 +0100
Message-ID: <0b3ce259fa26e59ef24a91ca070e2b08feeede82.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=PWG1Uz/7pwDZMqUJE8wpnS6Sgs1oh93ryPafYte5lCg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvw4fJEaOX0vcpHk3eLvUdGT9H5CpTDKlptW8 lA5zTtov2yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8OAAKCRCPgPtYfRL+ Tus6B/46H6BzlY4ooZ66vBemZu+u9k40M56CS1npEuvxZzdqVdr5+yYBtvf0sFepZiA1kZLByHC qmvwOMfVSURaQxhSnUSW3sf5PogyKEeJGChX0Aet1HFsu5I0s3KtUZq9MwTR+bcWJnQOEU7xT1w fhU1DQ87m1Qu3KgVdq1fZKtzmUPAQHqXryaG1Onoy8LTkDRF3SQYO6h278bsvtBs38kRzaOcAvz hOgLGCS5wqtWh94/e0lQHwClfg0b+BQsNClTafeNu0B+HnvcDhTyHoEGqOQk0MWRf5Pa3laE0BV XoyAv8patZJKyEfoJDbzwDswrq0Vny5P+AXykut/8qQ3Ajgq
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.43:from];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_NA(0.00)[baylibre.com];
	ARC_NA(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.43:from];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 41D4E5000A
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: KET6CGBOYYVODC4YFD5MTVQMGJRHS7WT
X-Message-ID-Hash: KET6CGBOYYVODC4YFD5MTVQMGJRHS7WT
X-Mailman-Approved-At: Fri, 12 Dec 2025 10:57:12 +0000
CC: op-tee@lists.trustedfirmware.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KET6CGBOYYVODC4YFD5MTVQMGJRHS7WT/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

VGhlIHRlZSBzdWJzeXN0ZW0gcmVjZW50bHkgZ290IGEgc2V0IG9mIGRlZGljYXRlZCBmdW5jdGlv
bnMgdG8gcmVnaXN0ZXINCihhbmQgdW5yZWdpc3RlcikgYSB0ZWUgZHJpdmVyLiBNYWtlIHVzZSBv
ZiB0aGVtLiBUaGVzZSBjYXJlIGZvciBzZXR0aW5nIHRoZQ0KZHJpdmVyJ3MgYnVzIChzbyB0aGUg
ZXhwbGljaXQgYXNzaWdubWVudCBjYW4gYmUgZHJvcHBlZCkgYW5kIHRoZSBkcml2ZXINCm93bmVy
ICh3aGljaCBpcyBhbiBpbXByb3ZlbWVudCB0aGlzIGRyaXZlciBiZW5lZml0cyBmcm9tKS4NCg0K
U2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BiYXlsaWJy
ZS5jb20+DQotLS0NCiBzZWN1cml0eS9rZXlzL3RydXN0ZWQta2V5cy90cnVzdGVkX3RlZS5jIHwg
NSArKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9zZWN1cml0eS9rZXlzL3RydXN0ZWQta2V5cy90cnVzdGVkX3RlZS5j
IGIvc2VjdXJpdHkva2V5cy90cnVzdGVkLWtleXMvdHJ1c3RlZF90ZWUuYw0KaW5kZXggYWEzZDQ3
N2RlNmRiLi4zY2VhOWEzNzc5NTUgMTAwNjQ0DQotLS0gYS9zZWN1cml0eS9rZXlzL3RydXN0ZWQt
a2V5cy90cnVzdGVkX3RlZS5jDQorKysgYi9zZWN1cml0eS9rZXlzL3RydXN0ZWQta2V5cy90cnVz
dGVkX3RlZS5jDQpAQCAtMjY0LDcgKzI2NCw2IEBAIHN0YXRpYyBzdHJ1Y3QgdGVlX2NsaWVudF9k
cml2ZXIgdHJ1c3RlZF9rZXlfZHJpdmVyID0gew0KIAkuaWRfdGFibGUJPSB0cnVzdGVkX2tleV9p
ZF90YWJsZSwNCiAJLmRyaXZlcgkJPSB7DQogCQkubmFtZQkJPSBEUklWRVJfTkFNRSwNCi0JCS5i
dXMJCT0gJnRlZV9idXNfdHlwZSwNCiAJCS5wcm9iZQkJPSB0cnVzdGVkX2tleV9wcm9iZSwNCiAJ
CS5yZW1vdmUJCT0gdHJ1c3RlZF9rZXlfcmVtb3ZlLA0KIAl9LA0KQEAgLTI3MiwxMiArMjcxLDEy
IEBAIHN0YXRpYyBzdHJ1Y3QgdGVlX2NsaWVudF9kcml2ZXIgdHJ1c3RlZF9rZXlfZHJpdmVyID0g
ew0KIA0KIHN0YXRpYyBpbnQgdHJ1c3RlZF90ZWVfaW5pdCh2b2lkKQ0KIHsNCi0JcmV0dXJuIGRy
aXZlcl9yZWdpc3RlcigmdHJ1c3RlZF9rZXlfZHJpdmVyLmRyaXZlcik7DQorCXJldHVybiB0ZWVf
Y2xpZW50X2RyaXZlcl9yZWdpc3RlcigmdHJ1c3RlZF9rZXlfZHJpdmVyKTsNCiB9DQogDQogc3Rh
dGljIHZvaWQgdHJ1c3RlZF90ZWVfZXhpdCh2b2lkKQ0KIHsNCi0JZHJpdmVyX3VucmVnaXN0ZXIo
JnRydXN0ZWRfa2V5X2RyaXZlci5kcml2ZXIpOw0KKwl0ZWVfY2xpZW50X2RyaXZlcl91bnJlZ2lz
dGVyKCZ0cnVzdGVkX2tleV9kcml2ZXIpOw0KIH0NCiANCiBzdHJ1Y3QgdHJ1c3RlZF9rZXlfb3Bz
IHRydXN0ZWRfa2V5X3RlZV9vcHMgPSB7DQotLSANCjIuNDcuMw0KDQo=
