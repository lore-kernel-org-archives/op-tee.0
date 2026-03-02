Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540D8E9B37D
	for <op-tee@archiver.kernel.org>; Mon,  2 Mar 2026 13:39:55 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9FB5343845
	for <op-tee@archiver.kernel.org>; Mon,  2 Mar 2026 13:39:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=f7JYfitH;
	dkim-atps=neutral
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8CA6440AF3
	for <op-tee@lists.trustedfirmware.org>; Mon,  2 Mar 2026 13:39:33 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4638a18efc2so3351434b6e.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 02 Mar 2026 05:39:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772458773; cv=none;
        d=google.com; s=arc-20240605;
        b=ZBDAMvsXRWvgbRYvkdefD5FR71yVnYMP+hmEL6rWCSiPfNmPQcihRZO18vvx8MWwGX
         +l2YBc3IAJdp/rtXptLRu2sdlg+DsBz+Lbk6JCeXXlCqYRbN/f8ZoKymOZ9SXcWolPdu
         Qo6gQUY9j4qSfZPcdTYfqTOYPSQhD8LhZdEnyBCbCfbiFSEmSHt51g4jGvo2006d4kVr
         pix/l8JbbwyYQYabGwjPKEFhRzAnK5ebG90qCDbolokOtUQ5IIGioWlbckhoUHG2uMWC
         HAuPkc8RYZT4aB9r8uyqyeoK9eus6nbFItWrmYxcW9yUQj5wXr3Kexnb89N9hXFu2HNr
         V6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PQW6wU6uZH9wyTixh3EBJIBogxoEQTvqKZgZk9jAkUQ=;
        fh=bDdIobJRcIkFJxqNb9i05L4RyRmzCcqlRpR00mcVhdw=;
        b=BVHWBhPQiPdaVsJ/0nKZQDi0CevY7YmFPnCEXqRt5MhykMCiSKCiKpXrawKgf8clKx
         9pccoryEskQfL8VWsPCFq5GPI4OsoVdrVtdazKyEYcE1rDpRa9D1ZQ6Va9ioK4oWUER5
         3dcjUWR6+oQNfTO42uqQjc43dH3MRGpM/zGcdv7xySGLdWwX6skLvdNws3nHSBvXI7er
         z3s57i6t0XM2T4U09pvl2Qu2kpuVOri0/iABgEmnQAkEADXYr2SiJOE/G/Odm5LjTrT7
         NSapeiHUxHakL12A5ES/cajmAuRxzq2qJ0H/T5U752YY0w+evC2hQ2I85XZNeFd65Ydj
         br1w==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772458773; x=1773063573; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQW6wU6uZH9wyTixh3EBJIBogxoEQTvqKZgZk9jAkUQ=;
        b=f7JYfitHtQcTNCrCtlbHCMFj8FEA1Ia9y1yP2i2GAd1lraEQmmsjiyPEMFAmjlJjFo
         dLcimr3ulV8PXbzC7yicCyMpTmS7SiOu1UkdOxBQJJ3bm2zWx5wG5q4cF2ACGqxrUdoS
         Qefb7405UlQTfZS5qqd6wJBcKqc4e67R2YEEBvPbce1KOLJSTY4R5+P1dfqQXnb6eA3A
         FGjeH8XU+da/MaewPzmgdSmSsHYwx8nGJkTg2hkzT9qQQgKkB4A5Wq+RYwEhWA4pXAQO
         M+F6SB1u5T2ZBCNR1pMza+qh/SRn3FPbpIRMKW3mrfnufQyAnVhH4UfE3ZWoVGav1ysH
         Mq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772458773; x=1773063573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PQW6wU6uZH9wyTixh3EBJIBogxoEQTvqKZgZk9jAkUQ=;
        b=Bh+CZku498sbgzlf3GN1GOIe0Klb31vdVkOb3wKrbeOxUKDib2OJwO6982kotUnag1
         3p3RiduxpivkLC7KS3kUgqV1LNLzEVX4fYAsqug0/yKCkViPHUoY3+2cMyQC/xN5/Z0D
         unklua4EJVJo5ZJuUXH8+JEHNpISii/zCbrGwRRjiFKgHFaqJyEG8rgcZObunaaSrZgO
         Xvl6KBmgPuK8eWw0KLXrFmQfiDpzS0uAYnaJDfkqsiNNLzF0gsyvYWungknNV1XjZMjs
         aZDvSXhh44Ix6Y8k4/QURjKrTWbK9RfWxcNuFzze/NuOaiGGZvDPxDDN7LdxeOC7rops
         o5wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXApJ6CMpSWxN20FASIA51SQK5PT3qFIuSKz+CHtmBiFOiEjrDISEwO1UVNTtdN8iK8lGOuh0E=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwI034A+P1pHj2PRgQGqoBBvs0xNnDiNvLKe4VLWjxxmvu+PKSU
	FDHibuPmYkKpk9bL1gZH9XsRKkOfJGdbRJP0zjfha4Vo5DM4kHZpYXd72cumEAnE7xhgjVWB3WB
	1BwmDMT9TzPSVZhLOyyQo5qdkRfNXE6mCL4KfzmuYRt/V
