Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837C3105A576
	for <op-tee@archiver.kernel.org>; Thu, 12 Mar 2026 11:16:45 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C0E9C4395B
	for <op-tee@archiver.kernel.org>; Thu, 12 Mar 2026 11:16:44 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lMa2cZGP;
	dkim-atps=neutral
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 23EFA4389E
	for <op-tee@lists.trustedfirmware.org>; Thu, 12 Mar 2026 11:16:24 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-466ec4c6852so523973b6e.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 12 Mar 2026 04:16:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773314183; cv=none;
        d=google.com; s=arc-20240605;
        b=aisBRfKd7zR6god/UkQNDsXp3Oahxb4hDMHbYZWkDd3G8X7FwtpCmXzkVtO83neim0
         DQ11iQz0zn0StfOlvoIikk+RqnL8g3lLxiHnNMSZnA2WQPEc/45gYVX6MOOeoKcpt+Pg
         1HQ4aexESYZWeVuNF3pGbSdwdlUG1szt4QwfTPDz8AqhF4T+jfa0jDfYhpnJFdTmPJh1
         iI16gI02xMDr5A/tmQG3Jet76NvbIAK+NxQW28bnWhe04JMyPKQar8siVtStem6D1uRF
         Ue2cIgVwidOfEY2/cItbANOfkCSCDdok8U+uD+exFmvmgMvGAS31t/vbjJUF9zHbxWeM
         1voA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qtM9Diom4ZTvfvYrQoGnGjrc7XlzXbXwUOmWSlNnISk=;
        fh=7knbIp/uD+1bW7rNZqAeMtuA4VlYRZPOUwfeb6JREig=;
        b=ecAmP0v2mnNpW14N8Hz1HzKoNWu6lrYTxqfoo6iBTeNsa1mrF7cOpG93JNiPrp3O+S
         8YwEKft01CDAYc1OYP5pZFwwQYNgyY76Hz2WpYl4e/vQrWvypbHehO5ACB3xK9HjdCo5
         9ZqzaE11piiOFOJ1XoBTLjZnkijSWqAAFtMJ4q1ugQS/y76j1QAPwTN309nXAvfi0Bpb
         86ByPh3TradLoG/wpsvWp991qLvulKqISBCo/8+jv0DZA9BmJ3zmvMGqoTsTpl5880WZ
         hU++IB+dxhRAwFc1M148oIH5oWyfekuIiVnfH4lSS3C4rH2vPAXlaJxw2UFGh2DLxzFV
         Zbjg==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773314183; x=1773918983; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtM9Diom4ZTvfvYrQoGnGjrc7XlzXbXwUOmWSlNnISk=;
        b=lMa2cZGPhnQC2k/mTEpPL8ngTgIdmIkaoTHCRRw/x+NspgEu/wyjhgZDgpBXCIi6MV
         SXrZgUYmFua0caQK2im23iSRxmBI3di0eGSgRXYpBlxdA190Dpk1wGrCnGQ46sSGMt2t
         lH8iUts0Tm+AIjnO8XvwGse6XtXTVI0wRpJVttF/Uc29yhcdyBeG7Sjg+VCvA2YursrQ
         ho267b2wx6gbnm6C1WsYpiEQ9Q/KypCYYoxjzk0S5/50HgUZB7TSmWJxYLcy0KjiTmJM
         gArwboxRTqelI9FiDFQqFf02HmQr39sDoOJW3VxGikxscJrgm95NodwG6EUbEsAM0+gD
         VC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773314183; x=1773918983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qtM9Diom4ZTvfvYrQoGnGjrc7XlzXbXwUOmWSlNnISk=;
        b=tWw3c6rps8ysxVS1TfxjY5vHD4Y2AL1TihtSW/KANyZHve5dSBXl5SZ7YqcxUcQJCa
         lomaPGU5MHXtv/sLhiySKR3Uc3LwnbWUzg5+6MrqVog4TAljVn6lad1lyvsz3/lj3h+f
         lL8iGKh4wmJnVE+BDy/d8/ALRNr62/vTYS+F2F3jU0tuAdexNb2uhQ520yBt4YkBVEEO
         Kbwd6tdKZNXTjuFOeBeYwj7WrMIuiGhhUEpporOs5tVS8qSN6Vy4UG7TnO7LMv8BdaHv
         2ShozPW7fPfo9cM4H8FGwbUqsbGSGWc0/wFrNMJZpVSAGfm9mX/aAwAE5YLHef1RoACj
         rXww==
