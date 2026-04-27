Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B15FF8860
	for <op-tee@archiver.kernel.org>; Mon, 27 Apr 2026 13:42:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4A2BC44406
	for <op-tee@archiver.kernel.org>; Mon, 27 Apr 2026 13:42:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LiYmOjp4;
	dkim-atps=neutral
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D0D1243296
	for <op-tee@lists.trustedfirmware.org>; Mon, 27 Apr 2026 13:42:45 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40ea611d1a4so3590107fac.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 27 Apr 2026 06:42:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777297365; cv=none;
        d=google.com; s=arc-20240605;
        b=fJa4Jp/wWtEIQQgqHxbP/8AHMDsHjxCCI8fgfST0ZVq+zrWsK3Btsv2skV1x9RyD7X
         +8IsqRe0uDWaIGcrlewBk6BL7W3GM2sYAfCX4ZctsFa82XHp+pBfG0owcQpIRhcBJ0Ng
         UKFQY7x52i899VHpLfFlWxj2XfRymqiQ4tM+Yr6TXxcR7XEGyjvi3S9UCNIXVvTJHOr4
         ekf2zqSt3CNhQS2dnuNbCO8xuJQ/A7SuCSBXzd3nWJYC0UIPhv8A7jos9Is2qJFxKKyt
         ngZ8uOkOaWlw3pi7vcA1Vcy+G7NOX177+vujocm67zFO+akb/ijEgEttebjLylUvEQlD
         fBqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZqbZg/21i+6RQTLJEXvFkGwmbCgrJAcmhxL/tmOScfg=;
        fh=wjNblMYhcU3a70GTnFRS35j5S+vjyhUMLNLvuDZ02GQ=;
        b=KnTB/7nJEjgwKdtPNmSFwaLsXgGun3nNYIIyjsXFJIZTUXFpNdM5JRfo0S3Yii9m3l
         cRpzd3nr6NgRuKeTeyzc9NRiTcWoZtlnR05F78F6y5CyvYP7mmi96otPSeakRyZYXQca
         o4lg/d8G2JOfRmS8Ms+T4cz6ZseYGrf5ibZCqkYzrJH/GKNjyR0sxzvdUQpg1OThHCTl
         tyjSFUVdYMgG/rEsQ/1MOxcqNXCJ8wu4u2UDgBLHoN0eXCvGEGZq8QgizeM+VkydHywv
         drh9neuiAFD4EIf9Pe+FHVDDkeEGv8IIG2OsN2GAP6WKjG53Zk/xjvK3wTMITfEYNYKr
         5ekw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777297365; x=1777902165; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqbZg/21i+6RQTLJEXvFkGwmbCgrJAcmhxL/tmOScfg=;
        b=LiYmOjp40DGCgGdwZRn4WSkX+UFkUsJX72mpspFO5JHW6+ySYfXmV9Q7ZscbEfKfEr
         rWmtV76WaYIcl/TPaQP49tRfnLPItI1xNmR6QMZalBl8r8Ama5C2/DzFeyzNza2hpUCE
         4+Mm3924uwixvV8yuq+NwUfAWusnneQoqiJEuZk9V+AZ1s9ardDjylKnaMsCAxB+1U78
         yVpWwezEVIEPab5QmfliQGUf/utomQ10BbREKySeIBPkSxF7Qcydt5jv/xHlzQW0Ufo1
         sn9DltgJ0ZNEaBzY0dVssPpSbQr1Tsv3ua5TgBdkuvPXl8eh8hN/nSesF4ncgnCbckBJ
         lkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777297365; x=1777902165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZqbZg/21i+6RQTLJEXvFkGwmbCgrJAcmhxL/tmOScfg=;
        b=GFF5NzLafUMgmEFldbVuZJOy9zbyhT12fvNAoNLg7E+61LCYysKLW8c5DChexrm+9N
         Rhw/+KPW87He5oTydNz1BU217LseJ234RK2qtU5Gu0Q5KDEOEYcY3wZJHkfPMa6nKLdO
         xpp0UsLljMRqOpvLpN+5TwmMUgMXAy3smXE8jaeB1QxbxB+jaf80MVKJT1qnikPRlHAt
         acTkJ6jpYggyjJaeN+xyBCECmAJsHJQIvBNjvQccClnfPJJm+noaV9ZVzWPkqj8kbzmb
         0xZau9+INIePi3uLAhGEbb0HKQCLhX5V74bUYCfHZuQNwzFVLttBzEVkK7s1znmkHdCk
         rbdA==
