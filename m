Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617A1CF45C9
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 19:40:36 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A8DE44328B
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 19:40:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YrNgBzsU;
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 04FBA4327D
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Jan 2026 14:46:40 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c9edf63a7so5248334a91.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 12 Jan 2026 06:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768229199; x=1768833999; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xjc6M9tmGl5hN1Yu645jKd7QvQ8TOMfGzm863v7vtE4=;
        b=YrNgBzsUHMm9s9cHePRTjxGI2yWs07v5BONKDqWtokQ4xyev0p5NoFBNZD+0a6OOT8
         8avreRVWTQWIv1k6nLDF6Ojm/RxIm8OVqwZ09lpP0LbtEycPhjiHfp+bj+gYmQtiM+vw
         5U+tT0gXdYNqjVst1Cm9K8DTny01pSAXkromr66IKGFtJrnAE/pRaSN049NmOYkKosHr
         w/1ewMLx8GCGMSePt4H84Mosca6irrgXxYW4Pp91rSDxwwOIFg2bfDqhm5/RLoVCoSHQ
         YAMlQLj9/FikPUG1UPCnh2LYUvPtRwnzFPoJL4vqmicKDBOgssb9N3totoWYFazLJQNs
         HDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229199; x=1768833999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xjc6M9tmGl5hN1Yu645jKd7QvQ8TOMfGzm863v7vtE4=;
        b=MXS9EoI0CyGO+Pb1AxbhjSTW4w0dFHp/P37BwKt8ctlVJU8DS/UbYmAGVPddLMYcC7
         rGr9R7DvpHhY4zzEd07v8ApN6G46vMxZHyag5wO0k12TciJq9BpZMIrosHksjrajkQdO
         H0oZSzUw0o1R5UD3P9G9xGTGz+HUsuWet8Oe095nyuwcjoEjucTjuq0Ft60JvLQfbbCD
         tMorwipyrGyS3ywjRrI6MfOoB5wKJtgArZVM3X6FhJrvQg0NVEipeXKANS587X4fCROR
         xi4NaBVfl/SITTmqJDes/JLDxf07GHGtn/DQihWDbCxNYX5WX7VR8KbW0VfsA7tg7Rdb
         7bjw==
X-Forwarded-Encrypted: i=1; AJvYcCX+M43qjN3NQCOTpy3Tl/AuDxeyn9ScASbkuqvJ2JhAP8Q0lY9ttPQPVFta6utXVYrCRkR/fGE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwgCzAO6pJMCJqNRFkQWUIi9104eY832ITToHOY4gTY8Vta/zyS
	Y7uYiuhF6s+epNNd8Rs/GFVcxojxNg4Ohkk/GwWP8q6UtSZJROdws5hkZLTAG5bokzynPrBoVBY
	t3whThJpZjHJ0GuJnXWjoVhd9iCCBWxY=
X-Gm-Gg: AY/fxX58Mm3cVcN0cqcANfKdkSNJF0d+nvGsSOcuTI3XpgCCiAXSDzNrUSvK6tcCdVS
	UeF4mVc0iAffXeTCwDl0U9F4f3Kl+5OYdZPpJX3PKzwyudlvVrhHomGVs/nY4JIxO0wPLdbmKCC
	3fZ0JMszqBX/X7zYGBoLpNyLYkYtohrSnOERhAzhNxF01Wg/cPUwjt5wY7QSmUcSikZlmfIfW/m
	C81aAl9lvl5O23sXBHVPBwAXQQOBeCR+Rp2fxKuqQjkdxbEJ0APGKTAbmXGbqbvVmrQLLpRHBXn
	NqQaRpQDqIq2RZfxvC+52/IwwtLBS+zgoz84m4Yb
X-Google-Smtp-Source: AGHT+IGK1mIUb34t+JTkSSvIdWLdzisbXFU4RsJq4tdtJrHuJ2qQ6EEQfxsl1/i+NVAqAeTOmevUDpjDXGsQz4C25GE=
X-Received: by 2002:a17:90b:5628:b0:34a:8c77:d386 with SMTP id
 98e67ed59e1d1-34f68c91bbemr16314050a91.9.1768229198734; Mon, 12 Jan 2026
 06:46:38 -0800 (PST)
MIME-Version: 1.0
References: <20260109154442.421248-1-coking@nvidia.com> <aWTaUvGu9dlvnJO9@sumit-xelite>
In-Reply-To: <aWTaUvGu9dlvnJO9@sumit-xelite>
From: ryan foster <foster.ryan.r@gmail.com>
Date: Mon, 12 Jan 2026 06:46:25 -0800
X-Gm-Features: AZwV_QjEJFTH8Bbgk4_6aa1ffC8HADv6P0jGsrQmwQ15AeggtFLkF1CcB4gKQZg
Message-ID: <CAHtS329G-H8vVVr==DZUAetzVNc4couN2OV3tH7qH_7YDGe8xA@mail.gmail.com>
Subject: Re: [PATCH][next] optee: make read-only array attr static const
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.216.44:from];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.44:from];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FREEMAIL_ENVFROM(0.00)[gmail.com]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 04FBA4327D
X-Spamd-Bar: ----
X-MailFrom: foster.ryan.r@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: XUREL4XVOEOLQPCLIUBMAMQSGF5RLGAZ
X-Message-ID-Hash: XUREL4XVOEOLQPCLIUBMAMQSGF5RLGAZ
X-Mailman-Approved-At: Mon, 12 Jan 2026 19:39:40 +0000
CC: Colin Ian King <coking@nvidia.com>, op-tee@lists.trustedfirmware.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XUREL4XVOEOLQPCLIUBMAMQSGF5RLGAZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

This looks like a micro-optimization, const makes the lookup array
explicitly immutable, and static keeps it out of the stack frame,
avoiding per-call initialization.

Is there a style preference for read only lookup arrays here, e.g.
Should these variables remain local but not static, or should they be
moved to file scope static const?

On Mon, Jan 12, 2026 at 3:26=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Fri, Jan 09, 2026 at 03:44:42PM +0000, Colin Ian King wrote:
> > Don't populate the read-only array attr on the stack at run
> > time, instead make it static const.
>
> Is there any value add to do this? AFAIK, the static local variables
> aren't preffered.
>
> -Sumit
>
> >
> > Signed-off-by: Colin Ian King <coking@nvidia.com>
> > ---
> >  drivers/tee/optee/rpc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > index 97fc5b14db0c..1758eb7e6e8b 100644
> > --- a/drivers/tee/optee/rpc.c
> > +++ b/drivers/tee/optee/rpc.c
> > @@ -43,7 +43,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct t=
ee_context *ctx,
> >       struct i2c_msg msg =3D { };
> >       size_t i;
> >       int ret =3D -EOPNOTSUPP;
> > -     u8 attr[] =3D {
> > +     static const u8 attr[] =3D {
> >               TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> >               TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> >               TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
> > --
> > 2.51.0
> >
>
