Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F014FC43458
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 10:13:48 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 30C6144EA6
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 10:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782814428;
	bh=Y0HeA7vcQKzETHead9KOFN5K8r/CS2Pk8qKXBxT1fLc=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=3L/Vx+hmJIopa03z/Exi9y2+UFwBMKox1yZPbUjgyDHa4RwzzcsZ0IVSZZk/VRgCe
	 mfDXkNYtIOIRtEuEfe9f93WRMuuySicHY9QQNyjYgmtxQ+swLFsDaohGJ8kSmWUXAb
	 +wP9GKkWAEQoyZEWWqmvD3Dv1W84DgVP0V3nTVhowJmww0lTS56zBfCa7zizdNCCQb
	 8zGKLatZoP8b/IYXez/0CK1PKPMlUDZzzXbktf+f3AlNQ2VD8r1ckYyHFVBv0UMAuR
	 OCLPlCqeqpJfxjY8ONo7xPezS2m8apNvodfLv5IOwRgrQoyh+apVz2g7yonNSGEKg0
	 G5/4xSvNDRPqw==
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 01612444F4
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 10:13:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mEGLUGcV;
	dkim-atps=neutral
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4926e5803e5so42095e9.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 03:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782814420; x=1783419220; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nMjuFcF1JOSdoZXexZR3W9kBR6KPAe7iuNXDZe8pc5M=;
        b=mEGLUGcVNbnQccdIvVDrcmai0nmINE1jD/6xlkOXPG7FcaxoV52ZPfoUYAxUvVXom5
         pDK57590CwvkDFsWivJ+wh75OWWDC4iq2784eZxs9CRinnKLjZFybQKhTHi1IfiSeTpw
         2SVKxaoUvzPu/oARjgaynoGHpAaWngSACJzZ+lIKmw1YFUf66e64ontpmpXEDsrfc3GU
         TY35dTBz8wAjvwVR6PDBZ8UGdKU3vpmE9F/27qbdIyYm1ky6kcXcX3LdSFTcTP6H1ODD
         2aA/pswMLW1R7K/LOUXrR9DkExy+C9qqU9YpOKkI0cEsdwyBCMYtVPpbAaPUTQIjEKr7
         Tjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814420; x=1783419220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nMjuFcF1JOSdoZXexZR3W9kBR6KPAe7iuNXDZe8pc5M=;
        b=CSLRq39tUvOwe4VYQAHE/upnIpXIgXeHAeCr+O7w10necp8KkghK0SpeyWMOvUNyG9
         nEbtU3vuwmXyptnTTYnWDof1/xHl1RTzoOxIJZZr4hTw963vxBwzqzGTn6gsEEJRhtBT
         UF6UGF7doWQ4UD/1rrfju1lq7VuSWoDHBHuyjn3Glm6IlJUdksRAGt3/UxesYlthOGaj
         B6VJ6zZ+6GTGXg3tqD6AvhfBm1tuD1iT5F8d3OcuFkoSx/e3Wf8hhQXw2vkGsbhiARaM
         lgYW049O0PLOQwWjgb5gpJoEzgd803T1k9qUwbTys196ogammQRk6iul4KVwiHJ5svFb
         f6ug==
X-Forwarded-Encrypted: i=1; AFNElJ8vRVJMN8t/Rpe/kt/eCXq0o7C+TBWt2ss43MSjKy1vUAefjR6qSQPVlqgi1xqcKGMDtupaZgs=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxyQs07h+3Ob2Wi7MHXjZ6rEC9XrdSB357e9t/mrbzk1rJuXKRk
	gadi7MoNlze7ntv6rRAX/cnobSns893HV9zm1BhBHsyR9LgDnSrQWOpfXBKrasQnVQ==
X-Gm-Gg: AfdE7cmP8maWCxlFuXFZQpntzsKIW+9v/CkMT03zCFDAiiKKPcZs4aqF5KBBVVGjrwW
	Ej8rRuW9g0jPVBWVKFTebht2nePwH20RxWFtTUHpfVhlMkGHe56RLJGUOAcioe1TtIWnOUaMXdz
	sh/kFxkngJTnM5Rr25Us689Gj5tYDT00VLDoGcK3e6xIInCx52IJ1o51wF9rGEpgnhPTcc5NX7h
	fAm9utrlUPUroTiW3/JBBG3a+yh8TtA5R9bplL3FmnRDaHTldbJnJ3n8UDMOa6TAhOWG+tc1KXz
	FSE+Jw14+daIpuBaToBymIQEN3UNNh6TTLZDg35BeAauyaFyE5xzmlniKzY9HLqcPadyV03ZWVi
	2hmTi45p2Txn46yTXahngXbbRva0L+AimW4av3qK+nf/QITkGbniwnER6zi05tWc6wWHNJDDqZ5
	2qhJTztmUqKkhnJ+vv3OYzHuG0EfY/uvGW8htnd/sFwOC8IL2FYTuRlkXMCGfekGyNc/lZZA==
