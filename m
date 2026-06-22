Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4370ACDB46B
	for <op-tee@archiver.kernel.org>; Mon, 22 Jun 2026 07:54:18 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 627FB44E32
	for <op-tee@archiver.kernel.org>; Mon, 22 Jun 2026 07:54:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iRJQzdV8;
	dkim-atps=neutral
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A5A7E43941
	for <op-tee@lists.trustedfirmware.org>; Mon, 22 Jun 2026 07:54:10 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e6128bd9b3so2201138a34.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 22 Jun 2026 00:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782114850; cv=none;
        d=google.com; s=arc-20240605;
        b=OE33zuHrg0MqaCIWaj9I3V4ZuTKRRnZOHLa3qeeGj8mmPie8NR/nFiSOI8GOEz/80W
         IyZCGZIpbCbdoMXzGzqU1lMf5OdBQGxuqLgnt3RmcDP6TioS4asUSYFd0SbCXSiyzuGG
         fwfogPyuEGKLwlCa64/mp717a216YvhJmTr9O5O+i3hcDVT0wtIrZQAiLuMAKQFYsror
         hNP1LYbULnfrub9881TCI/1jwct2Cmhdwta9v/xtlA1Y+mhjLPB6hk4xFEF5RTrGReJ2
         ztXrd0kWwwb7kaAkDakfr60LUSZG11ULGkG1uGYnqb30qPpzI5w8+xW6m685aOOurAE2
         zvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=t8qKUhvKEwaPt+ZICG0oraEIE0x89i+8oKc6AV/sOms=;
        fh=QMgjRTud3zRGrIikisptnJQ9eIvAhpU2BvrMJA0Z90w=;
        b=hs/dMV6y8brb4E8mYf49Nxnq1FXvP0BV0JcEBCQSBXmmpruxfbnQ4ecsyhFxHeO1hw
         V4yUlOQKgxoQzmkcLZ3E5jaA/hKmtRqjasTdT0DQfiNx8f7NIn9h0Hwx0BIFkChkb85C
         B3A54je/8CjX0oTmEGgdeFtIGsn0YtqOwMHdq3Jyyx9tZL0loGn4zK40fBYhjKoSLMxr
         7EO462j9HkuQAYLwSAx4wvXajLZUo2WcXHiEzojfHJWqZOll1z11FKBNdm68UspUS7XQ
         DoKEvkKZTqZrotGou7sf2Uyt6pNkata6mRhwWCqn3TRtqc4hMJOu0Wtddbu+/78S0wSe
         0pmg==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782114850; x=1782719650; darn=lists.trustedfirmware.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t8qKUhvKEwaPt+ZICG0oraEIE0x89i+8oKc6AV/sOms=;
        b=iRJQzdV8LDgduM+5YkR1UoI1YJzw31MMmmJigQEbKOY55uyCbATsMPinuLTljlF7x2
         VFp8iwGSMBQZZFflCH32n50ZkCUeh9btkgS7VF7qJlYWWqc0mq71+jBeLnbZWMPneuMm
         i33gkNNWojEArXOMFbqls8OgNICE8nKxjB5BiwdbAurEVN89M/pBZr0fSz2seBQMKDZ6
         Udc8UW51pjrXgbdbaIk5719QFQ5RLp5wfZjUxa48wseOiycUUfP2S3ua5jOSaFFcpzf/
         gpYLq4HOX9KFjMInY7eBk0nGVRshV+Px7efn0H1B3/t7K4R57HcafgxRB7VAfZ0tquXn
         8Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782114850; x=1782719650;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8qKUhvKEwaPt+ZICG0oraEIE0x89i+8oKc6AV/sOms=;
        b=h7EkE1d87kUkzPuKThG2uP5CiS9rhbQlsId7se0Ndi6HW4JDJeqBYXw5mCL6LWKW44
         IBRuGVPWFLC02qTiL4bMIjPhaF6elX38LfNVdtyjTM55puhVODUyr9/6QqFgcYCN0dRs
         rqrh9ac/PlzxlMrXJAept03utK14D41qkTNWJNg3tOHsTzx++3o41Zo6VBIYrSvDxbkA
         F9qQ8tWkh+Qpb88WyTWbrS85Yxb1IpqQrDhdua5kpMcWxwKx9WZb3cHS333xcbLxgG0G
         LMKWlKbwoIOFfwboqvtuhwWf2eZcqUPtEznVZJHtteKJ0LMZAYxyrpsm4OPICdgMGz41
         7giA==
