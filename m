Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A318CAC597
	for <op-tee@archiver.kernel.org>; Mon, 15 Sep 2025 14:05:50 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4842F41938
	for <op-tee@archiver.kernel.org>; Mon, 15 Sep 2025 14:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1757945149;
	bh=SvHMWyYdR4qjHLGPmBZkMX9M9zpP/B8P6V6mKohBf/Y=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=cjTblL/yRdy6IByg6UrVf+K1Isph45ZuRdGeQqxsRdcS1NA/UiE1jSU9p84PVKWLK
	 2+B/JdWSzjopGZQVEYGA0ovEiFX0Id2lGOS8Ff0DsS/f8oNtEAI21t/Uk7b3NxVeAV
	 EVj2dZnZatFXh39+BVYl3Vclz4aG9P8raDU8vAnPJ7hzalT+kG1d/YDUsuPVclMnFe
	 rXDIHmHxMB/u3iYFOzifdw6EBwR4Pt32YSdnUBl7rbrH/80IEa5hqwjk2IGqJkoA8j
	 iIyrTVZ0m4c50eouLfqclEDcsY+sU+H8rW4XCJvvK98ne7gJD597g2Ptq9hh0HNsiD
	 tG6jiGkskL6Xg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 790AE40ADA
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Sep 2025 14:05:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PJgoLG9Y;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BE782419E4;
	Mon, 15 Sep 2025 14:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8C5C4CEF1;
	Mon, 15 Sep 2025 14:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757945134;
	bh=GGWTXMnsvErJb2h3pKbkZRJqvllX1YeT8+dWpSMY+/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJgoLG9YCmgt/nfsqCliDQBcjNMtYABcybsaMDTjh1bl0ymbH+apjITS/WVMSd6H2
	 FCgmQMGvGYGol8RvvSRn1LlT9ZY25PrmEzQP2JGgm01OAGhRp0si+U79SmkWDvGjqe
	 rlSHNu9d5JHHeV4bpGBBzPcVP4r9OUQQ6JJk9LQZUxQQ6nuVA9Ty3Fq3j4rbPPvOD0
	 AhjaEG2rrSs5t/GbahnkGV5qFCyER11d2F9HXc/ZICObO5842j0Osm7GpRL+otdRvP
	 csfLk4s5J75pR85kMulqQ+uYAMDoPoHO1g0ojJ6fEOcs08cO6M2eUfp9FH9uNpQkvs
	 j+IfO+Wrica8w==
Date: Mon, 15 Sep 2025 09:05:31 -0500
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v12 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
Message-ID: <mir6lhkj456ra3i6w7def4rrtzw663f66l66cz4s3gxxvueeqk@ils2hjklbp4y>
References: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
 <CAHUa44Fow6BhkdTki=rt2psOC=dq99cRgwXsVagmQU7fttXyCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAHUa44Fow6BhkdTki=rt2psOC=dq99cRgwXsVagmQU7fttXyCw@mail.gmail.com>
