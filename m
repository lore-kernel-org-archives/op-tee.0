Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1336ED5B161
	for <op-tee@archiver.kernel.org>; Tue, 16 Dec 2025 07:34:15 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 458AE4FEDA
	for <op-tee@archiver.kernel.org>; Tue, 16 Dec 2025 07:34:15 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wRXWoqCQ;
	dkim-atps=neutral
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 673904FEDA
	for <op-tee@lists.trustedfirmware.org>; Tue, 16 Dec 2025 07:33:55 +0000 (UTC)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-657044fea68so2195785eaf.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 23:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765870435; x=1766475235; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJxuVx1hE8QwPo+5lZ9vSSExDNzQxar/zw9l2S0dxlw=;
        b=wRXWoqCQ92vPFwJgkiQ4fE8iBaZ9XQpE3kQ2dxOUUVmo1RYnxtoU6dWIOE5rWd0u9+
         nJqYc5Bd7Wrx/RTobY7nD1R9k3er5PDx9uTsz3+W/LK0hxiriUDKyo/NtxBX1gts9V8M
         xx0KkqAAUq4otbMGPUL230m5Vljlq1rBB1MiT9O2Kct7sb0bDZNYVEQoW2aRBUrkxxyq
         Bdw5EQCM+TM9N6MPsFE7WFl4Bccy67zuYXzYQn+pFe4lFZq0OsEJxYgVu3CDtYhN0F6p
         Xi+6D/Bal78MwoZ8n/KWgIjZRnpgXTkxPZ9hiIVQEEyFDoStZUcp1+qCOHbHnKt2y1WF
         WVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765870435; x=1766475235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pJxuVx1hE8QwPo+5lZ9vSSExDNzQxar/zw9l2S0dxlw=;
        b=O65ExZNhl4VoRtatUUDgq9sgJwwTECxCtnB6dCTszvvsjd+qskcohrrR8UffXdu6rH
         3/XaDqOSk/aQwSLt8fKSDtZ1eoTlh6Mju8+cNxr3l/KQwVbkoM2E1IxZXHPcw52cHAOP
         45SnYJ4HLHjHVtui9WLCYYi3eiQXm3QZ+8h2f1MAczaxG99/j3N7e4Rx0qZe0kw5pKrz
         0Q3TzxWFfQmixwCP+oI2VgKzD6d5Vq0f/sNlVhfTT3eaKBrjeGnyQiNX1lyCunZUM/eo
         3d45dqLFqCI1f8F2DdTsxJY/ZUQZSyRx5eTbtokJLmYTcOFZCZ5B6R4kfi1blhXmJhYx
         +ldg==
X-Forwarded-Encrypted: i=1; AJvYcCXPcYMEMGdQY51l/UB5QkpJAvwkaETDmIXIr1PvzGc5b0qVwvZ0FHXIqJ2o6B5w3KmZD3jZ/2U=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyMpu/DUgd+IFvWCtaxozSKQHg31UbVxNuXX1ABqKEFw8OKDDZd
	4S5dCyP46Vp8cPMPRQkOqWoJAXf1mHTeEJS1U/y1BXD1k9SYTyiWP8SR7OJxGCLdfpY4Gqri99C
	FP/4yaIUbn47M4AANDXwM3wgS5Uxkp3M/HBmFucVuQcMN
X-Gm-Gg: AY/fxX6UBOGyUUtP98N7N7t1aQj6GjWAectBVSneJHZPNWN1+nBAv+eZw01mr6c6Dvo
	hYKNxY+pYz3pJYUom+etqsaxjERZ17cJLGSOCY3tlS2UbXXNEpf9xstwgs/hFZq8qCR9kYXHeFP
	+S/bCSfrOlU3ylfFzL1T9Xv9Adx4GrbTyUxBsNOCnB6xRLxP4AXIMIlXzK6K8qUR+QVfnac7jqB
	Spdo0f4S2S1t57H/qlkJRf5egUhWHPozAhcA9zNGZj+ojwkt72rq90pvPXBLqD2mhJy19weMn0s
	1CGEh8iskzNo+i6opjOIw0+1XA==
X-Google-Smtp-Source: AGHT+IFgcI1iXYmQOJMbCoMzO4TuZILfDefDSjHP+dHpTw0q1q+63iQUVOEFLyAayV4+4wtBrXEibqfLYLgVtUxJtl0=
X-Received: by 2002:a05:6820:2114:b0:65b:328b:4b9c with SMTP id
 006d021491bc7-65b451b2947mr5857330eaf.18.1765870434698; Mon, 15 Dec 2025
 23:33:54 -0800 (PST)
MIME-Version: 1.0
References: <20251208020844.5310-4-krzysztof.kozlowski@oss.qualcomm.com>
 <aTtn-x0hh18V7n7J@sumit-X1> <b29c97cd-cade-40ef-8e6d-d164b1d16059@oss.qualcomm.com>
 <aTtyR5J3AqXoE7to@sumit-X1> <7b074ee0-4f10-4fba-9680-3d87dcf766c1@oss.qualcomm.com>
In-Reply-To: <7b074ee0-4f10-4fba-9680-3d87dcf766c1@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 16 Dec 2025 08:33:43 +0100
X-Gm-Features: AQt7F2pwugYqW3nJWhjtHv1ppCx-uDAzlDiP3MdQeHwnJLNKjL7ZHy9bFIyp3LI
Message-ID: <CAHUa44EO8HYA=KgouSt902RJ63H-Vz24nOaaj7PATVT0n2fkeA@mail.gmail.com>
Subject: Re: [PATCH 1/3] tee: qcomtee: call: Fix confusing cleanup.h syntax
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.54:from];
	MIME_GOOD(-0.10)[text/plain];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.54:from];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 673904FEDA
