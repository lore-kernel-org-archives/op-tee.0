Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52058FF885E
	for <op-tee@archiver.kernel.org>; Mon, 27 Apr 2026 08:51:51 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 86F9F43EA0
	for <op-tee@archiver.kernel.org>; Mon, 27 Apr 2026 08:51:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wUX2gUbn;
	dkim-atps=neutral
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 31F2C43E5D
	for <op-tee@lists.trustedfirmware.org>; Mon, 27 Apr 2026 08:51:45 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4779b2497b4so5741016b6e.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 27 Apr 2026 01:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777279904; cv=none;
        d=google.com; s=arc-20240605;
        b=YNw/RtvpXejxRissPT6ZSKSE6mdmcHYTkQTuvKUWZRdscZpssRD5MpSQbbfx0Z+JXR
         5PMN3RugawbHxm2J1FZe/deVBZor6zPCIioDdVH0hI2Bj2yns2lG/PgWL+Dqj5Abqub4
         94CdOxBCpvcwL/StjirSZPAz7FN5Y0Lx1a31MY2FrMXDsnZpJVlreRO2mE9WFcY9EnsK
         ssERSGSPDy+/hNBG61/7lquuwUZcZhltPIQ97u0x4uVutdlKKiYtaIKHaIwc51J7+P19
         ZcpaSg7OhqePFdhOOJmWigWViOSNP8/advF5ygGowH0kp+DbqiGCNbVChwHKcCASfKzc
         uwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XT3gbcq+fk250A9gsnTsBOtjpgbR19UnsNKNoI2tldU=;
        fh=2MRiFYyW2yEu4bliipz6LUTPqHoxA9OTMlHWGzYnOB8=;
        b=gyCQkodg5Wsedg5y8OgAon9mywMaxYvNta0wiI8qSpvUxI156QMKuNXnD4jMB4sfxZ
         s7uw5H1XtEj/Trk4uWp9fYS0IrU7uDTvn0c2HG5DF8HnQCUSjWYTn0m0yzTbYUV/xqnE
         UubSqMMUrFfdjkqvCcqWwjlZZvlqL6G/n1CPr14x7TUnUPOSap6ZWx1s5gb3nU2vb6cA
         SmYfFe212wXNQ7gfgVIVpJls5W1+jl2h2PdNyynEYgbhvjIyJ1MSZgbex7T0H0KRvzkb
         HqMsar22hhEJna6ieWhIez0iCNL720bdGQjieJHENxI5morebmAmzHUGkBpVKmrBdNH0
         tVVQ==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777279904; x=1777884704; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XT3gbcq+fk250A9gsnTsBOtjpgbR19UnsNKNoI2tldU=;
        b=wUX2gUbnrCitaupdenPLUz9RReR2be9fEFIdvbDEihj92gns+PztT33B4Ximb/2aD/
         n4BRqk71TyQrT2ZCfGQsu84pa2AJ5b45b8HZQGx7mVgf2M4VZveHVTXOKR4gNTlSveFp
         CeNsmnxlEq9st8I725J1WR9FdHYGfiUzGtYV0ucVEQwTGqFxAayIdDRY9GkxbX+CA/A3
         6msYPiPHR0nntT+cc54JKrB7REbE3lhSmFXB6iBuKs/2o3JYqjthk8lOOdlv2B1gRNFK
         sM2wtIc29f0Pj76+n0aIdoxSGlpXFdrqRqS5hpdHWfoxn6zlr/2wKSYhfd773UiXftL6
         oVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777279904; x=1777884704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XT3gbcq+fk250A9gsnTsBOtjpgbR19UnsNKNoI2tldU=;
        b=JBI9SVWf9V2bdRGQDY1ABZh87LngCD3+XLTimtGsoV1dSSay8oaChx/ufIwbPbNO8P
         f8jvutE7WncQEQ8iEK7O/6LxlApPQ57ekzbHrqA8VZddRYhm8U6wKcgTjBbkz7u1QK/y
         GGqglmNKZdHmLemcvKJECfkstqMp6jlya5rwqpLQmihrpV/M7yhH/816cf22TVXAlXbM
         uha0HNfVAcwDxfKm53yv9DwsZS0AwOTQbaaWSD8/zBS5GAmo1bS3fb4IL7vsartea5Aa
         R3h/oZ4yi9Z0+3TwMEtQ9ewgyte0o9XqUUib3/HNdm1171hv24sbCSKZC1aMa3/mYFJR
         J0wQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tzpqMGPn4lYVh+cdEUFeXLpl3hDmi/aHuKKd4SpiFMTKVHA08AKs/Cbni7/cVkXPRyZFsNWQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxtmCdN5I2FzOXMOoZXggOFhohJC3V8Bj/KdCS1Ab/8cECauW8A
	FIK8ZunH8WfgbBa/lHmWjjuQVK1h/8Unojch554MqSkZxAyXa28+g0BiprkQCHrDAS/b01mJGZ4
	9rRHRShCOB5u+mLhPMm1HvyDsGeB5vNpq12oYHvtdznLr
