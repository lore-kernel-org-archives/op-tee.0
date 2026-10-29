Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA79C606A31A
	for <op-tee@archiver.kernel.org>; Thu, 29 Oct 2026 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=yl3waVPh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b=Z1U5hFl/
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 48908453FD
	for <op-tee@archiver.kernel.org>; Thu, 29 Oct 2026 13:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793280447;
	bh=cg8hUPE5yRx5TYUSfeEjPJqKSIi4SLDf19ZGPB+ktHo=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=yl3waVPhSy3fiOtyWY4O2CfOX/DI/ikF1w6dyHm3eE9F6gFWFwZtdeV+DtOpdulq0
	 xa9wG5jzQ+I02VAr+JEVlDL5/Yr9E0udbUgJHJCiN1K5Y3nipSFlAbFKrRb3wTYknX
	 4ISCyQ4DGZQKzXFQus8nhY7gml3ZpPAE+OBfpIwx+Pu6pnNtziHT38mqq4PQlMhwEr
	 zoYwIgABKCMkh8kAiVpwk6oc68gNVJJYbSRY5/k244w1uM/EbIfuvsTYUiSRFcVOg7
	 JUvKCc1Db8v71J9SJbPwJRdxvFemyDfLD9nHFKhTssi0i1yySEMHTpV1avVBNICKa0
	 4VUXPkLZIVudg==
Received: from sender-pp-o97.zoho.eu (sender-pp-o97.zoho.eu [136.143.169.97])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0F113444C0
	for <op-tee@lists.trustedfirmware.org>; Thu, 29 Oct 2026 12:41:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b=Z1U5hFl/;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; t=1793277698; cv=none;
	d=zohomail.eu; s=zohoarc;
	b=jZm/8o3IRNLR3MMAIs1KqAMSNxmCgqKm1sa6HzDm8xJmCbxf8685lAneencYwKjUX/gaw2PMqttidgZtq8zpCRWu8Xv3VS3FrIUujt2Lvf4/83n2qeq2J8tYLIUg4m2b9gftY2Pyu679h5oSS8heCzXvLlZcr1lMafOgKapABgk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc;
	t=1793277698; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
	bh=IlfCkaxrTaB5puTFuxoOhA7Sw2Q92nX/SaX+B99HdMU=;
	b=HfDz2x7e0Fb+JxwwZ+rYJ3gX3j3LiFonmUtfsSL4+CwtJhkFiEyU2PFpfsM+FuJQPKTm3u5G5xsPKYw3KYYdQ+GdwTHFaiGjMImHN64tpJ8RaSztC8DTqM0E6vp4nEsW4iJge7Hk8I7JBUUicAUmOzDGxR0XyrTkay99f/cocaU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=zohomail.eu;
	spf=pass  smtp.mailfrom=harukak@zohomail.eu;
	dmarc=pass header.from=<harukak@zohomail.eu>
DKIM-Signature: a=rsa-sha256; b=Z1U5hFl/B4IpEM9YQo+HAq/WOk7UCXOo6lYnF9m2TzV8+OqC7lG9bjhxJxHiHiWUY1ifcV4775CGh+3+FpxksjouqtkqzwoV/g/FNcSiOP9vFPpqhFQ/L6XTIgr9Ed4v+Nxn0L+vBDKFF6gafYe1jOgisNJj93sHqBKSvCKgCJU=; c=relaxed/relaxed; s=zoho; d=zohomail.eu; v=1; bh=IlfCkaxrTaB5puTFuxoOhA7Sw2Q92nX/SaX+B99HdMU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793277697278378.4156436187916;
	Thu, 29 Oct 2026 13:41:37 +0100 (CET)
