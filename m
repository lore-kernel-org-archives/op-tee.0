Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37463CA1013
	for <op-tee@archiver.kernel.org>; Mon,  8 Sep 2025 07:57:55 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6A1D84662D
	for <op-tee@archiver.kernel.org>; Mon,  8 Sep 2025 07:57:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xg-auto.20200927.dkim.feishu.cn header.i=@xg-auto.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=KHZvSXn1;
	dkim-atps=neutral
Received: from sg-1-31.ptr.blmpb.com (sg-1-31.ptr.blmpb.com [118.26.132.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3E67A42DF1
	for <op-tee@lists.trustedfirmware.org>; Mon,  8 Sep 2025 07:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=xg-auto.20200927.dkim.feishu.cn; t=1757316905;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=3g1HZ0DP+qG2UjgdCnc8PoK+hFDcvE+xdlTO49NVwpU=;
 b=KHZvSXn1iFW8bEqZ7qo5cIue0tc6pVfF7sRXgEG/J0LMtS7phdiOw7g9QHvuhn0PnxQIyE
 lvdwH8wVR82b29o5jkJIuXSCPlW+egqShMhEvcv9/c0PNWzvXEEIQX+a/Vir4yqUmJfMyL
 ZemV1Ugo94RRMjZVoZNacBadW0gAtL4UPSwfgrlnffSsFJpINpI0gpKT8+lDN/+MzUo9oL
 OTKqdFeMRPtV7ymTsPyBp7iDUOMs+pypM5Qz4Yroto2LuoWkiBV8OWevP95wzK5/glCB2G
 adQcCObBtKIh/8X8hnh8YgA4FdNS7mVhokv2XOO2k2oprczivcHcc1382WcpfQ==
Mime-Version: 1.0
X-Lms-Return-Path: <lba+168be8726+c074c7+lists.trustedfirmware.org+rui.dai@xg.auto>
Date: Mon, 08 Sep 2025 15:35:02 +0800
Message-Id: <eb57f0258749e983b3423f1620c8d6876113f7cc.953132d2.6e78.4432.8309.0d0d57874c64@feishu.cn>
To: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Subject: [BUG] mobj_ffa_get_by_cookie() fails with 16K/64K kernel page size
From: =?utf-8?q?=E6=88=B4=E7=9D=BF?= <rui.dai@xg.auto>
X-Rspamd-Queue-Id: 3E67A42DF1
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.90 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[xg-auto.20200927.dkim.feishu.cn:s=s1];
	R_SPF_ALLOW(-0.20)[+ip4:118.26.132.0/24];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	ONCE_RECEIVED(0.10)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:138699, ipnet:118.26.132.0/24, country:SG];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.937];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DMARC_NA(0.00)[xg.auto];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[xg-auto.20200927.dkim.feishu.cn:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-MailFrom: rui.dai@xg.auto
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: RU6ADI3RJSFS4TASJESRYDFUZ2TM55OL
X-Message-ID-Hash: RU6ADI3RJSFS4TASJESRYDFUZ2TM55OL
X-Mailman-Approved-At: Mon, 08 Sep 2025 07:57:41 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RU6ADI3RJSFS4TASJESRYDFUZ2TM55OL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGkgT1AtVEVFIG1haW50YWluZXJzLA0KDQpJIGZvdW5kIGFuIGlzc3VlIGluIG9wdGVlX29zIHJl
bGF0ZWQgdG8gRkZBIG1lbW9yeSBoYW5kbGluZyBhY3Jvc3MgZGlmZmVyZW50IGtlcm5lbCBwYWdl
IHNpemVzLg0KDQpGaWxlOiBjb3JlL2FyY2gvYXJtL21tL21vYmpfZmZhLmMNCkZ1bmN0aW9uOiBt
b2JqX2ZmYV9nZXRfYnlfY29va2llKCkNCg0KQXQgdGhlIGJlZ2lubmluZyBvZiB0aGlzIGZ1bmN0
aW9uIHRoZXJlIGlzIGEgY2hlY2s6DQoNCsKgwqDCoCBpZiAoaW50ZXJuYWxfb2ZmcyA+PSBTTUFM
TF9QQUdFX1NJWkUpDQrCoMKgIMKgIMKgwqAgcmV0dXJuIE5VTEw7DQoNCkhlcmUsIFNNQUxMX1BB
R0VfU0laRcKgaXMgZml4ZWQgdG8gNEtCLiBXaGVuIHJ1bm5pbmcgd2l0aCBhIExpbnV4IGtlcm5l
bCBidWlsdCB3aXRoIDE2SyBvciA2NEsgcGFnZSBzaXplcw0KKENPTkZJR19BUk02NF8xNktfUEFH
RVMgb3IgQ09ORklHX0FSTTY0XzY0S19QQUdFUyksIHRoaXMgY2hlY2sgaW5jb3JyZWN0bHkgcmVq
ZWN0cyB2YWxpZCBvZmZzZXRzLg0KQXMgYSByZXN1bHQsIG1vYmpfZmZhX2dldF9ieV9jb29raWUo
KSByZXR1cm5zIE5VTEwsIHdoaWNoIGxlYWRzIHRvIFRFRV9FUlJPUl9CQURfUEFSQU1FVEVSUyBk
dXJpbmcgRkZBDQpjb21tdW5pY2F0aW9uIChmb3IgZXhhbXBsZSB3aGVuIHNldF9mbWVtX3BhcmFt
KCkgY2FsbHMgaXQpLg0KDQpJbXBhY3Q6DQotIEZGQSBjb21tdW5pY2F0aW9uIGZhaWxzIG9uIHN5
c3RlbXMgd2hlcmUgdGhlIGtlcm5lbCB1c2VzIDE2SyBvciA2NEsgcGFnZXMuDQotIFdpdGggMTZL
IGJlY29taW5nIG1vcmUgd2lkZWx5IGFkb3B0ZWQgKGUuZy4gR29vZ2xl4oCZcyBzdGFuZGFyZGl6
YXRpb24pLCB0aGlzIHByb2JsZW0gd2lsbCBiZSBtb3JlIGNvbW1vbi4NCg0KRXhwZWN0ZWQgYmVo
YXZpb3I6DQpUaGUgZnVuY3Rpb24gc2hvdWxkIG5vdCBhc3N1bWUgYSBmaXhlZCA0SyBwYWdlIHNp
emUsIGJ1dCBhZGFwdCB0byB0aGUgYWN0dWFsIGtlcm5lbCBwYWdlIHNpemUuDQoNCkVudmlyb25t
ZW50Og0KLSBPUC1URUUgdmVyc2lvbjogb2JzZXJ2ZWQgaW4gbXVsdGlwbGUgdmVyc2lvbnMgaW5j
bHVkaW5nIGxhdGVzdCBtYXN0ZXINCi0gUGxhdGZvcm06IEFSTTY0IHdpdGggRkZBIGVuYWJsZWQN
Ci0gS2VybmVsIGNvbmZpZzogQ09ORklHX0FSTTY0XzE2S19QQUdFUyAvIENPTkZJR19BUk02NF82
NEtfUEFHRVMNCg0KUG9zc2libGUgZml4Og0KLSBSZXBsYWNlIHRoZSBTTUFMTF9QQUdFX1NJWkUg
Y2hlY2sgd2l0aCBhIGR5bmFtaWMgY2hlY2sgYmFzZWQgb24gdGhlIGtlcm5lbOKAmXMgYWN0dWFs
IHBhZ2Ugc2l6ZSwNCsKgIG9yIG1ha2UgdGhlIHZhbGlkYXRpb24gY29uZmlndXJhYmxlLg0KDQpQ
bGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IG5lZWQgbW9yZSBkZXRhaWxzLiBJIGFtIGhhcHB5IHRv
IHRlc3Qgb3IgcHJvdmlkZSBhIHBhdGNoIHN1Z2dlc3Rpb24gaWYgdGhhdCBoZWxwcy4NCg0KQmVz
dCByZWdhcmRzLA0KZGRyZHRkbg==
