Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A71CFD875C
	for <op-tee@archiver.kernel.org>; Tue, 17 Mar 2026 12:22:21 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 49E0543A93
	for <op-tee@archiver.kernel.org>; Tue, 17 Mar 2026 12:22:21 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hDpuqJo7;
	dkim-atps=neutral
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4DEEC40B21
	for <op-tee@lists.trustedfirmware.org>; Tue, 17 Mar 2026 12:22:03 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-40438e0cba6so3589205fac.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 17 Mar 2026 05:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773750122; cv=none;
        d=google.com; s=arc-20240605;
        b=VtS15qGMUp2OYGt1CWMMUG1ApA9BiN9f7HVrH5puh91QDGiZ61DlCux5L1e0ESp8Qg
         4VZ6E4rjY8ae/Q/06PuWQyjX28f3SRefPnnNJnSaQ8FX3sllrsljankODBwN0GeVXI/C
         j71ugk4K5eivq9FvRUFzTdiKREyWNyw3Betfgkq6+ZgvKWNlw0Uinzd7rJWJerfomZxU
         RguvQVJusHI2FDlCrF09aqBUM5MuIYHtOPX7C76kkb5xZGXLRE4hDhClfsExPoKLFeju
         nMboWtahYMhHdX6ruW7JB74dtWbEuJOEQT2T188KAPA3RXo09+9+eMo5lcOmQ2zNPyoK
         D33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZZAlly6r9Aj/G7mBI0TIakScb7FVS3esqnlgh/50biw=;
        fh=/Z/x50JmPtlx9qyVbroD35kUsYmAH0fvEMzeo5fdm6o=;
        b=FP66WNSWpVES7N/EXhqdOqhJgIbauIGfLacwbTrQRzo158vi4sSaZZrnGciG6aIcR7
         uN1U1OCEeiZzWhsYeAXeE609E4XXM15A0a6ac9Uix3AKKiNIS68KO3AcGj2V/WQ4GrFa
         lUxzhtT5Php9jO7anu4To9nLSfEQRwV4iQHfUEdO/mnuuIV8Q3ldYYsEgLb2xMb7JqK5
         iDFgC9dTyKTpgckcYXzUygsH7qh9QA9uBATJdH6vQBCew7Cb+6CtPObMuwo/xBBlIZZY
         GA+1JYBJfEBPGsKVznseqsIHFMzWL7V17PK/xZgE0PKS6XPKVt5HHkEa8XbBgNgSYpqh
         /jsw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773750122; x=1774354922; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZAlly6r9Aj/G7mBI0TIakScb7FVS3esqnlgh/50biw=;
        b=hDpuqJo7bKnjzQJ6rX/3KNgE2DENeI/LdYregGwby0fXMR7ocKyJ9BKmMynnQ0Uz6o
         7uOV8RYeBcFokD8F+uDysmvpTdXL/jfcUP3WqTzkOQh/TQISy4zhPY82MbWuah7SqyeK
         AgP90RphyquSZErCcpqOGzMB42z/O+mvHS/AfK3z5z0pFHrBXAmAyN5pm/0njnnONce2
         n2v1jdBp+9k+eak2EBimukdgA1zdHh58ZphWJiLe8mz+YIC8I1lIdszTlGHSdpY3j451
         HvdKkL8/3NgE5zNs4aEultk8ljQJ9K9STzwgY3ahlTE91WUvJyjWybliEMyPyFHKI992
         vJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773750122; x=1774354922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZZAlly6r9Aj/G7mBI0TIakScb7FVS3esqnlgh/50biw=;
        b=aEzwuie0GzN6OYumHCGLbkb7YikPmqldTPsjgApbPxzJPinymSHVt8SOxHiTT/w7W2
         VHt9SxEIyFiV7aCoyIiA01/PPMCTq5XI/RhjNT3RQn4KWQQwPxkE6MWvyI2QL7OqKuMa
         LBvsuoRAGhZdK44gc4B1f/XUwewhN9idrK2g7TiuMkYTPIbogCGOujwW1Wi81EU2USTt
         VH2ptpTHIq7HdxAXkYZH7wcu/9+eIRJWdN3uJiuPqGtK8jXYtIytgfCJcYaeqDfjCMc1
         qzsqVcRdWPaYP1eZTQG4ilO2odHDL7M1WswiMQuoPYekiPWPg2NRVD+0pBz+35fZ9nZ8
         w3Kg==
