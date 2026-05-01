Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DF4CD3424
	for <op-tee@archiver.kernel.org>; Fri,  1 May 2026 14:12:00 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A0DF844585
	for <op-tee@archiver.kernel.org>; Fri,  1 May 2026 14:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777644719;
	bh=hcyctBNRRAQk+0InkpxlCS1lfZhqWYkgfIjb+wBB1nw=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=nstG2/x8pXVTseJigd1tfkCTrs0DMpMJ0d1YD6df1OxhPx3WSTNgihgZ0KtdZcaaP
	 gjeepLS3VgAHafhh6VccsrKiZRVe5tz3O3QXewOFQAYX/5myvHaMnoI/IkmGPyDJaf
	 16/EXAYQwAAU3b7hr+ZuznbGwB2C5MEDI8KTYEtSc1ew4AcbdEkTyyDXlqjPtERaBL
	 K8xKTBf8hGmy14rbkCf/p9K2daHXSrTKpOiLSPve5allvkdFm5Evk60aEUR/0DX+Mm
	 pYDrgUAMPzTXsOeYbAxmDYRGAhr8BEQ3v1jIA45Ct76TZuonAD4kJNL6aQVQQ8NxBV
	 rwNXZA25v7PbQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CAFC643296
	for <op-tee@lists.trustedfirmware.org>; Fri,  1 May 2026 14:11:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HxgY0soV;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1009C600CB;
	Fri,  1 May 2026 14:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B196C2BCB4;
	Fri,  1 May 2026 14:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777644709;
	bh=hcyctBNRRAQk+0InkpxlCS1lfZhqWYkgfIjb+wBB1nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HxgY0soVS2v6o2/czfldpnU5z90SDBiFfUg0+Lx9jN4IzjA78vFM0PA7EuR7QtUXv
	 KTzVa20tzAgAgsyr+quSek2TYMS0jvllCBPIqOuE8JJ3IGSigLNnPV4LJT72OGMwmA
	 0uWuf+WHwYuQXVvG+9BEibd7pyALC0voy0vyK9NtFGm0frPZm/vioEzems/XFfz7Rz
	 +nriz1HsGO4t63crYPzKRzCKKyOO6qieoVJ3y+aVRM/FqhfouayJevY3ERPy6ePxm4
	 3NcvH7LktzUYWJ/2wD4b0MC2sn3fxEj9Y8ue3HQ7RHle5pMlGmSxk1lUPCj8Xq1+o4
	 Bv8gyJQsH346Q==
Date: Fri, 1 May 2026 19:41:32 +0530
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: Re: [PATCH v4 10/15] drm/msm: Switch to generic PAS TZ APIs
Message-ID: <afS0lAnzVW9jHsxi@sumit-xelite>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-11-sumit.garg@kernel.org>
 <20260429135954.nvr6nyfadsjeymyt@hu-mojha-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429135954.nvr6nyfadsjeymyt@hu-mojha-hyd.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_TLS_LAST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CAFC643296
X-Spamd-Bar: ---
Message-ID-Hash: DTEHIQEYPIBHFIOSBJWFBBTIJYDZGG76
X-Message-ID-Hash: DTEHIQEYPIBHFIOSBJWFBBTIJYDZGG76
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanat
 han@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DTEHIQEYPIBHFIOSBJWFBBTIJYDZGG76/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Wed, Apr 29, 2026 at 07:29:54PM +0530, Mukesh Ojha wrote:
> On Mon, Apr 27, 2026 at 03:25:58PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS
> > TZ service allows to support multiple TZ implementation backends like QTEE
> > based SCM PAS service, OP-TEE based PAS service and any further future TZ
> > backend service.
> > 
> > Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/Kconfig             |  1 +
> >  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  4 ++--
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++-----
> >  3 files changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gdrivers/gpu/drm/msm/Kconfigpu/drm/msm/Kconfig
> > index 250246f81ea9..09469d56513b 100644
> > --- a/drivers/gpu/drm/msm/Kconfig
> > +++ b/drivers/gpu/drm/msm/Kconfig
> > @@ -21,6 +21,7 @@ config DRM_MSM
> >  	select SHMEM
> >  	select TMPFS
> >  	select QCOM_SCM
> 
> do we need this ?

Yeah we do..

> 
> > +	select QCOM_PAS
> >  	select QCOM_UBWC_CONFIG
> >  	select WANT_DEV_COREDUMP
> >  	select SND_SOC_HDMI_CODEC if SND_SOC
> > diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > index 79acae11154a..b556da823897 100644
> > --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > @@ -5,7 +5,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/types.h>
> >  #include <linux/cpumask.h>
> > -#include <linux/firmware/qcom/qcom_scm.h>
> > +#include <linux/firmware/qcom/qcom_pas.h>
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
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > index 66f80f2d12f9..6d68edf0578c 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > @@ -8,6 +8,7 @@
> >  
> >  #include <linux/ascii85.h>
> >  #include <linux/interconnect.h>
> > +#include <linux/firmware/qcom/qcom_pas.h>
> >  #include <linux/firmware/qcom/qcom_scm.h>
> 
> do we need this ?
> 

..needed for qcom_scm_set_gpu_smmu_aperture() API.

> >  #include <linux/kernel.h>
> >  #include <linux/of_reserved_mem.h>
> > @@ -146,10 +147,10 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
> >  		goto out;
> >  
> >  	/* Send the image to the secure world */
> > -	ret = qcom_scm_pas_auth_and_reset(pasid);
> > +	ret = qcom_pas_auth_and_reset(pasid);
> >  
> >  	/*
> > -	 * If the scm call returns -EOPNOTSUPP we assume that this target
> > +	 * If the pas call returns -EOPNOTSUPP we assume that this target
> >  	 * doesn't need/support the zap shader so quietly fail
> >  	 */
> >  	if (ret == -EOPNOTSUPP)
> > @@ -175,9 +176,9 @@ int adreno_zap_shader_load(struct msm_gpu *gpu, u32 pasid)
> >  	if (!zap_available)
> >  		return -ENODEV;
> >  
> > -	/* We need SCM to be able to load the firmware */
> > -	if (!qcom_scm_is_available()) {
> > -		DRM_DEV_ERROR(&pdev->dev, "SCM is not available\n");
> > +	/* We need PAS to be able to load the firmware */
> > +	if (!qcom_pas_is_available()) {
> > +		DRM_DEV_ERROR(&pdev->dev, "Qcom PAS is not available\n");
> >  		return -EPROBE_DEFER;
> >  	}
> >  
> > -- 
> > 2.51.0
> > 
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> 
> 

Thanks.

-Sumit
