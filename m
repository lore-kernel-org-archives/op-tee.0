Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365A8CCF9E3
	for <op-tee@archiver.kernel.org>; Mon, 10 Nov 2025 10:46:13 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4DE3E430D7
	for <op-tee@archiver.kernel.org>; Mon, 10 Nov 2025 10:46:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Z21ur9pg;
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 91E3043134
	for <op-tee@lists.trustedfirmware.org>; Mon, 10 Nov 2025 09:33:58 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso1740696a12.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 10 Nov 2025 01:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762767238; x=1763372038; darn=lists.trustedfirmware.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hIOQ6rxvxUexWQ4rBYVQFATudRCo9jllmoVsfvKzXaI=;
        b=Z21ur9pgsoXJmVlUqVNDpSEVk/LYz0kgh9+BXaEQBqY0OM5/yIs8ZEUVhrudsZG3mu
         9xhu0pYYVVrxCc3CZBY0wuPyRxelD6igffa4NQ4GKhEIQcX3iLL8IqE5uy9U/H5e3D75
         BrnG9m3M7V6/zvw13dtStuOE9v9d8cifeZauBXHf3lbM64VLSgxtkDHR+u+EEp+UP99I
         ICXJnI7ALhV/q/p+yaE6VDjYoLlDwOayYY2q+d0nq6Kp/lQvkp8zz516760TREbrSr2P
         qxe6zpsvHud9yINW3ftFJD2EU00oEdAEZjMPjndldxcTPlndqeUUkyyFYcY7aUwMH9MJ
         p5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767238; x=1763372038;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hIOQ6rxvxUexWQ4rBYVQFATudRCo9jllmoVsfvKzXaI=;
        b=EKV/v8u+26djcq5z2wsDzCkKIGXofgrWe/hYVEE0MQaSpknrLakqXuX4J/VjfCB0Mu
         dgmiIVpe6QgFT0OIwm1sAk6O6HNohNQ2FBp699blx2XpGP7pfBqtIQhZj+ROrpgpwggl
         Ka28mLLoZTSBe+UyQGUUkCZxpNSh6637VHzhAIRAN8kUPZN74v2+pF18jOumrrzkrAn4
         zuKIdVm4KftIGrrEFyBeI/JUmCvEGoQbRkdvc8i9qIFvBeE2azBAPEbbcM8cJAXW+ABt
         rNnIU9NzSElNYbGD2dEzAyjkn+kmtPpfAQ56ZXNzPID1Rtc+JMMUxqrj/dflkJpoNJrp
         x/1A==
X-Forwarded-Encrypted: i=1; AJvYcCU1wfibjnctUi5u01IRBFf4irYaZTOy/z7CT7VGwyx2NJn0/+qglIB6hQWmkMFKbIx1R97w0mw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxX1HXu35Ledxs1j6ICki06+Xpg4ReUKeAxZtnliObp/OwIUr/n
	4PDRM58VI3fdh4AkyY+uK678MDsDxJJDMFNWzL6hUfNRHcA8fySNIVkN
X-Gm-Gg: ASbGncsSMwsPUgil+8bwk1elnNuvxQJRe7fNgigpZxsV4JJTyrRfRgMKMZ8Sxns+AYe
	DQsXyUHMuWIjUdPjn7GuQMPVTU0DIzBJbgv29/aIV+AAy9VoTeL/EnPdQnZiBqcvJAauAs7sfPr
	Fo7XJwG1Zw7RyFDsn/ORD/c4aDggU9jUn7dso82h1Vi100GrpEG11e8Lj3YH2JIQSM3Ee1sqbTj
	5OWU4bnUceh0caFGTltr7HKfy9IA1/RjR+SbcAtIVRY2Gm4yxcEBaBG5zznfJiiAIrFXB7S0Tut
	LrUgoVGOpsqbUuEN12i4MrWwxysDj0o3QhiPdLLPPg5Ex6WkFgeeYAW3AA+minmhaFz+vwyzAq2
	MM8ag/748aO6G/Rv1NUjinFBUnTNc3PRH+6I83CYqdQzMSr1QPdOpVtygdly+u1Lad9Fx9ShQbb
	rOOQXmap7RowXTChwTBxlhWBdMPJkaJAGc5J/1F2GPnVzob1LSYN/2cMFx9A==
