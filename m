Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5B7D5B16E
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:26:03 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 89D784FE93
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:26:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Cs/GHkgK;
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7B2864FEE2
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 14:17:56 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so5948397a12.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 06:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808275; x=1766413075; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tz/rLe0gEEPSg+6BoTZK8cqpnlYbSYNZB83UFAX5Ufw=;
        b=Cs/GHkgKlhs6SINTX8MGUdjRkBjQg7A+a/cEDGwP3NcEtBVy+P6q0txlD6nhaULC3/
         H30PEil62AFKaCnVM2WCLzMGO/jAJ0wYnID+mOrIAs6Lylx6Vk33ewkfBX3tMUxhbAhM
         S7M4G6e3hYRLToQXBnOZUKTPYrXAj7JgSwaqWgOvnu3eNoumiNRXCaapgcU3MR8koica
         mg9J/RU0WE3Ztxcu805XgnZbpSwynf+fNyQLaZXEBAhid9cBaavKyVM53DoHy1PYUPKh
         FCE/bNWXfY1nrgBtYWMdOy0HsgEdG+0ns+GEb/9duMIlwoHejiNAtZckrcjmUt7fD0p/
         qbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808275; x=1766413075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tz/rLe0gEEPSg+6BoTZK8cqpnlYbSYNZB83UFAX5Ufw=;
        b=jXpY4KjsXNXTzVPcMJBdn/ljO8zYOesxi7UDUJaIwr3jDs3lNZtLB8c3vNKcpAa7ol
         fGD7pbJWA1evahDZegu5Zt3EK7vqoGck878JziQ8er8C+jG1rLLzMuSoHJ4QGIbQjAAz
         eZvaZlVoSNeFreMkJn/WuT1qU819TtrL1VhSMvO2t6SPF1AtDVTRDAgB4+SdOTjtGzNS
         MTRfZtwVBh5pwLsuqbOPTs0Z6G4mZ9sHhH94t7NS/7EDzotGqHsKVKDWuEg1KGtdaBfN
         i7JasXYiBWxa2V+WFPA16R6ePvEYrASlYcFIuBvmjoPD07iBQVds1StIy/1GFjb9va8Y
         PxiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkHCxnbcCypHXE1xLcdwE8tSbA3wdmOETAwMNlakSTCRLbimx+6Wsx2R3ySWSPacrpCObyjGU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Ywt6fpdmJp0WYEt5KHKOHh8Lim1asIQcII/qXC0oCAeKW92m7hm
	cxlZVDfq4tN0dyYa6UFF2KyS6cyBtkuabRqsLcKxGRc3TlZRwMTj9yg2t8ShqMj/Jfk=
X-Gm-Gg: AY/fxX6pU2AYYcjSoYnEa/Edbl4okJqcCHEgak1s15ijpU5piLTMXL7YPKMi8UOTTSD
	XlDO/zzM6T8LM5p7ehe5qkCJLGo2xVZLnW/0dwciAesw+NW8Rx1h0CY5ZoLHtIPgmsT2I15Umsj
	wWCDfLsV0kN6sNzf+FVdjYc/AQ9//vxdUPfjKiQvUFYwiI1lYum+tQKjCyEpWK1rAGr8Bq0vS4L
	RvDOwkLJfPr3Bhe2FPX5YDMiXcdLJ2sZhm8bD4Ic11wF/IeTOal/sYAcek7zzWPE4bkOuLSaQFm
	PDAX1qbuJyx1R9bzXKkS9H0bN7Ymo+Wvjez080JDvu9DFQte6rA0eUXcsrQqhUaN3JrNJ1MBhcL
	XCbd/0WSnPtA+PPwSlHbWHXwmP0mNG3BfYzb5kiSS3RwJHm53RAu9/dQfJaULxBSM0qS6YXmGU8
	qefosqQlqXBoEH0ZRx3Y7s9Iih/I7dhavbkCChZpox5KDYHiXCIpdLj+fyzA==
X-Google-Smtp-Source: AGHT+IHXNUiy/5yBOT4dn7umwiox+CfDP3uCJtKbMP9NvLprVYwnlB88jSKq4lkDDOMP5RZKyuAxog==
X-Received: by 2002:a05:6402:4404:b0:647:a636:76c with SMTP id 4fb4d7f45d1cf-6499b1f8b4dmr9871722a12.31.1765808275438;
        Mon, 15 Dec 2025 06:17:55 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-64982227ba1sm13523693a12.33.2025.12.15.06.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:54 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH v2 12/17] firmware: tee_bnxt: Make use of module_tee_client_driver()
