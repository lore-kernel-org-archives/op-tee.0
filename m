Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B4FD5B16C
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:18:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2F3614FEDB
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 14:18:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=0KObfwZ3;
	dkim-atps=neutral
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 29C0845294
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 14:17:36 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b7cee045187so693305866b.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 06:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808255; x=1766413055; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ppOcPFqIwq9P7NGqZqTz1/tjn18c3F+fMKSBb9x2/Cg=;
        b=0KObfwZ3nCLUjkHRBqxKG12K+JpDbIVteU8ICoEVLrZ+N3vRNYS7LFmcTWV7aRiGyf
         vvh0NS02SxmvqlxJwKjtKjl7dl3JDRRniqr4oEiqo6fXWAYS7JRwbdRvA6BpUVNrCddx
         ysmrR9VdYNaSBav6YBsrTMB4KvSXspYQgLXTR+yanPyK88o5aaya32j+0b36dzGMmmce
         5d+DBUSGJFaU208nFmiFOuzIxbSyNicgX0N4gmz3aN5yVZpd0WY2fZBh/SegBLIQqn8L
         4fr9CQX4m+CzewBGC4FF+ka9Ax/6s+uKo63tDIrKOcFGSid0vTuiTmXOmS3ekiGp7tZo
         JQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808255; x=1766413055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppOcPFqIwq9P7NGqZqTz1/tjn18c3F+fMKSBb9x2/Cg=;
        b=R0SK5GM80qrkHymW2hPFtY1CXGGEIwDqDhCIfAgmqhapKgKoeMPovEYMEmPzfgvdJf
         UdKAYcvWOxwSbJ7tZpd89G7r9Gn5SKmURAwbgXREC6IKZMsQ1w7SL1tOiePoOg4K65OG
         v1YBKT02tvz6vwh0efK7U4ZHIb0hOkizY2GLZ/MV3KSyZCsVOvbpnSh8ACjLuT4+oq/X
         kvP7sbj3ShHjer0AzF0Hhaqd92HgM4MgBZClklqtHYI+usyoOsnjxDWiL9sNabNmm0TA
         mjxbehOmW4qSLMQvHAR8lBRbC5+TesPx0eG3lntJC7UvUzq4voZ9OYdMoFokg994nqhq
         kKbQ==
X-Gm-Message-State: AOJu0YyJFtAfvMn0qkRxDXgs9Jlja+aJrrZJPxMGKhZ032MoS3Waxzyr
	5YFaTEhlfTjDc7E72G9A5NZ8/tpTzIiCDPAoHuYMvSVoljRtimtsMrXj/gM2aMaV9k4=
X-Gm-Gg: AY/fxX4k6jP8usR/H2GttDwL6uNPKNcpUZgIhphcbVDFoeBjlB/jQsrj1MsDQdyfcqB
	ihWmYDeBGwIKMNE/vT1vLbXeqMtB3HwUUO5/hfiSOtO9Z53MsjFVQcjrj7r+/jrh9I1hcJ6WGpP
	rtfUKXyYmiLAIwMI7amaucEisuPnu/6sGbrKbpGeXsVomY8uzMoWqYlo0PvEOnIKTr8f8M2Hhl6
	vbp7H0PP9s9kR2Tha/4QLMWEry/JfzRukL8h0IKhldAG/ZEryt0YTbZo5s12Gw3zL/Pcb2BaK3K
	c+PGwDzGd3c+zl7eGnpMdO5ols5kDcIZRQHGKiqI7QzuZhG73447sEOR/E2+1fj2/BD8DjQzlpb
	EItPKC88OgS/I0671To6C5q3CgziRa5YjF77NAdl8J2GPkpnEow1mc/Kil61G3UmTGUdph4NL99
	pzpelsJGbyQ2OwiVgjniJZfeJ7Ti7kqJlDNjAxgPDS5HY3SMSO2k3h94zgiQ==