To: Jens Wiklander <jenswi@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 0/2] rpmb: add virtio RPMB driver
Date: Thu, 29 Oct 2026 21:41:30 +0900
Message-ID: <20261029124132.2354314-1-harukak@zohomail.eu>
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:205111, ipnet:136.143.169.0/24, country:NL];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,linuxfoundation.org,gmail.com,redhat.com,linux.alibaba.com,kernel.org,linaro.org,sandisk.com,oss.qualcomm.com,lists.linux.dev,lists.trustedfirmware.org,vger.kernel.org];
	DWL_DNSWL_BLOCKED(0.00)[zohomail.eu:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[136.143.169.97:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[zohomail.eu:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0F113444C0
X-Spamd-Bar: ---
X-MailFrom: harukak@zohomail.eu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 46C5QEEDVC2YCFXULJBYQUDPHKOOI5NU
X-Message-ID-Hash: 46C5QEEDVC2YCFXULJBYQUDPHKOOI5NU
X-Mailman-Approved-At: Thu, 29 Oct 2026 13:27:09 +0000
CC: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Wang <jasowangio@gmail.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Sumit Garg <sumit.garg@kernel.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Tomas Winkler <tomas.winkler@sandisk.com>, Ulf Hansson <ulfh@kernel.org>, Harald Mommer <harald.mommer@oss.qualcomm.com>, virtualization@lists.linux.dev, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/46C5QEEDVC2YCFXULJBYQUDPHKOOI5NU/>
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
biB2MjoNCi0gVXNlIGd1YXJkKCkgYW5kIHNjb3BlZF9ndWFyZCgpIGZvciB0aGUgbG9ja3MgaW4g
Ym90aCBwYXRjaGVzIChHcmVnKQ0KLSBDYWxsIHZpcnRpb19kZXZpY2VfcmVhZHkoKSBiZWZvcmUg
dnItPnZxIGlzIHNldCwgc28gYSByZXF1ZXN0IG9uDQogIHJlc3RvcmUgY2FuIG5vdCBraWNrIHRo
ZSBxdWV1ZSBiZWZvcmUgRFJJVkVSX09LIChzYXNoaWtvKQ0KLSB2MTogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjYxMDI5MDgxMzE3LjIyNjQ4ODctMS1oYXJ1a2FrQHpvaG9tYWlsLmV1
Lw0KDQotIGhhcnVrYQ0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIwNDA1
MDkzNzU5LjExMjY4MzUtMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnLw0KDQpIYXJ1a2EgS3V6ZSAo
Mik6DQogIHJwbWI6IHN0b3AgdGhlIHJvdXRpbmcgYWZ0ZXIgdW5yZWdpc3Rlcg0KICBycG1iOiBh
ZGQgYSB2aXJ0aW8gUlBNQiBkZXZpY2UgZHJpdmVyDQoNCiBNQUlOVEFJTkVSUyAgICAgICAgICAg
ICAgICAgICAgICB8ICAgNyArDQogZHJpdmVycy9taXNjL0tjb25maWcgICAgICAgICAgICAgfCAg
MTAgKysNCiBkcml2ZXJzL21pc2MvTWFrZWZpbGUgICAgICAgICAgICB8ICAgMSArDQogZHJpdmVy
cy9taXNjL3JwbWItY29yZS5jICAgICAgICAgfCAgMTQgKy0NCiBkcml2ZXJzL21pc2MvdmlydGlv
X3JwbWIuYyAgICAgICB8IDI4NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogaW5j
bHVkZS9saW51eC9ycG1iLmggICAgICAgICAgICAgfCAgIDQgKw0KIGluY2x1ZGUvdWFwaS9saW51
eC92aXJ0aW9fcnBtYi5oIHwgIDU2ICsrKysrKw0KIDcgZmlsZXMgY2hhbmdlZCwgMzc3IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9taXNj
L3ZpcnRpb19ycG1iLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS91YXBpL2xpbnV4L3Zp
cnRpb19ycG1iLmgNCg0KDQpiYXNlLWNvbW1pdDogYzMzOWY0MDEwZGVhOGIwZDc1NGY4NGFjZTcw
Y2QxYjA4OTg3OGVmOA0KLS0gDQoyLjU1LjANCg0K
