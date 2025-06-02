Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F17C54FB3
	for <op-tee@archiver.kernel.org>; Mon,  2 Jun 2025 13:08:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 343DA4FB98
	for <op-tee@archiver.kernel.org>; Mon,  2 Jun 2025 13:08:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=x9rG/2Y1;
	dkim-atps=neutral
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 097CB430F4
	for <op-tee@lists.trustedfirmware.org>; Mon,  2 Jun 2025 13:07:46 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-60634f82c77so1296826eaf.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 02 Jun 2025 06:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748869665; x=1749474465; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGEn0S3eIF1t1Sj5b0H8YinszKfJs0cUlhOWZ/+NwOs=;
        b=x9rG/2Y1HsPCTrD5CYy8xDLHuX8pI2w35HsqpxuOEhLShUwmEuevI1dNtxoTrYcx5G
         GgZTNgkWgWbhqrCAjngThRu10f2BQ4Hf1pV13hDtCga0yNCwo4wt1PcpmQc264pYIB4f
         sVc6acskSdM1Ydo2dyEbP2eb0ToVeVmcj/ZuuOYqeHSTyNWOAyw8z8VC9S6jX3pzDBHp
         muYy4iKgkFtUAxbf/G28gsVfu+54DnhCMofCM/Nn0Btl/Jqag0vh5tbPuFh1cN9KSbHg
         cjztgi8OV5a2vWEhFS3ykvbHJmbl4x0xbeM67eVSNI6wy3FNo7WaCed6p8Om+RSZhReX
         o2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748869665; x=1749474465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGEn0S3eIF1t1Sj5b0H8YinszKfJs0cUlhOWZ/+NwOs=;
        b=tept+IILr8L31JBdxchFg0BMJ5i6iRu6305iHDYTftSl6qEMqo4haUTxDYknm1FSJE
         HZkcS9pnna2GZKnGcP4pu97c1nOb1zqst1aaCbE0jWe3kBJTEZQAhPqyKXl+e7kFl5yt
         nBS4lAJYhhG1LL3QD9zwWLIAFDQyRLnLrLmGKGyj22jrUkgo/p9bcVCfhhbfmKOqHLfx
         M72Fbsqhe0EcAP9xt2nDkK3MNGojsYMLy9DSJSL1GaIMnI1aKjFIRYJqixMPwJqmnyry
         ytB1Oio3AY+I2n/MkSRwvwBJwvXXNOBklV+64zBSOZsClqrr6b9LCL1aD32lHewBcKSe
         7FtA==
X-Forwarded-Encrypted: i=1; AJvYcCXR4G5zv7wI7tMcjGUXIgej2W8/8LYwDQ4h5X3soBmZkIcXq2tU2WmNFnv1nyyWBOyOnKZnWZk=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YydNTGdS2q1kN+7FdAzD59KRbn/vJR4/AzrXAW/xnAXzMxrSr3S
	bVthKzXCjCgHn83GD1MkucPt11rvRTtPp8yC4NDBZMuwpwVX/RzM/OOoBGSh/1TYZjV+z9tY9sJ
	dbu6Adh4QIKm9P8/6wytFiQO02iq7frC12oSKB9oYs9VV
X-Gm-Gg: ASbGncuNaaNtJiU/6M7LqulmSMqxSQP/jWacXb2BEtT3EjTVj4ZQHI365YdVtL0WzAA
	AbdHtmB2ZAPdJC3Nkl0WaIs59ODyfD3Nan1TYiO2b5Yhv1iGjvZ5pPAkeuv87Vyu0kYStGwrxM+
	iSxGcGruFLM2fuInHZua+P6g+mY0FOuBQstQ==
X-Google-Smtp-Source: AGHT+IEx5+w1dwr71oSgx37+faFBIG4ZKzh/eGNt7uJdmyo1EJ22pDg1MdsYK9f5BbLI2E9/ZHgUqwOWUuzpROGnWAo=
X-Received: by 2002:a05:6820:f06:b0:60b:d6f1:7c50 with SMTP id
 006d021491bc7-60d508750d2mr6863837eaf.0.1748869665092; Mon, 02 Jun 2025
 06:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <11fff295-0e06-4865-9d7d-f8ed2876de87@oss.qualcomm.com>
In-Reply-To: <11fff295-0e06-4865-9d7d-f8ed2876de87@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 2 Jun 2025 15:07:32 +0200
X-Gm-Features: AX0GCFtJNrSoxwsAalchHPMw6USIB9BARJjm21E5rSonj6QlcG4lIVfRgFJSDvk
Message-ID: <CAHUa44FM9vEpn=3uwim2+tPHAyVn4TVjyRiHxZrWk3o-mpf6SQ@mail.gmail.com>
Subject: Re: Issue with optee fixing supplicant wait loop
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.01 / 15.00];
	BAYES_HAM(-2.91)[99.60%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.44:from];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[209.85.161.44:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.161.44:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 097CB430F4
Message-ID-Hash: Q5GMMWE7GUAEABXDUSPIDMP2PUIOK3EH
X-Message-ID-Hash: Q5GMMWE7GUAEABXDUSPIDMP2PUIOK3EH
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Q5GMMWE7GUAEABXDUSPIDMP2PUIOK3EH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Amir,

On Thu, May 29, 2025 at 1:47=E2=80=AFAM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> Hi Jens, Sumit,
>
> The following change has recently been merged: tee: optee: Fix supplicant=
 wait loop
> (https://github.com/torvalds/linux/commit/70b0d6b0a199c5a3ee6c72f5e61681e=
d6f759612).
>
> This fix addresses the issue where the supplicant may terminate before th=
e client due to
> the shutdown sequence or a crash. However, it introduces a potential new =
issue - now that
> the client is killable, what happens if it terminates before the supplica=
nt?
>
> During cleanup, the client would remove/free the request, while the reque=
st would still
> be available in the request idr for the supplicant. Although I have not b=
een able to
> reproduce it, this could theoretically result in a kernel page fault.

You're right, a use-after-free is possible.

>
> To address this, there are a few options:
>  (1) Use rcu and access request under a read lock in optee_supp_recv and =
optee_supp_send.
>  (2) Reuse supp->mutex, ensuring that most of these functions run within =
the lock,
>      even though it may not always be necessary.
>
> Could you confirm whether this behavior was intentional? If not, I am hap=
py to
> prepare a patch. Additionally, please let me know whether you prefer solu=
tion
> (1) or (2), or if you have any other suggestions.

A patch to fix this is welcome. I generally prefer a less complicated
alternative, so if possible, please avoid RCU.

Cheers,
Jens

>
> Thank you for your time.
>
> Regards,
> Amir
>
>
