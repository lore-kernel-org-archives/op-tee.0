Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B54FF885A
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 12:29:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 87990443B5
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 12:29:10 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Vtf1ZWxC;
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2F303431FF
	for <op-tee@lists.trustedfirmware.org>; Sun,  3 May 2026 08:32:39 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-83537a80ab6so355535b3a.1
        for <op-tee@lists.trustedfirmware.org>; Sun, 03 May 2026 01:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777797158; cv=none;
        d=google.com; s=arc-20240605;
        b=XMWn9cVrN8oxulPWj6/t/9qoGYNS8sgsUEnwlkAZbKow/TzP7vofK1M6qQvVaoftYt
         574ctewhZmHzZAnljNl3y3wuTnJ1CBEtP84ZJpgzQd2z53GSOUreX87Qif4OO/8BuUZM
         Z2C2BTZHAeYoWvaaw2GpBT1PMKLEZDrYpYXRVjflD/iYLcWuRVIR+hKxv6SzAVu04GoV
         qCiRhPQIvoJnzEudKHKlHnnGQaUy4ZMKc5kgc+eHc2VPIXA2fvbqwGkgah2u92E+fq2Q
         IsGJDHauYD8AA6+8HU92D/Sh8SQIHHprk0qtaapMYv8koTsqGD0bAmFiH4+pjij9pkrd
         19Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Pd6L2p4z/vEjj2PWWTDuqoD7HTdqPmKTwvL6NDv8+CI=;
        fh=DBvxCipNH2RlJe8Lt8jDz73G7et6cRT4xOp4aNQo0jg=;
        b=eezvQRKQq7N76pZmv9abixy7eyvLQ+2xLqWyRpoDjp+N7kUrNLy9MSQ8dwzpKHOCYH
         yUmPRnaDGCPXp82jUbxvBK6P+9pa2+osuYo4RH5odcx1cVSlyuE/s+UZiCGrFF+fgGLb
         w9aPct7Y2GZkiQlLS+pt6ay+JZCtzyKewo9dv5g3ZmrewZKmopvUnMhqC5cmXp/+q5wz
         lHw9decnFsWXs0AmfPukYS0vui8QXnSLJAptiyxmgnKNINPMe7uPT4TFFkPx+Irw6aVi
         qbK+6A7L8+NR4OyJg9pXah9qkTjUxqN4ysI948ig6AHpNQEwSKfZx6xHa38Yp9XI2E8D
         G7bQ==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777797158; x=1778401958; darn=lists.trustedfirmware.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pd6L2p4z/vEjj2PWWTDuqoD7HTdqPmKTwvL6NDv8+CI=;
        b=Vtf1ZWxC4wbAokpT/GrtYbdz5vxnsEWc2blJSzlPbIZljBoLMlMEQQCTPMSxS5Ok/x
         VyLCJDRDC2ARaSnjYuNUrfJta1emOV01aFlU9Rtexok0xhDjY46+T8zxcOOmitOLsmH8
         /+4yxAyaJ/1kK737eP5+Qon+DVXcbNiUT842ECa3nIvmY5dO/z3d2GpuNtjSU26H7YyG
         9PGQqXzrvJR/GUwcdj/H0D1up47X+oik4Fu7imVgmtSxM6kKe0lvvNDQuXJXfCz5/CIu
         8LfXRB+7vlGjoAbZXiobeiNxmRdFDRUv1j5uqRBREjUwhEjMiK79HjjbHfbsZrnRn19b
         eB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777797158; x=1778401958;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pd6L2p4z/vEjj2PWWTDuqoD7HTdqPmKTwvL6NDv8+CI=;
        b=EZu8Eg17GdckJ8gRVJMsDghGBm6PkCqqH6qqDuruQ6+uiq+i7w0xg4u/A6MDo/IG9r
         sf2KL5KDDVc5OElSTzkkYw0rO+nBl3W8+MXLOZrxYGkr2B9oDTA8J6lVPktqU86IvIXL
         kqLJyI1l+YlfrqdZcyPPgVmQYeSp5TXSGAt4BvLOPO7pRufxdK4Kw0wcdD1zwtu52K9T
         BB+Y1NhzR+ahnFtsvuR+rEtaXVHO/IcOuGWoeUmxhp4zxjH4VIsA2pcz0aEbutRe5Tfg
         3DCsCKUvQvkQfD5A/75E0F9YLkxFjkfGcqbKWjpsu4iGgCOChRXsU1Xd4VwDXtlD+aX6
         vIjg==
X-Gm-Message-State: AOJu0Yz5nuWEWXgaXvTDja7M1tP5wk4y0VWuwPGKzW3bYCjNzIDmw500
	7n7voDVgqv4v2TyGBLjXJB2nxIOl3YtmaaoshbUE+yfN7PtaLTRVSout8DruJHsAYu+FnccNuJV
	2QG6JFIiGzVjXiDFG1PzaIW9KojEtnRc9iMbQ
X-Gm-Gg: AeBDievXRkQ5V2IEY40ofJPP8N/5/bUWZGsRfxfRpjt315wJEQXN1xJc+rS9CTJtAy+
	ByW7G58xjFPlhh4RjOwgfI5m9Iw/MqGclOyOCCFDH5H/i/yXZGdO9Oufes8EDFKnVFdSNY7U6ar
	wkVg+UjW3vP/xQc3tw5N14MaDdTa2Onnttjb9hY0cs6OS/30mgVKBJgFvkf2++hONxEwXifQhrA
	SsMnOHqQDS2efBgOwVv6zhnVw8v5xQjjVGz5Bonc2JZSz/B/0VkXFh5XhjLpIaquaX9JmTMKYjo
	PSGhG1oBqbkW7ZU9caehYEaHn3wN1g3oLUaJILj7LRZlWAkHbA==
X-Received: by 2002:a05:6a00:1d94:b0:82f:8a29:e3b4 with SMTP id
 d2e1a72fcca58-8352d2f7d66mr5194752b3a.50.1777797157581; Sun, 03 May 2026
 01:32:37 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?xLBzYSBDb8Wfa3Vu?= <isacskn94@gmail.com>
Date: Sun, 3 May 2026 11:32:26 +0300
X-Gm-Features: AVHnY4K3nszkQPfT_ZYpaataGbpGn4iE6rVXiylEb5JpY-l_fi81iujeVhKEhh8
Message-ID: <CAPziTZNyW4ejdRm76bLVxU-4uY1f6W-fzVzqLA1oCAZvPZeO9g@mail.gmail.com>
Subject: KLMBG4GEUF
To: op-tee@lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.40 / 15.00];
	R_MIXED_CHARSET(1.25)[subject];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	SUBJ_ALL_CAPS(0.75)[10];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	BAYES_HAM(-0.30)[75.09%];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.177:from];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[209.85.210.177:from];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2F303431FF
X-Spamd-Bar: /
X-MailFrom: isacskn94@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: B45GDVBKEZCDMU2CPNGIBMMIOVPHLKWN
X-Message-ID-Hash: B45GDVBKEZCDMU2CPNGIBMMIOVPHLKWN
X-Mailman-Approved-At: Mon, 04 May 2026 12:28:47 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/B45GDVBKEZCDMU2CPNGIBMMIOVPHLKWN/>
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
IGJlIGhpZ2hseSBhcHByZWNpYXRlZC4NCg0KQmVzdCByZWdhcmRzLA0K
