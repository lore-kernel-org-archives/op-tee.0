Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94BDEDF150
	for <op-tee@archiver.kernel.org>; Fri, 13 Feb 2026 11:34:00 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0C2E2436ED
	for <op-tee@archiver.kernel.org>; Fri, 13 Feb 2026 11:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1770982440;
	bh=QgnfCSpXJFh+lL0EfZdqmKPlDdU8ijdr5ddIa8voqws=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=W8GzUDPvmaHdsnNMTx80S3pm55v4cpfK4M6HT3u661R/IHlVsFmHXjrOSo9k/sis2
	 kcg75V1T84pUFSAA4hh2ddJ5RyzNggvjKlCjPAydwM98O4RapbmwsN14Pb923qNQbY
	 cEDVk6J23Tr5wJq3NrS4uOUABjD9s/PHzIQ3EddfxIrVcYvndyTukhvT1tJUTdIjAO
	 SyEqxbrNgZPKjP3ls2GmUuc+W9V0N/EaYkG+qvIWDO1s6s5YeRQDtyHzftUrtVvL9h
	 YAI4KRZBnRhVlbjjIsVDJlSFphCkVmZE9AvsPFRDoAat26SyV5PGk8RUVqwNHTrkRg
	 baI07gzr9TYqA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A9855436ED
	for <op-tee@lists.trustedfirmware.org>; Fri, 13 Feb 2026 11:33:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N9x0Ntlr;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EF4064340E;
	Fri, 13 Feb 2026 11:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E8EC116C6;
	Fri, 13 Feb 2026 11:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770982420;
	bh=ZAsIAHTH8afGKBP3w79TsYREK8opIrY7trwWGRrtKZk=;
	h=From:To:Cc:Subject:Date:From;
	b=N9x0NtlrXjdEMuXYaJQpa5jL0/PlQRrK9EeiWBY93T1JNNF57/ESsuHoET1KXVcTl
	 CY20zpX186kwJPksFI+7n5OHiZ4aZpPYVAhgV4XaRVOq8QauMmQ+61yuN8qPDVyS/F
	 rGQ1hWFeoW8BUzeOkPZDVwfnJRmsnAZOvBtS4e0Ck44ymQg6z4eVk2q2ezVu9fKJ4N
	 Dhqf/x909B0yTWWbspJLYqvza+y/ynmeK2KWnhd6pbs9NVAlehH08+23831xTYTHAa
	 WQHIkrkvJ0KG83olBgFtuao+2uVN6dM+Xkh6HFkvyV6FMttE8n2eYCuh24rBXJQUuX
	 r7QQnCUQ+oiFw==
To: op-tee@lists.trustedfirmware.org
Subject: [RFT PATCH] tee: shm: Remove refcounting of kernel pages
Date: Fri, 13 Feb 2026 17:03:17 +0530
Message-ID: <20260213113317.1728769-1-sumit.garg@kernel.org>
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A9855436ED
X-Spamd-Bar: ---
Message-ID-Hash: HWLUG75YNIWA3FRBTPS6ERGENCFC5JAS
X-Message-ID-Hash: HWLUG75YNIWA3FRBTPS6ERGENCFC5JAS
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: vbabka@suse.cz, akpm@linux-foundation.org, willy@infradead.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Marco Felsch <m.felsch@pengutronix.de>, =?UTF-8?q?Sven=20P=C3=BCschel?= <s.pueschel@pengutronix.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HWLUG75YNIWA3FRBTPS6ERGENCFC5JAS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

