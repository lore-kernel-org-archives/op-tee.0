Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D658C5DF74
	for <op-tee@archiver.kernel.org>; Tue, 18 Aug 2026 05:25:27 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3ABBA44F5D
	for <op-tee@archiver.kernel.org>; Tue, 18 Aug 2026 05:25:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q423vN6o;
	dkim-atps=neutral
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 73BCD44E03
	for <op-tee@lists.trustedfirmware.org>; Tue, 18 Aug 2026 03:38:13 +0000 (UTC)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7377dde7bc6so374407137.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 17 Aug 2026 20:38:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787024293; cv=none;
        d=google.com; s=arc-20260327;
        b=TamQWsdG113yubQqcSz47G91t7HYlBV+RbenScRKfs79pgBxIx/zcf6z51f25B6ipD
         IAiShLFhc06ZyTHdnXO0IBtDrOnVoq7X0Jo3/MBIM0EeZSvckHcoy9Rdu2Ad15HSZq63
         KHeIZ8pHOE7XjaQvizsF+ZzHRzoB79dmzDDmPAvZKIUeS//RwjhxL9ErtYi6bSBKcZ1Z
         sGr7DfU75OKN7uM+fp0bjt86wlpHRKCqDCyK78Av3GriYDQIKqPmrBOL3g0Mwi+oteVt
         4fVdSRkyo8rs5sGkDOSre3lIFPyyz2QlCxU83VxV4Xh55szJiSiYUHhimThLhHz1SuNI
         miYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=gIrEwK5CI1wCUC0awV1Bsr5u1ODZXD5P1uKctypD5+E=;
        fh=7v/QesuSdWkBwu0IbhtwEFJ6FT/jSiil7hvGUN2anLE=;
        b=PDjjoLC6vovMAOGsWj0budD7u+yAUM7johUNv61XeAruz+OcvPo5SzAtRjr4TXiVgx
         8l1WFz4eh4UIhrhnS/bNfDzjiIC9FYIce87b33z8Oloiu3/D3J8gAJpAnMIVbylDSXjZ
         qdxV+1AoNj2OjpVlV1QvUO/tKb4r9iUfdUNT0zWejx9V2iWVhUtmGF4Hxx2qvxE0Fmzw
         +ePSjIRPlJvJeSqumDcG31+sPi1JxA47kM4X2FHzubTOGZ2jahCc5apN6t6UrON+JmNc
         voHs5KZDHdDkQGqEsgT552lB5P+FbzXrhLcQCOHnS5SJs4RkJkFTrmkbWjTH/8LxSNMB
         Z6Tw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787024293; x=1787629093; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gIrEwK5CI1wCUC0awV1Bsr5u1ODZXD5P1uKctypD5+E=;
        b=Q423vN6o4eX7ohW+ysZSiAKO3Qc42FEN/m+v2F9vxL58OHLG5l1MxvCII92ECGVA0P
         Mx1sIwkmokDzHKHGcSDa3OkoxsDtMR+SEul3ZEM3ZOkd4ZgfFneqsQbWBmGcK507DQRM
         4obzOBEz5uFctrZbWKPWl/70OvyzeSFWvMbX08FJn/wFBMgviBQS6FLUgNlNtHF4gdac
         xWt5s6WISGQ2nhlRGjySQHw0L86u9BsxHG+cMiRkfcM61pSp8KmTGxGOwcUw7Vu+1J/B
         eTqfP+aHcn5eEUDe7LQYpWdchYfih2Cl7uMdWh+NK1lnUt3FgHVF8DXy5cUeF+bzpItj
         X6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787024293; x=1787629093;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gIrEwK5CI1wCUC0awV1Bsr5u1ODZXD5P1uKctypD5+E=;
        b=Md7qLzv8Kn2BCPcLLHC5zI3VFQaJkQwS/xZZoU1aZDufiN93V2bahKeouiuyn4uOZM
         9itlX2gZVeVCWhQ0u0bEXji1E+T4YLkQc5yx0/7wWYdpcnE0Y5ov8d25vBVhBJuf5dzp
         kb8T+U4Aa+N962U7kc5ov5oRbotQoTgKHKXmSeAid+EvclaLaBwSZX+dO6ymE/NsmJFw
         jUe36ePDcaWVXB743669Rp6XanN6TwXnjbqzJyGeYOSNQNkkkG0LnlOAVcvAa1MLR+W6
         iqgp7RJWCCZs/M25p/k9ctQ59vWQOxRMoyEzxGucyKf19r00KqhEsNOeX8Ac/LZfriO1
         H7tw==
