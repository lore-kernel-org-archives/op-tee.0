Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084DFC77B7F
	for <op-tee@archiver.kernel.org>; Fri, 27 Jun 2025 12:16:36 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 353234FC22
	for <op-tee@archiver.kernel.org>; Fri, 27 Jun 2025 12:16:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=d1vGmDce;
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3F19B45291
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Jun 2025 12:16:21 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a510432236so1633586f8f.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 27 Jun 2025 05:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751026580; x=1751631380; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uueq+Nn6G2L5nAkKp2KhSvpUNnDq5OjH8F1opqSOa6U=;
        b=d1vGmDceLaC8uiJ361sz4FVO+xwCxUrn5ij39jtFWQu61OhzFgRpGOHDFVK6OGillU
         Bllig1j5lHusBGY3SX3MpjpIBYarOWmeZsidAoJf/v9Bmqba3jOsoLvzgpNHQmXLtQ7S
         a3QnoPe+KRi6qYVehrDmaJYgJ6j64R756FAyTwqOw+uuIKjIGVhh1I2xnYOEzGszNLH7
         WvOxEksxtfXeHl8y0kAUovJ/w5nXrXobmQ6OoZ/wrK00y8ASiRzs7BE0uHCrJW/ZaPUq
         9+lhEIOUpmzjGqILWFHB5ZrwBb6P4fF6dbomPa5ercHQ92CM3JvdnvUqUZsMtFDcEHty
         idnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751026580; x=1751631380;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uueq+Nn6G2L5nAkKp2KhSvpUNnDq5OjH8F1opqSOa6U=;
        b=q7z06mrM2WW7Ecw1RtROoHDKTGpGmpO8JIVLRBeZydzbs3ImzcVYCG1tgKuo+dEFEA
         +vSnaD3Nx1JwBjEiCjMKJRFR7RWhq5DnCv4C2codPtKCiOZDT1mUsTfu6BeUANy6tEZl
         rhFnFV2lSHfAnNyUI92ZmnAiaad8Z3PnxSwrGHPfaaeA30NUbZ11mol/NFvwKDizdzbp
         6I4hDblysBGSGln1+hrLHp3gMrttY18Wl57Lt8EYF2NqT7f4SqatAkdf++8GAC7+YrCS
         CZnVj63EdS9IOQ3CzG15kbR8kWTDIJ3lhGQx71F2AILsfT/3/w4ybZVOrpJPFL1FJ6U3
         GnFA==
X-Gm-Message-State: AOJu0Yx0L1YEHEw3WdJe72IAtKoD73iFDDvTiS5p2VpiTyeSU1a1XnAs
	CcuKWyzhfrsuu7BOgzX/ycF0j1lgro0jckr+OnmKo6euFDIISUZvrmQ6Ov7bTzJ0MLT+Pu618YI
	KGMbu1kNNe7apKys=
X-Gm-Gg: ASbGnctVyqmHBV9jKnANGuarhJdxMGXCdnQ8ZHhOzvVr+PsQenb4iKgvNtatShmo/Gh
	GLCT/D9uwXOuNBcTnN8khb34mQSQUXqwnS4B0tUZ9/lNzQ6B98GWBKdzZ2jcCMsF9+ME1tHpaGh
	BYH3gBASOlGOOsldjrkQ243welai2Uhi8Qtvuj1PKCeSp5Jij0qchEczHLQRvTjhpVxjNd/pT8q
	piQakVtk+4SK+JP9z2CDxn7BdWj8u+yU8TjMdGZ/yPVbrzi8oJyGNJDWPqoUBbPlXY7kgh3Qu4Q
	+U3a1Z4uddalpVN7xVAMYOn6a+/79rHUs4ghJp7hTDpW2Qdhw3gCKGAs67SK9LkxJ0hGMLPdWed
	MK+E=
X-Google-Smtp-Source: AGHT+IEg+RPMRwq5h4NB7vLLpTWu+N6UuGjhiHllv1q34ZIxbanGjfofGJ2Xt1KnF/mBby9FJh5YGw==
X-Received: by 2002:adf:b60e:0:b0:3a5:25e4:264f with SMTP id ffacd0b85a97d-3a8fdeff980mr2275995f8f.31.1751026579741;
        Fri, 27 Jun 2025 05:16:19 -0700 (PDT)
Received: from [10.5.0.2] ([45.84.137.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538327fed8sm38580425e9.1.2025.06.27.05.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 05:16:18 -0700 (PDT)
Message-ID: <b2adf419-48ff-4702-98ab-5c2895621326@linaro.org>
Date: Fri, 27 Jun 2025 14:16:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Preparing for OP-TEE 4.7.0
From: Jerome Forissier <jerome.forissier@linaro.org>
To: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
References: <3ee43fd2-676e-4c6e-a0df-a98c43c694c3@linaro.org>
Content-Language: en-US
In-Reply-To: <3ee43fd2-676e-4c6e-a0df-a98c43c694c3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3F19B45291
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.94 / 15.00];
	BAYES_HAM(-2.94)[99.75%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.54:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[209.85.221.54:from];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[45.84.137.46:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.54:from];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: RJSB2FHBQM7QB6HFOYYGKSDMBETJ23TM
X-Message-ID-Hash: RJSB2FHBQM7QB6HFOYYGKSDMBETJ23TM
X-MailFrom: jerome.forissier@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RJSB2FHBQM7QB6HFOYYGKSDMBETJ23TM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi everyone,

I've created and pushed the 4.7.0-rc1 tag to our repositories. Please proceed
with testing as necessary.

Regards,
-- 
Jerome

On 6/20/25 14:05, Jerome Forissier wrote:
> [BCC all OP-TEE maintainers]
> 
> Hi OP-TEE maintainers & contributors,
> 
> OP-TEE version 4.7.0 is scheduled to be released on 2025-07-11. So,
> now is a good time to start testing the master branch on the various
> platforms and report/fix any bugs.
> 
> The GitHub pull request for collecting Tested-by tags or any other
> comments is https://github.com/OP-TEE/optee_os/pull/7439.
> 
> We will create the release candidate tag 4.7.0-rc1 next Friday,
> allowing for a two week testing period before the planned release.
> 
> You can find more information related to releases here:
> https://optee.readthedocs.io/en/latest/general/releases.html
> 
> Thanks,