RnJvbTogU3VtaXQgR2FyZyA8c3VtaXQuZ2FyZ0Bvc3MucXVhbGNvbW0uY29tPg0KDQpFYXJsaWVy
IFRFRSBzdWJzeXN0ZW0gYXNzdW1lZCB0byByZWZjb3VudCBhbGwgdGhlIG1lbW9yeSBwYWdlcyB0
byBiZQ0Kc2hhcmVkIHdpdGggVEVFIGltcGxlbWVudGF0aW9uIHRvIGJlIHJlZmNvdW50ZWQuIEhv
d2V2ZXIsIHRoZSBzbGFiDQphbGxvY2F0aW9ucyB3aXRoaW4gdGhlIGtlcm5lbCBkb24ndCBhbGxv
dyByZWZjb3VudGluZyBrZXJuZWwgcGFnZXMuDQoNCkl0IGlzIHJhdGhlciBiZXR0ZXIgdG8gdHJ1
c3QgdGhlIGtlcm5lbCBjbGllbnRzIHRvIG5vdCBmcmVlIHBhZ2VzIHdoaWxlDQpiZWluZyBzaGFy
ZWQgd2l0aCBURUUgaW1wbGVtZW50YXRpb24uIEhlbmNlLCByZW1vdmUgcmVmY291bnRpbmcgb2Yg
a2VybmVsDQpwYWdlcyBmcm9tIHJlZ2lzdGVyX3NobV9oZWxwZXIoKSBBUEkuDQoNCkZpeGVzOiBi
OWMwZTQ5YWJmY2EgKCJtbTogZGVjbGluZSB0byBtYW5pcHVsYXRlIHRoZSByZWZjb3VudCBvbiBh
IHNsYWIgcGFnZSIpDQpSZXBvcnRlZC1ieTogTWFyY28gRmVsc2NoIDxtLmZlbHNjaEBwZW5ndXRy
b25peC5kZT4NClJlcG9ydGVkLWJ5OiBTdmVuIFDDvHNjaGVsIDxzLnB1ZXNjaGVsQHBlbmd1dHJv
bml4LmRlPg0KU3VnZ2VzdGVkLWJ5OiBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFkLm9y
Zz4NClNpZ25lZC1vZmYtYnk6IFN1bWl0IEdhcmcgPHN1bWl0LmdhcmdAb3NzLnF1YWxjb21tLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvdGVlL3RlZV9zaG0uYyB8IDI5ICstLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyOCBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGVlL3RlZV9zaG0uYyBiL2RyaXZlcnMvdGVlL3Rl
ZV9zaG0uYw0KaW5kZXggNGE0N2RlNGJiMmU1Li41NGUyYmEzYWZiMjUgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL3RlZS90ZWVfc2htLmMNCisrKyBiL2RyaXZlcnMvdGVlL3RlZV9zaG0uYw0KQEAgLTIz
LDI5ICsyMywxMSBAQCBzdHJ1Y3QgdGVlX3NobV9kbWFfbWVtIHsNCiAJc3RydWN0IHBhZ2UgKnBh
Z2U7DQogfTsNCiANCi1zdGF0aWMgdm9pZCBzaG1fcHV0X2tlcm5lbF9wYWdlcyhzdHJ1Y3QgcGFn
ZSAqKnBhZ2VzLCBzaXplX3QgcGFnZV9jb3VudCkNCi17DQotCXNpemVfdCBuOw0KLQ0KLQlmb3Ig
KG4gPSAwOyBuIDwgcGFnZV9jb3VudDsgbisrKQ0KLQkJcHV0X3BhZ2UocGFnZXNbbl0pOw0KLX0N
Ci0NCi1zdGF0aWMgdm9pZCBzaG1fZ2V0X2tlcm5lbF9wYWdlcyhzdHJ1Y3QgcGFnZSAqKnBhZ2Vz
LCBzaXplX3QgcGFnZV9jb3VudCkNCi17DQotCXNpemVfdCBuOw0KLQ0KLQlmb3IgKG4gPSAwOyBu
IDwgcGFnZV9jb3VudDsgbisrKQ0KLQkJZ2V0X3BhZ2UocGFnZXNbbl0pOw0KLX0NCi0NCiBzdGF0
aWMgdm9pZCByZWxlYXNlX3JlZ2lzdGVyZWRfcGFnZXMoc3RydWN0IHRlZV9zaG0gKnNobSkNCiB7
DQogCWlmIChzaG0tPnBhZ2VzKSB7DQogCQlpZiAoc2htLT5mbGFncyAmIFRFRV9TSE1fVVNFUl9N
QVBQRUQpDQogCQkJdW5waW5fdXNlcl9wYWdlcyhzaG0tPnBhZ2VzLCBzaG0tPm51bV9wYWdlcyk7
DQotCQllbHNlDQotCQkJc2htX3B1dF9rZXJuZWxfcGFnZXMoc2htLT5wYWdlcywgc2htLT5udW1f
cGFnZXMpOw0KIA0KIAkJa2ZyZWUoc2htLT5wYWdlcyk7DQogCX0NCkBAIC00NzcsMTMgKzQ1OSw2
IEBAIHJlZ2lzdGVyX3NobV9oZWxwZXIoc3RydWN0IHRlZV9jb250ZXh0ICpjdHgsIHN0cnVjdCBp
b3ZfaXRlciAqaXRlciwgdTMyIGZsYWdzLA0KIAkJZ290byBlcnJfcHV0X3NobV9wYWdlczsNCiAJ
fQ0KIA0KLQkvKg0KLQkgKiBpb3ZfaXRlcl9leHRyYWN0X2t2ZWNfcGFnZXMgZG9lcyBub3QgZ2V0
IHJlZmVyZW5jZSBvbiB0aGUgcGFnZXMsDQotCSAqIGdldCBhIHJlZmVyZW5jZSBvbiB0aGVtLg0K
LQkgKi8NCi0JaWYgKGlvdl9pdGVyX2lzX2t2ZWMoaXRlcikpDQotCQlzaG1fZ2V0X2tlcm5lbF9w
YWdlcyhzaG0tPnBhZ2VzLCBudW1fcGFnZXMpOw0KLQ0KIAlzaG0tPm9mZnNldCA9IG9mZjsNCiAJ
c2htLT5zaXplID0gbGVuOw0KIAlzaG0tPm51bV9wYWdlcyA9IG51bV9wYWdlczsNCkBAIC00OTcs
MTAgKzQ3Miw4IEBAIHJlZ2lzdGVyX3NobV9oZWxwZXIoc3RydWN0IHRlZV9jb250ZXh0ICpjdHgs
IHN0cnVjdCBpb3ZfaXRlciAqaXRlciwgdTMyIGZsYWdzLA0KIA0KIAlyZXR1cm4gc2htOw0KIGVy
cl9wdXRfc2htX3BhZ2VzOg0KLQlpZiAoIWlvdl9pdGVyX2lzX2t2ZWMoaXRlcikpDQorCWlmIChp
dGVyX2lzX3V2ZWMoaXRlcikpDQogCQl1bnBpbl91c2VyX3BhZ2VzKHNobS0+cGFnZXMsIHNobS0+
bnVtX3BhZ2VzKTsNCi0JZWxzZQ0KLQkJc2htX3B1dF9rZXJuZWxfcGFnZXMoc2htLT5wYWdlcywg
c2htLT5udW1fcGFnZXMpOw0KIGVycl9mcmVlX3NobV9wYWdlczoNCiAJa2ZyZWUoc2htLT5wYWdl
cyk7DQogZXJyX2ZyZWVfc2htOg0KLS0gDQoyLjUxLjANCg0K
