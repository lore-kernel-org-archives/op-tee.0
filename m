Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213E0C9EC97
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 15:15:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5375943280
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 15:15:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=C5r0Qc2J;
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A9DCB41A43
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Jan 2026 15:15:22 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477632d9326so39359655e9.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 12 Jan 2026 07:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768230922; x=1768835722; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B9FXlOztAQ3v1foaiiiFEOmTKWgsDAmfXBn5g4N5tkI=;
        b=C5r0Qc2JofsYVATxtm1WKQIu/KkZj+bGpVuMdmiiAh4bee7e1zB6yb0voF4RybsCTA
         hkx9+fSUxEQYIEJLQoRYHkOvJYKouzRmUSW8aUKEDpEeUOfqGAoT78nHWxJCkVbiV7YL
         OVPOHEqlqABIRFEtKecDuOJrz7k3iNdErMmtj/DRzkZeuGUFWY2xMKrvsa4M4ni0IzkS
         GLZdGFuZmRin2+A3rKOvzSDnAhvrmuzHEYP1F1Kcc9enOpq8PcM8cndiTzFn/ed142mT
         ayGOaa5JsSYshXzPC3zLphKGeBOTus2lXV7bPxbd2WXQWXpatiJyz5XKW+5sGOvCmSKB
         GgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768230922; x=1768835722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9FXlOztAQ3v1foaiiiFEOmTKWgsDAmfXBn5g4N5tkI=;
        b=kyvygf1RzIbnqPZlsXfPbgS26NqUnCXRF79oATsVN0COBO0s0SEZ8rHPD3mfslzbHv
         x03hh1J933tX72Pfd4GB51OfXHOGDRS1Mu08kqgoBAlJ0eALmJKQSD6603SgynuTL/28
         iIIYnsuXfDNp9QG4YAKI+UuItyh8nGOSSvlNdyenE/FMldMx4gN8h+SAj19Hbw8siLDt
         YMxO20IuFEqfIH6C4/lK94m6GPTOGX4os2vsjVZt7s50o9U9Op8a7dVdPbqTo8ssUizX
         c+h3T0gfdWV+ROA5wDh6g8qNf0QhuQC4nIB2no0eScAaZtYQ8gfMZ/VkkLiFLTcttubO
         QXSw==
X-Forwarded-Encrypted: i=1; AJvYcCWvvd2BC+nJuTnH6s1u0mXVi9pR92NnKK8bTOu/u1EgQTAo+S1T786XDT5v/oabMpbbSRA+vv8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwlmzPlLJPlrsUpGq8RdhQxtHlM4s/Wt8lpyMCyqZtWj9nhuN8Z
	Njtpy+nOt8C+V6vVPpw5+E3K4CZQALOH6EjsxdIs9PGhP2g5DYPEvplR+5XqS+tHCMd0VQ==
X-Gm-Gg: AY/fxX7zCG3mgXlU25H/7HcZvUxiKuZBowTP05IAn1VbyjLn4YNNOl6yj27FNiEKU0J
	WOaPtADfhY7nFgZvszk/MoIavt/mIvLRS2+IU4AKhWilaiXmSL5Wk/G/N/7++pCDZnKNUQlx0C1
	SMimFK2yfhDhLKZWf8cytNVpoPpXnWuiY/8de2ZKJBBuqcwDLgbv0pgcFe7dASCNiveIHIfU3Cp
	kKLQVSDd6yJ7wmHmYUKl78XDdU1x/xM+3T+PAFJHx72zq3Vbb9PEbFa+DF0RI4wYjIrHFzsn1of
	EUJdlcB+VNcQv/Bsk1J6wrQ9akeTSy6CmgxZdsZhg7zP1Vdw27N28vIPr62TeLK4sUEib71XOFT
	SHhNdk5CYyLTEhUEbitW8QY8mdBMomANn9a+ajH7hLIKwwuIGmq09VDS6iCcA/PAH4w3LTPIoHJ
	lfSN/FVhVhqOH87DU9
X-Google-Smtp-Source: AGHT+IFO0yPg5n5oM2epf+jZFSWNft4b56dzwR4qk5iFKZhjsdfcK/zEf81nvYnre7YVzrIgmZde6g==
X-Received: by 2002:a05:600c:4ed3:b0:47d:6140:3284 with SMTP id 5b1f17b1804b1-47d88fc1df4mr187863785e9.37.1768230921406;
        Mon, 12 Jan 2026 07:15:21 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5dfa07sm38984778f8f.25.2026.01.12.07.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:15:21 -0800 (PST)
Date: Mon, 12 Jan 2026 18:15:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH][next] optee: make read-only array attr static const
Message-ID: <aWUQBSa3dw5HOsVd@stanley.mountain>
References: <20260109154442.421248-1-coking@nvidia.com>
 <aWTaUvGu9dlvnJO9@sumit-xelite>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWTaUvGu9dlvnJO9@sumit-xelite>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.42:from];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.42:from];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A9DCB41A43
X-Spamd-Bar: ---
Message-ID-Hash: TZI74UCPOMK56ZS66KZN6HTZD6BI3U5B
X-Message-ID-Hash: TZI74UCPOMK56ZS66KZN6HTZD6BI3U5B
X-MailFrom: dan.carpenter@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Colin Ian King <coking@nvidia.com>, op-tee@lists.trustedfirmware.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TZI74UCPOMK56ZS66KZN6HTZD6BI3U5B/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, Jan 12, 2026 at 04:56:10PM +0530, Sumit Garg wrote:
> On Fri, Jan 09, 2026 at 03:44:42PM +0000, Colin Ian King wrote:
> > Don't populate the read-only array attr on the stack at run
> > time, instead make it static const.
> 
> Is there any value add to do this? AFAIK, the static local variables
> aren't preffered.
> 

I have never heard that static local variables aren't prefered.  I
imagine that because they're often not thread safe?  But if they're
const thread safeness isn't an problem.  Generally, we prefer the
scope as local as possible.

regards,
dan carpenter