X-Google-Smtp-Source: AGHT+IF5kWl8asvVZ2gDn2/ukMC7FmJVzWuHgbBPUo4GSSTrWpKfiHxIiV3JEK3vNep6zj7EVQ2rxQ==
X-Received: by 2002:a17:907:a909:b0:b7c:cc8d:14ef with SMTP id a640c23a62f3a-b7d218d55fdmr1188092466b.32.1765808254923;
        Mon, 15 Dec 2025 06:17:34 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa56c152sm1380034166b.56.2025.12.15.06.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:34 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Garg <sumit.garg@kernel.org>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	=?utf-8?b?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH v2 00/17] tee: Use bus callbacks instead of driver callbacks
Date: Mon, 15 Dec 2025 15:16:30 +0100
Message-ID: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3083; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=KVuyHGeUtpLkpGJYZbfb5WtDJicjtg3giXBlS+vhN0U=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhBsL1Z+rYFoGFHUfEy6nbD85QotpwGnuS0G OxYNqNRFI2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYQQAKCRCPgPtYfRL+ TugUB/9E31O/wKyUkNJNEPUiyayhLen3mT/3afyja8AKlZtLRRSDYD85SklWs8WUYR25f620Tug HCQFCBGP6zvWFDFUJWDts8iS5V7u/2f3fzK4EwWEIO8RjWf//RCGbcOXzrjD+gHhyiO4ntF2NWr 3ospR0B/APcHFEMI3zfkmIaPNlyEhNrddsNRbaHKA+WTWhZm7A/yqOnVYIJ6MLuTrhjHLZZoL5u gBimMOyT/Dmu6TUF9ex7Rhk+vookCt9jpn+vbxsz0ArRtMIo0W8fVdouxPDFA9SMn/bCn6BBJ+B fl85F7WiQwNbfWoeC8/qrjWMCGDfxgyRZi39jRQ+nWgTC5V5
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.80 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.65:from];
	ARC_NA(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,lwn.net,kernel.org,selenic.com,gondor.apana.org.au,bootlin.com,gmail.com,foss.st.com,oss.qualcomm.com,siemens.com,baylibre.com,arm.com,wanadoo.fr,broadcom.com,HansenPartnership.com,linux.ibm.com,redhat.com,paul-moore.com,namei.org,hallyn.com,gmx.de];
	RCPT_COUNT_TWELVE(0.00)[43];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[46.5.122.62:received];
	ALIAS_RESOLVED(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.65:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 29C0845294
X-Spamd-Bar: /
Message-ID-Hash: F475B55P3UC5TYQOQJ6OJWZPGAS6PYBM
X-Message-ID-Hash: F475B55P3UC5TYQOQJ6OJWZPGAS6PYBM
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org, linux-mips@vger.kernel.org, netdev@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/F475B55P3UC5TYQOQJ6OJWZPGAS6PYBM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGVsbG8sDQoNCnRoZSBvYmplY3RpdmUgb2YgdGhpcyBzZXJpZXMgaXMgdG8gbWFrZSB0ZWUgZHJp
dmVyIHN0b3AgdXNpbmcgY2FsbGJhY2tzDQppbiBzdHJ1Y3QgZGV2aWNlX2RyaXZlci4gVGhlc2Ug
d2VyZSBzdXBlcnNlZGVkIGJ5IGJ1cyBtZXRob2RzIGluIDIwMDYNCihjb21taXQgNTk0YzgyODFm
OTA1ICgiW1BBVENIXSBBZGQgYnVzX3R5cGUgcHJvYmUsIHJlbW92ZSwgc2h1dGRvd24NCm1ldGhv
ZHMuIikpIGJ1dCBub2JvZHkgY2FyZWQgdG8gY29udmVydCBhbGwgc3Vic3lzdGVtcyBhY2NvcmRp
bmdseS4NCg0KSGVyZSB0aGUgdGVlIGRyaXZlcnMgYXJlIGNvbnZlcnRlZC4gVGhlIGZpcnN0IGNv
bW1pdCBpcyBzb21ld2hhdA0KdW5yZWxhdGVkLCBidXQgc2ltcGxpZmllcyB0aGUgY29udmVyc2lv
biAoYW5kIHRoZSBkcml2ZXJzKS4gSXQNCmludHJvZHVjZXMgZHJpdmVyIHJlZ2lzdHJhdGlvbiBo
ZWxwZXJzIHRoYXQgY2FyZSBhYm91dCBzZXR0aW5nIHRoZSBidXMNCmFuZCBvd25lci4gKFRoZSBs
YXR0ZXIgaXMgbWlzc2luZyBpbiBhbGwgZHJpdmVycywgc28gYnkgdXNpbmcgdGhlc2UNCmhlbHBl
cnMgdGhlIGRyaXZlcnMgYmVjb21lIG1vcmUgY29ycmVjdC4pDQoNCnYxIG9mIHRoaXMgc2VyaWVz
IGlzIGF2YWlsYWJsZSBhdA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2NvdmVyLjE3NjU0
NzIxMjUuZ2l0LnUua2xlaW5lLWtvZW5pZ0BiYXlsaWJyZS5jb20NCg0KQ2hhbmdlcyBzaW5jZSB2
MToNCg0KIC0gcmViYXNlIHRvIHY2LjE5LXJjMSAobm8gY29uZmxpY3RzKQ0KIC0gYWRkIHRhZ3Mg
cmVjZWl2ZWQgc28gZmFyDQogLSBmaXggd2hpdGVzcGFjZSBpc3N1ZXMgcG9pbnRlZCBvdXQgYnkg
U3VtaXQgR2FyZw0KIC0gZml4IHNodXRkb3duIGNhbGxiYWNrIHRvIHNodXRkb3duIGFuZCBub3Qg
cmVtb3ZlDQoNCkFzIGFscmVhZHkgbm90ZWQgaW4gdjEncyBjb3ZlciBsZXR0ZXIsIHRoaXMgc2Vy
aWVzIHNob3VsZCBnbyBpbiBkdXJpbmcgYQ0Kc2luZ2xlIG1lcmdlIHdpbmRvdyBhcyB0aGVyZSBh
cmUgcnVudGltZSB3YXJuaW5ncyB3aGVuIHRoZSBzZXJpZXMgaXMNCm9ubHkgYXBwbGllZCBwYXJ0
aWFsbHkuIFN1bWl0IEdhcmcgc3VnZ2VzdGVkIHRvIGFwcGx5IHRoZSB3aG9sZSBzZXJpZXMNCnZp
YSBKZW5zIFdpa2xhbmRlcidzIHRyZWUuDQpJZiB0aGlzIGlzIGRvbmUgdGhlIGRlcGVuZGVuY2ll
cyBpbiB0aGlzIHNlcmllcyBhcmUgaG9ub3JlZCwgaW4gY2FzZSB0aGUNCnBsYW4gY2hhbmdlczog
UGF0Y2hlcyAjNCAtICMxNyBkZXBlbmQgb24gdGhlIGZpcnN0IHR3by4NCg0KTm90ZSB0aGlzIHNl
cmllcyBpcyBvbmx5IGJ1aWxkIHRlc3RlZC4NCg0KVXdlIEtsZWluZS1Lw7ZuaWcgKDE3KToNCiAg
dGVlOiBBZGQgc29tZSBoZWxwZXJzIHRvIHJlZHVjZSBib2lsZXJwbGF0ZSBmb3IgdGVlIGNsaWVu
dCBkcml2ZXJzDQogIHRlZTogQWRkIHByb2JlLCByZW1vdmUgYW5kIHNodXRkb3duIGJ1cyBjYWxs
YmFja3MgdG8gdGVlX2NsaWVudF9kcml2ZXINCiAgdGVlOiBBZGFwdCBkb2N1bWVudGF0aW9uIHRv
IGNvdmVyIHJlY2VudCBhZGRpdGlvbnMNCiAgaHdybmc6IG9wdGVlIC0gTWFrZSB1c2Ugb2YgbW9k
dWxlX3RlZV9jbGllbnRfZHJpdmVyKCkNCiAgaHdybmc6IG9wdGVlIC0gTWFrZSB1c2Ugb2YgdGVl
IGJ1cyBtZXRob2RzDQogIHJ0Yzogb3B0ZWU6IE1pZ3JhdGUgdG8gdXNlIHRlZSBzcGVjaWZpYyBk
cml2ZXIgcmVnaXN0cmF0aW9uIGZ1bmN0aW9uDQogIHJ0Yzogb3B0ZWU6IE1ha2UgdXNlIG9mIHRl
ZSBidXMgbWV0aG9kcw0KICBlZmk6IHN0bW06IE1ha2UgdXNlIG9mIG1vZHVsZV90ZWVfY2xpZW50
X2RyaXZlcigpDQogIGVmaTogc3RtbTogTWFrZSB1c2Ugb2YgdGVlIGJ1cyBtZXRob2RzDQogIGZp
cm13YXJlOiBhcm1fc2NtaTogb3B0ZWU6IE1ha2UgdXNlIG9mIG1vZHVsZV90ZWVfY2xpZW50X2Ry
aXZlcigpDQogIGZpcm13YXJlOiBhcm1fc2NtaTogTWFrZSB1c2Ugb2YgdGVlIGJ1cyBtZXRob2Rz
DQogIGZpcm13YXJlOiB0ZWVfYm54dDogTWFrZSB1c2Ugb2YgbW9kdWxlX3RlZV9jbGllbnRfZHJp
dmVyKCkNCiAgZmlybXdhcmU6IHRlZV9ibnh0OiBNYWtlIHVzZSBvZiB0ZWUgYnVzIG1ldGhvZHMN
CiAgS0VZUzogdHJ1c3RlZDogTWlncmF0ZSB0byB1c2UgdGVlIHNwZWNpZmljIGRyaXZlciByZWdp
c3RyYXRpb24NCiAgICBmdW5jdGlvbg0KICBLRVlTOiB0cnVzdGVkOiBNYWtlIHVzZSBvZiB0ZWUg
YnVzIG1ldGhvZHMNCiAgdHBtL3RwbV9mdHBtX3RlZTogTWFrZSB1c2Ugb2YgdGVlIHNwZWNpZmlj
IGRyaXZlciByZWdpc3RyYXRpb24NCiAgdHBtL3RwbV9mdHBtX3RlZTogTWFrZSB1c2Ugb2YgdGVl
IGJ1cyBtZXRob2RzDQoNCiBEb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdGVlLnJzdCAgICAgICAg
ICAgICB8IDE4ICstLS0tDQogZHJpdmVycy9jaGFyL2h3X3JhbmRvbS9vcHRlZS1ybmcuYyAgICAg
ICAgICAgfCAyNiArKy0tLS0NCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV9mdHBtX3RlZS5jICAgICAg
ICAgICAgICB8IDMxICsrKysrLS0tDQogZHJpdmVycy9maXJtd2FyZS9hcm1fc2NtaS90cmFuc3Bv
cnRzL29wdGVlLmMgfCAzMiArKystLS0tLQ0KIGRyaXZlcnMvZmlybXdhcmUvYnJvYWRjb20vdGVl
X2JueHRfZncuYyAgICAgIHwgMzAgKystLS0tLQ0KIGRyaXZlcnMvZmlybXdhcmUvZWZpL3N0bW0v
dGVlX3N0bW1fZWZpLmMgICAgIHwgMjUgKystLS0tDQogZHJpdmVycy9ydGMvcnRjLW9wdGVlLmMg
ICAgICAgICAgICAgICAgICAgICAgfCAyNyArKy0tLS0tDQogZHJpdmVycy90ZWUvdGVlX2NvcmUu
YyAgICAgICAgICAgICAgICAgICAgICAgfCA4NCArKysrKysrKysrKysrKysrKysrKw0KIGluY2x1
ZGUvbGludXgvdGVlX2Rydi5oICAgICAgICAgICAgICAgICAgICAgIHwgMTIgKysrDQogc2VjdXJp
dHkva2V5cy90cnVzdGVkLWtleXMvdHJ1c3RlZF90ZWUuYyAgICAgfCAxNyArKy0tDQogMTAgZmls
ZXMgY2hhbmdlZCwgMTY0IGluc2VydGlvbnMoKyksIDEzOCBkZWxldGlvbnMoLSkNCg0KYmFzZS1j
b21taXQ6IDhmMGI0Y2NlNDQ4MWZiMjI2NTM2OTdjY2VkOGQwZDA0MDI3Y2IxZTgNCi0tIA0KMi40
Ny4zDQoNCg==
