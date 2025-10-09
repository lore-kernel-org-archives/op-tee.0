Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15DECCD183
	for <op-tee@archiver.kernel.org>; Thu,  9 Oct 2025 15:58:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C9E67431E9
	for <op-tee@archiver.kernel.org>; Thu,  9 Oct 2025 15:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1760025508;
	bh=yflXdarV10vcYRveUWcXjcH338/7fpZ75TGETQSqT2U=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=v7biE4mVu9woPEHtIbfUiIXM1gHKLSras47V5xm+Kd1UZlrYQ+WytFgJRxzYmiAJu
	 CyX1OCgY7n1fMQtlbr7R8bO/8HH4V7dxMp8UijXD8FxTtk8rmnE899uAJvxMPrDGzb
	 Mog3MAadhsnxEvJ9CMds7NXzig5yfy2jMIYXLuL2cZjYL2lnREgK+PhGxH5v9/e4jI
	 tliQdczyB8v81N8ONtG2Wdp+8fcpTuOaX9MJQFPVSGiYBqco5LJetrV78d2avsLPPP
	 kSjIWBD+8d/O2XWIVv2PUDfNyzWlgtW0Myf76DydU7uOoejEMNp7jaAWdDjFM31Oz1
	 JLnxbS4XWIvjw==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C1DB142BF2
	for <op-tee@lists.trustedfirmware.org>; Thu,  9 Oct 2025 15:58:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m3wpdBe+;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1317E451FE;
	Thu,  9 Oct 2025 15:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22403C4CEFE;
	Thu,  9 Oct 2025 15:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025492;
	bh=UKm9SEYPUAsn6ZnlOTERMD4FkIdrAs6P9akhvatSUds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3wpdBe+rOoG5MjQbLZhjSYb3S9cCjSD4QOYd1fzVypV0wj3a0tiUXLzMq4zg0iGk
	 jCWivBcuXP6uj3ZSLlSp1+qTf+e1i70RRQ9UerXmq+Mt0P3U363hXU0eyzXpfp+gqk
	 OYzNuh9DZWCrm50M2GGk/OIhfJtbvcLS6IVdY68xoq3UCIEM/kjHf9j0rerKCtE/Mg
	 8QWj2jXl/fIrCMmal9fa8Tqovvl9sPIsi2fvxfleucAyRTaHGDj8AbyWXCkE6d6WnA
	 5mDTwsehbAwCNDMe72Wz2JjkjSsj6POnuhZdxRxrqJ3f74TMT1GmkCatvXodKzr4yE
	 7HPkCHEi4c5yQ==
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.4] tee: allow a driver to allocate a tee_device without a pool
Date: Thu,  9 Oct 2025 11:54:40 -0400
Message-ID: <20251009155752.773732-14-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: C1DB142BF2
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 3VCSNNOLV4IMMT6F3ZIHQ7OTJ3FI67MJ
X-Message-ID-Hash: 3VCSNNOLV4IMMT6F3ZIHQ7OTJ3FI67MJ
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Sasha Levin <sashal@kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3VCSNNOLV4IMMT6F3ZIHQ7OTJ3FI67MJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sasha Levin via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sasha Levin <sashal@kernel.org>