X-Forwarded-Encrypted: i=1; AHgh+RrI1FuWNjfo2gPlY1mvJefB6r8mMcLHB5kkxD7kcTVdxgk9y5RL/oT6gzagfKOqbOb3H1+wtG8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxGKGSqO8FGxfVejQLaWhKuI7TpD7QNhxjr2JJiVYk15pPsUvQr
	UBXpAt6ca0qWz9sxWKgoPZ2YPXD0VLqOUpD5foM7W6t1gMqQyeondMwUMR0MYLSu4WCI2+g6dfr
	/gonMdIBb+kjO2lWoWOd3HXeh08zxTAc=
X-Gm-Gg: AR+sD10PfMyVDfmGxSGY2vdpKEqI1ImrVPHe9q5xdMTeuDrNf92mczKtDxVlI9tZvw9
	KVA7puk3tcdP758CIACHhR3q7xiItE/T4hAwhoMIM9VjTOYJSARVkL/j3LOnFk8Pgcvd/m1ySdK
	rqPqY5irJ9qQm/sFw1US6O2k/WpTZqBxLSVmnfYuumG3R6WkQzkGCfCBISDqT7iCRnwVsng6RyR
	LFBJZEaiCi2XePBlfkaHNWLV8hkasvg6qI+sNRobEZwX+RNHljin083Drv2cdWIGId21AiPAejY
	Pe50SAlGy14WG39oIaJErQJ8CuqGWQA8PlvyYvoCrKgXoYlccVAINBW9MNMcxh7NrwTm1oO9iM8
	mum7c/q8=