Date: Mon, 15 Dec 2025 15:16:42 +0100
Message-ID: <fc3ad2adcd795dc92106c35e9306c52f199e6fe3.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=KuzBomJ+2b6IkLEr6dylmkMduKhBvGwTMDuWUs1IqUQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhplUIGHxY+kNc+ZnO2NN941Q0i8QiNARXnc uHMb9q9vG+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYaQAKCRCPgPtYfRL+ Tpg5CAC2TR34NPIIYAuCMyG/P/V874WeW0I8DBjfDj1sHTP/b5eQM9txRkeuAySo9lTtzf81I2A YZ13WAyDX0adgP5RhgtEsjfa90Hk+YTfNuszrHVf/XL2FMVoNxFvv+x2DqypHVM6eguDjv2F39L b+/hoVh6XHoGrr0U9KvJ3Pm15CINftKatRbBgm85spaL315JL78QMLhLet2I1dzCLblTLOBPSNk 5vB00SoF4E/JkOme7zwKoKdBozHPHlFCH6koMJTjAsB0HswWjxs64c16CUl61+W/4tJQYUniXof 8E4qisqElJ8CG1CgS6EqyNLPpVvFhWBQL2mUY7EZtOKt9jrf
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.54:from];
	DMARC_NA(0.00)[baylibre.com];
	FREEMAIL_TO(0.00)[linaro.org,gmail.com,broadcom.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.54:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[46.5.122.62:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7B2864FEE2
X-Spamd-Bar: --
Message-ID-Hash: I7ZB3ZVMALNPCI42BY5HHUT5H73Z3CU5
X-Message-ID-Hash: I7ZB3ZVMALNPCI42BY5HHUT5H73Z3CU5
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, linux-mips@vger.kernel.org, netdev@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/I7ZB3ZVMALNPCI42BY5HHUT5H73Z3CU5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

UmVkdWNlIGJvaWxlcnBsYXRlIGJ5IHVzaW5nIHRoZSBuZXdseSBpbnRyb2R1Y2VkIG1vZHVsZV90
ZWVfY2xpZW50X2RyaXZlcigpLg0KVGhhdCB0YWtlcyBjYXJlIG9mIGFzc2lnbmluZyB0aGUgZHJp
dmVyJ3MgYnVzLCBzbyB0aGUgZXhwbGljaXQgYXNzaWduaW5nDQppbiB0aGlzIGRyaXZlciBjYW4g
YmUgZHJvcHBlZC4NCg0KUmV2aWV3ZWQtYnk6IFN1bWl0IEdhcmcgPHN1bWl0LmdhcmdAb3NzLnF1
YWxjb21tLmNvbT4NClNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1r
b2VuaWdAYmF5bGlicmUuY29tPg0KLS0tDQogZHJpdmVycy9maXJtd2FyZS9icm9hZGNvbS90ZWVf
Ym54dF9mdy5jIHwgMTQgKy0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9i
cm9hZGNvbS90ZWVfYm54dF9mdy5jIGIvZHJpdmVycy9maXJtd2FyZS9icm9hZGNvbS90ZWVfYm54
dF9mdy5jDQppbmRleCA0MGUzMTgzYTNkMTEuLmZiZGYxYWE5N2M4MiAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZmlybXdhcmUvYnJvYWRjb20vdGVlX2JueHRfZncuYw0KKysrIGIvZHJpdmVycy9maXJt
d2FyZS9icm9hZGNvbS90ZWVfYm54dF9mdy5jDQpAQCAtMjYxLDI1ICsyNjEsMTMgQEAgc3RhdGlj
IHN0cnVjdCB0ZWVfY2xpZW50X2RyaXZlciB0ZWVfYm54dF9md19kcml2ZXIgPSB7DQogCS5pZF90
YWJsZQk9IHRlZV9ibnh0X2Z3X2lkX3RhYmxlLA0KIAkuZHJpdmVyCQk9IHsNCiAJCS5uYW1lCQk9
IEtCVUlMRF9NT0ROQU1FLA0KLQkJLmJ1cwkJPSAmdGVlX2J1c190eXBlLA0KIAkJLnByb2JlCQk9
IHRlZV9ibnh0X2Z3X3Byb2JlLA0KIAkJLnJlbW92ZQkJPSB0ZWVfYm54dF9md19yZW1vdmUsDQog
CQkuc2h1dGRvd24JPSB0ZWVfYm54dF9md19zaHV0ZG93biwNCiAJfSwNCiB9Ow0KIA0KLXN0YXRp
YyBpbnQgX19pbml0IHRlZV9ibnh0X2Z3X21vZF9pbml0KHZvaWQpDQotew0KLQlyZXR1cm4gZHJp
dmVyX3JlZ2lzdGVyKCZ0ZWVfYm54dF9md19kcml2ZXIuZHJpdmVyKTsNCi19DQotDQotc3RhdGlj
IHZvaWQgX19leGl0IHRlZV9ibnh0X2Z3X21vZF9leGl0KHZvaWQpDQotew0KLQlkcml2ZXJfdW5y
ZWdpc3RlcigmdGVlX2JueHRfZndfZHJpdmVyLmRyaXZlcik7DQotfQ0KLQ0KLW1vZHVsZV9pbml0
KHRlZV9ibnh0X2Z3X21vZF9pbml0KTsNCi1tb2R1bGVfZXhpdCh0ZWVfYm54dF9md19tb2RfZXhp
dCk7DQorbW9kdWxlX3RlZV9jbGllbnRfZHJpdmVyKHRlZV9ibnh0X2Z3X2RyaXZlcik7DQogDQog
TU9EVUxFX0FVVEhPUigiVmlrYXMgR3VwdGEgPHZpa2FzLmd1cHRhQGJyb2FkY29tLmNvbT4iKTsN
CiBNT0RVTEVfREVTQ1JJUFRJT04oIkJyb2FkY29tIGJueHQgZmlybXdhcmUgbWFuYWdlciIpOw0K
LS0gDQoyLjQ3LjMNCg0K
