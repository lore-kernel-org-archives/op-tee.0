Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFACEF4ECD
	for <op-tee@archiver.kernel.org>; Mon,  6 Apr 2026 11:43:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 46F6443A76
	for <op-tee@archiver.kernel.org>; Mon,  6 Apr 2026 11:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1775475787;
	bh=FGRHUXyR+0IYeCGEAzCaangJ4UIXGFGgJFbwE4z892Y=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=DmRdns/sQ7cAWtUITKZFH0gPCsO/OdIn7RFvFEPQUxf0L7WR/khKOtMwezQRp29oX
	 PdG4wKrGp+46H4IeAZ8Bxy5FY4PN5I1B9iQfAHqDR2+Hak8rrz/F7CSdmw7uAb6iub
	 4fhgmzO+7+tOiIAkfaD6zScyskk36LY5Hmz18QRG9ol/5MR7bjSxCmwH9etZ4fj28y
	 t9h+ZKS/gb8frRwQQNky48Phx7SEnmuGsLdUhCJXauk15n5cj8Yqm2hzZbWQyMYhye
	 K/bGn0OFToFwTux8kOFJ3kJfLl99f0pXplgdgPfwAILgw184rQKGK+nLDPjnAIq39t
	 SbNhzizSqPEuQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BA70943A61
	for <op-tee@lists.trustedfirmware.org>; Mon,  6 Apr 2026 11:43:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uEwkjpkg;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D1A8C600AC;
	Mon,  6 Apr 2026 11:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716F7C4CEF7;
	Mon,  6 Apr 2026 11:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775475779;
	bh=FGRHUXyR+0IYeCGEAzCaangJ4UIXGFGgJFbwE4z892Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uEwkjpkgZJJUgzLAMipZqb7S3m6PFvmEe1MRqsi12pNbrWPbTPr+/ozV0WB4e3kwc
	 wUFFUuEvlco8X0oM3WIbq9yPqBJEUoDRTdYVLYUFB2rLHKjh8gNzdqJKD/ZZA+/iG9
	 1xttCsrneXaxcIrBL9n1jqQndgGGSU6R9UiOuHMqxrC6g8cjPDhBpYAasm+A5RKcHR
	 nV9r4Cclk4K062pas6X6TeGAxUgQ9hdOz1Jzos5uBp1OPKQb3IZujuUKw/GO3+cLck
	 va/Idz0NKezYCEsD/GzpcK2QssI9WrYqRPMFymOo9jE/73sGxbCzQuYHAdNKM1hmip
	 dP8d3gB/fbK0A==
Date: Mon, 6 Apr 2026 17:12:42 +0530
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
	vikash.garodia@oss.qualcomm.com
Subject: Re: [PATCH v3 11/15] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <adOcMsk8a_Clb4WZ@sumit-xelite>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <20260327131043.627120-12-sumit.garg@kernel.org>
 <ac-KQ7e8-syph1Zl@trex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac-KQ7e8-syph1Zl@trex>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_TLS_LAST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TAGGED_RCPT(0.00)[dt,netdev];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BA70943A61
X-Spamd-Bar: --
Message-ID-Hash: B7MO7MQS5C2F3ZDS6ZOBD4HO4VTL3PQR
X-Message-ID-Hash: B7MO7MQS5C2F3ZDS6ZOBD4HO4VTL3PQR
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kand
 agatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/B7MO7MQS5C2F3ZDS6ZOBD4HO4VTL3PQR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

Hi Jorge,

On Fri, Apr 03, 2026 at 11:37:07AM +0200, Jorge Ramirez wrote:
> On 27/03/26 18:40:39, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> > TZ service allows to support multiple TZ implementation backends like QTEE
> > based SCM PAS service, OP-TEE based PAS service and any further future TZ
> > backend service.
> 
> OP-TEE based PAS service relies on the linux driver to configure the
> iommu (just as it is done on the no_tz case). This generic patch does
> not cover that requirement.

That's exactly the reason why the kodiak EL2 dtso disables venus by
default in patch #1 due to missing IOMMU configuration.

> 
> Because of that, it is probably better if the commit message doesnt
> mention OP-TEE and instead maybe indicate that PAS wll support TEEs that
> implement the same restrictions that QTEE (ie, iommu configuration).

The scope for this patch is to just adopt the generic PAS layer without
affecting the client functionality.

> 
> I can send an RFC for OP-TEE support based on the integration work being
> carried out here [1]

@Vikash may know better details about support for IOMMU configuration
for venus since it's a generic functionality missing when Linux runs in
EL2 whether it's with QTEE or OP-TEE.

However, feel free to propose your work to initiate discussions again.

> 
> [1] https://github.com/OP-TEE/optee_os/pull/7721#discussion_r3016923507

-Sumit
