Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55075CD3436
	for <op-tee@archiver.kernel.org>; Wed,  6 May 2026 11:45:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 660F444DE0
	for <op-tee@archiver.kernel.org>; Wed,  6 May 2026 11:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1778067915;
	bh=hhTrGP4S/BXwCHAiPhtKUBT3aM5H12HQDgaM3WyB8SM=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=nWQGaP+o8LO0ZcYnoXt5x1emceH+0ibtAtbFvLvTt8PmBh/4emAR3rEFakDoK9Vx+
	 V035t0KKQbudcnfuLZrKPnx7uYiqDwyLF5dhzER55cvMRzlgj8yIlQgoAa1KqQnwRl
	 LGBrRRMwRO1capw+YdEpGEReubNvB8RDNHfWbZeojvS7R62Mzunx7LyoYemmrK2EtX
	 3spnUD3wZP8fmweJ6rN++/eCONLMQvC9cPDRl4G8xLtyRRIo27nKP1tHV68XftutGi
	 jdsaLudi0gY72XUxm4Ah09G45KdlabMmX8qevns2Q3qNlBxiSpZCIDgfg3WMeoWFYH
	 OL01BsjeG8JLw==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 926FD43710
	for <op-tee@lists.trustedfirmware.org>; Wed,  6 May 2026 11:45:08 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JK9Rzoig;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D3D9341ABC;
	Wed,  6 May 2026 11:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E248C2BCB8;
	Wed,  6 May 2026 11:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778067907;
	bh=hhTrGP4S/BXwCHAiPhtKUBT3aM5H12HQDgaM3WyB8SM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JK9RzoigiB1D3DXGs/HNMPpy5luVXNjQDMJ/gNJwQwvD3QX5cwaaDXLByrbYh0rD7
	 unldqglV7SpdVuXWY+NgLy2tFLcj1HLkdrYiuAfhotSgVMFmyVebpugEr32x4ihMc0
	 /tOg24M8MPx0qFmabWfnU+kelwaO+lTgzJKEa2z6qkJ7YGiJg6aNwzN4jGpgCTc8oc
	 NVhfIHljXCC/NcCUwAOnt7rBjjzZnbCv+41BW+iXoF7z+oYkX7+01Kuy8XgtzhiqEs
	 2wR7jxsdr6NctbnKkN145c3AfMYB1T4A8mwdhnVOx2bukV3wZrjpRg2SdK/mGdfwkf
	 QLBVpImLnNOrQ==
Date: Wed, 6 May 2026 17:14:50 +0530
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v5 14/16] wifi: ath12k: Switch to generic PAS TZ APIs
Message-ID: <afspsrA8zT8Fb4z-@sumit-xelite>
References: <20260504130603.1474043-1-sumit.garg@kernel.org>
 <20260504130603.1474043-15-sumit.garg@kernel.org>
 <3bfdc11c-115f-45ab-b0ab-75ad88dc6f31@oss.qualcomm.com>
 <ae68bdb3-d683-4e7a-a27f-739214656ce2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae68bdb3-d683-4e7a-a27f-739214656ce2@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[99.98%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_TLS_LAST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[51];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 926FD43710
X-Spamd-Bar: --
Message-ID-Hash: CPN5DHB6ZL6SI26GZ7JLT3I7HA3XVZMK
X-Message-ID-Hash: CPN5DHB6ZL6SI26GZ7JLT3I7HA3XVZMK
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, Sowmiya Sree Elavalagan <sowmiya.elavalagan@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.konde
 ti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CPN5DHB6ZL6SI26GZ7JLT3I7HA3XVZMK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Tue, May 05, 2026 at 07:50:03AM -0700, Jeff Johnson wrote:
> On 5/5/2026 7:27 AM, Jeff Johnson wrote:
> > On 5/4/2026 6:06 AM, Sumit Garg wrote:
> >> @@ -485,9 +485,9 @@ static void ath12k_ahb_power_down(struct ath12k_base *ab, bool is_suspend)
> >>  		pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
> >>  			 ATH12K_AHB_UPD_SWID;
> >>  		/* Release the firmware */
> >> -		ret = qcom_scm_pas_shutdown(pasid);
> >> +		ret = qcom_pas_shutdown(pasid);
> >>  		if (ret)
> >> -			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
> >> +			ath12k_err(ab, "pas shutdown failed for userPD%d: %d\n",
> >>  				   ab_ahb->userpd_id);
> > 
> > at some point the "ret" param was dropped, and this now generates build warnings
> The 'ret' param was dropped by:
> 8fb66931fe31 ("wifi: ath12k: Enable IPQ5424 WiFi device support")
> 
> Not sure if that was on purpose or accidental. Sowmiya?
> 
> -       if (ret)
> -               ath12k_err(ab, "scm pas shutdown failed for userPD%d: %d\n",
> -                          ab_ahb->userpd_id, ret);
> ...
> +               if (ret)
> +                       ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
> +                                  ab_ahb->userpd_id);
>

Ah I see, not sure why I didn't see any build issues in the defconfig
builds. Maybe this driver isn't enabled there?

Anyhow I can add the "ret" back here.

-Sumit
