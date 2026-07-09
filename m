Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA118C43458
	for <op-tee@archiver.kernel.org>; Thu,  9 Jul 2026 19:32:55 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0C4834152C
	for <op-tee@archiver.kernel.org>; Thu,  9 Jul 2026 19:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1783625575;
	bh=lBVcNbE3SdloI5j4P8VPbIu6NmrvZndG9ZjUXvjaqfU=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=5UEnR+B+o6Z74tc0MpxHCZLgCa9SyN+yei18D75QjzpB918uttRccgz0nGO6saR69
	 4c4zjB7qJqDYJLDpewXsNQe8Sa8SZlQHEUmjZD3C1+q/LMCYunNBtkO5rNHZXsZhhA
	 GOHFqFLHCNjjudL0bihC1yoissMh1CPgKcom/pLxmGAQa/n/MmNF5TnxjkFy8tPial
	 sEROHiqOotdSL602lC0ZH1ofr4b0RfaXem2v27/ELpSkw/QggGWwUtm/w+ZSrnroOZ
	 JZvs4byU3STLVovBD0Xyxwcd56WvXFBd47HjXPQylJIkpjrGhHHoiCb3TFyifvlcQm
	 B3a0RELbDfVBQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EBD3440AD0
	for <op-tee@lists.trustedfirmware.org>; Thu,  9 Jul 2026 19:32:48 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=auzMKv1K;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 640C4600C3;
	Thu,  9 Jul 2026 19:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244A21F000E9;
	Thu,  9 Jul 2026 19:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783625568;
	bh=kAnk8wurZx5c5OpGGojggK9/9lXOvy6JHQHST6N14hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=auzMKv1KlscxwXNmEZXTOFba3AzC1zvV5+KdLqK0W5IDP55KMnvUDomWlmIqurbJq
	 KvnBdQZTeHn6OnilAVzhRDXElp2+lyOAqSt8AzaPojSa6/oownhsZAeRZ66qSpL/oZ
	 QPffV5w4Rg1Ou9qpCF7MsXqreDvfczmOByHdhc/WAsKhMv9fb0+4/LyVRMjvolSXnM
	 gyP9Q5qvjQcq8TuiOCwfjhGGvo1RbIJw+Ef2lv9z7fc6OWQJoR7zsX7App24WvM+x2
	 0Sx8wwnFRJlrbavFkDmXz0Sm0yUuWQncw1ncAwrPth0JOYmqq7jEyRTmUKtvOrGDpc
	 uBdy+bMWI8DJw==
To: konradybcio@kernel.org,
	Sumit Garg <sumit.garg@kernel.org>
Subject: Re: (subset) [PATCH v9 00/14] firmware: qcom: Add OP-TEE PAS service support
Date: Thu,  9 Jul 2026 14:32:39 -0500
Message-ID: <178362521364.2422497.1305957434056184382.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702115835.167602-1-sumit.garg@kernel.org>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.50 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.98%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCPT_COUNT_TWELVE(0.00)[48];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EBD3440AD0
X-Spamd-Bar: -------
Message-ID-Hash: TURZKN6LKUIR4GVTH4CNJV2AOO5FR7I4
X-Message-ID-Hash: TURZKN6LKUIR4GVTH4CNJV2AOO5FR7I4
X-MailFrom: andersson@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualc
 omm.com, amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TURZKN6LKUIR4GVTH4CNJV2AOO5FR7I4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Bjorn Andersson via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Bjorn Andersson <andersson@kernel.org>


On Thu, 02 Jul 2026 17:28:16 +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Qcom platforms has the legacy of using non-standard SCM calls
> splintered over the various kernel drivers. These SCM calls aren't
> compliant with the standard SMC calling conventions which is a
> prerequisite to enable migration to the FF-A specifications from Arm.
> 
> [...]

Applied, thanks!

[01/14] firmware: qcom: Add a generic PAS service
        commit: 08314e7c2c38b9ae6a5e01c58ed10a950859404d
[02/14] firmware: qcom_scm: Migrate to generic PAS service
        commit: 5c1a2975d23c51c01aca51945d0f10a4ee4c9020
[03/14] firmware: qcom: Add a PAS TEE service
        commit: b6f7978da0c4d26fe465aa6634f5a0b48f900de0
[14/14] MAINTAINERS: Add maintainer entry for Qualcomm PAS TZ service
        commit: 6701259025d49139131a0eb2257659a066dcca22

This is available as an immutable branch, for other subsystems to pull at:
  https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git 20260702115835.167602-2-sumit.garg@kernel.org


[04/14] remoteproc: qcom_q6v5_pas: Switch over to generic PAS TZ APIs
        commit: 254030af0d81b12b7624d9ce85c6bdd3171629c6
[05/14] remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs
        commit: f3b1357673ddb37ae8b9a8fe44df73cbd2a519c5
[06/14] remoteproc: qcom_wcnss: Switch to generic PAS TZ APIs
        commit: ea3b5245f5deba916320b32a8e6510a74c034c17
[07/14] remoteproc: qcom: Select QCOM_PAS generic service
        commit: c4383254ac7a529736577e304176a10371c2ee0b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
