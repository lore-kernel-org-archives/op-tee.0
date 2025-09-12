Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92819CA101F
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 09:47:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B9F884FE20
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 09:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1757670428;
	bh=enhGF1+OO7OUI4XIuKvKyyyS6jCeQbgowLDWeX/DwUA=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=GeTEETBJiViss3XkKYmqgz2/nAhCB2MyVB95AzVwYCb+VdqnJPQlAHxfyRlmhfKMc
	 G4zmblZYvNdRb1la8A2W8zOmEpN9ewb7sKJF+SoV8URTxqAikmiHxQeu0bT5WylIUz
	 op8QiFd9cvBY1m+RFP35KtOOUk/Aj4mDI5TSTbXfMSDXMOI+lHBFNuD+QPUSLib4uY
	 YlatwhT819ZqCKocamVvubiIFTkLQWptZsMeMovNxQtnT4stvXGStX694hupbCK9Sr
	 +gJRWRBUYI5CH27grIl9xGUOBzGDaq6AAWw83FVcsW/nvqshRHha/ABteIpXI7iC+X
	 TG9amhDu4sjYg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 93B6E42D0E
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 09:46:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tlHwIS8u;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0EE9E601E8;
	Fri, 12 Sep 2025 09:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C41CC4CEFB;
	Fri, 12 Sep 2025 09:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757670411;
	bh=NegVXeCczBLb95zus6Xi050gA1rei1TvPnU9xQh+Oz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tlHwIS8ug6kpBIrC+YecNbpE7U+PsFjIkpz8qRKv0N8I/dMi05ykyBedvzKGA9d+z
	 UyfCvbqR8D4bmoMvnGGtflnFBLXY07Cqu9o1LLWyrBAIQESt+qlQSE/yQN6l1tMfqr
	 9g1FPoIalkF/eMyh872sL/l8IIbH5Mdp829VHOxyOxi/QSlQdfultYiLZ4b2tJtbGN
	 h48YWJ+Q3mPXk9Fae45hjGdZlsSOEW38Zo4E03YQWNnSW3kVBOv0JU26h21GAFlWTZ
	 s80T7jn2C06bJoLUtOYhmNyu7qpCNhTBotRJ1feUw3EeQDvhlEqhhFZqQZ0HV13QYW
	 btfi9G8AHwzbA==
Date: Fri, 12 Sep 2025 15:16:34 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v12 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
Message-ID: <aMPr-sYzFDlr-R8R@sumit-X1>
References: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
 <CAHUa44Fow6BhkdTki=rt2psOC=dq99cRgwXsVagmQU7fttXyCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAHUa44Fow6BhkdTki=rt2psOC=dq99cRgwXsVagmQU7fttXyCw@mail.gmail.com>
