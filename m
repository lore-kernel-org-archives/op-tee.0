Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F23CDE008
	for <op-tee@archiver.kernel.org>; Fri, 26 Jun 2026 09:21:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A396644E5C
	for <op-tee@archiver.kernel.org>; Fri, 26 Jun 2026 09:21:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XOD4fOOg;
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id F2F9243AD3
	for <op-tee@lists.trustedfirmware.org>; Fri, 26 Jun 2026 06:25:39 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-697f6c67028so1175907a12.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 25 Jun 2026 23:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782455139; cv=none;
        d=google.com; s=arc-20260327;
        b=hvfMnMwYSMbnYgkpXu3Wl4v1pTB/9HCQSJ4agzGO6I88y/ptFzi6pNapQGB1FwLFSX
         +k2jAcQNBkSXJ1hXjGlT7gmxJlMNQ2/rFUZzgOakO9w74BKwZgZDyrAV0D8PlLx2VpSF
         sM7di9B/fOJQOIww7SotyVKGvJnojCechuYi0Ekp+DiPyePLMfZoB51z/VL837PASEf1
         e6CzVIJgWQXtTbyb3LOWKuZgT8CrkhQ+RYawULjEJlU+mYcSonMpO3DPonXfKOslPN6I
         jaCEoDBTQqF81I/r3dH/HW+xc/wDT9hlwBjpwKwcWfXiIdP8uWtEXjPKtNMVSYJiKltY
         7Nlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ovzk7VQAV6v6yqxXRWKnF95LCyLuZw9njHmBH04w9DA=;
        fh=DBvxCipNH2RlJe8Lt8jDz73G7et6cRT4xOp4aNQo0jg=;
        b=ZwTjAdogMBWDczS3LxqO8KkTBpi/AIFsIoj1a29+r45OPXcIFWYPgKEeOvs2AoLHlm
         cZ+G8SBynAN8aA9Z4vDaen8PutyasmkfS7JciAf3vnzh9ig8Iz6Dt1kDHwWxTz3X/kOm
         E2WcKQC2fBDPlICbN16pkp8nPmn9bbKa7N3zkOP1t2L1cafrvzrGlP7jyu+L032GgqSv
         dpyfXqLFNaY2uXqVSvbTwF9udyys4bJWnXmf3qPNM9f4QJlQnpdoqKz4lfC3JamaIg0O
         9fpv3V1UVQOtoKdeDOvKudiDtY0GSXxw00dBWai/ecls+6hpWLi1KDtR1nAPzV9XUMax
         iDeA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782455139; x=1783059939; darn=lists.trustedfirmware.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ovzk7VQAV6v6yqxXRWKnF95LCyLuZw9njHmBH04w9DA=;
        b=XOD4fOOgLclxcM9RtLQ4H0bxSe0rOBqlk3GQoGfh5/UmXfF5j1VaFq+GPPyEmDTEQR
         6li6aSPvMsoYueDnA4ZB96S3It1m6fotQFo0pERCiMySl5EbeRRG+BYb4GdHvOTy95IZ
         u8SRbLLLr+6XdbimVfvMRo09FKrMBoK65KJanHWp3QcQ1fHlPiONr9q6twobH3/xyTeG
         K6HHHKkH+bvHj9KPCmJpjjMqwFMyE7WHU82ohBE8NRaZW8Iek/rq60Yyz5wAT+uw5SHh
         bgDuxaWIjkAy4HGygdVVAUj2Rtk5ildLyZdlKQRr0TjVszW3lEOPIv7tLAzh6GLaXkpL
         yB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455139; x=1783059939;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovzk7VQAV6v6yqxXRWKnF95LCyLuZw9njHmBH04w9DA=;
        b=iqiHytlgpZp1hznAVvzzzLb1c4Dc7FPLFQJtNJm6iNqEqtgy8MiANycgAa2okBVdvO
         bILVLbJpzOe6tBWh1yfJ4yYmZt71vjyfKGkhVUxoAVlHnTr3LRTLT2cSWdQ+NkNmeCqv
         C5skrlSLnoEHncJAZCUTRCAYyPs7UrH86MrY7cQtEUnPGd/N7hH1zaIXwCTe82so5kNF
         6kjiDjaOj2f3+Bx3z7zzE1MiwQKwAYy6GcLg+dhF0MyupDTqdRws5tFFrGNN0h0FcW2H
         tJSYIAWyf9OqytWa5C7FjCtptsna9Cg4qXL/iK8NqMpvA22XEThBO7QehUPMWiYUu5Zk
         yHDg==
X-Gm-Message-State: AOJu0YyIiz6XSyqH2hsar56kTegXH2R3p4GrmbgwrUO/RxZMzPzDf9Kb
	Jgm9SPtwUZr86pU6VeaKroipgxLbWOA0Koz13DOyCe9gkZBAeVrLlqGk9RBgAsKG9kMDCp1fY8S
	GrnPR8kRJ/cYKPKgJmvkB6JFzCebsWpz6g8Qc
