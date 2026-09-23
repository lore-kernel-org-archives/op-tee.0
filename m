Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45EEC98304
	for <op-tee@archiver.kernel.org>; Wed, 23 Sep 2026 21:08:40 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 356F245407
	for <op-tee@archiver.kernel.org>; Wed, 23 Sep 2026 21:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790197720;
	bh=u9vyTnfDdTrmd9y7fzOYI9Chf27iTNx4Gu6KyxRoDT4=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=WH1XjL1yOWuNRz4RRY9pT48E2hShWkRrkHzvwe+H9kcfv0edIlSdXyQ704Qe+eiqO
	 W8RfGO52UdZTcVbLomxkYOxmBY1KCvCJoeAgjPkzJkI1peBPChQdBH/murBsbFb/xf
	 wouw3v259CgtzlsZIyqGKYIXPTtqP4rzYOPA7TBH6ZIm8S95zOY0efzTxCDPj+1FHy
	 6SqcHNrNJRdxV9PUGUtTFyNAjc3YFL+R5FvCNMqSmwzemBRWN4Lybwe18PFzK3Hmuq
	 VP3ar/OFeG5i6YRAJzw6hSajFuOiORuXLaPgBFSAtbe1wInhvriKeg+/aDEMftAnS8
	 gT15IgfKE2O8w==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id ADC964323F
	for <op-tee@lists.trustedfirmware.org>; Wed, 23 Sep 2026 21:08:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IFfLk5F+;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C2D3D600AA;
	Wed, 23 Sep 2026 21:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16721F00893;
	Wed, 23 Sep 2026 21:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790197711;
	bh=oYRyYQ7jGFmso8AY6dUwDwpqY0QEPIOZBmqP3y/+Wjw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IFfLk5F+vPh8IZNhqF0jC6aiB53HDZvSF2VK2z8f7otoMhT2JY81X0DRgu4kSZy1c
	 joRyiJr0iXdIujrsXvmcilGrrlkhEL9YLIUEvmzKixvjEeFJ8vxgxkwXlAMImcgbz5
	 ObT2M39E9XWkmhhoICbrZZTEJIdLs70sQZ7CLs85nDdlrYvQI58UEG0MV2Zli3ORfN
	 qEGaY7uobvyPgkqQYN9MxRINi7FLvSkgqHtmHbwFsTDaPMYxN2sV8xdrPRQjkvGaFE
	 AUROK5OvdNxX5Jpjfb4/VhakF9Jk6w7yYiqjrfNKsr4mXgTRJosRSZ3QC2bAL67QYd
	 6F00ow4Wk2EBQ==
Message-ID: <49153dff-b4e0-43ac-aa82-15175fea6445@kernel.org>
Date: Wed, 23 Sep 2026 22:08:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] firmware: qcom: scm: pass qcom_scm through the
 exported API
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
 <bRb6NzJiFvNGB0X3BeiVytgZNlRv88LFlcaBwwFIFa3GtVZhn5bh9EoRRDliRtgsnlQNMddvcIPK-5HK9x7z9Q==@protonmail.internalid>
 <20260914-scm-device-api-v1-2-3573e2596c51@redhat.com>
Content-Language: en-US
In-Reply-To: <20260914-scm-device-api-v1-2-3573e2596c51@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.19 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-2.69)[98.64%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,pengutronix.de,armlinux.org.uk,arm.com,gmail.com,oss.qualcomm.com,poorly.run,linux.dev,somainline.org,ffwll.ch,8bytes.org,rendec.net,arndb.de,linuxfoundation.org,linaro.org,intel.com,chromium.org,codeaurora.org];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received,172.105.4.254:from];
	RCPT_COUNT_GT_50(0.00)[59];
	RCVD_COUNT_TWO(0.00)[2];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: ADC964323F
X-Spamd-Bar: -----
Message-ID-Hash: 2ZRI2AWGW25E3OHTI5AOKOQDVMQ6LNGZ
X-Message-ID-Hash: 2ZRI2AWGW25E3OHTI5AOKOQDVMQ6LNGZ
X-MailFrom: bod@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, iommu@lists.linux.dev, linux-media@vger.kernel.org, linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, linux-gpio@vger.kernel.org, linux-remoteproc@vger.kernel.org, op-tee@lists.trustedfirmware.org, Maxime Ripard <mripard@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2ZRI2AWGW25E3OHTI5AOKOQDVMQ6LNGZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Bryan O'Donoghue via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Bryan O'Donoghue <bod@kernel.org>

On 14/09/2026 13:41, Albert Esteve wrote:
>   static int spm_cpuidle_drv_probe(struct platform_device *pdev)
>   {
> +	struct qcom_scm *scm = qcom_scm_get();
>   	int cpu, ret;
> 
> -	if (!qcom_scm_is_available())
> +	if (!scm)
>   		return -EPROBE_DEFER;

Is this equivalent code ?

Its also a bit confusing to me that the next patch adds a .available 
field to the qcom_scm struct.

I see where you do get drvdata but I haven't managed to find in the 
series where the data gets set - haven't asked an LLM either - I think 
the logic to associate the scm pointer and get it should live together 
in one patch so that the logic is easier to find and reason about.

---
bod
