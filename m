Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6758AC87FD3
	for <op-tee@archiver.kernel.org>; Wed,  6 Aug 2025 13:22:59 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AC7C84FCE4
	for <op-tee@archiver.kernel.org>; Wed,  6 Aug 2025 13:22:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ROm4G/mN;
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 99ED842DF8
	for <op-tee@lists.trustedfirmware.org>; Wed,  6 Aug 2025 13:22:37 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6156463fae9so1665215a12.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 06 Aug 2025 06:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754486556; x=1755091356; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TYaSjFWkWULj7+qwr2Q4UbtEqdyFggG1GRdSP6+DILk=;
        b=ROm4G/mN+GjOn7jma23vekMhT/NN3odirOOFXcOAhAlo313qR14oFZ5knFbYog54Z7
         Gj0IcKrB2KfRwvHxN11eHZ/lum+Wp+p2bMXmb5ph664Ugw6YW7jJYqE0UhEEnXIeqZd+
         zqleJfopPEC49zFayT+Z1ijoWkQ/QtaVcUXjFCKgcTJFATvXmdX+i+zReyeCtLt5M/Yv
         geTkCLi8JfANEmfVDbOpueRGwbFB1hfsMe3ahepJknH8BZV1Cmmgn4iqk9FljscYK2XL
         LWnUPReF4Gc9oJCcFK7+liVYBj7UYDJ3DoaZ7zlR6E3AKWlzI5HBygeAue12Yk3ZhknC
         5dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754486556; x=1755091356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYaSjFWkWULj7+qwr2Q4UbtEqdyFggG1GRdSP6+DILk=;
        b=nsNupq5/pKggPUyX4xVSI3dGiRRy7MDgnRVJpwJVJzee0E39o73iaCiusAc8XZNQJ+
         F5VCxYmBDUu5N6KThslZY/0NjIPWAFoUn8Q+6Dfb3e13trAk7sAqc9AKNGiDnCdGJtP1
         CgGNJ7K882RPp1qzOh/JEdb65CM7ETRtZbBdGf1HTx58S2Wl5ChSCmg6HU7tid0y8Ada
         ISqSTHA1GCdv10UxBHxVz3FBZdDqm7bRsdcKbvG/w6E7eROObsSXKwe2VcZuVbUb3sRh
         RKGQ/4Z0LumjXqXTpl6yS9c/6IWQtPVJuP7yKFeNHc2OYGFMdwtKci+Y8VUBJ2L6cSiy
         X9+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3jrIe1diRKkIypHylvg+2Xxd3FjP4K8uSgqeUNzROnqBxzymT3C2INaw41BabcNrlXUMqddc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx0SiQQNI5C7J2EF0brjG3QkJOFChRfa4roIWFdXkjTna5p0PXw
	6C7hpoUTELg0OTRUpDTaAnxPfmi4/LQplzhN/BLpAlcAE3pV7Tm2A22rCRUooqsRb9WAMw==
X-Gm-Gg: ASbGncumhRMMGHgqNdVlO/lYAMS6yomxMBg3pgQhjzcKS/cL9iV5tHnobis5Szqh9r6
	ZiUHogBz46Cp0z6q+mhimvOVUZp03LI4IYgitv3ic6FBRVDiI3ojKj83Va5VxopJDFoFha3PoZD
	8G1oFljjjm6NltOmpgq6PNHxDOVESJVHZ32l+U2L8svGcZt6X66vCUG91Mfbx50OQEmzCcCywrY
	16flQtQSzW+AGr160b+ruwLtwswu/HdHNmlCvj8dYXivz2gdRVTTn+3WC8ltpgc6Ia8UXqDDfj/
	udCHWQirP30xk6/X3YSN9S8lZ3Yb8RVE1nfYrTDbzNqDmMXG4aBjxSIh2v0Xq0froQelUkYRA7o
	PqMzGjxeMWJifkyVhkdCwqzwFySc5Za0LQWLbtS7F+KqeFkD96G9iuoe695cLWd39+uCbHBQbdU
	4=