X-Gm-Gg: ATEYQzysWqaOZB4G75Ovmc9uXNGdO181fSM0FIZqNPZf6Ma082iVZF7ta5evr+CCNc5
	tmtHbMzhm2KYFXeUkJ+UEYXXmak6tXq5fUArLAuCbrmhyBX+JW4TrDBaG4D7QJLYjWOSkptTXZ7
	lM1kVAxJqWm5cZNFqkRZPL8Q+FFVl5Va9BLPOG0jc+W45IwfDWEslWy6/I06fxRciopad4nGNo9
	AJ1wgpQVlw2PW13V7SDJe8g1RwIl7wyYPxjksaOJqrLvr13ykBHwdWb/7sX0IInn2zCUI4MiWHf
	wIyz7WWFwXkdaN6Tnsix5X9YKzcOd8YskQcQiA==
X-Received: by 2002:a05:6808:bd3:b0:462:d09a:cdca with SMTP id
 5614622812f47-464beb5b37dmr6019969b6e.32.1772458772889; Mon, 02 Mar 2026
 05:39:32 -0800 (PST)
MIME-Version: 1.0
References: <CABcfEOfmr+xL_uOmmXfQkvZiME0-Mk3-KK1xSS5kCW-ervTTHQ@mail.gmail.com>
 <CAHUa44EcHjWqJXNgKG=9Pb2yX9k11+8RkjJA=LE3GfqC=qkb-g@mail.gmail.com> <aaWK8EqeAZN7SIdc@sumit-xelite>
In-Reply-To: <aaWK8EqeAZN7SIdc@sumit-xelite>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 2 Mar 2026 14:39:20 +0100
X-Gm-Features: AaiRm53s5Ug97Zc5xrabFRHSwNNB_FTRtP64inRo1ot9eA8IdM1u9pr_BE_UjYc
Message-ID: <CAHUa44Epr-r3hLf9cLiOMzn+tdqGuuOXjOzv5V44OMvbNnhbDg@mail.gmail.com>
Subject: Re: [PATCH v5] tee: optee: prevent use-after-free when the client
 exits before the supplicant
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.180:from];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.180:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.trustedfirmware.org,oss.qualcomm.com];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8CA6440AF3
X-Spamd-Bar: ---
Message-ID-Hash: G26NWWU3NAL54T4PMTAFKFRLT6546T7I
X-Message-ID-Hash: G26NWWU3NAL54T4PMTAFKFRLT6546T7I
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/G26NWWU3NAL54T4PMTAFKFRLT6546T7I/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, Mar 2, 2026 at 2:04=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org> w=
rote:
>
> On Mon, Mar 02, 2026 at 01:59:35PM +0100, Jens Wiklander wrote:
> > Hi,
> >
> > On Wed, Feb 25, 2026 at 8:54=E2=80=AFAM Yuanjia Yeh <yeh.ooxx@gmail.com=
> wrote:
> > >
> > > Hi all,
> > >
> > > We can reproduce the reported use-after-free issue on our platform vi=
a an
> > > overnight reboot test
> > >
> > > The verifications are listed as the following
> > >
> > > - With v2 + Michael Wu's patch: Issue resolved.
> > > - With v4: Race condition observation and already report to Amir
> > > - With v5: Race fixed. Stable in our tests, including:
> > >       xtest + reboot loop (300 cycles)
> > >       continuous reboot test (1000 cycles)
> > >
> > >   No regressions observed with v5.
> > >
> > > If there are no other concerns, we recommend adopting v5.
> > >
> > > If needed, please add the following tag:
> > > Tested-by: Ox Yeh <ox.yeh@mediatek.com>
> > >
> > > Yuanjia Yeh
> >
> > Thanks for testing. Sumit, with this Tested-by are, you OK with the
> > patch? I've tested it locally and it doesn't break anything for me.
>
> Yeah, feel free to add:
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Thanks, I'm picking up this.

Cheers,
Jens
