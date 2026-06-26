Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44649C43458
	for <op-tee@archiver.kernel.org>; Fri, 26 Jun 2026 15:24:18 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 80E7E44EB7
	for <op-tee@archiver.kernel.org>; Fri, 26 Jun 2026 15:24:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zu/qY0rP;
	dkim-atps=neutral
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B347743854
	for <op-tee@lists.trustedfirmware.org>; Fri, 26 Jun 2026 15:24:08 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e93d1dd156so425959a34.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 26 Jun 2026 08:24:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782487448; cv=none;
        d=google.com; s=arc-20260327;
        b=BkY8tASlEJpb7O52Hsk+P9mU0oIZW3JFObfgD+CmB1wQo4aEi4cEqP17JWx9GQ0vfI
         i8YRzYS3oBFiEB7F2kP9cBlTqrqYoRViJdNk+4+QaGRjzb3pk3OnYWbCxgCoLj+yo6r9
         IpMBfXajeL+JAlblMwYEf9mophBdQ1foDgvru+AvmLwdNeWNvS4Db6mBn+jh9C5K9pGM
         KYsJman9wcj+qscEwIiXOLfnu/pPKwr4nxSexKV360+TAb8/Ic9B+f77l7aLjC0QgECr
         9wqhgS3amZW0AbOnXIZwygD37N3JWyRLi2Vw6l0KZjcasDBQoE1rKJnHUUz3c1YTMxEc
         MNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ZbwZRWFkiov8tgMOf6blh5vfWBl4kLotkr2eKXhFzTM=;
        fh=DBvxCipNH2RlJe8Lt8jDz73G7et6cRT4xOp4aNQo0jg=;
        b=aWK5gtqPJzU164P08uOvmhEEQ9NYSNNHS9lRgRsw1FQk7PeADvkCr+pBLS5UtoWqHl
         O3fZE0j6EjNHcXi+T3IEW5gfFIlmnJpDgMkGEW9qp12O8VkyhR0KbqIHsP1+bpT0i11M
         pXFwb3uhkpW65vWZExizlo4HgtXDj5PjupYdL+/wZFuGhSo9lIBHpi65v1qLQJkWVR+l
         vgKIXTv5VhFOYi1EBlhLFXtXiy5/tlH12AjvREoStU3sSvc0ZsMcr7CIUOsSoZGwCsom
         lcCWyVapnr3AL5v5Lfdm1io0JOzj8VWEkMF6MvCkLKhAhRanBoHhUJZPGf+7p8cNp86l
         ZmxQ==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782487448; x=1783092248; darn=lists.trustedfirmware.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZbwZRWFkiov8tgMOf6blh5vfWBl4kLotkr2eKXhFzTM=;
        b=Zu/qY0rPOlF51Czmj0NWnDJR23Gpea5yJH5R0VEphXpEG64r9z/GKRShwTbFjkY0Ta
         u0cKmBal2wL4dwlAl8TcrRATC/TDVpzrkzFnil6pE2FZcrWXEdXUDEXHO+eLIo6n0OfM
         fvC2Ay+wwcHQcbcSiBL+HlCLQCl3Cwa2SqE/DzovXGBIT2gROpTn7C2I+DyQn6BESfIZ
         y6ZavhjdKEjpDPhbZes+W4ZTmEw1JvkB6FopW3Uc2CAuaLQ5yEsYDqaVns9oEptSx4Vs
         jywXrXB3+6CJkTBv9hawBgdnimFO5XuREuwFzj3yFaF3Ek0wrpvErfK45/AZxIVZa+bt
         q3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782487448; x=1783092248;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbwZRWFkiov8tgMOf6blh5vfWBl4kLotkr2eKXhFzTM=;
        b=sLvT/2XbIWTTQnGKzS5R71jvvhkHqJ8M6bxM9qOrh8vieV1uC9QSiMfGzI6Ch0x060
         qhmFQ/cDvXVwkwFaAm/IaCfB1oEOV7ZyBD30s6VjhuLOSSMxEtLS7HtrUs1Wxo2AtsKW
         thehfoqfpfJyhAcI+Jx47buRhtVgEG7J1FEcGkoEMJFbn5WC3RNYjSjB7Cvgc4sQ7I0H
         pGD+n38CDerH/w8nVeaE5cgaHyylpiIe4edtufweEJqBTy3aifrgyo2lIvoHSDt0CsSh
         wltMeJsLKhW7XQIjPrzS5P4ibUoK6hG5e4pXU/V7Dv/ug3eMvISY8fThTpt3Z7Gf6zNE
         WHmg==
