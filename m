Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CE6C98322
	for <op-tee@archiver.kernel.org>; Sat, 17 Jan 2026 11:33:55 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9E7F1434B2
	for <op-tee@archiver.kernel.org>; Sat, 17 Jan 2026 11:33:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cXzn1zJ7;
	dkim-atps=neutral
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3372041B60
	for <op-tee@lists.trustedfirmware.org>; Sat, 17 Jan 2026 11:33:38 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6611ca93e45so777072eaf.3
        for <op-tee@lists.trustedfirmware.org>; Sat, 17 Jan 2026 03:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768649617; x=1769254417; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOzQ1khzRrSH94mr21KFZdEC2mQ+Ktkw7PoKvjMdSQM=;
        b=cXzn1zJ7Z0HUS0HSlvHkd446yhWH8p9f/FYzZw/nOFO9F8JEBDXkvJNg6iJqq5j3EV
         wx6S6TqiDpNW8q4nHa/zNC+Kcza4UsCU9Xg4Si19mse9hO6p9sG1f45iDI62AItco4Oe
         8DFAFNsS12uTtujgw6dQn/NyASgSa/IVUk5Kght/u9LVLNgJ9bl9CXLZK8BqWQ/14k09
         By2bBRrsDWLx3e7FhuGDYy1anmkoG8THSg8tnHqEfpL6ku8tCCBxeoy45ulZI9b2ic5V
         z9qAmkGSGb+C7EgyMLULysqOg4Bl19FQgWL6jkXs8dja6k78+bYiSrEEbDno2WjR0sNk
         a/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768649617; x=1769254417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iOzQ1khzRrSH94mr21KFZdEC2mQ+Ktkw7PoKvjMdSQM=;
        b=P7KiRaoXAxZNxeaOjXj3irgZAn4tvw3nKrgPT/4k7GQ8iew0/zhYuDBlvAT7QHYQg2
         lc6n3DBTqNnEyT8v3IGjJWul9gPuXPwfL2aevcdVjedx6qL9awt8ghVogtCGmweRPbAs
         ZFuRsMoVX/KJRJSpsG5YOGsoFJTNevbXDwc8Is6XHakrb9BaXL+oL9dlKqldVQeREMDU
         SlSh32kRrKye1QDJPwZgU9rAWIt7Jt+J3PJcljOY/e2ecxxBtdWo9/PIbBopf5Yz8wUS
         cg336VArBF7M7xQ6SIrIVUk//y9I9zNouwNEk/F8o6vqsu1y/PkQLWj9MTbEasX7ysnJ
         vADg==
X-Forwarded-Encrypted: i=1; AJvYcCU8rmqeBmmYTlQbcYg9QwjUby24nse1xLlwIaop5MbJE/qcTFHUVQP4td5cvdnUeSUNTwY/MSQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyjP9LlbRxr6M7UdoIXtXDsPncWfAi3hMMM22A26vsnw15GOCFb
	S8wtu/Oppd9e2fjWgCsO1qtO9TIhbMc+7zNe39z9tEbpEiYOgApLkCdQMQzdDSa2HiAMk2sFd3T
	NWtj1Vl1TOYoTPf9WZQSEQeAc4lFyDyZpKOlXf9xsrPpE
X-Gm-Gg: AY/fxX5vs7gfY/qUKoPOyrGM3uJkZjBq2kK0bo7zOJ48FqnCoyCbI9Lf68ZUE6/OXex
	FMAwMa7Jl57YeZacoG2p+ixS5mSS3EHf7vQETq3HBpFfv/NtXDSBZ0svQyPWZvewqihtPWiLjiO
	m6Z1r6jODbwrckKNrG+MSh6lWnDHPEa/FrqiLsJHDooPiDjyOlBvPwzl6RX7g/FjqTYQZaUuIXM
	lryaXhlknKB5nm50pXeUNfScy799dBQ8e2z2RQo6d1cCr86/lbsGdc7XirPpp+f/MkLMxgtwU7I
	VaIsE2BnEqWIAkRZs2OYVkgNEINwhwjx0LI2
X-Received: by 2002:a4a:e914:0:b0:65f:1ab0:cdca with SMTP id
 006d021491bc7-661188cc3acmr2272492eaf.1.1768649617502; Sat, 17 Jan 2026
 03:33:37 -0800 (PST)
