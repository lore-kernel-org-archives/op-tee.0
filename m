Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A524CDE00E
	for <op-tee@archiver.kernel.org>; Thu, 25 Jun 2026 20:51:31 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 67D6844EF6
	for <op-tee@archiver.kernel.org>; Thu, 25 Jun 2026 20:51:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=GYAIdYuO;
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B12AE43299
	for <op-tee@lists.trustedfirmware.org>; Thu, 25 Jun 2026 20:51:22 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso2061625e9.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 25 Jun 2026 13:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782420681; x=1783025481; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=56KnvKb2f10kk6NZo1dnYB4KHKkcPVZ6avkUXiH5CCw=;
        b=GYAIdYuObsGmdh9t46gO9om+j1399vjYgBaf2CWqsc+bfRgVQniHe0/+J3GTSt2T3v
         1CF85NxB6pgvbp+QGpGLaBeKpR4YV/rS9/jIOXz+hDDDfLztEie8EcFKGqNZdKdopxEd
         xSQOYpEY5lY7evoLNwP2444Z+ZqhJZWcV2FR3NvpOUIqfN8AK0bIZZdTQ/krdTpVTvxL
         yxTfSUTpuXxgn2eJVkMhbOwniQ7PaYfBGycyjacoI/6PkKV/FVutFjQQwcDoqUyM6yHp
         SeA5MxGVN5qX2C8ROKSm/p0ynUhhQttDJrXzTDPYywBV6WVfjixmXNppftpO+Oz4nGN9
         KObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782420681; x=1783025481;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56KnvKb2f10kk6NZo1dnYB4KHKkcPVZ6avkUXiH5CCw=;
        b=Fx5/TVE4lBTaEgpCZb0E+OHwNcPOB5YDqdFKP3dHjvaklZ+L0avoTrlw3szH59XUMi
         KDB5nhBSwfraoNrggcAELxgMkBX+dsOygOg18KkOOkfADvkGN6PX4pGd03RbIyhXwuir
         hWt++8klra7jZ9yF7dG6AEmdW84wEuvSpld0we4FPF2PerDbOABBZ9nQfoeBLN9eynTk
         QPJ7lPcTmRxwkWnxUg391G4qtSGGFDd3PXUHFiVptvHHMoHuLD/Hrfh1Md0Pt3cpolQk
         VvS1LBW60S1TE5dhRSo8Aq0Wjzvki92sViIv/Vd+lJwlTaWN3uTThutnQstWz4V4GVAJ
         X8rQ==
X-Gm-Message-State: AOJu0YzGH4kZtsJsvvuTHzfyrtgpHX8X1YTx5sURlHAl484MSMhU2Zey
	XHvzhg73w9TnuJEJ57z7iiuXHzsRGR9SiNavys2nLIEK/rkS2pFqBiLu45p9ZMnGzvw=
X-Gm-Gg: AfdE7cmvXc7kE69PsWxt6Sb+qTS65h63h0gOlgTfr2agbDFFstMLvG7DJVgK334PWjI
	pkJILNznUIREx+4mvbP5JuQrFX7YwPRX+J+ig2N4Ez/YAQN8GSoOPwKNPyW2le1RsVQ3vCh2ZIJ
	Nc2Xb1mN6PYNUYIvBG3Lmqjr4Fqhxw9FGRImzRImsIF5udhjQhgErjlCmAJsiCmKrPCRwXIYo54
	EsoNy3lSgPzIJxpH8T/fteHyv59LuTRCcNUYQTLs4CXtNYFSwa6lFrDQi148idA2S2SmV+IaZ68
	TR5m/wRU6/QdjqRIcbTg96ThNAcx3T+YzZ3FrGCjf2pXRrIrLVip1gA/wn1etfJ9OjmigJCi2Ve
	b+9dLlt+DR4kFbJrnUqCj6IQrnKVh9AmjKyeKJhhqdnVQS+KcwMNmlT4Mb5gWb7N5VAhutSllY/
	mJGRVWdbyNf/q8IVEhTCgXlzl0WIZmdMcZUfr6pNOQ9eepbMhq/U6GLEm25e54Ig==
X-Received: by 2002:a05:600c:3513:b0:492:564f:5603 with SMTP id 5b1f17b1804b1-49266850086mr59044095e9.14.1782420681182;
        Thu, 25 Jun 2026 13:51:21 -0700 (PDT)