X-Gm-Message-State: AOJu0Yy8MvqoVheZb1zg+ltPcpDjaETSeMjrriGoWtXYwaXyvz3CGpRZ
	ksxLGeX0QMD0cIp+h/3Qn0LzmRDzaEw+JIv1kRJXy74IaFg6WFGCA/j1YaNMmBKC7Ne7y3890sl
	9HgmtI2wTR1A3jIjArjSFoKw/x287mAuShA67JO4=
X-Gm-Gg: AfdE7clF+sq6ov6zvVsrcRWOLm/ucCo79Cr2ClAfLvtjW9bvUca7RoaaGfKu17Yf28g
	McSYkl0LhH5hOISIDm8dB7P1DRJGYJRT2xTNvoxYXKv0HkYf5B5t+PRbSskF/d002qNJYfn+p5h
	C2VpSdtSl2zhMBSRzQ6T87utdWg2LLl5qoryO21QHGxbTNoiyAOqq4wHarKlXNK3HJntgUPsaPf
	f6xpnz+JcoXtxBdk9TIDDeolJNdZQtGVTEy0q6HESgBUwGAjxQIn1tmq2T3WQ/tApSJ0N928xKZ
	8VV0daloWPtiedS7tqAhBk//61P62VRstcrYQK4LZ9R4I1LHv03M/AVGvTA=
X-Received: by 2002:a05:6820:2910:b0:6a1:50e7:5c0f with SMTP id
 006d021491bc7-6a150e75d86mr546463eaf.58.1782487447810; Fri, 26 Jun 2026
 08:24:07 -0700 (PDT)
MIME-Version: 1.0
From: Joakim Bech <joakim.bech@gmail.com>
Date: Fri, 26 Jun 2026 17:23:56 +0200
X-Gm-Features: AVVi8CfDTExzfeXFm0lAr7pH6VbUVfIZrH4fTc_n1A4Rl8zItyvAxjVt3d-9XZI
Message-ID: <CALh3NmE7pch+-OTHQQ1ZW1qwcjVkmwOr2NNHh7PJ_TL9m3y4vg@mail.gmail.com>
Subject: OP-TEE going forward
To: op-tee@lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.41 / 15.00];
	BAYES_HAM(-1.31)[90.13%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.45:from];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.45:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B347743854
