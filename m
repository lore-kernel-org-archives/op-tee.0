Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E05BCAC597
	for <op-tee@archiver.kernel.org>; Mon, 15 Sep 2025 17:50:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C97F441B48
	for <op-tee@archiver.kernel.org>; Mon, 15 Sep 2025 17:50:29 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LZxReaTd;
	dkim-atps=neutral
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A8AC741B48
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Sep 2025 17:50:01 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-33730e1cda7so42984151fa.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Sep 2025 10:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757958600; x=1758563400; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nUoHh/QaA/cJemcuKzQ0L0kM7hvamnSwD+AbhFj55I=;
        b=LZxReaTdufGmqKTWDd4oMUz2ZWdq62+twPNXT7SkUMDVTyywY7gJbtNlBqnu67+TYl
         glI2d5gs4tLLkOi7vMPath+rfmmfsG09nNFvuwM5Y7GSGUr1lNUYanC50ESQBulAbbJu
         CbwchhodhkdiRBaMpb5CzWBhHKUfhTMLeO7IJ7npNyG+HK5OFaWsOkbdR7cIFuXl2E3I
         1vC1LowCVxM0ViNMDi6USCq0iEbgrTohVUEN/Rj3hFnydpgkOsX5sDg4orFdDcmR8jIf
         Y0vo3KRab/VG04EM8A4Gb5/FBjANfEUU/b4llEgsrFeDR6ixX1YdMKAi2SHqNMO9FsGb
         LlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757958600; x=1758563400;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nUoHh/QaA/cJemcuKzQ0L0kM7hvamnSwD+AbhFj55I=;
        b=PDKQd/p4XcXQJOZOrN0SkaROEMBsggtKoqh/izhSlcFj5PU1nQU48hu3/x+CMG+44O
         qwfzg0YGBgD3p6ud8pMuLdRBahWPyg9Jcjx2SECjfcZiH13g7RjzgqdRfYdnR8V/UGwy
         SdA0Dzdx1Hudvpzql5K3gcpyMnsybN8pfXSMbNCB9Xt0seoB/zHQnSVCC81BXs8A5h0J
         xZWXDDL/rmOg/b04ljo0G1cFwKkHBHsfOT6FjtH7imG4C/lCHVPSj6n43iQSyNE7kkYw
         hUWRwGSaHQriwAL4BGcEsxGhszpzbk1HtadOL0XrUFhjKvRgS2fNIgsIm1LV9fFIWcXp
         uV5g==
X-Forwarded-Encrypted: i=1; AJvYcCX6zvCLAVQl3qDbnmI3yfWMU6ErO1tmomrvRKpBZ0pO5XkR/FWUMMDnvctNWaJCeNimfs8YO7c=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwJwT4gHyifzL4VR7VHCJXChmJOw3HYsFyh0/CMIzzcJA3hgFME
	d8meW+gpTRAImwgi8jJPraW9hG4njop2QlkZgWc39huDiZuBgbUztoJAhmozhiIH1Qutag==
X-Gm-Gg: ASbGncvNfAdYCvNSZuMGEWOpgUafJQkguzqMzwIuNtbAQnaAFSRQpuVC1iJBWpDJF2o
	PD4erU5IoRmNTnZTWcyAN81TpXM5UGwFs72WzZNCa0asOnXrKsYoFc4Wrf/nHSKgY8+7aqizURS
	8g9y5BKGvnwSQGoltA8F/GR1z7aXGa0uczOvpJAKOzW9bpv1sMBWOcEfRBerqoHMiQy4r4SI6+c
	lCnqAPSEC2AB4zkBhfXoaVmvBrvyZlIt/QIoukNRDV3Cox7dvRIp73wofb8wJv/+p86+tdA+ZEj
	0Ko/hsEXdKz4AadYnLdqZQkiSH0VLnigmzwzsQQdYCtRUcLlkIfCsVHQw2a2vs7mC/JvUQDFPTV
	5e9NQ2PAmqH9i3nximtv3oMKeNFTDDx07lCWY88hLXjHlSlr5wT0NZWDDpH7gDIrFmEjQz3K0zO
	E=
