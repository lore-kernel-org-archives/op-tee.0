Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC24FB5190
	for <op-tee@archiver.kernel.org>; Tue,  7 Apr 2026 04:55:10 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A927043EB7
	for <op-tee@archiver.kernel.org>; Tue,  7 Apr 2026 04:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1775537709;
	bh=rvu7/o0Lwq7mvoGpGDMuVDAnB7mMlRjy9d5tc7U+Cb8=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=FIg9GShU8fLsEE+U4RfHug0LL8sdnLg/nPydnbBcVwCQrbQGXeir6BLwTb+gS8XSK
	 7cHKcGaoBIkBZlWVgRBwgymxm9uVYqHdoLJHV5XbnzaJuIVVo8NVWh6IYqSnUhdbrM
	 s2uk3c5RTweBNO5BJThcRpgoYbddHzqF6WKeZTYV5hkVSBXzyadmV7IKTcXXupT7k2
	 tiq1sCzYaIPmT6ZyCJ+YMba7FDKjrgqHQ1+KL+O6tvHk29wfTmVJI3a9FlMkyXqlag
	 WOlrnpMdQK1tSCHgGdTzzfx81FSwxtLXJv3WAskmqGk+MEfe6gCEtzBQ/oj1V5uNS8
	 47yDTf7lH297A==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7B27F41B79
	for <op-tee@lists.trustedfirmware.org>; Tue,  7 Apr 2026 04:55:03 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=og8fhcTr;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9D27460180;
	Tue,  7 Apr 2026 04:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60815C116C6;
	Tue,  7 Apr 2026 04:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775537702;
	bh=rvu7/o0Lwq7mvoGpGDMuVDAnB7mMlRjy9d5tc7U+Cb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=og8fhcTrcSW1XpExdd/a68mQ3sOlxr3SXLyjG8HBdY4XWYM29iTLx0Vs0oZzLQBYD
	 tu/RPZiAfSuTwJv5JHbdFaiitpZ6bXxgjdlLLxffWjK89/+jrNtXEyaJ4DJU/d0LCi
	 R6uKK10Vn0UY5G1a0lvKWQphTQ5vpl4v7DMcIZPNotI5UlcQAmshX1P/Wvpvltcgkl
	 vD400kR01f5mLCkLuTrZxTVTIz3eLkCsqiEBguYacQ0aKOGIUaWkZrKUIb0uWeIiYs
	 L/vTx3jbOsZk2PnifHxjEUKls3C4t+Wnbflcd+lJMRWwJLFmxogFFi7/Fue/xF+WPg
	 BLYdUjWFdKV2w==
Date: Tue, 7 Apr 2026 10:24:44 +0530
To: Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3 00/15] firmware: qcom: Add OP-TEE PAS service support
Message-ID: <adSOFCL26y5qt1Cu@sumit-xelite>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <adPLx3nCBb8IHz2b@baldur>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adPLx3nCBb8IHz2b@baldur>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7B27F41B79
X-Spamd-Bar: --
Message-ID-Hash: SWJ26U2BN5FSDFROHYVS5RDG25BMZK2S
X-Message-ID-Hash: SWJ26U2BN5FSDFROHYVS5RDG25BMZK2S
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.
 viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SWJ26U2BN5FSDFROHYVS5RDG25BMZK2S/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

Hi Bjorn,

On Mon, Apr 06, 2026 at 10:09:27AM -0500, Bjorn Andersson wrote:
> On Fri, Mar 27, 2026 at 06:40:28PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Qcom platforms has the legacy of using non-standard SCM calls
> > splintered over the various kernel drivers. These SCM calls aren't
> > compliant with the standard SMC calling conventions which is a
> > prerequisite to enable migration to the FF-A specifications from Arm.
> > 
> 
> Please get our colleagues involved in this discussion, because this
> non-SCM interface does not match the direction we are taking.

I thought I have already involved folks from QTEE perspective (Apurupa
and Sree) actively working on FF-A implementation aligned to this
interface. It would have been better if you could let me know where is
the direction mismatch here. In case there is a better alternative
design proposal for PAS service with FF-A, I would be happy to hear
that.

Anyhow for the legacy SoCs like KLMT, we really don't have any
alternative but have to stick to existing QTEE PAS design with OP-TEE
providing as an alternative backend. Surely we want to support loading
of existing signed firmware present in linux-firmware repo for KLMT with
OP-TEE being the TZ.

-Sumit
