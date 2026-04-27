Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C79FF885E
	for <op-tee@archiver.kernel.org>; Mon, 27 Apr 2026 13:42:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EFFB644230
	for <op-tee@archiver.kernel.org>; Mon, 27 Apr 2026 13:42:15 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ptE6goaw;
	dkim-atps=neutral
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 57DFB43296
	for <op-tee@lists.trustedfirmware.org>; Mon, 27 Apr 2026 13:42:09 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dcc9b506d9so6769680a34.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 27 Apr 2026 06:42:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777297329; cv=none;
        d=google.com; s=arc-20240605;
        b=RvI5oph5kOjFhDGIXj9pEcldgf7SfCmZC6exgtggaE8mAMhDLNiIaAFVSc4agb+8JR
         d1GyP8HvyTEunO6Hj2Fkf6vtqoyQh7qJTND5Dwsi9pBLMhJhtTR0H03GSPNTyvhbGp4O
         SCk59QA72+Pqhx8slGMBIOA7an7oG6vGhLaRERQhRt+0Ji3LVRemKKxYUC92PO1hbD40
         zkEq03jh5kluj8CMgGl4Xcgsk9WjpG+cAV3NJOYr3oZCkuyIovZE4vfeLQy9HQyLkLW+
         LltgXnmR6dSzRACSicyDhkVyNaqoKRlP1+IQ2Taz856UtIjtSK8CmQ4WvBvjJmBe7e2E
         AaxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vI2Pb40nQwV1Ke8OwqQQ1JIIRXAgY4alEzVSyg1vqp0=;
        fh=/a3bmAus4GwWEScT5ASIToX036L3mXD1bjwLBxmpz2M=;
        b=AC4FXp+v7/tfn5HCrUqvcKdl2ylQ9SYSvSMIfduhVq8v4umxSXtOq4mYujNfh7evGV
         q8ZJivJfSnPqttbsnosVsEq/mu2UhzzcJ3u588XvJK4KG0qUq625nHBaKTZJ/dcCJ6Oo
         t70hOn5mzdyqbbPXR1BfKUM01kSkj60xOO+l8tm4DcC74+8M3F5in4tv+fezKF1EKQGZ
         x/o6R3fOzwiFKspjMsxvU8B9zUJ8qrhLD9l2QxG5n3AKFTEDbn3wz49rbthqhAw86VJV
         WdLfST2g9k49NsQiQcas1Q1r5bH0IYhRolxdbwtv6YSDMVwIpxVuuAaKdMfun/V5z1ix
         AxdA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777297329; x=1777902129; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vI2Pb40nQwV1Ke8OwqQQ1JIIRXAgY4alEzVSyg1vqp0=;
        b=ptE6goawVwRo97ozIRzL5/I74uErYavoCHxZK467Qu8UwUzN/Jk44SfufCp0EZpyZs
         2nhrj22TcyTALZ/u+hfpDiTRcfvd9keQHwZIwlZzLikJ5a4FET80N6FUgq3jXwWa++qd
         FaSTOqkIWISIvv8+BUw5F7Ejh+KbTkj0dPLqd+mquXgns2JU9SwFxNCC54Vh+5l6o8EU
         sqZXqqP42j3zoC/8C+s2RzpsfuwNk3SfW5/s6Cd2Auv57SreewHto4DeM+o3uCNVQn9Q
         1p5yaq9JsKZ2Fc/8xMDpVVsQNAfyv4rQQ10kipPsOuk/5PltZ2CV/9O/G3GNMm42uTMJ
         s6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777297329; x=1777902129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vI2Pb40nQwV1Ke8OwqQQ1JIIRXAgY4alEzVSyg1vqp0=;
        b=K4Z+b9V/0t04gWRfJfB0QmVDPDPv/Aq7Mn6fzAF3eYR7Y8LukCcJOYvT9G/xinrF2w
         0hZGkujmNqdwCAVbm9ylAgdMjt4HFUagiGbbPg48n7aPMjp6lV01OyCnHOo0HimDdyhd
         u9cXdYJes/xkDbQx+mLV11BEoCizor/J6T/D5g3bI1opYTKykQWGo4Dp2PJfRdge7HI8
         TOtf1ho51BB88Mk6UCeuXDxDMxIgeXQnta/k/ktK72hQTnGtLn+mszaevyFXTNW3az3S
         YeKmE9+s2UGTzbVLwU+cZPK2Yn64fb8W47tzUMzzYJog/TaHTNDgdsg6FqYDvWt8CJJh
         1fMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8NTh+MXXmwfwYLd9nnrX7VutkbxC4LXI9GcbteEcxbAg86ugzNAAXa5ZyUbdMX/zEKr45IXKI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxSxMekutUj6I4wZiRrCj4YrVg8UV4tkC2DYXBrNqfcS8WK6kn5
	0YWdUa5/DhZLCAoP9JbF0EFjxT5kXqsqTsJ3yj3XT9SMQVFakEZGIhQy04WNcgsuBSAdEQGiHyY
	BzwqjqQmXdVuJQJuTDvcy0d0NcMQPQTOsKiBPTcHfrfR05vMzA7JPC8kIDg==
