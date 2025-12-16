Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6EFD609A0
	for <op-tee@archiver.kernel.org>; Tue, 16 Dec 2025 14:54:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 351004FEE3
	for <op-tee@archiver.kernel.org>; Tue, 16 Dec 2025 14:54:42 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nAnu7ysg;
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 767254FEDF
	for <op-tee@lists.trustedfirmware.org>; Tue, 16 Dec 2025 14:54:25 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so35978925e9.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 16 Dec 2025 06:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765896864; x=1766501664; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=083eJ1odQemhQ29TeIEP+fOEpTzIo0LkfQYMHvDxxKA=;
        b=nAnu7ysgYDNauc4BzM8ekliusKhQ9jgoDoRN4lqMKpTLwbWy/jT/F19b49YqDwuS50
         WhpAO39WR6MTHAUBQKTKFsQR8R1rLSJ3cUiWMrJLbd1HSf6bqLSNPfAaM6Cv3Yuyws0E
         /9tAtpE8Tj1PiCOyTZV2ZqVjqREvnNWueEWvqLdSLq6/yzI1SaZlGHaDyULYFnq+vNUO
         h0lX+7642bMqCz+00H99+Ee40O5Dwpqoz8MVc6FuV50iP/GaX9RH9IvircGbut+9VF79
         LcnsXDPm9KiZHjU+fj7t9ySqH5U6lz3OUrdMHSgZFnNDYdL3TC/xkcHKU3N7Y2qzeL4B
         WTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765896864; x=1766501664;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=083eJ1odQemhQ29TeIEP+fOEpTzIo0LkfQYMHvDxxKA=;
        b=FiAmg4wGYIXJPCHmGzhJQhdgdH4QlBUN4r/D/frI+6Ik3A9sjDkBy4qnS4A/kag99A
         VudrYcvaYnMJbiy5qx6dYKejzcols41Qk0IYDfU82b40B3GJNlh17VCoqjLzROyaH1tk
         dGnvHk5UAAsRcPNX3xoqUXkB4SE7PGdt8qA8siFe0Ire2HW4jE9bdUtne8gspOmWP2Y5
         qLcTd/Gp8N9HSH4kW/LNiP1UHJZ6daldgzXvgD5yZpm2hUbiKMGcBHfCgq5+Ma+0ISl2
         FwvKz3dsdmhA5W1ZHTRBsJSCh0JUso9I5dU9FQf/9lRiuvhftXrWxXZqSmVGl94YEixB
         vEJw==
X-Forwarded-Encrypted: i=1; AJvYcCWIAc1IcORJMsjDeKmcGGV85lBa+fN75LBnQg0QZBmo5Y5FjBYBldkCIsH56laY2qrre+Q01HU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yyqj5zoJL7SMPuKKDLrxlvhCFh1h8Og6gnsSzsm17PrjxXmwuWv
	ELt3wGc/7sq+KVBvWLU7oRLo/7bH9A6lxkyHssB7sguJF0YGWCPZt0LXYVU3ze0wKI6+cQ==
X-Gm-Gg: AY/fxX4FLoDuoM52gi26AKopd/LG+yJCgLpuec10mBJ1ttBqlUFXQVroFEMzDqxsKAH
	VaQamIFL9rg6bZ2ndMx6az+/DRcm2rma/TnyPZuQJLwzrjUdBDoC0yjz/GN/slkicdBJDse5oAC
	jC4rk8wqLwqsunrfmtH2Z/r438Cohj+zdq2Frahbf0QnTKM4HDVB/XvJYdAN4bnB4okBtn/+Wbi
	oY76T+GJibf27t4EO+qpZeeT2Q2JLm/e0Js7XbFO4GXo2dA1NrNuLH8LQ9I/6Lp6ldhPUgip2ck
	HPwGcWWjbXhAvWx0/DjiMA097dFRaPsMFKCkPeHminslmQ0XldOU3fLZKyWiTjhpWIF34YxObN3
	1lRnlr3JbRXOpRk4D0Nd+NSdCGB8bGEqEdfM7G0Il23jFPrOYcaxzpXbVPvqJnvwUCTG8ckmV6I
	fonyELo6VPRGfjfvMS
X-Google-Smtp-Source: AGHT+IGpLSwim1pE/P8INB8GaZ4+p0IZFRfyX4iOIwOp/CHXTNFQFXGZiSSviqhN1XuTIjxJ7LXHug==
X-Received: by 2002:a05:600c:699a:b0:479:2651:3f9c with SMTP id 5b1f17b1804b1-47bda6e58d4mr12243695e9.14.1765896864224;
        Tue, 16 Dec 2025 06:54:24 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f3240fasm252658655e9.0.2025.12.16.06.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 06:54:23 -0800 (PST)
