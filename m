Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05D4606A324
	for <op-tee@archiver.kernel.org>; Mon,  2 Nov 2026 19:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=vikl9PUM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b=RalvWQ8B
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3EFBC45459
	for <op-tee@archiver.kernel.org>; Mon,  2 Nov 2026 19:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793647560;
	bh=dpnrpEV8eSlnt3O98CHEO3wHahx2gJTZOYCbzDiucvc=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=vikl9PUMmIv0AScXbMy8D0vEYvmAwbYvQyw48E8oU4thXw4hywFPSD89K/MAFMiQe
	 f54nQH9dxylizyAi0SA6jhbnJx1X0uFfhdLHV0zPwPXCUD9f57IMjM9VdizfDjqqTL
	 rjg0HLIzCRXmif50SZ6ipy8neR705zC62xWTIYYw0T50+bmdpzGYyKDESXNiwZLF2F
	 ORVfzPLafQHpMNuvy/kMCh2w22dgUce43vtby/BI0KN/00m4J9fjfE6Y6mWKKnws0w
	 Oiuug1FRY1sHYR21IfV/lAkDcVJgcSVGxt6A5mZDxDBR6MsIMRw5kRbKAGjkB4FBJy
	 70iTXCFPd2m7g==
Received: from sender-pp-o97.zoho.eu (sender-pp-o97.zoho.eu [136.143.169.97])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5E5F044E04
	for <op-tee@lists.trustedfirmware.org>; Fri, 30 Oct 2026 13:30:38 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b=RalvWQ8B;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; t=1793367008; cv=none;
	d=zohomail.eu; s=zohoarc;
	b=A9QTYqSOo3bLQJAgR4tIp6ph8ZuH4TcVzPv+rsQmJU/LwKPWURUNF7FP10N/Svbnc+xqmJsx8WQs/0J1VI/uZo26LmApNwefq47KtyxXnUGpnoMbIYEng/gH5AIpTBfgUI0Dg4BfEIMZGIoOoscYnRyplzx3rePbFgd8zNw+ZMo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc;
	t=1793367008; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
	bh=tSXBp/mM3Jor62eoR+K0nfkcpAJny/xKBd3jSXD8N24=;
	b=gmKkpzbjBAM1L6k5XrY/PVKCzxoVx+U8p1pd35Ft2fK3ocu+I0ljT5RNawN6W1dewLby3y4uRc7jV97LcJYuGyJCLozwiEJwhYzBaEDNFWnz1XUFsCpFGOsec4yMiqpf46ogYbm5OCfKzkpt4+W893W7vNf5MzkIJjj5mhina7s=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=zohomail.eu;
	spf=pass  smtp.mailfrom=harukak@zohomail.eu;
	dmarc=pass header.from=<harukak@zohomail.eu>
DKIM-Signature: a=rsa-sha256; b=RalvWQ8BXTsUpsi+4S/3Dgoky4EHifL+ya2v85ZkxqAFWxP9utljouo/4UMtBA+MCpIM1TfHV16Oxe13oBtfJIOP84pge6445lNSU4yX4Hgs+wTFeQtRlt6DR5byfTc5t1CFmG/S+gRxrqOWmMYXWT/jo6SEOrvKOY4m//LPOfA=; c=relaxed/relaxed; s=zoho; d=zohomail.eu; v=1; bh=tSXBp/mM3Jor62eoR+K0nfkcpAJny/xKBd3jSXD8N24=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793367005105963.2039853294061;
	Fri, 30 Oct 2026 14:30:05 +0100 (CET)