X-Gm-Gg: AeBDievk9GdFcfEWNGMF6AzLKJmEjspuwhGhXA29L4JHpdMkiHtY/dQEX/oYoadH36A
	OwbCwmjPMMRW2l6DsQwUxEED4u5Ll46IHpFywQaLL8sGmVqvfEKJu1DU2WRivcsC+kqzkqZsswh
	4bM667KvmZ+/TR3ljksMwzsFyQPrID+zUqwHdGkKi1LYqJTnvyvgOxRmktxqG6qZZmqJg5Q2KDB
	cg9dX/N1Fxw/DdOIuhZFSZof57toLnMysqfLDMEAzRa96MT6T7HJdAzqyFEwXp4VEJgvY0cFy3B
	7tH35mMDDi6/AM+ZHi8yowiFnLaHyZvPwHlGT44s3jAoJ1GOg1yHOCRbO1k=
X-Received: by 2002:a4a:e903:0:b0:694:8ed8:e57d with SMTP id
 006d021491bc7-6948ed8ec24mr16715234eaf.58.1777279904554; Mon, 27 Apr 2026
 01:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260316071210.GA2470832@rayden>
In-Reply-To: <20260316071210.GA2470832@rayden>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 27 Apr 2026 10:51:33 +0200
X-Gm-Features: AVHnY4LMRWaAwM9YY5FDDDuE2oBKAAMdMaxEoXqUa_2V6ezVDw7lz7SimrvLSMM
Message-ID: <CAHUa44Fpy6Dywfe-UA0Wx0v5D=jb6=SNiE+Wi0g08EtCNLepMw@mail.gmail.com>
Subject: Re: [GIT PULL] OP-TEE fix for 7.0
To: arm@kernel.org, soc@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.170:from];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.170:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 31F2C43E5D
X-Spamd-Bar: ----
Message-ID-Hash: QNCVWETNCWCAPRAYER5TIYYECNIGHO4R
X-Message-ID-Hash: QNCVWETNCWCAPRAYER5TIYYECNIGHO4R
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QNCVWETNCWCAPRAYER5TIYYECNIGHO4R/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

It appears that this pull request has been missed. Can you pull it as
it is, or do you need a new pull request?

Thanks,
Jens

On Mon, Mar 16, 2026 at 8:12=E2=80=AFAM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hello arm-soc maintainers,
>
> Please pull this patch fixing a use-after-free race in the OP-TEE driver
> where a client exiting prematurely could free a request still being
> processed by the supplicant.
>
> Thanks,
> Jens
>
> The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f2=
7f:
>
>   Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)
>
> are available in the Git repository at:
>
>   gitolite.kernel.org:pub/scm/linux/kernel/git/jenswi/linux-tee tags/opte=
e-fix-for-v7.0
>
> for you to fetch changes up to 387a926ee166814611acecb960207fe2f3c4fd3e:
>
>   tee: optee: prevent use-after-free when the client exits before the sup=
plicant (2026-03-02 14:36:50 +0100)
>
> ----------------------------------------------------------------
> OP-TEE fix for v7.0
>
> Fix a use-after-free race between client and supplicant by serializing
> request access with the supplicant mutex.
>
> ----------------------------------------------------------------
> Amirreza Zarrabi (1):
>       tee: optee: prevent use-after-free when the client exits before the=
 supplicant
>
>  drivers/tee/optee/supp.c | 107 ++++++++++++++++++++++++++++++++---------=
------
>  1 file changed, 74 insertions(+), 33 deletions(-)