MIME-Version: 1.0
References: <20260109154442.421248-1-coking@nvidia.com> <aWTaUvGu9dlvnJO9@sumit-xelite>
 <CAHtS329G-H8vVVr==DZUAetzVNc4couN2OV3tH7qH_7YDGe8xA@mail.gmail.com>
 <DS0PR12MB8294F8C07E39842AC16CBA21AF81A@DS0PR12MB8294.namprd12.prod.outlook.com>
 <aWoBgt66shtVTovl@sumit-xelite>
In-Reply-To: <aWoBgt66shtVTovl@sumit-xelite>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Sat, 17 Jan 2026 12:33:25 +0100
X-Gm-Features: AZwV_QjgSErz9k4igW8Ybil0s5E-zl_z4UBojBpjGipbHvYstM4bI01lX_YWxpw
Message-ID: <CAHUa44ETDyE66bRS_nP-efWnFk2L3=fHW5y-ZJiwXG4o-6+XKQ@mail.gmail.com>
Subject: Re: [PATCH][next] optee: make read-only array attr static const
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.49:from];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,lists.trustedfirmware.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.49:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3372041B60
X-Spamd-Bar: --
Message-ID-Hash: YJUKGOQVON7OVFKCI4ED7YSCEV7TYEN2
X-Message-ID-Hash: YJUKGOQVON7OVFKCI4ED7YSCEV7TYEN2
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Colin King <coking@nvidia.com>, ryan foster <foster.ryan.r@gmail.com>, "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YJUKGOQVON7OVFKCI4ED7YSCEV7TYEN2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Fri, Jan 16, 2026 at 10:14=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org>=
 wrote:
>
> On Mon, Jan 12, 2026 at 03:24:49PM +0000, Colin King wrote:
> > I added this change for several reasons, it's read-only so making it co=
nst is always sensible.  Making it static means we don't get the compiler t=
o generate object code that stores the array on the stack (each time it's c=
alled) and then index into it, instead the data is put into a read-only dat=
a section at compile timne and the object code just fetched data from this =
array.
> >
> > Basically, if it's read-only it's good to make it const and it's not in=
 an __init section then you may as well make it static const. It's scoped i=
nside the function, even though it's in the data section.
> >
>
> That's fair. I don't have a strict preference here. Feel free to add:
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> >
> > ________________________________
> > From: ryan foster <foster.ryan.r@gmail.com>
> > Sent: 12 January 2026 14:46
> > To: Sumit Garg <sumit.garg@kernel.org>
> > Cc: Colin King <coking@nvidia.com>; Jens Wiklander <jens.wiklander@lina=
ro.org>; op-tee@lists.trustedfirmware.org <op-tee@lists.trustedfirmware.org=
>; kernel-janitors@vger.kernel.org <kernel-janitors@vger.kernel.org>; linux=
-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH][next] optee: make read-only array attr static cons=
t
> >
> > This looks like a micro-optimization, const makes the lookup array
> > explicitly immutable, and static keeps it out of the stack frame,
> > avoiding per-call initialization.
> >
> > Is there a style preference for read only lookup arrays here, e.g.
> > Should these variables remain local but not static, or should they be
> > moved to file scope static const?
> >
> > On Mon, Jan 12, 2026 at 3:26=E2=80=AFAM Sumit Garg <sumit.garg@kernel.o=
rg> wrote:
> > >
> > > On Fri, Jan 09, 2026 at 03:44:42PM +0000, Colin Ian King wrote:
> > > > Don't populate the read-only array attr on the stack at run
> > > > time, instead make it static const.
> > >
> > > Is there any value add to do this? AFAIK, the static local variables
> > > aren't preffered.
> > >
> > > -Sumit
> > >
> > > >
> > > > Signed-off-by: Colin Ian King <coking@nvidia.com>
> > > > ---
> > > >  drivers/tee/optee/rpc.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > > > index 97fc5b14db0c..1758eb7e6e8b 100644
> > > > --- a/drivers/tee/optee/rpc.c
> > > > +++ b/drivers/tee/optee/rpc.c
> > > > @@ -43,7 +43,7 @@ static void handle_rpc_func_cmd_i2c_transfer(stru=
ct tee_context *ctx,
> > > >       struct i2c_msg msg =3D { };
> > > >       size_t i;
> > > >       int ret =3D -EOPNOTSUPP;
> > > > -     u8 attr[] =3D {
> > > > +     static const u8 attr[] =3D {
> > > >               TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > > >               TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > > >               TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
> > > > --
> > > > 2.51.0
> > > >
> > >
