Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBF0CDE001
	for <op-tee@archiver.kernel.org>; Wed, 24 Jun 2026 15:23:55 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D41C344F0B
	for <op-tee@archiver.kernel.org>; Wed, 24 Jun 2026 15:23:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=tzqEor1d;
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 91A6F43825
	for <op-tee@lists.trustedfirmware.org>; Wed, 24 Jun 2026 15:23:47 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-697ebe536b6so2065783a12.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 24 Jun 2026 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782314626; x=1782919426; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o65Gi1B2z1oHh6yCPrtIa/SPSeB2QGXC6qgDajJ5awQ=;
        b=tzqEor1dnZnwR1CRPjIYtChEPzXNgsMEYY1JxwjCk4oz8UCKj9yv/Dd0EtBEtTKWGl
         IC+SsPcnl/uLi9GkwQzcePh1dFLa9m4NgwrEasklyfans8FqPV4EG6ByZqyMa39cGjAw
         2SHrhIROM8KN2RXNPR6tttla16WT13Hwqb+89Fnr2LJwiZIUC6+Jw9znt6pQIY5L4sPB
         KLjcW7bjLOFjRp2uhtrXOkE23Sn9ihyvGyWYFUlolBMd75nbgpSC+HaKeaIGkCzDnIC6
         3pRDSW8eWXO+YcQHCWwSEzQ7mjbC7pvIBoiKjX7Vnp6LdeX25hZN3XVxXOA9HUbAh2aj
         xV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782314626; x=1782919426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o65Gi1B2z1oHh6yCPrtIa/SPSeB2QGXC6qgDajJ5awQ=;
        b=gMe9yuO1nOAAKqb/oiCiKJCMAzLD2TzcJ0s3leMfwOWVpg9aAzXU8ZXgMwvulOsgdp
         5LiIBffTtbgH4nn1u+EYdkC35MjdzmaK2eeivMJ4/+/kQD/RZ2xczb9YuKjvSEKD2DGF
         JvWSxAzz8ZbrUeBO7/eAPgPQJ4ZOXQJxLlxqkq7iGbqxkzzN5BoAPGsZVDjd7wB1bHTt
         gnyNqXS3tSUNi/XOqXxx84PF0Ej8JG4rP4SUDBNt32h0sqeYPxCtlGQ0denSwTkty7Lq
         QFAP+mvjU0RxJSzE2vlKqyvzMFzS6KDysyzExa7o9ZFlg8vAWfPbCgDx6YMkHoo7D683
         53Vg==
X-Gm-Message-State: AOJu0Ywp8xIljmQofTfE/ltxlyhJHx+AtYG6Y3QxTr5b+LzjNwsa75bg
	ZO7Km3sywEfqTv0dq1vZNDvyqywofup4GoIxN/Q5Y5UTwwfXrdgHBYJeq9RTiZlN2qM=
X-Gm-Gg: AfdE7ckqEegxl/3CK7/djmfavoDPYTehWrHB2s4I5wc3wZY+xqEMOPgrynVolpEW+mL
	5JebN5Z047kDm77htJLCsnngcFqFSPwWUzPggK6ss738KzEochis0PjaCgfbG8hQq9z7moX87+Q
	H/RExrkWqDbJi90EvCiF9skheWhOmZFgSvefKWIsExERJ5TDyS330UlR2DFDjm/rm+oCAtHt+BK
	skI//6hkrzfxXPkt48Cx5ZUNrZaX6XoKevCLd0NAxc8zKfgpQficaDmoAoMuruNvf4chbsaoEeD
	e/4GkxB+fw/iV1aYrUohOVDAXP2ExdPB07Gqh3JhjpJF65zj1ICld+yKCh4XufuDWxM3SNqprx1
	fwONnqCMR6S5KY5lUxJgIPajIXaLQ9dx10iuzKdXgKXSzbeFR3BEflThygL9hJYa23R/4hTuKL+
	3DhKsg4AKQxS5ImtXQHTbKmrTwJxMofWlDPpUbSltSluqfXcV8zZw=
X-Received: by 2002:a05:6402:430f:b0:697:be3b:cb06 with SMTP id 4fb4d7f45d1cf-697be3bcbdfmr6818559a12.18.1782314626240;
        Wed, 24 Jun 2026 08:23:46 -0700 (PDT)