X-Forwarded-Encrypted: i=1; AJvYcCU1RceBHUVEOZmNdzsKWkHpmHIH/SOwhR17KBIn6+L4CFWGSl6/OlQBwLpW2P+/h1n0qPX5UJQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxRnfIjN6SSgZdh2tkwNInr8VNj2yipILkb7JfwCNpEcG4Glxro
	HUonSx2syUoTBqffPu2Eb0KTqKTZVkL20CiuUgtVgy1mjeqCq79+uzKvwla8XaZqXCgbfB9pJLp
	v8+ihRvMFGICNG2KyQMyn5pBB2GUiw3ZG2ompV1/SGIxq
X-Gm-Gg: ATEYQzwSbHgXms7YnPoTnVTyY00XFAU2D94Haidu8U1T2JV0XH7oI9h8aawJV7VELAH
	I937j4mfEUTQLcgXOGitrGNEOk0wiQSB1vY5F9I6wKOKjfXwY9AofbIvJqhjOhR8C7VfipMw9UK
	59fbW2gF1MbUklD7IKXboc4RgktX6BbqMhpbdIR0Y2tAJ7jG+EV9Lv7tF8YQPxk6cY9aEJsSv6l
	dsyAo0xPMPullOaRxSkAuxIoB42ZYqH7o+IsYYBf9j8vecqU+3B20HyrtZH3HaYtadFR2rCeZ6I
	0r86CYEZ8NGY7zlp7Z8ZI87USKg2uYLgp0lJ1d0=
X-Received: by 2002:a05:6820:c307:20b0:67b:ca95:fb33 with SMTP id
 006d021491bc7-67bca96028bmr2445853eaf.59.1773314183390; Thu, 12 Mar 2026
 04:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260305083312.1040969-1-nichen@iscas.ac.cn> <2e15b2b8-7dd4-4e63-b9a9-a664323ebb36@web.de>
 <abKEdk6MpkVHBlfi@sumit-xelite>
In-Reply-To: <abKEdk6MpkVHBlfi@sumit-xelite>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 12 Mar 2026 12:16:11 +0100
X-Gm-Features: AaiRm50vN4AQnVsBykx_LBopda0I2RdX1xi-uhZ6MXIDd5wNPLJR__kvVxi0q84
Message-ID: <CAHUa44GkZ3jgJg=s+a4RnvMggCxu+mVhU=0z3BKWGkHqDKGaSQ@mail.gmail.com>
Subject: Re: [PATCH] optee: Check return value of tee_shm_get_va()
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
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.182:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.182:from];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[web.de,iscas.ac.cn,lists.trustedfirmware.org,vger.kernel.org,linaro.org];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 23EFA4389E
X-Spamd-Bar: ---
Message-ID-Hash: UYRUOQNPMT6QJV4F3DYHR6N5E6U5FHET
X-Message-ID-Hash: UYRUOQNPMT6QJV4F3DYHR6N5E6U5FHET
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Markus Elfring <Markus.Elfring@web.de>, Chen Ni <nichen@iscas.ac.cn>, op-tee@lists.trustedfirmware.org, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UYRUOQNPMT6QJV4F3DYHR6N5E6U5FHET/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Thu, Mar 12, 2026 at 10:16=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org>=
 wrote:
>
> On Fri, Mar 06, 2026 at 12:52:39PM +0100, Markus Elfring wrote:
> > =E2=80=A6
> > > +++ b/drivers/tee/optee/rpc.c
> > > @@ -393,6 +393,11 @@ static void handle_rpc_func_rpmb_frames(struct t=
ee_context *ctx,
> > >                         params[0].u.memref.shm_offs);
> > >     p1 =3D tee_shm_get_va(params[1].u.memref.shm,
> > >                         params[1].u.memref.shm_offs);
> > > +   if (IS_ERR(p0) || IS_ERR(p1)) {
> > > +           arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > > +           goto out;
> > > +   }
> > > +
> > >     if (rpmb_route_frames(rdev, p0, params[0].u.memref.size, p1,
> > >                           params[1].u.memref.size)) {
> > >             arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > =E2=80=A6
> >
> > How do you think about to use an additional label for the shown
> > error code assignment?
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/coding-style.rst?h=3Dv7.0-rc2#n526
> >
>
> I suppose here you meant to update the label name since it's the same
> error type used by other code paths too. So following label rename
> should be fine I think as per coding guidelines:
>
> s/out/err_dev_put/

Wouldn't the name err_dev_put suggest this only occurs in the error path?

Cheers,
Jens

>
> -Sumit
