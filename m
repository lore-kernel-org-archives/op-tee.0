Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5FEC2A088
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 10:45:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 15A0A4FF34
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 10:45:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oaj100dZ;
	dkim-atps=neutral
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 45F154FEB0
	for <op-tee@lists.trustedfirmware.org>; Mon,  5 Jan 2026 10:44:50 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7ce2b17a2e4so1261951a34.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 05 Jan 2026 02:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767609889; x=1768214689; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAaHf6yOWNsJkhvl6QiZWHrv6AwqRWjpGt7OkO97AzM=;
        b=oaj100dZaj2mtPB97ZXpJwMovySN+khX9enD/3/Gsm5NyniD+ClbvY7X668aLKh1Wr
         1lFcO8aozAkMrV3fSpnaIvIlUdHY7yTwl4LI3fk49qUFJ7MtDho6UzpzJl5r/EhvV2WP
         nSozH1leLERwu0MZZj5AOWS4Sq9dcUsmNiBq5ceDwLSoDOmUKEbGPiR1l9jsXSV7CU4v
         yOIS9TTmp87TC5T6ruBxelBZ/r4CJ1mbmKqVgNSLlQVTlz6uBP+LOj+yBSA+Rzf4QgT9
         dMgiV5pGB3FmlEMiismX/OKgh3VcGo1xb4Mr7RupmzSS1EmZfyhjlfnYfkQsdC5AFhzn
         0Q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767609889; x=1768214689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oAaHf6yOWNsJkhvl6QiZWHrv6AwqRWjpGt7OkO97AzM=;
        b=OB3WYb5mTRvW+2Xjm6IIeonY2IkvuR+8Ze63lQ9HeRBwvZ7eBEuwlDB9furvmjYKlX
         CdlfJnpWemhisMkcl4emnlfoDVeIenP/eyZ3108U5lUz6DCUywoEzVL3W4t6o4LMIP5v
         /0gG0/fRAlNjxchIVn1RobAVHp2hJKEs15C+1QB59RbWXSvRqxwHJDIaN2cpwTXimCAO
         1wgAIFHPu/db3SoYpPc42/nK1BK9T7s0O2fwXe30NVZEOMQtJ7puLnpJ43LiBkK17YoC
         xyMWxq1GKCi499vWg3qrSAD1m3xnJe7hECkhxo2p5KGd6XmKxeD+XKrX6nV7v7F6be9W
         VjSw==
X-Forwarded-Encrypted: i=1; AJvYcCUlTakbeZUj1li0dDue3iKdV9w9gcvF4OS0Q3G9XS73mF7Jmv8t/H6kZJwEbKzufaZdaqB3sNg=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxHnJjWGqn3jftx7fWY27j373R8wPGZcgR1wwR7OYnw8WeuTCmF
	yioxz+9wiTdqNX0I6dI2Jil0BsXMBakDOm4P0BHp362tB0sQmEVy2sQ/SCeMroAKnNE8zKBi462
	yE8oCpOup8i8qKC9FmH9152Hrv7KCfH10n+Oq9ZUee3eV
X-Gm-Gg: AY/fxX4PVp8HFIwmHWZv3+8QuptK3lCOq7ROWO1ISOGIPL7CqTyY49jv25lYOzZZOHA
	xSlFSTYOLZ6U/G0/TXfPgT0kKQZ8BiYp9hWscoNrxWEbA4f4y7XNew2wrgJnRQ3Y+BUZ6OgM5D+
	4KPyXjs5+HgKZdbSCcdE9CQAmAE4AI4E3XIPulewE/0jIb5LeKRqgdeXpVZpkmc4SFim5+OnCLd
	7xNaP4PnxLk33qRrN4Z6+90ZOGw2HxUuNNnvZfwHFlbAfpAOHfqRnE93bCfTBgs8fCwPvQy5fVD
	s5ykDEcxqHN1ed6OdRHVimqgoA==
X-Google-Smtp-Source: AGHT+IEMgsYCEaejUCdRz1sFVJJFyHx3BrnIrdCUbB11wMQOevmpe/rOaRtrABvM7gz2Me7LPQlUE3P0caYucuHtfEQ=
X-Received: by 2002:a05:6820:1626:b0:65c:f583:d3cd with SMTP id
 006d021491bc7-65d0eab7e3fmr23544956eaf.55.1767609889583; Mon, 05 Jan 2026
 02:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20251208020844.5310-4-krzysztof.kozlowski@oss.qualcomm.com> <ebaf9e48-07c6-4b00-b773-312e0c9a8e21@oss.qualcomm.com>
In-Reply-To: <ebaf9e48-07c6-4b00-b773-312e0c9a8e21@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 5 Jan 2026 11:44:38 +0100
X-Gm-Features: AQt7F2pJVcziQCylElUKsMUche4vaefoDeBwc087wyFI1gv6lzxDTfIojMTspwk
Message-ID: <CAHUa44GU=Hb+L4St5Ryeh4AV-SAWBbzH-npEyek=TT1KPw2Awg@mail.gmail.com>
Subject: Re: [PATCH 1/3] tee: qcomtee: call: Fix confusing cleanup.h syntax
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.43:from];
	MIME_GOOD(-0.10)[text/plain];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.43:from];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 45F154FEB0
X-Spamd-Bar: ----
Message-ID-Hash: XTRUGQ5WGPYDPOGOYF7PKI7FQWCWCQTW
X-Message-ID-Hash: XTRUGQ5WGPYDPOGOYF7PKI7FQWCWCQTW
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XTRUGQ5WGPYDPOGOYF7PKI7FQWCWCQTW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Sun, Jan 4, 2026 at 11:42=E2=80=AFPM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
>
> On 12/8/2025 1:08 PM, Krzysztof Kozlowski wrote:
> > Initializing automatic __free variables to NULL without need (e.g.
> > branches with different allocations), followed by actual allocation is
> > in contrary to explicit coding rules guiding cleanup.h:
> >
> > "Given that the "__free(...) =3D NULL" pattern for variables defined at
> > the top of the function poses this potential interdependency problem th=
e
> > recommendation is to always define and assign variables in one statemen=
t
> > and not group variable definitions at the top of the function when
> > __free() is used."
> >
> > Code does not have a bug, but is less readable and uses discouraged
> > coding practice, so fix that by moving declaration to the place of
> > assignment.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.co=
m>
> > ---
> >  drivers/tee/qcomtee/call.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> >
>
> Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

I'm picking up this.

Thanks,
Jens
