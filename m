Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F18C83F07
	for <op-tee@archiver.kernel.org>; Mon,  7 Jul 2025 11:26:00 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 48C9742BFA
	for <op-tee@archiver.kernel.org>; Mon,  7 Jul 2025 11:26:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jPVilgQj;
	dkim-atps=neutral
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 09EE23F6B0
	for <op-tee@lists.trustedfirmware.org>; Mon,  7 Jul 2025 07:18:41 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6120049f09fso1668575eaf.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 07 Jul 2025 00:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751872720; x=1752477520; darn=lists.trustedfirmware.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dii6nHNGqkKV38PPLrNqnhdq6HEwzfLWRA5316t8Kog=;
        b=jPVilgQjBsyI9lORmjOjxfKwB28FRN2GB3AxUnDzuUGN1MDvJOh4cSw8UTlRLu7oym
         C/iSUPVm9kcaBVnJdNuY7WGGM6POn4y8dZsPcB1b7eHx6V6ZjYkK/+9wzDtWCrnMgXFa
         AkZuaTquh7zIuG+hEnHbJaq4g/YsalVX4lK3s+76odmWLUedmTBnm9mzmn+yWvMQss0s
         mZCWVS9YtEfD7/pPXPEp3Yawt/E2LVdE+a1uSUkivMYqzqaMNtmBBu5U4fK3v3DATAD6
         KPh/TOQmIpNAC/1gdK13uU1qbPFpk9a5+BnyIvbPpO91pz4lbGpyM027KS5BqR8LToFB
         Ov1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751872720; x=1752477520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dii6nHNGqkKV38PPLrNqnhdq6HEwzfLWRA5316t8Kog=;
        b=gXqE586k3WNxvp17YGKc9ebSyK6n+/aIh6zbjXqFqSi+ooW49/8C28L7HbordUgmQg
         zmyA0CV/7K+TZAhITTYbJ1OUkf5IqYARA/ZiahN52RmsiGWmToe8nOt3PZFUycqeeDn8
         o13++HslY8RyurhApym4OHLSofrfhP3Dl8JtumORKp+AHDO6I5A4vXtjDzKtv4CnefZk
         UanBCqGfeX7mR4AbQ4i2fzyDCR8kmxC9ap6XnD6AKuTlbQDDiL+QIf0Pzq1A81rgWW/p
         TjmMnoz6YA04YXlA8R5sv/3jZhrR+dBEEW3eoApBD30rXT2PB689Ir5c4tXPGo7NyFyd
         yznw==
X-Forwarded-Encrypted: i=1; AJvYcCUQW31Yoc5vL2csA+y8VOky5HfbVcIs/RAwwT0JwUpah9E/pxxrle/LqhnsA6ednqINY4UbmLI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxirWXOzK+UIjbZWHFgyXn99Lu0fhmFbs2m33Pj3tMrqqIwYY/8
	YMeHS6I/NjRYFEZZe2j95j1FPpH/+al4DYCQXHkS+0Mn8I3k9wam0qRnMMyDOGG4lSQcEiTROot
	2GCfNHMiAjy0XlbzZdV6m47CHp8x0dc0=
X-Gm-Gg: ASbGnct+lBlXsULwvJB7v5rV8d7Khvw0yViOobJ328rpGSUAVjZ/RZzD7DSSunVVq7W
	kllHzoRkla0jLdxrZG9e/APhzWWRzIw6JejTkqNvhoLfCRPB/r0rXmRFKCEP9H0DWVqtIt/nAP3
	xut02qbo2Ei9IsWWXoP6hiX7g2oXjFge3si7Vp1ELJk0ruU/tGSxSy6rRaWtJHmbBGMYjwdBc3t
	VWl
