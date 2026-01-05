Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B109DC2A088
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 10:45:45 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id F2DBD4FEB0
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 10:45:44 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RvV1PHaa;
	dkim-atps=neutral
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3CCCB4FEDA
	for <op-tee@lists.trustedfirmware.org>; Mon,  5 Jan 2026 10:45:28 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-455a461ab6eso4214484b6e.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 05 Jan 2026 02:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767609927; x=1768214727; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbfo3VAG2V1COS2yJgiRNDBqK2UQf3Ldn6aq1VH3eSg=;
        b=RvV1PHaarVFuqGaBRAxtB/1Hj4s9jFdHTs+udyx+eluycfWk6nSyQGxy074EIgDrIc
         72Yh5AYK3scTDULQzwMxbjhghkiA6bI4NsB0hsp6SxjTzIGWJOU/kandMdntIQgEe8VU
         hiUOfZdgS5j6aPvVqI+AlJSv/9hrlHYybpY1ef2F9c/vn146K7CNspOUaGZbfv1cgu/8
         Pg680PZZsOTQiF/a5YDEcxkihJZlVg6hKU7YyjjdhI9XP8lKYDcn/c67rNKdVXE9qHCA
         9AT2lt/xTEXs9S6k8jwt4JvVmuC9dsWkkcWsXi0x7Q4SeA9BVMZdZUAa3zigHj/L0l6M
         Cmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767609927; x=1768214727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tbfo3VAG2V1COS2yJgiRNDBqK2UQf3Ldn6aq1VH3eSg=;
        b=s5HECfHpurvHG9hNZusSZrARu0N6l9CwZ3/wlmEcza1ID+YBxrlApanIhEzgQmdHpB
         H5rNrYscMva7LZlJxCvyxNO8ReE7dNOwMLEn/Vggjz6rnyzDIAjd9YNa26lDTq+Jtarg
         pHteiaqFadLLduhz5OILfeQ/io37orIpdOjPSvpf9RiuIBZaMW2aaYwlMP/K4yTyHFkv
         ClQ7ZjTuPsjNslKHcCZNk/qakDun5YaI4ucFOcsYHf36WaN/q2CmOizztNxQPo8FaNUw
         Nc5i18G2nLAlGpVQXNYqa9L9M3uFBAobECH7h9dXpZv0cDDxbScHGB2jqsS8WcuPjg1c
         uKDA==
X-Forwarded-Encrypted: i=1; AJvYcCWozsvY0Z3134Q2py/8CDLSQzwsJyxGaR8iotiQqxaIrMYQ5ZaWkRQgSmT0eHpUIHDqw+q7ndQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwJ8V60hMhvnJgS6gDtbD0NZ7+1dqUd3Y//vQp33/TUel3S2R3R
	ZjY8YaNIlWf9wnaDHx3OPmCukyakccl1nyz2iqTM1QZs+DrypsDscJCapRHCpBzSZGEuSPxoDVQ
	gt9scmxCKdO+QioZwUhNA5fD5auPO7BIZWNwZ4KcgqE9A/hB4canjCbIXAQ==
X-Gm-Gg: AY/fxX7UoiItKFBBsN0HaPuw3XNn42smDwAeMpJIqoiBoyg9Usq8/JiT/3zTNbqDWn/
	3THJEpfD67fwc7ayy17C9YYA3epRMTSG8uR8b0r+qCzpPpVAEuRmlammBS28nzrDeR3G3WjpuKO
	nFgQzrw7QaEwP67nnJ2fCIyLEP6SxACWu+BW60lVkVXa47xLRkAy+bgQDRsVEhnAAds8jwyIdbE
	FHMv8VJzRRTxt5TBMSIRicXLJHKvYGO6BIJujLSMhcW+Rj/TtZUqu1MilnJUwPOBvygoFAdA2J4
	HyT+/Sr9PDSwTvjsZI0EAM+I4A==
X-Google-Smtp-Source: AGHT+IGI/mK9Fh8eQRtLlCcrWEi6MJHRt6mLRzizqsEn77LrTLCYTSG41+6Vo4/l7cB7eDR+n1Mk0jNOLm/Oj50mVqA=
X-Received: by 2002:a05:6820:6fd7:b0:65d:1c:f39d with SMTP id
 006d021491bc7-65d0eb2e176mr15362351eaf.84.1767609927390; Mon, 05 Jan 2026
 02:45:27 -0800 (PST)
