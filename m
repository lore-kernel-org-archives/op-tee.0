Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CEED44166
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 10:57:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 836804FD0E
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 10:57:08 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=xwj+sUfH;
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7BCAB431FB
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 17:15:54 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4775ae77516so4193775e9.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 09:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473353; x=1766078153; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EMUEsjsV+UnHdVdxs42rX4kdIiZsjjM1yfHblt+Kr5Q=;
        b=xwj+sUfHxjV/dp0jqcTypyk+cbwHZ3Y6CCNGmE+xrQOmdkFwuP9jk+93fRwrZJq/jI
         TVqPmHMS454F3idCsfh3lXUzG7EWYUABYGnm5eq6As94CyjJ/i1MQpCcnduf0aCS0vh3
         VnzsSW1Coex0Dvf5+I+6OzM6fCH6MlRgmPVvOVTQpVjrs7+WKSt4MnqcRWDAOFP67rxx
         kswnIsVBDLOcvQyiAgS0K1YMn/SbumfUDNllwFaxQC6xhJWXPmLRFV0VXcCssCHRfT3+
         JhKN5Q38jZN2idORIcCdfImz1rYKbIJkxZEnhoeK0WJyPtVh3Q/dHZnZMt5fE9nZWsbq
         qOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473353; x=1766078153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMUEsjsV+UnHdVdxs42rX4kdIiZsjjM1yfHblt+Kr5Q=;
        b=s6KdiStVwrUAMBtI1ZfI3ApiTW8I4VCnG4/hdikF5KWrvYFV1Ru87OkT0JOECiFt4t
         1XxcAFDs+OQ3F94DRO1SIgv1ZjUAC5W1VwLgZFjbOjFDUThFLih236nV0T3edyuAnZmS
         8ZhFN26tx+xuH3ps1tPPAmxmcJxKbQAuTcy3ZDTcEFREePN3/VZR5Gu0hg2imTdrtrPZ
         Y/oei7DvXW9picG6SLCj/BJt0rDAYG3iFzmuCUoKeZH3QBCixU0Za9+UaS1PvsQCbkDr
         0gfnQjUfAMxfuElMzAsLIoWUMrbHu9GAm0LVenxloo7IGQmeteoKAg7M7/oJiF9A553n
         rZsg==
X-Gm-Message-State: AOJu0YzsISdXSydzTn+WUR+VGhdz0G/qCW1VEDU0acraqocQ2P0G6vcA
	Ncbda1b8BDxSL0xfRMScdXlZsEaePHDp99BJf/FrYc2MTG6J0bLUoLzIaZwWXn5VMZc=
X-Gm-Gg: AY/fxX4hQS93p3v7nPnRoV7H31dwpdWFOsRFpV+yMXkm1eqAou5UaaCScB+yzh79Jbe
	3BcWqnUWk7BQ/NWAU/Tz5vwMT6qUupD8GLlooKPVUG+fU3dAgWHILUZP27QduP7mqT8nt+JFJjZ
	YgDEJE6f3g2d7SBHgA2/cujsEV7rGb0qyVfexy0R36A40GEbGO+Y/+4xFd4ZFf2+Q7wALhfzG4d
	sCuVbM+X71bk5A4DnboYaxupRtDUlk5epnnsUIeiUsyUxExzDhY8D533L6OihiwiX4VvIWpn7BJ
	yysURi8MLC6WWmjwdCW0FCNXKtOO8jbGTCnDTq/BN64QigRHfNM5uPGJVxpdjrYQmAtxM0PYele
	8gBzZzt8gj4Heo7AXN8W/0oSyD0dE3ZnlG9583KZqEbftzpb+NKaApByAM4f4Nna3owhM0YyKI4
	E5+5WoJTVPsieTymMouc7NANKGhTNHL7qU8nBq6j177cI91H3WAsH3jLF7qQJ2bEcRCZG4El/fU
	Zw=
X-Google-Smtp-Source: AGHT+IH1WdB9lpe0Nt0W2bI91FzFVq1XhPopqcW3gxsnNR/pZMKlmmN+J4cQvorBXPFQhPdkhqM0qw==
X-Received: by 2002:a05:600c:1d0b:b0:477:7c45:87b2 with SMTP id 5b1f17b1804b1-47a8375ae3dmr83804315e9.16.1765473353260;
        Thu, 11 Dec 2025 09:15:53 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42fa8a6fd62sm7327909f8f.10.2025.12.11.09.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:15:52 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
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
	Sudeep Holla <sudeep.holla@arm.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH v1 00/17] tee: Use bus callbacks instead of driver callbacks