X-Received: by 2002:a05:6102:8412:b0:745:36ea:415b with SMTP id
 ada2fe7eead31-774a0c393b7mr609976137.5.1787024292933; Mon, 17 Aug 2026
 20:38:12 -0700 (PDT)
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Aug 2026 22:38:11 -0500
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Aug 2026 03:38:11 +0000
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
In-Reply-To: <9f11db59-5245-4bd5-afbb-485500d37675@oss.qualcomm.com>
References: <9f11db59-5245-4bd5-afbb-485500d37675@oss.qualcomm.com>
MIME-Version: 1.0
Date: Mon, 17 Aug 2026 22:38:11 -0500
X-Gm-Features: AcwNN1U-AVOWmBeBV57CTV0WGb83EoYnz9v6x-yh3VQbi21K0NLNvm86S_SBKxA
Message-ID: <CAO8wpHw-J_A8bDL1MPnhXtVKSR1O4HCXbox1-eq2of5GU2wYKg@mail.gmail.com>
Subject: Re: Re: [PATCH] tee: qcomtee: fix kernel-doc warnings
To: amirreza.zarrabi@oss.qualcomm.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.217.52:from];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.217.52:from];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[gmail.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 73BCD44E03
X-Spamd-Bar: -----
X-MailFrom: bbnpreetsingh@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: HG74HUHV7YR3XHVYWQJFPULNEHQYGVIM
X-Message-ID-Hash: HG74HUHV7YR3XHVYWQJFPULNEHQYGVIM
X-Mailman-Approved-At: Tue, 18 Aug 2026 05:25:20 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
CC: jenswi@kernel.org, sumit.garg@kernel.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HG74HUHV7YR3XHVYWQJFPULNEHQYGVIM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGkgSmVucywNCg0KR2VudGxlIHBpbmcuIEFtaXJyZXphIHJldmlld2VkIHRoaXMgYSBjb3VwbGUg
b2Ygd2Vla3MgYmFjayDigJQgaXMgdGhlcmUNCmFueXRoaW5nIHlvdSBuZWVkIGZyb20gbWUgYmVm
b3JlIGl0IGNhbiBiZSBwaWNrZWQgdXA/DQoNClRoYW5rcywNCkJhYmFucHJlZXQNCg0KT24gTW9u
LCBBdWcgMDMsIDIwMjYgMDg6NDkgUE0sIEFtaXJyZXphIFphcnJhYmkgPA0KYW1pcnJlemEuemFy
cmFiaUBvc3MucXVhbGNvbW0uY29tPiB3cm90ZToNCg0KPiBIaSBCYWJhbnByZWV0LA0KPg0KPiBU
aGFua3MuDQo+DQo+IFJldmlld2VkLWJ5OiBBbWlycmV6YSBaYXJyYWJpIDxhbWlycmV6YS56YXJy
YWJpQG9zcy5xdWFsY29tbS5jb20+DQo+DQo+IEFtaXINCj4NCj4gT24gOC8yLzIwMjYgMTA6Mzkg
QU0sIEJhYmFucHJlZXQgU2luZ2ggd3JvdGU6DQo+ID4gRml4IGtlcm5lbC1kb2MgaXNzdWVzIHBy
ZXNlbnQgc2luY2UgdGhlIGRyaXZlciB3YXMgYWRkZWQgaW4gY29tbWl0DQo+ID4gZDZlMjkwODM3
ZTUwICgidGVlOiBhZGQgUXVhbGNvbW0gVEVFIGRyaXZlciIpOg0KPiA+DQo+ID4gLSBhc3luY19y
ZWxlYXNlKCkgZG9jdW1lbnRzIGl0cyBzZWNvbmQgcGFyYW1ldGVyIGFzIEBtc2csIGJ1dCB0aGUN
Cj4gPiAgIHBhcmFtZXRlciBpcyBuYW1lZCBhc3luY19tc2cgKG1zZyBpcyBhIGxvY2FsIHZhcmlh
YmxlKTsNCj4gPiAtIHN0cnVjdCBxY29tdGVlX21zZ19vYmplY3RfaW52b2tlIGRvY3VtZW50cyBt
ZW1iZXIgQGN0eCwgYnV0IHRoZQ0KPiA+ICAgbWVtYmVyIGlzIG5hbWVkIGN4dDsNCj4gPiAtIGVu
dW0gcWNvbXRlZV9hcmdfdHlwZSBsZWF2ZXMgUUNPTVRFRV9BUkdfVFlQRV9OUiB1bmRlc2NyaWJl
ZC4NCj4gPg0KPiA+IFRoZSBjeHQgc3BlbGxpbmcgaXMgcGFydCBvZiB0aGUgUVRFRSBtZXNzYWdl
IGZvcm1hdCBhbmQgaXMgdXNlZA0KPiA+IHRocm91Z2hvdXQgdGhlIGRyaXZlcjsgc3RydWN0IHFj
b210ZWVfbXNnX2NhbGxiYWNrIGluIHRoZSBzYW1lIGhlYWRlcg0KPiA+IGFscmVhZHkgZG9jdW1l
bnRzIGl0IGFzIEBjeHQsIHNvIHRoZSBjb21tZW50IGlzIGNvcnJlY3RlZCByYXRoZXIgdGhhbg0K
PiA+IHRoZSBtZW1iZXIuDQo+ID4NCj4gPiBObyBmdW5jdGlvbmFsIGNoYW5nZXMuDQo+ID4NCj4g
PiBBc3Npc3RlZC1ieTogQ2xhdWRlOmNsYXVkZS1vcHVzLTUgW2tlcm5lbC1kb2NdDQo+ID4gU2ln
bmVkLW9mZi1ieTogQmFiYW5wcmVldCBTaW5naCA8YmJucHJlZXRzaW5naEBnbWFpbC5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvdGVlL3Fjb210ZWUvYXN5bmMuYyAgICAgICAgICB8IDQgKyst
LQ0KPiA+ICBkcml2ZXJzL3RlZS9xY29tdGVlL3Fjb210ZWVfbXNnLmggICAgfCAyICstDQo+ID4g
IGRyaXZlcnMvdGVlL3Fjb210ZWUvcWNvbXRlZV9vYmplY3QuaCB8IDEgKw0KPiA+ICAzIGZpbGVz
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3RlZS9xY29tdGVlL2FzeW5jLmMgYi9kcml2ZXJzL3RlZS9xY29tdGVl
L2FzeW5jLmMNCj4gPiBpbmRleCAzMWJmZjQzMDllNjcyLi41ODQ5ZTUxNjEyMDMzIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvdGVlL3Fjb210ZWUvYXN5bmMuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
dGVlL3Fjb210ZWUvYXN5bmMuYw0KPiA+IEBAIC05NywxMCArOTcsMTAgQEAgc3RhdGljIHZvaWQg
cWNvbXRlZV9nZXRfYXN5bmNfYnVmZmVyKHN0cnVjdA0KPiBxY29tdGVlX29iamVjdF9pbnZva2Vf
Y3R4ICpvaWMsDQo+ID4gIC8qKg0KPiA+ICAgKiBhc3luY19yZWxlYXNlKCkgLSBQcm9jZXNzIFFU
RUUgYXN5bmMgcmVsZWFzZSByZXF1ZXN0cy4NCj4gPiAgICogQG9pYzogY29udGV4dCB1c2VkIGZv
ciB0aGUgY3VycmVudCBpbnZvY2F0aW9uLg0KPiA+IC0gKiBAbXNnOiBhc3luYyBtZXNzYWdlIGZv
ciBvYmplY3QgcmVsZWFzZS4NCj4gPiArICogQGFzeW5jX21zZzogYXN5bmMgbWVzc2FnZSBmb3Ig
b2JqZWN0IHJlbGVhc2UuDQo+ID4gICAqIEBzaXplOiBzaXplIG9mIHRoZSBhc3luYyBidWZmZXIg
YXZhaWxhYmxlLg0KPiA+ICAgKg0KPiA+IC0gKiBSZXR1cm46IFNpemUgb2YgdGhlIG91dGJvdW5k
IGJ1ZmZlciB1c2VkIHdoZW4gcHJvY2Vzc2luZyBAbXNnLg0KPiA+ICsgKiBSZXR1cm46IFNpemUg
b2YgdGhlIG91dGJvdW5kIGJ1ZmZlciB1c2VkIHdoZW4gcHJvY2Vzc2luZyBAYXN5bmNfbXNnLg0K
PiA+ICAgKi8NCj4gPiAgc3RhdGljIHNpemVfdCBhc3luY19yZWxlYXNlKHN0cnVjdCBxY29tdGVl
X29iamVjdF9pbnZva2VfY3R4ICpvaWMsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3QgcWNvbXRlZV9hc3luY19tc2dfaGRyICphc3luY19tc2csDQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdGVlL3Fjb210ZWUvcWNvbXRlZV9tc2cuaA0KPiBiL2RyaXZlcnMvdGVlL3Fjb210
ZWUvcWNvbXRlZV9tc2cuaA0KPiA+IGluZGV4IDg3OGY3MDE3OGE1YjYuLjVkN2IyMWZkZDM2ODgg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy90ZWUvcWNvbXRlZS9xY29tdGVlX21zZy5oDQo+ID4g
KysrIGIvZHJpdmVycy90ZWUvcWNvbXRlZS9xY29tdGVlX21zZy5oDQo+ID4gQEAgLTExMiw3ICsx
MTIsNyBAQCB1bmlvbiBxY29tdGVlX21zZ19hcmcgew0KPiA+DQo+ID4gIC8qKg0KPiA+ICAgKiBz
dHJ1Y3QgcWNvbXRlZV9tc2dfb2JqZWN0X2ludm9rZSAtIERpcmVjdCBvYmplY3QgaW52b2NhdGlv
biBtZXNzYWdlLg0KPiA+IC0gKiBAY3R4OiBvYmplY3QgSUQgaG9zdGVkIGluIFFURUUuDQo+ID4g
KyAqIEBjeHQ6IG9iamVjdCBJRCBob3N0ZWQgaW4gUVRFRS4NCj4gPiAgICogQG9wOiBvcGVyYXRp
b24gZm9yIHRoZSBvYmplY3QuDQo+ID4gICAqIEBjb3VudHM6IG51bWJlciBvZiBkaWZmZXJlbnQg
dHlwZXMgb2YgYXJndW1lbnRzIGluIEBhcmdzLg0KPiA+ICAgKiBAYXJnczogYXJyYXkgb2YgYXJn
dW1lbnRzLg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RlZS9xY29tdGVlL3Fjb210ZWVfb2Jq
ZWN0LmgNCj4gYi9kcml2ZXJzL3RlZS9xY29tdGVlL3Fjb210ZWVfb2JqZWN0LmgNCj4gPiBpbmRl
eCA4YjQ0MDFlY2FkNDhjLi5kNWRlMDJkY2VmM2I5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
dGVlL3Fjb210ZWUvcWNvbXRlZV9vYmplY3QuaA0KPiA+ICsrKyBiL2RyaXZlcnMvdGVlL3Fjb210
ZWUvcWNvbXRlZV9vYmplY3QuaA0KPiA+IEBAIC03NCw2ICs3NCw3IEBAIGVudW0gcWNvbXRlZV9v
YmplY3RfdHlwZSB7DQo+ID4gICAqIEBRQ09NVEVFX0FSR19UWVBFX09POiBvdXRwdXQgb2JqZWN0
IChPTykuDQo+ID4gICAqIEBRQ09NVEVFX0FSR19UWVBFX0lCOiBpbnB1dCBidWZmZXIgKElCKS4N
Cj4gPiAgICogQFFDT01URUVfQVJHX1RZUEVfSU86IGlucHV0IG9iamVjdCAoSU8pLg0KPiA+ICsg
KiBAUUNPTVRFRV9BUkdfVFlQRV9OUjogbnVtYmVyIG9mIGFyZ3VtZW50IHR5cGVzLg0KPiA+ICAg
Kg0KPiA+ICAgKiBVc2UgdGhlIGludmFsaWQgdHlwZSB0byBzcGVjaWZ5IHRoZSBlbmQgb2YgdGhl
IGFyZ3VtZW50IGFycmF5Lg0KPiA+ICAgKi8NCj4NCj4NCg==