Received: from [172.27.130.2] (97e782b0.skybroadband.com. [151.231.130.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fe949csm27705515e9.5.2026.06.25.13.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 13:51:20 -0700 (PDT)
Message-ID: <4a626073-9c32-491e-b7f5-cfd25d6eb001@riscstar.com>
Date: Thu, 25 Jun 2026 21:51:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] core: riscv: Implement Floating-Point and Vector
 extension context tracking
From: Dave Patel <dave.patel@riscstar.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
References: <20260623061855.17863-1-dave.patel@riscstar.com>
 <CAHUa44EJivE8XwoVO9Tnd6-Jp_F0hyDgwzwO6Gv-TOvgUfo36w@mail.gmail.com>
 <217e1d7a-a77c-415b-8018-3d80ccc82f7a@riscstar.com>
Content-Language: en-US
In-Reply-To: <217e1d7a-a77c-415b-8018-3d80ccc82f7a@riscstar.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.98%];
	DMARC_POLICY_ALLOW(-0.50)[riscstar.com,none];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.49:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[209.85.128.49:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B12AE43299
X-Spamd-Bar: ---
Message-ID-Hash: UZ6PGTORHYFXOUHVJPKCRZ3S65T2IX6U
X-Message-ID-Hash: UZ6PGTORHYFXOUHVJPKCRZ3S65T2IX6U
X-MailFrom: dave.patel@riscstar.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, Samuel Holland <samuel.holland@sifive.com>, Peter Lin <peter.lin@sifive.com>, Robin Randhawa <robin.randhawa@sifive.com>, Scott Bambrough <scott@riscstar.com>, Ray Mao <raymond.mao@riscstar.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UZ6PGTORHYFXOUHVJPKCRZ3S65T2IX6U/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

T24gNi8yNC8yNiAxNjoyMywgRGF2ZSBQYXRlbCB3cm90ZToNCj4gT24gNi8yNC8yNiAwOTowMywg
SmVucyBXaWtsYW5kZXIgd3JvdGU6DQo+PiBIaSBEYXZlLA0KPj4NCj4+IE9uIFR1ZSwgSnVuIDIz
LCAyMDI2IGF0IDg6MTnigK9BTSA8ZGF2ZS5wYXRlbEByaXNjc3Rhci5jb20+IHdyb3RlOg0KPj4+
DQo+Pj4gRnJvbTogRGF2ZSBQYXRlbCA8ZGF2ZS5wYXRlbEByaXNjc3Rhci5jb20+DQo+Pj4NCj4+
PiBEZWFyIE9QLVRFRSBEZXZlbG9wZXJzLA0KPj4+DQo+Pj4gVGhpcyBwcm9wb3NhbCBpbnRyb2R1
Y2VzIGFyY2hpdGVjdHVyYWwgcnVudGltZSBjb250ZXh0IG1hbmFnZW1lbnQgc3RydWN0dXJlcyBh
bmQNCj4+PiB0cmFja2luZyBtZWNoYW5pc21zIGZvciBzdGFuZGFyZCBzY2FsYXIgRmxvYXRpbmct
UG9pbnQgKEYvRCkgYW5kIFZlY3RvciAoVikgSVNBDQo+Pj4gZXh0ZW5zaW9ucyBvbiBSSVNDLVYg
cGxhdGZvcm1zLg0KPj4+DQo+Pj4gIyMjIDEuIEFyY2hpdGVjdHVyYWwgQWxpZ25tZW50IGFuZCBT
aGlmdA0KPj4+DQo+Pj4gQ3VycmVudGx5LCB0aGUgdGhyZWFkIHNjaGVkdWxpbmcgbGF5ZXIgaW4g
T1AtVEVFIE9TIGltcGxlbWVudHMgYSB0aWdodGx5IGNvdXBsZWQNCj4+PiBWRlAgbW9kZWwgc3Bl
Y2lmaWMgdG8gdGhlIEFSTSBhcmNoaXRlY3R1cmUgKGUuZy4sIHRocmVhZF9rZXJuZWxfZW5hYmxl
X3ZmcCkuIFRoaXMNCj4+PiBtb2RlbCByZWxpZXMgaGVhdmlseSBvbiBhIHNvZnR3YXJlIGRyaXZl
biAibGF6eSBjb250ZXh0IHRyYXAiIG1lY2hhbmlzbSwgd2hlcmUNCj4+PiB0aGUga2VybmVsIGRp
c2FibGVzIHRoZSBGUFUgdG8gY2F0Y2ggc3Vic2VxdWVudCBleGVjdXRpb24gZmF1bHRzLg0KPj4+
DQo+Pj4gT24gUklTQy1WIGFyY2hpdGVjdHVyZXMsIGNvbnRleHQgdHJhY2tpbmcgY2Fubm90IHJl
bHkgb24gc29mdHdhcmUgaW5pdGlhdGVkIGxhenkNCj4+PiB0cmFwcyB2aWEgZXhlY3V0aW9uIGZh
dWx0cyBkdWUgdG8gc3RydWN0dXJhbCBvcGNvZGUgb3ZlcmxhcCBhY3Jvc3MgY3VzdG9tIGV4dGVu
c2lvbnMNCj4+PiBhbmQgdGhlIHNldmVyZSBwaXBlbGluZSBleGVjdXRpb24gcGVuYWx0aWVzIG9m
IHRyYXBzLiBJbnN0ZWFkLCBSSVNDLVYgcHJvdmlkZXMNCj4+PiBuYXRpdmUgaGFyZHdhcmUgc3Rh
dHVzIHN0YXRlIG1hY2hpbmVzIG1hbmFnZWQgdmlhIHRoZSBgc3N0YXR1cy5GU2AgKEZsb2F0aW5n
LVBvaW50KQ0KPj4+IGFuZCBgc3N0YXR1cy5WU2AgKFZlY3RvcikgYml0ZmllbGRzLg0KPj4+DQo+
Pj4gVG8gbWFwIHNlYW1sZXNzbHkgaW50byBPUC1URUUncyBleGlzdGluZyBgdGhyZWFkXypfdmZw
YCB0aHJlYWQgc2NoZWR1bGluZywgd2UNCj4+PiB1dGlsaXplIHRoZXNlIGhhcmR3YXJlIGZsYWdz
IHRvIGltcGxlbWVudCAiZWFnZXItb24tZGlydHkiIGNvbnRleHQgc2F2aW5nLiBUaGUNCj4+PiBr
ZXJuZWwgbGVhdmVzIGV4dGVuc2lvbnMgZW5hYmxlZCBkdXJpbmcgYWN0aXZlIGV4ZWN1dGlvbiBh
bmQgb25seSB3cml0ZSBhdCBjb250ZXh0DQo+Pj4gc3dpdGNoIGlmIHRoZSBoYXJkd2FyZSByZXBv
cnRzIGEgYERpcnR5YCBzdGF0dXMuDQo+Pj4NCj4+PiAjIyMgMi4gSW1wbGVtZW50YXRpb24gU3Vi
c3lzdGVtIEFyY2hpdGVjdHVyZQ0KPj4+DQo+Pj4gVG8gbWFpbnRhaW4gbW9kdWxhciBkZXNpZ24g
dGhlIGltcGxlbWVudGF0aW9uIGV4cGxpY2l0bHkgZGl2aWRlcyBzY2FsYXIgcHJvY2Vzc2luZw0K
Pj4+IGZyb20gc2NhbGFibGUgdmVjdG9yIGNvbmZpZ3VyYXRpb25zOg0KPj4+DQo+Pj4gMS4gTW9k
dWxhcml0eSAmIEhlYWRlcnM6DQo+Pj4gICAgLSA8a2VybmVsL3Jpc2N2X2ZwLmg+IHNwZWNpZmll
cyBiaXRtYXNrcyBhbmQgc3RydWN0dXJlcyAoYHN0cnVjdCByaXNjdl9mcF9zdGF0ZWApDQo+Pj4g
ICAgICBmb3Igc2NhbGFyIGV4ZWN1dGlvbi4NCj4+PiAgICAtIDxrZXJuZWwvcmlzY3ZfdmVjdG9y
Lmg+IGVuY2Fwc3VsYXRlcyBzY2FsYWJsZSB2ZWN0b3IgcGFyYW1ldGVyIHN0YXRlIGxheW91dHMN
Cj4+PiAgICAgIChgc3RydWN0IHJpc2N2X3ZlY3Rvcl9zdGF0ZWApLiBUaGlzIGFsbG93cyBkZXZp
Y2VzIG1pc3NpbmcgYSB2ZWN0b3IgdW5pdCB0byBjb21wbGV0ZWx5DQo+Pj4gICAgICBvbWl0IHZl
Y3RvciBmb290cHJpbnRzIG9yIGRlcGVuZGVuY3kuDQo+Pj4NCj4+PiAyLiBCaXR3aWR0aCBhbmQg
TGF5b3V0IEFkYXB0YWJpbGl0eToNCj4+PiAgICAtIFNjYWxhciBMb3ctTGV2ZWwgQXNzZW1ibHkg
KGBmcF9hc20uU2ApOiBOYXRpdmVseSBhZGFwdHMgdG8gYm90aCAzMi1iaXQgKGBydjMyYCkNCj4+
PiAgICAgIGFuZCA2NC1iaXQgKGBydjY0YCkgd2lkdGggY29uZmlndXJhdGlvbnMgdmlhIGNvbXBp
bGVyIGBfX3Jpc2N2X3hsZW5gIHByZXByb2Nlc3NpbmcgZGlyZWN0aXZlcy4NCj4+PiAgICAtIFZl
Y3RvciBFeHRlbnNpb24gT3B0aW1pemF0aW9uIChgcmlzY3ZfdmVjdG9yLmNgKTogRnVsbHkgaXNv
bGF0ZWQgZnJvbSBwcmltYXJ5IHRocmVhZCBmaWxlcy4NCj4+PiAgICAgIEluc3RlYWQgb2Ygc3Rv
cmluZyB2ZWN0b3IgcmVnaXN0ZXJzIHNlcXVlbnRpYWxseSwgaXQgYWRvcHRzIHdob2xlLXJlZ2lz
dGVyIGJsb2NrDQo+Pj4gICAgICB0cmFuc2ZlciBpbnN0cnVjdGlvbnMgKGB2czhyLnZgIGFuZCBg
dmw4ci52YCkuIEdyb3VwaW5nIGVsZW1lbnRzIGludG8gYmxvY2tzIG9mDQo+Pj4gICAgICBlaWdo
dCBjb21wcmVzc2VzIHRoZSBzYXZlL3Jlc3RvcmUgcGlwZWxpbmUgaW50byBmb3VyIGNvcmUgb3Bl
cmF0aW9uYWwgY2h1bmtzDQo+Pj4gICAgICAoYHYwYCwgYHY4YCwgYHYxNmAsIGB2MjRgKS4NCj4+
Pg0KPj4+IDMuIFVuaWZpZWQgU2NoZWR1bGluZyBBYnN0cmFjdGlvbiAoYHRocmVhZF92ZnAuY2Ap
Og0KPj4+ICAgIFVuaWZpZWQgdG9wLWxldmVsIGltcGxlbWVudGF0aW9uIChgdGhyZWFkX2tlcm5l
bF9zYXZlX3ZmcGAsIGB0aHJlYWRfdXNlcl9lbmFibGVfdmZwYCwNCj4+PiAgICBldGMuKSBhcmUg
dXNlZCBmb3IgY29udGV4dCByb3V0aW5nLg0KPj4+DQo+Pj4NCj4+PiAjIyMgMy4gRmVlZGJhY2sg
UmVxdWVzdGVkDQo+Pj4NCj4+PiBXZSBhcmUgc2Vla2luZyBlYXJseSBkZXNpZ24gZmVlZGJhY2sg
ZnJvbSB0aGUgY29tbXVuaXR5IHJlZ2FyZGluZzoNCj4+PiAtIFN0cnVjdHVyYWwgQ29udmVudGlv
bjogU2hvdWxkIHdlIGtlZXAgdGhlIHVuaXZlcnNhbCAidmZwIiBuYW1pbmcgc2NoZW1lIHdpdGhp
biB0aGUgZ2xvYmFsDQo+Pj4gICBgdGhyZWFkLmhgIGhlYWRlciBpbnRlcmZhY2VzIGZvciBzdHJ1
Y3R1cmFsIGJhY2t3YXJkIGNvbXBhdGliaWxpdHksIG9yIGlzIGFuIGV4cGxpY2l0IHVwc3RyZWFt
DQo+Pj4gICByZWZhY3RvcmluZyB0b3dhcmQgYSBnZW5lcmljIG5hbWUgKGUuZy4sIGB0aHJlYWRf
a2VybmVsX2VuYWJsZV9jb3Byb2NfcmVnc2ApIHByZWZlcnJlZD8NCj4+PiAtIFZlY3RvciBCb3Vu
ZHMgTWVtb3J5IEFsbG9jYXRpb246IFdoYXQgaXMgdGhlIHByZWZlcnJlZCBhcHByb2FjaCBmb3Ig
c2FmZWx5IG1hbmFnaW5nIHRoZSBkeW5hbWljDQo+Pj4gICBoZWFwIGZvb3RwcmludCBmb3IgdmVj
dG9yIHJlZ2lzdGVyIHN0YXRlcyAoYHZyZWdzYCkgd2hpY2ggc2NhbGUgYmFzZWQgb24gcnVudGlt
ZSBDUFUgYFZMRU5CYCBib3VuZHM/DQo+Pj4gLSBFYWdlciBDb250ZXh0IHN3aXRjaGluZyBoYXMg
YmVlbiBwcm9wb3NlZCwgaGVuY2UgYXJlIHRoZXJlIGFueSByZXNlcnZhdGlvbnMgb24NCj4+PiB0
aGlzID8NCj4+Pg0KPj4+DQo+Pj4gTG9va2luZyBmb3J3YXJkIHRvIHlvdXIgc3VnZ2VzdGlvbnMg
YW5kIGRlc2lnbiBjcml0aXF1ZXMuDQo+Pj4NCj4+PiBEYXZlIFBhdGVsICgzKToNCj4+PiAgIEZs
b2F0aW5nIFBvaW50IGNoYW5nZXMNCj4+PiAgIFJJU0NWIFZlY3RvciBjaGFuZ2VzDQo+Pj4gICBU
aHJlYWQgY2hhbmdlcyBmb3IgUklTQ1YgZmxvYXRpbmcgcG9pbnQgYW5kIHZlY3RvciBjaGFuZ2Vz
DQo+Pj4NCj4+PiAgY29yZS9hcmNoL3Jpc2N2L2luY2x1ZGUvcmlzY3ZfZnAuaCAgICAgfCAgMzAg
KysrKysNCj4+PiAgY29yZS9hcmNoL3Jpc2N2L2luY2x1ZGUvcmlzY3ZfdmVjdG9yLmggfCAgMzIg
KysrKysNCj4+PiAgY29yZS9hcmNoL3Jpc2N2L2tlcm5lbC9yaXNjdl9mcC5TICAgICAgfCAxNTkg
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+ICBjb3JlL2FyY2gvcmlzY3Yva2VybmVsL3Jp
c2N2X3ZlY3Rvci5jICB8ICA3NyArKysrKysrKysrKysNCj4+PiAgY29yZS9hcmNoL3Jpc2N2L2tl
cm5lbC90aHJlYWRfdmZwLmMgICAgfCAxNDIgKysrKysrKysrKysrKysrKysrKysrKw0KPj4+ICA1
IGZpbGVzIGNoYW5nZWQsIDQ0MCBpbnNlcnRpb25zKCspDQo+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBjb3JlL2FyY2gvcmlzY3YvaW5jbHVkZS9yaXNjdl9mcC5oDQo+Pj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBjb3JlL2FyY2gvcmlzY3YvaW5jbHVkZS9yaXNjdl92ZWN0b3IuaA0KPj4+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgY29yZS9hcmNoL3Jpc2N2L2tlcm5lbC9yaXNjdl9mcC5TDQo+Pj4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBjb3JlL2FyY2gvcmlzY3Yva2VybmVsL3Jpc2N2X3ZlY3Rvci5jDQo+Pj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBjb3JlL2FyY2gvcmlzY3Yva2VybmVsL3RocmVhZF92ZnAuYw0K
Pj4+DQo+Pj4gLS0NCj4+PiAyLjQzLjANCj4+Pg0KPj4NCj4+IFBsZWFzZSBjcmVhdGUgYSBQUiBh
dCBHaXRIdWIgd2l0aCB0aGVzZSBwYXRjaGVzIGluc3RlYWQuIFRoYXQncyB0aGUNCj4+IHByZWZl
cnJlZCB3YXkgb2YgcmV2aWV3aW5nIHBhdGNoZXMgZm9yIHRoZSBPUC1URUUgcmVwb3NpdG9yaWVz
Lg0KPj4NCj4+IENoZWVycywNCj4+IEplbnMNCj4gDQo+IEhlbGxvIEplbnMsDQo+ICAgICAgICAg
ICAgVGhhbmtzIGZvciB5b3VyIHJlc3BvbnNlLg0KPiBUaGUgZW1haWwgY2hhaW4gd2FzIGZvciBS
RkMgYW5kIG5vdCBhIGZvcm1hbCByZXZpZXcgcGF0Y2gsIG9uY2UgdGhlDQo+IHByb3Bvc2VkIFJG
QyBoYXMgYW4gYWdyZWVtZW50LCBJIHNoYWxsIHByb3ZpZGUgYSBwYXRjaCBmb3IgZm9ybWFsIHJl
dmlldy4NCj4gDQo+IFRoYW5rcw0KPiBEYXZlDQoNCkhpIEplbnMsDQogICAgICAgIEFzIHJlcXVl
c3RlZCBJIGhhdmUgY3JlYXRlZCBhIFBSIGF0IEdpdEh1Yg0KaHR0cHM6Ly9naXRodWIuY29tL09Q
LVRFRS9vcHRlZV9vcy9wdWxsLzc4NjENCg0KVGhpcyBpcyBqdXN0IGEgUkZDLCBzbyBwbGVhc2Ug
bGV0IG1lIGtub3cuDQoNClRoYW5rcw0KRGF2ZQ0KDQo=