X-Spamd-Bar: ---
Message-ID-Hash: 7VH3DB77WCOLFL4GEO5Z5ZJGU67KXFUI
X-Message-ID-Hash: 7VH3DB77WCOLFL4GEO5Z5ZJGU67KXFUI
X-MailFrom: joakim.bech@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7VH3DB77WCOLFL4GEO5Z5ZJGU67KXFUI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGksDQoNCk9QLVRFRSBoYXMgYmVlbiBydW5uaW5nIHN1Y2Nlc3NmdWxseSBhcyBhbiBvcGVuIHNv
dXJjZSBwcm9qZWN0IHNpbmNlIDIwMTQNCmFuZCBjYW4gYmUgY29uc2lkZXJlZCBhIG1hdHVyZSBw
cm9qZWN0LiBJdCBpcyB3aWRlbHkgdXNlZCBpbiB2YXJpb3VzDQphcHBsaWNhdGlvbnMgYW5kIGRl
dmljZXMsIHVzZWQgYnkgYm90aCBzbWFsbCBhbmQgbGFyZ2UgY29tcGFuaWVzIGFuZCBpdCBoYXMN
CmFuIGFjdGl2ZSBjb21tdW5pdHkuDQoNCkFsdGhvdWdoIG93bmVyc2hpcCB0cmFuc2ZlcnJlZCBm
cm9tIExpbmFybyB0byBUcnVzdGVkRmlybXdhcmUgYSBjb3VwbGUgb2YNCnllYXJzIGFnbywgdGhl
IGNvcmUgYWN0aXZpdGllcyBhcm91bmQgT1AtVEVFIGhhcyBiZWVuIG1haW5seSBiZWVuIGRvbmUg
YnkNCkxpbmFybyBlbXBsb3llZXMgYW5kIGFzc2lnbmVlcyAoZW5naW5lZXJzIGZyb20gb3RoZXIg
Y29tcGFuaWVzIHdvcmtpbmcgd2l0aA0KTGluYXJvKS4gSG93ZXZlciwgd2l0aCB0aW1lIHRoaW5n
cyBjaGFuZ2UuIFRoZSBjb3JlIG1haW50YWluZXJzIFsxXSBoYXZlDQptb3ZlZCBvbiB0byBvdGhl
ciBjb21wYW5pZXMgYW5kIHdlJ3JlIG5vdyBpbiBhIHNpdHVhdGlvbiB0aGF0IG5vbmUgb2YgdGhl
DQpjb3JlIG1haW50YWluZXJzIGFyZSB3b3JraW5nIGZvciBMaW5hcm8gYW55bW9yZS4gQWx0aG91
Z2ggd2UgYXMgY29yZQ0KbWFpbnRhaW5lcnMgaGF2ZSBleHByZXNzZWQgd2lsbGluZ25lc3MgdG8g
Y29udGludWUgY29udHJpYnV0aW5nIHRvIHRoZQ0KcHJvamVjdCwgT1AtVEVFIGlzIG5vIGxvbmdl
ciB0aGUgb25seSBwcm9qZWN0IHdlIGFyZSB3b3JraW5nIG9uIGFuZA0KdGhlcmVmb3JlIHdlIGNh
bm5vdCBjb21taXQgYXMgbXVjaCB0aW1lIHRvIHRoZSBwcm9qZWN0IGFzIHdlIHVzZWQgdG8uDQoN
CldpdGggdGhhdCB0aGVyZSBhcmUgc29tZSBvcGVuIHF1ZXN0aW9ucyBsaWtlLCB3aG8gaXMgdWx0
aW1hdGVseSByZXNwb25zaWJsZQ0KZm9yIHRoZSBwcm9qZWN0LCB3aG8gYWRtaW5pc3RlcnMgbWFp
bGluZyBsaXN0cywgbWVyZ2UgcGF0Y2hlcywgcmVzcG9uZHMgdG8NCnNlY3VyaXR5IGluY2lkZW50
IHJlcG9ydHMsIHJ1biBtb250aGx5IG1lZXRpbmdzIGFuIHdobyBpcyB0aGUgb25lIG1ha2luZw0K
cmVsZWFzZXM/DQoNClNpbmNlIHRoaXMgdG91Y2hlcyBsZWdhbCBhc3BlY3RzIGFuZCBwbGFpbiBw
ZXJtaXNzaW9ucywgd2Ugd2lsbCB3b3JrIHdpdGgNCkxpbmFybyB0byB0cnkgdG8gZmluZCBhIHNv
bHV0aW9uIHRvIHRoaXMgc2l0dWF0aW9uLCBidXQgdGhpcyBhbHNvIG1lYW5zDQp0aGF0IHdlJ3Jl
IGxvb2tpbmcgZm9yIG5ldy9hZGRpdGlvbmFsIG1haW50YWluZXJzIHRvIGhlbHAgd2l0aCB0aGUg
cHJvamVjdC4NCk1haW50YWluZXJzIHRoYXQgY2FuIGNvbW1pdCB0aW1lIHRvIHRoZSBwcm9qZWN0
IGFuZCBoZWxwIHdpdGggdGhlDQpkYXktdG8tZGF5IGFjdGl2aXRpZXMuDQoNCkEgZGlyZWN0IGNv
bnNlcXVlbmNlIG9mIHRoaXMgc2l0dWF0aW9uIGlzIHRoYXQgd2Ugd2lsbCBub3QgYmUgYWJsZSB0
byBtYWtlDQp0aGUgcmVsZWFzZSBtZWFudCB0byBiZSByZWxlYXNlZCBKdWx5IDE3dGggMjAyNiBb
Ml0uIFRoYXQgcmVsZWFzZSBoYXMgYmVlbg0KZHJvcHBlZCBhbmQgd2UgaW5zdGVhZCBhaW0gdG8g
bWFrZSB0aGUgbmV4dCByZWxlYXNlIGluIE9jdG9iZXIgMjAyNi4NCg0KSWYgeW91IGFyZSBpbnRl
cmVzdGVkIGluIGhlbHBpbmcgb3V0IHdpdGggdGhlIHByb2plY3QsIHBsZWFzZSByZWFjaCBvdXQg
dG8NCnVzIG9uIHRoZSBtYWlsaW5nIGxpc3Qgb3IgZGlyZWN0bHkgdG8gYW55IG9mIHRoZSBjb3Jl
IG1haW50YWluZXJzLiBXZSBhcmUNCmhhcHB5IHRvIGRpc2N1c3Mgd2hhdCBpdCBtZWFucyB0byBi
ZSBhIG1haW50YWluZXIgYW5kIHdoYXQga2luZCBvZiBoZWxwIHdlDQphcmUgbG9va2luZyBmb3Iu
DQoNClsxXQ0KaHR0cHM6Ly9naXRodWIuY29tL09QLVRFRS9vcHRlZV9vcy9ibG9iLzdjMzhjYzM1
OGUzNmE4Yjc0YTNmZWZlZGIwYzVjN2Y3OGJlMDU4ZGMvTUFJTlRBSU5FUlMjTDQwMC1MNDAzDQpb
Ml0gaHR0cHM6Ly9vcHRlZS5yZWFkdGhlZG9jcy5pby9lbi9sYXRlc3QvZ2VuZXJhbC9yZWxlYXNl
cy5odG1sDQoNCi8vIFJlZ2FyZHMsDQpKb2FraW0sIEplbnMsIEplcm9tZSBhbmQgRXRpZW5uZS4N
Cg==
