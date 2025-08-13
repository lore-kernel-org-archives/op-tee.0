Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF798C87FCF
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 14:40:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id ECC0D4FCA6
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 14:40:15 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pDXQfhce;
	dkim-atps=neutral
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BC48C42E10
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 14:40:02 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61b43c84905so4274121eaf.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755096002; x=1755700802; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV7ug8iAUZr45ytqyo04qfrP0xb0ZjQy7wbsd8qq0sA=;
        b=pDXQfhce6X0UzdV8U1LxRhOPI/zsdVk96LbrTXXXh9/Du3Rl9rEgKCAAJC2z7bYFtS
         Fz6+UMw3Rob7AFdCAs9ml9A66eqWaIVGAemsl0SFZaBCPt3t5p1X1jswaIMIDCZ6ivLT
         yqCG8H3IW2P3u/vcsSCNua1UiaH2LKc/J8qUG1Pc61zCd9sbyqAYIzKanMoAv7o+zvyp
         KUG3N1x+NDwP09zr5+1ohZf87YdGrFJ+RjSI1hhzUaXhxpv7iZQ6bmGQi6vN8uvKdL2g
         geUnDgCZ4UIkRFTPiC18WXVbmc+hQFzD8V1g9Z/G8+7vuDDcB6yl8ZUmbIVfneFMkGAs
         x2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755096002; x=1755700802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sV7ug8iAUZr45ytqyo04qfrP0xb0ZjQy7wbsd8qq0sA=;
        b=Gz/gIQKCxLAq91p+KGy0qyPea31szHyY7lUo/2vadCxQ9R9YaqfPybgsjVFVkh+Zg5
         kIk0Rxv+XkK9Zk5S7O5+z7fZbzDdUOkyP33lxmOs8/7d5gpq1mXdu+RNiY0E4q7TGOSE
         egnTJgW9OewoTKaMdvDp4jviS8naJeu7TyEVIR64T5LzmV0BiBxzwcztu5jr3381zXD+
         LH+hZhXzqwCpTM3LfcfMw+tmINGTxCAXVBolrdo9ELDXixG+L3wbWgaSCxbkMS6yp55D
         6t8RE3cz6M6e+sgMLPd0qIHpNjuteoyxtdlbmE/CDMjyIU3/lQm/YTc+DlA/yWHuul1i
         3VgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXatTNJolDC1vKUFNnmVCF+15z/6upKMcRXe/QJ1826v3zZjN6jlKkR3dBYSng9loxApQcn46g=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxSwMEKl6gkHb4UexSjJHuoAwFl6dcy6qAg/1uZyj2jVeHvRm4d
	4/VzmqKWfGWn5P9V0VWrXfDHxlT5RpfdLwh4/ZmlW7H3GZb89gBNUSB74NMWHMSFe61AKEU08yI
	tOTDRoyw4duP97uF29Ib/VCplI8q8Z7s0RemUHrK6uY8Q
X-Gm-Gg: ASbGncuU0JWT+su8XDzPxkLUK7CNNjkdoYJ28AGr9GkNheDRhrtXIx2YS/CzWmqSE3/
	jLyULMiKKvUlBG3DQXjBJGUwZ3QwVZdFrlgxY2tEzpXQ+OEOUITmTa8BhcybE5vcHtWDZlFu8Lj
	2yuiXMg7iFr+TG3YxVzEi64KwzdHCmcAkZLFkc1ZCZ8MxZ2uLwotOaVWnNv3wusShX5p84Qj+7n
	zpcVTCr
X-Google-Smtp-Source: AGHT+IHC7csBnnmVeyozlhE6czCMvb+rLNabVehQ/2DXrtUClUHk7vysXYF5f8+3kJAFnNYGQPwefi4/ihiJTtqrSv0=
X-Received: by 2002:a05:6820:54b:b0:619:844f:2d0e with SMTP id
 006d021491bc7-61bc76a583bmr1459875eaf.8.1755096001906; Wed, 13 Aug 2025
 07:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250622082910.13897-1-abhinav.ogl@gmail.com>
In-Reply-To: <20250622082910.13897-1-abhinav.ogl@gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 13 Aug 2025 16:39:50 +0200
X-Gm-Features: Ac12FXyhUeoBN6AsIilsKfGzLH5o-2jBLlxxf0JYZUEHFC0u9_LymyTa00MBA58
Message-ID: <CAHUa44H5OX5CYW5eR2wvtwaywUCNvV0wVtTRsi23YpbSaZofTA@mail.gmail.com>
Subject: Re: [PATCH] treewide: Replace scnprintf with sysfs_emit in
To: Abhinav Ananthu <abhinav.ogl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BC48C42E10
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.98%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.45:from];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 2U4GSPIH3Y2IINOXTBKX6LPBAXHJVXUG
X-Message-ID-Hash: 2U4GSPIH3Y2IINOXTBKX6LPBAXHJVXUG
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2U4GSPIH3Y2IINOXTBKX6LPBAXHJVXUG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Abhinav,

On Sun, Jun 22, 2025 at 10:30=E2=80=AFAM Abhinav Ananthu <abhinav.ogl@gmail=
.com> wrote:
>
> Use sysfs_emit() to format sysfs output instead of scnprintf() as recomme=
nded
> by the kernel documentation.
>
> Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>
> ---
>  drivers/tee/optee/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Your patch looks good, but I've already accepted another patch for the
same issue.

Thanks,
Jens