X-Google-Smtp-Source: AGHT+IHXonlyJsEwptAZtH8gqbNV18Yqqkb2gFcaLd8EoBqiR9uHczu/9wCsppE9vHLym1iN8/0B2Q==
X-Received: by 2002:a2e:be1c:0:b0:353:dece:550c with SMTP id 38308e7fff4ca-353dece59f4mr29367421fa.37.1757958600095;
        Mon, 15 Sep 2025 10:50:00 -0700 (PDT)
Received: from rayden (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1b2a925dsm27634961fa.46.2025.09.15.10.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 10:49:59 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:49:57 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] TEE add QCOMTEE driver for v6.18
Message-ID: <20250915174957.GA2040478@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: A8AC741B48
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.169:from];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.169:from];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[37.123.177.177:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: V7R4K4PV6WVIZIIB56WHTHVRYYMCFNX6
X-Message-ID-Hash: V7R4K4PV6WVIZIIB56WHTHVRYYMCFNX6
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, op-tee@lists.trustedfirmware.org, Bjorn Andersson <andersson@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/V7R4K4PV6WVIZIIB56WHTHVRYYMCFNX6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGVsbG8gYXJtLXNvYyBtYWludGFpbmVycywNCg0KUGxlYXNlIHB1bGwgdGhpcyBzZXQgb2YgcGF0
Y2hlcyBbMV0gYWRkaW5nIGEgUXVhbGNvbW0gVEVFIChRVEVFKSBkcml2ZXIgdG8NCnRoZSBURUUg
c3Vic3lzdGVtIGFzIGRlc2NyaWJlZCBiZWxvdy4gVGhlIFFURUUgcGF0Y2hlcyBkZXBlbmQgb24g
dHdvDQpwYXRjaGVzIGZyb20gYnJhbmNoDQonMjAyNTA5MTEtcWNvbS10ZWUtdXNpbmctdGVlLXNz
LXdpdGhvdXQtbWVtLW9iai12MTItMi0xN2YwN2E5NDJiOGRAb3NzLnF1YWxjb21tLmNvbScNCm9m
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Fjb20vbGlu
dXgNCg0KQmrDtnJuIGFza2VkIG1lIFsyXSB0byBwdWxsIHRoZW0gZnJvbSBoaXMgdHJlZS4NCg0K
VGhpcyBwdWxsIHJlcXVlc3QgaXMgYmFzZWQgb24gbXkgcHJldmlvdXMgcHVsbCByZXF1ZXN0IHdp
dGgNCnRlZS1wcm90LWRtYS1idWYtZm9yLXY2LjE4IHRvIGF2b2lkIGEgZmV3IGNvbmZsaWN0cyB3
aGVuIG1lcmdpbmcuDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9vcC10ZWUvMjAyNTA5
MTEtcWNvbS10ZWUtdXNpbmctdGVlLXNzLXdpdGhvdXQtbWVtLW9iai12MTItMC0xN2YwN2E5NDJi
OGRAb3NzLnF1YWxjb21tLmNvbS8NClsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9vcC10ZWUv
bWlyNmxoa2o0NTZyYTNpNnc3ZGVmNHJydHp3NjYzZjY2bDY2Y3o0czNneHh2dWVlcWtAaWxzMmhq
a2xicDR5Lw0KDQpUaGFua3MsDQpKZW5zDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBj
b21taXQgZGJjMjg2OGI3YjU3ZmI0Y2FhOGU0NGE2OWU4ODJkY2Y4ZThkNTliZjoNCg0KICBvcHRl
ZTogc21jIGFiaTogZHluYW1pYyBwcm90ZWN0ZWQgbWVtb3J5IGFsbG9jYXRpb24gKDIwMjUtMDkt
MTEgMTE6MjI6NDMgKzAyMDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5
IGF0Og0KDQogIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9q
ZW5zd2kvbGludXgtdGVlLmdpdCB0YWdzL3RlZS1xY29tdGVlLWZvci12Ni4xOA0KDQpmb3IgeW91
IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gZGNjN2E1NzFhMzY2NWExNjU4MWI1YjE4Y2E2YjExM2Y2
MGE5YTQxYToNCg0KICBEb2N1bWVudGF0aW9uOiB0ZWU6IEFkZCBRdWFsY29tbSBURUUgZHJpdmVy
ICgyMDI1LTA5LTE1IDE3OjM0OjA2ICswMjAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpBZGQgUXVhbGNvbW0gVEVF
IGRyaXZlciAoUVRFRSkNCg0KVGhpcyBpbnRyb2R1Y2VzIGEgVHJ1c3RlZCBFeGVjdXRpb24gRW52
aXJvbm1lbnQgKFRFRSkgZHJpdmVyIGZvcg0KUXVhbGNvbW0gVEVFIChRVEVFKS4NCg0KUVRFRSBl
bmFibGVzIFRydXN0ZWQgQXBwbGljYXRpb25zIChUQXMpIGFuZCBzZXJ2aWNlcyB0byBydW4gc2Vj
dXJlbHkuIEl0DQp1c2VzIGFuIG9iamVjdC1iYXNlZCBpbnRlcmZhY2UsIHdoZXJlIGVhY2ggc2Vy
dmljZSBpcyBhbiBvYmplY3Qgd2l0aA0Kc2V0cyBvZiBvcGVyYXRpb25zLg0KDQpLZXJuZWwgYW5k
IHVzZXJzcGFjZSBzZXJ2aWNlcyBhcmUgYWxzbyBhdmFpbGFibGUgdG8gUVRFRSB0aHJvdWdoIGEN
CnNpbWlsYXIgYXBwcm9hY2guIFFURUUgbWFrZXMgY2FsbGJhY2sgcmVxdWVzdHMgdGhhdCBhcmUg
Y29udmVydGVkIGludG8NCm9iamVjdCBpbnZvY2F0aW9ucy4gVGhlc2Ugb2JqZWN0cyBjYW4gcmVw
cmVzZW50IHNlcnZpY2VzIHdpdGhpbiB0aGUNCmtlcm5lbCBvciB1c2Vyc3BhY2UgcHJvY2Vzcy4N
Cg0KV2UgZXh0ZW5kIHRoZSBURUUgc3Vic3lzdGVtIHRvIHVuZGVyc3RhbmQgb2JqZWN0IHBhcmFt
ZXRlcnMgYW5kIGFuIGlvY3RsDQpjYWxsIHNvIGNsaWVudCBjYW4gaW52b2tlIG9iamVjdHMgaW4g
UVRFRToNCiAgLSBURUVfSU9DVExfUEFSQU1fQVRUUl9UWVBFX09CSlJFRl8qDQogIC0gVEVFX0lP
Q19PQkpFQ1RfSU5WT0tFDQoNClRoZSBleGlzdGluZyBpb2N0bCBjYWxscyBURUVfSU9DX1NVUFBM
X1JFQ1YgYW5kIFRFRV9JT0NfU1VQUExfU0VORCBhcmUNCnVzZWQgZm9yIGludm9raW5nIHNlcnZp
Y2VzIGluIHRoZSB1c2Vyc3BhY2UgcHJvY2VzcyBieSBRVEVFLg0KDQpUaGUgVEVFIGJhY2tlbmQg
ZHJpdmVyIHVzZXMgdGhlIFFURUUgVHJhbnNwb3J0IE1lc3NhZ2UgdG8gY29tbXVuaWNhdGUNCndp
dGggUVRFRS4gSW50ZXJhY3Rpb25zIHRocm91Z2ggdGhlIG9iamVjdCBJTlZPS0UgaW50ZXJmYWNl
IGFyZQ0KdHJhbnNsYXRlZCBpbnRvIFFURUUgbWVzc2FnZXMuIExpa2V3aXNlLCBvYmplY3QgaW52
b2NhdGlvbnMgZnJvbSBRVEVFDQpmb3IgdXNlcnNwYWNlIG9iamVjdHMgYXJlIGNvbnZlcnRlZCBp
bnRvIFNFTkQvUkVDViBpb2N0bCBjYWxscyB0bw0Kc3VwcGxpY2FudHMuDQoNCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkFt
aXJyZXphIFphcnJhYmkgKDExKToNCiAgICAgIGZpcm13YXJlOiBxY29tOiB0em1lbTogZXhwb3J0
IHNobV9icmlkZ2UgY3JlYXRlL2RlbGV0ZQ0KICAgICAgZmlybXdhcmU6IHFjb206IHNjbTogYWRk
IHN1cHBvcnQgZm9yIG9iamVjdCBpbnZvY2F0aW9uDQogICAgICB0ZWU6IGFsbG93IGEgZHJpdmVy
IHRvIGFsbG9jYXRlIGEgdGVlX2RldmljZSB3aXRob3V0IGEgcG9vbA0KICAgICAgdGVlOiBhZGQg
Y2xvc2VfY29udGV4dCB0byBURUUgZHJpdmVyIG9wZXJhdGlvbg0KICAgICAgdGVlOiBhZGQgVEVF
X0lPQ1RMX1BBUkFNX0FUVFJfVFlQRV9VQlVGDQogICAgICB0ZWU6IGFkZCBURUVfSU9DVExfUEFS
QU1fQVRUUl9UWVBFX09CSlJFRg0KICAgICAgdGVlOiBpbmNyZWFzZSBURUVfTUFYX0FSR19TSVpF
IHRvIDQwOTYNCiAgICAgIHRlZTogYWRkIFF1YWxjb21tIFRFRSBkcml2ZXINCiAgICAgIHRlZTog
cWNvbTogYWRkIHByaW1vcmRpYWwgb2JqZWN0DQogICAgICB0ZWU6IHFjb206IGVuYWJsZSBURUVf
SU9DX1NITV9BTExPQyBpb2N0bA0KICAgICAgRG9jdW1lbnRhdGlvbjogdGVlOiBBZGQgUXVhbGNv
bW0gVEVFIGRyaXZlcg0KDQpKZW5zIFdpa2xhbmRlciAoMSk6DQogICAgICBNZXJnZSBicmFuY2gg
JzIwMjUwOTExLXFjb20tdGVlLXVzaW5nLXRlZS1zcy13aXRob3V0LW1lbS1vYmotdjEyLTItMTdm
MDdhOTQyYjhkQG9zcy5xdWFsY29tbS5jb20nIG9mIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L3Fjb20vbGludXgNCg0KIERvY3VtZW50YXRpb24vdGVlL2lu
ZGV4LnJzdCAgICAgICAgICAgICAgfCAgIDEgKw0KIERvY3VtZW50YXRpb24vdGVlL3F0ZWUucnN0
ICAgICAgICAgICAgICAgfCAgOTYgKysrKw0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDcgKw0KIGRyaXZlcnMvZmlybXdhcmUvcWNvbS9xY29tX3NjbS5jICAg
ICAgICAgfCAxMTkgKysrKw0KIGRyaXZlcnMvZmlybXdhcmUvcWNvbS9xY29tX3NjbS5oICAgICAg
ICAgfCAgIDcgKw0KIGRyaXZlcnMvZmlybXdhcmUvcWNvbS9xY29tX3R6bWVtLmMgICAgICAgfCAg
NjMgKystDQogZHJpdmVycy90ZWUvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICB8ICAgMSAr
DQogZHJpdmVycy90ZWUvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQogZHJp
dmVycy90ZWUvcWNvbXRlZS9LY29uZmlnICAgICAgICAgICAgICB8ICAxMiArDQogZHJpdmVycy90
ZWUvcWNvbXRlZS9NYWtlZmlsZSAgICAgICAgICAgICB8ICAgOSArDQogZHJpdmVycy90ZWUvcWNv
bXRlZS9hc3luYy5jICAgICAgICAgICAgICB8IDE4MiArKysrKysNCiBkcml2ZXJzL3RlZS9xY29t
dGVlL2NhbGwuYyAgICAgICAgICAgICAgIHwgODIwICsrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KIGRyaXZlcnMvdGVlL3Fjb210ZWUvY29yZS5jICAgICAgICAgICAgICAgfCA5MTUgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvdGVlL3Fjb210ZWUvbWVtX29iai5j
ICAgICAgICAgICAgfCAxNjkgKysrKysrDQogZHJpdmVycy90ZWUvcWNvbXRlZS9wcmltb3JkaWFs
X29iai5jICAgICB8IDExMyArKysrDQogZHJpdmVycy90ZWUvcWNvbXRlZS9xY29tdGVlLmggICAg
ICAgICAgICB8IDE4NSArKysrKysrDQogZHJpdmVycy90ZWUvcWNvbXRlZS9xY29tdGVlX21zZy5o
ICAgICAgICB8IDMwNCArKysrKysrKysrDQogZHJpdmVycy90ZWUvcWNvbXRlZS9xY29tdGVlX29i
amVjdC5oICAgICB8IDMxNiArKysrKysrKysrKw0KIGRyaXZlcnMvdGVlL3Fjb210ZWUvc2htLmMg
ICAgICAgICAgICAgICAgfCAxNTAgKysrKysNCiBkcml2ZXJzL3RlZS9xY29tdGVlL3VzZXJfb2Jq
LmMgICAgICAgICAgIHwgNjkyICsrKysrKysrKysrKysrKysrKysrKysrDQogZHJpdmVycy90ZWUv
dGVlX2NvcmUuYyAgICAgICAgICAgICAgICAgICB8IDEyNyArKysrLQ0KIGRyaXZlcnMvdGVlL3Rl
ZV9wcml2YXRlLmggICAgICAgICAgICAgICAgfCAgIDYgLQ0KIGluY2x1ZGUvbGludXgvZmlybXdh
cmUvcWNvbS9xY29tX3NjbS5oICAgfCAgIDYgKw0KIGluY2x1ZGUvbGludXgvZmlybXdhcmUvcWNv
bS9xY29tX3R6bWVtLmggfCAgMTUgKw0KIGluY2x1ZGUvbGludXgvdGVlX2NvcmUuaCAgICAgICAg
ICAgICAgICAgfCAgNTQgKy0NCiBpbmNsdWRlL2xpbnV4L3RlZV9kcnYuaCAgICAgICAgICAgICAg
ICAgIHwgIDEyICsNCiBpbmNsdWRlL3VhcGkvbGludXgvdGVlLmggICAgICAgICAgICAgICAgIHwg
IDU2ICstDQogMjcgZmlsZXMgY2hhbmdlZCwgNDQxMCBpbnNlcnRpb25zKCspLCAyOCBkZWxldGlv
bnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi90ZWUvcXRlZS5yc3QNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy90ZWUvcWNvbXRlZS9LY29uZmlnDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvdGVlL3Fjb210ZWUvTWFrZWZpbGUNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy90ZWUvcWNvbXRlZS9hc3luYy5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvdGVlL3Fjb210ZWUvY2FsbC5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdGVlL3Fj
b210ZWUvY29yZS5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdGVlL3Fjb210ZWUvbWVt
X29iai5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdGVlL3Fjb210ZWUvcHJpbW9yZGlh
bF9vYmouYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3RlZS9xY29tdGVlL3Fjb210ZWUu
aA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3RlZS9xY29tdGVlL3Fjb210ZWVfbXNnLmgN
CiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy90ZWUvcWNvbXRlZS9xY29tdGVlX29iamVjdC5o
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdGVlL3Fjb210ZWUvc2htLmMNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy90ZWUvcWNvbXRlZS91c2VyX29iai5jDQo=
