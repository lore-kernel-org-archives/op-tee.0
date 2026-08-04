Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8596C55822
	for <op-tee@archiver.kernel.org>; Tue,  4 Aug 2026 22:31:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C85C1450DA
	for <op-tee@archiver.kernel.org>; Tue,  4 Aug 2026 22:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1785882693;
	bh=mG1SLwAJIubIVjXdTFNOBu8EzWB7e3//i6VKXIlyBlc=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Q+QzhJTKg/EWMeCZHmPxL+E1/7xSfb0pz5RKuQNcArOrpgcADb3O5jP2PpKniSV98
	 2fcXGs3zjDFYNGDmXe9aASoNdd/iE3zeOn4vKRRK7fma48KPLPV5Tz8j1+GV+zf40j
	 xx3IMq6ayyIN8t1XYYJl8QEiWIiNOA2ZOhIYAXSg7Q9caX4jpujZiPRPE68ehv5tNH
	 ptuNCn55lMKIBsNfXn8cyhwK1mDWiFKC2cnjUV6As90cS7+/AQzKyG+7ZqMGaHGzYg
	 /BD0dDE83zasBpkCtpStPeZNtLRoJvAdA8RTK71zJ6pw44tczSZNFur/12WLxidMW2
	 zM+YVNiQPwgSg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 763C1450AE
	for <op-tee@lists.trustedfirmware.org>; Tue,  4 Aug 2026 22:31:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSdW48Lc;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8399243F42;
	Tue,  4 Aug 2026 22:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C731F00A3D;
	Tue,  4 Aug 2026 22:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785882685;
	bh=1rNKgpIx6sZKzmYQ6FweqLBwIUVjPux1He9OuvdAw/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VSdW48Lc4jRQjSvOYK6+1RkSCe23ufhDsOsXhNt4Ddw8D/YQHxmW320dvP2P7ORz+
	 Nzz4hCaj/lJheSxjNhu3iK8vKtbjkdRaSYOp9A3xKfMCmjo1wFCtcIoxttJJ7CHyTW
	 6FMLdwzCEAHkqLj2FEznUUNVP76O0jKtDVItxv3ED11ABBaD/MjbZTwf7dKQLMYfYP
	 dEaRKsKWQs/SpA7P9pNqP15pttyCi9lzKbUd8DJdKNkfS4l3ybZmwCkpxRabdDxoZc
	 l51MfSH06sfXgb8HFBXSqbR2LPPJEGwI4O/DC9mCeNnBGbOkIY2Ycs3abL1ZRO0ZNw
	 8giP29bCtxPug==
To: konradybcio@kernel.org,
	Sumit Garg <sumit.garg@kernel.org>
Subject: Re: (subset) [PATCH v9 00/14] firmware: qcom: Add OP-TEE PAS service support
Date: Tue,  4 Aug 2026 17:31:15 -0500
Message-ID: <178588267268.451855.11887423649046062153.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702115835.167602-1-sumit.garg@kernel.org>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.45 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-2.95)[99.77%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCPT_COUNT_TWELVE(0.00)[48];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 763C1450AE
X-Spamd-Bar: -------
Message-ID-Hash: TLP7J5MUDQLK7DSF7TEDNKORQKJKSE2L
X-Message-ID-Hash: TLP7J5MUDQLK7DSF7TEDNKORQKJKSE2L
X-MailFrom: andersson@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualc
 omm.com, amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TLP7J5MUDQLK7DSF7TEDNKORQKJKSE2L/>
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

[09/14] media: qcom: Switch to generic PAS TZ APIs
        commit: 94d3305d990b055e1561e3b78275344b1f40c86e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
