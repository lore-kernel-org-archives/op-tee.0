Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CE6CE7AEE
	for <op-tee@archiver.kernel.org>; Fri, 14 Nov 2025 11:45:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id F1D455006F
	for <op-tee@archiver.kernel.org>; Fri, 14 Nov 2025 11:45:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bQAupRYd;
	dkim-atps=neutral
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 372D14312B
	for <op-tee@lists.trustedfirmware.org>; Fri, 14 Nov 2025 11:45:31 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4501b097976so925370b6e.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 14 Nov 2025 03:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763120730; x=1763725530; darn=lists.trustedfirmware.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EiFzL9ZHpkA2x1IuPAdAFUOJiwMcQN+CNNfmB6yFZ30=;
        b=bQAupRYd48v6TpYc7UzpT5aqKNEuA0hQmBmQ4s8L+aUE3d4Vm36Rn2G4qNAQ5qmSlS
         FWbX63Z+nvhfN4G1Uh9LemSR9p7kXYDUwbYvcRr+5KH2j4DX+iI1ND3yAdq2oeQChVDB
         22LuqlLi2vv3OMTxJ53TWFj0ZcCN7ADbwkfRH5uYqweXR+cFCGxuifJxL+sIaN65Hz54
         Yhj/OLHkPb5V1PjQfcIM782n9TIb91US0HDy46L17CkpLECUvEMOCjD+v16BY3t3tID/
         MXR9LdF8vWripARXcI9EBotSAcJdR5/i1C0W1cIdwfI/1XnJ7eLaPz6wCrKnUaPQkoc4
         f8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763120730; x=1763725530;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EiFzL9ZHpkA2x1IuPAdAFUOJiwMcQN+CNNfmB6yFZ30=;
        b=kjabuyIOauWF2ThaHI5I8LIZpU0PSkdKpTCtuVzbNDNjOqkykoHB15Ho7R7qTwwgnA
         sS/xgAmhDWJYEA7OhmTbLu4hSv134SOGJjQyAYLd3B2mI2tB0GLSOI4e1HvYVGFL6Rys
         C+ZUNafop+FOKiekQUJK9mO5FNokGqejWK+kfc/COpM2S6oRRDvhBfT8UKmGJIAcFBNV
         9HVMt3r8PhwkjvJUWWb/4s32Yjm1hRIS+mE7LhioWHMY1WelvX7SVs2ATQJi9Lbg1iEY
         lHHwiy7G99dWXU2VNmS4EDBPbd8J1RABHrGneeVF7iQgq2JCb9SaHENH8JnJU67PQj5u
         Kosg==
X-Gm-Message-State: AOJu0Yz60Ly/YvxzmcPN1ZBnm5oFfTTaTWDsAK3fg22XY6V30tzerGUo
	0MpW1jsMBp29ofxkY5fnpqeV6Q4wt1+Sl4lEMuA0mdcO6qdfFgZ5MFIxhH5i9Hiz9VsMNBnhTir
	gBH212dqkObzhmGzEacP/FNvDX1jQGUnBWh7BDQvf9jyyzlLZPiUd70lEZg==
X-Gm-Gg: ASbGncv7BEx02C+5hiaqpabc9xrCl8j7mfb61PI00P/+4SOWRiKhJ5RUPBAYS/c5e9T
	/6wKBRVost6eoKxk2xRHYzBu/Nrva8T/zJJbl4QZuEt06EvIj8Sa3YDMGfdAYJCMvj0Myuex4KI
	WYTKaFqpbJcIoAVQyKVdY7hRcNDlbrQcyyhuAHwIQHeSimPeVjlzgG7cpNr9zFlhuOSkkiI3T31
	HXY4sCeiiatzOSGMU2hMowpma8y5/MjGYHhOoUWUudJrt1woy4Cy42reo8NKqEkEd6+kgeW6w==
X-Google-Smtp-Source: AGHT+IGqC0LiQMfQ6Celh2YXuLZV8zAKuGo+VOQ9fCvy+0dEmXrGsVFuBCHdKfTlyE3hjggEyRAODie9X+kvkbkpqzY=
X-Received: by 2002:a05:6808:14c2:b0:43f:7a07:44d7 with SMTP id
 5614622812f47-450975c79ffmr1326440b6e.47.1763120730298; Fri, 14 Nov 2025
 03:45:30 -0800 (PST)
MIME-Version: 1.0
From: Shaun Longhorn <shaun.longhorn@linaro.org>
Date: Fri, 14 Nov 2025 11:45:00 +0000
X-Gm-Features: AWmQ_bkCLjHKmwo7uNKfJisNRg7bcWHSoMTxEY9_acJ07adk092rZKd8Th-Wt3U
Message-ID: <CAGP7_2nAJefmTaw9Xy=nipo9hg6tsvYHiTBsR_hwvUnHMU+Fyg@mail.gmail.com>
Subject: AI Policy - Guidance on AI-assisted contributions
To: op-tee@lists.trustedfirmware.org
X-Spamd-Bar: ---
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 372D14312B
X-Spamd-Result: default: False [-3.76 / 15.00];
	BAYES_HAM(-2.76)[98.96%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.171:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.171:from];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: 5CM2CRNC56PHXNR3QWPXXR3JBJD5BJ2M
X-Message-ID-Hash: 5CM2CRNC56PHXNR3QWPXXR3JBJD5BJ2M
X-MailFrom: shaun.longhorn@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5CM2CRNC56PHXNR3QWPXXR3JBJD5BJ2M/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

QWxsLA0KDQpQbGVhc2UgYmUgYXdhcmUgdGhhdCB0b2RheSB3ZSBoYXZlIHB1Ymxpc2hlZCBvdXIg
QUkgcG9saWN5IHdpdGggR3VpZGFuY2Ugb24NCkFJLWFzc2lzdGVkIGNvbnRyaWJ1dGlvbnMuDQoN
ClNlZSB0aGUgZnVsbCBkZXRhaWxzIGhlcmU6IGh0dHBzOi8vd3d3LnRydXN0ZWRmaXJtd2FyZS5v
cmcvYWlwb2xpY3kvDQoNClNob3VsZCB5b3UgaGF2ZSBhbnkgcXVlc3Rpb25zIGZlZWwgZnJlZSB0
byByYWlzZSB0aGVtLg0KDQoNClRoYW5rcywNClNoYXVuDQpDb21tdW5pdHkgTWFuYWdlcg0K
