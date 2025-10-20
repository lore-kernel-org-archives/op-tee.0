Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D5BCCD199
	for <op-tee@archiver.kernel.org>; Mon, 20 Oct 2025 11:12:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1C9614FF5C
	for <op-tee@archiver.kernel.org>; Mon, 20 Oct 2025 11:12:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Fl5miU1F;
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7E0E94FECB
	for <op-tee@lists.trustedfirmware.org>; Mon, 20 Oct 2025 11:11:01 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4711f3c386eso17901875e9.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 20 Oct 2025 04:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760958660; x=1761563460; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xOY7GkyzMIY9Did9eEottikeig5IOmlOr5DVrcR0uZM=;
        b=Fl5miU1FM1+KBobIvMwVpYRscJfdTXQBXY6BUTOgopUwd/GDgtxMc9cZDpyHjwWOo9
         /lvO2cBKpXnPJYoVEn0iKCb6JpGCX/GpevYplce9GYeLALPsMunznhdmbtVnV+4CECac
         NLUMGJezoQ45bBlyY2VcWHikpj2zP8y9dNGOAR7YxgPgjplu3vgQOFGqpL8WJwGWumLm
         +rWwv5qLDPj3IyesXyIvYRa/orSzxszk40bxnyqMDSPQ4AQiVSaY+keY9+ZfepMwm49T
         lz/QPVMl2fUvoFUkIxruWMkrqp1aiqdIHL1liHRhWYVNE14qZTC3Eu6m2Y+BCVCMCtUp
         AMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958660; x=1761563460;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xOY7GkyzMIY9Did9eEottikeig5IOmlOr5DVrcR0uZM=;
        b=sthlwP1B7djW4KMbiMkmHbHdyIsH7Q28aaFH+zuv7ATvJ0VCjoqGbs4YO0+tjqVMYt
         hEXJ+kiSnorgzCWBrqV0EVK0H2EVnXzKUpJjJnrjeadBIFbhgPeFRn9afJKdE1lLduQS
         p0AxsB2lgdSIrgs2Njis5bO9sLaz05Y6ohokKzPsqXsgJNaAE0Zcwm51Cwo+Gu8oXhSo
         aQUObYwC1CIYA0KqtPKKPHNOiHSWJJ0NN/0P/wvgpmgnTOsTJEnzS/MXfxu1YDAAUSXY
         IBhEFaK3fIhQso7uIlYyHAByRxIG8XpSuTakbWtb6tQtaF5Dsw7D4xd58pjY5Y9UbfDw
         Ra4w==
X-Forwarded-Encrypted: i=1; AJvYcCX8EwfjJVmQIZGvi6Ia+UZCiyB0fwiJyrqem4DEQIISrzhJeFkJaFwsOUhkyVTgFmA49+PjWic=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxUmTcjbUpP51hqOboij2dsgWQGD4Buc32vl+LkDf+8Eahp8Dv9
	LIFQYe1lCzOJD6jEgG8UWonsrZ6cJ4LdU5hI/Kc9NQwQ+EedtGGn3Sswb7zkjbJBdto24A==
X-Gm-Gg: ASbGncuU10/PnCOyj0MxfbV/75NSkpG0ao857LpMl3NYciljUC/s0u7q7hUJV1a8tXd
	iecgdVRDQ+u+mp7xek0dXu3z1cW+IdlvYtH80ev4b1nvyY3M/zqmYbChpcAvYPfDYIWQExDKOlh
	LXHYuHPUKS0J98QN14B+Li7Pewf57gpcsuV8zMhyr+poIOhYlcqVU6aEUNuWm9oKcCIQRM9bxIF
	tltOgiDHeo2n5j/HoxoTjJEsaU2gnJX7dusp7npy/sD5dgFmb11FL5ptEMcBG/3Nj+mm4c9KSKh
	/sLr+G7SPu56CsEuuemdErJSjEjJiEVT3G1IQhkb8XxG02yx2yzLB4oOXHTstgX2jZXV9GnMn4T
	TxFWFSMv4CsufEvTeLfR8O19heVkInsXsenVM3PUqoII16OYOPSBkgjjppPGHzHTwlUdwxqQFVV
	4tjLPSUGp5iO34zP4Ofa8fl4fYqMgCBM0NUWB1BH/wnmcmajrJGalgd11oe3kgXENJ4Y4JFeFnu
	g==
X-Google-Smtp-Source: AGHT+IF+NgY6IRZQEjo7/8NIksK2fAUH5dLF6mvw/Y5nlQgL/18d91TnEelAeRZOAXg4r74Cy/OW4w==
X-Received: by 2002:a05:600c:524f:b0:46e:326e:4501 with SMTP id 5b1f17b1804b1-471178a785bmr89576185e9.10.1760958660376;
        Mon, 20 Oct 2025 04:11:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:2fe:bc2d:65b1:1566? ([2a01:e0a:3cb:7bb0:2fe:bc2d:65b1:1566])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b988dsm15169425f8f.35.2025.10.20.04.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 04:11:00 -0700 (PDT)
Message-ID: <f23c1ae7-de7d-4627-b1e6-e5123c263adc@linaro.org>
Date: Mon, 20 Oct 2025 13:10:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] core: Relax StMM dependency to TEE_STORAGE_PRIVATE
To: Jan Kiszka <jan.kiszka@siemens.com>, Joakim Bech
 <joakim.bech@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>,
 OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
References: <1b6b2738-9813-4d22-9ad3-cb3b5d6a1509@siemens.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <1b6b2738-9813-4d22-9ad3-cb3b5d6a1509@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7E0E94FECB
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.41:from];
	MIME_TRACE(0.00)[0:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.41:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: QZRWKG6DENB6F3FZNQ65OWBL664EEVTV
X-Message-ID-Hash: QZRWKG6DENB6F3FZNQ65OWBL664EEVTV
X-MailFrom: jerome.forissier@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QZRWKG6DENB6F3FZNQ65OWBL664EEVTV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello Jan,

On 10/20/25 12:03, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This allows to run StMM without the userspace supplicant if the
> in-kernel RPMB service is available.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  core/pta/device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/core/pta/device.c b/core/pta/device.c
> index 39ad3ddda..21c13bd94 100644
> --- a/core/pta/device.c
> +++ b/core/pta/device.c
> @@ -67,8 +67,8 @@ static TEE_Result get_devices(uint32_t types,
>  		add_ta(ta->flags, &ta->uuid, buf, blen, &pos, rflags);
>  
>  	if (stmm_get_uuid())
> -		add_ta(TA_FLAG_DEVICE_ENUM_SUPP, stmm_get_uuid(), buf, blen,
> -		       &pos, rflags);
> +		add_ta(TA_FLAG_DEVICE_ENUM_TEE_STORAGE_PRIVATE,
> +		       stmm_get_uuid(), buf, blen, &pos, rflags);
>  
>  	if (IS_ENABLED(CFG_EARLY_TA))
>  		for_each_early_ta(eta)

This looks OK to me. Would you mind posting this as a pull request on
GitHub [1]? That's the normal way we deal with patched for OP-TEE.
Thanks!

[1] https://github.com/OP-TEE/optee_os/pulls

Regards,
-- 
Jerome
