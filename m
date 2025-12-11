Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC5BD4417C
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:04:40 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 294D346453
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 11:04:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=HRh8uSed;
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6F41F4FFF8
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 17:16:12 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42e2b80ab25so197984f8f.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 09:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473371; x=1766078171; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+SHfa6vAHr55xEpYtx8saNp/3XbgtX4zTiJHIYfZ1k=;
        b=HRh8uSedVQluJMQ/cFrZ57Wp+peWIAEb7ZzfpsCyhei63tlfAazFu56ez5hXXP53AX
         9Ne1xRyl560hmioYegQwIR7Gl942ABFNEwtDtYFtynY/PwSOD5Y+J45YjaGU1Lw/SH9x
         34Ra9WnGLb6/UgTv3H9EykY1VUcT4wUcLBD+gsas6jSJe6jxscdJrvaLiKSef6ayiTHA
         nThAPvgRWvblCMgKYMtv3UDTedrXB/ZhvCbtfI1owicqlUPyGlgIDc6xg7AIUPfgNDNQ
         Ko82S7kjYHGLDHEvDTsud4eN8Z0aB1MQsh2DnUFv9zxFcfMMNdz63NQtsqcMKXRt+DfL
         37wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473371; x=1766078171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n+SHfa6vAHr55xEpYtx8saNp/3XbgtX4zTiJHIYfZ1k=;
        b=qcpmzks1wNhGgSlgWSaz99XkHFc2KVUhrrG59OQGnHRCTH7W1gV+s2kv2iRZ6/m49m
         0/UmS18BkTy/gViIgkp/90C5cJlGCOT90mSKROybLoPjnm9wOD8HdqPRfd4fNIwgox3h
         76e4WLl02pMBnE6UX907pd7sDGXHSFpAxvigzXKRLkj4CE3e4eG48ByjoLNjVTwhadLG
         3cowjT7Mubns2DoC728TXfh5x8fGAYkLsVi5y/zedkZQV74oOwfVIbHIxTMvsNzNGU3J
         mx1SpHiLyPG+KdK5KCpX9bDMKYEzKrtiE0JFrv1L11Uc/MwlsfJvAoOaapeTUL1NhXjY
         s9fw==
X-Gm-Message-State: AOJu0YySXC0v5y6ZI1STIw7XA95Hq6gPn2LDF6yUgOAMIS4kSWTw6sQo
	BcyqPOCF9xu68kjWvf+Y6x+6fLQOcYtzon9TMeSv7SBw1JfrGDCgzhQ3pLKNDrk78kk=
X-Gm-Gg: AY/fxX4TcKAgU2WY008pLCCdy+2LazQDUFzOs26+S4AbT76eV0HIppECIOn88PTGm32
	TINyeLHIDm2mTf5LVEPsK0WBFBwbknEGbBfZKVuSzgKe/1ZQ5Fcsjy9wmjEmWA6liRVYG+gYrBN
	MV4ydwBtdR2VrswYhDVu2ABo3YUb5Go8txI0IEkGrsNgzL6jae5gjNmskZ2sEKGe1KQ+qj9Zsgd
	E1BWafl3PlyH/bu0o4G8+Fd6e3HIgq9+xJWcjKgGUC4H5qLNbXpt3LGdk2iJRhL1Csc32e3n68r
	dgxuFP5Z8OC2ELApQM9NtZwXC17DhLHT/FiMU78F7mrcD0BVi8IrU3u9z+H19qO4WZeWgku6jiw
	e+VY33aCMGQOLO9x1oZnWbV60+iSdA53z3bLio0tm1Uim6DB4nJ/uXZBK0XNmCUIKVh4z2VeImN
	icX1cHCKYUxDR6e06QLZI+RexjqCPdgMCFDpi3YG+M4MYvVvjhkTO2WdaZU7CbqMz43Nd9FiLVi
	Uo=
