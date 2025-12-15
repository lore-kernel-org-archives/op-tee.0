Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221CDD5B16E
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:22:12 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6E8384FF29
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:22:11 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=sYbJxTfL;
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 22A5B4FE9C
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 14:17:45 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b736ffc531fso716462766b.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 06:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808264; x=1766413064; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeVmB6pdOKliNGaheWVpdrKRlK51LVSf7JP1hhbHQFo=;
        b=sYbJxTfL1e5AGsk1aarOmHXJLeEhI53rXTWs6N/r/DSoXVRaQ91BlQRtq/MXp/4iF0
         mc6j7q5IzBXrL+4B/6zPJK8jIOcwwvIWvXvM292iu6x4Wzj76CK4CDUZLKGTtj1BALWR
         +xH8CPKkMMc3v1RyDJE6UPD+3mECtoHm+oO6vwvL08320Ad4Pgh0Hy37O6q9A61MWh45
         f9lR2+IJ0pO/0YJXklQrml/YuzE4OwBALNvAFwcEmZHXb1bEzQFPyGdT5RmSXa/TBXhI
         b5BsR9cstwX9+LprXoTIIIKCOQr1vtR0xdHJDALRXTFAVYKtf7Hxxn1JshINR7ILtZtm
         j27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808264; x=1766413064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MeVmB6pdOKliNGaheWVpdrKRlK51LVSf7JP1hhbHQFo=;
        b=YAd8TwjQt1V+jfxyXYlDk1kxBWZKi3Z3EblBktWtqHOdRrUSO1vzM+CIKPjYZf/9Z9
         PkXBp5zUv66VXPhW/qssWAgaMuIUdLM7Hf+TJWkBi8M7n1iqH+EzChD5Cyr5qJcis0Q0
         SkiKdI78lKRqIQ7P1uKnPoVF3sTHLSX7ryU0s3LSizotJEZxVMJF3+LScYFuEMTHxyfs
         ZOB/xRP9rqrEuuPU5iE9oNqmxUg9pM0wd4JVhFgPBKzWjzqea4uWFiUaD5JCRKgeNVpc
         dQ726e7cdNQ6u5PQnIEmne+KzHbIF68KJnZGuuj6iABEKRqibQbaKhdEahV5VWk9losY
         xhLg==
X-Forwarded-Encrypted: i=1; AJvYcCUXJ3oJQNgXT0V9hABWeLjlP+tNyNCpRwBHHjCv3+O2IizOiNPrv0mds2MWYs2xHwQ7oP/KdfQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Ywh4JgnLjw1FsBHOk3gNESpvA7n53PeGJADMCwpkwJzA6SVXHaO
	4VWUj+gSef1Q3G1ZdfsW5ezfgLi4pEsQ5mJBjPI+E8uRXkzlGm6H59sB4qy2qiYEl+8=
X-Gm-Gg: AY/fxX7lfsCWIY6vEoe2gUULxNrJLrQph+lXUcGYiUDuSx5ImHSGNIBnHBIVhx6IdHM
	cXCLnSzF7Y1Un8NVwJ/ej5WWhSNISachZ4Np7YHBTVAE+DZQh+EJhrDuaX9ZOkcPJgRkigEiiHa
	DpdVT3pJL3NPKQrKP8y8gc4oIo7prCGe+yY/0DUBIo9D0Y33N90Y28DZko+OcwvWw+VlyDysYzQ
	ftUm/USrg++osn35XyjcNFQl9NkXnrEpuZMQX0BQCyvDGM14JJ/043Kex8+0OmSVTcdrYcPNRE3
	TiH70mf2rlk3YnEG0knBR+LEXIWdNNusJrbirDLR/MadVqCbt9w+vLCFQQRKmQcgHMlPoyHs33/
	vg2Yy92YiJD2uhn9x4SOcyLFVkVjiPQ+vN/enEaiBNZ67jKFCZGiSazwQEFHmJEPQKhib1/CVe7
	FbPAzktjyqp0trzvC+nsbuDnYkikyK+NbV1cSeIPNGC1EWmLlsgUb6dber/t+e3oUC+Daq
X-Google-Smtp-Source: AGHT+IGjuIlGhVLGV8y/XU/LQ0KVHoNFed57MFBl0SJ8RGXpjTQqBLrhIQJec3QABMGxBdUrXwOG6A==
X-Received: by 2002:a17:907:9816:b0:b79:c233:c8a7 with SMTP id a640c23a62f3a-b7d23665c82mr1069817966b.21.1765808264061;
        Mon, 15 Dec 2025 06:17:44 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa5d1e89sm1393673866b.69.2025.12.15.06.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:43 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	=?utf-8?b?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 06/17] rtc: optee: Migrate to use tee specific driver registration function