X-Forwarded-Encrypted: i=1; AFNElJ+KeQ7aYho86wttfMZn+m1PXvYd3Hklx6+xY3IvWw9iKdDdQTyUQ/5D/ApohqXNCCOCpgI+wNQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yz4VrhssEJ58c6dL75VsEd2LQZkUZJ1+S2D7EoyyOdPwAzC5LW5
	m2tH1d6bTmLQ9NHiQi9V25qaSAYUVOz3DHtBYE2cLaznoSaw+hVxkwFCa0+1T15OhZo9bPmQlN5
	/e4/xyBmo5oFpZVIuArQ3MT3pXzPYbBGeWr/QNLlJp/7D
X-Gm-Gg: AeBDievwQUUp/0lN8r8ZXw+/OJekNk9ZelqqYXtpgqa/4N/sTcS+yMbRAjF/GMNfZkq
	DeDlfowAcBHf/JKm6D4opWzJTpgtQAdzQGtuTDc8jl1YRrw85mJ0yaRqpY51ZqL91+apbsvd8+5
	qER7qdT/Y8fUsYeXbvJpSqtrQyZbfzLsjjPUavHCQpqgynDK5KZWuU0Kp36O5n8OKtocdWoowwX
	HmQ3gD5iiDCN6lw8JFGZhIC7J5Txy8fMI5d7WL7qmFgjTzO92iinaEDvKjpfIAZDGosSfczlq7b
	mwwnIwqAJMa4pFmKVMSMrIqE+ieqskLr2os3qyYfNTbYqh8t
X-Received: by 2002:a05:6820:7098:20b0:684:743e:86a6 with SMTP id
 006d021491bc7-69462e590a5mr16079899eaf.20.1777297365227; Mon, 27 Apr 2026
 06:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260416221819.3600289-1-hiroh@google.com> <aeYcIpw6lyUnmIsN@sumit-xelite>
In-Reply-To: <aeYcIpw6lyUnmIsN@sumit-xelite>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 27 Apr 2026 15:42:33 +0200
X-Gm-Features: AVHnY4IPZA0YVGq54b0JsXigobGBBHCMrZi0GB1-iaGwMM38-X2y-guRIDymgFI
Message-ID: <CAHUa44Fe_L5CVKnsxi4HswH2D9bCA3u14ESb6LoKqcOSrfs3Cw@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Allow MT_NORMAL_TAGGED shared memory
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.54:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.160.54:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D0D1243296
X-Spamd-Bar: -----
Message-ID-Hash: JUOPSISOFTJTJR6ZNHFVBYQJ2M4PSHRD
X-Message-ID-Hash: JUOPSISOFTJTJR6ZNHFVBYQJ2M4PSHRD
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Hirokazu Honda <hiroh@chromium.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JUOPSISOFTJTJR6ZNHFVBYQJ2M4PSHRD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Mon, Apr 20, 2026 at 2:29=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Thu, Apr 16, 2026 at 03:18:19PM -0700, Hirokazu Honda wrote:
> > From: Hirokazu Honda <hiroh@chromium.org>
> >
> > On ARM64, shared memory can have MT_NORMAL_TAGGED attribute when using
> > the Memory Tagging Extension (MTE). The OP-TEE driver needs to
> > recognize this as normal memory to allow sharing such buffers with the
> > Secure World.
> >
> > Signed-off-by: Hirokazu Honda <hiroh@chromium.org>
> > ---
> >  drivers/tee/optee/call.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Looks good. I'm picking up this.

Cheers,
Jens
