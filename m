Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F378C7EE39
	for <op-tee@archiver.kernel.org>; Mon, 30 Jun 2025 09:13:07 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7222C459F2
	for <op-tee@archiver.kernel.org>; Mon, 30 Jun 2025 09:13:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eBoFF3XM;
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 138DB3F66F
	for <op-tee@lists.trustedfirmware.org>; Mon, 30 Jun 2025 09:12:51 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6097b404f58so7237602a12.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 30 Jun 2025 02:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751274770; x=1751879570; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukb6NGxA5RLj1sf3aa1YZKV0mHtaYpOfTcidTCe2adw=;
        b=eBoFF3XMkZ0lEo+FuT8C+r3bo7LIemPgm+BVx8yeNYPex2ns9rJO0bY0qjLO1Gd6pl
         nW5yysiJkVA/mWJxtsnaqIF1WlPFXnLk9xf8Xgr+HgR37sF/cEZswiVeTY3MXy3Lpa9s
         9nCckGkzhZ05RIeiAvj5ciJ+w0tg2yQuDHb1N+L04wm7bCnfk29gkgCdeJ+jJ14TOZ+G
         zLEgD3m/j0qTk82z6wRWje+bll8ToTY/NJ4Tg3A0UO193WNTgC+3x0pRv5XW4nH1ONp+
         EZ6hmfYtd7m6QnkzWJS787fPyhwBnmIndZBJTfP2GoBVE0zvcO57eklk2SXBbXor5oLu
         kcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751274770; x=1751879570;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukb6NGxA5RLj1sf3aa1YZKV0mHtaYpOfTcidTCe2adw=;
        b=LQm1TmuUD0wHVK4qFfb3yvPdqzQc19zMithZPWhLLO2fYcSh7zohtRnSLery8smvmJ
         ak4nGQtdZzblhXdsVPSCi2bNStsNMW5ezaN8vFoKoRLL7mYiisgFF/i/deW0SUZ8XP8g
         rmw0HFI76NzDsj9Is5L/j+v7XHMzdzDpT/8IIbWa1WduHQYWfW8F7kfDcHmtkWQlC3ys
         +EofwDxJ5kyUan/xvqab8qBGbgwR5NoeLLV+3C40dnPkam2e/JPDra1GoYrYiJZqcSeC
         DRK4LxN77Ke5M5iUPnsRBIQBi5BDurmpVRmA8WdVszYkdNO+o+2QA468T+oCfn3AQZcv
         jd3A==
X-Gm-Message-State: AOJu0YwUrJ5gSkFRSt2V5fLGC7BQgGV0zLncm0q9kgmwNbU5rjGunUpZ
	xBSMDtI0+5hCB2zNtZRKDSgdzvXKmuIQPFRgnxouMAALYr+EnlOpGx2BrXpfrTTJch01y56feSE
	BWxIXGuDHRSEOElhKeg==
X-Gm-Gg: ASbGncu27mTtUM2sKjXioYTv7n74IN4kx19gMUTSuOU6eH0uA/B0h9bAJgm+5LhX9Tu
	GNjvI7LvrurQS9r2eipbRUCS2VJmo+nOnWsb1tsrztIk6z9faiRooKd89H48n5W9wc9a/uXERuv
	p+py9JHLeggg//JDPMRBFk91zQMYOkWvFw6luQ/XWLv5AJMzp1+WGxW0CxJXTvSukXpf2OQiw1e
	c1aduvrdwsVSRlFVE6mNsY1r/O6NgomUuMnkY+HaJAorlqMgCPBnFQbvvK1Li5oabZ2TnDKrr38
	onBJQpVT6KlXFAhxLaDuChV1ldKTD1eU7XeRz2Uio8dt8Pur055nYKuI53ZAmwcVI4EM
X-Google-Smtp-Source: AGHT+IEYQbljOGQp8iFpW+WWRPp+bJQImYk+909Yl3mkTeKfi46U2ZOuaZhA7Dwe71H8MOrwatFNXg==
X-Received: by 2002:a17:907:1b1b:b0:ae0:d332:f637 with SMTP id a640c23a62f3a-ae35010ffd3mr1178897466b.31.1751274769591;
        Mon, 30 Jun 2025 02:12:49 -0700 (PDT)
Received: from [10.5.0.2] ([45.11.80.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3a0adb7eesm38132466b.73.2025.06.30.02.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 02:12:49 -0700 (PDT)
Message-ID: <0436a1be-5c76-4b66-980b-cb50a2070f3a@linaro.org>
Date: Mon, 30 Jun 2025 11:12:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Preparing for OP-TEE 4.7.0
From: Jerome Forissier <jerome.forissier@linaro.org>
To: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
References: <3ee43fd2-676e-4c6e-a0df-a98c43c694c3@linaro.org>
 <b2adf419-48ff-4702-98ab-5c2895621326@linaro.org>
Content-Language: en-US
In-Reply-To: <b2adf419-48ff-4702-98ab-5c2895621326@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 138DB3F66F
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.69 / 15.00];
	BAYES_HAM(-2.69)[98.62%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.53:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[209.85.208.53:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.53:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: 7ZZ6X7P5T7OATMY3TSXNX2TNWTYHR2XY
X-Message-ID-Hash: 7ZZ6X7P5T7OATMY3TSXNX2TNWTYHR2XY
X-MailFrom: jerome.forissier@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7ZZ6X7P5T7OATMY3TSXNX2TNWTYHR2XY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>



On 6/27/25 14:16, Jerome Forissier wrote:
> Hi everyone,
> 
> I've created and pushed the 4.7.0-rc1 tag to our repositories. Please proceed
> with testing as necessary.

FYI, I messed up when creating the 4.7.0-rc1 tag in the build.git repo :-/
I forced-pushed a new one. And optee_ftpm.git had no 4.7.0-rc1 tag, this is
now fixed as well. Sorry for the inconvenience.

Regards,
-- 
Jerome
