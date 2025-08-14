Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EF1CA0EDC
	for <op-tee@archiver.kernel.org>; Thu, 14 Aug 2025 08:01:14 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9802942E06
	for <op-tee@archiver.kernel.org>; Thu, 14 Aug 2025 08:01:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=obfM9yvJ;
	dkim-atps=neutral
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3C7ED42E06
	for <op-tee@lists.trustedfirmware.org>; Thu, 14 Aug 2025 08:00:57 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-30cce5da315so252228fac.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 14 Aug 2025 01:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755158456; x=1755763256; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n70nGhvWz6Vpr8NHMWaTGqVNUV776vq89TNauT5t+Vs=;
        b=obfM9yvJfwMUNVUmwoW1vGxoD5Ev71EjQJkPLZwehrZEiU5U03DCQRZjP67/MGqmzf
         d5Vit58jw1Y1y3a3jx4oBK9/E2dEz8iLFNkw7/KL5x/9JZQMSlmnd3DNsfUKGs7LjOEm
         V+Ls7bEJuA7QHP+Uh5VhIwFwXZUdPLXOPgkcWE11aSPtMr/9OD17o4YZ3+5VrwZrR73c
         gxcgr/9grLiWJoxilvX5K6uqhKwUKsudzBff63TvqP55hNqRc1TO3eVvt7ExmuSDVEIJ
         K5t6vboZo2gf/d21L0f+3/R61AuxoaVFvuGOR6OEm9BkANg4vPGlRaP82fbPQJVDn+B/
         njbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755158456; x=1755763256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n70nGhvWz6Vpr8NHMWaTGqVNUV776vq89TNauT5t+Vs=;
        b=KkJqI8ApOGewCV0DsTMZ+MI/OxNJAvAV0BKV4eVtuowWGL6ljFZLGGK8BP7j4v8InW
         ahaDM+b3Fts8bKOABfzl7MPunZ2phSx/UJeWtKzQA5nwS12Ua9ROI56K5RdKkHjDWgww
         ahsd8iHa4OGAPyFzRyUrQ7xb0zl5ZnjF3vKnHnif4gcOUutgRi16PTlrcp5hHy4/uHmn
         IGeOjkLjRJ+Z2YWZHz0WOxV9XPzBl1egJdWoKTDYBKiii3Y/Gizs2A/7Ni7jfhjQyLdQ
         g8PytTQgMqdUqoPk7C8tmHH41qjBXTrWRPnw+3W+zt6XZnwNxNBbcvSaeYOZf+ruKP69
         5N8A==
X-Forwarded-Encrypted: i=1; AJvYcCWhKdtHlXFHFa7VaUJbdesQwqv71zI5XSf8mVwNLBfHiBPYyz3dIsZuHwvEJzRJ/I7HEfplpNw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyzTdEknIrELQ/sbyMpIEgMNQ+AJigfMBVfVZ1XsCmk1k95eJoC
	phwIXRcBbdvSgyCbbTEJo27WBRWj2iIz7AxrIVb+CNXEvwZFxIQbFXN7jtmpw6Fz1QIzOHao7aE
	MZpLxPbv8eznXxAWjCTMZ29ph2fEN2VSUdu81qcV0VjAcS8prhjupLC8=
X-Gm-Gg: ASbGncvz8NPmtN8jmNSmV/0dvUdGIcQi6IbJrV0E2WqBgc5+nOgclacDI2LsrakolDP
	3KpWtBYH6HvieHu5q20kmgXQ1QyAqaopD/xiKGotcLzL9y26cJGR6Xf1+7BKex8cqt0+nhyjlpV
	Wz3NkQakIYwP1q0NG+8CMlmCkNK9WPi8QsCqJRn5w46xxgsRtxzhgNnktXYnbMWM3fxS7BC+R6U
	Mh3NptK
X-Google-Smtp-Source: AGHT+IGTBMwMw+gzWgxP9b5nguwG0dbCgs193lvPsSCGkN0VzG4a8mD8pVivm8MI/iAjnF7DolsTQBv4YPj5EujlUoM=
X-Received: by 2002:a05:6870:b491:b0:2ff:a4c2:b52c with SMTP id
 586e51a60fabf-30cd1390b93mr1399807fac.34.1755158456494; Thu, 14 Aug 2025
 01:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <SJ2PR12MB86897F31237163137445D7CAB82DA@SJ2PR12MB8689.namprd12.prod.outlook.com>
 <aJmChHa_BxNO74cB@sumit-X1> <SJ2PR12MB8689AE34D74E657EFC3055F7B828A@SJ2PR12MB8689.namprd12.prod.outlook.com>
 <aJnJY5hV-Pul8QzN@sumit-X1> <SJ2PR12MB8689CB7106ECD0EDB2534208B828A@SJ2PR12MB8689.namprd12.prod.outlook.com>
In-Reply-To: <SJ2PR12MB8689CB7106ECD0EDB2534208B828A@SJ2PR12MB8689.namprd12.prod.outlook.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 14 Aug 2025 10:00:45 +0200
X-Gm-Features: Ac12FXxqNjdN08EUBkW_hi248QaNUjOt1HWt7kCngST3BNpBgYKS5WS7Ah6vKqE
Message-ID: <CAHUa44E97D4res6VX84XCSStsisPp0E3B4v8xJQoohKijkzf4A@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: ffa: fix a typo of "optee_ffa_api_is_compatible"
To: Sungbae Yoo <sungbaey@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3C7ED42E06
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.160.44:from];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.160.44:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: RVCZEHTZQIKWR2Q3WXJD3AMLUA4SBXT3
X-Message-ID-Hash: RVCZEHTZQIKWR2Q3WXJD3AMLUA4SBXT3
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RVCZEHTZQIKWR2Q3WXJD3AMLUA4SBXT3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, Aug 11, 2025 at 1:31=E2=80=AFPM Sungbae Yoo <sungbaey@nvidia.com> w=
rote:
>
> Fixes optee_ffa_api_is_compatbile() to optee_ffa_api_is_compatible()
> because compatbile is a typo of compatible.
>
> Fixes: 4615e5a34b95 ("optee: add FF-A support")
> Signed-off-by: Sungbae Yoo <sungbaey@nvidia.com>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>

Looks good. I'm picking up this.

Thanks,
Jens
