Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D10CD3424
	for <op-tee@archiver.kernel.org>; Fri,  1 May 2026 13:27:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 81DDF44A33
	for <op-tee@archiver.kernel.org>; Fri,  1 May 2026 13:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777642035;
	bh=cecY22npZ8O09cZUaB8M0VENwxo6jF899E2WK/sGM8U=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=vZGntWVp4ZeyxnlvckG5OjBzmMzJXPboKzI6kur2QtazBxFpeD9bS3jZhsQb6EMuF
	 nnUBufXNPlxD0F/Ez2Vrq6g7olEwtOUFDjbxN/0a1OGYHaQTfyBQ7525Ht9xRws3jJ
	 DdQfUrWpK2zefJtJWSkDhjRvs3HRtTYxG2WOuW+uknz+F3VSMJOVXQm7Ii6w7dEmkJ
	 O85TlsJbRbH0hgHLAaxO6hBp1BGGQb92nJIUuYAbOuF0tq4g9RqTVsvfmNRgWT14at
	 5/qnDVuTf8tg2e3f+4BkagHGubzNe1oqNvbEVsqPTBhoVW9wKXSfs9vP3iTNBFmGjR
	 gs7QJCAHqIGvQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DE9F6436CA
	for <op-tee@lists.trustedfirmware.org>; Fri,  1 May 2026 13:27:08 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ks9s1mZI;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 307B6435AD;
	Fri,  1 May 2026 13:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09DDC2BCB4;
	Fri,  1 May 2026 13:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777642028;
	bh=cecY22npZ8O09cZUaB8M0VENwxo6jF899E2WK/sGM8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ks9s1mZIkV8HxwO4Mq2+M0rNhz33rtPZ+PEpQg8O0T7agTQM/ie+qo1rwFzMc+b+A
	 VqDH4/+JcAgC//FSDTXVNeTLY3ZnVf6ao0PPeE2eDyKLB70fqAtG1BZGKK4J4NwVYM
	 OfaQriqJVci3Be7SKDrYFRY61OXwF0wXPYEyzsVt5ayiFhEFxMW1q5daFboq3L7XMO
	 64Cx2hTxZcYCLazmmG5vv2hGIZnAcTrMTjhtB+7TrKmtFgXcpfm7HFnitN26O/Gx8U
	 JOUfHUQd9G+45ryjeV+BQBCvFltUxfgmsGCNc+KFS0VD58QfpBufJUzuhvutKP50DW
	 4FZ/nGOcO+OnA==
Date: Fri, 1 May 2026 18:56:50 +0530
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: Re: [PATCH v4 11/15] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <afSqGp-yzZip7q-j@sumit-xelite>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-12-sumit.garg@kernel.org>
 <20260428193714.sg5n3tntww2nuquu@hu-mojha-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428193714.sg5n3tntww2nuquu@hu-mojha-hyd.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[49];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DE9F6436CA
X-Spamd-Bar: ---
Message-ID-Hash: ZF347JPZLBALKRFO2YACX2NA6UDFFWKM
X-Message-ID-Hash: ZF347JPZLBALKRFO2YACX2NA6UDFFWKM
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanat
 han@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZF347JPZLBALKRFO2YACX2NA6UDFFWKM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Wed, Apr 29, 2026 at 01:07:14AM +0530, Mukesh Ojha wrote:
> On Mon, Apr 27, 2026 at 03:25:59PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> > TZ service allows to support multiple TZ implementation backends like QTEE
> > based SCM PAS service, OP-TEE based PAS service and any further future TZ
> > backend service.
> > 
> > Along with that pass proper PAS ID to set_remote_state API. As per testing
> > the SCM backend just ignores it while OP-TEE makes use of it to for proper
> > book keeping purpose.
> 
> When we use 'Along with' or 'while at it', patch is doing two things and
> not one.

Okay, I will split this into 2.

> 
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/media/platform/qcom/iris/Kconfig      | 25 ++++++++++---------
> >  .../media/platform/qcom/iris/iris_firmware.c  |  9 ++++---
> >  drivers/media/platform/qcom/venus/Kconfig     |  1 +
> >  drivers/media/platform/qcom/venus/firmware.c  | 11 ++++----
> >  4 files changed, 25 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/media/platform/qcom/iris/Kconfig b/drivers/media/platform/qcom/iris/Kconfig
> > index 3c803a05305a..f54b759c18aa 100644
> > --- a/drivers/media/platform/qcom/iris/Kconfig
> > +++ b/drivers/media/platform/qcom/iris/Kconfig
> > @@ -1,13 +1,14 @@
> >  config VIDEO_QCOM_IRIS
> > -        tristate "Qualcomm iris V4L2 decoder driver"
> > -        depends on VIDEO_DEV
> > -        depends on ARCH_QCOM || COMPILE_TEST
> > -        select V4L2_MEM2MEM_DEV
> > -        select QCOM_MDT_LOADER if ARCH_QCOM
> > -        select QCOM_SCM
> > -        select VIDEOBUF2_DMA_CONTIG
> > -        help
> > -          This is a V4L2 driver for Qualcomm iris video accelerator
> > -          hardware. It accelerates decoding operations on various
> > -          Qualcomm SoCs.
> > -          To compile this driver as a module choose m here.
> > +	tristate "Qualcomm iris V4L2 decoder driver"
> > +	depends on VIDEO_DEV
> > +	depends on ARCH_QCOM || COMPILE_TEST
> > +	select V4L2_MEM2MEM_DEV
> > +	select QCOM_MDT_LOADER if ARCH_QCOM
> > +	select QCOM_SCM
> > +	select QCOM_PAS
> > +	select VIDEOBUF2_DMA_CONTIG
> > +	help
> > +	  This is a V4L2 driver for Qualcomm iris video accelerator
> > +	  hardware. It accelerates decoding operations on various
> > +	  Qualcomm SoCs.
> > +	  To compile this driver as a module choose m here.
> 
> Here, Space replaced by Tabs just for one line.., should be fine.

