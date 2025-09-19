Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7417FCAC59A
	for <op-tee@archiver.kernel.org>; Fri, 19 Sep 2025 07:59:15 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9667F43148
	for <op-tee@archiver.kernel.org>; Fri, 19 Sep 2025 07:59:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qtfGRMyR;
	dkim-atps=neutral
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1127B40B16
	for <op-tee@lists.trustedfirmware.org>; Fri, 19 Sep 2025 07:58:58 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-621a3c43df3so789738eaf.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 19 Sep 2025 00:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758268737; x=1758873537; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHJ3UbPpS3D5IfXMLoQP0sFO1NEt5wlea5HnZpiaQh0=;
        b=qtfGRMyRU0MDNqxnjSJ9wpCzaRX3aBIYb38cuw0aMJhCNWAe8GUuKXebYYrUU5GN2p
         +gWAye64werd1LKh2pl0LAPHuFpH3X550h29nPfXTsexWuLMTzl1QbgfDiausqRE8ruS
         B5WW0bFqKV54fJBK/56L+LOaWrnqVEexQrSnxAagzUbvTIt86OiJY+tkrvI1YOvcxF01
         zePm/5RMhbowrOVsgPsMyPl4WtNcUs5N9jH7thlOfoGzfj5iQUPjaud0TZHa1DFBbdhw
         LOe/QUF6vxTBB33TlnCqW2//iTB2Mkns06W5yBV8e5NOxcGNdU2rd0L/q1Y/Xj/m7XDZ
         noiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758268737; x=1758873537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHJ3UbPpS3D5IfXMLoQP0sFO1NEt5wlea5HnZpiaQh0=;
        b=gviLuJstmkuATaMi8Y0Tw6tJnmL5e/YEbua162rSicEE0M0JItjeDeAJlbmMg2a8Kf
         Z3ouz/3IB/gWc8Ka4cmlsjSPmCeAOyUuDuHxlgouAFHvQjvdSOZ/bOhBshRmxYAyitCB
         svmG7hM2eNAMuacznOg5RxjehdKRMbDNgUjpsQL+w5Bu+AjMHyI35wYVrfyiTGiRWR2S
         AT1es5I+sX8mEBD+3dUq7X4jk31BofijNrc3SRbI5UnhUI1KnzuXNs6GGsQLhQcb8GBR
         DhXTqDg+lv1WMZYMufqEPEFyXxDP1rezEU+GFlgIrNNLW1F8Y84lypZRxpWSoDna2raz
         xieQ==
X-Forwarded-Encrypted: i=1; AJvYcCVumcu6sByrO6UOsNQ03SrEV5Ad/dvgcD9zAuTA9rUsV1q9b95mrBw8dGKAK1kgtvd4ffibMpo=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwvUxtc0dJxEtSfAOOIcQO6kwGdjiojEbtoryFvWh1BmQQCGSk+
	LmdWs1u1nEsyKS+mWCXU8LuAgCw36yzou9PtkkAZS1kZHJsw8nAG4trBawXELd0QcWtk+PzD54s
	NeR64xF9UjFNhmj2bPYkenC2d9U/L0Qe5OoV0d8wXjRTb
X-Gm-Gg: ASbGncvrDZoxvJRcnZqGkCzUuuqKsuGX/QCj3mlKZNgQFSkETDUbRG0w1TeLyGm/8dG
	hVOAx5hhJlW0eDiwJehOotQDhd7CakOewyty41ITUFFWIMmLCWjOkD+efym2Qfw5qyu/NmyjQle
	cXt1swcW9bbrBKBcecMp8Afd9Uavq8nDO7QSkYsJfhQ6BCPH8PwfODPNABYWkIrlQ1cqNUA+mY6
	TN+CxrO
X-Google-Smtp-Source: AGHT+IFkd+gNrjrot18Zo5hmp077YMeppKIoRCZvWMh3/mqyMghiA3DIyH1IQhZkyQF86NUjQQnEf00dsGPBqTCeBfU=
X-Received: by 2002:a05:6808:6f85:b0:43d:6b7b:2469 with SMTP id
 5614622812f47-43d6c129f19mr966534b6e.4.1758268737218; Fri, 19 Sep 2025
 00:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <aMvV8WIKnqLN3w6R@stanley.mountain> <aMzodGIvL88HNi0d@sumit-X1>
In-Reply-To: <aMzodGIvL88HNi0d@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 19 Sep 2025 09:58:46 +0200
X-Gm-Features: AS18NWD_RyD3kl7DRtBl_0VNsyLANW3lHRdWn6UrulYuNqtupf3pr3qBMXZkBaU
Message-ID: <CAHUa44HLULAZ3XXimqDzCfG8rc8OzU-ACmv2Gaee7Xbi=w3VEg@mail.gmail.com>
Subject: Re: [PATCH] tee: qcom: return -EFAULT instead of -EINVAL if
 copy_from_user() fails
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1127B40B16
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.44:from];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.44:from];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: FLJPIZN3NARP67L5TIAI54IVLEU67JWG
X-Message-ID-Hash: FLJPIZN3NARP67L5TIAI54IVLEU67JWG
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Dan Carpenter <dan.carpenter@linaro.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FLJPIZN3NARP67L5TIAI54IVLEU67JWG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Fri, Sep 19, 2025 at 7:22=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Thu, Sep 18, 2025 at 12:50:41PM +0300, Dan Carpenter wrote:
> > If copy_from_user() fails, the correct error code is -EFAULT, not
> > -EINVAL.
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/tee/qcomtee/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Applied.

/Jens

>
> -Sumit
>
> >
> > diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
> > index 783acc59cfa9..b6715ada7700 100644
> > --- a/drivers/tee/qcomtee/core.c
> > +++ b/drivers/tee/qcomtee/core.c
> > @@ -424,7 +424,7 @@ static int qcomtee_prepare_msg(struct qcomtee_objec=
t_invoke_ctx *oic,
> >               if (!(u[i].flags & QCOMTEE_ARG_FLAGS_UADDR))
> >                       memcpy(msgptr, u[i].b.addr, u[i].b.size);
> >               else if (copy_from_user(msgptr, u[i].b.uaddr, u[i].b.size=
))
> > -                     return -EINVAL;
> > +                     return -EFAULT;
> >
> >               offset +=3D qcomtee_msg_offset_align(u[i].b.size);
> >               ib++;
> > --
> > 2.51.0
> >