To: Jens Wiklander <jenswi@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 0/2] rpmb: add virtio RPMB driver
Date: Fri, 30 Oct 2026 22:29:58 +0900
Message-ID: <20261030133000.24147-1-harukak@zohomail.eu>
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
	R_DKIM_ALLOW(-0.20)[zohomail.eu:s=zoho];
	ONCE_RECEIVED(0.20)[];
	R_SPF_ALLOW(-0.20)[+ip4:136.143.169.0/24:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:205111, ipnet:136.143.169.0/24, country:NL];
	RCPT_COUNT_TWELVE(0.00)[15];
	RWL_MAILSPIKE_POSSIBLE(0.00)[136.143.169.97:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,linuxfoundation.org,gmail.com,redhat.com,linux.alibaba.com,kernel.org,linaro.org,sandisk.com,oss.qualcomm.com,lists.linux.dev,lists.trustedfirmware.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[136.143.169.97:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[zohomail.eu:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5E5F044E04
X-Spamd-Bar: ---
X-MailFrom: harukak@zohomail.eu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: AEVTLV2VS7EKESIMJHUXKK4SZ2KT757V
X-Message-ID-Hash: AEVTLV2VS7EKESIMJHUXKK4SZ2KT757V
X-Mailman-Approved-At: Mon, 02 Nov 2026 19:24:47 +0000
CC: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Wang <jasowangio@gmail.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Sumit Garg <sumit.garg@kernel.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Tomas Winkler <tomas.winkler@sandisk.com>, Ulf Hansson <ulfh@kernel.org>, Harald Mommer <harald.mommer@oss.qualcomm.com>, virtualization@lists.linux.dev, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AEVTLV2VS7EKESIMJHUXKK4SZ2KT757V/>
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
QUlORVJTLiBJIHdvdWxkIGxpa2UgdG8gbWFpbnRhaW4gdGhlIGRyaXZlci4NCg0KQ2hhbmdlcyBp
biB2MzoNCi0gVGFrZSBhIHNwaW5sb2NrIGFyb3VuZCB0aGUgdmlydHF1ZXVlIG9wZXJhdGlvbnMs
IHNvIHRoZSBjb21wbGV0aW9uDQogIGNhbGxiYWNrIGNhbiBub3QgY2FsbCB2aXJ0cXVldWVfZ2V0
X2J1ZigpIHdoaWxlIGEgbmV3IHJlcXVlc3QgaXMNCiAgYWRkZWQgKHNhc2hpa28pDQotIERvIG5v
dCBkZWxldGUgdGhlIHZpcnRxdWV1ZSB0d2ljZSB3aGVuIHJlc3RvcmUgZmFpbGVkIChzYXNoaWtv
KQ0KLSBFeHBsYWluIHRoZSByZWxpYWJsZV93cl9jb3VudCBjYWxjdWxhdGlvbiBpbiBhIGNvbW1l
bnQNCi0gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MTAyOTEyNDEzMi4yMzU0
MzE0LTEtaGFydWtha0B6b2hvbWFpbC5ldS8NCg0KQ2hhbmdlcyBpbiB2MjoNCi0gVXNlIGd1YXJk
KCkgYW5kIHNjb3BlZF9ndWFyZCgpIGZvciB0aGUgbG9ja3MgaW4gYm90aCBwYXRjaGVzIChHcmVn
KQ0KLSBDYWxsIHZpcnRpb19kZXZpY2VfcmVhZHkoKSBiZWZvcmUgdnItPnZxIGlzIHNldCwgc28g
YSByZXF1ZXN0IG9uDQogIHJlc3RvcmUgY2FuIG5vdCBraWNrIHRoZSBxdWV1ZSBiZWZvcmUgRFJJ
VkVSX09LIChzYXNoaWtvKQ0KLSB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYx
MDI5MDgxMzE3LjIyNjQ4ODctMS1oYXJ1a2FrQHpvaG9tYWlsLmV1Lw0KDQotIGhhcnVrYQ0KDQpb
MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIwNDA1MDkzNzU5LjExMjY4MzUtMS1h
bGV4LmJlbm5lZUBsaW5hcm8ub3JnLw0KDQpIYXJ1a2EgS3V6ZSAoMik6DQogIHJwbWI6IHN0b3Ag
dGhlIHJvdXRpbmcgYWZ0ZXIgdW5yZWdpc3Rlcg0KICBycG1iOiBhZGQgYSB2aXJ0aW8gUlBNQiBk
ZXZpY2UgZHJpdmVyDQoNCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICB8ICAgNyAr
DQogZHJpdmVycy9taXNjL0tjb25maWcgICAgICAgICAgICAgfCAgMTAgKysNCiBkcml2ZXJzL21p
c2MvTWFrZWZpbGUgICAgICAgICAgICB8ICAgMSArDQogZHJpdmVycy9taXNjL3JwbWItY29yZS5j
ICAgICAgICAgfCAgMTQgKy0NCiBkcml2ZXJzL21pc2MvdmlydGlvX3JwbWIuYyAgICAgICB8IDMw
MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9saW51eC9ycG1iLmgg
ICAgICAgICAgICAgfCAgIDQgKw0KIGluY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcnBtYi5oIHwg
IDU2ICsrKysrKw0KIDcgZmlsZXMgY2hhbmdlZCwgMzkxIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9taXNjL3ZpcnRpb19ycG1iLmMNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19ycG1iLmgNCg0KDQpi
YXNlLWNvbW1pdDogYzMzOWY0MDEwZGVhOGIwZDc1NGY4NGFjZTcwY2QxYjA4OTg3OGVmOA0KLS0g
DQoyLjU1LjANCg0K
