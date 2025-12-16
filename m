Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B17DD5E128
	for <op-tee@archiver.kernel.org>; Tue, 16 Dec 2025 10:53:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 65FD04FEDA
	for <op-tee@archiver.kernel.org>; Tue, 16 Dec 2025 10:53:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JypnC0O7;
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 65A1B4FE8E
	for <op-tee@lists.trustedfirmware.org>; Tue, 16 Dec 2025 10:53:16 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so7589954a12.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 16 Dec 2025 02:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765882395; x=1766487195; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SyLRPeLgGroQt1zWR2UffRTFVA4a7Ly7CRnPUKhzpZ0=;
        b=JypnC0O7KojsJLRDU6PMpeDdvf1Ajsg857oqwmQtBwI25tG1gSXYgQodFO+U9VSDS1
         t5uqS7Zj6+n7voGcx5oDt4sadH/BZ2zIgSCX8Th6avKYEJIj7z6PP6jMjgC3pTQxzdA9
         8HqCTTn6WXyzdn/jDeUQY7e8AMiFLw2FZz+zwUH9bkWqaoRglVcjyGStNcRRQ8JsH9js
         Y7FMWraL+rIWrGJqGJgikgHqUjoYwVO6Kujm7/KWUxmS18YwWl8leoqJiyw01576cX2p
         SmJ8Yn9Xu+Im5GHRE9r/6yIIcvh+6vYojMPBKlw5Qy3hKH3wIC/hKhjSGKYNomMWjy6q
         hl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765882395; x=1766487195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SyLRPeLgGroQt1zWR2UffRTFVA4a7Ly7CRnPUKhzpZ0=;
        b=mU3/5a909Z+VhkvYnJxu0qcGrvT0xZA32UMotAaoBZzqAD9tJWtNmAb0a1SB92BkxW
         o2wkP2eO5DBDph1+E8COpGoEtN+18Fo8LHCam9niTjyph2yNsippYv0/gdYKBz1VIO3o
         AL5d48bGhKXs2C8N4UgSiSln1BiouIsDWfgxJVOfG0GnVaGkwRL7MHiY9HaS5BVEODst
         NzspZK4F3LZYAkegy1+7d+CI1efL/W+ykY1I8l1LAP58zntQTxPUGjXRA2dnpZdBUpWC
         E+pwiAPNuFWdC+xiu/11sDdVN5GW/QabDafMgB25ZvtOeCfjHybWEpfsopFD7z8ibCPL
         6kVQ==
X-Gm-Message-State: AOJu0YyEqGSQ6xqZ3W+NZHk3SPkJ+RMJYSzDMp0ATls9KNOuTwvRCWHa
	wCu8ePpqCDOzWCRq7TGleU6cy35ZQsaBN3WLdtLesWF0n4OOpm6CVdviNM9BKlruBHtBaQ==
X-Gm-Gg: AY/fxX7gQ5EfMOIH5zj74y9dbGrZ0dm+lDvMKJ3j+Hqis3JgLHHRynpSsyYMPMS/GVQ
	l1hDRjzfnMvysuUi8b9b2jPiySQZgdl0fg/nffPoSoIh2UwtDMhL11JyV4zumSI5nkgAY6oZc+x
	U+EN1vPg4TB5aDWWmdEaaQpBoAztQSEYNxd4m3UskpaIrsWf0ddQVO921eHlTlB9eWG6/RAG61r
	6zhxQ74QrM/fKUdVASG1YAdaZYeUl/vdKLj5z+eT5XWHtiN3WwvUzNsnDSd1tNi/yR++ePb7Pzj
	5RkhrloYztvo4BabjKDrX1t8dGg/GbGAyUWsXP/vl+awURjyBTTstqpEQDx9MSGY6WKWtIAl6ax
	pH0rjQeKp85R4XmDKGE6+HsNzW+RaUjEWrcZThPsKufGviyGI3On/R87IngD9sDhmvnbR43gJnc
	RgirlqwQ9zE0VZqPNcdQ7yjA==
