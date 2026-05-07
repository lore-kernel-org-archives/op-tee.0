Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2FACD343B
	for <op-tee@archiver.kernel.org>; Thu,  7 May 2026 07:31:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C9D3A44D3A
	for <op-tee@archiver.kernel.org>; Thu,  7 May 2026 07:31:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vQEccjDJ;
	dkim-atps=neutral
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0BCA443271
	for <op-tee@lists.trustedfirmware.org>; Thu,  7 May 2026 07:31:21 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-408778a8ec4so279527fac.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 07 May 2026 00:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778139080; cv=none;
        d=google.com; s=arc-20240605;
        b=HWweQbBieOqSHeDafu4XO2cWvZCzmohfCcVvfqMEpobbG1myjKaMV1GQJoVuwqpMxB
         CTRic1qK7G3Z5d84ogUXZR3PcsUXhGL7RiAqU9f0qJ3O9yjoClLm9xQiY9UC4o3XWM0s
         yIbbsz8jFGR8usor7zol3Pcu+xImp1xAEcpo/nX4IqqKmafx5gQldlGqYthqCNlEhYp5
         Lb35PYkuANWJ6Dr87G/J1JlIUB6swGFwaakK+0RYED6rXCglPwj1hfuVXYTrzs54eJmp
         LZ5eU7ltdof2rJf1K3pO9TTaxhqEMAYSxvaqJjxrK7jK3XcJZTsZOP/j2/zs8iRCtaB3
         xM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jFOQdIJISvoPXXvxTeBBdH00URrGZUVuDlNO/Sgrz7M=;
        fh=a8ed3lWwtOtRX4mVqa0iqBvuOYoBJHm2lTmhvNQ+cXU=;
        b=COmAeditc2QV3bTCPltbmCRw/Q5hrAbH7lCdn/SssUfC9A+RiCLr0KMPTsn2uWRwgj
         NCByQVVbfFBYTfai89RvKf7amY71oAz2zBSqNWBeLxRpOhFaG7z3WolfxBmY5t7pPXJ1
         bFrMcsXM/JIhZpW9w7wx8tMz+8FygSSDJ7oQJNO4ICe34444Wt5MaZ38NnSREANnJB8b
         Pf0U8PUI/nrrxl5VEeVY1NdHITjH10C9atU9ImPaSNXfAYCP1zYQhgRI8mpeuiFEUMms
         g24tGUs0wllygjKT80x9vRM/fJsgVY8gus7XHL6BHMFcT3BS7AzBsKaHT8q0l/5nDR5s
         ZD6w==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778139080; x=1778743880; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFOQdIJISvoPXXvxTeBBdH00URrGZUVuDlNO/Sgrz7M=;
        b=vQEccjDJEiv6cMSU9VTXoP4AR7YuaPzlefNszuD5dPwRcSgv22wuxBJ3xdhzeEo3fE
         UUvPnqZ11YRUmOZOmH02hiHwAyW9IVFTPsLRTjn1dhUZ/39K/n3tcSmFQ25cNyooOe5J
         PgSsbdT6xroqEIECjKX7lev3aGny8gjfldeR9VegCsMZQRfbPv/Mhfm1+MtVl9PSzS0b
         lC/cIKXi0IFIG9aF3Bti9R3rInABKg9xFivRfIfQGLCiIMCMaPXLPy65Iq/oew4AA7xE
         LyI8Rfo2wuFlMypkjPToSNFnt0UsvAxTVYKyPDDf6eNOzNo4oWADV+aIDvC/m7G6JD8y
         3jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778139080; x=1778743880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jFOQdIJISvoPXXvxTeBBdH00URrGZUVuDlNO/Sgrz7M=;
        b=k6qfV08/suj2OXXlMmC0ZZH+gvzz4vtH8pFYAAQ1QVSSa3sLXllGfewvOePs8q+sI8
         NzZ7u6cvLsNx6NUjpKL6ov8uni5OkSCa97h4pviDBMjg8DDPUyQRqTi/fbfAX2pPH0ji
         lO9buCEtOPz+dc58yZL2QEu3aqvPtT61YrIOmrSmSMWrQCvKAEC0U/qnt0SUiiu/y7bQ
         hihaqCs5F5yww3WoiH7PvKlcmBkvnooSvhp3XCT20TeVzJEmFqXNnCE2/ko1Ja6c2Fpu
         rw2NNCpUjCAxV3cPvCQV4KdXcOWoZbPCjmqk8Uf5qCBUIY+U8bIACap440zH9TASotv+
         a1MQ==