Date: Thu, 11 Dec 2025 18:14:54 +0100
Message-ID: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3006; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=VskU/7ED+cd07+YT0cLSY6lSv8W33UJFXaXtUVFg16k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvwTkOdNXplS+sYyTfjIHP/A8Gme4RZEpqcXt diRkMgNgISJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8EwAKCRCPgPtYfRL+ Tl1NCACRY8t0HOZ/pe2jgNYt83zctNNDYXhzu8cPsBYC6DoxIG7qbaEG/i2btzV7P9iWEXcGnaW iTW12DonZuA0Ys9v8JfYi5w/j0bn6FtrwKHIXypEwJzVzqmq0s9FhsPI+49irrtevJQOGtp/6FA ++4ZHclomZVYjG5ZORmnn0yLTtXHbQYEPcyHuzEEUvs+tHCIYIgkV7gzQ+qvpTw0lA+x5uFNqib OwGvVZIMvKV/HN70QhazY/X+w3FigDIT5y0g639i0H9JkEXX1mq5qRYi9kcC8z3WazU0iJ39L6Z w+blXNgg5fNZycKQ3GRhj80bk29PcQH7RHH6Vzov1GydnnYE
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: base64
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.70 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[linaro.org,kernel.org,selenic.com,gondor.apana.org.au,bootlin.com,gmail.com,foss.st.com,oss.qualcomm.com,siemens.com,arm.com,wanadoo.fr,broadcom.com,HansenPartnership.com,linux.ibm.com,redhat.com,paul-moore.com,namei.org,hallyn.com,gmx.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[baylibre.com];
	ARC_NA(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.128.45:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	BLOCKLISTDE_FAIL(0.00)[2003:f6:5f00:6608:b665:17f2:bd01:7279:query timed out,209.85.128.45:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.45:from];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7BCAB431FB
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: TUV2DJJ2NDCU6C7BNKSIFZTPGLARKP2P
X-Message-ID-Hash: TUV2DJJ2NDCU6C7BNKSIFZTPGLARKP2P
X-Mailman-Approved-At: Fri, 12 Dec 2025 10:56:46 +0000
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org, netdev@vger.kernel.org, linux-mips@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TUV2DJJ2NDCU6C7BNKSIFZTPGLARKP2P/>
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
cnMgdGhlIGRyaXZlcnMgYmVjb21lIG1vcmUgY29ycmVjdC4pDQoNClRoZSBwYXRjaGVzICM0IC0g
IzE3IGRlcGVuZCBvbiB0aGUgZmlyc3QgdHdvLCBzbyBpZiB0aGV5IHNob3VsZCBiZQ0KYXBwbGll
ZCB0byB0aGVpciByZXNwZWN0aXZlIHN1YnN5c3RlbSB0cmVlcyB0aGVzZSBtdXN0IGNvbnRhaW4g
dGhlIGZpcnN0DQp0d28gcGF0Y2hlcyBmaXJzdC4NCg0KTm90ZSB0aGF0IGFmdGVyIHBhdGNoICMy
IGlzIGFwcGxpZWQsIHVuY29udmVydGVkIGRyaXZlcnMgcHJvdm9rZSBhDQp3YXJuaW5nIGluIGRy
aXZlcl9yZWdpc3RlcigpLCBzbyBpdCB3b3VsZCBiZSBnb29kIGZvciB0aGUgdXNlcg0KZXhwZXJp
ZW5jZSBpZiB0aGUgd2hvbGUgc2VyaWVzIGdvZXMgaW4gZHVyaW5nIGEgc2luZ2xlIG1lcmdlIHdp
bmRvdy4gU28NCkkgZ3Vlc3MgYW4gaW1tdXRhYmxlIGJyYW5jaCBjb250YWluaW5nIHRoZSBmcmlz
dCB0aHJlZSBwYXRjaGVzIHRoYXQgY2FuDQpiZSBtZXJnZWQgaW50byB0aGUgb3RoZXIgc3Vic3lz
dGVtIHRyZWVzIHdvdWxkIGJlIHNlbnNpYmxlLg0KDQpBZnRlciBhbGwgcGF0Y2hlcyBhcmUgYXBw
bGllZCwgdGVlX2J1c190eXBlIGNhbiBiZSBtYWRlIHByaXZhdGUgdG8NCmRyaXZlcnMvdGVlIGFz
IGl0J3Mgbm90IHVzZWQgaW4gb3RoZXIgcGxhY2VzIGFueSBtb3JlLg0KDQpCZXN0IHJlZ2FyZHMN
ClV3ZQ0KDQpVd2UgS2xlaW5lLUvDtm5pZyAoMTcpOg0KICB0ZWU6IEFkZCBzb21lIGhlbHBlcnMg
dG8gcmVkdWNlIGJvaWxlcnBsYXRlIGZvciB0ZWUgY2xpZW50IGRyaXZlcnMNCiAgdGVlOiBBZGQg
cHJvYmUsIHJlbW92ZSBhbmQgc2h1dGRvd24gYnVzIGNhbGxiYWNrcyB0byB0ZWVfY2xpZW50X2Ry
aXZlcg0KICB0ZWU6IEFkYXB0IGRvY3VtZW50YXRpb24gdG8gY292ZXIgcmVjZW50IGFkZGl0aW9u
cw0KICBod3JuZzogb3B0ZWUgLSBNYWtlIHVzZSBvZiBtb2R1bGVfdGVlX2NsaWVudF9kcml2ZXIo
KQ0KICBod3JuZzogb3B0ZWUgLSBNYWtlIHVzZSBvZiB0ZWUgYnVzIG1ldGhvZHMNCiAgcnRjOiBv
cHRlZTogTWlncmF0ZSB0byB1c2UgdGVlIHNwZWNpZmljIGRyaXZlciByZWdpc3RyYXRpb24gZnVu
Y3Rpb24NCiAgcnRjOiBvcHRlZTogTWFrZSB1c2Ugb2YgdGVlIGJ1cyBtZXRob2RzDQogIGVmaTog
c3RtbTogTWFrZSB1c2Ugb2YgbW9kdWxlX3RlZV9jbGllbnRfZHJpdmVyKCkNCiAgZWZpOiBzdG1t
OiBNYWtlIHVzZSBvZiB0ZWUgYnVzIG1ldGhvZHMNCiAgZmlybXdhcmU6IGFybV9zY21pOiBvcHRl
ZTogTWFrZSB1c2Ugb2YgbW9kdWxlX3RlZV9jbGllbnRfZHJpdmVyKCkNCiAgZmlybXdhcmU6IGFy
bV9zY21pOiBNYWtlIHVzZSBvZiB0ZWUgYnVzIG1ldGhvZHMNCiAgZmlybXdhcmU6IHRlZV9ibnh0
OiBNYWtlIHVzZSBvZiBtb2R1bGVfdGVlX2NsaWVudF9kcml2ZXIoKQ0KICBmaXJtd2FyZTogdGVl
X2JueHQ6IE1ha2UgdXNlIG9mIHRlZSBidXMgbWV0aG9kcw0KICBLRVlTOiB0cnVzdGVkOiBNaWdy
YXRlIHRvIHVzZSB0ZWUgc3BlY2lmaWMgZHJpdmVyIHJlZ2lzdHJhdGlvbg0KICAgIGZ1bmN0aW9u
DQogIEtFWVM6IHRydXN0ZWQ6IE1ha2UgdXNlIG9mIHRlZSBidXMgbWV0aG9kcw0KICB0cG0vdHBt
X2Z0cG1fdGVlOiBNYWtlIHVzZSBvZiB0ZWUgc3BlY2lmaWMgZHJpdmVyIHJlZ2lzdHJhdGlvbg0K
ICB0cG0vdHBtX2Z0cG1fdGVlOiBNYWtlIHVzZSBvZiB0ZWUgYnVzIG1ldGhvZHMNCg0KIERvY3Vt
ZW50YXRpb24vZHJpdmVyLWFwaS90ZWUucnN0ICAgICAgICAgICAgIHwgMTggKy0tLS0NCiBkcml2
ZXJzL2NoYXIvaHdfcmFuZG9tL29wdGVlLXJuZy5jICAgICAgICAgICB8IDI2ICsrLS0tLQ0KIGRy
aXZlcnMvY2hhci90cG0vdHBtX2Z0cG1fdGVlLmMgICAgICAgICAgICAgIHwgMzEgKysrKystLS0N
CiBkcml2ZXJzL2Zpcm13YXJlL2FybV9zY21pL3RyYW5zcG9ydHMvb3B0ZWUuYyB8IDMyICsrKy0t
LS0tDQogZHJpdmVycy9maXJtd2FyZS9icm9hZGNvbS90ZWVfYm54dF9mdy5jICAgICAgfCAzMCAr
Ky0tLS0tDQogZHJpdmVycy9maXJtd2FyZS9lZmkvc3RtbS90ZWVfc3RtbV9lZmkuYyAgICAgfCAy
NSArKy0tLS0NCiBkcml2ZXJzL3J0Yy9ydGMtb3B0ZWUuYyAgICAgICAgICAgICAgICAgICAgICB8
IDI3ICsrLS0tLS0NCiBkcml2ZXJzL3RlZS90ZWVfY29yZS5jICAgICAgICAgICAgICAgICAgICAg
ICB8IDg0ICsrKysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9saW51eC90ZWVfZHJ2LmggICAg
ICAgICAgICAgICAgICAgICAgfCAxMiArKysNCiBzZWN1cml0eS9rZXlzL3RydXN0ZWQta2V5cy90
cnVzdGVkX3RlZS5jICAgICB8IDE3ICsrLS0NCiAxMCBmaWxlcyBjaGFuZ2VkLCAxNjQgaW5zZXJ0
aW9ucygrKSwgMTM4IGRlbGV0aW9ucygtKQ0KDQoNCmJhc2UtY29tbWl0OiA3ZDBhNjZlNGJiOTA4
MWQ3NWM4MmVjNDk1N2M1MDAzNGNiMGVhNDQ5DQotLSANCjIuNDcuMw0KDQo=
