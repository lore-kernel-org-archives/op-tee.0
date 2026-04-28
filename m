Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BD4FF8867
	for <op-tee@archiver.kernel.org>; Wed, 29 Apr 2026 06:17:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A885543E31
	for <op-tee@archiver.kernel.org>; Wed, 29 Apr 2026 06:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777443464;
	bh=rzWf/oQSHbkLcV8GwzpmrSWI0KfR0fCQpV3xi0rt5Og=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=MWBRrFBLeV+cmKuTrfr90LEPg99J0kDpioydSDktR1nEnL/V3O4WflQcbXEPF4EwH
	 7JsoThEAWFK5Bcd/0VZPIfJR6s2+0uNQQZKpOhpAuvywUXOXwvKt2g4d1CtvNVa2WT
	 sNhx+WdmLL7KV2RVqybbJLHfTBzfm/N2xPg1sEFA/VBpeQiGlqzKuw7fdp2Io9ddo3
	 8Ncrcq7U3aTtLLfY/CWA52BmPS6gc57TrLb0Ctu0+2JGA63GODUlUmCBnFJmrMOAi3
	 JmM0uuT6pghvE3Y99Et5L1DEaDaw0E+CWofuL+ys3gudDe6YjW11gmmg+7Kz3/dSvg
	 KnBrfQxXoW4qg==
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 108EC43250
	for <op-tee@lists.trustedfirmware.org>; Tue, 28 Apr 2026 16:54:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=IvYngyhB;
	dkim-atps=neutral
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6949f3eeaf6so19662eaf.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 28 Apr 2026 09:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1777395244; x=1778000044; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3Z9r4IpEjJMUHPOqoRO6rW4qYst7QOqGLcntOF/K5A=;
        b=IvYngyhBUiPPAen087mDlD20fHkQlmqbwYz+AewXiTv7rZZgYkT7XjAg991G32sBfc
         HZu4Y043H3ACtx+GClTvDPJrY3ZptLU+h6+tqlzd3Rrqi/KlyjDdI0Fb3G0vgfmQz0uZ
         S/J3aygVGE3rCZELKit1bmMOXk+9pOsTmD7hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777395244; x=1778000044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3Z9r4IpEjJMUHPOqoRO6rW4qYst7QOqGLcntOF/K5A=;
        b=KxmhhS9qemo2DhYJhAxR1ctHfY1oFtTQNkDre3xWwV1eIWtwGb8glXyQbO0FQcGBL4
         ImaaT6L5SAh5RQk/cMXADqOsaQ86Z5lr/1GHGsdTqACjfuj87JGZHOVm0qIwZ6T3wWq2
         Qarnz+i4GgZfsbBLVVzbSLWew/Mr0KUMYos6VwfS2j+g1KB1m9Yllw+0EtMpQoUrROEO
         OHoLYxr6PV/BHA8wI+maPQImB/hA+Gd5fNJDJsUtKSeKCDSwX8PaQ0uJtilXUiaTchyS
         0kDtQbZiNiwtzLw0nTa8ErHwUMc5PHa2FtE43ai5YaeeJi49CaELwQlKNj32HU4sCKsB
         1z6g==
X-Forwarded-Encrypted: i=1; AFNElJ86/GA+oCJHxc5kwh9PkKQ8hjvDr+lha2Mf1fv3IoX7CnZJRZprVYfGcge6ocaGMdpuCT4nisU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxfHjPlvj3/CDINvHt/KKH0MQg43pPj6cfGTUqy5qkklL66h6nL
	/GIc/wWDWeKFyHcwAQA/a8V5h40Twz4Dfj3cpPYQdGatzJL6lm8GfALrX2jdm7ZgNg==
X-Gm-Gg: AeBDiet4uznnOiymqGWFG++oJrhnHA21MchL/SDM3QivkXKJpt9DR1uPsXSKIbcS4HC
	0D39lt2iwzMN3b940mWqM3NTa88A/S170qKf6OXjOBoBnRzuschvqhw3Ownd2Wajj1lOjlNdp3d
	/JOnEz1sBcDXUzXld0tgNAuzRncew++3lYzKjavfUEim8wYFwwT2F63j4V/5weML3zIeZDos0p0
	emshXmn0cE5btRzvIwdN8IibpGKLbHcZJgM7dj04Ly5U/WNciLVmfj0miH3JIAILp2M5NSGjVZQ
	Qxpyb8V78rerwuMYvuWxIRi8dPoBoEOHveGzCM2d/hu0WIAOiJq77dmp0m7VE4b7fnSh0hPa3v2
	kOGDFjY0mGB4TYGHB7w7hhsxrPxVLrpTpZ+KSFojgEUdYLU0o7d91Su+Yi7qejr6uDN/jR34WAk
	xKvWsajhfAjKBtNv6XIIsL7x4ZJ0ngomQc57a9585E1WgVQjMuowHLY5bo+6WSwTKWcWOf4Fbnr
	gBzU8k=
