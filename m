Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3B4EB7EAC
	for <op-tee@archiver.kernel.org>; Wed,  4 Mar 2026 09:34:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 30AB043178
	for <op-tee@archiver.kernel.org>; Wed,  4 Mar 2026 09:34:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HCDniXjX;
	dkim-atps=neutral
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5C36243161
	for <op-tee@lists.trustedfirmware.org>; Wed,  4 Mar 2026 09:34:22 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-415e568a7ecso802403fac.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 04 Mar 2026 01:34:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772616862; cv=none;
        d=google.com; s=arc-20240605;
        b=cdSLqNzJWD4AHUpMnOXc0dZ6SOnFKfQH7Mb3MAf/KWdS4B0HzfzuIN7+RwmhvWZY56
         JYpjhX4A88FCTUbMBIou7Hf5LoEpcqJRUM/FZ88pL8KiMzO61km61zs6oPsPPxm8h9WQ
         mIfDJA3FaWzgGJAI+NyFdUGcsZv4rTt+6ouaPBOhKVuUx/4igiujfYMjor8wOd/fO5gd
         rdqV9QihFM+Z6Pp434D+91jcWIqRzlwTtCwXaa/aOkkYaYlCK2gM2ER9G9wU1Z7PGOKN
         FkfwCMwvYXrSLpsaeHSpMX04Ygh6vIrtatSoYZtL0lwgCKV+NfUz2uPMS5PDnumnWgNG
         X5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7hb6fY86/FrgvHUqwzAV8MUgbDVO/vkX1bjsm+eW84g=;
        fh=uJI/ZKZfIpSbr+NWM4QY8lr/Iyb2/dAa5gIxy612s9M=;
        b=YDpYCqBa1ZVBQdBhT4w6m44gaZWAIlHWLSatRWciax9/wrwpuWb8NOScxBqlFJUaCC
         OLwzI3dBMDiG6nJkTVyhqqcOQi9yqbgqRgTybd86DSBiuNd9SA+XN2P8qQoylkTuKHbA
         97ii+khpG5NMoeluVgs1AcxhJkfs36x40OWUeZjI0ZtA27ye7aUlGDkDjuYPxA/XOfB0
         z3a2wvF2pxV8lRP2bdR8xAhypDpsryodjGGdaTkbmzD6TphuhAHV1drPmr5HOJ2YfYyV
         aal+csx/pIX9gsqy80szNhFHeY26AkYVRj6rXDLWw+jALy3h6svpW/zRzpHMBUkxtzkM
         gJxw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772616862; x=1773221662; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hb6fY86/FrgvHUqwzAV8MUgbDVO/vkX1bjsm+eW84g=;
        b=HCDniXjXw+oUPtj2O03hb/U+AHyuNh/QdUhNmQOBOl8Mip50V5OrDwDLVXItGmU/tD
         iv82teOf03N7/7x/ew8uhCRMqBfHgygmlXCy/jpVeNPUsjdzlJ/U6nqPAwtdYgpWS2Vp
         5SV0LbAKnLI6cyiOnzwnvqW/q41B0FWLeU75oHxs01ZdtKm3PEzrXJR/GItMCnRVQ0l2
         FPgoX0hSF9qLo/QoNXxEmMkyDXAyJ4iSiMqGnSS/o10cSqQkgNjWV7ZYZxF4Yk/xT/hi
         CMwuGu4WuX+djstD44Aan8wRHIaGuG4cgvszzaEpMNt8tKFWL9HeqmvJqbmiaRZK1WNR
         0ESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772616862; x=1773221662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7hb6fY86/FrgvHUqwzAV8MUgbDVO/vkX1bjsm+eW84g=;
        b=aoEqTyr++EtRBYYM/U58f3QmZ3UxiXOz8CXGi6sdiOG+i+rXmsVVIhiTL+hbDeh7hR
         7pWVB37/06vM+FG0QmhlA6/EOgJZqMw5g7L4rmdaWJ6hxG77ztOKLW4XWeAIFqfyyqgq
         sKCcOXuMF2aPdGvR+UxMoawiCbNnzXBC1ALgs/kDyMZP6W2jCzxzitam2qu+pz9Smk9Y
         YlVLB6/8+sR5FaJoQDkH8kp2jxhgODwUolndJxM6kHVd4jOQYtGO3M455amaXEQItMTO
         Sns/rELeJ+S9DM1y5fKFOGxPyNSS4Ka9/KC/SJLF60vsQtrLF2u78ncpCtiFOTvwLxWE
         6szw==
