Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA3BCD8C8E
	for <op-tee@archiver.kernel.org>; Mon,  8 Jun 2026 06:30:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5C3EB44ECC
	for <op-tee@archiver.kernel.org>; Mon,  8 Jun 2026 06:30:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pTT0HDqw;
	dkim-atps=neutral
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B465B4374A
	for <op-tee@lists.trustedfirmware.org>; Mon,  8 Jun 2026 06:30:29 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-441b5b4af7aso222226fac.3
        for <op-tee@lists.trustedfirmware.org>; Sun, 07 Jun 2026 23:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780900229; cv=none;
        d=google.com; s=arc-20240605;
        b=cSYzUfDtuTHLvcHFK+kzQKIwuEP9o2SoRcQg0YgmXI5g7KhFHEndTd16B6PZC7LMlr
         Er/NvepiOP4lt47tGh8hk/rvps5WjM75CVG0K3wGX/Dvj+CT2EOpoYfkMVU/IRqG0O78
         G9Xy+Z6KG+Ru/yc3W/PrITbZMS6OlwjMFuXxhSfigtTeSm8GuQ+oqEOkqdA5NNGYyFfB
         kGxbOzDMJdm8fqVneCyVD6RTE9QEifOHwiUhIEFmHcLagl0Fa58Htad4ch41wfFEgi8g
         y6QKidtH1nE6TkuE8xCKjLKvWu9ai3M2PKqEtdbyxWpaw2R8G4AxxBUE++AWzzw2f3j8
         Cu/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cF6fB2N8LuORhWnBuQP8LeIeEYj2bNNqRhPeb4/SE38=;
        fh=MBhB7nPpNjfMN2sDogV22M4O//6VSOdbYeiSCkvg3nA=;
        b=GXJ2r7utDU0O3OBI4Jb5KXImjJWMW8pXHLvO9eBlC4gxmiHSB/yOxLJuz1rjQrNJJY
         ojTzNvMsIFYaYOFJhNx2DY3IpkpGGiCt67GfszPpx4/Vj244HbHxXNtk8CY865ktwPO0
         WNzE3Ykc7Je0QUyg9WXEwxX2e//t+teGnIkNLtCeypdIHbqDHprSJmv80Vgg9+MA72gx
         /LYoIq+iMbPmP5gB0H2wRFNP92Prld7ApAY0H3Mv2jcNxKu3qs9PQfcVwO42pvUQNgWP
         J/JCLqff+H5+iBWbx6yjvRCRc0TClLyL3hw8zXlJDleM8762A+AwgdxjsdMbayVBlEz0
         sN/A==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780900229; x=1781505029; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cF6fB2N8LuORhWnBuQP8LeIeEYj2bNNqRhPeb4/SE38=;
        b=pTT0HDqwMQGjbA6vni+/IJdgXtTNo4trGHqXgwhSfG+LzM/010zKJ52xsbQgrTSinv
         Y28cGeXZFTlPN2aNbO5poFTHFw84P/lZvnbSPuvrx0gi04X61J85D0dFOK9YEiMD9n0e
         iineR5ocQfg7du5JCXTx3F47J4BnYXFOqQqIvHnOCBsEVLgMeRio6yCPF76f5yPSzTBq
         lNW67INiPCgMG8oJUoJvOFA03An/CY9D47VpGzIOSkqR+mhbTf8zBZEa+Db1YvEaJVXr
         3+rH+OVX+TmLVrM2X0ophGmv3XG6IQbfIDESZIfm1glTDxSZIAQ39mrcXzAeqiYMj4DD
         uTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780900229; x=1781505029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cF6fB2N8LuORhWnBuQP8LeIeEYj2bNNqRhPeb4/SE38=;
        b=C1fc03JfrrP7xXLi5kRb3X3Oaau6QUKMGQC3KQhzdVV//foSunZ9I7vUBd8oncPf/k
         LSTgTz5+Pb43l0U4+wVyYy0/PvazQBTAoLbBYl6iE3LR3jS5vcWxrFXBL7yJxWPvc2Of
         333hhGIF1H++VR1VgsusaR+mnMURMq2BkQSrLcp3IDdwku/9k2qKceoMdZdrhkjPjjje
         AaPPCObzhvUB97ohvth39qCYLW7olE1dVJJwtGmL4CBcjlgavm3olrj0GZ+IX/8jEEPm
         8lmqdIrJ9eapNbW2Ko6rHeDxpBUA6gpNoDA+GXHHycoy0vz+UWKJZ2kAdnBOA1uQBICW
         mH4A==