X-Gm-Message-State: AOJu0YxyqZ36PzXNJ5ipeID+JHad2L7IN7iApZ3M9fMmtzt31olHWg6d
	k2WBqYFpuJB07kFyAHGXUwrEvAwyT1uHjo6qdfeqtE4903HeXL5AyjwoTsHX0M/cvheGUz/33+a
	ScGZLmS2BbJfYD73xYAK7mtr2iEVwaCzXNTQgZUNjc/hK8EZIJxb+MzITDQ==
X-Gm-Gg: AfdE7cnzSWDr00tXy7EPng+39LGc+FFCUgDwkm/QCYG/xDe6jo8CWprEyTgoCzfgIn3
	eDnYQFnDj2inYayfVD30CmHaLha5lQAE6MXzJSQVn0Xa/NiXC8B4kW3GsSgWQhHV/GCVn7cNX+A
	3ZKIqIleu3eKRI5MNn+qOGX3+X8Vu2uXEj2rnw+iah9k/Dj0KkeB5CqLWvCvGJ//HSxUlulEZdr
	jBacPX8/WJTzoS+choV/o4oZiBt+EdS/ee6CpioWe3HDRrYvBVk5iArvg5NOaZRcJ9BirErkgMZ
	5+eoPWGCDB1SeopMDM6f6b3kFco=
X-Received: by 2002:a05:6808:4f2a:b0:48a:a85b:ba53 with SMTP id
 5614622812f47-48aa85bc13fmr11011830b6e.35.1782114849712; Mon, 22 Jun 2026
 00:54:09 -0700 (PDT)
MIME-Version: 1.0
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 22 Jun 2026 09:53:57 +0200
X-Gm-Features: AVVi8CdAeCaAu7eF-PM-i1Xhe6FWKEe7VpwuKfQBHjhSrR3Ivt5gICC_bT5k8gk
Message-ID: <CAHUa44HygNePe1-Rfn_3VwEBM_dgj9E46Pw=Mh1-xYQC4RefGw@mail.gmail.com>
Subject: OP-TEE Contributions Forum, monthly meeting June 23
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.73 / 15.00];
	BAYES_HAM(-1.63)[92.66%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.52:from];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWO(0.00)[2];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.52:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A5A7E43941
X-Spamd-Bar: ---
Message-ID-Hash: OD6UVMELXWHXFFFU2O4IQMJUSQG4UW34
X-Message-ID-Hash: OD6UVMELXWHXFFFU2O4IQMJUSQG4UW34
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
CC: linaro-open-discussions@op-lists.linaro.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OD6UVMELXWHXFFFU2O4IQMJUSQG4UW34/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGksDQoNClRvbW9ycm93LCBUdWVzZGF5LCBpdCdzIHRpbWUgZm9yIGFub3RoZXIgT1AtVEVFIGNv
bnRyaWJ1dG9ycycgbW9udGhseQ0KbWVldGluZy4gRm9yIHRpbWUgYW5kIGNvbm5lY3Rpb24gZGV0
YWlscywgc2VlIHRoZSBjYWxlbmRhciBhdA0KaHR0cHM6Ly93d3cudHJ1c3RlZGZpcm13YXJlLm9y
Zy9tZWV0aW5ncy8NCg0KTWFpbnRhaW5lcnMgaW4gSnVseToNCi0gSmVucyBpcyB1bmF2YWlsYWJs
ZSBtb3N0IG9yIGFsbCBvZiBKdWx5DQoNCk9QLVRFRSByZWxlYXNlIEp1bHkgMTc6DQotIFNvbWVv
bmUgbmVlZHMgdG8gZmlsbCBpbiBmb3IgSmVucywgb3Igd2UgY2FuY2VsIG9yIHBvc3Rwb25lIHRo
ZSByZWxlYXNlDQoNCk5leHQgT1AtVEVFIENvbnRyaWJ1dG9ycyBGb3J1bSwgSnVseSAyOA0KLSBD
YW4gc29tZW9uZSBlbHNlIGhvc3QgdGhlIG1lZXRpbmcsIG9yIHNob3VsZCB3ZSBjYW5jZWwgaXQ/
DQoNCkFkZGluZyBzZWN0aW9ucyBpbiBNQUlOVEFJTkVSUw0KLSBDb3JlIHJldmlld2Vycw0KLSBW
YXJpb3VzIFRBcw0KLSBVcGRhdGluZyBvdGhlciBwYXJ0cw0KDQpBbnkgdXBkYXRlcyBmb3IgS2Nv
bmZpZyBzdXBwb3J0Pw0KDQpBbnkgb3RoZXIgdG9waWNzPw0KDQpDaGVlcnMsDQpKZW5zDQo=
