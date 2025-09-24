Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC8ECAC5A5
	for <op-tee@archiver.kernel.org>; Wed, 24 Sep 2025 09:22:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 576F9431CD
	for <op-tee@archiver.kernel.org>; Wed, 24 Sep 2025 09:22:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lpEfam0r;
	dkim-atps=neutral
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0091D41881
	for <op-tee@lists.trustedfirmware.org>; Wed, 24 Sep 2025 09:21:47 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-62f5f5cfc58so1394695eaf.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 24 Sep 2025 02:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758705706; x=1759310506; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxVruqv640FOouJsJqQA7LKvaemFmmPlp5hTqabzSp4=;
        b=lpEfam0rqBagKgqgX+SLlVdEeCYsVeJJ9WRBZOmBmT88f/ZUHQM864OPrFRyeJ8WV/
         ipCiGv+fr24pGt25Znlu/0DYHnCbVHHayHKTnIHF0ClDm0MP/LSzJNbx26ztycFhl909
         6JRwI/9htsbeEeaNbEKG6f1XWW6plPFQ9DlJ96C39CzTJstUCMevbl9ZoUVzKjJy7nM+
         9fPXQ+rWL6hb70XdzOuGKW3k+sb03GXAFUFe7IB9+k4K+ds+GuysM2rFLly6R6OP3c0V
         kWF9TTD0MPgX4Nq7p7QdhxtEvTPWlsqabv35w8aiY/v0WemKtuFuWtuaQU7A5f30IH3e
         1p4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758705706; x=1759310506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxVruqv640FOouJsJqQA7LKvaemFmmPlp5hTqabzSp4=;
        b=ha1eeQP+j5iVJxEvjRtuEAMZuWqQf2277SXfE4Srav+HaGdb8KsPb42drI3i6x7Lux
         +3EEQFS2Wfk6MrFweTtotS/zjlGhL2k93fehwCDhEd0Q1SjN7P+CGEPurr70fw/ijW6N
         7u9vsJ5q5fowWNkkSbmE7wz58Lpl/dKCyClnUyiAUVe2VC6jTZpUUt8kkKkERQxIEcGj
         MgrnfUZATK4feA5WJIXLrf76G+ovWCVhk4Uva4eD8XzouCQfixv5JA3VlbIIKbQtSgmo
         OcosFtsaUs+d5quFisvsC1VTVo7nfVgK5ndwj6jyHEkLVYgazAre6HPDWKTFN63GfERQ
         K0qA==
X-Forwarded-Encrypted: i=1; AJvYcCXHwX/akbsT0grnTAtUo76ddqcVnSBFwqXOMXRMdvJA4VkVTMtFWRGdIYfB6QqwQnzkXnjjleo=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw/SVbOf351058Qok8c1TlXV8imxMm1M9aGR4AD8+Su/eb65F3Y
	YFtqkp/qwzYLr5IsZlCVZydPhfNOQXXNnr8HTLiyz/a4hvtvS8m4Dp3ehbQBpRkk/MAHWG1OVwd
	oRrTNVSVTnMAqyCsgj1xkJ8YwUBGnMWM4xsED74ur+NLZ
X-Gm-Gg: ASbGncuQYtxXOOqUkdfCErlaQtwD786a+q0dV6Nm8riW/bQk7JEbSjnTnI6qdBrE/lf
	EC9zVZ4CQon3NUzjwrdHQ5ha/1cbHI8eBxzrM4s+DnIlXx4hMCg68wJJjXnqj6FI+3bZuYK4GPY
	Y1yILcJ0z+uvRaZ2vBb0cSahJmB1caGgFXUwWwLtWXGv4c0KrscnijsBohgGZIleBhHZ2Ox1Dx5
	6yscPdG
X-Google-Smtp-Source: AGHT+IF9MUcsTpqeMRCCkmOByiXncoZ6aC5AAkRn9kos4HYZSgn1UCyuiasgjldg/eI9Gic3np9EBS9bfwc5jv78a7A=
X-Received: by 2002:a05:6808:17a0:b0:43b:516a:6a3a with SMTP id
 5614622812f47-43f2d4a0853mr2953120b6e.46.1758705706106; Wed, 24 Sep 2025
 02:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <aMvV4kK386Sni10i@stanley.mountain> <adbccfc0-0f9c-4b71-9fb5-5582c8180ac7@oss.qualcomm.com>
 <bb776102-310b-4a84-943a-86d4138592d8@oss.qualcomm.com> <aNOfXlG21HIBR18E@stanley.mountain>
In-Reply-To: <aNOfXlG21HIBR18E@stanley.mountain>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 24 Sep 2025 11:21:34 +0200
X-Gm-Features: AS18NWBAFawQ8-QtJaveVkFxCVFVwvIAoDOcJ1zhiDc0CJ08YKpktCHoZXO_RhA
Message-ID: <CAHUa44G2yaB28sd0FjkjyCNJKXjx2Jg9j-9HXytyvsmiQ3ThAA@mail.gmail.com>
Subject: Re: [PATCH next] tee: qcom: prevent potential off by one read
To: Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0091D41881
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.46:from];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.46:from];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: FJBSNAW3SOFVFX47AK4LDTN533N6KWJG
X-Message-ID-Hash: FJBSNAW3SOFVFX47AK4LDTN533N6KWJG
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FJBSNAW3SOFVFX47AK4LDTN533N6KWJG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Wed, Sep 24, 2025 at 9:36=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Wed, Sep 24, 2025 at 08:58:45AM +1000, Amirreza Zarrabi wrote:
> >
> >
> > On 9/24/2025 8:48 AM, Amirreza Zarrabi wrote:
> > > On 9/18/2025 7:50 PM, Dan Carpenter wrote:
> > >> Re-order these checks to check if "i" is a valid array index before =
using
> > >> it.  This prevents a potential off by one read access.
> > >>
> > >> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> > >> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > >> ---
> > >>  drivers/tee/qcomtee/call.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> > >> index cc17a48d0ab7..ac134452cc9c 100644
> > >> --- a/drivers/tee/qcomtee/call.c
> > >> +++ b/drivers/tee/qcomtee/call.c
> > >> @@ -308,7 +308,7 @@ static int qcomtee_params_from_args(struct tee_p=
aram *params,
> > >>    }
> > >>
> > >>    /* Release any IO and OO objects not processed. */
> > >> -  for (; u[i].type && i < num_params; i++) {
> > >> +  for (; i < num_params && u[i].type; i++) {
> > >>            if (u[i].type =3D=3D QCOMTEE_ARG_TYPE_OO ||
> > >>                u[i].type =3D=3D QCOMTEE_ARG_TYPE_IO)
> > >>                    qcomtee_object_put(u[i].o);
> > >
> > > This is not required, considering the sequence of clean up, this
> > > would never happen. `i` at least have been accessed once in the
> > > switch above.
> > >
> > > Regards,
> > > Amir
> > >
> > >
> >
> > Also, size of u is always num_params + 1 for the ending 0.
> > (basically means `i < num_params` can be removed).
> >
>
> Yes.  This is true.

So this patch isn't needed. I'll drop it if no one objects.

Cheers,
Jens
