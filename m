Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDA7FCB61B
	for <op-tee@archiver.kernel.org>; Fri,  6 Mar 2026 15:52:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 55C3A431C3
	for <op-tee@archiver.kernel.org>; Fri,  6 Mar 2026 15:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1772812346;
	bh=VB7z6G4/ZLlDD7r7FKPmMsl9wkW7kNZ+4WwUIRbuOyo=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=hcpW6qVwzA7xKiSGCo2qq2tk5YkDQdRjaXlqKlpni4er8JtKzr2K5oMKMChvYow3j
	 Xftc1ggDYPvyFYBzgn/95FLa43X8LXzMJBs4PVJyIrQMrRhqrL/IOjENuZWj1k1bEi
	 fxaCDcaEEVG+7ptu9zGEoZ70EURohZpE9+s0jBHQQLiP1TK2XuzcLE4bxdI+jnOV4i
	 WBxtX+3FB/4v3fWC4QRQmjkR+O+pFvjuZ1+No0DO7S/plLOQi+Xb73RoSdbO8fwdu6
	 AjHATw2z2PlhBsYSW/oR0Ev2yDbO9FhAFzWlhJ2hBCt+r993zrMXj+fkbXS3SIV22/
	 2y/eCz9PoW5lQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C95EA431C3
	for <op-tee@lists.trustedfirmware.org>; Fri,  6 Mar 2026 15:52:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sDoh2dpx;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1C1A344395;
	Fri,  6 Mar 2026 15:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153C4C4CEF7;
	Fri,  6 Mar 2026 15:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772812326;
	bh=VB7z6G4/ZLlDD7r7FKPmMsl9wkW7kNZ+4WwUIRbuOyo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sDoh2dpx7TsNXplh355AlqTBYRr5byBVn6JZf1XoqnYR1K+T+maAULQRE1A8qMTKg
	 xHtDnGP3+GPygxGHbqLIvytNB/VHWUllxD053WfzTs9wBqALLwbozdBF0kwn8YAiHi
	 Xu+QgLYJOxkJYXesCociGAm3EP56F0PYeEeSS654JMCMTmP6hSLKZ10k+hxyes9CS7
	 fc1mRKGwqqkaaOT8ht0+Lr30ETzX5q8TdzY8TBMqGfrLO191G538lT12CTQC62TveW
	 Unm/228UfIdJvqzUYQpEGHVCvmMkdgkcg+yf2e0/KQQIz8ISf60N9dK2kpAVokD3WG
	 +CtPHgNkHZr8w==
Message-ID: <eb0ef26d-d1db-43b9-8113-a7c977d4b8cd@kernel.org>
Date: Fri, 6 Mar 2026 07:52:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] wifi: ath12k: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-14-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260306105027.290375-14-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.08 / 15.00];
	BAYES_HAM(-2.58)[98.14%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C95EA431C3
X-Spamd-Bar: --
Message-ID-Hash: AZ7YTXPWMLQUZBUWKL7EINTF74ZQMPJY
X-Message-ID-Hash: AZ7YTXPWMLQUZBUWKL7EINTF74ZQMPJY
X-MailFrom: jjohnson@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AZ7YTXPWMLQUZBUWKL7EINTF74ZQMPJY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jeff Johnson via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jeff Johnson <jjohnson@kernel.org>

On 3/6/2026 2:50 AM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch ath12k client driver over to generic PAS TZ APIs. Generic PAS TZ
> service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Acked-by: Jeff Johnson <jjohnson@kernel.org>

