Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A46C54FCC
	for <op-tee@archiver.kernel.org>; Fri, 20 Feb 2026 08:50:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4BBE4438CF
	for <op-tee@archiver.kernel.org>; Fri, 20 Feb 2026 08:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1771577451;
	bh=/D6HP3qKAnFMp9MNYp4X2sCLWaKZu0NUhBd3zGC8570=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=YAqsv03y9TBlXRK5C+kwssfRbsplEaZp8SB+EEteK3HUshOnYriVefa3I9lUqAWqH
	 hciTu/faegZbRMcYhkaJK1Zn2o0juLZtOyAc/1gzcK+1sbnmHX9KV8/83jmyRpUELU
	 zzEUutr/LzkzPwD4qIwnYrmEJCsHcsAJFRZF1yjzG8C5VTGdq1GQLBv2OsVUNGgxoS
	 7JPwAN9qrGYRepk4Iio9mwUtLce4+2lZBtqLmNtYgP1zdzV03LcaDukYo0e/iVjNPv
	 Te0alURyGc3O3JiqDEUJeRQaPLfK5FklsCOhY4O2v5x4oQFcA80GFDnW/6ckxzyZdI
	 ublC+kwEHDelQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1443543833
	for <op-tee@lists.trustedfirmware.org>; Fri, 20 Feb 2026 08:50:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NykkGadI;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 640FB403FA;
	Fri, 20 Feb 2026 08:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DF9C116C6;
	Fri, 20 Feb 2026 08:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771577429;
	bh=rjIXc2AD+KfYAMtK9G+UrVTRs1f6gjwWMNxmefC21+A=;
	h=From:To:Cc:Subject:Date:From;
	b=NykkGadIpSyxkv1Ts+iqza0OoWYhC3x0nEkKJC1nHPiq+Q/tZtM3082XxYygS3k0U
	 ERgYbDalsuPJB1aLjwMhT6PY6Ekf0x2KWoF4v4oDBWrNYGQvx76aRDULVQJnGBPz6j
	 NadzF+L5sPkfRifh7uzvLv27M8Le62soIMxR7rW5habAVutncdD629VLok9mh1uVdd
	 xZ4Mlq0UH2Br/OxL7hxlM5W5eySCtJlLsC7QUrogD0rrhY1GmW3UK5WrezV3KSSvuF
	 WfOtGNegK3Il0k+sZ0bziEybFk8wWVoEY83zCbB0Fy6FeHhTzIgWBTelpqt8uSLyBP
	 6os3ER8cQVs+Q==
To: op-tee@lists.trustedfirmware.org
Subject: [RFT PATCH v2] tee: shm: Remove refcounting of kernel pages
Date: Fri, 20 Feb 2026 14:19:59 +0530
Message-ID: <20260220084959.1966771-1-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1443543833
X-Spamd-Bar: ---
Message-ID-Hash: G4GJMD5HJ54KCSMGAIXWVNODTY46P3UB
X-Message-ID-Hash: G4GJMD5HJ54KCSMGAIXWVNODTY46P3UB
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: vbabka@suse.cz, akpm@linux-foundation.org, willy@infradead.org, m.felsch@pengutronix.de, s.pueschel@pengutronix.de, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/G4GJMD5HJ54KCSMGAIXWVNODTY46P3UB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

RnJvbTogTWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+DQoNCkVhcmxpZXIgVEVF
IHN1YnN5c3RlbSBhc3N1bWVkIHRvIHJlZmNvdW50IGFsbCB0aGUgbWVtb3J5IHBhZ2VzIHRvIGJl
DQpzaGFyZWQgd2l0aCBURUUgaW1wbGVtZW50YXRpb24gdG8gYmUgcmVmY291bnRlZC4gSG93ZXZl
ciwgdGhlIHNsYWINCmFsbG9jYXRpb25zIHdpdGhpbiB0aGUga2VybmVsIGRvbid0IGFsbG93IHJl
ZmNvdW50aW5nIGtlcm5lbCBwYWdlcy4NCg0KSXQgaXMgcmF0aGVyIGJldHRlciB0byB0cnVzdCB0
aGUga2VybmVsIGNsaWVudHMgdG8gbm90IGZyZWUgcGFnZXMgd2hpbGUNCmJlaW5nIHNoYXJlZCB3
aXRoIFRFRSBpbXBsZW1lbnRhdGlvbi4gSGVuY2UsIHJlbW92ZSByZWZjb3VudGluZyBvZiBrZXJu
ZWwNCnBhZ2VzIGZyb20gcmVnaXN0ZXJfc2htX2hlbHBlcigpIEFQSS4NCg0KRml4ZXM6IGI5YzBl
NDlhYmZjYSAoIm1tOiBkZWNsaW5lIHRvIG1hbmlwdWxhdGUgdGhlIHJlZmNvdW50IG9uIGEgc2xh
YiBwYWdlIikNClJlcG9ydGVkLWJ5OiBNYXJjbyBGZWxzY2ggPG0uZmVsc2NoQHBlbmd1dHJvbml4
LmRlPg0KUmVwb3J0ZWQtYnk6IFN2ZW4gUMO8c2NoZWwgPHMucHVlc2NoZWxAcGVuZ3V0cm9uaXgu
ZGU+DQpTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz4N
CkNvLWRldmVsb3BlZC1ieTogU3VtaXQgR2FyZyA8c3VtaXQuZ2FyZ0Bvc3MucXVhbGNvbW0uY29t
Pg0KU2lnbmVkLW9mZi1ieTogU3VtaXQgR2FyZyA8c3VtaXQuZ2FyZ0Bvc3MucXVhbGNvbW0uY29t
Pg0KLS0tDQoNCkNoYW5nZXMgaW4gdjI6DQotIEF0dHJpYnV0ZSBNYXR0aGV3IGFzIHRoZSBhdXRo
b3Igb2YgdGhpcyBwYXRjaC4NCi0gRml4IGNoZWNrIGZvciB1c2VyIHBhZ2VzLg0KDQogZHJpdmVy
cy90ZWUvdGVlX3NobS5jIHwgMjcgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDI3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy90ZWUvdGVl
X3NobS5jIGIvZHJpdmVycy90ZWUvdGVlX3NobS5jDQppbmRleCA0YTQ3ZGU0YmIyZTUuLjg5ODcw
N2NhMjFhOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdGVlL3RlZV9zaG0uYw0KKysrIGIvZHJpdmVy
cy90ZWUvdGVlX3NobS5jDQpAQCAtMjMsMjkgKzIzLDExIEBAIHN0cnVjdCB0ZWVfc2htX2RtYV9t
ZW0gew0KIAlzdHJ1Y3QgcGFnZSAqcGFnZTsNCiB9Ow0KIA0KLXN0YXRpYyB2b2lkIHNobV9wdXRf
a2VybmVsX3BhZ2VzKHN0cnVjdCBwYWdlICoqcGFnZXMsIHNpemVfdCBwYWdlX2NvdW50KQ0KLXsN
Ci0Jc2l6ZV90IG47DQotDQotCWZvciAobiA9IDA7IG4gPCBwYWdlX2NvdW50OyBuKyspDQotCQlw
dXRfcGFnZShwYWdlc1tuXSk7DQotfQ0KLQ0KLXN0YXRpYyB2b2lkIHNobV9nZXRfa2VybmVsX3Bh
Z2VzKHN0cnVjdCBwYWdlICoqcGFnZXMsIHNpemVfdCBwYWdlX2NvdW50KQ0KLXsNCi0Jc2l6ZV90
IG47DQotDQotCWZvciAobiA9IDA7IG4gPCBwYWdlX2NvdW50OyBuKyspDQotCQlnZXRfcGFnZShw
YWdlc1tuXSk7DQotfQ0KLQ0KIHN0YXRpYyB2b2lkIHJlbGVhc2VfcmVnaXN0ZXJlZF9wYWdlcyhz
dHJ1Y3QgdGVlX3NobSAqc2htKQ0KIHsNCiAJaWYgKHNobS0+cGFnZXMpIHsNCiAJCWlmIChzaG0t
PmZsYWdzICYgVEVFX1NITV9VU0VSX01BUFBFRCkNCiAJCQl1bnBpbl91c2VyX3BhZ2VzKHNobS0+
cGFnZXMsIHNobS0+bnVtX3BhZ2VzKTsNCi0JCWVsc2UNCi0JCQlzaG1fcHV0X2tlcm5lbF9wYWdl
cyhzaG0tPnBhZ2VzLCBzaG0tPm51bV9wYWdlcyk7DQogDQogCQlrZnJlZShzaG0tPnBhZ2VzKTsN
CiAJfQ0KQEAgLTQ3NywxMyArNDU5LDYgQEAgcmVnaXN0ZXJfc2htX2hlbHBlcihzdHJ1Y3QgdGVl
X2NvbnRleHQgKmN0eCwgc3RydWN0IGlvdl9pdGVyICppdGVyLCB1MzIgZmxhZ3MsDQogCQlnb3Rv
IGVycl9wdXRfc2htX3BhZ2VzOw0KIAl9DQogDQotCS8qDQotCSAqIGlvdl9pdGVyX2V4dHJhY3Rf
a3ZlY19wYWdlcyBkb2VzIG5vdCBnZXQgcmVmZXJlbmNlIG9uIHRoZSBwYWdlcywNCi0JICogZ2V0
IGEgcmVmZXJlbmNlIG9uIHRoZW0uDQotCSAqLw0KLQlpZiAoaW92X2l0ZXJfaXNfa3ZlYyhpdGVy
KSkNCi0JCXNobV9nZXRfa2VybmVsX3BhZ2VzKHNobS0+cGFnZXMsIG51bV9wYWdlcyk7DQotDQog
CXNobS0+b2Zmc2V0ID0gb2ZmOw0KIAlzaG0tPnNpemUgPSBsZW47DQogCXNobS0+bnVtX3BhZ2Vz
ID0gbnVtX3BhZ2VzOw0KQEAgLTQ5OSw4ICs0NzQsNiBAQCByZWdpc3Rlcl9zaG1faGVscGVyKHN0
cnVjdCB0ZWVfY29udGV4dCAqY3R4LCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIsIHUzMiBmbGFncywN
CiBlcnJfcHV0X3NobV9wYWdlczoNCiAJaWYgKCFpb3ZfaXRlcl9pc19rdmVjKGl0ZXIpKQ0KIAkJ
dW5waW5fdXNlcl9wYWdlcyhzaG0tPnBhZ2VzLCBzaG0tPm51bV9wYWdlcyk7DQotCWVsc2UNCi0J
CXNobV9wdXRfa2VybmVsX3BhZ2VzKHNobS0+cGFnZXMsIHNobS0+bnVtX3BhZ2VzKTsNCiBlcnJf
ZnJlZV9zaG1fcGFnZXM6DQogCWtmcmVlKHNobS0+cGFnZXMpOw0KIGVycl9mcmVlX3NobToNCi0t
IA0KMi41MS4wDQoNCg==
