Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3933AD3B7E5
	for <op-tee@archiver.kernel.org>; Mon, 29 Dec 2025 08:11:22 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 70E2F4FE91
	for <op-tee@archiver.kernel.org>; Mon, 29 Dec 2025 08:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1766995881;
	bh=0TV5dj0yRk85CYXlwkY2tzU/i7OpJdaJiQyK8mcULgA=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=eqzxz3nen/UBV+q0tZHhV6jFSfC30CsqQRajxd4qwhJeULg1pUd44S2eoOuEfz23r
	 HK8yWB4oYLm6REFwmhUF2jCKxN73dxkkIilVhYbId9tuh6OQqoKOKNSLq+Ka4FCEFp
	 SNjvRP/VGDFljacWfVVIH484Vj7D3DIFLCr2x7gjP+Cx7prgz1imFCby2TCKZPyc5s
	 1zDYCe1WSS+JoW50HX/hiI2whB6h0yPYTwCoTcYQQYh+pDTm7hc2kHGe1ld1Qg+BmL
	 NQoCGXytLcOT41chvonxrwxwYNYWP59KXquzXBkV2TH8hxOP4g5B4+PcUyMYV2mhBZ
	 fwwzjlcg66IZg==
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CCD3441855
	for <op-tee@lists.trustedfirmware.org>; Tue, 23 Dec 2025 03:33:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=NZHvOwHf;
	dkim-atps=neutral
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EE7D63FB7A
	for <op-tee@lists.trustedfirmware.org>; Tue, 23 Dec 2025 03:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1766460805;
	bh=lVCxrlF7FHwqXKZZb1CMswRbmazuR5+zvey6bIzOBUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=NZHvOwHfHlN/GzbYlmcqpjWznE+4FzXSVtUfLoU2aSGLzjRRaZxRhE7q+U6pcPhMw
	 Pzr58pQHd1pGNeuxDJgiFZtOWNx7CFhpiEaemNF5hHwZYpABwpdkGPOlnxe3Afvphx
	 XB71EanHBpxFRoBRUuzboeenPgDU8VWOnfpoVky9IDOOJRpwv2xHPByO1vHqbvAODJ
	 SRLGvzMjjgxGRa2VUGAeCTYDzhl7reXdSniPtKkc/p4ZkzoeNwK7RSj2ncHnLVLRsd
	 p7BmSkEN1sQ48jRmcQkniBE/d5Cu0B4NPu3GI9AGspiFO0V8cDA3bc33L2er9d4keM
	 z8oYixR6Z9pavqPu2YU1FgHmAjQkt493ChA11aGTCok0TmbEJ9gidhhqPm5p2LyQcO
	 BuJxe8l/3S6dJQdRv0eDDeeT+e6tfIX3WE8vJFQDMePoszWSKiH767EOhe6RFQjMr0
	 j7uEmFXa2bb/mduhRrlxwomxJ5cDTvdNX1Jn0jIFq9AFMpKI6X1b9rqG8XlBUpTSXf
	 m3ostS06B425HkN0fp2U3jBgBSbVcOe+HiKPD35GIbeom91hYkiiZe2Zx+d+KOHJot
	 yx3WStt7fsHeOuodZVEktc/m3Jf15/6r8fGXGTTLw1SETXuFNnIEraTNuip0WR5fOE
	 LCDTMXFZb1n5Q1NpmJB2B8m0=
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b73586b1195so18115466b.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 22 Dec 2025 19:33:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766460804; x=1767065604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVCxrlF7FHwqXKZZb1CMswRbmazuR5+zvey6bIzOBUU=;
        b=iaY3v4bVpixeVy6Ul1MFC8DqqAI5nwJrZMmZo/xnLIt1tmeQY3qRMis6kixdY4Ev0r
         i3xKgIkqJem7fjDvj1soiF4ZBGKT3eumiajGg84N2ZfxsApRGCqHqviukQqEhDL4b4XV
         RwqU1GIkpCI+uk1ntUxwDshVGD3ROT0a4j8VE3yQM1ail0ovs3KbgO3OLJUij8UJRIfC
         xSaWr46Novv/Bi9eex1kgduV9mcaMcGtqud656yzuaekhxfZNrYZ7G/z+cqi5rUUKrDm
         /YizAxieVcpl/2mm6etaZcE8jFUiTB432MRwVlVBCXn4iUF9DDuL61qmuKvjZKFen093
         53PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd1gFRXS8AekNS+AFG9U5B7hzX4lRJRuBw5sIuojqKeEZaVnRi9gKTyweKk2/JqeBBA3p52AY=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yzf5x8IdBVEH0H4dY+TJcmHkZ0Jfum0dPgCbH7lAF+y1tsE6EdL
	TytNi9FGUVVhHTT8P+MiJDrzH//imdI6u4cRQdf7XGP/FyOt2/U9DufNrJagn97NKWc93Q/6uXd
	aGjxWU0dm3YSICfjpQWOwx6b5b1bZoXK56sO1pOq3V1YhwOEdEaNQQiED+QlkMhtd29JILD5qt0
	39DtVsDLwHoVRS4p8fxzhDiincGQJGROAWnwb3+PL0w3FOs6y09/7Ix3FmzozwmA==
