Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B264FCCFA13
	for <op-tee@archiver.kernel.org>; Fri,  1 May 2026 13:59:12 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EC43A44E0A
	for <op-tee@archiver.kernel.org>; Fri,  1 May 2026 13:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777643952;
	bh=pyGGj8CgYj8YKM+1n+ffgeaGs4n29YMxEkBJUo1PKMo=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=hZ5f4pGW5EpCD9mzc0kFClvYE40RuBy0Fe4oEniVn3NKaVGEKbYp/Pu+V5Z01+1Rl
	 FqATLEzhQCdVBSbtegWTJSqTaE2lp0pfzxXX01Pvq7+0W/7txNZS2o3gAsExLmPsdg
	 ij3zidJZY1idRM5/CcTFmWtVErEi0oRAUODzMleuSLEaqdDpfigiqIBC0fUwFxUh1A
	 D4sc6BjeY98+ekK+DFspRrTEexrZXWGOUei+oxFIW6OhaIN4rE9wvO0IsYP1gAzhtT
	 Rr+Zb2La48+/Dov6ompWiJgRJufKOYIGuKOjwPN8chVdfmOBHTZstVNseCSLG6HKe9
	 4YWQb4/xwHGEw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 26E61436CA
	for <op-tee@lists.trustedfirmware.org>; Fri,  1 May 2026 13:59:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BIohrFyb;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 980CE600AE;
	Fri,  1 May 2026 13:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A28EC2BCB4;
	Fri,  1 May 2026 13:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777643945;
	bh=pyGGj8CgYj8YKM+1n+ffgeaGs4n29YMxEkBJUo1PKMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BIohrFybibBQ29JXyaKkk7tpR9SY33a1ULDEXYO0ggJZPVBGjV4kol4a3Oo5KcigC
	 vvl9rtpktZmkYOvK0ZanKn5pBn6I40+FNXlG6+Q0fDXt4fhrSahOTWeDeIRNvDgAnr
	 qDfcMkpOLtgmvARVrNbe0mo8GqgtIXcSiA9pijs0QRaex7NWmA3+rEhaS4Lf7PSUmf
	 l21wV01YBfLy+sLbcNH30NUp0eRR29R3odnhq/LXGzgCEJ5UkDgZxxIFufJWtzHLv8
	 9lpiqvzMaJU41PHE5LzQZ5BOt4WzIJJADN2rcjfT6oC6zaFI9Mexu3hhwSvCsrIBBx
	 Wbtz6RzKcrZGA==
Date: Fri, 1 May 2026 19:28:48 +0530
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: Re: [PATCH v4 06/15] remoteproc: qcom_q6v5_mss: Switch to generic
 PAS TZ APIs
Message-ID: <afSxmNWWgvPkcMXT@sumit-xelite>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-7-sumit.garg@kernel.org>
 <20260429133157.lopr6n5vaik36466@hu-mojha-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429133157.lopr6n5vaik36466@hu-mojha-hyd.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 26E61436CA
X-Spamd-Bar: -
Message-ID-Hash: BUK3Z2YXVOWU4GSE3ZBIXCWTKAVERQB5
X-Message-ID-Hash: BUK3Z2YXVOWU4GSE3ZBIXCWTKAVERQB5
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanat
 han@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BUK3Z2YXVOWU4GSE3ZBIXCWTKAVERQB5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Wed, Apr 29, 2026 at 07:01:57PM +0530, Mukesh Ojha wrote:
> On Mon, Apr 27, 2026 at 03:25:54PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Switch qcom_q6v5_mss client driver over to generic PAS TZ APIs. Generic PAS
> > TZ service allows to support multiple TZ implementation backends like QTEE
> > based SCM PAS service, OP-TEE based PAS service and any further future TZ
> > backend service.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/remoteproc/qcom_q6v5_mss.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> > index ae78f5c7c1b6..96888007faa8 100644
> > --- a/drivers/remoteproc/qcom_q6v5_mss.c
> > +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> > @@ -34,6 +34,7 @@
> >  #include "qcom_pil_info.h"
> >  #include "qcom_q6v5.h"
> >  
> > +#include <linux/firmware/qcom/qcom_pas.h>
> >  #include <linux/firmware/qcom/qcom_scm.h>
> 
> same here., whether it is needed now ?

Ditto, needed for qcom_scm_assign_mem().

> 
> >  
> >  #define MPSS_CRASH_REASON_SMEM		421
> > @@ -1480,7 +1481,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
> >  	}
> >  
> >  	if (qproc->need_pas_mem_setup) {
> > -		ret = qcom_scm_pas_mem_setup(MPSS_PAS_ID, qproc->mpss_phys, qproc->mpss_size);
> > +		ret = qcom_pas_mem_setup(MPSS_PAS_ID, qproc->mpss_phys, qproc->mpss_size);
> >  		if (ret) {
> >  			dev_err(qproc->dev,
> >  				"setting up mpss memory failed: %d\n", ret);
> > @@ -2077,7 +2078,7 @@ static int q6v5_probe(struct platform_device *pdev)
> >  	if (!desc)
> >  		return -EINVAL;
> >  
> > -	if (desc->need_mem_protection && !qcom_scm_is_available())
> > +	if (desc->need_mem_protection && !qcom_pas_is_available())
> >  		return -EPROBE_DEFER;
> >  
> >  	mba_image = desc->hexagon_mba_image;
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Thanks.

-Sumit