X-Forwarded-Encrypted: i=1; AJvYcCWBsYwczxJrzHSjaDw/R/2sJcBm6Z6933yMscohHJVfVIbT1jF3mIO4i8JCx73BqTiTMDx9EjA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxvKo209/ieHmMPhUdrUDL7o4TNMSBfniujdNWGqHVzC6THqc74
	WU6QQoawqRq1I9kyXaC+TeVs1PwtKruCscmR7R/Xzx9itrLsQUkVC0UxvVqkRpZo2GNa+BYTCIL
	UCBGRISPUcBcTLV/ebvIyvE9XFVqKrqL18DNI2xVEpoMH
X-Gm-Gg: ATEYQzyUMSloTDGEjCYp48azRkX2beiHKaHr88HVE4GbALpnGOM3UIg+LjuVJU1ixil
	15MPSBJOG9vdttUpsi2s5UMxasvX6e7KjKSnxuX1tQWYX9bF4ER9r+sEFw1NXzoHYKaihVgvnlQ
	LIypUruOyinfc2VH/lXDPhx4utYoI4cj3uSjcYyj2NZ8H+Ne8AxFCnSYECzo1YFDqFwo/RXQ5Fr
	zSUa0oV9DtrnD9e3SW4GFeRayDXzp1Tf8XPI9wvx64CkeVu2UlWR9RjOrxPXhQ3S/1YnOmjgmoz
	zt7p+3e5KmQ64dN5zxxDQdE3NQ/x43Z62BWyEaPNlqIV0wcL
X-Received: by 2002:a05:6871:112:b0:3e8:8e56:671e with SMTP id
 586e51a60fabf-416abc3c442mr740209fac.54.1772616861704; Wed, 04 Mar 2026
 01:34:21 -0800 (PST)
MIME-Version: 1.0
References: <20260126-optee-simplify-context-match-v1-0-d4104e526cb6@linaro.org>
 <20260126-optee-simplify-context-match-v1-1-d4104e526cb6@linaro.org> <aYrAeEiqG7iwXm_w@sumit-xelite>
In-Reply-To: <aYrAeEiqG7iwXm_w@sumit-xelite>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 4 Mar 2026 10:34:10 +0100
X-Gm-Features: AaiRm52FcW-OAyIi-wAaObIfx0MwPHh0zbRqzlqQxviphSbb0F7X9gKg8pS94SE
Message-ID: <CAHUa44G1+C47KY8UCV5+ype-NCjYPfgxFs_tivmsOA=R-H1C8g@mail.gmail.com>
Subject: Re: [PATCH 1/3] optee: simplify OP-TEE context match
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.160.44:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.44:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5C36243161
X-Spamd-Bar: -----
Message-ID-Hash: Y62KJOHR4PYJYJQIUQKYK5YULK4LKKJU
X-Message-ID-Hash: Y62KJOHR4PYJYJQIUQKYK5YULK4LKKJU
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: rouven.czerwinski@linaro.org, Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Y62KJOHR4PYJYJQIUQKYK5YULK4LKKJU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Tue, Feb 10, 2026 at 6:22=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Mon, Jan 26, 2026 at 11:11:24AM +0100, Rouven Czerwinski via B4 Relay =
wrote:
> > From: Rouven Czerwinski <rouven.czerwinski@linaro.org>
> >
> > Simplify the TEE implementor ID match by returning the boolean
> > expression directly instead of going through an if/else.
> >
> > Signed-off-by: Rouven Czerwinski <rouven.czerwinski@linaro.org>
> > ---
> >  drivers/tee/optee/device.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> > index 950b4661d5df..4c85b04d6004 100644
> > --- a/drivers/tee/optee/device.c
> > +++ b/drivers/tee/optee/device.c
> > @@ -13,10 +13,7 @@
> >
> >  static int optee_ctx_match(struct tee_ioctl_version_data *ver, const v=
oid *data)
> >  {
> > -     if (ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE)
> > -             return 1;
> > -     else
> > -             return 0;
> > +     return (ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE);
> >  }
> >
> >  static int get_devices(struct tee_context *ctx, u32 session,
> >
> > --
> > 2.52.0
> >
> >
> >
