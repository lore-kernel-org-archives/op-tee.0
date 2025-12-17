Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A8AD6555E
	for <op-tee@archiver.kernel.org>; Wed, 17 Dec 2025 12:24:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 744614315E
	for <op-tee@archiver.kernel.org>; Wed, 17 Dec 2025 12:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765974241;
	bh=Dbw+wemE0qXv+vVK+3pEg0NFkOQ/yshufK/8XvsLiJ8=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=TP+qe8fbZsu1T0kbKZ8tFfiWSI4LKBy5eVQpg3tSSU1eVDutYcg4bf/U4R4ybK7Pa
	 kEdsuStIpzyxpuk+/ehG0YYhpa8MzWJxynM8t+V/0t8DXSRDIHB2CrQvO6dxjiudZS
	 EGjNUbukIlEMPADVF88mUrR2AvZwqO7NKsio3GsvdfZ2MZLHrj9Td/c6rIOBb8pCDr
	 aJ6l04EGUmjzXytHIkdx3HUK5S1yzDfrHqmsAW4czsghGPLOvQ/HHJwuv5NUjEr6Uj
	 MdyOKftTdzBoM7AqLkRSgxcnLu2+G8fBz3T7xROYOLnUf+QS71mpTcT4Bgq7hfsreN
	 0w4rEkTg/XYtQ==
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9B87E40AD0
	for <op-tee@lists.trustedfirmware.org>; Wed, 17 Dec 2025 12:23:44 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=forissier.org header.i=@forissier.org header.a=rsa-sha256 header.s=google header.b=FUuy1ZTx;
	dkim-atps=neutral
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c363eb612so4185866a91.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 17 Dec 2025 04:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier.org; s=google; t=1765974224; x=1766579024; darn=lists.trustedfirmware.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NNqU5G1+bOHIgyxPUjuwkHdORAAeTRQSjJBMD39z25g=;
        b=FUuy1ZTxh6jiqpRQ7HNdBlJqmjJFc2m05sOOZPXWCBf2H3yFuPqhHANRlQUAn0mRbk
         9Pifq5pRlZQZb/j0wWS69RWl3DfH72BU5Y2TyE34pOqSJ6nsEhH2Z8nP68+VVZOFA95m
         DDWmcq5URk2W2p5qiInDrnimS9+Ji6hwCx9/pCtLPVCAIh3XrYaexbJ6Qpe1BH0e4NEm
         qyQ8j53TxoE25ozlLcBq9sfLR/2RwXikNcJ5cL9NM10p6fXJ4pDFXg51UyIsxaAzQ/pg
         NvGbqjWD//nDi0a4/yKLWo1x9atsXFhvFx3QPRCbyAV/fyR9ZA0aB5ONYEQEoxo88shW
         89cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765974224; x=1766579024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNqU5G1+bOHIgyxPUjuwkHdORAAeTRQSjJBMD39z25g=;
        b=DK5uI+k7fl3Lxe9pRr2Aw0Drxb3OzxG/9XQtOwaNiv/J1j2Xam6v3Jcv3jVwp2WIuV
         +boABfcem/9iDfzbLMUtrApp4FRwRz3Kk5f+CIzdeeUIc/z2sk45RQYwQEMjmwBiO3/p
         fV4KGFdchbtKIRNDMYVhOg1g+uRLYFaAfXL1MULpOOJ+NAlr3mk5qd5pMr4XnJAjdRrX
         WjFCgfhOVBvEXosbUW2m5JaiF2N/LLBTXI7q3KT1VtWKw+wt8L2n997y6iPE1JXU1UFj
         u32KGHVTKQS3Ko/qJ9Wi7SlGo8AuKuACI2l/3WXBZagVKXrlMdQyC3f2yRv8kjbgnOFC
         Ut/A==
X-Forwarded-Encrypted: i=1; AJvYcCV08r1yUUu05tYonFH+33QrUEHDDA3GXaPSCJ0Ugm9MQWsVID6zUAcN93CA19yVzCOF7NKt7tQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yyr0+51Hq+nz0d584TdPJ+yRbQQKGU9LEIpu9OAWlGUnySPc1o7
	jlZeFNxfNjuZek291RqOzetkHKEYyPe8OTJwqOefnB/qMfXpBHO0ad2q9pOKDl0E60+qOAbc4jS
	ey2zTUkQAdqZuAPro3P2P9ihdhRgLoFnCLJmYlBap4g==
X-Gm-Gg: AY/fxX5XtcG2SQafS3v8IkwPgQxBSwHbT81De5OepolCCbM6A/4pTvuYgD10ZWC+gE+
	5zJRoKKysaw9UhTO+ilCgpGZj0o0VwYIc1krCpxD5w1d4oheZ2qrZyJwRG5t4na27DEMwvQaJLz
	Rw1E5MgSbLT/b0WL4MhRCt3rq32n0W99/FQA61QrnTEFJ4MtThEGBtBhCCcHEWqyYVucCcM3eyI
	sMxkUcPvoVcm9w/hspgkEQ4WKwLbIUDt7fVTJPdxJhq44hEC5PYwtPBcvBd4PWUx+9UWw==
