Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5909CC87FD1
	for <op-tee@archiver.kernel.org>; Wed,  6 Aug 2025 09:18:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 92BA34FCB4
	for <op-tee@archiver.kernel.org>; Wed,  6 Aug 2025 09:18:04 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=naYusQh5;
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 94B1D42DF8
	for <op-tee@lists.trustedfirmware.org>; Wed,  6 Aug 2025 09:17:41 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-af94e75445dso673100166b.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 06 Aug 2025 02:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754471860; x=1755076660; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4SWn4M6kb+eo7B6eOyEBhyhuniBl8ADuyZRoiFygX2k=;
        b=naYusQh56NtofXzf/cTGCV3/WOp2r74rW6nc8cn+3Xc1mQUVZCiR2anEV48NNndnIR
         PBCnvw3fyf6MM35WX9rkEIZose6za02iOLCxdSKHBvd3uXpYC5zeaN3whg5QC/XzRn/I
         c8PzQwCXgmAyI59CV3c2sXvtVg9Inw3RX3AwY9Xp9/mLziDlZdqeNz0n4M8P3jjWAWAR
         msmqJDllgQY5kjklIQPTqg4aPr+cavXEl0KDtqeMO4azuLSYm3F67NBp45lPArZiU7TC
         VnkZIq0Ujdv0+3UGprmJuvnENVDjKaaEFcgqM/kWUCJ0sgxSYp0ogpOoKMCOgngJbueX
         CScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754471860; x=1755076660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4SWn4M6kb+eo7B6eOyEBhyhuniBl8ADuyZRoiFygX2k=;
        b=jFSWOgLMpR2M9DoNDCHsjmhkdb5UjaABRrHhO1h0kdwyG91rRO2/dtdRcfgnq6TbRi
         QOngLwBYfcJH5F6SFIrcxobfcmeULzIYaL+YqCEoLuw+W8L5RsvWecOnJYQUwBstZSKO
         h+DmzoGr/+pZFMsPA4xRNmHzPTAyeTPVh8Qlwv5pCgxJV8zFjnrYseRqLq1PNPpiF14D
         snFrATY+iN2ufDmcZ25YDSC1UqTrpzu2TMT7sgBJJZiP8sllSbPfkMnyui3fO7Op0jJc
         f5S+DIin9TwJYCIQsZ8pBsWRoK6f6Vx/3UcOVTglNElLFqbwH+GOQORig20PhisdUgU4
         3YFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcf1JFkzCEtnrdhS0WwTB4L5EZmKSEJFbW9vGj//x9OBkn6b5Ayhk5n+0eFQDeiPLqPJuT3rM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yxz6C6xKp70Ax5o7uRWUfl7kW5jeJP7GqYHxZbtv9QICimaLKL4
	qH57s6k90luZUwiBOuJeyPmtA2kJ/SEpNwZjJSssiROV07CpDsVqLHjKCsvYsBIZQmR54g==
X-Gm-Gg: ASbGnctR1idJev5vKWP1K/ihn2bwJ150tsIVb4Q5VYVgeUu3h26iX+e59lNAi7S2dlx
	R5qNO3FZJsdi3rY2hMUMUK0a2cGQW7lqSULWUEIkzCZp2IFKoDHkAgPw6EA0ke4oHJwxmpDz1Gr
	YvlibWEJNEujPsbo8LeLI4NimbUBmni1Z+I5seCMwAjKtHseaeewDnTy25NYEbrIReNdKzTbf+M
	zxtt11q2FhRt8eo3wJMH8bweReeYUjYB6DmMaDW87BiKpUp/io6W+49SthiBhHJn4U6lQy0+Z1v
	zfnWUeyy5DA4zqJPfK3PLiQDA5IJjZZfE4wHjqYnNeg+VYuBlCLbDwvyK4g7lgiUyoRBRZ3cpFc
	Z+ZgfeAaWl+xnn+9K1AmkwfF1HGldw8/2qGu5ZGjv9er+La7BQBQ4Gik95X5/bRMyi1D2meWgbL
	o=
X-Google-Smtp-Source: AGHT+IEDm6Mfp0uiOp19y4s8KMdbOn1ztOr2Gfd0ewbm1+/fJVRBDJVYkohruxcvX7yRAxSJdNF8bA==
X-Received: by 2002:a17:907:9345:b0:ae9:8dc8:511c with SMTP id a640c23a62f3a-af990252564mr167429466b.13.1754471860199;
        Wed, 06 Aug 2025 02:17:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:902a:b4a1:1539:a19? ([2a01:e0a:3cb:7bb0:902a:b4a1:1539:a19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0def2esm1040632666b.61.2025.08.06.02.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 02:17:39 -0700 (PDT)
Message-ID: <128045b6-c952-4069-9fea-8aa6d37e2132@linaro.org>
Date: Wed, 6 Aug 2025 11:17:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question on OPTEE Support on Raspberry
To: Yogesh Deshpande <Yogesh.Deshpande@arm.com>,
 "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
References: <AS8PR08MB98385F38DD41E1F66DE067298E2DA@AS8PR08MB9838.eurprd08.prod.outlook.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <AS8PR08MB98385F38DD41E1F66DE067298E2DA@AS8PR08MB9838.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 94B1D42DF8
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.70 / 15.00];
	BAYES_HAM(-2.70)[98.69%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.218.47:from];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.47:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: Y2TQ5TJQO3OPUYSYF3MUFSBP5TQ4F3JN
X-Message-ID-Hash: Y2TQ5TJQO3OPUYSYF3MUFSBP5TQ4F3JN
X-MailFrom: jerome.forissier@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Y2TQ5TJQO3OPUYSYF3MUFSBP5TQ4F3JN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Yogesh,

On 8/6/25 11:02, Yogesh Deshpande wrote:
> Hi,
> 
> I just wanted to know, has anyone ported OPTEE on Raspberry Pi 5 ?
> 
> Is there an environment where one can run OPTEE with a Trusted App
> on a Pi 5 Hardware ?

The only effort I know of is https://github.com/OP-TEE/optee_os/pull/6854.
Perhaps that PR could be revived?

Regards,
-- 
Jerome

> 
> Please let me know.
> 
> Regards,
> Yogesh Deshpande
> Principal Engineer,
> ATG Arm, Cambridge
> 
