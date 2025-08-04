Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72ECC87FCB
	for <op-tee@archiver.kernel.org>; Mon,  4 Aug 2025 11:20:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DE7F84FCC3
	for <op-tee@archiver.kernel.org>; Mon,  4 Aug 2025 11:20:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pJb49nJ+;
	dkim-atps=neutral
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 32BC941B34
	for <op-tee@lists.trustedfirmware.org>; Mon,  4 Aug 2025 11:20:16 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61990d3392cso1238637eaf.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 04 Aug 2025 04:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754306415; x=1754911215; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b93u56+uTgiRFAxnBL7fM25U7aghKeWgPbDUdKcg554=;
        b=pJb49nJ+K/Ut8/UAmCXFzPiC5ApqosZ2gx6zj55t49I1RlHYuw0kHevgDf7jYN5gu9
         eSLjLy/jECAudKwdsmMuzrHP2r9du7K92wsWKsGyvAJMvleVIqB9L+1tfsnv+1nhZcj7
         4AN5miSQ9MBgjvv+70hVvMmy5up3v3dHTbYUA0Cm5nbQwabnjYLFQq4+4amDOWApmD8p
         OoBzrG3jlTx1/tGmf9aWSINP288LEkCJ6zvKOByYGhXCfIFnqA0J1C+8ERAf1OzbYQHP
         yZGHXyoeFkEjss29NdFd/ChgRvz8RuKCAmcJyRz34Eq97210K3k2/OY+R8rNHZgVHiYQ
         7Geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754306415; x=1754911215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b93u56+uTgiRFAxnBL7fM25U7aghKeWgPbDUdKcg554=;
        b=dLCkvBr3sPIlnShrw+NE94pIq67txWEHl94DF+KbySvOx0koAP3q+D8MYUNYJdc1Wj
         nI90jJei68rDlTKFBlhNmu/aVHIOsWAgFW/rPUa1Skz1l8FaOZCHFrBXhpHndG/Qs0Y1
         CqDfvrH/ymSrt/kCzjtk3FOlbdsdhrH0+EhUL1uR1g3zRr9R57OxHNI6gb5c0NTusXAN
         NkRt7p3wXyUBG5O1JVRAvjTSZlxdiE/wYFeeruIKGbwGB42bTW/DEIHgKp73kxeYtGwR
         ODIG3QNKfh2sW71swjs7aDSiceo+ki3uSmnizbOeQ9LABBrfYx5fq0E+Mp77Oz1Ka7+M
         a07g==
X-Forwarded-Encrypted: i=1; AJvYcCUgRVfXYBWh6zS3Vw84CKFja0ME47HhwZou+OHzxYv4Ok18TtR0fttzMGg5DW2a+HIbkiKGK3Y=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzCFQgTfYnQREScPP/ekEqqROWm/xUTvBThnGRJWM2MUxOOAsQi
	AoQDD+PA1xC44Lj2fLrKbT5KzoePtodpPI7OI9R88Zrlt+hXFz+qtpg7GbsoFhpDrzKAUUPyPEH
	CtgwDL3FU7RRGn7ya0Bl9K1RVdoMKuupHySFsjTl1a3LE
X-Gm-Gg: ASbGncsg32PKe+174qetzk+5gRXkZcoSCpv2U4VHa1oRjXU5aB8v+SRmBnyaEouJtSv
	8/xSsuWXVwI8YLQhAUS9/822hDBqamsdLPnxZMWUIBpNrQbHbAdZLbH5JC0K2Dk4Pj6Cb3wDct1
	+eT0KBZbCMhABvLEED4Pe6pODeE7CFupa2eV+B3s1h1gKf2caRxNnE8eFGNgj1TPle1YEuf9WxH
	t9eVa/DONVaa8HL+ZE=
X-Google-Smtp-Source: AGHT+IF1oQvSmC0DUw3ocA0Ng4DtG7XWJo3uEaTvvjJ9MizE2sKgbMBq3d8pzwjFzhJxVfr4akPhyv+PF3cPJSGc4jU=
X-Received: by 2002:a05:6820:1e88:b0:619:a040:a61b with SMTP id
 006d021491bc7-619a040a962mr2538659eaf.8.1754306415477; Mon, 04 Aug 2025
 04:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <aHpohUxxSH42w16U@bhairav-test.ee.iitb.ac.in> <aH4c-bAN28Gmq86k@sumit-X1>
In-Reply-To: <aH4c-bAN28Gmq86k@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 4 Aug 2025 13:20:04 +0200
X-Gm-Features: Ac12FXx1HcFo7kDJkLn1QiDBQXxv6qeoFbharkQhwFLpksbuBhKbTIPEmdzB5tk
Message-ID: <CAHUa44Eht8TK52tH6WPwnEhLGR_aBB-UySnsPLf=+iD3qQqe_g@mail.gmail.com>
Subject: Re: [PATCH] drivers: tee: improve sysfs interface by using sysfs_emit()
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 32BC941B34
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.53:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.53:from];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[ee.iitb.ac.in,lists.trustedfirmware.org,vger.kernel.org,gmail.com,linuxfoundation.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: FCI7SWTQA3X5NEI2YFOF4BISQLUR4EVY
X-Message-ID-Hash: FCI7SWTQA3X5NEI2YFOF4BISQLUR4EVY
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Akhilesh Patil <akhilesh@ee.iitb.ac.in>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FCI7SWTQA3X5NEI2YFOF4BISQLUR4EVY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, Jul 21, 2025 at 12:57=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org>=
 wrote:
>
> On Fri, Jul 18, 2025 at 09:00:13PM +0530, Akhilesh Patil wrote:
> > Replace scnprintf() with sysfs_emit() while formatting buffer that is
> > passed to userspace as per the recommendation in
> > Documentation/filesystems/sysfs.rst. sysfs _show() callbacks should use
> > sysfs_emit() or sysfs_emit_at() while returning values to the userspace=
.
> > This change does not impact functionality, but aligns with sysfs
> > interface usage guidelines for the tee driver.
> >
> > Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> > ---
> >  drivers/tee/optee/core.c | 2 +-
> >  drivers/tee/tee_core.c   | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
>
> Nice catch.
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Looks good. I'm picking up this for v6.17.

Cheers,
Jens

>
> -Sumit
>
> >
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index c75fddc83576..ce44e3498d37 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -72,7 +72,7 @@ static ssize_t rpmb_routing_model_show(struct device =
*dev,
> >       else
> >               s =3D "user";
> >
> > -     return scnprintf(buf, PAGE_SIZE, "%s\n", s);
> > +     return sysfs_emit(buf, "%s\n", s);
> >  }
> >  static DEVICE_ATTR_RO(rpmb_routing_model);
> >
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index acc7998758ad..944f913f8592 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -977,7 +977,7 @@ static ssize_t implementation_id_show(struct device=
 *dev,
> >       struct tee_ioctl_version_data vers;
> >
> >       teedev->desc->ops->get_version(teedev, &vers);
> > -     return scnprintf(buf, PAGE_SIZE, "%d\n", vers.impl_id);
> > +     return sysfs_emit(buf, "%d\n", vers.impl_id);
> >  }
> >  static DEVICE_ATTR_RO(implementation_id);
> >
> > --
> > 2.34.1
> >
