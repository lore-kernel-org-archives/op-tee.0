Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A30D606A327
	for <op-tee@archiver.kernel.org>; Thu, 29 Oct 2026 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=rqvKDP6J;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b=JIX1Ll9N
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E6008453EA
	for <op-tee@archiver.kernel.org>; Thu, 29 Oct 2026 09:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793265996;
	bh=BdIugdVi24x8O+EY2XqzpooeaXWm2IgoY+sIiozzn6I=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=rqvKDP6Je3qj3tCJUv73b0KQamM1FZtAd5jCS7BFIJ5KRMiLO2cJFTfmppCZolWtm
	 nx1tQek/2j2Q0PkNHmoCVMbFhAT73jHQP4uZrNfhPlkQGT7tJpo9WjBkhx4MJc7bfY
	 weEIGS/F06cLZ6fm2DyfdW/WJHdU9OQm2rVVVy62OTgYGfIDlOhJoOxL5lWrQKsY0R
	 Lnf7BlOfv1+xBYQHnoqSgcE1z1zHfPG4Ho1Z6Cuvh/4BVp+zUiWJ9mNPIYhrXTYvzQ
	 BPsPW3+hZfG4+BaSmzN89eZTYR9Y8L2wDQDCSt012ImtlJ/F5cOVWpCCr9/YyySGmJ
	 u4QgqSKzDBWTg==
Received: from sender-pp-o97.zoho.eu (sender-pp-o97.zoho.eu [136.143.169.97])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6413844E0F
	for <op-tee@lists.trustedfirmware.org>; Thu, 29 Oct 2026 08:13:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b=JIX1Ll9N;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; t=1793261603; cv=none;
	d=zohomail.eu; s=zohoarc;
	b=VcFJ5VshLeWeokJpto4zw5sToBHKLPJ8tum/jznnU3WxJVdcVoJpyOOh6h72mRmCKAGwlpr69hYMNTemqzvwuQ4AreJRcBZcVuPQDm6Dc5Nk/IJftNqL912zLveZqpCO/V7OGIIqJGFx2KHAWAoUiDK7qqe9fnBKCNJ0j7/7kNw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc;
	t=1793261603; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
	bh=o+i10nqF5qXBpuSwTxyLUdRhBjEMSTYWSK5VKJ6ipa4=;
	b=Mqq8bUrEeFFSwdhFgWKrkGaK4rL4g/0FhPmn7gTX5cZlP4qYpBAN6ZTk7o6Z5ZyG9jL50xJHI3DtE+iluHKv1u9jq1QoNX+LPqZai14QND88KW+S3Lwrfs9EUr9oS8ANblXiB8vYDS7lRCCyJMo5tLmz1OXPnOjBTLJRDHdI+hE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=zohomail.eu;
	spf=pass  smtp.mailfrom=harukak@zohomail.eu;
	dmarc=pass header.from=<harukak@zohomail.eu>
DKIM-Signature: a=rsa-sha256; b=JIX1Ll9NlZoXfHuQy6r9be5xVUUafGG480o9XxWugX6A2CNzKf6tTM9+3shIv8DSpQqdLQMn/7A2WlrqgHCH9UwaeEr7OU5PEHuFQ6rqrDdmEBWsrPFHV4xaoO4dl2TXuEdq0VwMxMp6elTxje1eFkjFImrpRNmq2tkUk50qz5A=; c=relaxed/relaxed; s=zoho; d=zohomail.eu; v=1; bh=o+i10nqF5qXBpuSwTxyLUdRhBjEMSTYWSK5VKJ6ipa4=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793261603070644.342366589474;
	Thu, 29 Oct 2026 09:13:23 +0100 (CET)
