Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E95ECAC5A5
	for <op-tee@archiver.kernel.org>; Wed, 24 Sep 2025 08:28:31 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6D0F043125
	for <op-tee@archiver.kernel.org>; Wed, 24 Sep 2025 08:28:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Hge/eu6B;
	dkim-atps=neutral
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D718540B68
	for <op-tee@lists.trustedfirmware.org>; Wed, 24 Sep 2025 08:28:15 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-30cceb749d7so2846996fac.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 24 Sep 2025 01:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758702495; x=1759307295; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTVkzl6UYOFqbtfOkUTSEgWlYPfNoRJvRz5e440qqv8=;
        b=Hge/eu6BvSx5BCHoprkPSUVk3OjhZuL4vQKJMNU2tdD2gJ1wEFon9LX8PDHoJ4ps2R
         E3snbtUFfAU4v/JEhxoXiyb6kgjr6c9NN47Eql47Z3F6wkPZe1ZTOSLhELIqRcsr7gX5
         Ut/ENebLojv5xGsGAgSjXPpvQmDpRjRxeWhe9Z/uYF1W6s3ZZjOwghrXVagNI+SzvZt7
         BjgznBLO1mi7IIj1iXtsh4fR8a1/ykNDSXP1ZpBCVnFTz20jk9sVi4lznoEZ8QKlm/5v
         TfXjNxrealbE/ag9s30GAe1uOP/9LirABfPW9XNolnCaCtmaBklLZ+/SH9qvYYIhczbw
         iRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758702495; x=1759307295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTVkzl6UYOFqbtfOkUTSEgWlYPfNoRJvRz5e440qqv8=;
        b=FmA8ohPX+JwKgMkzm7YbP9gxV1shFERZUX63XWC4i0jWEh0N1sv6bJ3cc+GeS+Rnoc
         iV9fjR7ExOA7RDLJQHFs//yuOr7OdhHbrW0Iv3+/7JDYKGZ1uTgX+Eq8MFjVR7ZsCTCx
         Rr4jpJKdFukpZN3LjMuc31CBS3jvLswL7HCei1Ak/Sis7dqCQ8ivhFnVp2DT0j/UJaGr
         6ZnJ+qqRvJOj/DKYqx/Z2m2IVtwEGJviGTHKL4lvNEtun36vqdYsQXUGqXbVwXgb/Dx1
         wbvxRhxg9x+AYqYYLtRzydRdvN2k6+SiyMT+A843Ff6vLCd4kvtAdVC2k4yhdQedeDwA
         1KLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQXUIq/QaVSO2RZy7Yd/s3wu9mVuH3TZY1YezcoioXtF5QcZa/xTRcPjIO+0cJNwV4rJGnuE4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yz5VTVr588Ni0YLGxW4h9P3UbgCUGctzkdYe3NrEtoAvkhCq950
	x/+ld09I4NBUMXAiDCVvV3K9k2p++S4YAJEBDkgHuvt7TOmxY+RshhWKeqyy7cZK7FYr7Lt6kxz
	a1p6fRsx8feBJs0yEfu27IoFNfsLY0hvz8f0JBootbmrp
X-Gm-Gg: ASbGnctKSsw9OCi86DM6nO0JrkEGMXLn5ErXV4szLN01HEmyeVrN35aEl6YB6g9cOvM
	iqi/Hlkow2sE8kDR8PPKgFDOvrmAWE5TDbmVkYMVMEXrIYoHTA1zUMYTGStV620JcPlXWrkv0Dd
	XMN4LJni3x7kkJ6RJ0ELvwGWebFbeRbsgUHQLttszo1Zd9sg4s7octRiQJnhhiwzMtN7JrGzQE+
	klZkRCr
X-Google-Smtp-Source: AGHT+IFiZs3fit7JmrwTrcdOE3PuEb7BgKG0XRjkXlRJI66gxsYXWU/izU5IO2sIbpWcGOQKmMbdO6vVroeM7IP2Zhw=
X-Received: by 2002:a05:6870:a908:b0:347:b473:5f58 with SMTP id
 586e51a60fabf-34c781131f2mr3086804fac.1.1758702495151; Wed, 24 Sep 2025
 01:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250922083211.3341508-2-jens.wiklander@linaro.org> <aNENxpvdpW7ItjgT@sumit-X1>
In-Reply-To: <aNENxpvdpW7ItjgT@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 24 Sep 2025 10:28:03 +0200
X-Gm-Features: AS18NWBtHMnzvD8ACh0gV2MjOlJFNbL_oo8xYwwc8TnXxOERP-GW5Ztr25D4Hzo
Message-ID: <CAHUa44FtbqOnbBvOSNkX+jdqUK-+hTAM3hYseMPbhOt0U_Nxqw@mail.gmail.com>
Subject: Re: [PATCH v2] tee: fix register_shm_helper()
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D718540B68
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.42:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.trustedfirmware.org,linaro.org,gmail.com];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.42:from];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 5FZLBZOTXKEL3YGTIZAQRKFLPHBMGZ3H
X-Message-ID-Hash: 5FZLBZOTXKEL3YGTIZAQRKFLPHBMGZ3H
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, Jerome Forissier <jerome.forissier@linaro.org>, stable@vger.kernel.org, Masami Ichikawa <masami256@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5FZLBZOTXKEL3YGTIZAQRKFLPHBMGZ3H/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, Sep 22, 2025 at 10:50=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org>=
 wrote:
>
> On Mon, Sep 22, 2025 at 10:31:58AM +0200, Jens Wiklander wrote:
> > In register_shm_helper(), fix incorrect error handling for a call to
> > iov_iter_extract_pages(). A case is missing for when
> > iov_iter_extract_pages() only got some pages and return a number larger
> > than 0, but not the requested amount.
> >
> > This fixes a possible NULL pointer dereference following a bad input fr=
om
> > ioctl(TEE_IOC_SHM_REGISTER) where parts of the buffer isn't mapped.
> >
> > Cc: stable@vger.kernel.org
> > Reported-by: Masami Ichikawa <masami256@gmail.com>
> > Closes: https://lore.kernel.org/op-tee/CACOXgS-Bo2W72Nj1_44c7bntyNYOavn=
TjJAvUbEiQfq=3Du9W+-g@mail.gmail.com/
> > Tested-by: Masami Ichikawa <masami256@gmail.com>
> > Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer=
 registration")
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> > Changes from v1
> > - Refactor the if statement as requested by Sumit
> > - Adding Tested-by: Masami Ichikawa <masami256@gmail.com
> > - Link to v1:
> >   https://lore.kernel.org/op-tee/20250919124217.2934718-1-jens.wiklande=
r@linaro.org/
> > ---
> >  drivers/tee/tee_shm.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

I'm picking up this.

Thanks,
Jens