X-Google-Smtp-Source: AGHT+IGBozllb/2h1ea2qiEh7ICSHUWvUqikLzwQ3tfjItVoV9tpEMJjMoXRDDyLItiPcMewTe/HjX4bZvzBh/GbJGw=
X-Received: by 2002:a17:90b:3910:b0:343:e2ba:e8be with SMTP id
 98e67ed59e1d1-34abd6da7afmr16631309a91.10.1765974223546; Wed, 17 Dec 2025
 04:23:43 -0800 (PST)
MIME-Version: 1.0
References: <aUBbXjP7B0jDVkeN@stanley.mountain> <f76a7766-08b9-4bc9-9d04-0ed61087ccc0@linaro.org>
 <aUFynAjN13O_ai_P@stanley.mountain>
In-Reply-To: <aUFynAjN13O_ai_P@stanley.mountain>
Date: Wed, 17 Dec 2025 13:23:31 +0100
X-Gm-Features: AQt7F2ojcinNI4rZN865Y9XIEIlXI5m-KSQFIT7ynNINpMal0_zxRa6uWBQE3zI
Message-ID: <CAA-cTWZa2jxmBg4iWNZr948XeNECgwizkeZRKN3ZvbdxLpJ8gg@mail.gmail.com>
Subject: Re: build breakage with SCMI
To: Dan Carpenter <dan.carpenter@linaro.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.85 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	R_MIXED_CHARSET(1.25)[subject];
	URI_HIDDEN_PATH(1.00)[https://github.com/OP-TEE/optee_os/blob/master/.github/workflows/ci.yml#L226];
	DMARC_POLICY_ALLOW(-0.50)[forissier.org,reject];
	R_DKIM_ALLOW(-0.20)[forissier.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.216.42:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.42:from];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[forissier.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9B87E40AD0
X-Spamd-Bar: -
Message-ID-Hash: EJVM65Y4J7JL4AUKXDC4AFRLY3IN2E55
X-Message-ID-Hash: EJVM65Y4J7JL4AUKXDC4AFRLY3IN2E55
X-MailFrom: jerome@forissier.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
CC: Jerome Forissier <jerome.forissier@linaro.org>, Valentin Caron <valentin.caron@foss.st.com>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EJVM65Y4J7JL4AUKXDC4AFRLY3IN2E55/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: =?utf-8?q?J=C3=A9r=C3=B4me_Forissier_via_OP-TEE?= <op-tee@lists.trustedfirmware.org>
Reply-To: =?UTF-8?B?SsOpcsO0bWUgRm9yaXNzaWVy?= <jerome@forissier.org>

T24gVHVlLCBEZWMgMTYsIDIwMjUgYXQgMzo1NOKAr1BNIERhbiBDYXJwZW50ZXIgPGRhbi5jYXJw
ZW50ZXJAbGluYXJvLm9yZz4NCndyb3RlOg0KDQo+IE9uIFR1ZSwgRGVjIDE2LCAyMDI1IGF0IDEx
OjUzOjEzQU0gKzAxMDAsIEplcm9tZSBGb3Jpc3NpZXIgd3JvdGU6DQo+ID4gSGkgRGFuLA0KPiA+
DQo+ID4gT24gMTIvMTUvMjUgMjA6MDIsIERhbiBDYXJwZW50ZXIgd3JvdGU6DQo+ID4gPiBXaGVu
IEkgdHJ5IGJ1aWxkaW5nIHdpdGggYG1ha2UgcnVuIFdJVEhfU0NNST15YCB0aGVuIHRoZSBidWls
ZCBmYWlsczoNCj4gPiA+DQo+ID4gPiBjb3JlL2xpYi9zY21pLXNlcnZlci9zY21pX3NlcnZlci5j
OiBJbiBmdW5jdGlvbg0KPiDigJhzY21pX3NlcnZlcl9pbml0aWFsaXpl4oCZOg0KPiA+ID4gY29y
ZS9saWIvc2NtaS1zZXJ2ZXIvc2NtaV9zZXJ2ZXIuYzo4MzoyMjogZXJyb3I6IGltcGxpY2l0IGRl
Y2xhcmF0aW9uDQo+IG9mIGZ1bmN0aW9uIOKAmHNjbWlfY29uZmlndXJl4oCZIFstV2ltcGxpY2l0
LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0KPiA+ID4gICAgODMgfCAgICAgICAgICAgICAgICAgcmMg
PSBzY21pX2NvbmZpZ3VyZShjZmcpOw0KPiA+ID4gICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICBefn5+fn5+fn5+fn5+fg0KPiA+ID4NCj4gPiA+IFRoaXMgd2FzIGludHJvZHVjZWQgaW4gY29t
bWl0IGNlNmVhNDExMjAwOCAoInNjbWktc2VydmVyOiBjb25maWd1cmUNCj4gPiA+IFNDUC1maXJt
d2FyZSBmcm9tIERUIikuICBBIGdyZXAgZm9yIHNjbWlfY29uZmlndXJlKCkgdHVybnMgdXAgZW1w
dHkuDQo+ID4gPiBXYXMgcGFydCBvZiB0aGUgY29tbWl0IG1pc3Npbmc/DQo+ID4NCj4gPiBJIHN1
c3BlY3QgeW91ciBTQ1AtZmlybXdhcmUgc291cmNlIHRyZWUgaXMgdG9vIG9sZC4gUGxlYXNlIHNl
ZToNCj4gPg0KPiBodHRwczovL2dpdGh1Yi5jb20vT1AtVEVFL29wdGVlX29zL2Jsb2IvbWFzdGVy
Ly5naXRodWIvd29ya2Zsb3dzL2NpLnltbCNMMjI2DQo+ID4NCj4NCj4gSHVoLiAgVGhhbmtzLiAg
VGhhdCBmaXhlcyB0aGUgYnVpbGQuICBJIGhhZCB1c2VkIHRoaXMgY29tbWFuZDoNCj4NCj4gcmVw
byBpbml0IC11IGh0dHBzOi8vZ2l0aHViLmNvbS9PUC1URUUvbWFuaWZlc3QuZ2l0IC1tIHFlbXVf
djgueG1sDQo+DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9PUC1URUUvbWFuaWZlc3QvYmxvYi9tYXN0
ZXIvcWVtdV92OC54bWwNCj4NCj4gVGhhdCBtYW5pZmVzdCBmaWxlIGNoZWNrcyBvdXQgcmV2aXNp
b249InJlZnMvdGFncy92Mi4xNi4wIiB3aGljaCBkb2Vzbid0DQo+IGJ1aWxkLiAgQWN0dWFsbHks
IGFsbCB0aGUgbWFuaWZlc3QgZmlsZXMgd2hpY2ggcmVmZXJlbmNlIFNDUCBhcmUgdG9vIG9sZDoN
Cj4NCj4gcWVtdV92OC54bWw6ICAgICAgICA8cHJvamVjdCBwYXRoPSJTQ1AtZmlybXdhcmUiDQo+
ICBuYW1lPSJsaW5hcm8tc3dnL1NDUC1maXJtd2FyZS5naXQiDQo+ICByZXZpc2lvbj0icmVmcy90
YWdzL3YyLjE2LjAiIGNsb25lLWRlcHRoPSIxIiAvPg0KPiBzdG0zMm1wMS54bWw6ICAgICAgICA8
cHJvamVjdCBwYXRoPSJzY3AtZmlybXdhcmUiDQo+ICBuYW1lPSJmaXJtd2FyZS9TQ1AtZmlybXdh
cmUuZ2l0IiByZXZpc2lvbj0icmVmcy90YWdzL3YyLjE1LjAiDQo+IHJlbW90ZT0iYXJtLWdpdGxh
YiIgY2xvbmUtZGVwdGg9IjEiIC8+DQo+IHN5bnF1YWNlci54bWw6ICAgICAgICA8cHJvamVjdCBw
YXRoPSJTQ1AtZmlybXdhcmUiDQo+ICBuYW1lPSJBUk0tc29mdHdhcmUvU0NQLWZpcm13YXJlLmdp
dCINCj4gIHJldmlzaW9uPSI1NmQ0ZjUxNWJjZjFiYzFiODQzYWJlMzQzZTljZjlkYzQ0ODk4Y2Ey
IiAvPg0KPg0KPg0KVGhlIGxhdGVzdCByZWxlYXNlIHRhZyBJIGNhbiBzZWUgb24gR2l0TGFiIGlz
IHYyLjE2LjAsIGRvIHlvdSBrbm93IGlmIHRoZXJlDQppcyBnb2luZyB0byBiZSBhIHJlbGVhc2Ug
c29vbj8gSW4gdGhpcyBjYXNlIHdlIGNvdWxkIHdhaXQgYmVmb3JlIHVwZGF0aW5nDQp0aGUgbWFu
aWZlc3RzLiBPdGhlcndpc2UsIHVzaW5nIGEgU0hBLTEgaXMgZmluZS4NCldvdWxkIHlvdSBtaW5k
IGNyZWF0aW5nIGEgcHVsbCByZXF1ZXN0Pw0KDQpUaGFua3MsDQotLSANCkplcm9tZQ0KDQpyZWdh
cmRzLA0KPiBkYW4gY2FycGVudGVyDQo+DQo+DQo=