X-Forwarded-Encrypted: i=1; AFNElJ9FeCZ1pk1rFzGnxX0vSlQbYcuSMlABIhTgLcS8PHUP2JdObvhIZBogx9DZ5iRdR4cCVC3zBYY=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwgqZjKVj8uXn/w3c4cB82f9H1bph67ydLewDNj//SJRhlR9a8p
	SC8Fz2wDSzn/oAxr6vm/S5wLo9vd62FTWKb+D70cMbKM5ycp/T393yttFtxyz3zArm03nQ2G3Yu
	AbojKGXHfOcrcEzzVmlsCkloH7hx0wvaVJaVBZsCVpM8N
X-Gm-Gg: AeBDievCaDhbc67ymnkf6Boa7gojH668ihctFfFYPBXtlFlwYnNVefX6yQIbL9mXPUy
	yqHDXlUfM2rxPTi794aN6ly5fP56AOZ2wy1Wm8BRQhSrfpw6aQbK1ylo114zNrowgGaEVQmPL25
	lWDIYfhCZHjFqyHyLNEabtTv2JOcNGoiFvItIHHg7WyJmOV8ADr7uxfQaQFPdxYz0siEeLeeSUg
	+LvCtTVIRcpdERFtVwpgOvU1fVi4pr+SaY8DGLcJwu6Y6VtaFbEH/hbmK0SYCZTEmXXMP1Fo9EN
	8sQL0lGJLJI5r75M7zB/Y6TfJUy90DnvIi5mZgT1xt8+bfFFiVxKVvztUXM=
X-Received: by 2002:a05:6870:2108:b0:42b:d14d:38c3 with SMTP id
 586e51a60fabf-434f5ee17eemr4432862fac.4.1778139080327; Thu, 07 May 2026
 00:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <afS5XzaeLUx1ngAl@sumit-xelite> <20260505153041.17794-1-q.h.hack.winter@gmail.com>
 <CAH78GvvE=wyZz5-LFySytq2=ChOUtj7YtR5dBAY9SLJQARa6Wg@mail.gmail.com>
In-Reply-To: <CAH78GvvE=wyZz5-LFySytq2=ChOUtj7YtR5dBAY9SLJQARa6Wg@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 7 May 2026 09:31:08 +0200
X-Gm-Features: AVHnY4KlrZOMC_vOjMC-j8wBZZva9QjauwZUMBdJGyR_gsN_h_A33R6KXTyeGH0
Message-ID: <CAHUa44HGzi5nS2=vq7EWnbXy=a-347tqQh=GPSk95wR0=UaWKA@mail.gmail.com>
Subject: Re: [PATCH v2] tee: fix missing shm reference cleanup in tee_ioctl_supp_recv
To: Qihang <q.h.hack.winter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.50:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.50:from];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0BCA443271
X-Spamd-Bar: -----
Message-ID-Hash: BWALGPAOHNWZBJCG6QNIXL3WSOFPBKEO
X-Message-ID-Hash: BWALGPAOHNWZBJCG6QNIXL3WSOFPBKEO
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BWALGPAOHNWZBJCG6QNIXL3WSOFPBKEO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Qihang,

On Wed, May 6, 2026 at 4:18=E2=80=AFAM Qihang <q.h.hack.winter@gmail.com> w=
rote:
>
> Hi Jens, Sumit,
>
> While reworking this, I noticed that there may be two slightly
> different cleanup issues involved here.
>
> One appears to be in tee_ioctl_supp_recv() itself. Another may be in a
> qcomtee-specific error path where MEMREF references can already have
> been acquired before the backend rejects the parameters.
>
> I am not entirely sure where you would prefer the boundary between the
> core fix and any backend-specific fix to be.
>
> Would you prefer that I keep the current patch strictly focused on the
> tee_ioctl_supp_recv() cleanup path first, and handle any qcomtee-side
> issue separately if needed?

qcomtee-specific changes should preferably go into a separate patch.
In this case, I suspect the fix is to add a similar tee_shm_put() as
we have in supp_check_recv_params() in drivers/tee/optee/supp.c.

Cheers,
Jens