RnJvbTogQW1pcnJlemEgWmFycmFiaSA8YW1pcnJlemEuemFycmFiaUBvc3MucXVhbGNvbW0uY29t
Pg0KDQpbIFVwc3RyZWFtIGNvbW1pdCA2ZGJjZDVhOWFiNmNiNjY0NGU3ZDcyODUyMWRhMWM5MDM1
ZWM3MjM1IF0NCg0KQSBURUUgZHJpdmVyIGRvZXNuJ3QgYWx3YXlzIG5lZWQgdG8gcHJvdmlkZSBh
IHBvb2wgaWYgaXQgZG9lc24ndA0Kc3VwcG9ydCBtZW1vcnkgc2hhcmluZyBpb2N0bHMgYW5kIGNh
biBhbGxvY2F0ZSBtZW1vcnkgZm9yIFRFRQ0KbWVzc2FnZXMgaW4gYW5vdGhlciB3YXkuIEFsdGhv
dWdoIHRoaXMgaXMgbWVudGlvbmVkIGluIHRoZQ0KZG9jdW1lbnRhdGlvbiBmb3IgdGVlX2Rldmlj
ZV9hbGxvYygpLCBpdCBpcyBub3QgaGFuZGxlZCBjb3JyZWN0bHkuDQoNClJldmlld2VkLWJ5OiBT
dW1pdCBHYXJnIDxzdW1pdC5nYXJnQG9zcy5xdWFsY29tbS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBB
bWlycmV6YSBaYXJyYWJpIDxhbWlycmV6YS56YXJyYWJpQG9zcy5xdWFsY29tbS5jb20+DQpTaWdu
ZWQtb2ZmLWJ5OiBKZW5zIFdpa2xhbmRlciA8amVucy53aWtsYW5kZXJAbGluYXJvLm9yZz4NClNp
Z25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVsLm9yZz4NCi0tLQ0KDQpMTE0g
R2VuZXJhdGVkIGV4cGxhbmF0aW9ucywgbWF5IGJlIGNvbXBsZXRlbHkgYm9ndXM6DQoNCllFUw0K
LSBUaGUgY2hhbmdlIHNpbXBseSBkcm9wcyB0aGUgYHx8ICFwb29sYCBndWFyZCBpbiBgdGVlX2Rl
dmljZV9hbGxvYygpYA0KICAoYGRyaXZlcnMvdGVlL3RlZV9jb3JlLmM6ODkyYCksIHdoaWNoIGN1
cnJlbnRseSByZWplY3RzIGRyaXZlcnMgdGhhdA0KICBpbnRlbnRpb25hbGx5IG9taXQgYSBzaGFy
ZWQtbWVtb3J5IHBvb2wgZXZlbiB0aG91Z2ggdGhlIEFQSSBjb250cmFjdA0KICBhbmQgZG9jcyAo
YGluY2x1ZGUvbGludXgvdGVlX2NvcmUuaDoxMjNgKSBoYXZlIGxvbmcgYWR2ZXJ0aXNlZCBgcG9v
bGANCiAgYXMgb3B0aW9uYWwuIFRvZGF5IHRoYXQgbWlzbWF0Y2ggbWVhbnMgc3VjaCBkcml2ZXJz
IGNhbm5vdCByZWdpc3RlciBhdA0KICBhbGwsIHNvIHVzZXItdmlzaWJsZSBmdW5jdGlvbmFsaXR5
IGlzIGJsb2NrZWQuDQotIE90aGVyIHN1YnN5c3RlbSBjb2RlIGFscmVhZHkgdHJlYXRzIGEgbWlz
c2luZyBwb29sIGFzIGEgdmFsaWQgc3RhdGUNCiAgYW5kIGJhaWxzIG91dCBzYWZlbHk6IHNoYXJl
ZC1tZW1vcnkgYWxsb2NhdG9ycyBjaGVjayBgaWYNCiAgKCF0ZWVkZXYtPnBvb2wpYCBiZWZvcmUg
ZGVyZWZlcmVuY2luZyBpdCBhbmQgcmV0dXJuIGFuIGVycm9yIHRvIHVzZXINCiAgc3BhY2UgKGBk
cml2ZXJzL3RlZS90ZWVfc2htLmM6NzhgKSwgc28gYWxsb3dpbmcgYWxsb2NhdGlvbiB3aXRob3V0
IGENCiAgcG9vbCBkb2VzbuKAmXQgY3JlYXRlIG5ldyBOVUxMIGRlcmVmZXJlbmNlcyBvciBjaGFu
Z2UgYmVoYXZpb3VyIGZvcg0KICBkcml2ZXJzIHRoYXQgZG8gdXNlIHNoYXJlZCBtZW1vcnkuDQot
IEV4aXN0aW5nIGluLXRyZWUgVEVFIGltcGxlbWVudGF0aW9ucyBzdGlsbCBndWFyZCB0aGVpciBw
b29sIHNldHVwIHdpdGgNCiAgYElTX0VSUigpYCBjaGVja3MgKGUuZy4gT1AtVEVFIGluIGBkcml2
ZXJzL3RlZS9vcHRlZS9zbWNfYWJpLmM6MTY1MWApLA0KICBzbyBhIGdlbnVpbmUgZmFpbHVyZSBz
dGlsbCBwcm9wYWdhdGVzIGFuIGVycm9yIGluc3RlYWQgb2Ygc2xpcHBpbmcNCiAgdGhyb3VnaDsg
d2Ugb25seSB1bmJsb2NrIHRoZSBkb2N1bWVudGVkIOKAnG5vIHBvb2zigJ0gY2FzZS4NCi0gVGhl
IHBhdGNoIGlzIHRpbnksIHNlbGYtY29udGFpbmVkLCBhbmQgZG9lc27igJl0IGFsdGVyIGlvY3Rs
cyBvciBkYXRhDQogIHN0cnVjdHVyZXMsIG1ha2luZyB0aGUgcmVncmVzc2lvbiByaXNrIHZlcnkg
bG93IHdoaWxlIGZpeGluZyBhIGxvbmctDQogIHN0YW5kaW5nIHJlYWwgYnVnIHRoYXQgcHJldmVu
dHMgY29tcGxpYW50IGRyaXZlcnMgZnJvbSBsb2FkaW5nLg0KICBCYWNrcG9ydGluZyBrZWVwcyB0
aGUgc3RhYmxlIHRyZWUgY29uc2lzdGVudCB3aXRoIHRoZSBleHBvcnRlZCBURUUgQVBJDQogIGFu
ZCBzdXBwb3J0cyBkb3duc3RyZWFtIGRyaXZlcnMgdGhhdCByZWx5IG9uIHRoZSBkb2N1bWVudGVk
IGJlaGF2aW91ci4NCg0KIGRyaXZlcnMvdGVlL3RlZV9jb3JlLmMgfCAyICstDQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3RlZS90ZWVfY29yZS5jIGIvZHJpdmVycy90ZWUvdGVlX2NvcmUuYw0KaW5kZXggYWNjNzk5
ODc1OGFkOC4uMTMzNDQ3ZjI1MDY1NyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdGVlL3RlZV9jb3Jl
LmMNCisrKyBiL2RyaXZlcnMvdGVlL3RlZV9jb3JlLmMNCkBAIC04ODksNyArODg5LDcgQEAgc3Ry
dWN0IHRlZV9kZXZpY2UgKnRlZV9kZXZpY2VfYWxsb2MoY29uc3Qgc3RydWN0IHRlZV9kZXNjICp0
ZWVkZXNjLA0KIA0KIAlpZiAoIXRlZWRlc2MgfHwgIXRlZWRlc2MtPm5hbWUgfHwgIXRlZWRlc2Mt
Pm9wcyB8fA0KIAkgICAgIXRlZWRlc2MtPm9wcy0+Z2V0X3ZlcnNpb24gfHwgIXRlZWRlc2MtPm9w
cy0+b3BlbiB8fA0KLQkgICAgIXRlZWRlc2MtPm9wcy0+cmVsZWFzZSB8fCAhcG9vbCkNCisJICAg
ICF0ZWVkZXNjLT5vcHMtPnJlbGVhc2UpDQogCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCiAN
CiAJdGVlZGV2ID0ga3phbGxvYyhzaXplb2YoKnRlZWRldiksIEdGUF9LRVJORUwpOw0KLS0gDQoy
LjUxLjANCg0K