To: Jens Wiklander <jenswi@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/2] rpmb: add virtio RPMB driver
Date: Thu, 29 Oct 2026 17:13:15 +0900
Message-ID: <20261029081317.2264887-1-harukak@zohomail.eu>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.80 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[zohomail.eu:s=zohoarc:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.eu,reject];
	R_SPF_ALLOW(-0.20)[+ip4:136.143.169.0/24];
	ONCE_RECEIVED(0.20)[];
	R_DKIM_ALLOW(-0.20)[zohomail.eu:s=zoho];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:205111, ipnet:136.143.169.0/24, country:NL];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,linuxfoundation.org,gmail.com,redhat.com,linux.alibaba.com,kernel.org,linaro.org,sandisk.com,oss.qualcomm.com,lists.linux.dev,lists.trustedfirmware.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[136.143.169.97:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[zohomail.eu:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6413844E0F
X-Spamd-Bar: ---
X-MailFrom: harukak@zohomail.eu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: BWAXG2RHPCGXOHBO5HOHUZH3GO4T76SQ
X-Message-ID-Hash: BWAXG2RHPCGXOHBO5HOHUZH3GO4T76SQ
X-Mailman-Approved-At: Thu, 29 Oct 2026 09:26:17 +0000
CC: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Wang <jasowangio@gmail.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Sumit Garg <sumit.garg@kernel.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Tomas Winkler <tomas.winkler@sandisk.com>, Ulf Hansson <ulfh@kernel.org>, Harald Mommer <harald.mommer@oss.qualcomm.com>, virtualization@lists.linux.dev, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BWAXG2RHPCGXOHBO5HOHUZH3GO4T76SQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Haruka Kuze via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Haruka Kuze <harukak@zohomail.eu>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VGhpcyBhZGRzIGEgZHJpdmVyIG9uIHRvcCBvZiB0aGUgcnBtYiBzdWJzeXN0ZW0gZm9yIHZpcnRp
by1ycG1iIGRldmljZXMuDQoNCkFsZXggQmVubsOpZSBoYWQgYW4gZWFybGllciB2aXJ0aW8tcnBt
YiBkcml2ZXIgaW4gaGlzIFJQTUIgc2VyaWVzIFsxXQ0KYnV0IHRoYXQgc3RhbGxlZCBkdWUgdG8g
dGhlIHVzZXIgc3BhY2UgQVBJLg0KDQpUaGUgb25lIHRoYXQgbWVyZ2VkIGxhdGVyIGhhcyBubyB1
c2VyIHNwYWNlIEFQSSBhbmQgT1AtVEVFIHJvdXRlcyBmcmFtZXMNCnRocm91Z2ggaXQgc28gdGhp
cyBkcml2ZXIgb25seSBuZWVkcyB0byBpbXBsZW1lbnQgcm91dGVfZnJhbWVzKCkuDQoNCkkgYWRk
ZWQgcGF0Y2ggMSB0byBmaXggYSB1c2UtYWZ0ZXItZnJlZSB0aGF0IEkgaGl0IHdoaWxlIHRlc3Rp
bmcNCnJlbW92aW5nIHRoZSBkZXZpY2UgKE9QLVRFRSBjYW4gc3RpbGwgcm91dGUgZnJhbWVzIGFm
dGVyIGRyaXZlciB1bnJlZ2lzdGVycw0KdGhlIHJwbWIgZGV2aWNlKS4NCg0KSSB0ZXN0ZWQgdGhp
cyB3aXRoIFVNTCAodmlydGlvX3VtbCkgYW5kIGEgdmhvc3QtdXNlciBiYWNrZW5kIEkgd3JvdGUN
CmZvciB0aGlzIG9uIHRvcCBvZiBydXN0LXZtbSdzIHZob3N0LWRldmljZSB3aXRoIEtBU0FOLCBs
b2NrZGVwOg0KDQogLSBrZXkgcHJvZ3JhbW1pbmcNCiAtIHdyaXRlIGNvdW50ZXINCiAtIHNpbmds
ZSBhbmQgbXVsdGkgYmxvY2sgd3JpdGUgYW5kIHJlYWQNCiAtIE1BQyBhbmQgY291bnRlciBmYWls
dXJlcw0KIC0gbWF4X3dyX2NudA0KIC0gdW5iaW5kaW5nIHRoZSBkcml2ZXIgd2hlbiB0aGUgcnBt
YiBkZXZpY2UgaXMgaGVsZA0KDQpXaXRoIE9QLVRFRSA0LjExIG9uIFFFTVUgdmlydCBhcm02NCB0
aGUgc2VjdXJlX3N0b3JhZ2UgZXhhbXBsZSBUQSBrZWVwcw0KaXRzIG9iamVjdHMgaW4gUlBNQiB0
aHJvdWdoIHRoZSBkcml2ZXIgYW5kIGFuIG9iamVjdCB3cml0dGVuIHRvIGluIG9uZQ0KYm9vdCBp
cyBmb3VuZCBpbiB0aGUgb25lIGFmdGVyLg0KDQpJIGhhdmUgYWRkZWQgbXlzZWxmIGluIE1BSU5U
QUlORVJTLiBJIHdvdWxkIGxpa2UgdG8gbWFpbnRhaW4gdGhlIGRyaXZlci4NCg0KLSBoYXJ1a2EN
Cg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDQwNTA5Mzc1OS4xMTI2ODM1
LTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZy8NCg0KSGFydWthIEt1emUgKDIpOg0KICBycG1iOiBz
dG9wIHRoZSByb3V0aW5nIGFmdGVyIHVucmVnaXN0ZXINCiAgcnBtYjogYWRkIGEgdmlydGlvIFJQ
TUIgZGV2aWNlIGRyaXZlcg0KDQogTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgfCAg
IDcgKw0KIGRyaXZlcnMvbWlzYy9LY29uZmlnICAgICAgICAgICAgIHwgIDEwICsrDQogZHJpdmVy
cy9taXNjL01ha2VmaWxlICAgICAgICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvbWlzYy9ycG1iLWNv
cmUuYyAgICAgICAgIHwgIDIyICsrLQ0KIGRyaXZlcnMvbWlzYy92aXJ0aW9fcnBtYi5jICAgICAg
IHwgMjk0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBpbmNsdWRlL2xpbnV4L3Jw
bWIuaCAgICAgICAgICAgICB8ICAgNCArDQogaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19ycG1i
LmggfCAgNTYgKysrKysrDQogNyBmaWxlcyBjaGFuZ2VkLCAzOTEgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9taXNjL3ZpcnRpb19ycG1i
LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19ycG1iLmgN
Cg0KDQpiYXNlLWNvbW1pdDogYzMzOWY0MDEwZGVhOGIwZDc1NGY4NGFjZTcwY2QxYjA4OTg3OGVm
OA0KLS0gDQoyLjU1LjANCg0K