Received: from [172.27.130.2] (97e782b0.skybroadband.com. [151.231.130.176])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6980afa5051sm36628a12.9.2026.06.24.08.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 08:23:45 -0700 (PDT)
Message-ID: <217e1d7a-a77c-415b-8018-3d80ccc82f7a@riscstar.com>
Date: Wed, 24 Jun 2026 16:23:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] core: riscv: Implement Floating-Point and Vector
 extension context tracking
To: Jens Wiklander <jens.wiklander@linaro.org>
References: <20260623061855.17863-1-dave.patel@riscstar.com>
 <CAHUa44EJivE8XwoVO9Tnd6-Jp_F0hyDgwzwO6Gv-TOvgUfo36w@mail.gmail.com>
Content-Language: en-US
From: Dave Patel <dave.patel@riscstar.com>
In-Reply-To: <CAHUa44EJivE8XwoVO9Tnd6-Jp_F0hyDgwzwO6Gv-TOvgUfo36w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.96 / 15.00];
	BAYES_HAM(-2.96)[99.84%];
	DMARC_POLICY_ALLOW(-0.50)[riscstar.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.41:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.41:from];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 91A6F43825
X-Spamd-Bar: ---
Message-ID-Hash: HFQPWFJ5HQ22N4P5GRYV7ZOIW46K3GZH
X-Message-ID-Hash: HFQPWFJ5HQ22N4P5GRYV7ZOIW46K3GZH
X-MailFrom: dave.patel@riscstar.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, Samuel Holland <samuel.holland@sifive.com>, Peter Lin <peter.lin@sifive.com>, Robin Randhawa <robin.randhawa@sifive.com>, Scott Bambrough <scott@riscstar.com>, Ray Mao <raymond.mao@riscstar.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HFQPWFJ5HQ22N4P5GRYV7ZOIW46K3GZH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