Yeah, spaces aren't meant here.

> 
> 
> > diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> > index 5f408024e967..856fa6a79064 100644
> > --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> > +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> > @@ -4,6 +4,7 @@
> >   */
> >  
> >  #include <linux/firmware.h>
> > +#include <linux/firmware/qcom/qcom_pas.h>
> >  #include <linux/firmware/qcom/qcom_scm.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_reserved_mem.h>
> > @@ -79,7 +80,7 @@ int iris_fw_load(struct iris_core *core)
> >  		return -ENOMEM;
> >  	}
> >  
> > -	ret = qcom_scm_pas_auth_and_reset(core->iris_platform_data->pas_id);
> > +	ret = qcom_pas_auth_and_reset(core->iris_platform_data->pas_id);
> >  	if (ret)  {
> >  		dev_err(core->dev, "auth and reset failed: %d\n", ret);
> >  		return ret;
> > @@ -93,7 +94,7 @@ int iris_fw_load(struct iris_core *core)
> >  						     cp_config->cp_nonpixel_size);
> >  		if (ret) {
> >  			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
> > -			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> > +			qcom_pas_shutdown(core->iris_platform_data->pas_id);
> >  			return ret;
> >  		}
> >  	}
> > @@ -103,10 +104,10 @@ int iris_fw_load(struct iris_core *core)
> >  
> >  int iris_fw_unload(struct iris_core *core)
> >  {
> > -	return qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> > +	return qcom_pas_shutdown(core->iris_platform_data->pas_id);
> >  }
> >  
> >  int iris_set_hw_state(struct iris_core *core, bool resume)
> >  {
> > -	return qcom_scm_set_remote_state(resume, 0);
> > +	return qcom_pas_set_remote_state(resume, core->irisi_platform_data->pas_id);
> 
> 
> Should be a separate change for qcom_pas_set_remote_state()
> 
> >  }
> > diff --git a/drivers/media/platform/qcom/venus/Kconfig b/drivers/media/platform/qcom/venus/Kconfig
> > index ffb731ecd48c..574172724e8f 100644
> > --- a/drivers/media/platform/qcom/venus/Kconfig
> > +++ b/drivers/media/platform/qcom/venus/Kconfig
> > @@ -6,6 +6,7 @@ config VIDEO_QCOM_VENUS
> >  	select OF_DYNAMIC if ARCH_QCOM
> >  	select QCOM_MDT_LOADER if ARCH_QCOM
> >  	select QCOM_SCM
> > +	select QCOM_PAS
> >  	select VIDEOBUF2_DMA_CONTIG
> >  	select V4L2_MEM2MEM_DEV
> >  	help
> > diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> > index 1de7436713ed..3c0727ea137d 100644
> > --- a/drivers/media/platform/qcom/venus/firmware.c
> > +++ b/drivers/media/platform/qcom/venus/firmware.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/of_reserved_mem.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/of_device.h>
> > +#include <linux/firmware/qcom/qcom_pas.h>
> >  #include <linux/firmware/qcom/qcom_scm.h>
> >  #include <linux/sizes.h>
> >  #include <linux/soc/qcom/mdt_loader.h>
> > @@ -58,7 +59,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
> >  	int ret;
> >  
> >  	if (core->use_tz) {
> > -		ret = qcom_scm_set_remote_state(resume, 0);
> > +		ret = qcom_pas_set_remote_state(resume, VENUS_PAS_ID);
> 
> This too..
> 
> >  		if (resume && ret == -EINVAL)
> >  			ret = 0;
> >  		return ret;
> > @@ -218,7 +219,7 @@ int venus_boot(struct venus_core *core)
> >  	int ret;
> >  
> >  	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
> > -	    (core->use_tz && !qcom_scm_is_available()))
> > +	    (core->use_tz && !qcom_pas_is_available()))
> >  		return -EPROBE_DEFER;
> >  
> >  	ret = of_property_read_string_index(dev->of_node, "firmware-name", 0,
> > @@ -236,7 +237,7 @@ int venus_boot(struct venus_core *core)
> >  	core->fw.mem_phys = mem_phys;
> >  
> >  	if (core->use_tz)
> > -		ret = qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
> > +		ret = qcom_pas_auth_and_reset(VENUS_PAS_ID);
> >  	else
> >  		ret = venus_boot_no_tz(core, mem_phys, mem_size);
> >  
> > @@ -259,7 +260,7 @@ int venus_boot(struct venus_core *core)
> >  						     res->cp_nonpixel_start,
> >  						     res->cp_nonpixel_size);
> >  		if (ret) {
> > -			qcom_scm_pas_shutdown(VENUS_PAS_ID);
> > +			qcom_pas_shutdown(VENUS_PAS_ID);
> >  			dev_err(dev, "set virtual address ranges fail (%d)\n",
> >  				ret);
> >  			return ret;
> > @@ -274,7 +275,7 @@ int venus_shutdown(struct venus_core *core)
> >  	int ret;
> >  
> >  	if (core->use_tz)
> > -		ret = qcom_scm_pas_shutdown(VENUS_PAS_ID);
> > +		ret = qcom_pas_shutdown(VENUS_PAS_ID);
> >  	else
> >  		ret = venus_shutdown_no_tz(core);
> >  
> > -- 
> > 2.51.0
> 
> with above change
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 

Thanks.

-Sumit