X-Rspamd-Queue-Id: 93B6E42D0E
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: UXSLUGRCDDLQM7BEB6YCTPRHIKXRP2M6
X-Message-ID-Hash: UXSLUGRCDDLQM7BEB6YCTPRHIKXRP2M6
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, Kuldeep Singh <quic_kuldsing@quicinc.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UXSLUGRCDDLQM7BEB6YCTPRHIKXRP2M6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gRnJpLCBTZXAgMTIsIDIwMjUgYXQgMTA6MjE6NTVBTSArMDIwMCwgSmVucyBXaWtsYW5kZXIg
d3JvdGU6DQo+IEhpLA0KPiANCj4gT24gRnJpLCBTZXAgMTIsIDIwMjUgYXQgNjowN+KAr0FNIEFt
aXJyZXphIFphcnJhYmkNCj4gPGFtaXJyZXphLnphcnJhYmlAb3NzLnF1YWxjb21tLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBpbnRyb2R1Y2VzIGEgVHJ1c3RlZCBFeGVj
dXRpb24gRW52aXJvbm1lbnQgKFRFRSkNCj4gPiBkcml2ZXIgZm9yIFF1YWxjb21tIFRFRSAoUVRF
RSkuIFFURUUgZW5hYmxlcyBUcnVzdGVkIEFwcGxpY2F0aW9ucyAoVEFzKQ0KPiA+IGFuZCBzZXJ2
aWNlcyB0byBydW4gc2VjdXJlbHkuIEl0IHVzZXMgYW4gb2JqZWN0LWJhc2VkIGludGVyZmFjZSwg
d2hlcmUNCj4gPiBlYWNoIHNlcnZpY2UgaXMgYW4gb2JqZWN0IHdpdGggc2V0cyBvZiBvcGVyYXRp
b25zLiBDbGllbnRzIGNhbiBpbnZva2UNCj4gPiB0aGVzZSBvcGVyYXRpb25zIG9uIG9iamVjdHMs
IHdoaWNoIGNhbiBnZW5lcmF0ZSByZXN1bHRzLCBpbmNsdWRpbmcgb3RoZXINCj4gPiBvYmplY3Rz
LiBGb3IgZXhhbXBsZSwgYW4gb2JqZWN0IGNhbiBsb2FkIGEgVEEgYW5kIHJldHVybiBhbm90aGVy
IG9iamVjdA0KPiA+IHRoYXQgcmVwcmVzZW50cyB0aGUgbG9hZGVkIFRBLCBhbGxvd2luZyBhY2Nl
c3MgdG8gaXRzIHNlcnZpY2VzLg0KPiA+DQo+IFtzbmlwXQ0KPiANCj4gSSdtIE9LIHdpdGggdGhl
IFRFRSBwYXRjaGVzLCBTdW1pdCBhbmQgSSBoYXZlIHJldmlld2VkIHRoZW0uDQo+IA0KPiBUaGVy
ZSB3ZXJlIHNvbWUgbWlub3IgY29uZmxpY3RzIHdpdGggb3RoZXIgcGF0Y2hlcyBJIGhhdmUgaW4g
dGhlIHBpcGUNCj4gZm9yIHRoaXMgbWVyZ2Ugd2luZG93LCBzbyB0aGlzIHBhdGNoc2V0IGlzIG9u
IHRvcCBvZiB3aGF0IEkgaGF2ZSB0bw0KPiBhdm9pZCBtZXJnZSBjb25mbGljdHMuDQo+IA0KPiBI
b3dldmVyLCB0aGUgZmlybXdhcmUgcGF0Y2hlcyBhcmUgZm9yIGNvZGUgbWFpbnRhaW5lZCBieSBC
asO2cm4uDQo+IEJqw7ZybiwgaG93IHdvdWxkIHlvdSBsaWtlIHRvIGRvIHRoaXM/IENhbiBJIHRh
a2UgdGhlbSB2aWEgbXkgdHJlZSwgb3INCj4gd2hhdCBkbyB5b3Ugc3VnZ2VzdD8NCg0KSSBoYWQg
YW4gb2ZmbGluZSBjaGF0IHdpdGggQW1pciBhYm91dCB0aGlzIGFuZCB0aGVyZSBpcyBhIGJ1aWxk
DQpkZXBlbmRlbmN5IG9mIFFURUUgZHJpdmVyIG9uIGZpcm13YXJlIHBhdGNoZXMgaW4gY2FzZSB0
aGUgcGF0Y2hlcyBnZXRzDQphcHBsaWVkIGluIHJldmVyc2Ugb3JkZXIgKGZpcnN0IFFURUUgcGF0
Y2hlcyBhbmQgdGhlbiBmaXJtd2FyZSBvbmVzKS4NClNvIEkgd291bGQgc3VnZ2VzdCB0aGUgY29t
cGxldGUgcGF0Y2gtc2V0IGdvZXMgdGhyb3VnaCBKZW5zIHRyZWUgZ2l2ZW4NCnRoZSB2ZXJ5IGxp
bWl0ZWQgdGltZSB3ZSBoYXZlLg0KDQpCam9ybiwNCg0KV291bGQgaXQgYmUgZmluZSBmb3IgeW91
IHRvIHByb3ZpZGUgeW91ciBhY2sgZm9yIHRoZSBmaXJtd2FyZSBwYXRjaGVzPw0KDQotU3VtaXQN
Cg0KPiANCj4gSXQncyB1cmdlbnQgdG8gZ2V0IHRoaXMgcGF0Y2hzZXQgaW50byBsaW51eC1uZXh0
IGlmIGl0J3MgdG8gbWFrZSBpdA0KPiBmb3IgdGhlIGNvbWluZyBtZXJnZSB3aW5kb3cuIElkZWFs
bHksIEknZCBsaWtlIHRvIHNlbmQgbXkgcHVsbCByZXF1ZXN0DQo+IHRvIGFybS1zb2MgZHVyaW5n
IHRoaXMgd2Vlay4NCj4gDQo+IENoZWVycywNCj4gSmVucw0KPiANCj4gPg0KPiA+IC0tLQ0KPiA+
IEFtaXJyZXphIFphcnJhYmkgKDExKToNCj4gPiAgICAgICBmaXJtd2FyZTogcWNvbTogdHptZW06
IGV4cG9ydCBzaG1fYnJpZGdlIGNyZWF0ZS9kZWxldGUNCj4gPiAgICAgICBmaXJtd2FyZTogcWNv
bTogc2NtOiBhZGQgc3VwcG9ydCBmb3Igb2JqZWN0IGludm9jYXRpb24NCj4gPiAgICAgICB0ZWU6
IGFsbG93IGEgZHJpdmVyIHRvIGFsbG9jYXRlIGEgdGVlX2RldmljZSB3aXRob3V0IGEgcG9vbA0K
PiA+ICAgICAgIHRlZTogYWRkIGNsb3NlX2NvbnRleHQgdG8gVEVFIGRyaXZlciBvcGVyYXRpb24N
Cj4gPiAgICAgICB0ZWU6IGFkZCBURUVfSU9DVExfUEFSQU1fQVRUUl9UWVBFX1VCVUYNCj4gPiAg
ICAgICB0ZWU6IGFkZCBURUVfSU9DVExfUEFSQU1fQVRUUl9UWVBFX09CSlJFRg0KPiA+ICAgICAg
IHRlZTogaW5jcmVhc2UgVEVFX01BWF9BUkdfU0laRSB0byA0MDk2DQo+ID4gICAgICAgdGVlOiBh
ZGQgUXVhbGNvbW0gVEVFIGRyaXZlcg0KPiA+ICAgICAgIHRlZTogcWNvbTogYWRkIHByaW1vcmRp
YWwgb2JqZWN0DQo+ID4gICAgICAgdGVlOiBxY29tOiBlbmFibGUgVEVFX0lPQ19TSE1fQUxMT0Mg
aW9jdGwNCj4gPiAgICAgICBEb2N1bWVudGF0aW9uOiB0ZWU6IEFkZCBRdWFsY29tbSBURUUgZHJp
dmVyDQo+ID4NCj4gPiAgRG9jdW1lbnRhdGlvbi90ZWUvaW5kZXgucnN0ICAgICAgICAgICAgICB8
ICAgMSArDQo+ID4gIERvY3VtZW50YXRpb24vdGVlL3F0ZWUucnN0ICAgICAgICAgICAgICAgfCAg
OTYgKysrKw0KPiA+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICA3ICsNCj4gPiAgZHJpdmVycy9maXJtd2FyZS9xY29tL3Fjb21fc2NtLmMgICAgICAgICB8IDEx
OSArKysrDQo+ID4gIGRyaXZlcnMvZmlybXdhcmUvcWNvbS9xY29tX3NjbS5oICAgICAgICAgfCAg
IDcgKw0KPiA+ICBkcml2ZXJzL2Zpcm13YXJlL3Fjb20vcWNvbV90em1lbS5jICAgICAgIHwgIDYz
ICsrLQ0KPiA+ICBkcml2ZXJzL3RlZS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgIHwgICAx
ICsNCj4gPiAgZHJpdmVycy90ZWUvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICB8ICAgMSAr
DQo+ID4gIGRyaXZlcnMvdGVlL3Fjb210ZWUvS2NvbmZpZyAgICAgICAgICAgICAgfCAgMTIgKw0K
PiA+ICBkcml2ZXJzL3RlZS9xY29tdGVlL01ha2VmaWxlICAgICAgICAgICAgIHwgICA5ICsNCj4g
PiAgZHJpdmVycy90ZWUvcWNvbXRlZS9hc3luYy5jICAgICAgICAgICAgICB8IDE4MiArKysrKysN
Cj4gPiAgZHJpdmVycy90ZWUvcWNvbXRlZS9jYWxsLmMgICAgICAgICAgICAgICB8IDgyMCArKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy90ZWUvcWNvbXRlZS9jb3JlLmMg
ICAgICAgICAgICAgICB8IDkxNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4g
IGRyaXZlcnMvdGVlL3Fjb210ZWUvbWVtX29iai5jICAgICAgICAgICAgfCAxNjkgKysrKysrDQo+
ID4gIGRyaXZlcnMvdGVlL3Fjb210ZWUvcHJpbW9yZGlhbF9vYmouYyAgICAgfCAxMTMgKysrKw0K
PiA+ICBkcml2ZXJzL3RlZS9xY29tdGVlL3Fjb210ZWUuaCAgICAgICAgICAgIHwgMTg1ICsrKysr
KysNCj4gPiAgZHJpdmVycy90ZWUvcWNvbXRlZS9xY29tdGVlX21zZy5oICAgICAgICB8IDMwNCAr
KysrKysrKysrDQo+ID4gIGRyaXZlcnMvdGVlL3Fjb210ZWUvcWNvbXRlZV9vYmplY3QuaCAgICAg
fCAzMTYgKysrKysrKysrKysNCj4gPiAgZHJpdmVycy90ZWUvcWNvbXRlZS9zaG0uYyAgICAgICAg
ICAgICAgICB8IDE1MCArKysrKw0KPiA+ICBkcml2ZXJzL3RlZS9xY29tdGVlL3VzZXJfb2JqLmMg
ICAgICAgICAgIHwgNjkyICsrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGRyaXZlcnMvdGVl
L3RlZV9jb3JlLmMgICAgICAgICAgICAgICAgICAgfCAxMjcgKysrKy0NCj4gPiAgZHJpdmVycy90
ZWUvdGVlX3ByaXZhdGUuaCAgICAgICAgICAgICAgICB8ICAgNiAtDQo+ID4gIGluY2x1ZGUvbGlu
dXgvZmlybXdhcmUvcWNvbS9xY29tX3NjbS5oICAgfCAgIDYgKw0KPiA+ICBpbmNsdWRlL2xpbnV4
L2Zpcm13YXJlL3Fjb20vcWNvbV90em1lbS5oIHwgIDE1ICsNCj4gPiAgaW5jbHVkZS9saW51eC90
ZWVfY29yZS5oICAgICAgICAgICAgICAgICB8ICA1NCArLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L3Rl
ZV9kcnYuaCAgICAgICAgICAgICAgICAgIHwgIDEyICsNCj4gPiAgaW5jbHVkZS91YXBpL2xpbnV4
L3RlZS5oICAgICAgICAgICAgICAgICB8ICA1NiArLQ0KPiA+ICAyNyBmaWxlcyBjaGFuZ2VkLCA0
NDEwIGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQ0KPiA+IC0tLQ0KPiA+IGJhc2UtY29t
bWl0OiA4YjhhZWZhNWE1YzdkNGE2NTg4M2U1NjUzY2YxMmY5NGMwYjY4ZGJmDQo+ID4gY2hhbmdl
LWlkOiAyMDI0MTIwMi1xY29tLXRlZS11c2luZy10ZWUtc3Mtd2l0aG91dC1tZW0tb2JqLTM2MmM2
NjM0MDUyNw0KPiA+DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IC0tDQo+ID4gQW1pcnJlemEgWmFy
cmFiaSA8YW1pcnJlemEuemFycmFiaUBvc3MucXVhbGNvbW0uY29tPg0KPiA+DQo=
