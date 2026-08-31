Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA64C61DE2
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 08:26:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 635AD4519E
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 08:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788164778;
	bh=L50lYICP106cKUnxwcy3VRTlzI/KCvX3m5TcfCKQ+uY=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=TgV0dtow48t8SjRp1+IW44dbMomCJA/Xe4OLnZtULJyxJ7JVLBsw5zXFm4QcvBGCD
	 zHeVjZENC874c0Q12miK60FIqxWHdD8LxbLGEZDSu+MKnzQnTUYBqjhaItUnqPXpmQ
	 U8k2M7a5mhcA0Y4J1HFWxKUCnS2Z6e8YalCJhC7xQpDZZhp6+WbBRi8xiD+bkyLCul
	 KnU3W4u/Cn9vldoDM+sgpq6uZ1Ijg5Ji7oVtQvlFN2DpuB3Y3TyZQCRLG9dpEManY6
	 0sYK4Cu42n9DQY4bz9lN9fufYQCtdPIiSmB3gd/MY2aOqI3BEPOaY8m14BDwan4cMk
	 hgueS1ULHn0mw==
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2FD31443CF
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 08:26:11 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IC3Exh5m;
	dkim-atps=neutral
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c01c79467so367221cf.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 01:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788164771; cv=none;
        d=google.com; s=arc-20260327;
        b=DEM2XjCPlxQfT+tj4fI8rTyghM6Ttl8vlWh0Qo30z6N0h81wL0I7fvy6+MkhxF6Vxr
         2CcSSeidFk7730Xgnhxqx0CT1OZ611xozb7oaIgijwqQb69Ct0SKo4W3e645fHsABAAb
         //i4Oez8eDlfurh6qf41DtMTkBZYKO/xI7Sv+7sXCA+2QbMSH1bgCAxR88OnKKbuNVgY
         5JASQSHDE3eKr8gNLqgDORm+HZbDtTAkHdR/YouiGBHR519IyKgvFciP81bjT2E8u3pW
         C1M5A7k9THMFgCn8FjBPfoaLwxCpUUwZwhyUusjMKbhf3SBhnGTQysxsN1+w6O95MYYW
         WBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L50lYICP106cKUnxwcy3VRTlzI/KCvX3m5TcfCKQ+uY=;
        fh=iixv1IUE182P+oNq0j+2YwWoS+6rWBuzLyEEXj8ERqU=;
        b=ZmgbzxTHSLXgY/9oB0uFYJnQb0AJAZbSL3XJ9r/aMhfs5bqftcidpyY2ha8qa/yWXD
         +SLDydlx4Mv9kwMNeSOSoE57k7BrIrnV7WEsvGOFWOuIkl3kd2iSDP1pXqlCWQ/qhTsf
         sU4DzcZOIOslJJls9ipP+1G1+ZS0cXdasPVHPCnka5v6dcnoreFawqsK1GmL4fKMhiku
         hzGMN10NHMrsmdXQ5jxN5mlad83ZrtZYpdVsYCsWB1gGj12StFIFdsFnibOUiOIb8Jax
         v12PHCdV6sa/RdTfOigv6YO53l8vgeQAEk64SEPMjGXKy5PgdJpjT8NTPfftJNSJ0H1u
         n1Hg==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788164771; x=1788769571; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L50lYICP106cKUnxwcy3VRTlzI/KCvX3m5TcfCKQ+uY=;
        b=IC3Exh5mPYe+esc/4/67hzFqYvmYoyZRqF4pxZ+1K+Ty43jb8lTbtWUvo3VvyvDy2s
         L1sGMDjIqso4H3FvZxulyHupt2i6aplKXJ51PVpTnyPAzGbW7EPRrYGyzg44n+MNfBsN
         4b9aKUwHkzBi/WvgVdi2hcfvCbAHUpDh8tOpNyNNzKGTCY82lz6iGOvuYnX5//j0iWa5
         wh/Xl6uW/MR/67zBUUjWnuI4LTvq+ZC6GHo3DMWPzOsWJh4vJ7bprnfrkbDoB5gmt3LK
         gfqDUQ6+lWXUMCcQdqrEohvsJ+8GS8va/qpQCFOzMxeqJqxm/JszMpqgT1aJri9HVHkA
         /P0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788164771; x=1788769571;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L50lYICP106cKUnxwcy3VRTlzI/KCvX3m5TcfCKQ+uY=;
        b=ic35AY3qag6UtB2FYy61tS/guk7Gf7QInpwPWdtxVPcP+hFn2KxwkgzARvxmb5ksqQ
         8MsdVamZcq1dXa5KKByRAGkAZhnuOb3hCIlZ+A3VNbbJ6XmpK9E24XPhmVWSDF6X9m7g
         dgO7PzWlRpZU3AbUA2ezdLsdV7r1rrVxCgGXP95bu87mHz90Lt7cCnm0Va/4RZJhbjJ4
         k0t5DAsJRPV4ngt056r7nSwLVAGMHjkSe9P9nsxzH2hx0uCUnsTaevUx9c75FOt127Cx
         cVxAJ28hcjzEBUlnN/Z8eXbAgs4FBn1/4Pa8P1RvsJOj9dd9Q+tQnWczJPpUbTVWi3bq
         p69g==