X-Google-Smtp-Source: AGHT+IHuuLI/4RS8KwBW22mp4P9uiUcK+/+J9CzVnEFso4ZPPDKXkgx2yRdnK09lmyiSmH0g7kSV56/YbrCwNPnSulQ=
X-Received: by 2002:a05:6820:3093:b0:611:b00b:baa with SMTP id
 006d021491bc7-61392b6e733mr9338671eaf.3.1751872720185; Mon, 07 Jul 2025
 00:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAE3nP4gt44hNp_GNzfYXCqXpsw+WSwFnY+Xz=jJAQzdNQ5D6KA@mail.gmail.com>
 <CAHUa44FxVseYXptcKf2_C1AHgGOD_eGyR=2A3FXzwd42XSqcMQ@mail.gmail.com> <CAE3nP4jkU_MioO41z2d7UoswSdeDJWfbwPB04iinvb34pXx0Kw@mail.gmail.com>
In-Reply-To: <CAE3nP4jkU_MioO41z2d7UoswSdeDJWfbwPB04iinvb34pXx0Kw@mail.gmail.com>
From: ANAND MOHAN Tiwari <anandmohantiwari94@gmail.com>
Date: Mon, 7 Jul 2025 12:48:28 +0530
X-Gm-Features: Ac12FXx6I3HTA_vTHxH8NbBqbjpxKEzRx_zlVaz36x-FSXQfVoXGrE-8zBmZads
Message-ID: <CAE3nP4iG_K6fwAQx=P6m7HAXsZcrauJp-UvKmBO7dyOMHJWreA@mail.gmail.com>
Subject: Re: Compilation Issue for plat-k3 for am67a beagleY-AI Board
To: Jens Wiklander <jens.wiklander@linaro.org>
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 09EE23F6B0
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.53:from];
	ARC_NA(0.00)[];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.53:from];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[209.85.161.53:from]