X-Received: by 2002:a05:600c:3e0d:b0:490:ab15:b9e8 with SMTP id 5b1f17b1804b1-493bd6f0744mr57395e9.2.1782814417931;
        Tue, 30 Jun 2026 03:13:37 -0700 (PDT)
Received: from google.com (143.11.148.146.bc.googleusercontent.com. [146.148.11.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475671d02f5sm6914506f8f.28.2026.06.30.03.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:13:37 -0700 (PDT)
Date: Tue, 30 Jun 2026 10:13:33 +0000
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v7 1/7] optee: ffa: Add NULL check in
 optee_ffa_lend_protmem
Message-ID: <akOWzVB_yw1-u5uN@google.com>
References: <20260617145130.3729015-1-sebastianene@google.com>
 <20260617145130.3729015-2-sebastianene@google.com>
 <CAHUa44GST=efeDepEHWs_=ehr7JVnkg+y0ZLebcLAGZXxpNegA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAHUa44GST=efeDepEHWs_=ehr7JVnkg+y0ZLebcLAGZXxpNegA@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,lists.linux.dev,lists.infradead.org,vger.kernel.org,google.com,gmail.com,lists.trustedfirmware.org,linux.ibm.com,huawei.com,oss.qualcomm.com];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.42:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[146.148.11.143:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[google.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.42:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 01612444F4
X-Spamd-Bar: --
Message-ID-Hash: FSIAL6RXEHGN72UGALMG5LIORBVTIB6C
X-Message-ID-Hash: FSIAL6RXEHGN72UGALMG5LIORBVTIB6C
X-MailFrom: sebastianene@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org, will@kernel.org, joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FSIAL6RXEHGN72UGALMG5LIORBVTIB6C/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sebastian Ene via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sebastian Ene <sebastianene@google.com>

T24gTW9uLCBKdW4gMjksIDIwMjYgYXQgMTA6NTM6MzNBTSArMDIwMCwgSmVucyBXaWtsYW5kZXIg
d3JvdGU6DQo+IEhpLA0KPiANCj4gT24gV2VkLCBKdW4gMTcsIDIwMjYgYXQgNDo1MeKAr1BNIFNl
YmFzdGlhbiBFbmUgPHNlYmFzdGlhbmVuZUBnb29nbGUuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZy
b206IE1vc3RhZmEgU2FsZWggPHNtb3N0YWZhQGdvb2dsZS5jb20+DQo+ID4NCj4gPiBGcm9tOiBN
b3N0YWZhIFNhbGVoIDxzbW9zdGFmYUBnb29nbGUuY29tPg0KPiA+DQo+ID4gU2FzaGlrbyAobG9j
YWxseSkgcmVwb3J0cyBhIHBvc3NpYmxlIG51bGwgZGVyZWZlcmVuY2UgdW5kZXIgbWVtb3J5DQo+
ID4gcHJlc3N1cmUgZHVlIHRvIHRoZSBsYWNrIG9mIHZhbGlkYXRpb24gb2YgdGhlIGFsbG9jYXRl
ZCBwb2ludGVyLg0KPiA+DQo+ID4gRml4IHRoYXQgYnkgYWRkaW5nIHRoZSBtaXNzaW5nIGNoZWNr
Lg0KPiA+DQo+ID4gRml4ZXM6IDJiNzhkNzljZGY5NiAoIm9wdGVlOiBGRi1BOiBkeW5hbWljIHBy
b3RlY3RlZCBtZW1vcnkgYWxsb2NhdGlvbiIpDQo+ID4gU2lnbmVkLW9mZi1ieTogTW9zdGFmYSBT
YWxlaCA8c21vc3RhZmFAZ29vZ2xlLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTZWJhc3RpYW4g
RW5lIDxzZWJhc3RpYW5lbmVAZ29vZ2xlLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogU3VtaXQgR2Fy
ZyA8c3VtaXQuZ2FyZ0Bvc3MucXVhbGNvbW0uY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3Rl
ZS9vcHRlZS9mZmFfYWJpLmMgfCAzICsrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspDQo+IA0KPiBJJ20gcGlja2luZyB1cCB0aGlzIGlzb2xhdGVkIHBhdGNoIGZyb20gdGhl
IHBhdGNoc2V0Lg0KDQpUaGFua3MgZm9yIGxldHRpbmcgbWUga25vdywgSSB3aWxsIHNwaW4gYSB2
OCBidXQgbm90IGluY2x1ZGUgdGhpcyBwYXRjaA0KYW55bW9yZSBzaW5jZSB5b3UgcGlja2VkIGl0
Lg0KDQo+IA0KPiBDaGVlcnMsDQo+IEplbnMNCg0KU2ViYXN0aWFuDQo=
