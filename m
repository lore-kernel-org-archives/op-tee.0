Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C069FD88FF
	for <op-tee@archiver.kernel.org>; Wed, 11 Mar 2026 05:48:10 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B2C0E43953
	for <op-tee@archiver.kernel.org>; Wed, 11 Mar 2026 05:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1773208089;
	bh=vtEXOBuhUMjTZiyrtnPZqy/gdjvwakJ6MHrQOKgG2i8=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=vfDM1DZ9WdYHSgyQJV01TMNRpIsgVxmkNk0YGTbUSvAxMB6UXhYTW+wy88iEQefCI
	 +W5+AzJQ0BgUk3w5ZKqQ8n9jyk9wUn+fbCePpRclIBDt7RAk9sIzKu7qGdldXoH76p
	 rVjlz0jASgAbggF5W+GbgUPuDK/gRhH7ZgkLa7ZNAJotmL4FEv4Gkh+e3ZeKrcgJV4
	 D+ZSpsb664B9fE7leq6z62VhWgPk3P7O9lzyC7saE6dxxa516+a5vxbnsZmGSn4XmF
	 TwuYS5cBJ5+4bDBgup3gQcU/EsUSq5WZw18NCe+7J/GdlOWnx9/QYjb1amp24n6r4U
	 9n8JE5Q7KAY2w==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 32D03430AD
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Mar 2026 05:47:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eeACOq6z;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 645AE41757;
	Wed, 11 Mar 2026 05:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0823FC4CEF7;
	Wed, 11 Mar 2026 05:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773208070;
	bh=vtEXOBuhUMjTZiyrtnPZqy/gdjvwakJ6MHrQOKgG2i8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eeACOq6zvoHImfK89PKpnKoKhq+cOkbQunVao4m97OtiMRTKtqFh5GxPIPgTjIpgy
	 rnEXWEaYqXoVPz5ELjFYeO/OHfGGLDfvzbsGPzhxhIrkh68hW1CJRR4AMqK4s5A/36
	 ld6d79lXYRX/UiVqfoGxjiJVtOw0GGYKcTa1YqzSjiSiJyZy/VAFq8tCU6CqG2b/NJ
	 SZNPygMIjEB2PBNtAIG1KJvpM2Btaw4YdDzp40appRQ5TQ/cLfng+o6eD2SfNbyA4Z
	 Rq3gIQ30dMyREadAFPWCHwvu/KXM6SPAK0Tl7Sju6ZCSdtME89zS08zVLG6HUh3nuc
	 aib8sP4ePsXng==
Date: Wed, 11 Mar 2026 11:17:32 +0530
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 11/14] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <abEB9DiHs6JLVRnp@sumit-xelite>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-12-sumit.garg@kernel.org>
 <aa6O5tir4kVIe0eZ@trex>
 <a96cca02-54e4-4ed0-9fcb-816c72afe0e7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a96cca02-54e4-4ed0-9fcb-816c72afe0e7@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.95 / 15.00];
	BAYES_HAM(-2.95)[99.80%];
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
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 32D03430AD
X-Spamd-Bar: --
Message-ID-Hash: RYUSAG4SNEB6UK5SP7GGBDOGKTJ6VOE3
X-Message-ID-Hash: RYUSAG4SNEB6UK5SP7GGBDOGKTJ6VOE3
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm
 .com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RYUSAG4SNEB6UK5SP7GGBDOGKTJ6VOE3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Tue, Mar 10, 2026 at 12:18:29PM +0100, Konrad Dybcio wrote:
> On 3/9/26 10:12 AM, Jorge Ramirez wrote:
> > On 06/03/26 16:20:24, Sumit Garg wrote:
> >> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> >>
> >> Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> >> TZ service allows to support multiple TZ implementation backends like QTEE
> >> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> >> backend service.
> >>
> >> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> >> ---
> 
> [...]
> 
> > are the calls to set_remote_state required?
> > 0 is not the IRIS/VENUS remote processor.
> > 
> > If it is legacy, maybe they can be phased out?
> 
> FWIW, in msm-3.10 (yes) QCOM_SCM_SVC_BOOT/0x0a used to be called
> 'TZBSP_VIDEO_SET_STATE', taking the arguments:
> 
> args[0] = suspend->0, resume->1
> args[1] = spare=0
> 
> seems like sdm845/msm-4.9 still had that and so did 8250/msm-4.19

I would assume passing actual PAS ID in that spare argument shouldn't
cause any issues for QTEE as it could just ignore that. Let me try to
see in my testing on RB3Gen2 if it causes any ABI issues. Since with
OP-TEE we would like to not deal with ABI inconsistencies.

-Sumit
