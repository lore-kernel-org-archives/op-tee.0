Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E669C98304
	for <op-tee@archiver.kernel.org>; Wed, 23 Sep 2026 21:00:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CC73E4539B
	for <op-tee@archiver.kernel.org>; Wed, 23 Sep 2026 21:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790197224;
	bh=ccQz9YvjRV9nNKuWS/TlWg8SWDYqOPJmHdP9RIhMSUY=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=aA3JHxCt+5xz4V8CZQymOkA/EfkfXHY2TxZ2RpLHqFqQF8/KP6syHVUYLtD7qNdS2
	 95m5pDx1+az/XX4s/ECLTO2XkvhqUnmiNJ8KdFMckWuQeGRVuiuDc1NUsXt7+Kbvkz
	 fPKmv5aaqxnEgVPSr4WNa0/63zU4z3bIhIw/km3rxWMcAaQhaIkDsN4TkmdBK9c1Ps
	 U3qiTbIE+Y9TqVv8/VhNBuDlezETWihpBz/TbxMuqEYQd56cGm4jZyjXH3u5nj/NaV
	 V3nYslJ4KPr6IYAklZuWxU07xKp3S+8I9w7VCrOLMnDwkxepdF/8E2JeXy1fYohChY
	 H8cFhlm5HqfRA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C47614323F
	for <op-tee@lists.trustedfirmware.org>; Wed, 23 Sep 2026 21:00:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j12baXkZ;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DB6E943963;
	Wed, 23 Sep 2026 21:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A831F000FF;
	Wed, 23 Sep 2026 21:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790197216;
	bh=gopMSo0mzfjrUmtaCVKnC5i427RNBJMYYN+bfD5UTH4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=j12baXkZU6VWzbYrJ0+NzEVS/CfB8Rh8M798lc+51zoz+KwjyW3gRw6z7EbYzEKEt
	 ZvK0X4S2aRfw3cy98PCg798VnCw2rE7bfIYDt0xAL3U971Y+q8VpPNSApFBWoOB/KT
	 GYT2UyxeQI99pJh0d6zdMidf9LV8/FqeIZJtB0pCSDN+mByRuB8vFuwtybfAlOxXz5
	 Emh6muuBBbpxRkqAdRwCwdcgzHCg2AkyVLFkGW5mRTdrDHfNbeedm2Zedp/LbGYsw9
	 HH+YBEKk6Hr2IUcRUjHJrynTu5TcVnQd3Gg0SAZBacZirPA9pv1eDsGDNBQUY5X6UD
	 eqECMtzKo5Dig==
Message-ID: <b1340496-1ff3-4ad7-87c3-36d2162efbfa@kernel.org>
Date: Wed, 23 Sep 2026 22:00:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] firmware: qcom: scm: pass qcom_scm to internal
 helpers
To: Albert Esteve <aesteve@redhat.com>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Russell King
 <linux@armlinux.org.uk>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Maximilian Luz <luzmaximilian@gmail.com>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jeff Johnson <jjohnson@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Brian Norris <briannorris@chromium.org>,
 Govind Singh <govinds@codeaurora.org>,
 Niklas Cassel <niklas.cassel@linaro.org>, Kalle Valo <kvalo@kernel.org>
References: <20260914-scm-device-api-v1-0-3573e2596c51@redhat.com>
 <EKwbCgCnxbNX4p95qJ3xoytzeNBBLc2L_HOVWr-S-y8n7pNOIToj37TyoXRcLyIK1gjq_IvbreQ331gw6jIK9Q==@protonmail.internalid>
 <20260914-scm-device-api-v1-1-3573e2596c51@redhat.com>
Content-Language: en-US
In-Reply-To: <20260914-scm-device-api-v1-1-3573e2596c51@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,pengutronix.de,armlinux.org.uk,arm.com,gmail.com,oss.qualcomm.com,poorly.run,linux.dev,somainline.org,ffwll.ch,8bytes.org,rendec.net,arndb.de,linuxfoundation.org,linaro.org,intel.com,chromium.org,codeaurora.org];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	RCPT_COUNT_GT_50(0.00)[59];
	RCVD_COUNT_TWO(0.00)[2];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C47614323F
X-Spamd-Bar: --
Message-ID-Hash: VY5MHM5RA2TRCGFQO2ZVQAXJ5OGGD3DL
X-Message-ID-Hash: VY5MHM5RA2TRCGFQO2ZVQAXJ5OGGD3DL
X-MailFrom: bod@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, iommu@lists.linux.dev, linux-media@vger.kernel.org, linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, linux-gpio@vger.kernel.org, linux-remoteproc@vger.kernel.org, op-tee@lists.trustedfirmware.org, Maxime Ripard <mripard@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VY5MHM5RA2TRCGFQO2ZVQAXJ5OGGD3DL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Bryan O'Donoghue via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Bryan O'Donoghue <bod@kernel.org>

On 14/09/2026 13:41, Albert Esteve wrote:
>   int qcom_scm_pas_auth_and_reset(u32 pas_id)
>   {
> -	return __qcom_scm_pas_auth_and_reset(__scm->dev, pas_id);
> +	struct qcom_scm *scm = __scm;
> +
> +	return __qcom_scm_pas_auth_and_reset(scm->dev, pas_id);
>   }
>   EXPORT_SYMBOL_GPL(qcom_scm_pas_auth_and_reset);

Why make this change at all though ?

It takes a pointer to the file static _scm

The reset of the patch looks straight-forward to me but this change 
caught my eye.

---
bod
