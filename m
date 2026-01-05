Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB08C79F90
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 13:02:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D47604FF54
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 13:02:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gwq0Vrig;
	dkim-atps=neutral
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 171BD4FEB7
	for <op-tee@lists.trustedfirmware.org>; Mon,  5 Jan 2026 13:02:35 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3e8819eda8bso5089902fac.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 05 Jan 2026 05:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767618154; x=1768222954; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7LgAIEr8YY2wy2aAQMBCTti2X4ob2jrv84eqDNVh4g=;
        b=gwq0Vrig9zJX+xvXnhd1XxQczpaB+1t2X957lQkKZ6zs+v4s409KLejxPyAzebKfzm
         JXwIuaurYQ+4ab8ZY/0j2bAWiGx0WJDVCw+ULRJRTMW9hkjtg6JKhdHwK9bS/FUelxsf
         e90ewD0nLQ4uJCdfYV1wnbVUKHYNjiMbScgDmoanrl5CvoKbNkSEq1RQDo5rFM+pkEDY
         nw5ob3N4fMKQkkIgzkuHT4HvQ87EcStLMnc/nSV0tqoKczyE2oSnFQz/GNQmN0TwUDmo
         aUoetKNQ2r88eILtIt1JbvLIn+WijPGvmchjH0faa4HmjRD39x9tPaP7SnYsORVp5g4O
         Sytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767618154; x=1768222954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D7LgAIEr8YY2wy2aAQMBCTti2X4ob2jrv84eqDNVh4g=;
        b=wZ+lYDBL+N6/jRxPEa6ep/UrFDUxpkOmvUjXnxOq8JiF4IQJcI7vJqQlC+a88g+XKY
         g0qfUYbbKzHC2v0dhXsoSbuqTVo6tCCgQm8Pcdkvs9PmPvGj7DV9HNLm9mhrfN+762Wi
         WeSKYj8OiMCl1h87xngwTP20kFIi+pP8+dpThASB6bIsPhQl13iEsPaIVtjTNMB33JNA
         8/E0/oTC6MpcMcTjtScIi0zBqyMau6PHJ7xuK9nxlvcaYrU2AX0coxdkIZqOk6FP0Gym
         4AE5q2uN4I68u4KJVjn+AM31jgeqkjGzlr3jAUHwj3uN2hqVM5PzLZIY5soqZyBUoZKN
         /BrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGkpe5LpJmexLbOrAhbo5lIpdJ1+4z6KVxdJyQcUwsMdK85U+a4/SG40AGenqLosZrBtrJ3xU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwfE5kBQU8Cvru8uDesB7nivOkULz0N7XICv04at1Wk3acBvOHC
	nxpVxJj/pVSB+iOfp8MyxDRFeD/FXXsoaSXx9PD637V/2/P4K67EAVs9WSK0yq0qoxEgo+lbo7q
	jJsI5nQTXoM3cJ4rC3MGCx0UBfxDfccp7oUxHQTqKbl99
X-Gm-Gg: AY/fxX5RnTlG8gXDxXu2UlXNOhWMBEr4Zd2h9FN5rwdQN1a8n2jub8uidxyBu97vvYc
	mpNoHXqO1B7dsqemGg5bzr6yw5j2MPQXy0sQun2K3ZwcgV3VrRzGRO1UmrVtRxMDvmGrN3KrkT1
	u7GNIBF+Gm2Jfhxdk59c6Z1GY4B5qcb2TtoAfqGC4Ks4y1NiyjT55k8jnJwnLIEVzFbEulYFxEl
	DENlMM13GQkcRp0yeVQCG4cOGC2RK3Y98e6YaOY970Rrj8Ua5fMiv0S1UtpMIDL+mhwh9omCE7y
	QhdEVEuR3BnwtL0y5PwMGx4I3A==
X-Google-Smtp-Source: AGHT+IGSdC8qsdAKu5ru6Aqg3TzzWVkfF+sr9jAmlpE4HPxf5+amN/kO6shS2uyDYWvG1XvnJ5TmpGLBv7uaxQYhnOs=
X-Received: by 2002:a4a:b28b:0:b0:65d:6ed:e05c with SMTP id
 006d021491bc7-65d0eaf0753mr15500862eaf.64.1767618154208; Mon, 05 Jan 2026
 05:02:34 -0800 (PST)
MIME-Version: 1.0
References: <20260104170119.291968-1-Julia.Lawall@inria.fr> <aVtLiJBGovTFhjcc@sumit-xelite>
In-Reply-To: <aVtLiJBGovTFhjcc@sumit-xelite>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 5 Jan 2026 14:02:22 +0100
X-Gm-Features: AQt7F2qR-cBchafQDBWcJWzZf_cNqYuIg9WzkjXjE-TKI_7xtVDxWGu15riHjhg
Message-ID: <CAHUa44FVWUJefkA_xmNzX1ibFxgtinSgPqUx_p+HfuKPGQv-5A@mail.gmail.com>
Subject: Re: [PATCH] optee: update outdated comment
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.53:from];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.160.53:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 171BD4FEB7
X-Spamd-Bar: --
Message-ID-Hash: 575UPWGCJCNEBND4V3D5BWHFBIXR72C6
X-Message-ID-Hash: 575UPWGCJCNEBND4V3D5BWHFBIXR72C6
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Julia Lawall <Julia.Lawall@inria.fr>, kernel-janitors@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/575UPWGCJCNEBND4V3D5BWHFBIXR72C6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, Jan 5, 2026 at 6:26=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> w=
rote:
>
> On Sun, Jan 04, 2026 at 06:01:19PM +0100, Julia Lawall wrote:
> > The function cmd_alloc_suppl() was renamed as
> > optee_rpc_cmd_alloc_suppl() in commit c51a564a5b48
> > ("optee: isolate smc abi").  Update the comment
> > accordingly.
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> >
> > ---
> >  drivers/tee/optee/rpc.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

I'm picking up this.

Thanks,
Jens
