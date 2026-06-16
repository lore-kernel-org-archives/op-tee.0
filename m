Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5063CD98E1
	for <op-tee@archiver.kernel.org>; Tue, 16 Jun 2026 14:38:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E12EC44B0F
	for <op-tee@archiver.kernel.org>; Tue, 16 Jun 2026 14:38:42 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=k3RRajDg;
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 15A6A43723
	for <op-tee@lists.trustedfirmware.org>; Tue, 16 Jun 2026 14:38:36 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-461a5a39da1so529701f8f.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 16 Jun 2026 07:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781620715; x=1782225515; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W+tSGAKOOiWrJ8xcAUXOZaGk1NSgarKla4YzWcPQKdw=;
        b=k3RRajDgFqXP9bm7Amvyt1/urSzVeutIYYSEuA21rTLclKgOGvxuJOHJlAWXIbZzpK
         Hr+I4bIBWGigV5SA13bRau5OxcmQlfLK+O0rNH/Z3U6+oXXV4XJHpHINAUHsc7siN6Xq
         /zpv6Jg9XUgTylwxKKLT6mxsb6WVlrICZsAMS3GnVbIC6cxp2BYdLrLbfe269FTARCHP
         xq5tfpb7/i3GFqyXRheIHgPgVhORbYljdXElvXqkA4j3Nn0nkoh7wwqeGeZpwd+9Sa+Q
         G7c7RSUazH6ltbtS2REceCY21usLdccPGoEtOKWZJQx1k0WZgrwQ4I2fcadTPAjyfeAx
         HB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781620715; x=1782225515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+tSGAKOOiWrJ8xcAUXOZaGk1NSgarKla4YzWcPQKdw=;
        b=O/ca9r6uRa0FUIs+uT2hvzxYy2VOpVecLm12xn9OGRKsw4aSy8hz8my3bTFLNXCbm7
         5kTPBJPVna1evcKKczOCXn5ggp7rtx0LJdPA2Nwc1FYApVcWuw7RLpDrh/Fb9hToeW5T
         p/7E2+1GqvODM7WsB33GJauQ8v/P8wD3cac4MYygW+6Dj9n67R+tvkiC30u1zz1oh9xf
         optLZ2oX1EOy7z8a6aSHuDebpmnw9ovM5KnL+/F13ESFDejHBCqB0WI0lS3jWp3iZqG1
         3kSef7Nbym3fqCYNKUbHcCppYTWEWvUsgHKBy6Q/GtG1TdAa/QKqGATc+davSGH0ni2j
         7FFg==
X-Forwarded-Encrypted: i=1; AFNElJ9K3tyW3LabJSCeoVqoYc90KeIRFa2/YuD2TcRfuBF9LCHGbdHEUCto6Fts4YFIj1BKQmH5A5w=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy5ko+EXCnsYE3VP4A5lx9QEkmMhRU8oXUDg2LWMjcD3WqxgiZX
	QYdHjD7rVoYqz7fpcyMeAKoPVJ1Gbq0mISZXDNq/zhR29L+mT+CyTGlRn4MewTu+ftw=
X-Gm-Gg: Acq92OEkjkmFQXQlxbrM6f0yCLY8IjxfUhYCw2mN0isO4BeDbsHBKVp1U9mhIirZcDv
	qAKg4R+WXloT+n1u6fMMoq0TEpvdIaa8BOvE4S/T9Zp2gklonQtxzTs6u8I7rD0ibaHb/vfZhTT
	n9rR6ozGXH/JW9sS4i8bHJaACOzH2beXoMEzbSRbTmYttQKrTPNFkqu00IPRwr4IHHaj81rSrwp
	xU1jynOf1o09K7Z5HV0QjnH6wvZxNb/u4nvWrilMVGKhlI6ko4MEtV2F1RRIhpCni23BCG/8EEK
	6n++9e9JJyAbTw3tRzCh3xtETwGO/b1Kc7yRlhvU3vkdv9tZQmrXXwtm5Rd3NB9OVwCkt3Sf1d/
	WFjFp0ufwWiTzMoapgWU2/IBioF1N8a+bJItwOOIreELvOuPtdvZ0c7t+JH9BRs+4iHyjdm0c0/
	3Yt6IZ4a11yQAn13MyMP65cAdf8qYHTMEeOjnqvFmEk1TCq8pnzf6oI5dLDGneeovN5BYl5PZfW
	ruetcYxb839fcM=
X-Received: by 2002:a05:6000:220e:b0:45e:d8dc:922e with SMTP id ffacd0b85a97d-4619f3af726mr7190374f8f.20.1781620714895;
        Tue, 16 Jun 2026 07:38:34 -0700 (PDT)