T24gNi8yNC8yNiAwOTowMywgSmVucyBXaWtsYW5kZXIgd3JvdGU6DQo+IEhpIERhdmUsDQo+IA0K
PiBPbiBUdWUsIEp1biAyMywgMjAyNiBhdCA4OjE54oCvQU0gPGRhdmUucGF0ZWxAcmlzY3N0YXIu
Y29tPiB3cm90ZToNCj4+DQo+PiBGcm9tOiBEYXZlIFBhdGVsIDxkYXZlLnBhdGVsQHJpc2NzdGFy
LmNvbT4NCj4+DQo+PiBEZWFyIE9QLVRFRSBEZXZlbG9wZXJzLA0KPj4NCj4+IFRoaXMgcHJvcG9z
YWwgaW50cm9kdWNlcyBhcmNoaXRlY3R1cmFsIHJ1bnRpbWUgY29udGV4dCBtYW5hZ2VtZW50IHN0
cnVjdHVyZXMgYW5kDQo+PiB0cmFja2luZyBtZWNoYW5pc21zIGZvciBzdGFuZGFyZCBzY2FsYXIg
RmxvYXRpbmctUG9pbnQgKEYvRCkgYW5kIFZlY3RvciAoVikgSVNBDQo+PiBleHRlbnNpb25zIG9u
IFJJU0MtViBwbGF0Zm9ybXMuDQo+Pg0KPj4gIyMjIDEuIEFyY2hpdGVjdHVyYWwgQWxpZ25tZW50
IGFuZCBTaGlmdA0KPj4NCj4+IEN1cnJlbnRseSwgdGhlIHRocmVhZCBzY2hlZHVsaW5nIGxheWVy
IGluIE9QLVRFRSBPUyBpbXBsZW1lbnRzIGEgdGlnaHRseSBjb3VwbGVkDQo+PiBWRlAgbW9kZWwg
c3BlY2lmaWMgdG8gdGhlIEFSTSBhcmNoaXRlY3R1cmUgKGUuZy4sIHRocmVhZF9rZXJuZWxfZW5h
YmxlX3ZmcCkuIFRoaXMNCj4+IG1vZGVsIHJlbGllcyBoZWF2aWx5IG9uIGEgc29mdHdhcmUgZHJp
dmVuICJsYXp5IGNvbnRleHQgdHJhcCIgbWVjaGFuaXNtLCB3aGVyZQ0KPj4gdGhlIGtlcm5lbCBk
aXNhYmxlcyB0aGUgRlBVIHRvIGNhdGNoIHN1YnNlcXVlbnQgZXhlY3V0aW9uIGZhdWx0cy4NCj4+
DQo+PiBPbiBSSVNDLVYgYXJjaGl0ZWN0dXJlcywgY29udGV4dCB0cmFja2luZyBjYW5ub3QgcmVs
eSBvbiBzb2Z0d2FyZSBpbml0aWF0ZWQgbGF6eQ0KPj4gdHJhcHMgdmlhIGV4ZWN1dGlvbiBmYXVs
dHMgZHVlIHRvIHN0cnVjdHVyYWwgb3Bjb2RlIG92ZXJsYXAgYWNyb3NzIGN1c3RvbSBleHRlbnNp
b25zDQo+PiBhbmQgdGhlIHNldmVyZSBwaXBlbGluZSBleGVjdXRpb24gcGVuYWx0aWVzIG9mIHRy
YXBzLiBJbnN0ZWFkLCBSSVNDLVYgcHJvdmlkZXMNCj4+IG5hdGl2ZSBoYXJkd2FyZSBzdGF0dXMg
c3RhdGUgbWFjaGluZXMgbWFuYWdlZCB2aWEgdGhlIGBzc3RhdHVzLkZTYCAoRmxvYXRpbmctUG9p
bnQpDQo+PiBhbmQgYHNzdGF0dXMuVlNgIChWZWN0b3IpIGJpdGZpZWxkcy4NCj4+DQo+PiBUbyBt
YXAgc2VhbWxlc3NseSBpbnRvIE9QLVRFRSdzIGV4aXN0aW5nIGB0aHJlYWRfKl92ZnBgIHRocmVh
ZCBzY2hlZHVsaW5nLCB3ZQ0KPj4gdXRpbGl6ZSB0aGVzZSBoYXJkd2FyZSBmbGFncyB0byBpbXBs
ZW1lbnQgImVhZ2VyLW9uLWRpcnR5IiBjb250ZXh0IHNhdmluZy4gVGhlDQo+PiBrZXJuZWwgbGVh
dmVzIGV4dGVuc2lvbnMgZW5hYmxlZCBkdXJpbmcgYWN0aXZlIGV4ZWN1dGlvbiBhbmQgb25seSB3
cml0ZSBhdCBjb250ZXh0DQo+PiBzd2l0Y2ggaWYgdGhlIGhhcmR3YXJlIHJlcG9ydHMgYSBgRGly
dHlgIHN0YXR1cy4NCj4+DQo+PiAjIyMgMi4gSW1wbGVtZW50YXRpb24gU3Vic3lzdGVtIEFyY2hp
dGVjdHVyZQ0KPj4NCj4+IFRvIG1haW50YWluIG1vZHVsYXIgZGVzaWduIHRoZSBpbXBsZW1lbnRh
dGlvbiBleHBsaWNpdGx5IGRpdmlkZXMgc2NhbGFyIHByb2Nlc3NpbmcNCj4+IGZyb20gc2NhbGFi
bGUgdmVjdG9yIGNvbmZpZ3VyYXRpb25zOg0KPj4NCj4+IDEuIE1vZHVsYXJpdHkgJiBIZWFkZXJz
Og0KPj4gICAgLSA8a2VybmVsL3Jpc2N2X2ZwLmg+IHNwZWNpZmllcyBiaXRtYXNrcyBhbmQgc3Ry
dWN0dXJlcyAoYHN0cnVjdCByaXNjdl9mcF9zdGF0ZWApDQo+PiAgICAgIGZvciBzY2FsYXIgZXhl
Y3V0aW9uLg0KPj4gICAgLSA8a2VybmVsL3Jpc2N2X3ZlY3Rvci5oPiBlbmNhcHN1bGF0ZXMgc2Nh
bGFibGUgdmVjdG9yIHBhcmFtZXRlciBzdGF0ZSBsYXlvdXRzDQo+PiAgICAgIChgc3RydWN0IHJp
c2N2X3ZlY3Rvcl9zdGF0ZWApLiBUaGlzIGFsbG93cyBkZXZpY2VzIG1pc3NpbmcgYSB2ZWN0b3Ig
dW5pdCB0byBjb21wbGV0ZWx5DQo+PiAgICAgIG9taXQgdmVjdG9yIGZvb3RwcmludHMgb3IgZGVw
ZW5kZW5jeS4NCj4+DQo+PiAyLiBCaXR3aWR0aCBhbmQgTGF5b3V0IEFkYXB0YWJpbGl0eToNCj4+
ICAgIC0gU2NhbGFyIExvdy1MZXZlbCBBc3NlbWJseSAoYGZwX2FzbS5TYCk6IE5hdGl2ZWx5IGFk
YXB0cyB0byBib3RoIDMyLWJpdCAoYHJ2MzJgKQ0KPj4gICAgICBhbmQgNjQtYml0IChgcnY2NGAp
IHdpZHRoIGNvbmZpZ3VyYXRpb25zIHZpYSBjb21waWxlciBgX19yaXNjdl94bGVuYCBwcmVwcm9j
ZXNzaW5nIGRpcmVjdGl2ZXMuDQo+PiAgICAtIFZlY3RvciBFeHRlbnNpb24gT3B0aW1pemF0aW9u
IChgcmlzY3ZfdmVjdG9yLmNgKTogRnVsbHkgaXNvbGF0ZWQgZnJvbSBwcmltYXJ5IHRocmVhZCBm
aWxlcy4NCj4+ICAgICAgSW5zdGVhZCBvZiBzdG9yaW5nIHZlY3RvciByZWdpc3RlcnMgc2VxdWVu
dGlhbGx5LCBpdCBhZG9wdHMgd2hvbGUtcmVnaXN0ZXIgYmxvY2sNCj4+ICAgICAgdHJhbnNmZXIg
aW5zdHJ1Y3Rpb25zIChgdnM4ci52YCBhbmQgYHZsOHIudmApLiBHcm91cGluZyBlbGVtZW50cyBp
bnRvIGJsb2NrcyBvZg0KPj4gICAgICBlaWdodCBjb21wcmVzc2VzIHRoZSBzYXZlL3Jlc3RvcmUg
cGlwZWxpbmUgaW50byBmb3VyIGNvcmUgb3BlcmF0aW9uYWwgY2h1bmtzDQo+PiAgICAgIChgdjBg
LCBgdjhgLCBgdjE2YCwgYHYyNGApLg0KPj4NCj4+IDMuIFVuaWZpZWQgU2NoZWR1bGluZyBBYnN0
cmFjdGlvbiAoYHRocmVhZF92ZnAuY2ApOg0KPj4gICAgVW5pZmllZCB0b3AtbGV2ZWwgaW1wbGVt
ZW50YXRpb24gKGB0aHJlYWRfa2VybmVsX3NhdmVfdmZwYCwgYHRocmVhZF91c2VyX2VuYWJsZV92
ZnBgLA0KPj4gICAgZXRjLikgYXJlIHVzZWQgZm9yIGNvbnRleHQgcm91dGluZy4NCj4+DQo+Pg0K
Pj4gIyMjIDMuIEZlZWRiYWNrIFJlcXVlc3RlZA0KPj4NCj4+IFdlIGFyZSBzZWVraW5nIGVhcmx5
IGRlc2lnbiBmZWVkYmFjayBmcm9tIHRoZSBjb21tdW5pdHkgcmVnYXJkaW5nOg0KPj4gLSBTdHJ1
Y3R1cmFsIENvbnZlbnRpb246IFNob3VsZCB3ZSBrZWVwIHRoZSB1bml2ZXJzYWwgInZmcCIgbmFt
aW5nIHNjaGVtZSB3aXRoaW4gdGhlIGdsb2JhbA0KPj4gICBgdGhyZWFkLmhgIGhlYWRlciBpbnRl
cmZhY2VzIGZvciBzdHJ1Y3R1cmFsIGJhY2t3YXJkIGNvbXBhdGliaWxpdHksIG9yIGlzIGFuIGV4
cGxpY2l0IHVwc3RyZWFtDQo+PiAgIHJlZmFjdG9yaW5nIHRvd2FyZCBhIGdlbmVyaWMgbmFtZSAo
ZS5nLiwgYHRocmVhZF9rZXJuZWxfZW5hYmxlX2NvcHJvY19yZWdzYCkgcHJlZmVycmVkPw0KPj4g
LSBWZWN0b3IgQm91bmRzIE1lbW9yeSBBbGxvY2F0aW9uOiBXaGF0IGlzIHRoZSBwcmVmZXJyZWQg
YXBwcm9hY2ggZm9yIHNhZmVseSBtYW5hZ2luZyB0aGUgZHluYW1pYw0KPj4gICBoZWFwIGZvb3Rw
cmludCBmb3IgdmVjdG9yIHJlZ2lzdGVyIHN0YXRlcyAoYHZyZWdzYCkgd2hpY2ggc2NhbGUgYmFz
ZWQgb24gcnVudGltZSBDUFUgYFZMRU5CYCBib3VuZHM/DQo+PiAtIEVhZ2VyIENvbnRleHQgc3dp
dGNoaW5nIGhhcyBiZWVuIHByb3Bvc2VkLCBoZW5jZSBhcmUgdGhlcmUgYW55IHJlc2VydmF0aW9u
cyBvbg0KPj4gdGhpcyA/DQo+Pg0KPj4NCj4+IExvb2tpbmcgZm9yd2FyZCB0byB5b3VyIHN1Z2dl
c3Rpb25zIGFuZCBkZXNpZ24gY3JpdGlxdWVzLg0KPj4NCj4+IERhdmUgUGF0ZWwgKDMpOg0KPj4g
ICBGbG9hdGluZyBQb2ludCBjaGFuZ2VzDQo+PiAgIFJJU0NWIFZlY3RvciBjaGFuZ2VzDQo+PiAg
IFRocmVhZCBjaGFuZ2VzIGZvciBSSVNDViBmbG9hdGluZyBwb2ludCBhbmQgdmVjdG9yIGNoYW5n
ZXMNCj4+DQo+PiAgY29yZS9hcmNoL3Jpc2N2L2luY2x1ZGUvcmlzY3ZfZnAuaCAgICAgfCAgMzAg
KysrKysNCj4+ICBjb3JlL2FyY2gvcmlzY3YvaW5jbHVkZS9yaXNjdl92ZWN0b3IuaCB8ICAzMiAr
KysrKw0KPj4gIGNvcmUvYXJjaC9yaXNjdi9rZXJuZWwvcmlzY3ZfZnAuUyAgICAgIHwgMTU5ICsr
KysrKysrKysrKysrKysrKysrKysrKysNCj4+ICBjb3JlL2FyY2gvcmlzY3Yva2VybmVsL3Jpc2N2
X3ZlY3Rvci5jICB8ICA3NyArKysrKysrKysrKysNCj4+ICBjb3JlL2FyY2gvcmlzY3Yva2VybmVs
L3RocmVhZF92ZnAuYyAgICB8IDE0MiArKysrKysrKysrKysrKysrKysrKysrDQo+PiAgNSBmaWxl
cyBjaGFuZ2VkLCA0NDAgaW5zZXJ0aW9ucygrKQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBjb3Jl
L2FyY2gvcmlzY3YvaW5jbHVkZS9yaXNjdl9mcC5oDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGNv
cmUvYXJjaC9yaXNjdi9pbmNsdWRlL3Jpc2N2X3ZlY3Rvci5oDQo+PiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGNvcmUvYXJjaC9yaXNjdi9rZXJuZWwvcmlzY3ZfZnAuUw0KPj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBjb3JlL2FyY2gvcmlzY3Yva2VybmVsL3Jpc2N2X3ZlY3Rvci5jDQo+PiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGNvcmUvYXJjaC9yaXNjdi9rZXJuZWwvdGhyZWFkX3ZmcC5jDQo+Pg0KPj4gLS0N
Cj4+IDIuNDMuMA0KPj4NCj4gDQo+IFBsZWFzZSBjcmVhdGUgYSBQUiBhdCBHaXRIdWIgd2l0aCB0
aGVzZSBwYXRjaGVzIGluc3RlYWQuIFRoYXQncyB0aGUNCj4gcHJlZmVycmVkIHdheSBvZiByZXZp
ZXdpbmcgcGF0Y2hlcyBmb3IgdGhlIE9QLVRFRSByZXBvc2l0b3JpZXMuDQo+IA0KPiBDaGVlcnMs
DQo+IEplbnMNCg0KSGVsbG8gSmVucywNCiAgICAgICAgICAgVGhhbmtzIGZvciB5b3VyIHJlc3Bv
bnNlLg0KVGhlIGVtYWlsIGNoYWluIHdhcyBmb3IgUkZDIGFuZCBub3QgYSBmb3JtYWwgcmV2aWV3
IHBhdGNoLCBvbmNlIHRoZQ0KcHJvcG9zZWQgUkZDIGhhcyBhbiBhZ3JlZW1lbnQsIEkgc2hhbGwg
cHJvdmlkZSBhIHBhdGNoIGZvciBmb3JtYWwgcmV2aWV3Lg0KDQpUaGFua3MNCkRhdmUNCg==