X-Received: by 2002:a05:6820:4b05:b0:696:13e9:6863 with SMTP id 006d021491bc7-6965c5ee294mr1871158eaf.2.1777395244239;
        Tue, 28 Apr 2026 09:54:04 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-433effdc79bsm2240677fac.18.2026.04.28.09.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 09:54:03 -0700 (PDT)
Message-ID: <aa2b2823-05b2-49a6-bdd3-622523497a0d@ieee.org>
Date: Tue, 28 Apr 2026 11:54:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] net: ipa: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org,
 konradybcio@kernel.org
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-13-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260427095603.1157963-13-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ieee.org,reject];
	R_DKIM_ALLOW(-0.20)[ieee.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.53:from];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_TRACE(0.00)[ieee.org:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[ieee.org:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.161.53:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 108EC43250
X-Spamd-Bar: --
X-MailFrom: elder@ieee.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: OFW3N24JYRQFBLAUNP575MRDOBLFFGNL
X-Message-ID-Hash: OFW3N24JYRQFBLAUNP575MRDOBLFFGNL
X-Mailman-Approved-At: Wed, 29 Apr 2026 06:16:38 +0000
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm
 .com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OFW3N24JYRQFBLAUNP575MRDOBLFFGNL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Alex Elder via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Alex Elder <elder@ieee.org>

On 4/27/26 4:56 AM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch ipa client driver over to generic PAS TZ APIs. Generic PAS TZ
> service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Looks good to me.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   drivers/net/ipa/Kconfig    |  2 +-
>   drivers/net/ipa/ipa_main.c | 13 ++++++++-----
>   2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
> index 01d219d3760c..a9aff1b7977d 100644
> --- a/drivers/net/ipa/Kconfig
> +++ b/drivers/net/ipa/Kconfig
> @@ -6,7 +6,7 @@ config QCOM_IPA
>   	depends on QCOM_RPROC_COMMON || (QCOM_RPROC_COMMON=n && COMPILE_TEST)
>   	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
>   	select QCOM_MDT_LOADER
> -	select QCOM_SCM
> +	select QCOM_PAS
>   	select QCOM_QMI_HELPERS
>   	help
>   	  Choose Y or M here to include support for the Qualcomm
> diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> index 788dd99af2a4..3cd9e44680e9 100644
> --- a/drivers/net/ipa/ipa_main.c
> +++ b/drivers/net/ipa/ipa_main.c
> @@ -14,7 +14,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/types.h>
>   
> -#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>   #include <linux/soc/qcom/mdt_loader.h>
>   
>   #include "ipa.h"
> @@ -624,10 +624,13 @@ static int ipa_firmware_load(struct device *dev)
>   	}
>   
>   	ret = qcom_mdt_load(dev, fw, path, IPA_PAS_ID, virt, phys, size, NULL);
> -	if (ret)
> +	if (ret) {
>   		dev_err(dev, "error %d loading \"%s\"\n", ret, path);
> -	else if ((ret = qcom_scm_pas_auth_and_reset(IPA_PAS_ID)))
> -		dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> +	} else {
> +		ret = qcom_pas_auth_and_reset(IPA_PAS_ID);
> +		if (ret)
> +			dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> +	}
>   
>   	memunmap(virt);
>   out_release_firmware:
> @@ -758,7 +761,7 @@ static enum ipa_firmware_loader ipa_firmware_loader(struct device *dev)
>   		return IPA_LOADER_INVALID;
>   out_self:
>   	/* We need Trust Zone to load firmware; make sure it's available */
> -	if (qcom_scm_is_available())
> +	if (qcom_pas_is_available())
>   		return IPA_LOADER_SELF;
>   
>   	return IPA_LOADER_DEFER;