MIME-Version: 1.0
References: <20251208020844.5310-4-krzysztof.kozlowski@oss.qualcomm.com>
 <20251208020844.5310-6-krzysztof.kozlowski@oss.qualcomm.com> <eca4b7b7-d4de-4209-9965-4a8ce027caee@oss.qualcomm.com>
In-Reply-To: <eca4b7b7-d4de-4209-9965-4a8ce027caee@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 5 Jan 2026 11:45:15 +0100
X-Gm-Features: AQt7F2rW1d_WIKXIzDR4oO66eb8z6IxBmTiY48uzKUg7VxhM2OMIYdglPf1A19A
Message-ID: <CAHUa44GbvEEsyqRyOkmvyEtHaAQjJ_oytHiYrjMN1jjEtKkhdQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] tee: qcomtee: user: Fix confusing cleanup.h syntax
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	DNSWL_BLOCKED(0.00)[209.85.167.182:from];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ARC_NA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.182:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3CCCB4FEDA
X-Spamd-Bar: ----
Message-ID-Hash: TEEWYLPCVILTRLCCNWEMVOPNUE3H4RJV
X-Message-ID-Hash: TEEWYLPCVILTRLCCNWEMVOPNUE3H4RJV
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TEEWYLPCVILTRLCCNWEMVOPNUE3H4RJV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Sun, Jan 4, 2026 at 11:50=E2=80=AFPM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
>
>
> On 12/8/2025 1:08 PM, Krzysztof Kozlowski wrote:
> > Initializing automatic __free variables to NULL without need (e.g.
> > branches with different allocations), followed by actual allocation is
> > in contrary to explicit coding rules guiding cleanup.h:
> >
> > "Given that the "__free(...) =3D NULL" pattern for variables defined at
> > the top of the function poses this potential interdependency problem th=
e
> > recommendation is to always define and assign variables in one statemen=
t
> > and not group variable definitions at the top of the function when
> > __free() is used."
> >
> > Code does not have a bug, but is less readable and uses discouraged
> > coding practice, so fix that by moving declaration to the place of
> > assignment.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.co=
m>
> > ---
> >  drivers/tee/qcomtee/user_obj.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tee/qcomtee/user_obj.c b/drivers/tee/qcomtee/user_=
obj.c
> > index 0139905f2684..6aa3aefd67f0 100644
> > --- a/drivers/tee/qcomtee/user_obj.c
> > +++ b/drivers/tee/qcomtee/user_obj.c
> > @@ -228,10 +228,10 @@ static int qcomtee_user_object_dispatch(struct qc=
omtee_object_invoke_ctx *oic,
> >  {
> >       struct qcomtee_user_object *uo =3D to_qcomtee_user_object(object)=
;
> >       struct qcomtee_context_data *ctxdata =3D uo->ctx->data;
> > -     struct qcomtee_ureq *ureq __free(kfree) =3D NULL;
> >       int errno;
> >
> > -     ureq =3D kzalloc(sizeof(*ureq), GFP_KERNEL);
> > +     struct qcomtee_ureq *ureq __free(kfree) =3D kzalloc(sizeof(*ureq)=
,
> > +                                                       GFP_KERNEL);
> >       if (!ureq)
> >               return -ENOMEM;
> >
> > @@ -367,10 +367,10 @@ int qcomtee_user_param_to_object(struct qcomtee_o=
bject **object,
> >                                struct tee_param *param,
> >                                struct tee_context *ctx)
> >  {
> > -     struct qcomtee_user_object *user_object __free(kfree) =3D NULL;
> >       int err;
> >
> > -     user_object =3D kzalloc(sizeof(*user_object), GFP_KERNEL);
> > +     struct qcomtee_user_object *user_object __free(kfree) =3D
> > +             kzalloc(sizeof(*user_object), GFP_KERNEL);
> >       if (!user_object)
> >               return -ENOMEM;
> >
>
> Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

I'm picking up this.

Thanks,
Jens