X-Google-Smtp-Source: AGHT+IEVlfLgsF/P2fkju8/EGLrakjagEMlQtCpgWX8RHB5vEnT2Q9O+No1JYvdMM/sRnem0fYfvQQ==
X-Received: by 2002:a05:6000:2012:b0:42b:3978:158e with SMTP id ffacd0b85a97d-42fa3af895fmr6416347f8f.30.1765473370344;
        Thu, 11 Dec 2025 09:16:10 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42fa8b8a973sm7064875f8f.36.2025.12.11.09.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:16:09 -0800 (PST)
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
Subject: [PATCH v1 15/17] KEYS: trusted: Make use of tee bus methods
Date: Thu, 11 Dec 2025 18:15:09 +0100
Message-ID: <aab4c00b7e89abce7bcd8241c47f3398fb7227f8.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1908; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=CzasmjigxMDc3RbPNhKzZOfqJrGSXpxinQ87lLaAs6M=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvw6brlrzvg29fcU3xprVy3jDUvD6QI895K+A 4P0ITtETEGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8OgAKCRCPgPtYfRL+ ToAKCACHrdHSasYStywLZJGRNAkC64NWvFb/BwKzZCoF8C+nTT45O0JbfN5t/ZZlz3WQUTo5Kj7 m5QHbprAIkb7KlG6c9wMZpIvnIBvKwpE7j+PUzZ2X2+UD2nnn20123zaagJYaJHriTJetqmRK/g fl4EgbD/AzpOofrYMbezG60UvGRmRCPd4NvhNQ6GXkzjyAH5oICnrjI/ufaG65GzQSejD8nT5qK UIdLIccaehc7imlrk0QNv17cD5+/y0ZIwdI2uAIuelzdvUdNHWDYI1/zMNQ3t+FkqM+vgaElDdx 8Ft+pQXoK9ErCp8MIxolmLzr+4840mvUoLiV3YhnVRyUrSkT
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.47:from];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	BLOCKLISTDE_FAIL(0.00)[209.85.221.47:server fail];
	ARC_NA(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.47:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6F41F4FFF8
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 2ASL2WCBS2KOHJZPZAXTPCSEENOEAMNJ
X-Message-ID-Hash: 2ASL2WCBS2KOHJZPZAXTPCSEENOEAMNJ
X-Mailman-Approved-At: Fri, 12 Dec 2025 10:57:13 +0000
CC: op-tee@lists.trustedfirmware.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2ASL2WCBS2KOHJZPZAXTPCSEENOEAMNJ/>
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
cmUuY29tPg0KLS0tDQogc2VjdXJpdHkva2V5cy90cnVzdGVkLWtleXMvdHJ1c3RlZF90ZWUuYyB8
IDEyICsrKysrLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDcgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9zZWN1cml0eS9rZXlzL3RydXN0ZWQta2V5cy90cnVz
dGVkX3RlZS5jIGIvc2VjdXJpdHkva2V5cy90cnVzdGVkLWtleXMvdHJ1c3RlZF90ZWUuYw0KaW5k
ZXggM2NlYTlhMzc3OTU1Li42ZTQ2NWM4YmVmNWUgMTAwNjQ0DQotLS0gYS9zZWN1cml0eS9rZXlz
L3RydXN0ZWQta2V5cy90cnVzdGVkX3RlZS5jDQorKysgYi9zZWN1cml0eS9rZXlzL3RydXN0ZWQt
a2V5cy90cnVzdGVkX3RlZS5jDQpAQCAtMjAyLDkgKzIwMiw5IEBAIHN0YXRpYyBpbnQgb3B0ZWVf
Y3R4X21hdGNoKHN0cnVjdCB0ZWVfaW9jdGxfdmVyc2lvbl9kYXRhICp2ZXIsIGNvbnN0IHZvaWQg
KmRhdGEpDQogCQlyZXR1cm4gMDsNCiB9DQogDQotc3RhdGljIGludCB0cnVzdGVkX2tleV9wcm9i
ZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQorc3RhdGljIGludCB0cnVzdGVkX2tleV9wcm9iZShzdHJ1
Y3QgdGVlX2NsaWVudF9kZXZpY2UgKnJuZ19kZXZpY2UpDQogew0KLQlzdHJ1Y3QgdGVlX2NsaWVu
dF9kZXZpY2UgKnJuZ19kZXZpY2UgPSB0b190ZWVfY2xpZW50X2RldmljZShkZXYpOw0KKwlzdHJ1
Y3QgZGV2aWNlICpkZXYgPSAmcm5nX2RldmljZS0+ZGV2Ow0KIAlpbnQgcmV0Ow0KIAlzdHJ1Y3Qg
dGVlX2lvY3RsX29wZW5fc2Vzc2lvbl9hcmcgc2Vzc19hcmc7DQogDQpAQCAtMjQ0LDEzICsyNDQs
MTEgQEAgc3RhdGljIGludCB0cnVzdGVkX2tleV9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQog
CXJldHVybiByZXQ7DQogfQ0KIA0KLXN0YXRpYyBpbnQgdHJ1c3RlZF9rZXlfcmVtb3ZlKHN0cnVj
dCBkZXZpY2UgKmRldikNCitzdGF0aWMgdm9pZCB0cnVzdGVkX2tleV9yZW1vdmUoc3RydWN0IHRl
ZV9jbGllbnRfZGV2aWNlICpkZXYpDQogew0KIAl1bnJlZ2lzdGVyX2tleV90eXBlKCZrZXlfdHlw
ZV90cnVzdGVkKTsNCiAJdGVlX2NsaWVudF9jbG9zZV9zZXNzaW9uKHB2dF9kYXRhLmN0eCwgcHZ0
X2RhdGEuc2Vzc2lvbl9pZCk7DQogCXRlZV9jbGllbnRfY2xvc2VfY29udGV4dChwdnRfZGF0YS5j
dHgpOw0KLQ0KLQlyZXR1cm4gMDsNCiB9DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCB0ZWVfY2xp
ZW50X2RldmljZV9pZCB0cnVzdGVkX2tleV9pZF90YWJsZVtdID0gew0KQEAgLTI2MSwxMSArMjU5
LDExIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGVlX2NsaWVudF9kZXZpY2VfaWQgdHJ1c3RlZF9r
ZXlfaWRfdGFibGVbXSA9IHsNCiBNT0RVTEVfREVWSUNFX1RBQkxFKHRlZSwgdHJ1c3RlZF9rZXlf
aWRfdGFibGUpOw0KIA0KIHN0YXRpYyBzdHJ1Y3QgdGVlX2NsaWVudF9kcml2ZXIgdHJ1c3RlZF9r
ZXlfZHJpdmVyID0gew0KKwkucHJvYmUJCT0gdHJ1c3RlZF9rZXlfcHJvYmUsDQorCS5yZW1vdmUJ
CT0gdHJ1c3RlZF9rZXlfcmVtb3ZlLA0KIAkuaWRfdGFibGUJPSB0cnVzdGVkX2tleV9pZF90YWJs
ZSwNCiAJLmRyaXZlcgkJPSB7DQogCQkubmFtZQkJPSBEUklWRVJfTkFNRSwNCi0JCS5wcm9iZQkJ
PSB0cnVzdGVkX2tleV9wcm9iZSwNCi0JCS5yZW1vdmUJCT0gdHJ1c3RlZF9rZXlfcmVtb3ZlLA0K
IAl9LA0KIH07DQogDQotLSANCjIuNDcuMw0KDQo=