Date: Mon, 15 Dec 2025 15:16:36 +0100
Message-ID: <6da13fa15497f8bde6e2621ebb11ab74764f890a.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1476; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=8xBlw1gjbdzbNdrRW7jRBiV40wdZTcJoR7/j5OL6ib8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhb75mJ64PBhRfXSJJzfGImqsFztPlgX9E8Y hTlBWg5zv6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYWwAKCRCPgPtYfRL+ TsC4B/9HAtoQkHHcfMd9S0b9RyrKfMyDk9Oj7QkjAjCz5NCrRVQJwW1Szu4f0ATJxzGMnnC77H1 KwvApK2BvtqK66JJi96d1LwD0CMVlbji/IB4YsGF/lFpiBHiuBLxd7yg5iXBqvX87v+jorwAq77 7Wsrzaew2TImyvruUOTZwf9M1By1wkdIfaKg+ebLVwVJyWDzPVQxVja2stgsP2pooGyhhLdZeq3 1bdSzHk0G5rWmqfCtivdifouKeQwshMxGn5u8XcYMBmeMTG4f/1MkBa/X1Ri56FGv0VX+YiRyHY qbYRrIwYVd21yg9XFfq6shF2miyMo1Te9ZxC4KQ6IdyupLqK
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.30 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.41:from];
	DMARC_NA(0.00)[baylibre.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[46.5.122.62:received,209.85.218.41:from];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 22A5B4FE9C
X-Spamd-Bar: --
Message-ID-Hash: HKKPVBRC7S7IVTEM3AWAP6UCVLWNERCV
X-Message-ID-Hash: HKKPVBRC7S7IVTEM3AWAP6UCVLWNERCV
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HKKPVBRC7S7IVTEM3AWAP6UCVLWNERCV/>
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
UmV2aWV3ZWQtYnk6IFN1bWl0IEdhcmcgPHN1bWl0LmdhcmdAb3NzLnF1YWxjb21tLmNvbT4NCkFj
a2VkLWJ5OiBBbGV4YW5kcmUgQmVsbG9uaSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+
DQpTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQGJheWxp
YnJlLmNvbT4NCi0tLQ0KIGRyaXZlcnMvcnRjL3J0Yy1vcHRlZS5jIHwgMTQgKy0tLS0tLS0tLS0t
LS0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEzIGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ydGMvcnRjLW9wdGVlLmMgYi9kcml2ZXJzL3J0Yy9ydGMtb3B0
ZWUuYw0KaW5kZXggMTg0YzZkMTQyODAxLi5mOTI0YTcyOWVhZDAgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3J0Yy9ydGMtb3B0ZWUuYw0KKysrIGIvZHJpdmVycy9ydGMvcnRjLW9wdGVlLmMNCkBAIC03
MjYsMjUgKzcyNiwxMyBAQCBzdGF0aWMgc3RydWN0IHRlZV9jbGllbnRfZHJpdmVyIG9wdGVlX3J0
Y19kcml2ZXIgPSB7DQogCS5pZF90YWJsZQk9IG9wdGVlX3J0Y19pZF90YWJsZSwNCiAJLmRyaXZl
cgkJPSB7DQogCQkubmFtZQkJPSAib3B0ZWVfcnRjIiwNCi0JCS5idXMJCT0gJnRlZV9idXNfdHlw
ZSwNCiAJCS5wcm9iZQkJPSBvcHRlZV9ydGNfcHJvYmUsDQogCQkucmVtb3ZlCQk9IG9wdGVlX3J0
Y19yZW1vdmUsDQogCQkucG0JCT0gcG1fc2xlZXBfcHRyKCZvcHRlZV9ydGNfcG1fb3BzKSwNCiAJ
fSwNCiB9Ow0KIA0KLXN0YXRpYyBpbnQgX19pbml0IG9wdGVlX3J0Y19tb2RfaW5pdCh2b2lkKQ0K
LXsNCi0JcmV0dXJuIGRyaXZlcl9yZWdpc3Rlcigmb3B0ZWVfcnRjX2RyaXZlci5kcml2ZXIpOw0K
LX0NCi0NCi1zdGF0aWMgdm9pZCBfX2V4aXQgb3B0ZWVfcnRjX21vZF9leGl0KHZvaWQpDQotew0K
LQlkcml2ZXJfdW5yZWdpc3Rlcigmb3B0ZWVfcnRjX2RyaXZlci5kcml2ZXIpOw0KLX0NCi0NCi1t
b2R1bGVfaW5pdChvcHRlZV9ydGNfbW9kX2luaXQpOw0KLW1vZHVsZV9leGl0KG9wdGVlX3J0Y19t
b2RfZXhpdCk7DQorbW9kdWxlX3RlZV9jbGllbnRfZHJpdmVyKG9wdGVlX3J0Y19kcml2ZXIpOw0K
IA0KIE1PRFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsNCiBNT0RVTEVfQVVUSE9SKCJDbMOpbWVudCBM
w6lnZXIgPGNsZW1lbnQubGVnZXJAYm9vdGxpbi5jb20+Iik7DQotLSANCjIuNDcuMw0KDQo=
