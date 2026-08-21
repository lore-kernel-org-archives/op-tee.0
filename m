Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C554C5DF94
	for <op-tee@archiver.kernel.org>; Mon, 24 Aug 2026 05:14:54 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4A5DE4502B
	for <op-tee@archiver.kernel.org>; Mon, 24 Aug 2026 05:14:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bJKGsPyY;
	dkim-atps=neutral
Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4740643EC7
	for <op-tee@lists.trustedfirmware.org>; Fri, 21 Aug 2026 15:59:11 +0000 (UTC)
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4af7b6a2349so494249b6e.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 21 Aug 2026 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787327950; x=1787932750; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/a0pcGfQ/DN5G5vgeGh7d5qeMSleQ+VJHVJXKyA8bJE=;
        b=bJKGsPyYU3BepOA6M+XnwVYt+sQr8ZQAimlkZB00Zz/EPip3d0zdgiT4r/puVyIMUj
         5W4+gVNGu/b6+lBJHpHpwSQLnZQ0afx3qo68lWuED3wSZ4lstriewrKSBWjh9qIfhlFg
         c2pEL6x1WWZASXIMk/iTR4CTFWH7NiEYwz6f/EuK6H3TSq++X+vDR0F4GY9Q0US4+Jxq
         T2Y3AcDcCB43qoSK9r52Joxq1ODNMkB6zxv2WoTMz86tpHaXwaUNW9JCrJBC5pyx9G48
         3ULAuaUq0ZaPCf0qegJRmUla/kY6cRkS4Sa6MRymasa8zM9hceLmmzQ6dVCIqX3RblR3
         48mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787327950; x=1787932750;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/a0pcGfQ/DN5G5vgeGh7d5qeMSleQ+VJHVJXKyA8bJE=;
        b=SSsWQy2JpxhpNRi5ch7ts9WY6LMfDwuAp6/gS8eJwoiLOsdIB4ulMbWYuCTggTaMMp
         aPKJw09NbIEHaas8AZowBQtpVZzrtyTFQPFIU9Kw6vBbhaFqCI9l7l08d1TPKRHFr6Pf
         CCjkK9JbzI8NPb33bP5Bxix/78NmtVQDHWRDDCi4Da7pDrRR1xGlXtkBu7OGXefE1x0g
         UEt4PiV9iASnpBPkzWY49q7ohqnpVsgBr/dZxHovM/YenBVounY8IhBnB+iRf5QZSYNw
         ISLPjrJvTW4FeEcZeMx7NcPELroww+tY4t7Oz7tLKD3Pa6AyVYjrI+4j1WJv86KTk2wh
         Q5iQ==
X-Forwarded-Encrypted: i=1; AHgh+RpxRlHxLXU4X33xOywJo1jeIAyltNL7lUOWt5Jk9omngCWSqgxbPKFk9998pugeZqUP0no/fp4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwlsEnEUlANsbvzZODOIfYq4vXGgyUgRp4kNg1lzAQgv6VIHVLD
	OIcy1O6SZjTGZRXdVeVQZq+FOXqu7TphM5GdslGvRlP0+avEYtEO6Qew
X-Gm-Gg: AR+sD115dfTbOSyF3aWC09frjSXLS3LAdCWgL9EYufYw3pxo6crQnJKnU5MHQuP/jCd
	lB3XqS0plci8OlfzySfBwIqvhk1RC35AZ0wLV9AuFgxczBC6OkJbwfL19eqXiZTnCtVAcCQvV2l
	nqUcfvM+85qt8Duu3dFGsvcZeANNoF9YBa/jXtIxr6qxrFDWyScDk/XrcR7urinnDU8zfd+DS45
	cQT8nK1VBitKBeUNUqdCEj1uLf2AnvQCZ4lt62hwKO7LzRj1KAR0a5/TWBr6yT6FXogV3RsDKn1
	Zqj+PtCkoL9sIIz+Hz69/tv4CvF9bkNDOAE8IhVj4nh2Scvje5/CxBP83zEtG7zDA4QXmRD3cLy
	7fVVu73UZ1TRKhPDw+zLGwrervUSts4Cs64xuJHedAxQbaoTl5b61Q9ujhyT/OY+IokcnEqdgE8
	IRe9Qs8kNUdXYA0GwImHdCgac4xcnv7+EZdRkQtjl8vCA0IKDXCpte3c4JTPVfNm+SmabfX3Kwh
	wuBNw==
X-Received: by 2002:a05:6808:1527:b0:4a4:933:b20f with SMTP id 5614622812f47-4b2ef14d4eemr6740578b6e.7.1787327950508;
        Fri, 21 Aug 2026 08:59:10 -0700 (PDT)
Received: from ubuntu24 ([120.239.197.32])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2d6d8945dsm5119763b6e.16.2026.08.21.08.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:59:09 -0700 (PDT)
Date: Fri, 21 Aug 2026 23:58:57 +0800
From: Xing Loong <xing.xl.loong@gmail.com>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/3] tee: add MbedTEE driver
Message-ID: <aoh1wdtxXF5PkPPw@ubuntu24>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGgiveU2TjkA1YnPxBy2e9qtCorSumuno04aEir-u74yKvXBsw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.98 / 15.00];
	BAYES_HAM(-2.98)[99.92%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:74.125.0.0/16];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:74.125.0.0/16, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[gmail.com:dkim];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.231.203:from];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.231.203:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4740643EC7
X-Spamd-Bar: -
X-MailFrom: xing.xl.loong@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: AOZEBFAEVMDBNN6IX3ZKSYYL5ABT245O
X-Message-ID-Hash: AOZEBFAEVMDBNN6IX3ZKSYYL5ABT245O
X-Mailman-Approved-At: Mon, 24 Aug 2026 05:14:20 +0000
CC: Jens Wiklander <jenswi@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AOZEBFAEVMDBNN6IX3ZKSYYL5ABT245O/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>


Hi Jens,

On 20/08/2026 10:10, Jens Wiklander wrote:
> I took a quick look at the mbedtee project, and it appears to be a
> one-person hobby project. Sounds like fun, but I wonder how meaningful
> it is to upstream a kernel driver if you're the only user.

Fair point. I wasn't fully aware that an active user base was a strict
requirement for upstreaming a new driver, but that completely makes
sense from a maintenance perspective.

I'll hold off on pushing this driver for now until mbedtee gains more
actual users. For what it's worth, the integration side is fully in
place with tested QEMU/FastModel support and a working Buildroot
overlay, so it's very easy for anyone interested to try it out.

Thanks for your time and the prompt review!

Cheers,
Xing