X-Gm-Message-State: AOJu0YzALDr4tTNfTexrbjkFQc/Pqwpq/6xo5XGLcJwCnzV0YT3MU65X
	/DINlj2ScVBk+IKxh711og4hKEEvs06GWdlViH5Jdk+16doOwr2RmORkliax1piLbGQ1NzPiB/P
	mOxuY6uTNZvJ2DV8ELed0ITpjNGGSo9fjNXjWFJML9Avvqei/WAIs38jETw==
X-Gm-Gg: Acq92OGHxxVXJCywiTqj9yMJWrvsAVfIvG9Yn9QVjmhmSnl+EcEdaf6K+P1Jwfryk6H
	oRLCP/PFjd/hVIDi/YJmZ7rBw/el4MEHNf7Q2Pmpc29jhqaZqomwIy44Jaubbneq0ZplBgrRO+r
	3zYF1bXo0t12YKL2ctS1ueR41sQZCZcqSDyhqkRWii1zRTjozENvlFvHJ1+BSCI+bn5lHo0epFQ
	ybYVi3o3ZAvyQiCa+E8X0z5Mf4QHtbe85iLVw+r7VqjPJseZqkqT6QUzV6UZgOYtFp3n+s3sfxp
	Y52RpKXw8TZJw7zQupc5Hymv/SOrP+++7Z7SzGXRvE+hHCnX
X-Received: by 2002:a05:6871:4190:b0:434:5c90:9d87 with SMTP id
 586e51a60fabf-4413d848143mr8357950fac.12.1780900229071; Sun, 07 Jun 2026
 23:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHUa44GNE3wMTD-pu0fwyXquyAywiR6FjZBG53j=du-pb+8u1A@mail.gmail.com>
 <mdof4zapmokna4wv3tm5a53tdrkyu2tvfrng7h5yzvoadwywnd@ph7l6otpgryv>
In-Reply-To: <mdof4zapmokna4wv3tm5a53tdrkyu2tvfrng7h5yzvoadwywnd@ph7l6otpgryv>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 8 Jun 2026 08:30:17 +0200
X-Gm-Features: AVVi8Ccx871by8mQ9tsIrcrPPBQGcfUf8diK66bam8bXB3V7FmMTZEc5m1QccGA
Message-ID: <CAHUa44EWMM2hSpVUuvT0kW9vf1GgxiAV26utOinKrn+Lq0n1AQ@mail.gmail.com>
Subject: Re: OP-TEE Contributions Forum, monthly meeting May 26
To: Marco Felsch <m.felsch@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.49:from];
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
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.49:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B465B4374A
X-Spamd-Bar: -----
Message-ID-Hash: 5BEOKSPJPBXFYROUZH6KJV2QZMTAHA4T
X-Message-ID-Hash: 5BEOKSPJPBXFYROUZH6KJV2QZMTAHA4T
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>, linaro-open-discussions@op-lists.linaro.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5BEOKSPJPBXFYROUZH6KJV2QZMTAHA4T/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Marco,

On Thu, Jun 4, 2026 at 10:57=E2=80=AFAM Marco Felsch <m.felsch@pengutronix.=
de> wrote:
>
> Hi Jens,
>
> On 26-05-25, Jens Wiklander wrote:
> > Hi,
> >
> > Tomorrow, Tuesday, it's time for another OP-TEE contributors' monthly
> > meeting. For time and connection details, see the calendar at
> > https://www.trustedfirmware.org/meetings/
>
> Sorry I saw this e-mail to late since I was in Nice last week to attend
> to the Embedded Recipes.
>
> > Regarding Kconfig support:https://github.com/OP-TEE/optee_os/pull/7714
> > It appears that the transition will take quite some time. We'll have a
> > window when some variables have transitioned to be managed by Kconfig,
> > but others remain managed by the makefiles. Do we care that variables
> > passed on the command line may work differently, depending on whether
> > they are managed by makefiles or Kconfig? Can something be done about
> > it?
>
> Could you forward me the outcome of this discussion? I hope to continue
> the work next week, since we _really_ want Kconfig support.

We agreed that the transition may take a couple of years and that we
should try to minimize confusion in the meantime. Until we've
completed the transition, it would be preferable if, from a user
(someone who builds OP-TEE) point of view, it doesn't matter whether a
particular config variable is managed by Kconfig or by Makefiles. At
least when building using the build git. The mindset should be to
avoid causing any problems for the users. Documentation is helpful,
but changing well-established behavior will cause problems.

If the above isn't possible, then my view is that we must plan which
config variables we transition. Then, after each release, we select a
new group of config variables to be merged in a single PR. Or
something like that, so there's some logic behind how different config
variables behave. This will make the transition longer and more
difficult, but that's the price of making incompatible changes.

Cheers,
Jens