X-Rspamd-Queue-Id: 790AE40ADA
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: VU5JBTLYWFWVL7SJIS2OUWSLGCHDU33O
X-Message-ID-Hash: VU5JBTLYWFWVL7SJIS2OUWSLGCHDU33O
X-MailFrom: andersson@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, Kuldeep Singh <quic_kuldsing@quicinc.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VU5JBTLYWFWVL7SJIS2OUWSLGCHDU33O/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Bjorn Andersson via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Bjorn Andersson <andersson@kernel.org>

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
IFRFRSBwYXRjaGVzLCBTdW1pdCBhbmQgSSBoYXZlIHJldmlld2VkIHRoZW0uDQo+IA0KDQpIYXBw
eSB0byBoZWFyIHRoYXQuDQoNCj4gVGhlcmUgd2VyZSBzb21lIG1pbm9yIGNvbmZsaWN0cyB3aXRo
IG90aGVyIHBhdGNoZXMgSSBoYXZlIGluIHRoZSBwaXBlDQo+IGZvciB0aGlzIG1lcmdlIHdpbmRv
dywgc28gdGhpcyBwYXRjaHNldCBpcyBvbiB0b3Agb2Ygd2hhdCBJIGhhdmUgdG8NCj4gYXZvaWQg
bWVyZ2UgY29uZmxpY3RzLg0KPiANCj4gSG93ZXZlciwgdGhlIGZpcm13YXJlIHBhdGNoZXMgYXJl
IGZvciBjb2RlIG1haW50YWluZWQgYnkgQmrDtnJuLg0KPiBCasO2cm4sIGhvdyB3b3VsZCB5b3Ug
bGlrZSB0byBkbyB0aGlzPyBDYW4gSSB0YWtlIHRoZW0gdmlhIG15IHRyZWUsIG9yDQo+IHdoYXQg
ZG8geW91IHN1Z2dlc3Q/DQo+IA0KDQpQbGVhc2UgcHVsbDoNCg0KaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvcWNvbS9saW51eC5naXQgMjAyNTA5MTEtcWNv
bS10ZWUtdXNpbmctdGVlLXNzLXdpdGhvdXQtbWVtLW9iai12MTItMi0xN2YwN2E5NDJiOGRAb3Nz
LnF1YWxjb21tLmNvbQ0KDQpSZWdhcmRzLA0KQmpvcm4NCg0KPiBJdCdzIHVyZ2VudCB0byBnZXQg
dGhpcyBwYXRjaHNldCBpbnRvIGxpbnV4LW5leHQgaWYgaXQncyB0byBtYWtlIGl0DQo+IGZvciB0
aGUgY29taW5nIG1lcmdlIHdpbmRvdy4gSWRlYWxseSwgSSdkIGxpa2UgdG8gc2VuZCBteSBwdWxs
IHJlcXVlc3QNCj4gdG8gYXJtLXNvYyBkdXJpbmcgdGhpcyB3ZWVrLg0KPiANCj4gQ2hlZXJzLA0K
PiBKZW5zDQo+IA0KPiA+DQo+ID4gLS0tDQo+ID4gQW1pcnJlemEgWmFycmFiaSAoMTEpOg0KPiA+
ICAgICAgIGZpcm13YXJlOiBxY29tOiB0em1lbTogZXhwb3J0IHNobV9icmlkZ2UgY3JlYXRlL2Rl
bGV0ZQ0KPiA+ICAgICAgIGZpcm13YXJlOiBxY29tOiBzY206IGFkZCBzdXBwb3J0IGZvciBvYmpl
Y3QgaW52b2NhdGlvbg0KPiA+ICAgICAgIHRlZTogYWxsb3cgYSBkcml2ZXIgdG8gYWxsb2NhdGUg
YSB0ZWVfZGV2aWNlIHdpdGhvdXQgYSBwb29sDQo+ID4gICAgICAgdGVlOiBhZGQgY2xvc2VfY29u
dGV4dCB0byBURUUgZHJpdmVyIG9wZXJhdGlvbg0KPiA+ICAgICAgIHRlZTogYWRkIFRFRV9JT0NU
TF9QQVJBTV9BVFRSX1RZUEVfVUJVRg0KPiA+ICAgICAgIHRlZTogYWRkIFRFRV9JT0NUTF9QQVJB
TV9BVFRSX1RZUEVfT0JKUkVGDQo+ID4gICAgICAgdGVlOiBpbmNyZWFzZSBURUVfTUFYX0FSR19T
SVpFIHRvIDQwOTYNCj4gPiAgICAgICB0ZWU6IGFkZCBRdWFsY29tbSBURUUgZHJpdmVyDQo+ID4g
ICAgICAgdGVlOiBxY29tOiBhZGQgcHJpbW9yZGlhbCBvYmplY3QNCj4gPiAgICAgICB0ZWU6IHFj
b206IGVuYWJsZSBURUVfSU9DX1NITV9BTExPQyBpb2N0bA0KPiA+ICAgICAgIERvY3VtZW50YXRp
b246IHRlZTogQWRkIFF1YWxjb21tIFRFRSBkcml2ZXINCj4gPg0KPiA+ICBEb2N1bWVudGF0aW9u
L3RlZS9pbmRleC5yc3QgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgRG9jdW1lbnRhdGlvbi90
ZWUvcXRlZS5yc3QgICAgICAgICAgICAgICB8ICA5NiArKysrDQo+ID4gIE1BSU5UQUlORVJTICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDcgKw0KPiA+ICBkcml2ZXJzL2Zpcm13YXJl
L3Fjb20vcWNvbV9zY20uYyAgICAgICAgIHwgMTE5ICsrKysNCj4gPiAgZHJpdmVycy9maXJtd2Fy
ZS9xY29tL3Fjb21fc2NtLmggICAgICAgICB8ICAgNyArDQo+ID4gIGRyaXZlcnMvZmlybXdhcmUv
cWNvbS9xY29tX3R6bWVtLmMgICAgICAgfCAgNjMgKystDQo+ID4gIGRyaXZlcnMvdGVlL0tjb25m
aWcgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICBkcml2ZXJzL3RlZS9NYWtlZmls
ZSAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgZHJpdmVycy90ZWUvcWNvbXRlZS9L
Y29uZmlnICAgICAgICAgICAgICB8ICAxMiArDQo+ID4gIGRyaXZlcnMvdGVlL3Fjb210ZWUvTWFr
ZWZpbGUgICAgICAgICAgICAgfCAgIDkgKw0KPiA+ICBkcml2ZXJzL3RlZS9xY29tdGVlL2FzeW5j
LmMgICAgICAgICAgICAgIHwgMTgyICsrKysrKw0KPiA+ICBkcml2ZXJzL3RlZS9xY29tdGVlL2Nh
bGwuYyAgICAgICAgICAgICAgIHwgODIwICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+
ICBkcml2ZXJzL3RlZS9xY29tdGVlL2NvcmUuYyAgICAgICAgICAgICAgIHwgOTE1ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy90ZWUvcWNvbXRlZS9tZW1fb2Jq
LmMgICAgICAgICAgICB8IDE2OSArKysrKysNCj4gPiAgZHJpdmVycy90ZWUvcWNvbXRlZS9wcmlt
b3JkaWFsX29iai5jICAgICB8IDExMyArKysrDQo+ID4gIGRyaXZlcnMvdGVlL3Fjb210ZWUvcWNv
bXRlZS5oICAgICAgICAgICAgfCAxODUgKysrKysrKw0KPiA+ICBkcml2ZXJzL3RlZS9xY29tdGVl
L3Fjb210ZWVfbXNnLmggICAgICAgIHwgMzA0ICsrKysrKysrKysNCj4gPiAgZHJpdmVycy90ZWUv
cWNvbXRlZS9xY29tdGVlX29iamVjdC5oICAgICB8IDMxNiArKysrKysrKysrKw0KPiA+ICBkcml2
ZXJzL3RlZS9xY29tdGVlL3NobS5jICAgICAgICAgICAgICAgIHwgMTUwICsrKysrDQo+ID4gIGRy
aXZlcnMvdGVlL3Fjb210ZWUvdXNlcl9vYmouYyAgICAgICAgICAgfCA2OTIgKysrKysrKysrKysr
KysrKysrKysrKysNCj4gPiAgZHJpdmVycy90ZWUvdGVlX2NvcmUuYyAgICAgICAgICAgICAgICAg
ICB8IDEyNyArKysrLQ0KPiA+ICBkcml2ZXJzL3RlZS90ZWVfcHJpdmF0ZS5oICAgICAgICAgICAg
ICAgIHwgICA2IC0NCj4gPiAgaW5jbHVkZS9saW51eC9maXJtd2FyZS9xY29tL3Fjb21fc2NtLmgg
ICB8ICAgNiArDQo+ID4gIGluY2x1ZGUvbGludXgvZmlybXdhcmUvcWNvbS9xY29tX3R6bWVtLmgg
fCAgMTUgKw0KPiA+ICBpbmNsdWRlL2xpbnV4L3RlZV9jb3JlLmggICAgICAgICAgICAgICAgIHwg
IDU0ICstDQo+ID4gIGluY2x1ZGUvbGludXgvdGVlX2Rydi5oICAgICAgICAgICAgICAgICAgfCAg
MTIgKw0KPiA+ICBpbmNsdWRlL3VhcGkvbGludXgvdGVlLmggICAgICAgICAgICAgICAgIHwgIDU2
ICstDQo+ID4gIDI3IGZpbGVzIGNoYW5nZWQsIDQ0MTAgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRp
b25zKC0pDQo+ID4gLS0tDQo+ID4gYmFzZS1jb21taXQ6IDhiOGFlZmE1YTVjN2Q0YTY1ODgzZTU2
NTNjZjEyZjk0YzBiNjhkYmYNCj4gPiBjaGFuZ2UtaWQ6IDIwMjQxMjAyLXFjb20tdGVlLXVzaW5n
LXRlZS1zcy13aXRob3V0LW1lbS1vYmotMzYyYzY2MzQwNTI3DQo+ID4NCj4gPiBCZXN0IHJlZ2Fy
ZHMsDQo+ID4gLS0NCj4gPiBBbWlycmV6YSBaYXJyYWJpIDxhbWlycmV6YS56YXJyYWJpQG9zcy5x
dWFsY29tbS5jb20+DQo+ID4NCg==