Date: Tue, 16 Dec 2025 17:54:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: build breakage with SCMI
Message-ID: <aUFynAjN13O_ai_P@stanley.mountain>
References: <aUBbXjP7B0jDVkeN@stanley.mountain>
 <f76a7766-08b9-4bc9-9d04-0ed61087ccc0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <f76a7766-08b9-4bc9-9d04-0ed61087ccc0@linaro.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	URI_HIDDEN_PATH(1.00)[https://github.com/OP-TEE/optee_os/blob/master/.github/workflows/ci.yml#L226];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.47:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[196.207.164.177:received];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.47:from];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 767254FEDF
X-Spamd-Bar: --
Message-ID-Hash: YW7GKUBKUBGHGRRXHH57YOZ6G4ZN5WU5
X-Message-ID-Hash: YW7GKUBKUBGHGRRXHH57YOZ6G4ZN5WU5
X-MailFrom: dan.carpenter@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Valentin Caron <valentin.caron@foss.st.com>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YW7GKUBKUBGHGRRXHH57YOZ6G4ZN5WU5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

T24gVHVlLCBEZWMgMTYsIDIwMjUgYXQgMTE6NTM6MTNBTSArMDEwMCwgSmVyb21lIEZvcmlzc2ll
ciB3cm90ZToNCj4gSGkgRGFuLA0KPiANCj4gT24gMTIvMTUvMjUgMjA6MDIsIERhbiBDYXJwZW50
ZXIgd3JvdGU6DQo+ID4gV2hlbiBJIHRyeSBidWlsZGluZyB3aXRoIGBtYWtlIHJ1biBXSVRIX1ND
TUk9eWAgdGhlbiB0aGUgYnVpbGQgZmFpbHM6DQo+ID4gDQo+ID4gY29yZS9saWIvc2NtaS1zZXJ2
ZXIvc2NtaV9zZXJ2ZXIuYzogSW4gZnVuY3Rpb24g4oCYc2NtaV9zZXJ2ZXJfaW5pdGlhbGl6ZeKA
mToNCj4gPiBjb3JlL2xpYi9zY21pLXNlcnZlci9zY21pX3NlcnZlci5jOjgzOjIyOiBlcnJvcjog
aW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYc2NtaV9jb25maWd1cmXigJkgWy1X
aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dDQo+ID4gICAgODMgfCAgICAgICAgICAgICAg
ICAgcmMgPSBzY21pX2NvbmZpZ3VyZShjZmcpOw0KPiA+ICAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICAgXn5+fn5+fn5+fn5+fn4NCj4gPiANCj4gPiBUaGlzIHdhcyBpbnRyb2R1Y2VkIGluIGNv
bW1pdCBjZTZlYTQxMTIwMDggKCJzY21pLXNlcnZlcjogY29uZmlndXJlDQo+ID4gU0NQLWZpcm13
YXJlIGZyb20gRFQiKS4gIEEgZ3JlcCBmb3Igc2NtaV9jb25maWd1cmUoKSB0dXJucyB1cCBlbXB0
eS4NCj4gPiBXYXMgcGFydCBvZiB0aGUgY29tbWl0IG1pc3Npbmc/DQo+IA0KPiBJIHN1c3BlY3Qg
eW91ciBTQ1AtZmlybXdhcmUgc291cmNlIHRyZWUgaXMgdG9vIG9sZC4gUGxlYXNlIHNlZToNCj4g
aHR0cHM6Ly9naXRodWIuY29tL09QLVRFRS9vcHRlZV9vcy9ibG9iL21hc3Rlci8uZ2l0aHViL3dv
cmtmbG93cy9jaS55bWwjTDIyNg0KPiANCg0KSHVoLiAgVGhhbmtzLiAgVGhhdCBmaXhlcyB0aGUg
YnVpbGQuICBJIGhhZCB1c2VkIHRoaXMgY29tbWFuZDoNCg0KcmVwbyBpbml0IC11IGh0dHBzOi8v
Z2l0aHViLmNvbS9PUC1URUUvbWFuaWZlc3QuZ2l0IC1tIHFlbXVfdjgueG1sDQoNCmh0dHBzOi8v
Z2l0aHViLmNvbS9PUC1URUUvbWFuaWZlc3QvYmxvYi9tYXN0ZXIvcWVtdV92OC54bWwNCg0KVGhh
dCBtYW5pZmVzdCBmaWxlIGNoZWNrcyBvdXQgcmV2aXNpb249InJlZnMvdGFncy92Mi4xNi4wIiB3
aGljaCBkb2Vzbid0DQpidWlsZC4gIEFjdHVhbGx5LCBhbGwgdGhlIG1hbmlmZXN0IGZpbGVzIHdo
aWNoIHJlZmVyZW5jZSBTQ1AgYXJlIHRvbyBvbGQ6DQoNCnFlbXVfdjgueG1sOiAgICAgICAgPHBy
b2plY3QgcGF0aD0iU0NQLWZpcm13YXJlIiAgICAgICAgIG5hbWU9ImxpbmFyby1zd2cvU0NQLWZp
cm13YXJlLmdpdCIgICAgICAgICAgICAgcmV2aXNpb249InJlZnMvdGFncy92Mi4xNi4wIiBjbG9u
ZS1kZXB0aD0iMSIgLz4NCnN0bTMybXAxLnhtbDogICAgICAgIDxwcm9qZWN0IHBhdGg9InNjcC1m
aXJtd2FyZSIgICAgICAgICBuYW1lPSJmaXJtd2FyZS9TQ1AtZmlybXdhcmUuZ2l0IiByZXZpc2lv
bj0icmVmcy90YWdzL3YyLjE1LjAiIHJlbW90ZT0iYXJtLWdpdGxhYiIgY2xvbmUtZGVwdGg9IjEi
IC8+DQpzeW5xdWFjZXIueG1sOiAgICAgICAgPHByb2plY3QgcGF0aD0iU0NQLWZpcm13YXJlIiAg
ICAgICAgIG5hbWU9IkFSTS1zb2Z0d2FyZS9TQ1AtZmlybXdhcmUuZ2l0IiAgICAgICAgIHJldmlz
aW9uPSI1NmQ0ZjUxNWJjZjFiYzFiODQzYWJlMzQzZTljZjlkYzQ0ODk4Y2EyIiAvPg0KDQpyZWdh
cmRzLA0KZGFuIGNhcnBlbnRlcg0KDQo=