X-Spamd-Bar: ----
Message-ID-Hash: KTISVVNA5HK7C2RG7CL5JDRMLAMYIQUH
X-Message-ID-Hash: KTISVVNA5HK7C2RG7CL5JDRMLAMYIQUH
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KTISVVNA5HK7C2RG7CL5JDRMLAMYIQUH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Mon, Dec 15, 2025 at 9:30=E2=80=AFPM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> Hi,
>
> On 12/12/2025 12:39 PM, Sumit Garg wrote:
> > On Fri, Dec 12, 2025 at 02:07:40AM +0100, Krzysztof Kozlowski wrote:
> >> On 12/12/2025 01:55, Sumit Garg wrote:
> >>> On Mon, Dec 08, 2025 at 03:08:45AM +0100, Krzysztof Kozlowski wrote:
> >>>> Initializing automatic __free variables to NULL without need (e.g.
> >>>> branches with different allocations), followed by actual allocation =
is
> >>>> in contrary to explicit coding rules guiding cleanup.h:
> >>>>
> >>>> "Given that the "__free(...) =3D NULL" pattern for variables defined=
 at
> >>>> the top of the function poses this potential interdependency problem=
 the
> >>>> recommendation is to always define and assign variables in one state=
ment
> >>>> and not group variable definitions at the top of the function when
> >>>> __free() is used."
> >>>>
> >>>> Code does not have a bug, but is less readable and uses discouraged
> >>>> coding practice, so fix that by moving declaration to the place of
> >>>> assignment.
> >>>
> >>> Okay I see but..
> >>>
> >>>>
> >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm=
.com>
> >>>> ---
> >>>>  drivers/tee/qcomtee/call.c | 17 ++++++++---------
> >>>>  1 file changed, 8 insertions(+), 9 deletions(-)
> >>>>
> >>>> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> >>>> index 65f9140d4e1f..8f8830f0df26 100644
> >>>> --- a/drivers/tee/qcomtee/call.c
> >>>> +++ b/drivers/tee/qcomtee/call.c
> >>>> @@ -395,9 +395,7 @@ static int qcomtee_object_invoke(struct tee_cont=
ext *ctx,
> >>>>                             struct tee_ioctl_object_invoke_arg *arg,
> >>>>                             struct tee_param *params)
> >>>>  {
> >>>> -  struct qcomtee_object_invoke_ctx *oic __free(kfree) =3D NULL;
> >>>>    struct qcomtee_context_data *ctxdata =3D ctx->data;
> >>>> -  struct qcomtee_arg *u __free(kfree) =3D NULL;
> >>>>    struct qcomtee_object *object;
> >>>>    int i, ret, result;
> >>>>
> >>>> @@ -412,12 +410,14 @@ static int qcomtee_object_invoke(struct tee_co=
ntext *ctx,
> >>>>    }
> >>>>
> >>>>    /* Otherwise, invoke a QTEE object: */
> >>>> -  oic =3D qcomtee_object_invoke_ctx_alloc(ctx);
> >>>> +  struct qcomtee_object_invoke_ctx *oic __free(kfree) =3D
> >>>> +          qcomtee_object_invoke_ctx_alloc(ctx);
> >>>>    if (!oic)
> >>>>            return -ENOMEM;
> >>>>
> >>>>    /* +1 for ending QCOMTEE_ARG_TYPE_INV. */
> >>>> -  u =3D kcalloc(arg->num_params + 1, sizeof(*u), GFP_KERNEL);
> >>>> +  struct qcomtee_arg *u __free(kfree) =3D kcalloc(arg->num_params +=
 1, sizeof(*u),
> >>>> +                                                GFP_KERNEL);
> >>>
> >>> ..this makes the code less readable with variable declarations floati=
ng
> >>
> >> Which is intentional.
> >>
> >>> within the function. I would rather favor to not use the cleanup.h co=
nstruct
> >>> but use explicit kfree() invocations instead like it's done in all ot=
her
> >>> allocations in the TEE subsystem.
> >>
> >> Sure, fair. I just don't get why introducing cleanup.h without actuall=
y
> >> accepting its explicitly documented style...
> >>
> >
> > TBH, it is likely overlooked during review of the QTEE driver. Having a
> > builtin warning for the undesired syntax would help the reviewers here.
> >
> > -Sumit
>
> While the style may seem unusual -- as stated in cleanup.h, using cleanup=
 helpers
> makes the code more readable overall compared to relying on multiple goto=
 statements.
> Also, it=E2=80=99s not just about the "__free(...) =3D NULL" use cases --=
 there are locks
> involved as well. Switching to direct free() would require reverting thos=
e locks,
> since mixing cleanup helpers with manual cleanup is not acceptable.
>
> If this behavior is explicitly documented in cleanup.h, there is no reaso=
n not
> to use it as intended. I also support Krzysztof=E2=80=99s suggestion.

It looks quite ugly, and it can't be mixed with the usual goto
cleanups (I suspect some care is needed with switch cases too), so we
must be careful where we use it. It's not obvious that this pattern
should be used in every function. However, where it's used, it should,
of course, be used correctly.

Thanks for the fixes, Krzysztof.

Amir, if you're happy with the fixes, can you give your R-B for each of the=
m?

Thanks,
Jens
