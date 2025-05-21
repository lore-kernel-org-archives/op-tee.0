Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096EFC3ABC9
	for <op-tee@archiver.kernel.org>; Wed, 21 May 2025 04:11:40 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2339342ECC
	for <op-tee@archiver.kernel.org>; Wed, 21 May 2025 04:11:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CI0rcKgS;
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 29A0F3F82E
	for <op-tee@lists.trustedfirmware.org>; Wed, 21 May 2025 04:11:21 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5faa590dbb2so1231310a12.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 20 May 2025 21:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747800679; x=1748405479; darn=lists.trustedfirmware.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fMPRHmN3JbqqnbZfHEXbTrkxRhrqskAUeOZRxZwXPrk=;
        b=CI0rcKgSqwChd1FBuOSgeJrBdCfZWnPCdRiTV0LCVBKUQ24eKB4/8Y1Thfu4Bybezc
         79AC1rPcBZugOpkYUM4sQbxAZyGy0AjdLUA2gNcmtS+dqI4vF3LFNgIZObkSVfqZ2HEd
         j7e4fOUoX1JaJsFu06B+NJoevQddFzcCDc1o3fMS9GYTe/2wvqK6+Hq/e7z+pXAC4vVU
         H1DgZA+wYcnvzzO6LT8HoqNK5qsqLFDjhAFeOpTcZkGqVE2tsyEc09IOg6/zkHbl0dBv
         8doxQScviJbGfpBWBnSPIJm8CRwVgv+fzO7gtJN4rkVCqVeDkF7bQkWOMPVCJONk1c5N
         WWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747800679; x=1748405479;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMPRHmN3JbqqnbZfHEXbTrkxRhrqskAUeOZRxZwXPrk=;
        b=W4FaxWzwWmqU1vRcVV45+3V3gKsfYeGVNTfcJHm6W954YHn6e7s11netvm6UZ1EqXQ
         zE8OyZnwl7Iwm6JqyDUZIdJralTfV8qMKALdEvm7NEPekYbYp1W7+zKccYvXej6Jypt9
         rAfTdKdGAItDBEOBt7W8g6ds2bUrkYCRh0kIetofrzR+38TB3THFgUQLIUZZ6K7NlJ0N
         ZYMEHkstqtZO7y1TLrs/HJy7bJ1tt8iAYb++9iBZgKoTyGcgnEGwDJ25HLhKqZKuScvX
         Zr9GTncuQL6/EJPCYsilUf94CNWBx6bGsHt38nf1Z5lRoBTv7isFd4+bmN6bCGC0MGRH
         PPtw==
X-Gm-Message-State: AOJu0YwMHJMqeYJzDxu+a7SFXTJagMJpEUHZ59J2v1Fiadrblehgjz8o
	nbdZBSLh7jFEWvxXXH1FDdKF8UrBTISFEAZ+3nOiYDXv5eyfNWhp4BbMNNn/ziozFcCeOxyDaz/
	wTjepMSrodPlzOUAnEcg9X6Cf11bb9uiI6zgB
X-Gm-Gg: ASbGncsj73ZVsubatwTzrSeTTF/2XrSBmqcUxwCDdYpjQ4nvvYPiyav5Dtn8vwdPyhG
	czrxpU1CxlB2rSVTuWNP+7yzWB0YMCFm8t0TRP9TKuADE+8hBX0FxOpoWIuRclvEEOvIyh1XlJW
	PKbCP2yO8dIczbld1u8XGnne1GYrknv30=
X-Google-Smtp-Source: AGHT+IHtTdcnDR9qiXfPWYSTqGlIvI2vJfWGNjU0oIQX7l442AlEBTSM/dZoMflv9oKehW6JuSd647LqwdZHG2jtjv0=
X-Received: by 2002:a17:907:267c:b0:ace:3f65:1a0c with SMTP id
 a640c23a62f3a-ad52d6c072emr524341466b.16.1747800679137; Tue, 20 May 2025
 21:11:19 -0700 (PDT)
