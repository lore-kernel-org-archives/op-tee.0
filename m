Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179E8CAC59A
	for <op-tee@archiver.kernel.org>; Fri, 19 Sep 2025 07:59:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 54F9B43102
	for <op-tee@archiver.kernel.org>; Fri, 19 Sep 2025 07:59:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=M7SLbBmM;
	dkim-atps=neutral
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 18ECF43190
	for <op-tee@lists.trustedfirmware.org>; Fri, 19 Sep 2025 07:59:25 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6236479c8d6so939839eaf.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 19 Sep 2025 00:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758268764; x=1758873564; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASDqAkH4cmxDPZSFWYENHrs1T7W+4jRPHJP2+bsh1GM=;
        b=M7SLbBmMdZyT3YG6hJnMNGy4NhodlQ/mxO1nBmCaciaC7XtNBdxVtPx1xWn9JUCQPw
         NAVjIWLNKGbs3i7C+15Sb1g03Cf9GCfj6EVmswxa7UZYLPMRqAMakgZP7TomQD8RVRke
         WGakb0eqUq8lx1y3JQMraX8aaleEk6hapeOYI5Slqyy6i6b/vJ06GDhqpvLb94RCknHx
         ILvoRt3gXaTCpG4MLR1662xLvRsU9yo882NFtiaE9al9Bm1BqRW6OwHiXTqiRCir8j/x
         rUmHSNx16kdh6uljs2S3/hs1tjowTev41wXZsC8yvxqrB7wreQ1iysZfN+nkn27gSi7f
         njnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758268764; x=1758873564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASDqAkH4cmxDPZSFWYENHrs1T7W+4jRPHJP2+bsh1GM=;
        b=aUlbAX0GGS/lRah3XPz8nHwk8+1hVclEyuWSiIcajsOA6oRFQIuGyQHDuDl+s3PCId
         2DdxQkaTCZxAl80zmZJ0lpz5rTd/sKqf1jNLw1yTaqezSDEEb87M6zF8NNtn5bG1Q1k5
         SOObrEpQOEElX1XpTCAH3mqI1C4qkd/xMIk3DZ07r1vQRbBb1SoHmFU0wdsxUSOIN0cw
         Kzj6wDhQomKnanmuNQUzqamGSgDy3vt729zQGUtuWeRwEemsQsxpH9oxLcBJ06ms1/la
         2GIHctaGyktuTFStnsovYnWa9D1dMmTF8rQi23MEdhgdNZhX/4rpsa/0AZMpimnmHqPm
         HA8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoPAsf8UFrbusFS0zyQx0czIYmXRSXH4a/4Z2M5w9Kzzvsn5k6Weg/i3yqXQ1htX7iteC+2FI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzYPT0U2oVOZCWCp00pVW6eBvRukFtWJWy9buOoDLdPAsdYtq4l
	IK1pqzzMVOoc5u37uxyGb4iU1Ry++Q0fiusUf4/5AsItSOyl1r3wMhg9CXpvy9gTqGqPdLeburf
	8uHpIzKZbQ4P0dS6dk1q5kQuYK+gSsRzjFXMaCWLYgP4k
X-Gm-Gg: ASbGncvrU/A6lJ6+UdWPh9eu+Nw8dW86B1pJ4k/8aBQ3wLqKzRtXMK1gCVmfIH5Ls6w
	d2Wpt8WPVs3CEf1Ib03+Jyg8AzvKuxpi1YljCSCdCvic7vDs4DQmjsWIgOHhVK1nwbd8j+uhLPP
	nbUWhArv1MjaHWYwpEZOwxghXKDsyAbx980kIZTAqgIAfC95MWZx/0m+JzPS6bY1WC8VucSstfk
	gc227qd
X-Google-Smtp-Source: AGHT+IEekOH9/D2Na5uJOAYH+Gd3gYDqTSm7RjBTFazB5QY2j1Nx/k/QnGRih+TMOqi+VBgoo9dEC9T1EDeBavQpFxI=
X-Received: by 2002:a05:6808:5094:b0:439:b674:d9a3 with SMTP id
 5614622812f47-43d6c26736fmr1011006b6e.35.1758268764408; Fri, 19 Sep 2025
 00:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <aMvV4kK386Sni10i@stanley.mountain> <aMzoPc67ws5NMpKS@sumit-X1>
In-Reply-To: <aMzoPc67ws5NMpKS@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 19 Sep 2025 09:59:11 +0200
X-Gm-Features: AS18NWA3C9LQrIakhvqgeKImPW9n-BTnckAYGagXPywalztGB_Wmp1fHsBSux6w
Message-ID: <CAHUa44G96pdFL+08Rn8yr_5fp2MpUCjLAUsUcgprnrZCcSyLxg@mail.gmail.com>
Subject: Re: [PATCH next] tee: qcom: prevent potential off by one read
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 18ECF43190
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.45:from];
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.45:from];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: K5OWV65SGKJEMBHD7PHLJFFJLTKOAP6B
X-Message-ID-Hash: K5OWV65SGKJEMBHD7PHLJFFJLTKOAP6B
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Dan Carpenter <dan.carpenter@linaro.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/K5OWV65SGKJEMBHD7PHLJFFJLTKOAP6B/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Fri, Sep 19, 2025 at 7:21=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Thu, Sep 18, 2025 at 12:50:26PM +0300, Dan Carpenter wrote:
> > Re-order these checks to check if "i" is a valid array index before usi=
ng
> > it.  This prevents a potential off by one read access.
> >
> > Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/tee/qcomtee/call.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Applied.

/Jens

>
> -Sumit
>
> >
> > diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> > index cc17a48d0ab7..ac134452cc9c 100644
> > --- a/drivers/tee/qcomtee/call.c
> > +++ b/drivers/tee/qcomtee/call.c
> > @@ -308,7 +308,7 @@ static int qcomtee_params_from_args(struct tee_para=
m *params,
> >       }
> >
> >       /* Release any IO and OO objects not processed. */
> > -     for (; u[i].type && i < num_params; i++) {
> > +     for (; i < num_params && u[i].type; i++) {
> >               if (u[i].type =3D=3D QCOMTEE_ARG_TYPE_OO ||
> >                   u[i].type =3D=3D QCOMTEE_ARG_TYPE_IO)
> >                       qcomtee_object_put(u[i].o);
> > --
> > 2.51.0
> >
> >