X-MailFrom: anandmohantiwari94@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: DI5BYVPFXAG5KBXXCA4NF2PONERBZZ6R
X-Message-ID-Hash: DI5BYVPFXAG5KBXXCA4NF2PONERBZZ6R
X-Mailman-Approved-At: Mon, 07 Jul 2025 11:25:39 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
CC: "jerome.forissier@linaro.org" <jerome.forissier@linaro.org>, etienna.carriere@linaro.org, "afd@ti.com" <afd@ti.com>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DI5BYVPFXAG5KBXXCA4NF2PONERBZZ6R/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGkgVGVhbSwNCg0KDQpSZXF1ZXN0IHlvdSB0byBhZGQgc3VwcG9ydCBmb3IgYW02N2EgYmVhZ2xl
WS1BSSBib2FyZC4NCkxldCBtZSBrbm93IGlmIGkgY2FuIGhlbHAgaW4gYW55IHdheSBmb3IgdGhl
IHNhbWUuDQoNClRoYW5rcyAmIFJlZ2FyZHMsDQpBbmFuZCBNb2hhbiBUaXdhcmkNCihNKSArOTEg
ODIgOTkxMDY4MzkNCihNKSArOTEgODcgNjU2OTY5NDANCg0KDQpPbiBNb24sIDcgSnVsIDIwMjUg
YXQgMTI6NDXigK9QTSwgQU5BTkQgTU9IQU4gVGl3YXJpIDwNCmFuYW5kbW9oYW50aXdhcmk5NEBn
bWFpbC5jb20+IHdyb3RlOg0KDQo+IEhpIEplbnMsDQo+DQo+IFRoYW5rcyBmb3IgdGhlIGNvbmZp
cm1hdGlvbi4gSeKAmWxsIHJlcG9ydCB0aGlzIHRvIG9wdGVlLiBIb3cgd2UgY2FuIG1ha2UNCj4g
c3VyZSB0byBnZXQgaXRzIHN1cHBvcnQgYWRkZWQgPz8NCj4NCj4NCj4gVGhhbmtzICYgUmVnYXJk
cywNCj4gQW5hbmQgTW9oYW4gVGl3YXJpDQo+IChNKSArOTEgODIgOTkxMDY4MzkNCj4gKE0pICs5
MSA4NyA2NTY5Njk0MA0KPg0KPg0KPiBPbiBNb24sIDcgSnVsIDIwMjUgYXQgMTI6MTnigK9QTSwg
SmVucyBXaWtsYW5kZXIgPGplbnMud2lrbGFuZGVyQGxpbmFyby5vcmc+DQo+IHdyb3RlOg0KPg0K
Pj4gSGkgQW5hbmQsDQo+Pg0KPj4gaHR0cHM6Ly9naXRodWIuY29tL09QLVRFRS9vcHRlZV9vcy9p
c3N1ZXMvIGlzIHRoZSBiZXN0IHBsYWNlIHRvIHJlcG9ydA0KPj4gaXNzdWVzIGxpa2UgdGhpcywg
b3IgcG9zc2libHkgb3AtdGVlQGxpc3RzLnRydXN0ZWRmaXJtd2FyZS5vcmcuDQo+Pg0KPj4gQW55
d2F5LCBmcm9tIHRoZSBzb3VyY2UgY29kZSwgaXQgbG9va3MgbGlrZSBrMy1hbTY3YSBpc24ndCBz
dXBwb3J0ZWQuDQo+Pg0KPj4gQ2hlZXJzLA0KPj4gSmVucw0KPj4NCj4+IE9uIE1vbiwgSnVsIDcs
IDIwMjUgYXQgODozNOKAr0FNIEFOQU5EIE1PSEFOIFRpd2FyaQ0KPj4gPGFuYW5kbW9oYW50aXdh
cmk5NEBnbWFpbC5jb20+IHdyb3RlOg0KPj4gPg0KPj4gPiBEZWFyIEFsbCwNCj4+ID4NCj4+ID4g
VGhpcyBpcyB0byBicmluZyB5b3VyIGF0dGVudGlvbiB0b3dhcmRzICBjb21waWxhdGlvbiBpc3N1
ZSBmYWNlZCBieSBtZQ0KPj4gZm9yIGszLWFtNjdhIGJvYXJkLiBJIGNhbiBzZWUgY29tcGlsYXRp
b24gd29ya3MgdGlsbCBQTEFURk9STT1rMy02NXggZm9yDQo+PiBvcHRlZV9vcyBidXQgd2hlbiBp
IHRyaWVkIGNvbXBpbGluZyB0aGUgc2FtZSBhbTY3eCBpdCB0aHJvd3MNCj4+IGNvcmUvYXJjaC9h
cm0vcGxhdC1rMy9kcml2ZXJzL3NhMnVsLmM6MzYgZXJyb3I6IOKAmFNBMlVMX0JBU0XigJkgdW5k
ZWNsYXJlZA0KPj4gaGVyZSBzYW1lIGVycm9yIGlzIHRocm93biBmb3IgU0EyVUxfVElfU0NJX0ZX
X0lELA0KPj4gPiBTQTJVTF9USV9TQ0lfRldfUkdOX0lELA0KPj4gPiBTQTJVTF9USV9TQ0lfREVW
X0lELA0KPj4gPg0KPj4gPiBjb3JlL2FyY2gvYXJtL3BsYXQtazMvLi9wbGF0Zm9ybV9jb25maWdz
Lmg6OTENCj4+ID4g4oCYU0EyVUxfQkFTReKAmSB1bmRlY2xhcmVkDQo+PiA+DQo+PiA+IE5vdCBz
dXJlIHdob20gdG8gY29udGFjdCB0byByZXBvcnQgdGhpcyBidXQgaSBmb3VuZCB0aGVzZSBtYWls
cyBpbg0KPj4gY29tbWl0IG1lc3NhZ2VzLiBSZXF1ZXN0IHlvdSB0byBjaGVjayBvbiB0aGlzIG9y
IGxldCBtZSBrbm93IGlmIEnigJltIG1pc3NpbmcNCj4+IHNvbWV0aGluZw0KPj4gPiBUcmllZCBi
ZWxvdyBzdGVwcy4NCj4+ID4NCj4+ID4gZ2l0IGNsb25lIC1iIDExLjAxLjAzDQo+PiBodHRwczov
L2dpdGh1Yi5jb20vYmVhZ2xlYm9hcmQvdGktbGludXgtZmlybXdhcmUuZ2l0IC0tZGVwdGg9MQ0K
Pj4gPg0KPj4gPiBnaXQgY2xvbmUgLWIgbHRzLXYyLjEyLjQNCj4+IGh0dHBzOi8vZ2l0aHViLmNv
bS9UcnVzdGVkRmlybXdhcmUtQS90cnVzdGVkLWZpcm13YXJlLWEuZ2l0IC0tZGVwdGg9MQ0KPj4g
Pg0KPj4gPiBtYWtlIC1DIC4vdHJ1c3RlZC1maXJtd2FyZS1hLyAtajQgQ1JPU1NfQ09NUElMRT0k
e0NDNjR9IFBMQVQ9azMNCj4+IEFSQ0g9YWFyY2g2NCBTUEQ9b3B0ZWVkIFRBUkdFVF9CT0FSRD1s
aXRlIGFsbA0KPj4gPg0KPj4gPg0KPj4gPiBnaXQgY2xvbmUgLWIgNC42LjAgaHR0cHM6Ly9naXRo
dWIuY29tL09QLVRFRS9vcHRlZV9vcy5naXQgLS1kZXB0aD0xDQo+PiA+DQo+PiA+DQo+PiA+IG1h
a2UgLUMgLi9vcHRlZV9vcy8gLWo0IENST1NTX0NPTVBJTEU9JHtDQzMyfSBDUk9TU19DT01QSUxF
NjQ9JHtDQzY0fQ0KPj4gQ0ZHX0FSTTY0X2NvcmU9eSBQTEFURk9STT1rMy1hbTYyeCBhbGwg4oCU
4oCU4oCU4oCULT4gd29ya2luZw0KPj4gPg0KPj4gPiBtYWtlIC1DIC4vb3B0ZWVfb3MvIC1qNCBD
Uk9TU19DT01QSUxFPSR7Q0MzMn0gQ1JPU1NfQ09NUElMRTY0PSR7Q0M2NH0NCj4+IENGR19BUk02
NF9jb3JlPXkgUExBVEZPUk09azMtYW02NXggYWxsIOKAlOKAlOKAlOKAlC0+IHdvcmtpbmcgdGls
bCB0aGlzIGJ1dCB0cmllZA0KPj4gZm9yIGNvbXBpbGluZyBiZWxvdw0KPj4gPg0KPj4gPiBtYWtl
IC1DIC4vb3B0ZWVfb3MvIC1qNCBDUk9TU19DT01QSUxFPSR7Q0MzMn0gQ1JPU1NfQ09NUElMRTY0
PSR7Q0M2NH0NCj4+IENGR19BUk02NF9jb3JlPXkgUExBVEZPUk09azMtYW02N3ggYWxsIOKAlOKA
lOKAlOKAlC0+IG5vdCB3b3JraW5nIGFsc28gdHJpZWQgYnkNCj4+IHB1dHRpbmcgazMtYW02N2Eg
4oCUdGhpcyBteSBib2FyZCBiZWFnbGVZLUFJDQo+PiA+DQo+PiA+IExldCBtZSBrbm93IGlmIEni
gJltIG1pc3Npbmcgc29tZXRoaW5nIG9yIHdlIG5lZWQgdG8gZm9sbG93IGRpZmZlcmVudA0KPj4g
cHJvY2VkdXJlcyBhcGFydCBmcm9tIGFib3ZlDQo+PiA+DQo+PiA+IFRoYW5rcyBpbiBhZHZhbmNl
LiBZb3UgY2FuIHJlYWNoIG91dCBtZSB2aWEgYmVsb3cgbnVtYmVycyBvciByZXBseSBvbg0KPj4g
c2FtZSBlbWFpbC4NCj4+ID4NCj4+ID4gVGhhbmtzICYgUmVnYXJkcywNCj4+ID4gQW5hbmQgTW9o
YW4gVGl3YXJpDQo+PiA+IChNKSArOTEgODIgOTkxMDY4MzkNCj4+ID4gKE0pICs5MSA4NyA2NTY5
Njk0MA0KPj4NCj4NCg==