MIME-Version: 1.0
From: murali selvaraj <muraliselvaraj2020@gmail.com>
Date: Wed, 21 May 2025 00:11:08 -0400
X-Gm-Features: AX0GCFtPsYglHFKYdMJvuR9lvMUuojmA-YbKyU6U8EReSeimdN5G5ofZPrVFcFI
Message-ID: <CABBtTm9KhdQ2=pGPbCv2o44fc+8dRFWuYtKKA8Hgubxb4B_Ctg@mail.gmail.com>
Subject: pkcs11 engine basic expectation clarification
To: op-tee@lists.trustedfirmware.org, etienne.carriere@foss.st.com
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.17 / 15.00];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	BAYES_HAM(-0.17)[69.80%];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.46:from];
	FREEMAIL_FROM(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[209.85.208.46:from];
	DWL_DNSWL_BLOCKED(0.00)[gmail.com:dkim];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.46:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 29A0F3F82E
Message-ID-Hash: VBRBQPMXNULPCH5L7KMUJR4S2T2EF4KU
X-Message-ID-Hash: VBRBQPMXNULPCH5L7KMUJR4S2T2EF4KU
X-MailFrom: muraliselvaraj2020@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VBRBQPMXNULPCH5L7KMUJR4S2T2EF4KU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGkgU2lyL01hZGFtLA0KDQpJJ3ZlIGJlZW4gbG9hZGluZyB0aGUgcHJpdmF0ZSBrZXkgZnJvbSB0
aGUgUEtDUzExIHRva2VuIGludG8gbXkgYXBwbGljYXRpb24NCnVzaW5nIHRoZSBjb2RlIGJlbG93
Lg0KSSdtIGF0dGVtcHRpbmcgdG8gdXNlIGFuIEFQSSwgc3VjaCBhcyBnZXRfa2V5KHByaXZrZXkp
LCB0byBwYXNzIHRoaXMNCnByaXZhdGUga2V5IHRvIGFub3RoZXIgbGlicmFyeSBjYWxsZWQgKGZv
byk7DQoNCldvdWxkIGl0IHRoZW4gYmUgZmVhc2libGUgZm9yIG1lIHRvIHVzZSB0aGUgcHJpdmtl
eSBmcm9tIHRoaXMgZnVuY3Rpb24gdG8NCnBlcmZvcm0gYSBzaWduIG9wZXJhdGlvbiBmcm9tIHRo
ZSBmb28gbGlicmFyeT8NCk9yIGlzIHRoZXJlIGEgcnVsZSBpbiB0aGUgUEtDUzExIGVuZ2luZSB0
aGF0IHJlcXVpcmVzIHRoZSBrZXkgdG8gYmUgbG9hZGVkDQplYWNoIHRpbWUgaXQgaXMgbmVlZGVk
Pw0KVGhlbiwgbXkgYXBwbGljYXRpb24gYW5kIHRoZSBmb28gbGlicmFyeSBtdXN0IGNhbGwgdGhl
IGNvZGUgYmVsb3cNCnNlcGFyYXRlbHkgPw0KDQpFTkdJTkUgKmUgPSBOVUxMOw0KDQojZGVmaW5l
IFBLQ1MxMV9NT0RVTEVfUEFUSCAiL3Vzci9saWIvbGliY2t0ZWVjLnNvIg0KI2RlZmluZSBQUklW
X1VSSSAicGtjczExOmlkPSUxMjt0eXBlPXByaXZhdGU7cGluLXZhbHVlPTU0MzIiDQplID0gRU5H
SU5FX2J5X2lkKCJwa2NzMTEiKTsNCmlmICghZSkgew0KZnByaW50ZihzdGRlcnIsICJFcnJvciBs
b2FkaW5nIGR5bmFtaWMgZW5naW5lXG4iKTsNCkVSUl9wcmludF9lcnJvcnNfZnAoc3RkZXJyKTsN
CkVOR0lORV9mcmVlKGUpOw0KfQ0KLy8gU2V0IHRoZSBQS0NTIzExIG1vZHVsZSBwYXRoDQppZiAo
IUVOR0lORV9jdHJsX2NtZF9zdHJpbmcoZSwgIk1PRFVMRV9QQVRIIiwgUEtDUzExX01PRFVMRV9Q
QVRILCAwKSkgew0KZnByaW50ZihzdGRlcnIsICJFcnJvciBzZXR0aW5nIFBLQ1MjMTEgbW9kdWxl
IHBhdGhcbiIpOw0KRVJSX3ByaW50X2Vycm9yc19mcChzdGRlcnIpOw0KRU5HSU5FX2ZyZWUoZSk7
DQp9DQovLyBJbml0aWFsaXplIHRoZSBlbmdpbmUNCmlmICghRU5HSU5FX2luaXQoZSkpIHsNCmZw
cmludGYoc3RkZXJyLCAiRXJyb3IgaW5pdGlhbGl6aW5nIHRoZSBlbmdpbmVcbiIpOw0KRVJSX3By
aW50X2Vycm9yc19mcChzdGRlcnIpOw0KRU5HSU5FX2ZyZWUoZSk7DQp9DQoNCnByaXZrZXkgPSBF
TkdJTkVfbG9hZF9wcml2YXRlX2tleShlLCBQUklWX1VSSSwgTlVMTCwgTlVMTCk7DQppZiAoIXBy
aXZrZXkpIHsNCiAgICBmcHJpbnRmKHN0ZGVyciwgIkVycm9yIGxvYWRpbmcgcHJpdmF0ZSBrZXlc
biIpOw0KICAgIEVSUl9wcmludF9lcnJvcnNfZnAoc3RkZXJyKTsNCn0NCkVOR0lORV9mcmVlKGUp
Ow0K