X-Google-Smtp-Source: AGHT+IGL8U8AwBZN4pJnMi80e3kUGQSuXjn0pR5txm3KfrC9GE4bH1N0BeBWaOTIzoZFdpcdm+wzMg==
X-Received: by 2002:a17:902:fc8f:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-297e5413468mr96707665ad.7.1762767237567;
        Mon, 10 Nov 2025 01:33:57 -0800 (PST)
Received: from ?IPv6:2401:4900:8fcc:9f81:b4f9:45ad:465b:1f4a? ([2401:4900:8fcc:9f81:b4f9:45ad:465b:1f4a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3436c27a999sm3764935a91.4.2025.11.10.01.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:33:56 -0800 (PST)
Message-ID: <feffccdea0085f2a25f699bf80e5e8176ecd4128.camel@gmail.com>
Subject: Re: [PATCH] tee: fix uninitialized pointers with free attr
From: ally heev <allyheev@gmail.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 10 Nov 2025 15:03:51 +0530
In-Reply-To: <CAHUa44GYnZFaZQBNbV0=RSR7r61+ErYdQtEsRObNALz2CwT_Gg@mail.gmail.com>
References: 
	<20251105-aheev-uninitialized-free-attr-tee-v1-1-2e1ee8483bc5@gmail.com>
	 <CAHUa44GYnZFaZQBNbV0=RSR7r61+ErYdQtEsRObNALz2CwT_Gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
MIME-Version: 1.0
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 91E3043134
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.215.171:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.171:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+]
X-MailFrom: allyheev@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: TQ5R5JQXP6EG5ID67IL3GB6FJBJO4DB5
X-Message-ID-Hash: TQ5R5JQXP6EG5ID67IL3GB6FJBJO4DB5
X-Mailman-Approved-At: Mon, 10 Nov 2025 10:46:01 +0000
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TQ5R5JQXP6EG5ID67IL3GB6FJBJO4DB5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, 2025-11-10 at 09:57 +0100, Jens Wiklander wrote:
[..]
> > diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> > index ac134452cc9cfd384c28d41547545f2c5748d86c..8b7b4decddd8d1811dc0a7c=
c46a4a4fbada45526 100644
> > --- a/drivers/tee/qcomtee/call.c
> > +++ b/drivers/tee/qcomtee/call.c
> > @@ -645,12 +645,13 @@ static void qcomtee_get_version(struct tee_device=
 *teedev,
> >  static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32=
 id,
> >                                           u32 *version)
> >  {
> > -       struct qcomtee_object_invoke_ctx *oic __free(kfree);
> >         struct qcomtee_object *client_env, *service;
> >         struct qcomtee_arg u[3] =3D { 0 };
> >         int result;
> >=20
> > -       oic =3D qcomtee_object_invoke_ctx_alloc(ctx);
> > +       struct qcomtee_object_invoke_ctx *oic __free(kfree) =3D
> > +               qcomtee_object_invoke_ctx_alloc(ctx);
>=20
> Can we zero-initialize oic at its original location instead? Doing it
> here looks messy.
>=20
> Thanks,
> Jens
>=20
> > +
> >         if (!oic)
> >                 return;
> >=20
> >=20
> > ---
> > base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
> > change-id: 20251105-aheev-uninitialized-free-attr-tee-0221e45ec5a2
> >=20
> > Best regards,
> > --
> > Ally Heev <allyheev@gmail.com>
> >=20

Thanks, will fix it

Regards,
ALly
