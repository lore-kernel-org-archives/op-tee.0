Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C9ECD3424
	for <op-tee@archiver.kernel.org>; Fri,  1 May 2026 14:00:22 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 93F1C44D8C
	for <op-tee@archiver.kernel.org>; Fri,  1 May 2026 14:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777644021;
	bh=e9qq+VwXLefAq4gTECeQmQftjSoYyeTGHieCtYm/GNE=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=u2TYsCQeRTnLMs8V6cz3xzAj0m3msFTTdFcEP8YrMVKSbsD6oXauf9g0EVWCA3DHI
	 Bd3+yJCoZIoknMoV4OsGtBU3+Y40zOOcNJ+lzGUuRmAE2ntXNdh/k0kClMca9huZgE
	 KGFGQbzNu9Du9DS+Mh+rtR6gVQ+kUhmGZR2j77sAPW3w2tpSsfeWUJZp2e1eFwVGNA
	 zXaWMUhH0zu+QcVqHS01RWum+BouEL1HpTdN2IjKrwRg4apXkzZ8TbGQHkXK8iNopC
	 Mmzr5nMteEq6zJL0qv4PYK/XtKh2vEixBCjuuFIaMQM5Ue4ZURdMQbu6VHSJnK8BFe
	 U/q318ozGs1xw==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 99094432A6
	for <op-tee@lists.trustedfirmware.org>; Fri,  1 May 2026 14:00:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=miD4z4sA;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F37F940339;
	Fri,  1 May 2026 14:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0395CC2BCB4;
	Fri,  1 May 2026 13:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777644013;
	bh=e9qq+VwXLefAq4gTECeQmQftjSoYyeTGHieCtYm/GNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=miD4z4sAu+2Nxj3yLh8APL1hMcsNfokQiP+Ck63ukHOsSx6b1rQZB5LufDIfeqaUw
	 36LGRLYQwMxmSLXpwZCzo51cPgrW9oOaUKhaCHc2vTF3beXibjleS+0wYugts7swKA
	 K4/KpLQ5RnazFfAIdoXCPO/HcemiCmlhQ9zpP3ah1WlEhN8ECtR/3oTbVU/eJAsWl8
	 ZvfvLYqf4X39EWHWJcSq/NcAj0nraceTyQjksNKh9zfDoGymXjCQ7WKno3dP4hiGza
	 +Eyi/AdF1gw3CVn8jbletKDGzQ0JVrVPX1stm8EXqX+fpMqaht+kngCbxVSvN7zIN1
	 N8XczX3/pOuSw==
Date: Fri, 1 May 2026 19:29:56 +0530
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: Re: [PATCH v4 07/15] soc: qcom: mdtloader: Switch to generic PAS TZ
 APIs
Message-ID: <afSx3GpKhCpUIWv4@sumit-xelite>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-8-sumit.garg@kernel.org>
 <20260429134208.pqo67sh3jkvsa5ka@hu-mojha-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429134208.pqo67sh3jkvsa5ka@hu-mojha-hyd.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 99094432A6
X-Spamd-Bar: --
Message-ID-Hash: QPKE76ZTJDJ7YG6XI3G4NA6KRRYDDG3N
X-Message-ID-Hash: QPKE76ZTJDJ7YG6XI3G4NA6KRRYDDG3N
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanat
 han@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QPKE76ZTJDJ7YG6XI3G4NA6KRRYDDG3N/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Wed, Apr 29, 2026 at 07:12:08PM +0530, Mukesh Ojha wrote:
> On Mon, Apr 27, 2026 at 03:25:55PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Switch mdtloader client driver over to generic PAS TZ APIs. Generic PAS
> > TZ service allows to support multiple TZ implementation backends like QTEE
> > based SCM PAS service, OP-TEE based PAS service and any further future TZ
> > backend service.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/soc/qcom/mdt_loader.c       | 12 ++++++------
> >  include/linux/soc/qcom/mdt_loader.h |  6 +++---
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> > index c004d444d698..fdde7eda538a 100644
> > --- a/drivers/soc/qcom/mdt_loader.c
> > +++ b/drivers/soc/qcom/mdt_loader.c
> > @@ -13,7 +13,7 @@
> >  #include <linux/firmware.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > -#include <linux/firmware/qcom/qcom_scm.h>
> > +#include <linux/firmware/qcom/qcom_pas.h>
> >  #include <linux/sizes.h>
> >  #include <linux/slab.h>
> >  #include <linux/soc/qcom/mdt_loader.h>
> > @@ -229,7 +229,7 @@ EXPORT_SYMBOL_GPL(qcom_mdt_read_metadata);
> >  
> >  static int __qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
> >  			       const char *fw_name, int pas_id, phys_addr_t mem_phys,
> > -			       struct qcom_scm_pas_context *ctx)
> > +			       struct qcom_pas_context *ctx)
> >  {
> >  	const struct elf32_phdr *phdrs;
> >  	const struct elf32_phdr *phdr;
> > @@ -271,7 +271,7 @@ static int __qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
> >  		goto out;
> >  	}
> >  
> > -	ret = qcom_scm_pas_init_image(pas_id, metadata, metadata_len, ctx);
> > +	ret = qcom_pas_init_image(pas_id, metadata, metadata_len, ctx);
> >  	kfree(metadata);
> >  	if (ret) {
> >  		/* Invalid firmware metadata */
> > @@ -280,7 +280,7 @@ static int __qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
> >  	}
> >  
> >  	if (relocate) {
> > -		ret = qcom_scm_pas_mem_setup(pas_id, mem_phys, max_addr - min_addr);
> > +		ret = qcom_pas_mem_setup(pas_id, mem_phys, max_addr - min_addr);
> >  		if (ret) {
> >  			/* Unable to set up relocation */
> >  			dev_err(dev, "error %d setting up firmware %s\n", ret, fw_name);
> > @@ -472,7 +472,7 @@ EXPORT_SYMBOL_GPL(qcom_mdt_load);
> >   * firmware segments (e.g., .bXX files). Authentication of the segments done
> >   * by a separate call.
> >   *
> > - * The PAS context must be initialized using qcom_scm_pas_context_init()
> > + * The PAS context must be initialized using qcom_pas_context_init()
> 
> Should devm_qcom_pas_context_alloc() now

Ack.

> 
> >   * prior to invoking this function.
> >   *
> >   * @ctx:        Pointer to the PAS (Peripheral Authentication Service) context
> > @@ -483,7 +483,7 @@ EXPORT_SYMBOL_GPL(qcom_mdt_load);
> >   *
> >   * Return: 0 on success or a negative error code on failure.
> >   */
> > -int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx, const struct firmware *fw,
> > +int qcom_mdt_pas_load(struct qcom_pas_context *ctx, const struct firmware *fw,
> >  		      const char *firmware, void *mem_region, phys_addr_t *reloc_base)
> >  {
> >  	int ret;
> > diff --git a/include/linux/soc/qcom/mdt_loader.h b/include/linux/soc/qcom/mdt_loader.h
> > index 82372e0db0a1..142409555425 100644
> > --- a/include/linux/soc/qcom/mdt_loader.h
> > +++ b/include/linux/soc/qcom/mdt_loader.h
> > @@ -10,7 +10,7 @@
> >  
> >  struct device;
> >  struct firmware;
> > -struct qcom_scm_pas_context;
> > +struct qcom_pas_context;
> >  
> >  #if IS_ENABLED(CONFIG_QCOM_MDT_LOADER)
> >  
> > @@ -20,7 +20,7 @@ int qcom_mdt_load(struct device *dev, const struct firmware *fw,
> >  		  phys_addr_t mem_phys, size_t mem_size,
> >  		  phys_addr_t *reloc_base);
> >  
> > -int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx, const struct firmware *fw,
> > +int qcom_mdt_pas_load(struct qcom_pas_context *ctx, const struct firmware *fw,
> >  		      const char *firmware, void *mem_region, phys_addr_t *reloc_base);
> >  
> >  int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
> > @@ -45,7 +45,7 @@ static inline int qcom_mdt_load(struct device *dev, const struct firmware *fw,
> >  	return -ENODEV;
> >  }
> >  
> > -static inline int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx,
> > +static inline int qcom_mdt_pas_load(struct qcom_pas_context *ctx,
> >  				    const struct firmware *fw, const char *firmware,
> >  				    void *mem_region, phys_addr_t *reloc_base)
> >  {
> > -- 
> > 2.51.0
> > 
> 
> With above nit
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Thanks.

-Sumit