X-Gm-Gg: AfdE7cnIGI0vx0bxkNggg620VPwyZ68BY9v9JlRLbS9IVYyYr6nBNDmiD4PKTkwpvOo
	M5DYdxlmYTijEDnXzbD5bKnF3qgMv3JOGJaqkQ2RjbY9O0OwjHOrtc2eibaB/TM2ayImhn5N8UT
	cf7nqRSZnQ9Bn4D5yqMWjoXb1vxojQynQIqs0Htf44/JLFTDkAwVYLiQqUsipZbNhtp/wj2T5aK
	Fu0fhcS6kxjn2gsu7B2WbEe+vJW1FfpZFISHZB8DivkR2OSP6rMWanfIPZMUxZbn81bg9bimPA=
X-Received: by 2002:a17:907:c08d:b0:c12:27c2:2e85 with SMTP id
 a640c23a62f3a-c1227c232a3mr53674266b.9.1782455138582; Thu, 25 Jun 2026
 23:25:38 -0700 (PDT)
MIME-Version: 1.0
From: Brand Unit <brandunit69@gmail.com>
Date: Fri, 26 Jun 2026 12:25:26 +0600
X-Gm-Features: AVVi8CdlODCgl6LQq0UcU6zCo3pyzcxgsfzW8G4cnDVOjOHPJFybtN0MEkrIXUc
Message-ID: <CAGHBKnNPHGPkoYnE-6FzoDYsXepmzpW8FCQzE237CqRSruAJEw@mail.gmail.com>
Subject: Critical Vulnerabilities in OP-TEE/libfdt - CVE Assignment Request
To: op-tee@lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.28 / 15.00];
	BAYES_HAM(-1.28)[89.89%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.44:from];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.44:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: F2F9243AD3
X-Spamd-Bar: ---
X-MailFrom: brandunit69@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: PRGYIBA7POG2PL2ALIYR526WD2RLYMBC
X-Message-ID-Hash: PRGYIBA7POG2PL2ALIYR526WD2RLYMBC
X-Mailman-Approved-At: Fri, 26 Jun 2026 09:21:48 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PRGYIBA7POG2PL2ALIYR526WD2RLYMBC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

KkRlYXIgVHJ1c3RlZEZpcm13YXJlIFNlY3VyaXR5IFRlYW0sICoNCg0KKldlIGhhdmUgZGlzY292
ZXJlZCA0IGNyaXRpY2FsIHZ1bG5lcmFiaWxpdGllcyBpbiBPUC1URUUgYW5kIGxpYmZkdDoqDQog
IDEuIEludGVnZXIgVW5kZXJmbG93IGluIFBLQ1MjMTEgUlNBLUFFUyBLZXkgVW53cmFwIChIaWdo
KQ0KICAyLiBJbnRlZ2VyIFVuZGVyZmxvdyDihpIgU3RhY2sgQnVmZmVyIE92ZXJmbG93IChIaWdo
KQ0KICAzLiBIZWFwIFVuZGVyZmxvdyBpbiBvdmVybGF5X3N5bWJvbF91cGRhdGUoKSAoSGlnaCkN
CiAgNC4gSGVhcCBCdWZmZXIgT3ZlcmZsb3cgaW4gZmR0X25leHRfdGFnKCkgKEhpZ2gpDQoNCipB
bGwgdnVsbmVyYWJpbGl0aWVzIGhhdmUgYmVlbjogKg0K4pyTIFJlc3BvbnNpYmx5IGRpc2Nsb3Nl
ZCB2aWEgR2l0SHViIFNlY3VyaXR5IEFkdmlzb3J5IChlbWJhcmdvZWQpDQrinJMgRG9jdW1lbnRl
ZCB3aXRoIFBvQyBhbmQgdGVjaG5pY2FsIGFuYWx5c2lzDQrinJMgUmVwb3J0ZWQgdG8gSW50aWdy
aXRpDQoNCkdpdEh1YiBBZHZpc29yeSAoZW1iYXJnb2VkIHVudGlsIFNlcHQgMjQsIDIwMjYpOg0K
WyBHaXRIdWIgbGluaw0KPGh0dHBzOi8vZ2l0aHViLmNvbS9PUC1URUUvb3B0ZWVfb3Mvc2VjdXJp
dHkvYWR2aXNvcmllcy9HSFNBLXc4NXctaHA3Mi1qMzNnPg0KIF0NCipXZSBhcmUgcmVxdWVzdGlu
ZzogKg0KICAqMS4gRm9ybWFsIENWRSBhc3NpZ25tZW50ICoNCiogIDIuIFRpbWVsaW5lIGZvciBw
YXRjaCByZWxlYXNlICoNCiogIDMuIEFja25vd2xlZGdtZW50IGluIHNlY3VyaXR5IGFkdmlzb3J5
Kg0KUG9DIGlucHV0cyBhbmQgZGV0YWlsZWQgdGVjaG5pY2FsIGRvY3VtZW50YXRpb24gYXZhaWxh
YmxlLg0KQ29udGFjdDogbWVoZWRpMTAwIChtZWhlZGkxMDBALi4uIGlmIHlvdSBuZWVkIGRpcmVj
dCBjb250YWN0KQ0KIFJlZ2FyZHMsDQpNZWhlZGkgSGFzYW4NCg==
