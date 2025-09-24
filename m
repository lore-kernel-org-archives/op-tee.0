Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B33CAC59A
	for <op-tee@archiver.kernel.org>; Wed, 24 Sep 2025 07:32:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2269242C49
	for <op-tee@archiver.kernel.org>; Wed, 24 Sep 2025 07:32:42 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UnlQcXPf;
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 049EE3F0A0
	for <op-tee@lists.trustedfirmware.org>; Wed, 24 Sep 2025 07:32:27 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46b7bf21fceso33423735e9.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 24 Sep 2025 00:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758699147; x=1759303947; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UXwsP//vM56W40KjvtwrX9R47nj/UueUere/kbOGRCo=;
        b=UnlQcXPfgitxqCSeMvFMB30J23LPL2ujLjxoNooOqCbfyFFgnUXB1Fu7CHJKvVv1eW
         XIFEZzN0bpTooh7UTVp3nYe96aJVIOg8XrFCgm0vV3h6SSQj2U81SMzkeAa8WIJ0IIPE
         iNhc2JaAKHx3pxR4WYeOIyXNdr5vV937yyHyuEn/w4Ikg/bmje480JdFC2y2bz7//M+q
         Dy+Vp+wTa6IJ61MgFayBX0uylbpFnwlip2UbwGO7OeCmbeAsPaxkIMJ0BriBxoyemoZp
         AtL2ocHYSDBSH5ez9LORFwTCLnSrPgChtoV15UTf/+1+I776QKOKvmfaFqEpVqiySrGR
         mbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758699147; x=1759303947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXwsP//vM56W40KjvtwrX9R47nj/UueUere/kbOGRCo=;
        b=L8YfvpEa4csxqsLj0XIH/MXN2pUIbDeviAA60WJmoJzKCgjmTudnHiZJIB0PG+K/d4
         sUimmMJBpI/kHgVJxCrUi1alJ477YGMJdUFwD77h9MpnHN98lSf8c9/jKTzdd7sHtJYQ
         /e0iiQtw7e6Bv9Qcl17TbmxYRbPxJDYmvfLH0KbSa85GoNb+Wx/5C/p8fmV0ML1+48F0
         sfimm6EkqEaHTIBq1nXofIauZIcYz4eivpzzOzSLMX7aGQDjVagQ5AUV/Z0s8HGUOoYh
         5WFocDcuHrQPAw5XPboltjUt3LJdnRBsqlBhPOVqtThIXrqbmGXn9Q0K6pk94iQlNqh2
         w9TA==
X-Forwarded-Encrypted: i=1; AJvYcCUaWuXWnQWA0U+m6ej8uwgohL4aQoTYZpITaJ3QQkES5TQ0C9d7/QQ72ob+v6bzrawRy9jsKVw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw/DlBPgbQB1WlAN8sDBhNME4H9eohAuKyYnVtCfPEwf7250ykP
	8fho+DPRUlAqcSIWtRYWZzy4RPG35nlLun71gnwRty6Or5Q1i3UfYmXmtodloNNW6SFyzg==
X-Gm-Gg: ASbGncukDVYhWzUTlnIsfetcFO204qYMAa4JnVcvFKrOhd+gx/C5a3/zHSV66IHnZi0
	0HoGBm8jvnQ+6kNrXnYLwHltdR683L+b334i502FulKSNPmHmxMTm3tKIh/MTiHbFXXdNr4g1C/
	x8eO74l7BquhK9/xjaiNCW9EpeJFrPHwSAY6zSbdC0m24L0zOjU30X3S5TDMrfzM8fYneyBTXef
	VrDl/UlGHNMujB1pzBt1kHtpaK823n6OKd/+Ez3eCpXzw8JKvRl4s/KF+knTwKYInlehc70H+vv
	ncaAGlZAtNQhN6zlryUKG6a4xfpvEauocNOjuxbOSqEDgix2a358WPsqBkBqYVqT1n1zRWY9cqr
	FP3USOoV3jF4s0EFpXYcbi+F7PuHRaxYRsxHXEAg=
X-Google-Smtp-Source: AGHT+IFqcDjqsGKdmcV1EsOoO1DT4mayZkZcsrnoULvEIG2jDOzlj2gp/jdzhPJLQtRPGd1AKwtYvQ==
X-Received: by 2002:a05:600c:4f09:b0:45d:d5df:ab39 with SMTP id 5b1f17b1804b1-46e1dabe432mr51516895e9.26.1758699146691;
        Wed, 24 Sep 2025 00:32:26 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e2f13764dsm3026115e9.1.2025.09.24.00.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 00:32:26 -0700 (PDT)
Date: Wed, 24 Sep 2025 10:32:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: Re: [PATCH next] tee: qcom: prevent potential off by one read
Message-ID: <aNOehr6hxdb2OypO@stanley.mountain>
References: <aMvV4kK386Sni10i@stanley.mountain>
 <adbccfc0-0f9c-4b71-9fb5-5582c8180ac7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adbccfc0-0f9c-4b71-9fb5-5582c8180ac7@oss.qualcomm.com>
X-Rspamd-Queue-Id: 049EE3F0A0
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.42:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.42:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: MIGFS3XDYMXM2P7QG4ZMH4X3MLACVQUE
X-Message-ID-Hash: MIGFS3XDYMXM2P7QG4ZMH4X3MLACVQUE
X-MailFrom: dan.carpenter@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MIGFS3XDYMXM2P7QG4ZMH4X3MLACVQUE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Wed, Sep 24, 2025 at 08:48:29AM +1000, Amirreza Zarrabi wrote:
> On 9/18/2025 7:50 PM, Dan Carpenter wrote:
> > Re-order these checks to check if "i" is a valid array index before using
> > it.  This prevents a potential off by one read access.
> > 
> > Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/tee/qcomtee/call.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> > index cc17a48d0ab7..ac134452cc9c 100644
> > --- a/drivers/tee/qcomtee/call.c
> > +++ b/drivers/tee/qcomtee/call.c
> > @@ -308,7 +308,7 @@ static int qcomtee_params_from_args(struct tee_param *params,
> >  	}
> >  
> >  	/* Release any IO and OO objects not processed. */
> > -	for (; u[i].type && i < num_params; i++) {
> > +	for (; i < num_params && u[i].type; i++) {
> >  		if (u[i].type == QCOMTEE_ARG_TYPE_OO ||
> >  		    u[i].type == QCOMTEE_ARG_TYPE_IO)
> >  			qcomtee_object_put(u[i].o);
> 
> This is not required, considering the sequence of clean up, this
> would never happen. `i` at least have been accessed once in the
> switch above.

Only the first iteration has been accessed.  The rest no.

regards,
dan carpenter