Received: from localhost (p200300f65f47db04ed78e379f226b032.dip0.t-ipconnect.de. [2003:f6:5f47:db04:ed78:e379:f226:b032])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4606f26434dsm45670638f8f.1.2026.06.16.07.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:38:34 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v1] tee: qcomtee: Drop unused assignment of platform_device_id driver data
Date: Tue, 16 Jun 2026 16:38:29 +0200
Message-ID: <c21803b3f2ea1522bb930dc1dcab79c2627f2234.1781620559.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=AVhMeIY1PvyV4RiuwAZteI7ZZRMcD0tR7T2uTtHY47U=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqMV/lBZBY7mc35M4ybdluFIBOzGWByaPdm75cj 8Qd3LKI2XiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajFf5QAKCRCPgPtYfRL+ ThOpCACzTn7kcorJvTwKOMBfw0gvPGrtu/fluvqk6pTkMfLHZJ/vo0s8ks2JmSeDg2z9ZvTjjRz xe1wbs5bXDYOXWr28CZHVqIgjfL674mDA/IDQHGH5Oq56FnEDkjUhETy/2+BbuJyCcWd+M+UX0E +PQAq7JcSn5GU6ijXb80sy9vnWPQu+GB89njGQ7T2OnT5Ygik3IRComDtMq2tD1qVbP4YpcdO6R O/ppalmzpqZ4tHhtfd9ply1+sjjOHhyqOMbak9xNV8XARPmRomV5v4pwEXk+0pbQsjK0u1GNd3G X4CNTZ/HcWWUvhEj4acJCthK7D/6UBbr174M6wDafyCa3IpY
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.47:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.47:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 15A6A43723
X-Spamd-Bar: --
Message-ID-Hash: R27TCKKPXHZI3AIZODW7SA2MW22BU5V5
X-Message-ID-Hash: R27TCKKPXHZI3AIZODW7SA2MW22BU5V5
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/R27TCKKPXHZI3AIZODW7SA2MW22BU5V5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

VGhlIGRyaXZlciBleHBsaWNpdGx5IHNldHMgdGhlIC5kcml2ZXJfZGF0YSBtZW1iZXIgb2Ygc3Ry
dWN0DQpwbGF0Zm9ybV9kZXZpY2VfaWQgdG8gemVybyB3aXRob3V0IHJlbHlpbmcgb24gdGhhdCB2
YWx1ZS4gRHJvcCB0aGlzDQp1bnVzZWQgYXNzaWdubWVudC4NCg0KV2hpbGUgdG91Y2hpbmcgdGhp
cyBhcnJheSB1bmlmeSBzcGFjaW5nIGFuZCB1c2FnZSBvZiBjb21tYXMgYW5kIHVzZQ0KYSBuYW1l
ZCBpbml0aWFsaXplciBmb3IgLm5hbWUgZm9yIGltcHJvdmVkIHJlYWRhYmlsaXR5Lg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyAoVGhlIENhcGFibGUgSHViKSA8dS5rbGVpbmUt
a29lbmlnQGJheWxpYnJlLmNvbT4NCi0tLQ0KSGVsbG8sDQoNCndoaWxlIHRoaXMgaXMgYSBjbGVh
bnVwIHRoYXQgY2FuIHN0YW5kIG9uIGl0cyBvd24sIGl0IGlzIGFsc28gYQ0KcHJlcGFyYXRpb24g
Zm9yIGEgY2hhbmdlIHRvIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2VfaWQgdGhhdCByZXF1aXJlcyB0
aGF0DQouZHJpdmVyX2RhdGEgaXNuJ3QgYXNzaWduZWQgYnkgYSBsaXN0IGluaXRpYWxpemVyLg0K
DQpCZXN0IHJlZ2FyZHMNClV3ZQ0KDQogZHJpdmVycy90ZWUvcWNvbXRlZS9jYWxsLmMgfCA3ICsr
KysrKy0NCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3RlZS9xY29tdGVlL2NhbGwuYyBiL2RyaXZlcnMvdGVlL3Fj
b210ZWUvY2FsbC5jDQppbmRleCAwZWZjNTY0NjI0MmEuLjRhNTk3ZWVhZjE3NCAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvdGVlL3Fjb210ZWUvY2FsbC5jDQorKysgYi9kcml2ZXJzL3RlZS9xY29tdGVl
L2NhbGwuYw0KQEAgLTc5OCw3ICs3OTgsMTIgQEAgc3RhdGljIHZvaWQgcWNvbXRlZV9yZW1vdmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJa2ZyZWUocWNvbXRlZSk7DQogfQ0KIA0K
LXN0YXRpYyBjb25zdCBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlX2lkIHFjb210ZWVfaWRzW10gPSB7
IHsgInFjb210ZWUiLCAwIH0sIHt9IH07DQorc3RhdGljIGNvbnN0IHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2VfaWQgcWNvbXRlZV9pZHNbXSA9IHsNCisJew0KKwkJLm5hbWUgPSAicWNvbXRlZSIsDQor
CX0sDQorCXsgfQ0KK307DQogTU9EVUxFX0RFVklDRV9UQUJMRShwbGF0Zm9ybSwgcWNvbXRlZV9p
ZHMpOw0KIA0KIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHFjb210ZWVfcGxhdGZvcm1f
ZHJpdmVyID0gew0KDQpiYXNlLWNvbW1pdDogOGQ2ZGJiYmUzYmE2MmRlMGE2M2U5NjJlZTAwNGFm
Yjg0OGM4ZTNhYw0KLS0gDQoyLjQ3LjMNCg0K
