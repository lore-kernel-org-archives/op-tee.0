Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB486C43327
	for <op-tee@archiver.kernel.org>; Wed,  1 Jul 2026 07:45:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E6C8E44A28
	for <op-tee@archiver.kernel.org>; Wed,  1 Jul 2026 07:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782891905;
	bh=tDiFDbQae5B+AcU3uHwKS49XcuNSVuhzvPI0NJcCUBw=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=hFQhxaVV9rawonOwKcXlJuxwTyFTIaM9JTkXh0OqtPQbO2QwpwHUmh2SzUugSkJRA
	 4d3bLbKtgnrTHkTpmJezK9i8duprkSP4Nlr14/cbFMcG9riojYPf/cZJ2MDlZ5Jmk4
	 YhEokft9SvESCNWGokjkiKP30KT5DbQTcIpwfX0rY8/I76OofkVhDk89UrPN8Q6BY+
	 pY5BCWRqFSBk9O+uKzJzRrWIdhhOBoVWSRZJUCIvpqExow/JIHNtzK2NEQwroZwcl9
	 aSbcaf+lunZgtzF7zH/T28Svj7Nu1nN+P0Fd6WilTRwWn/nv4isUW/UbomWOVaFQzs
	 eh2+NsG9aXezg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7E9D644A28
	for <op-tee@lists.trustedfirmware.org>; Wed,  1 Jul 2026 07:44:57 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dD+FtfSd;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D76BD438F6;
	Wed,  1 Jul 2026 07:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5CD1F000E9;
	Wed,  1 Jul 2026 07:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782891896;
	bh=ozLRk5I8ZKe5jB7VBK0AxnV4gzUhCLP0jS540MNnO9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dD+FtfSd5ABFPT3H7OfKYHQf1GhlF3Yo9yrHYAAXziAe/Fsg7c/odLOXZtLTqVQCe
	 D/pDweTD81vwaMb8rKmT+FrAGjs+FpSOnXpPdkb99/rhqJIB1vO/QmniEvWdB7oXDn
	 DZzE69+CG5ADgir5cNGGOsF7YxupkO6eRgUvcwWPKLgQveI5ufw+JD6KYNUPCKthhr
	 mlenbMWEKT2oATLz7eAgfqNzIe3jnK+B2mYUrmUbTfTh+4JbVYANXZMbVlCom12Yn9
	 MzJtJwFhD9G/dQgElq/K4ovkn+kFfs8nocf3PN4BiO0Df9ixYLI4M9HZ52nGxvyKX2
	 EAUHpr8LFM4QA==
Date: Wed, 1 Jul 2026 13:14:38 +0530
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v8 10/14] media: qcom: Pass proper PAS ID to
 set_remote_state API
Message-ID: <akTFZgKBQYQUYxx4@sumit-xelite>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-11-sumit.garg@kernel.org>
 <c251430d-2184-4ecc-8d05-9cb47533e5ec@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c251430d-2184-4ecc-8d05-9cb47533e5ec@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7E9D644A28
X-Spamd-Bar: ------
Message-ID-Hash: 4ZSFYF3AMZ47EGZHAE6BGLITK45A6AEJ
X-Message-ID-Hash: 4ZSFYF3AMZ47EGZHAE6BGLITK45A6AEJ
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.ka
 ndagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4ZSFYF3AMZ47EGZHAE6BGLITK45A6AEJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Tue, Jun 30, 2026 at 02:42:25PM +0200, Konrad Dybcio wrote:
> On 6/26/26 3:34 PM, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > As per testing the SCM backend just ignores it while OP-TEE makes
> > use of it to for proper book keeping purpose.
> > 
> > Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> > Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/media/platform/qcom/iris/iris_firmware.c | 2 +-
> >  drivers/media/platform/qcom/venus/firmware.c     | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> > index ea9654dd679e..d2e7ba4f37e3 100644
> > --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> > +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> > @@ -110,5 +110,5 @@ int iris_fw_unload(struct iris_core *core)
> >  
> >  int iris_set_hw_state(struct iris_core *core, bool resume)
> >  {
> > -	return qcom_pas_set_remote_state(resume, 0);
> > +	return qcom_pas_set_remote_state(resume, IRIS_PAS_ID);
> >  }
> > diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> > index 3a38ff985822..3c0727ea137d 100644
> > --- a/drivers/media/platform/qcom/venus/firmware.c
> > +++ b/drivers/media/platform/qcom/venus/firmware.c
> > @@ -59,7 +59,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
> >  	int ret;
> >  
> >  	if (core->use_tz) {
> > -		ret = qcom_pas_set_remote_state(resume, 0);
> > +		ret = qcom_pas_set_remote_state(resume, VENUS_PAS_ID);
> 
> This should not be in the middle of a mildly related series..
> The PAS IDs should be centralized into a single header. And the
> name of the driver shouldn't be part of the define. I would guesstimate
> that on the secure side it's probably called VPU or VIDEO

I agree with your comments, this is something I would also like to
consolidate on OP-TEE side as well: see discussion here [1].

However, the patch itself was needed to do book keeping on OP-TEE side
but I can drop it since anyhow the video isn't functional yet in
upstream dependent on the proper IOMMU support.

[1] https://github.com/OP-TEE/optee_os/pull/7845#discussion_r3434507317

-Sumit