X-Gm-Gg: AY/fxX5O3w3AlblIiSKE2vzBBO/DabD9DPTCyaUAlOPR7C/tSE5mfQTrazdt6tJjVV7
	sUIGdukXnibvAFJD0ncaKSdhMUJHQTdL7MX+A/xmeGMkTBXQSkJ5P+ISxUB/ThDCfU/ayfSkTnc
	YYXpYwkiH9BrZ7G6ut8KLb7EQTQfq6gukzoFaWMOCuUyIBLYZCzDqPFjd3Oq5k8LxcP6k=
X-Received: by 2002:a17:907:c14:b0:b80:1309:aa09 with SMTP id a640c23a62f3a-b803718387cmr1420034166b.47.1766460804286;
        Mon, 22 Dec 2025 19:33:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHf27rZDPe+b1nS0yyhjnDlG0ogGXtP2QwqL8pIb6VaxrVJFEYoye3YTmHNx0pTRRnB+VPylC+nYXnZUilf9hw=
X-Received: by 2002:a17:907:c14:b0:b80:1309:aa09 with SMTP id
 a640c23a62f3a-b803718387cmr1420032366b.47.1766460803825; Mon, 22 Dec 2025
 19:33:23 -0800 (PST)
MIME-Version: 1.0
References: <aSVgctqRSy5_vvkN@sumit-X1> <aSVhBn0LR2CwM9p3@sumit-X1>
 <CAJwFiGKuSuiq5LhMS+wVcnhjfiBEDiSCOG9FwhEic+cxmnKJhQ@mail.gmail.com>
 <CAHUa44HUFPy24wZrA03z0KHZqUmbT+dSP+7zOT-zrrFq_-h8mg@mail.gmail.com>
 <CAJwFiGLRVZyr7Hb3PtGyA319hCYEJh9t8XY_amyjhUgqnrZycQ@mail.gmail.com>
 <CAHUa44GPuP+qdw2HPBgtrQNXovA7e5+yskrPRgh4D4OMutEJTA@mail.gmail.com>
 <CAJwFiGLNh-qu9ezQOmTBh3Dujf=mPRyzKBVXLV-A=GxhwcH-0w@mail.gmail.com>
 <CAHUa44Eq=P5G4vKSq5TyJx5qF9E5q=+pHexMg41X85NCX4SpHA@mail.gmail.com>
 <CAJwFiGKw8+T3v3H+=bBtWzV1kuXKBq9gRTWGpS4iS4ictWOAtA@mail.gmail.com>
 <CAHUa44ELXMv+e8dkZ=NwYjg=YoH=1=4JGze89BK+Db8ERozPLg@mail.gmail.com> <aUkYXBz3XfVGrmjD@sumit-xelite>