X-Forwarded-Encrypted: i=1; AHgh+RqMucYdQICPKS4zBMbx4mhhlZPCp+ULtmQ5UwgnilCEo5MB4Gk3ROMY2JvklM4pTXDcAGQ/IY8=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++lBzdDdJ6vnxV+lRb4AiuXeSDzifoK1091GtfnmdgmB4WC8A2TF
	mj4R/94Wh/s7+m2kt85J7xZW1o5+4BlYs2gAuyTZ/soUgyXLLKrcHn98S0UQSl3RHeCf0O8WFfx
	LJahi1uSk2ikVHY2Ivx3frF2pQHcgUCxcG5QmXWpV
X-Gm-Gg: AR+sD11EG/io7ZpN8DMKc4egmatlQJXxlpVCaRblgWXmuZ0mAUC3lUeyUO4qS2hIDfI
	hbwm2xgMgoXxycuzRqc5WljWGetOwutrEHDAqCbXAox/qUprU5A2xQXqaOJVvLA/dif3LVnVm8I
	eDsn6QR0uvi6NdZbgfe0gEBcLzrOOAotKW8IM6MRHarGlJN9fazP8YltCDn75Dkze4cwimh5WaL
	5C+EkKYCeBwW1haymnD5doti/PJe85VfiK4yhw/MxB3+i3PjftEZ+QrkuGjCX4weVTRgBB1b8ou
	Axkx3C2CtrZlAxRSe+dfIgicixub4l58pBte7mLKUn3bSfMy/5DoGhxrNeDG++b2tKnhm1f6f2W
	n4Q==
X-Received: by 2002:a05:622a:90b:b0:52b:806e:2633 with SMTP id
 d75a77b69052e-52ff716a474mr28081931cf.1.1788164769903; Mon, 31 Aug 2026
 01:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260827070345.2853821-1-jorge.ramirez@oss.qualcomm.com> <20260827070345.2853821-2-jorge.ramirez@oss.qualcomm.com>
In-Reply-To: <20260827070345.2853821-2-jorge.ramirez@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:25:33 +0800
X-Gm-Features: AcwNN1WVv-1JxNRBi1FdqkSyKkrL3KqIt4GooQUTfRRAXFQqWs_ZljDsUxFdizM
Message-ID: <CAE14pdejGMw-4hpj+nydgMi_Ff0WiACEEisa6Y=wp5cV1H_NnA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ufs: rpmb: retry power-on UNIT ATTENTION on the
 RPMB WLUN
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, beanhuo@iokpp.de,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	beanhuo@micron.com, can.guo@oss.qualcomm.com, sumit.garg@oss.qualcomm.com,
	jenswi@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.182:from];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.182:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2FD31443CF
X-Spamd-Bar: ---
Message-ID-Hash: ZU5VRXZ6F263K76F5YRTCWNR2ZVRUAD5
X-Message-ID-Hash: ZU5VRXZ6F263K76F5YRTCWNR2ZVRUAD5
X-MailFrom: stanleyjhu@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZU5VRXZ6F263K76F5YRTCWNR2ZVRUAD5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Stanley Jhu via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Stanley Jhu <stanleyjhu@google.com>

On Thu, 27 Aug 2026 09:03:35 +0200, Jorge Ramirez-Ortiz wrote:
> After a power cycle, the first command sent to any UFS logical unit
> completes with CHECK CONDITION reporting a power-on UNIT ATTENTION.
> The SCSI core surfaces this condition to the caller rather than
> retrying it.
>
> For the RPMB well-known LU the first command after boot is the first
> RPMB frame, and RPMB has no earlier, guaranteed access that could clear
> the condition beforehand. The power-on UNIT ATTENTION therefore reaches
> RPMB and fails that first frame, breaking RPMB on every cold boot.
>
> The RPMB WLUN needs the power-on UNIT ATTENTION to be retried so that
> RPMB works from the very first access after a power cycle.
>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>

Reviewed-by: Stanley Jhu <stanleyjhu@google.com>