X-Google-Smtp-Source: AGHT+IGbhgIaUlkNBa5tk7YK+yQOOxN8cvoTlUAxi29CMCjzL9eXhnIrcz5Oao2N22vxzMHxnmk4kQ==
X-Received: by 2002:a05:6402:2794:b0:649:81d3:e99e with SMTP id 4fb4d7f45d1cf-6499b1ceddemr12380833a12.25.1765882395289;
        Tue, 16 Dec 2025 02:53:15 -0800 (PST)
Received: from [10.100.0.2] ([194.15.111.154])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210fd44sm15847452a12.26.2025.12.16.02.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 02:53:14 -0800 (PST)
Message-ID: <f76a7766-08b9-4bc9-9d04-0ed61087ccc0@linaro.org>
Date: Tue, 16 Dec 2025 11:53:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: build breakage with SCMI
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Valentin Caron <valentin.caron@foss.st.com>
References: <aUBbXjP7B0jDVkeN@stanley.mountain>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <aUBbXjP7B0jDVkeN@stanley.mountain>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.98 / 15.00];
	BAYES_HAM(-2.98)[99.93%];
	URI_HIDDEN_PATH(1.00)[https://github.com/OP-TEE/optee_os/blob/master/.github/workflows/ci.yml#L226];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.42:from];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.42:from];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[209.85.208.42:server fail];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 65A1B4FE8E
X-Spamd-Bar: --
Message-ID-Hash: KERSRJRDS3SLM7X6MDXALTASUJDMQKJ7
X-Message-ID-Hash: KERSRJRDS3SLM7X6MDXALTASUJDMQKJ7
X-MailFrom: jerome.forissier@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KERSRJRDS3SLM7X6MDXALTASUJDMQKJ7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGkgRGFuLA0KDQpPbiAxMi8xNS8yNSAyMDowMiwgRGFuIENhcnBlbnRlciB3cm90ZToNCj4gV2hl
biBJIHRyeSBidWlsZGluZyB3aXRoIGBtYWtlIHJ1biBXSVRIX1NDTUk9eWAgdGhlbiB0aGUgYnVp
bGQgZmFpbHM6DQo+IA0KPiBjb3JlL2xpYi9zY21pLXNlcnZlci9zY21pX3NlcnZlci5jOiBJbiBm
dW5jdGlvbiDigJhzY21pX3NlcnZlcl9pbml0aWFsaXpl4oCZOg0KPiBjb3JlL2xpYi9zY21pLXNl
cnZlci9zY21pX3NlcnZlci5jOjgzOjIyOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2Yg
ZnVuY3Rpb24g4oCYc2NtaV9jb25maWd1cmXigJkgWy1XaW1wbGljaXQtZnVuY3Rpb24tZGVjbGFy
YXRpb25dDQo+ICAgIDgzIHwgICAgICAgICAgICAgICAgIHJjID0gc2NtaV9jb25maWd1cmUoY2Zn
KTsNCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fg0KPiANCj4g
VGhpcyB3YXMgaW50cm9kdWNlZCBpbiBjb21taXQgY2U2ZWE0MTEyMDA4ICgic2NtaS1zZXJ2ZXI6
IGNvbmZpZ3VyZQ0KPiBTQ1AtZmlybXdhcmUgZnJvbSBEVCIpLiAgQSBncmVwIGZvciBzY21pX2Nv
bmZpZ3VyZSgpIHR1cm5zIHVwIGVtcHR5Lg0KPiBXYXMgcGFydCBvZiB0aGUgY29tbWl0IG1pc3Np
bmc/DQoNCkkgc3VzcGVjdCB5b3VyIFNDUC1maXJtd2FyZSBzb3VyY2UgdHJlZSBpcyB0b28gb2xk
LiBQbGVhc2Ugc2VlOg0KaHR0cHM6Ly9naXRodWIuY29tL09QLVRFRS9vcHRlZV9vcy9ibG9iL21h
c3Rlci8uZ2l0aHViL3dvcmtmbG93cy9jaS55bWwjTDIyNg0KDQpUaGFua3MsDQotLSANCkplcm9t
ZQ0KDQo+IA0KPiByZWdhcmRzLA0KPiBkYW4gY2FycGVudGVyDQo+IA0K