X-Gm-Gg: AeBDiet0ABQ4izm0zRIbSfZFZz0nED5Owt/Q7kXJH3Hd41l8AVnN6cNdAk4TRyXYqbZ
	TJWjb9I0BrruCNO4T9SEumT5IG+xpLDB7r+E4sP/LK5AmiuTLiwwZH38ZhBG9w/aG2BKsc8CtCO
	zhcSEUBymMJkrJWPtmt3zPBl+fcbpa48rGZGoW34L9xWF2OkmoIC/ry1aOS8Jr495F1bUu59KuT
	4PfQn1iWfZZ8ms2yOUmpKu0P/vxkDg7OVx1Q1M+dVWOtBCmd2NI679q2MghQV/qJL8KnR4TZdR0
	UU/hgKkxXuvQUTzZojXMBsSuMf5HihQQfmMj9trX11lTlH0o
X-Received: by 2002:a05:6820:4b15:b0:687:60d8:776d with SMTP id
 006d021491bc7-69462f1758bmr23534925eaf.54.1777297328701; Mon, 27 Apr 2026
 06:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260322163114.17233-1-rodrigoffzz@gmail.com> <ady3o0i3YDmTehfK@sumit-xelite>
In-Reply-To: <ady3o0i3YDmTehfK@sumit-xelite>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 27 Apr 2026 15:41:56 +0200
X-Gm-Features: AVHnY4KfV-MivvSLhrT2U4OPn_DjEPlgCYLsWjkNe3PQLwft0fzpqjw0jmSL-Uk
Message-ID: <CAHUa44HHDS9Z9gftn6mpQx7ROyB4RQXKBgr8MXWh5VSh-Ji0Kw@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: fix kernel-doc warnings
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.46:from];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.trustedfirmware.org,linuxfoundation.org,brighamcampbell.com];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.46:from];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 57DFB43296
X-Spamd-Bar: -----
Message-ID-Hash: G3G34MPQD27IB7GPLUATPMKDGYPHMPNC
X-Message-ID-Hash: G3G34MPQD27IB7GPLUATPMKDGYPHMPNC
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Rodrigo Zaiden <rodrigoffzz@gmail.com>, op-tee@lists.trustedfirmware.org, Shuah Khan <skhan@linuxfoundation.org>, Brigham Campbell <me@brighamcampbell.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/G3G34MPQD27IB7GPLUATPMKDGYPHMPNC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Mon, Apr 13, 2026 at 11:30=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org>=
 wrote:
>
> On Sun, Mar 22, 2026 at 01:31:14PM -0300, Rodrigo Zaiden wrote:
> > Fix kernel-doc issues in optee_private.h and optee_msg.h:
> >
> > - Add missing documentation for struct members: optee_msg_param_value,
> >   optee_msg_param, optee_msg_arg, optee, and optee_ffa;
> > - Ensure member descriptions follow the order of declaration;
> > - Use consistent formatting (lowercase descriptions and ':' after
> >   member names);
> > - Adjust indentation for better alignment;
> >
> > This resolves kernel-doc warnings such as missing member descriptions
> > and incorrect prototype documentation.
> > No functional changes.
> >
> > Signed-off-by: Rodrigo Zaiden <rodrigoffzz@gmail.com>
> > ---
> >  drivers/tee/optee/optee_msg.h     |  50 +++++++------
> >  drivers/tee/optee/optee_private.h | 120 ++++++++++++++++--------------
> >  2 files changed, 92 insertions(+), 78 deletions(-)
>
> Thanks for doc fixes, FWIW:
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Looks good. I'm picking up this.

Cheers,
Jens
