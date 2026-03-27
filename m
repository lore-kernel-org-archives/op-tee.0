Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E73010ED65C
	for <op-tee@archiver.kernel.org>; Fri, 27 Mar 2026 12:19:18 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A7BC74444F
	for <op-tee@archiver.kernel.org>; Fri, 27 Mar 2026 12:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1774613957;
	bh=WdmmxLC4uZUaxNYg07u+R61NqLzB+09CSA+9gpv6wjo=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=DlhJ/UpQvZTxM2TgwhSaJOmFGuRBhHV48D42fnNy3eEcoF4zh0jLGdZbzMMrHksB3
	 I5ad5vU9pDPkBDJRwxB4FWpSuEa7bGdFa07s1SGgKCKksBYmzDvc094Rczl3r93AUI
	 a9jdfXR82ebKBWndvGgGQE/4/Xgby4RMaB+3MhWyJb742HkTicdTN6fikrDAkn7OGJ
	 A3ix5rjC8CPRWsRKPRpE0/UY+thZhRtTiDJz1FpWimxxKKUbLQqTVwVEfRPkQf6UYu
	 njgnso/LiNmZYRVBRgOQbS8ijVi8RntwjU7vyZ4eT7T1TrvJzPpfX8sGwBGpkP1Pcy
	 rrv6rk3e9HvUg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0B0803E936
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Mar 2026 12:19:11 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kA5KYHyR;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6B4A740107;
	Fri, 27 Mar 2026 12:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BE0C19423;
	Fri, 27 Mar 2026 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774613950;
	bh=WdmmxLC4uZUaxNYg07u+R61NqLzB+09CSA+9gpv6wjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kA5KYHyR7h3Q8MfGqowvF8zh3gqZs2NKETp6VjzAQHFOxAoWEqN0DxyQgjKOs/s4j
	 qXoc++EGCuN+Jk+SBWCPkkRPeNWml7CZJMT/6nIXgPViu8Dnrf5Y0JvyDOyGoeqnbI
	 0H5VWYLLc8pldAYA4QYKHb8XZkd0dRadiA9mRFVYgx1cYMtKzVV+8iqrV7NgH528iQ
	 NLZxMIbfgUxSiLRf8oVPOV+33glZq4ueSjniXmTt5fgoBdhmEIK2PUTDmmUKysdutE
	 loM8mBn20nJPvqYo7NRuB1vdTTBJYMQIPAhOc/DLPCFcpNFcwr1vGOZ12458rn/B7m
	 QhOIXoObtExuw==
Date: Fri, 27 Mar 2026 17:48:52 +0530
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v2 03/15] firmware: qcom_scm: Migrate to generic PAS
 service
Message-ID: <acZ1rDB5-koq8UqF@sumit-xelite>
References: <20260312062756.694390-1-sumit.garg@kernel.org>
 <20260312062756.694390-4-sumit.garg@kernel.org>
 <bc7b116d-de41-4b9a-9c84-1010e226bac8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc7b116d-de41-4b9a-9c84-1010e226bac8@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0B0803E936
X-Spamd-Bar: --
Message-ID-Hash: 3WICTRJQOL7GWQ76E3ZQKHLJGVBE76YP
X-Message-ID-Hash: 3WICTRJQOL7GWQ76E3ZQKHLJGVBE76YP
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.
 qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3WICTRJQOL7GWQ76E3ZQKHLJGVBE76YP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Fri, Mar 27, 2026 at 05:40:16PM +0530, Harshal Dev wrote:
> 
> 
> On 3/12/2026 11:57 AM, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > With the availability of generic PAS service, let's add SCM calls as
> > a backend to keep supporting legacy QTEE interfaces. The exported
> > qcom_scm* wrappers will get dropped once all the client drivers get
> > migrated as part of future patches.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/firmware/qcom/Kconfig    |   1 +
> >  drivers/firmware/qcom/qcom_scm.c | 336 ++++++++++++++-----------------
> >  2 files changed, 156 insertions(+), 181 deletions(-)
> >
> 
> [..]
> 
> > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > index 8fbc96693a55..2d7937ae7c8f 100644
> > --- a/drivers/firmware/qcom/qcom_scm.c
> > +++ b/drivers/firmware/qcom/qcom_scm.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/dma-mapping.h>
> 
> [..]
> 
> >  
> > -/**
> > - * devm_qcom_scm_pas_context_alloc() - Allocate peripheral authentication service
> > - *				       context for a given peripheral
> > - *
> > - * PAS context is device-resource managed, so the caller does not need
> > - * to worry about freeing the context memory.
> > - *
> > - * @dev:	  PAS firmware device
> > - * @pas_id:	  peripheral authentication service id
> > - * @mem_phys:	  Subsystem reserve memory start address
> > - * @mem_size:	  Subsystem reserve memory size
> > - *
> > - * Returns: The new PAS context, or ERR_PTR() on failure.
> > - */
> 
> Shouldn't we drop the documentation for the exported functions in this file as part of
> patch 14/15? After this patch is applied, the devm_qcom_scm_pas_context_alloc() function
> still remains exported and available.

I don't see value in maintaining redundant documentation during the
course of the patch-set. The wrappers are only maintained to keep the
individual commits compilable such that we don't break kernel git
bisection scripts.

-Sumit