X-Forwarded-Encrypted: i=1; AJvYcCW7eUfcS55OKuE8QSw2py6d3vHAAg9cMAi+SmavQJeFdCBha7dUh5vjJakwXkpgycn0wboU1CM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwN2A/PehLVqnJD233QDPqa6An+9/mG+EB9E0Tjn0yQgQDtQ303
	+lHt2LbE9v24UaMHsPZ3kc3tn90aopFEUIxmor3sKuZV0oTT9+Y0NIwa8JiK08frvlCRHPEsHUG
	U4vP6nHD16fWDUCdymkUCniA5TpUZGgU2PwZyOE8txY9C
X-Gm-Gg: ATEYQzypOgxYmrPlFA5vbsVHeAIwgGMDdO30PMLNcB+nr6V4vqfkDB+RGxWKPNr6PPm
	1lR5NzJVkke8R29BKT6lJuvZoFaYvvLLsSUGEEd1DMtIxsm0nGTxliegarPJp3oU5bEP67PaorJ
	UooLjY6stGsskXEqhjlHZL+3qjY2R+bo9sg9gww80cggxyYk5k3TLUSeo9reW3RNwOg/kpf1Jm4
	fNhpIqDigXN6R/SD79BS1UcG7CBaK3yS3HXIurhE+cvt716Ld0m0xVytF5uB65298CFrPjtyiVS
	wlbKUGNKdEAACmpK+SfImglFlksej1I7foegnw==
X-Received: by 2002:a05:6870:21c4:b0:417:5105:a735 with SMTP id
 586e51a60fabf-417b939919cmr9271254fac.33.1773750122269; Tue, 17 Mar 2026
 05:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260316074150.GA2474723@rayden> <20260317-illustrious-finicky-frog-90a86c@quoll>
In-Reply-To: <20260317-illustrious-finicky-frog-90a86c@quoll>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 17 Mar 2026 13:21:50 +0100
X-Gm-Features: AaiRm50DKtbSrt7RM-eiLNZ8ayhaRAs54Q936PCav8QiX1F0CvpkM0JNYHHVlF4
Message-ID: <CAHUa44HXjrPbPv0sBxzrW6o1iQVWdp2p-1-jroukZ8dxSvPmMg@mail.gmail.com>
Subject: Re: [GIT PULL] TEE shared memory fix for 7.0
To: Krzysztof Kozlowski <krzk@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
	Marco Felsch <m.felsch@pengutronix.de>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.49:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.49:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4DEEC40B21
X-Spamd-Bar: -----
Message-ID-Hash: DREZ4DC3AHAPLKEQENIUPOVJND2GKMB6
X-Message-ID-Hash: DREZ4DC3AHAPLKEQENIUPOVJND2GKMB6
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: arm@kernel.org, soc@kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DREZ4DC3AHAPLKEQENIUPOVJND2GKMB6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Tue, Mar 17, 2026 at 9:51=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Mon, Mar 16, 2026 at 08:41:50AM +0100, Jens Wiklander wrote:
> > Hello arm-soc maintainers,
> >
> > Please pull this patch removing the refcounting of kernel pages within
> > the TEE shared memory helper.
> >
> > Thanks,
> > Jens
> >
> > The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5=
f27f:
> >
> >   Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git ta=
gs/tee-fix-for-v7.0
> >
> > for you to fetch changes up to 08d9a4580f71120be3c5b221af32dca00a48ceb0=
:
> >
> >   tee: shm: Remove refcounting of kernel pages (2026-03-03 09:03:04 +01=
00)
> >
> > ----------------------------------------------------------------
> > TEE shared memory update for 7.0
> >
> > Remove refcounting of kernel pages in register_shm_helper() to support
> > slab allocations.
>
> That's a supposed fix for a year old commit, not current RC, and the
> commit msg does not explain what is the bug being fixed here. Looks like
> it is doing improvement, not a fix. Can you provide here more
> explanation of the actual bug being fixed to justify this going to
> current RC fixes?

I'm under the impression that it is a fix rather than an improvement.
However, since it has been stewing for a while, it's clearly not
urgent. I don't have anything specific on the bug fix, other than that
we're supposed to stop taking those refcounts. Perhaps Sumit, Marco,
or Matthew can add something?

Cheers,
Jens