In-Reply-To: <aUkYXBz3XfVGrmjD@sumit-xelite>
Date: Tue, 23 Dec 2025 11:33:12 +0800
X-Gm-Features: AQt7F2okPdnd-W_UXofpnjuVH2SjoPPL9Hak4X_mGVdLXyCTx18dcU_n4y8N7r0
Message-ID: <CAA=k7==Q8Zb4shHmYY49iAuMw2_OAwtp+TYqkbULjEgPt0b0zQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tee: optee: expose OS revision via sysfs
To: Sumit Garg <sumit.garg@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[canonical.com:dkim];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:185.125.188.122];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	RCVD_IN_DNSWL_MED(-0.20)[185.125.188.122:from];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.71:received];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ARC_NA(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[209.85.218.71:server fail];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,vger.kernel.org,lists.trustedfirmware.org,oss.qualcomm.com,amd.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CCD3441855
X-Spamd-Bar: ----
X-MailFrom: aristo.chen@canonical.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 7TAGIIXIKN3IDDZIRQAFYLS2HTENPGJW
X-Message-ID-Hash: 7TAGIIXIKN3IDDZIRQAFYLS2HTENPGJW
X-Mailman-Approved-At: Mon, 29 Dec 2025 08:10:27 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
CC: Aristo Chen <jj251510319013@gmail.com>, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo Thomas <Rijo-john.Thomas@amd.com>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7TAGIIXIKN3IDDZIRQAFYLS2HTENPGJW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Aristo Chen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>

SGkgSmVucyBhbmQgU3VtaXQsDQoNCk9uIE1vbiwgRGVjIDIyLCAyMDI1IGF0IDY6MDfigK9QTSBT
dW1pdCBHYXJnIDxzdW1pdC5nYXJnQGtlcm5lbC5vcmc+IHdyb3RlOg0KDQo+IE9uIE1vbiwgRGVj
IDIyLCAyMDI1IGF0IDA5OjM0OjI0QU0gKzAxMDAsIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0KPiA+
IEhpIEFyaXN0bywNCj4gPg0KPiA+IE9uIEZyaSwgRGVjIDE5LCAyMDI1IGF0IDQ6MznigK9QTSBB
cmlzdG8gQ2hlbiA8amoyNTE1MTAzMTkwMTNAZ21haWwuY29tPg0KPiB3cm90ZToNCj4gPiA+DQo+
ID4gPiBIaSBKZW5zDQo+ID4gPg0KPiA+ID4gSmVucyBXaWtsYW5kZXIgPGplbnMud2lrbGFuZGVy
QGxpbmFyby5vcmc+IOaWvCAyMDI15bm0MTLmnIg55pel6YCx5LqMIOS4i+WNiDQ6MzHlr6vpgZPv
vJoNCj4gPiA+ID4NCj4gPiA+ID4gSGkgQXJpc3RvLA0KPiA+ID4gPg0KPiA+ID4gPiBPbiBTdW4s
IERlYyA3LCAyMDI1IGF0IDM6MDHigK9QTSBBcmlzdG8gQ2hlbiA8amoyNTE1MTAzMTkwMTNAZ21h
aWwuY29tPg0KPiB3cm90ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEhpIEplbnMsDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiBKZW5zIFdpa2xhbmRlciA8amVucy53aWtsYW5kZXJAbGluYXJvLm9yZz4g
5pa8IDIwMjXlubQxMuaciDPml6XpgLHkuIkNCj4g5LiL5Y2IMzo1MeWvq+mBk++8mg0KPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+IEhpLA0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IE9uIFR1ZSwg
RGVjIDIsIDIwMjUgYXQgMTA6NTTigK9BTSBBcmlzdG8gQ2hlbiA8DQo+IGpqMjUxNTEwMzE5MDEz
QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEhpIEplbnMN
Cj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gSmVucyBXaWtsYW5kZXIgPGplbnMud2lrbGFu
ZGVyQGxpbmFyby5vcmc+IOaWvCAyMDI15bm0MTLmnIgx5pel6YCx5LiADQo+IOS4i+WNiDk6MDbl
r6vpgZPvvJoNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IEhpLA0KPiA+ID4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gT24gTW9uLCBEZWMgMSwgMjAyNSBhdCAxMjo0OOKAr1BN
IEFyaXN0byBDaGVuIDwNCj4gamoyNTE1MTAzMTkwMTNAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+
ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiBIaSwNCj4gPiA+ID4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiA+ID4gPiBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQGtlcm5lbC5vcmc+IOaWvCAy
MDI15bm0MTHmnIgyNeaXpemAseS6jA0KPiDkuIvljYgzOjU15a+r6YGT77yaDQo+ID4gPiA+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgTm92IDI1LCAyMDI1IGF0IDAx
OjIzOjIyUE0gKzA1MzAsIFN1bWl0IEdhcmcgdmlhDQo+IE9QLVRFRSB3cm90ZToNCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiBPbiBNb24sIE5vdiAyNCwgMjAyNSBhdCAwODoxNTowNEFNICswMTAwLCBK
ZW5zDQo+IFdpa2xhbmRlciB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEhpLA0KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIFNhdCwgTm92
IDIyLCAyMDI1IGF0IDQ6MDDigK9QTSBXZWkgTWluZyBDaGVuIDwNCj4gamoyNTE1MTAzMTkwMTNA
Z21haWwuY29tPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gRnJvbTogQXJpc3RvIENoZW4gPGFyaXN0by5jaGVuQGNhbm9uaWNhbC5j
b20+DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IFRvZGF5IHRoZSBvbmx5IHdheSB0byByZWFkIHRoZSBPUC1URUUgT1MgdmVyc2lvbg0KPiBpcyBm
cm9tIGRtZXNnL2pvdXJuYWwNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gbG9ncywgd2hpY2gg
Y2FuIGJlIGxvc3QgYXMgYnVmZmVycyByb2xsIG92ZXIuDQo+IENhcHR1cmUgdGhlIE9TIHJldmlz
aW9uDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IChtYWpvci9taW5vci9idWlsZF9pZCkgZnJv
bSBzZWN1cmUgd29ybGQgZm9yIGJvdGgNCj4gU01DIGFuZCBGRi1BIEFCSXMsIHN0b3JlDQo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IGl0IGluIHRoZSBPUC1URUUgZHJpdmVyLCBhbmQgZXhwb3Nl
IGEgc3RhYmxlDQo+IHVzZXJzcGFjZSByZWFkb3V0IHZpYQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiAvc3lzL2NsYXNzL3RlZS90ZWUqL29wdGVlX29zX3JldmlzaW9uLg0KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBB
cmlzdG8gQ2hlbiA8DQo+IGFyaXN0by5jaGVuQGNhbm9uaWNhbC5jb20+DQo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgZHJpdmVycy90ZWUv
b3B0ZWUvY29yZS5jICAgICAgICAgIHwgMTkNCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiAgZHJpdmVycy90ZWUvb3B0ZWUvZmZhX2FiaS5jICAgICAgIHwg
MTMNCj4gKysrKysrKysrKystLQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgZHJpdmVycy90
ZWUvb3B0ZWUvb3B0ZWVfcHJpdmF0ZS5oIHwgMTcNCj4gKysrKysrKysrKysrKysrKysNCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvdGVlL29wdGVlL3NtY19hYmkuYyAgICAgICB8
IDEzDQo+ICsrKysrKysrKysrLS0NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gIDQgZmlsZXMg
Y2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGlzIGFwcGVhcnMgdG8gYmUgYSBm
ZWF0dXJlIHRoYXQgY291bGQgYmUgdXNlZnVsDQo+IGZvciBhbGwgVEVFcy4NCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFRydWUsIGl0IGlzIHNvbWV0aGluZyB0
aGF0IFRFRSBjb3JlIHNob3VsZCBzdXBwb3J0Lg0KPiBBbHRob3VnaCBJIHdvdWxkDQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gaGF2ZSBwcmVmZXJyZWQgdG8gZXh0ZW5kIFRFRV9JT0NfVkVSU0lPTiBz
aW5jZSB0aGF0J3MNCj4gdGhlIGNvbW1vbiB3YXkgdGhlDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
dXNlci1zcGFjZSBsaWJyYXJ5IGdldCdzIFRFRSBpbXBsZW1lbnRhdGlvbiBzcGVjaWZpYw0KPiBp
bmZvcm1hdGlvbi4gQnV0DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gc2luY2UgaXQgYmVpbmcgYWxy
ZWFkeSBhIHVzZXItc3BhY2UgQUJJIHdoaWNoIGRvZXNuJ3QNCj4gb2ZmZXIgZXh0ZW5zaW9uLg0K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IE1heWJlIHdlIGNhbiBjb25zaWRlciBhZGRpbmcgVEVFX0lP
Q19SRVZFUlNJT04gaW5zdGVhZA0KPiBvZiBzeXNmcy4NCj4gPiA+ID4gPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+ID4gPiA+ID4gQWgsIHR5cG8gaGVyZToNCj4gPiA+ID4gPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+ID4gPiA+ID4gcy9URUVfSU9DX1JFVkVSU0lPTi9URUVfSU9DX1JFVklTSU9OLw0K
PiA+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiAtU3VtaXQNCj4gPiA+ID4g
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IEJ1dCBiZWZvcmUgZG9pbmcgdGhhdCB3ZSBuZWVkIHRvIGtub3cgd2hvIGlzIHRoZQ0KPiBhY3R1
YWwgY29uc3VtZXIgaGVyZQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGZyb20gdXNlci1zcGFjZSBw
ZXJzcGVjdGl2ZT8gV2lsbCB0aGUgY2xpZW50DQo+IGFwcGxpY2F0aW9ucyBhbHNvIGRlcGVuZCBv
bg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHRoZSBURUUgaW1wbGVtZW50YXRpb24gcmV2aXNpb24/
DQo+ID4gPiA+ID4gPiA+ID4gPiBNeSBjdXJyZW50IHRoaW5raW5nIGlzIHRoYXQgaWYgdGhlIFRF
RSByZXZpc2lvbiBpcw0KPiBleHBvc2VkLCB1c2VycyBjYW4gd3JpdGUgYQ0KPiA+ID4gPiA+ID4g
PiA+ID4gc2NyaXB0IHRvIGNhcHR1cmUgdGhlIHBsYXRmb3JtIHN0YXRlIGFuZCByZWNvcmQgdGhl
IGV4YWN0DQo+IHNlY3VyZSBPUyByZXZpc2lvbg0KPiA+ID4gPiA+ID4gPiA+ID4gZXZlbiBhZnRl
ciB0aGUgZG1lc2cvam91cm5hbGN0bCBsb2dzIGhhdmUgcm9sbGVkIG92ZXIuDQo+IFRoaXMgd291
bGQgc2lnbmlmaWNhbnRseQ0KPiA+ID4gPiA+ID4gPiA+ID4gaW1wcm92ZSBidWcgdHJpYWdlIGFu
ZCByZWdyZXNzaW9uIHRyYWNraW5nLg0KPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4g
PiA+IEluIG15IGNhc2UsIEkgaGF2ZSBhIHBhY2thZ2Ugd2l0aCBwcmVjb21waWxlZCB4dGVzdA0K
PiBiaW5hcmllcyBmb3IgbXVsdGlwbGUNCj4gPiA+ID4gPiA+ID4gPiA+IHJlbGVhc2VzIChmcm9t
IDMuMTQgdG8gNC42KSwgYW5kIEkgd29yayB3aXRoIGRpZmZlcmVudA0KPiBwbGF0Zm9ybXMgdGhh
dCBydW4NCj4gPiA+ID4gPiA+ID4gPiA+IGRpZmZlcmVudCBPUC1URUUgT1MgdmVyc2lvbnMuIEhh
dmluZyBhIHJlbGlhYmxlIHdheSB0bw0KPiBvYnRhaW4gdGhlIFRFRQ0KPiA+ID4gPiA+ID4gPiA+
ID4gcmV2aXNpb24gd291bGQgaGVscCBhIGxvdCwgYXMgaXQgd291bGQgYWxsb3cgbWUgdG8gc2Vs
ZWN0DQo+IHRoZSBjb3JyZWN0IHh0ZXN0DQo+ID4gPiA+ID4gPiA+ID4gPiB2ZXJzaW9uIHdoZW4g
cnVubmluZyB0ZXN0cy4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IEknbSBjb25j
ZXJuZWQgdGhhdCB0aGUgQUJJIG1pZ2h0IGJlIG1pc3VzZWQgdG8gYmUgcGFydCBvZg0KPiB3aGF0
IHRoZQ0KPiA+ID4gPiA+ID4gPiA+IGNsaWVudCBleHBlY3RzIGZyb20gdGhlIFRFRS4gWW91IGV2
ZW4gZXhwcmVzcyB0aGF0IGFzIGEgdXNlDQo+IGNhc2UuIEknZA0KPiA+ID4gPiA+ID4gPiA+IHJh
dGhlciBmaXggdGhlIHByb2JsZW0gd2l0aCB4dGVzdC4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+ID4gVGhhbmtzIGZvciB0aGUgZmVlZGJhY2shIFRvIGNsYXJpZnk6IGN1cnJlbnRseSwgdGhl
IE9QLVRFRSBPUw0KPiByZXZpc2lvbg0KPiA+ID4gPiA+ID4gPiBJIGV4cG9zZSBpbg0KPiA+ID4g
PiA+ID4gPiBzeXNmcyBpcyB0aGUgc2FtZSB2YWx1ZSBhbHJlYWR5IHByaW50ZWQgaW4gZG1lc2cg
YXQgYm9vdA0KPiA+ID4gPiA+ID4gPiAgKGUuZy4sIOKAnG9wdGVlOiByZXZpc2lvbiA0LjggKFhY
WFhYWCnigJ0pLg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBBcmUgeW91ciBjb25jZXJu
cyBzcGVjaWZpY2FsbHkgYWJvdXQgY2xpZW50cyBpbmZlcnJpbmcNCj4gY2FwYWJpbGl0aWVzDQo+
ID4gPiA+ID4gPiA+IGZyb20gYSByZXZpc2lvbg0KPiA+ID4gPiA+ID4gPiBzdHJpbmcgKOKAnHJl
diBYLlkgaW1wbGllcyBmZWF0dXJlIFrigJ0pPyBJZiBzbywgSSBhZ3JlZSB0aGF04oCZcw0KPiBm
cmFnaWxlDQo+ID4gPiA+ID4gPiA+IGFuZCBub3QgdGhlIGludGVudC4NCj4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiBZZXMNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoYW5rcyBmb3IgY2xhcmlmeWlu
ZyB0aGUgY29uY2VybiENCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gSeKA
mW0gaGFwcHkgdG8gYWRkIGEgc2hvcnQgbm90ZSBpbiB0aGUgZG9jIHRoYXQgdGhpcyBpcw0KPiBp
bmZvcm1hdGlvbmFsDQo+ID4gPiA+ID4gPiA+IG9ubHkgYW5kIHRoYXQNCj4gPiA+ID4gPiA+ID4g
ZmVhdHVyZSBkZXRlY3Rpb24gbXVzdCB1c2UgcHJvcGVyIGNhcGFiaWxpdHkgcXVlcmllcy4NCj4g
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoYXQgYWRk
cmVzc2VzIHRoZSB3b3JyeSwgb3IgaWYgdGhlcmXigJlzDQo+IGFub3RoZXINCj4gPiA+ID4gPiA+
ID4gY29uY2VybiBJ4oCZbQ0KPiA+ID4gPiA+ID4gPiBtaXNzaW5nLg0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+IEFkZGluZyBBUElzIHRoYXQgYXJlbid0IHN1cHBvc2VkIHRvIGJlIHVzZWQgc2Vl
bXMgb2RkLiBEbyB5b3UNCj4ga25vdyBpZg0KPiA+ID4gPiA+ID4gdGhlcmUgYXJlIGV4YW1wbGVz
IGluIHRoZSBrZXJuZWwgZm9yIHRoaXMga2luZCBvZiB0aGluZz8NCj4gPiA+ID4gPiBJ4oCZdmUg
ZG9uZSBzb21lIHJlc2VhcmNoIGFuZCwgYXMgZmFyIGFzIEkgY2FuIHRlbGwsIHRoZSBURUUgY29y
ZQ0KPiBhbHJlYWR5DQo+ID4gPiA+ID4gcHJvdmlkZXMgYW4gaW5mb3JtYXRpb25hbC1vbmx5IGZp
bGUgYXQNCj4gL3N5cy9jbGFzcy90ZWUvdGVlMC9pbXBsZW1lbnRhdGlvbl9pZC4NCj4gPiA+ID4g
PiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgaXQgd2FzIGludHJvZHVjZWQgcm91Z2hseSAxMCB5
ZWFycyBhZ28uDQo+IEhvd2V2ZXIsDQo+ID4gPiA+ID4gSSBoYXZlbuKAmXQgZm91bmQgYW55IGRv
Y3VtZW50YXRpb24gY2xhcmlmeWluZyBpdHMgaW50ZW5kZWQgcHVycG9zZSwNCj4gc28gSeKAmW0N
Cj4gPiA+ID4gPiBhc3N1bWluZyB0aGlzIG1heSBiZSBhIHNpbWlsYXIgc2l0dWF0aW9uLiBJ4oCZ
ZCBhcHByZWNpYXRlIGl0IGlmIHlvdQ0KPiBjb3VsZCBjb3JyZWN0DQo+ID4gPiA+ID4gbWUgaWYg
SeKAmW0gd3JvbmcuDQo+ID4gPiA+DQo+ID4gPiA+IFRoYXQgb25lIGlzIGZvciBhIHF1aWNrIHdh
eSBmb3IgYSBjbGllbnQgdG8gdGVsbCB0aGUgZGlmZmVyZW50IFRFRQ0KPiA+ID4gPiBkZXZpY2Ug
aW1wbGVtZW50YXRpb25zIGFwYXJ0LiBZb3UncmUgcmlnaHQsIGl0IHJlc2VtYmxlcyB5b3VyIGNh
c2UsDQo+ID4gPiA+IGV4Y2VwdCB0aGF0IHRoaXMgaXMgcGFydCBvZiBhIHdlbGwtZGVmaW5lZCBB
QkkuDQo+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBbHNvLCBoZXJlIGFyZSBzb21lIGZp
bGVzIHdpdGggc2ltaWxpYXIgcHVycG9zZXM6DQo+ID4gPiA+ID4gLSAvc3lzL2RldmljZXMvc3lz
dGVtL2NwdS9jcHUqL21pY3JvY29kZS92ZXJzaW9uDQo+ID4gPiA+ID4gLQ0KPiAvc3lzL2Rldmlj
ZXMvdmlydHVhbC9kbWkvaWQve2Jpb3NfZGF0ZSxiaW9zX3JlbGVhc2UsYmlvc192ZW5kb3IsYmlv
c192ZXJzaW9ufQ0KPiA+ID4gPiA+IC0gL3N5cy9rZXJuZWwvc2VjdXJpdHkvYXBwYXJtb3IvcmV2
aXNpb24NCj4gPiA+ID4NCj4gPiA+ID4gVGhhbmtzLCB0aGlzIGlzIGdvb2QgYmFja2dyb3VuZCBp
bmZvcm1hdGlvbi4NCj4gPiA+ID4NCj4gPiA+ID4gV2UgaGF2ZSBhIEJvRiBzZXNzaW9uIG9uIHRo
ZSBURUUgc3Vic3lzdGVtIGF0IExQQyBvbiBGcmlkYXkgWzFdLg0KPiBXZSdsbA0KPiA+ID4gPiB0
YWtlIHRoZSBvcHBvcnR1bml0eSB0byBkaXNjdXNzIGl0IHRoZXJlLg0KPiA+ID4NCj4gPiA+IEp1
c3QgYSBxdWljayBmb2xsb3ctdXAgb24gdGhpcyBwYXRjaCwgaGFzIHRoZXJlIGJlZW4gYW55IGRl
Y2lzaW9uIG9yDQo+ID4gPiBkaXJlY3Rpb24gZnJvbSB0aGF0IGRpc2N1c3Npb24/DQo+ID4gPiBJ
4oCZbSBoYXBweSB0byByZXdvcmsgdGhlIHBhdGNoIGluIHdoYXRldmVyIGRpcmVjdGlvbiB0aGUg
Z3JvdXAgcHJlZmVycy4NCj4gPg0KPiA+IE5vIG9uZSB3YXMgYWdhaW5zdCBpdC4gV2UgZGlkbid0
IGRpc2N1c3MgdGhlIGRldGFpbHMsIGJ1dCBoZXJlJ3Mgd2hhdA0KPiA+IEknZCBsaWtlIHRvIHNl
ZToNCj4gPiAtIFRoZSBjYWxsYmFjayBuYW1lIHNob3VsZCBiZSBnZXRfdGVlX3JldmlzaW9uKCkg
b3IgZ2V0X3RlZV9md192ZXJzaW9uKCkNCj4gPiAtIFRoZSBGVyB2ZXJzaW9uIGlzIHJldHVybmVk
IGFzIGEgc3RyaW5nIGZvciBmbGV4aWJpbGl0eQ0KPiA+IC0gQSBub3RlIHRoYXQgdGhlIEZXIHZl
cnNpb24gaXMgbm90IGludGVuZGVkIHRvIGJlIHVzZWQgdG8gZGV0ZXJtaW5lDQo+ID4gd2hhdCBm
ZWF0dXJlcywgZXRjLCBhcmUgYXZhaWxhYmxlLCBURUVfSU9DX1ZFUlNJT04gc2hvdWxkIGNvdmVy
IHRoYXQuDQo+ID4NCj4gPiBTdW1pdCwgd2hhdCBkbyB5b3UgdGhpbms/DQo+DQo+IFRoYXQgc291
bmRzIHJlYXNvbmFibGUgdG8gbWUuDQo+DQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjayEgSSB3aWxs
IHByZXBhcmUgVjMgcGF0Y2gNCg0KDQo+DQo+IC1TdW1pdA0KPg0KDQpCZXN0IHJlZ2FyZHMsDQpB
cmlzdG8NCg==
