Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5283F8FA6A
	for <op-tee@archiver.kernel.org>; Tue, 21 Apr 2026 12:43:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3E79C44DC3
	for <op-tee@archiver.kernel.org>; Tue, 21 Apr 2026 12:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1776775423;
	bh=+V8ZfRYrjzwJXgqe+fTwt5G7FKr8RN3Pd3uuU7wkOoo=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Q7ytLnbpQxtEF8AdwhpmxhR+A6JT/ziSnCGSlXWz85jAbdQVOdO4rpYzqwt476ady
	 HAjEw/fUCEqzPwQGXwCgFncSWdX4kMLnnI3Zp6WHMWJKfoPDCtl2QNLUgnvCeFE1ei
	 dEmUWie112rlsLq1LmGBl5iqegRFPmaDlW7d6LLM+NPl5n+1FnTxzyDOF+xUK1QDyX
	 cFSeMNFP3JiRZINOfwjRY6PAS5YrxL8ip09rlCeTlQ35DX/wUZOcA+SceESMpx0+AV
	 ygWM2YOm/8QKILOzam8aJUHmpf1C6UvW3PiTuAiAsG0u8Dqsb+V/uEnEgZEZiu3M1D
	 MSN+30t4jfcww==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 104E444935
	for <op-tee@lists.trustedfirmware.org>; Tue, 21 Apr 2026 12:43:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aKaBnixD;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 40B8960121;
	Tue, 21 Apr 2026 12:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4193C2BCB0;
	Tue, 21 Apr 2026 12:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776775416;
	bh=+V8ZfRYrjzwJXgqe+fTwt5G7FKr8RN3Pd3uuU7wkOoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aKaBnixDB559hSNI2VTzNUIPYmrAI6E00jRbjPrOokUf/IxdtI+SshEpQoAyenhw8
	 76rWm2uvZ8+hauZIvZZX6A7nFC0SxJ6kMrA9ulppvSD3C+FJ/CzVar45/8h/DB2zcv
	 YGLim2xCtfRLj1iQMqdaLuz8sX6dE1TTVXRbPe3a1uXohDZKA/UZJ6tPd6x5Wi16eZ
	 T0URH9Vv45mpbG6NaRuAGhxQYk5PnNi6nxmwsm5JkQwEWynXiz5ODq1PfIo++vls3p
	 MtaICJCnPo6Zj/5EBQN8gEOGsJsJFR+lVLiJOVhWYo/K5b9K+gK/6TjrA0rrben6Ud
	 sTHdoBBwGyulA==
Date: Tue, 21 Apr 2026 18:13:17 +0530
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Subject: Re: [PATCH v3 11/15] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <aedw5VUJvwVkYfF5@sumit-xelite>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <20260327131043.627120-12-sumit.garg@kernel.org>
 <ac-KQ7e8-syph1Zl@trex>
 <adOcMsk8a_Clb4WZ@sumit-xelite>
 <439f9bbf-1ba1-465f-b5af-01ba0ebb86d4@oss.qualcomm.com>
 <adYElwM6eT5T8hZM@trex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adYElwM6eT5T8hZM@trex>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	TAGGED_RCPT(0.00)[dt,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 104E444935
X-Spamd-Bar: --
Message-ID-Hash: OJ2OYA3GY5ESD4QPTLUBUK52I7NPGKAU
X-Message-ID-Hash: OJ2OYA3GY5ESD4QPTLUBUK52I7NPGKAU
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>, vikash.garodia@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, tonyh@qti.qualcomm.com, vign
 esh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OJ2OYA3GY5ESD4QPTLUBUK52I7NPGKAU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Wed, Apr 08, 2026 at 09:32:39AM +0200, Jorge Ramirez wrote:
> On 07/04/26 15:14:22, Trilok Soni wrote:
> > On 4/6/2026 4:42 AM, Sumit Garg wrote:
> > > Hi Jorge,
> > > 
> > > On Fri, Apr 03, 2026 at 11:37:07AM +0200, Jorge Ramirez wrote:
> > >> On 27/03/26 18:40:39, Sumit Garg wrote:
> > >>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > >>>
> > >>> Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> > >>> TZ service allows to support multiple TZ implementation backends like QTEE
> > >>> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> > >>> backend service.
> > >>
> > >> OP-TEE based PAS service relies on the linux driver to configure the
> > >> iommu (just as it is done on the no_tz case). This generic patch does
> > >> not cover that requirement.
> > > 
> > > That's exactly the reason why the kodiak EL2 dtso disables venus by
> > > default in patch #1 due to missing IOMMU configuration.
> > > 
> > >>
> > >> Because of that, it is probably better if the commit message doesnt
> > >> mention OP-TEE and instead maybe indicate that PAS wll support TEEs that
> > >> implement the same restrictions that QTEE (ie, iommu configuration).
> > > 
> > > The scope for this patch is to just adopt the generic PAS layer without
> > > affecting the client functionality.
> 
> the patchset cover letter + the commit message + the OP-TEE pull request
> being referenced gives the ilusion to users that with the current set
> they will get something functional (they will get a broken video
> platform instead if they try to use OP-TEE).
> 
> That was the point I was making: IMO the commit message walks on a thin
> line of "completeness"
> 
> QTEE and OP-TEE at this time implement different use cases (Venus with
> QTEE runs with Linux on EL1 , OP-TEE runs with Linux on EL2). So maybe
> worth mentioning this divergence.
> 

Sure, I can extend the cover letter to say media support with Linux at
EL2 is missing for both OP-TEE and QTEE which is being worked on as a
separate effort related to missing IOMMU support.

-Sumit
