Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46083FF885A
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 12:29:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A133C443B9
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 12:29:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZoH4GnJr;
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 31314434BC
	for <op-tee@lists.trustedfirmware.org>; Sun,  3 May 2026 09:27:47 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b458ca2296so18419695ad.0
        for <op-tee@lists.trustedfirmware.org>; Sun, 03 May 2026 02:27:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777800466; cv=none;
        d=google.com; s=arc-20240605;
        b=P6b2GAAuORffmRdky3u7MQnJFuD+XdVU9IlbX6Zruljq6UvfycfPP3wPSXzBkdJcEI
         lg1oaw5GwwI7/k5ofh5aDqQqsboW4f8fjtxqmA5vvvskbcX4lqrjixTSLQ9GjjKC8JVY
         TJHj2qxwWMeRKw7txhNThR3zf0q07SSbAIqo/UxX/x6Q7E9sX6QGgyCnkPLTOw44DgGj
         Xfhy7ymHdPIGzWOgKIvx9c9nSysMpchv16lGtGuEfBidzZeG8gc6zVsFxAnrLQURLOLF
         K6DCOtVOOSx4WC/vE4zPsb5F58X0ryRS0o1N+IL/MEkykl9XqhdEatHrBBMOwydbDpVf
         triA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ppStw6lCt5YLOOUp21CPZrKiG2nnbITvQ6cwOBft5X0=;
        fh=b53EzXOyAB+FVIoBPqsU39j69d8vfonKefXOHVaeaVE=;
        b=ZQLD1HGJEwSbh6b+YVT5pEwMnjib+QtlBm4WnlVK+Ci00zMxLzaTcZzOw00pc/0U6S
         pFlnHcMZSStJRxatT7cswyfEysEdpxIu6tluxVvXmGkOeHSQD1ZilG5AxljJ4J7LiAJZ
         IDPWqMSDHI+t0+oFjORyZywlaTMQFqzbddx36y0cGk2P9A3ytu0gZCaS/4KWsq7BueYq
         USt6vdxupsq7opFArqw7T16kEvTGF/3duEm+eFfhjH3XOhDIU7RfrbiPLpgPEZSqgb52
         2auWvAIxeEuw2BAk1n6eQQ2s5XyJZRFSAiVAGDG+/MEQjNt/Pr2pivnD8CHE4njJEqkE
         0r0Q==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777800466; x=1778405266; darn=lists.trustedfirmware.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ppStw6lCt5YLOOUp21CPZrKiG2nnbITvQ6cwOBft5X0=;
        b=ZoH4GnJrPBF3lscE3oaKtHnya527R1j3R6tLzUGrk2iMVfL6N9XavKo75w7J1b8UZc
         QeXGlmJrztlRI0Ll0CD784Mlplo4t0ezxKjZYcpOmRuVobRTT7A6uelkkWTp6NYj714a
         BL/0CnB0XOcwrSOv0QJPteoF+B/7fiK1k+qVbYut8XptSD/jLvO7iz0Hw2YhBnM8MhHS
         9PWfH/2UCNkoYIaygMwb1cB6mZDFjsR/XmUJcDuBX8B3kPFlW5xmE+ZjS5M2/MMq7jvx
         ge3dp5m8/5ehItB5+Pux/IopcENjqrt+yy+ZsAjW/XcNYe8HdkSRDzyGi8MEiZ02JoFe
         yRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777800466; x=1778405266;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ppStw6lCt5YLOOUp21CPZrKiG2nnbITvQ6cwOBft5X0=;
        b=SojgX02+P2PjRfPISAInU6urzQm8fpJyJ0xqfAyRrmzNP2UVi6YEewS+xHUV/jabpP
         BVOQy63b++xCECZFfn1lUp//YHM5bNpbn0+F3aCd//9zb6rt7yZ1p0lW3MUPFXyaCFzm
         gC35Y7UK461+nTp0xWxgHqAd9PoVp3rgHgiJm54qiVdWgug2FeUU9VkOKtt73857tRN3
         B9Xie7jMLUBYaY0nsEpqxbPm86BjFhTXqNqPV2rX5Ukl3xl8rzHmd+1vP95vVOt/gdWL
         IWy7a9hxKQmb7m4KiuvAdR+76UG3LHCd6qXkrLjMCfcaRSZHw6VpwnVQKZysXEoUzutz
         d80g==
X-Gm-Message-State: AOJu0Yxvajvqvi+szKuHUw7DHDZqkVQf3IAS4AmoALAGHhbeBNV0PWNw
	ggHtsvkF1PJR5bcFmt6htApA2aGoGru/H6LEOqZFPgETqhOY/SXM3ogPxeiNR614OHgu/4V6Vso
	qGl3ka4+Y7YiIxCL35bSYNgQuErQ8h2BJOQd7q3M=
X-Gm-Gg: AeBDiet2DAojek5fcqSg6QEBoGbrDVeZDLGfctTreGyAsSF4pLNTL0TFj1Go/Ao36O2
	/7lYAFSzVa51MueX3rKYAm1BjrPmDoGbgbjDPKKjLELyJMBjXP2nJcwu61e7K3c7EIqmA9+Ujq4
	ytPVHBf8Ggy3QwFdNKL40SZLF81nifr0HNhVaXB2vmB7eIB8WlCh6yKW8wYwjJObAN04SdGk+QR
	X76bhxraP5AEyEazDtlC8GYSEkoKk59EZKFm8gJbWKM4OTfXgbrv8cBe832XsyzBV93tyIFnqZd
	nOHDoSbAk8r4KZE3zI405YmTRXKFub0YrDzkc6Hj937xe96vYQ==
