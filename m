Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FBDC87FCF
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 13:44:23 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3E87F4FCAF
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 13:44:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fixdBtRW;
	dkim-atps=neutral
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C301742E7A
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 13:44:09 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-30ca7436450so2068754fac.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 06:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755092649; x=1755697449; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eihVYJrWZXZh50n0+ltviNDHEcxJdrJFasVcbGTuMaM=;
        b=fixdBtRW7CkiDzM2zIo+tTJd7OYxNtUvTerXYL8FSIwifGIcBERWpQvSncrjKc5c6e
         JDVzbSkewNuzYF0yJWHoh/MC/adBv5bDAZ6L+FlOcxGDbVM8l8iUH1CN6Q7OXQsAJVBC
         mtn91MlzhlRUt1iQ3rIRMbs9sM1Pwrdpi2PPHgNBPMdffEf8DPzKr82Jw5QEuq08sTw+
         o2CY/r3Dangp9XShwEZZyY9pzXKElYfF2wAx18CcegiAZORZv6O4ocvk63o7gBt+T87t
         piFpCJPiwTXpfYGOyjOtLrTKjn2e12bVJA49X/dBMkBzGwunh6+1UuuVwlRx7ah9mE+i
         gIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092649; x=1755697449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eihVYJrWZXZh50n0+ltviNDHEcxJdrJFasVcbGTuMaM=;
        b=YHoFOGjlCAD7h3pEu0q1CRKRSGGipvtc7N2+hjZPsyfC07oUebo8Y2WtxCOkiVRQSd
         sz7mwXmT4w8xFGlURHuiKYoRPJvTNAXawhJPh0KXwZ+ulQHzTSPyxZ4yKw3WK8QuDUgp
         85SUGB/4dP6LtvctGcQvoLni/S6t3809nKpB68NRlrLlvmNfeRn3PCCjLGrRp8Ro7Lqe
         h2Va4I+JeG3381C3RWOoJHkcCndM6kbG+C7FSNLFGHNbv4Q3WSn45wVTRBJPCHA022rL
         CdPGk6CVpvCWBFg+2GRDtlFff5VH49U4D/7ax1wBA2750+eZj7sIP4+oy6R5KklDam5w
         6rgA==
X-Forwarded-Encrypted: i=1; AJvYcCXDntoB0OQWtrkS596s1fthwLRuo08kczuChSSKiYB7piBEmnJrLzge1r/SYxicWUzPdEvvQGs=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yze29NWVNPgVPCFhPu/Ee2J3Owt9X6LVIPIPy9qpZWcUJeh6F5A
	zAusyy878supCZa+jqh5MO42f2B6syE0LCMjr/H9jjJ4Evol2csbq2Qz0NEfS9YZi93G598E+3V
	fxevpJEeyFMBn6gXh/60udyxcuet9FRLmba1MR70ja4FA
X-Gm-Gg: ASbGnctH0clmFIYsEUYTd+byuZCPt+cjgK57e9fPHiFXVQCPIIGrgmLn8C6WFzzSULA
	yUsMArAwz3VU0urI9MafnuFYyCm6ACJiUjNZ5jE2jJlmjl0piObu2jZgPBuTeGN+tt4Nx6pErbP
	E0jpjclWqT66pUmXeueDn5J1yA935RHZzUgOXc8bG4BtHeRKvK3PsmGnPfuaN5lVx/Qztegm1h5
	UsMeHgFba0IYBPOpiE=
X-Google-Smtp-Source: AGHT+IFU/NdbN7AcOZEv17USCBNw7GfCExUxIp81La73W0v9orSy0kbUcXLAKbnNYawjG6YyllhAALem09uD1POoEws=
X-Received: by 2002:a05:6870:9a1c:b0:2cc:3e39:7352 with SMTP id
 586e51a60fabf-30cb5bf9975mr1878664fac.18.1755092648901; Wed, 13 Aug 2025
 06:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250801235541.14050-1-ebiggers@kernel.org> <aJmKDyD4weX9bR0U@sumit-X1>
In-Reply-To: <aJmKDyD4weX9bR0U@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 13 Aug 2025 15:43:57 +0200
X-Gm-Features: Ac12FXw5rXcIObB1VY8YLwwvPYahf_MM_W0QzWG6bpFq_kd5MWctpI_dBq2BBok
Message-ID: <CAHUa44H1V0qR7omO8KpNxaW_bkXZAbaka=8r-zp+f6vdYs6fQQ@mail.gmail.com>
Subject: Re: [PATCH] tee: Use SHA-1 library instead of crypto_shash
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C301742E7A
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.51:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ARC_NA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.51:from];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 6K3SMEN6T2PGVKBSHNBWNTO3TPSBAJLW
X-Message-ID-Hash: 6K3SMEN6T2PGVKBSHNBWNTO3TPSBAJLW
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Eric Biggers <ebiggers@kernel.org>, op-tee@lists.trustedfirmware.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6K3SMEN6T2PGVKBSHNBWNTO3TPSBAJLW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, Aug 11, 2025 at 8:13=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Fri, Aug 01, 2025 at 04:55:41PM -0700, Eric Biggers wrote:
> > Use the SHA-1 library functions instead of crypto_shash.  This is
> > simpler and faster.
> >
> > Change uuid_v5() to return void, since it can no longer fail.
> >
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> >
> > Note: this patch depends on the SHA-1 library functions that were merge=
d
> > in v6.17-rc1.
> >
> >  drivers/tee/Kconfig    |  3 +--
> >  drivers/tee/tee_core.c | 55 +++++++-----------------------------------
> >  2 files changed, 10 insertions(+), 48 deletions(-)
>
> Nice cleanup, FWIW:
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Looks good. I'm picking up this.

Thanks,
Jens
