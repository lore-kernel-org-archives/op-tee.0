Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414FB106F304
	for <op-tee@archiver.kernel.org>; Thu, 26 Mar 2026 08:50:32 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 79DB6443FD
	for <op-tee@archiver.kernel.org>; Thu, 26 Mar 2026 08:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1774515031;
	bh=Nk3OQJcQa7+IWGZDgf0ivm4hL2jKChEzfHAOrtGBL30=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=jKpZl6uCUJBGsQy73z0pyyh0wna28rRgvwDKgFSJsymhpMGLw7iJPVTjiRwiI9YOg
	 0xRs8nTtYuYX2ndWU11c1eN66IZ1g0cvttjYcl5zrc3wBMvYhB51lHBc7K1/lvwiLm
	 v1BSvtmKK2/U2vgcoYiRra8WZzTsfG59kUl5ZCkjE3W6AJ8nOuIo/jqW8oknL0HJ+3
	 aHfY/Z8CEBeYnV/q/Ng4do5AntdwUdhvBloHSmT0+f1Z+W/En4Xu3oH6jSAAhqmUcR
	 E2CNLZfFRyt7Z0eplPT7u20i0GrQKh4tBvoNU6rCiGbnKHRbj3dIbwh502ULjqciF2
	 H2wJoiP9bPI4g==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D64A243A61
	for <op-tee@lists.trustedfirmware.org>; Thu, 26 Mar 2026 08:50:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eWGx2gOL;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 34BCC44222;
	Thu, 26 Mar 2026 08:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42667C116C6;
	Thu, 26 Mar 2026 08:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774515019;
	bh=Nk3OQJcQa7+IWGZDgf0ivm4hL2jKChEzfHAOrtGBL30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eWGx2gOLvfHG1xA6EpBU5XssaH7AfwFrQA3TL8MLeYvE58DFfYB+nnd8vYfaFzkd5
	 tZa3gLuhJniQtc+eMnqm0Ci4fM8aZ8bZw0zdRPKw8aPsmlkX0QrttqDtSHEKcGgU0P
	 eSuGGXg+6WgNmt5i6568+PjflSOR56src4Ur83Ye/WgmFoofV3I6YFNt3sF/wd8bf3
	 4D3T+8od5S/QtunojXburPPXiBzJzjIyK4/8BljTxruiOtlHbtOQXSsvFooGr9s8mY
	 ENWjxKH8Ox3u0OzttcoWYRmtEVP+sj1YLfb6OvbG9+iC2I2DZ6VyEUFE/c+JHNVoVu
	 SyL5V108Zuppg==
Date: Thu, 26 Mar 2026 14:20:01 +0530
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH 10/14] drm/msm: Switch to generic PAS TZ APIs
Message-ID: <acTzOTUVL6uYQZwh@sumit-xelite>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-11-sumit.garg@kernel.org>
 <v4ffww2r4ljqqbmvsc5jcr4ztqjbpfb42xryjeuz4abqiwup3a@2gfeelhjzzz4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v4ffww2r4ljqqbmvsc5jcr4ztqjbpfb42xryjeuz4abqiwup3a@2gfeelhjzzz4>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D64A243A61
X-Spamd-Bar: --
Message-ID-Hash: MXIFYZKVWEY5UOHPWRIMXMSBAODNZSPJ
X-Message-ID-Hash: MXIFYZKVWEY5UOHPWRIMXMSBAODNZSPJ
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.
 qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MXIFYZKVWEY5UOHPWRIMXMSBAODNZSPJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Wed, Mar 25, 2026 at 06:34:18AM +0200, Dmitry Baryshkov wrote:
> On Fri, Mar 06, 2026 at 04:20:23PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS
> > TZ service allows to support multiple TZ implementation backends like QTEE
> > based SCM PAS service, OP-TEE based PAS service and any further future TZ
> > backend service.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  4 ++--
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++-----
> >  2 files changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > index ef9fd6171af7..3283852f9a14 100644
> > --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > @@ -5,7 +5,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/types.h>
> >  #include <linux/cpumask.h>
> > -#include <linux/firmware/qcom/qcom_scm.h>
> > +#include <linux/firmware/qcom/qcom_pas.h>
> 
> Missing `select QCOM_PAS`.

Sure, I will add that in next spin.

-Sumit

> 
> 
> >  #include <linux/pm_opp.h>
> >  #include <linux/nvmem-consumer.h>
> >  #include <linux/slab.h>
> > @@ -653,7 +653,7 @@ static int a5xx_zap_shader_resume(struct msm_gpu *gpu)
> >  	if (adreno_is_a506(adreno_gpu))
> >  		return 0;
> >  
> > -	ret = qcom_scm_set_remote_state(SCM_GPU_ZAP_SHADER_RESUME, GPU_PAS_ID);
> > +	ret = qcom_pas_set_remote_state(SCM_GPU_ZAP_SHADER_RESUME, GPU_PAS_ID);
> >  	if (ret)
> >  		DRM_ERROR("%s: zap-shader resume failed: %d\n",
> >  			gpu->name, ret);
> 
> -- 
> With best wishes
> Dmitry
> 