X-Received: by 2002:a17:90a:d2c7:b0:35c:29ba:bf92 with SMTP id
 98e67ed59e1d1-3650ccefbebmr5785053a91.5.1777800465635; Sun, 03 May 2026
 02:27:45 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?xLBzYSBDb8Wfa3Vu?= <isacskn94@gmail.com>
Date: Sun, 3 May 2026 12:27:34 +0300
X-Gm-Features: AVHnY4KTWACQ5RZDt_fk1CM3oVvGTLbDOXEBPh84Lyub7UTKX0yLj4Is-BdqHrY
Message-ID: <CAPziTZO4gvmUUAKLL69-dhGkBADHYPUQ+FwTv98pCZ1sDJUC=w@mail.gmail.com>
Subject: KLMBG4GEUF
To: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.55 / 15.00];
	BAYES_HAM(-1.45)[91.29%];
	R_MIXED_CHARSET(1.25)[subject];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	SUBJ_ALL_CAPS(0.75)[10];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.214.173:from];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_EQ_ENVFROM(0.00)[];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.173:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 31314434BC
X-Spamd-Bar: -
X-MailFrom: isacskn94@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: AXH2QDPE55NDUQWJYLLXSHO2EQJNDVPA
X-Message-ID-Hash: AXH2QDPE55NDUQWJYLLXSHO2EQJNDVPA
X-Mailman-Approved-At: Mon, 04 May 2026 12:28:47 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AXH2QDPE55NDUQWJYLLXSHO2EQJNDVPA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGVsbG8sDQoNCkkgYW0gd29ya2luZyBvbiBlbWJlZGRlZCBhdXRvbW90aXZlIHN5c3RlbXMgcmVw
YWlyIGFuZCBpbnZlc3RpZ2F0aW5nDQpiZWhhdmlvciBvZiBTYW1zdW5nIGVNTUMgKEtMTUJHNEdF
VUYpIGluIHN5c3RlbXMgdGhhdCBhcHBlYXIgdG8gdXNlIE9QLVRFRQ0KZm9yIHNlY3VyZSBzdG9y
YWdlLg0KDQpSZWFsIHNjZW5hcmlvOg0KDQogICAtIFR3byBpZGVudGljYWwgZGV2aWNlcyAoc2Ft
ZSBoYXJkd2FyZSkNCiAgIC0gT25lIHdvcmtpbmcsIG9uZSBub3QgYm9vdGluZw0KICAgLSBGdWxs
IGVNTUMgZHVtcCB0YWtlbiBmcm9tIHdvcmtpbmcgZGV2aWNlOg0KICAgICAgLSBVU0VSDQogICAg
ICAtIEJPT1QxIC8gQk9PVDINCiAgICAgIC0gRVhUX0NTRA0KICAgICAgLSBSUE1CIChyZXBvcnRl
ZCByZWFkYWJsZSwgYnV0IGNvbnRlbnQgYXBwZWFycyBlbXB0eSBvciBub3QgdXNhYmxlKQ0KDQpU
ZXN0czoNCg0KICAgLSBXcml0aW5nIGZ1bGwgZHVtcCB0byBhbm90aGVyIGRldmljZSDihpIgbm8g
Ym9vdA0KICAgLSBTd2FwcGluZyBlTU1DIGJldHdlZW4gYm9hcmRzIOKGkiBib3RoIGZhaWwNCiAg
IC0gV3JpdGluZyBvbmx5IFVTRVIg4oaSIG5vIGNoYW5nZQ0KDQpGcm9tIG9ic2VydmF0aW9uczoN
Cg0KICAgLSBSUE1CIGFwcGVhcnMgbm9uLWNsb25hYmxlDQogICAtIFNlY3VyZSBzdG9yYWdlIGxp
a2VseSBib3VuZCB0byBoYXJkd2FyZQ0KICAgLSBCb290IHNlZW1zIGRlcGVuZGVudCBvbiB0aGlz
IGJpbmRpbmcNCg0KUXVlc3Rpb25zOg0KDQogICAxLiBJbiBPUC1URUUsIGlzIFJQTUIgYWx3YXlz
IHRpZWQgdG8gYSBoYXJkd2FyZSB1bmlxdWUga2V5IChIVUspPw0KICAgMi4gSXMgaXQgZXhwZWN0
ZWQgdGhhdCBSUE1CIGNvbnRlbnQgY2Fubm90IGJlIHJldXNlZCBhY3Jvc3MgaWRlbnRpY2FsDQog
ICBkZXZpY2VzPw0KICAgMy4gRG9lcyBPUC1URUUgZW5mb3JjZSBzZWN1cmUgc3RvcmFnZSBiaW5k
aW5nIGluIGEgd2F5IHRoYXQgcHJldmVudHMNCiAgIGNsb25pbmc/DQogICA0LiBJbiBjYXNlIG9m
IGRhbWFnZWQgZU1NQywgaXMgdGhlcmUgYW55IHN1cHBvcnRlZCB3YXkgdG8gcmVpbml0aWFsaXpl
DQogICBvciByZWNvdmVyIHNlY3VyZSBzdG9yYWdlPw0KDQpJIGFtIG5vdCB0cnlpbmcgdG8gYnlw
YXNzIHNlY3VyaXR5LCBidXQgdG8gdW5kZXJzdGFuZCB0aGUgYXJjaGl0ZWN0dXJhbA0KbGltaXRh
dGlvbiBpbiByZWFsIHJlcGFpciBzY2VuYXJpb3MuDQoNCkFueSBjbGFyaWZpY2F0aW9uIHdvdWxk
IGJlIGhpZ2hseSBhcHByZWNpYXRlZC4NCg0KQmVzdCByZWdhcmRzDQo=