X-Google-Smtp-Source: AGHT+IEUnURKvbW5u+A2wzbjlvEFhOSqqq4BYF/zVOMvnhuM3G6cEwqkv4fMbaMuKwODZCF5/1Pi4Q==
X-Received: by 2002:a17:907:7214:b0:af9:6159:8826 with SMTP id a640c23a62f3a-af990950051mr274364566b.20.1754486556358;
        Wed, 06 Aug 2025 06:22:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:902a:b4a1:1539:a19? ([2a01:e0a:3cb:7bb0:902a:b4a1:1539:a19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e8359sm1098819966b.89.2025.08.06.06.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 06:22:35 -0700 (PDT)
Message-ID: <3de6b7c0-1e24-4205-aa3f-ec7a84bf818b@linaro.org>
Date: Wed, 6 Aug 2025 15:22:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question on OPTEE Support on Raspberry
To: Yogesh Deshpande <Yogesh.Deshpande@arm.com>,
 "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
References: <AS8PR08MB98385F38DD41E1F66DE067298E2DA@AS8PR08MB9838.eurprd08.prod.outlook.com>
 <128045b6-c952-4069-9fea-8aa6d37e2132@linaro.org>
 <AS8PR08MB9838B047646F7F5C71DA37DD8E2DA@AS8PR08MB9838.eurprd08.prod.outlook.com>
 <AS8PR08MB98386743EB8157559E060DBD8E2DA@AS8PR08MB9838.eurprd08.prod.outlook.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <AS8PR08MB98386743EB8157559E060DBD8E2DA@AS8PR08MB9838.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 99ED842DF8
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.46:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.46:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: IZ6LDD6AG7YKKD3P32OCRRI4YVXCXRR7
X-Message-ID-Hash: IZ6LDD6AG7YKKD3P32OCRRI4YVXCXRR7
X-MailFrom: jerome.forissier@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IZ6LDD6AG7YKKD3P32OCRRI4YVXCXRR7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>



On 8/6/25 11:41, Yogesh Deshpande wrote:
> Thank you, Jerome, for your help, in re-opening the PR.

You're welcome.
 
> Please let me know, if you/your team need any support on any dependent component (like TF-A) where fixes might be needed?
> 
> In that case, we can bring in right people to get this over the line.

To be clear I do not intend to work on this item except for doing the maintainer tasks of course (code reviewing and merging). I suggest you try what Volodymyr (@lorc) has proposed and discuss technical issues in the PR. In case he has no time to spend on this you could as well open a new PR.

Thanks,
-- 
Jerome

> 
> Thanks again.
> 
> Regards,
> Yogesh
> 
> -----Original Message-----
> From: Yogesh Deshpande 
> Sent: Wednesday, August 6, 2025 10:26 AM
> To: Jerome Forissier <jerome.forissier@linaro.org>; op-tee@lists.trustedfirmware.org
> Subject: RE: Question on OPTEE Support on Raspberry
> 
> Thank you Jerome for a quick response.
> 
> Seems this PR was closed as been marked stale.
> 
> Any chance re-opening it and working on it ?
> 
> I am happy to state the reason for this request!
> 
> Regards,
> Yogesh
> 
> -----Original Message-----
> From: Jerome Forissier <jerome.forissier@linaro.org>
> Sent: Wednesday, August 6, 2025 10:18 AM
> To: Yogesh Deshpande <Yogesh.Deshpande@arm.com>; op-tee@lists.trustedfirmware.org
> Subject: Re: Question on OPTEE Support on Raspberry
> 
> Hi Yogesh,
> 
> On 8/6/25 11:02, Yogesh Deshpande wrote:
>> Hi,
>>
>> I just wanted to know, has anyone ported OPTEE on Raspberry Pi 5 ?
>>
>> Is there an environment where one can run OPTEE with a Trusted App on 
>> a Pi 5 Hardware ?
> 
> The only effort I know of is https://github.com/OP-TEE/optee_os/pull/6854.
> Perhaps that PR could be revived?
> 
> Regards,
> --
> Jerome
> 
>>
>> Please let me know.
>>
>> Regards,
>> Yogesh Deshpande
>> Principal Engineer,
>> ATG Arm, Cambridge
>>
