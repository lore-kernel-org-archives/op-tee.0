Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665F4103E2E6
	for <op-tee@archiver.kernel.org>; Wed, 11 Mar 2026 20:57:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A5227438BF
	for <op-tee@archiver.kernel.org>; Wed, 11 Mar 2026 20:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1773262625;
	bh=lrM6SdSaCsClSZdw9o+efFHo76I/LXqdd19scY5HvmY=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=qK7R1txc4WhdSMGP/QpUptJsJE1sKVY/6n4e/0bEu0Axht7hEl/z9UwcRKbY5jx20
	 YpE3zi2uunZQ0YhrddQj/6A/gHyNdNjOus5/CGFgYGztAHG16vry+D/oQLNXtyov+2
	 G9Wh9bnCLZSkYckyWmbKAimCJOZ2vfRmftYohg69ce4R/2C+JUzSHcf93MUmch/4QB
	 ikc+OJwA87rSAK/2c/14O5f9qsDOxpB79o7pIxVkbvfEd9So7gajWI7wJmreSR9vsk
	 6TeUoWBEnx5ZG+/gO+B3zLJrxAZSGKF6LpeqLpHxdwU6apDo3hMuwZKU6xTFcJG0kH
	 5NXVc3NRMO8EQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 14C3D43229
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Mar 2026 20:56:47 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ivtT51Xi;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8128D60142;
	Wed, 11 Mar 2026 20:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0A7C2BCB7;
	Wed, 11 Mar 2026 20:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773262606;
	bh=lrM6SdSaCsClSZdw9o+efFHo76I/LXqdd19scY5HvmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ivtT51Xi+u75a/AudCeznrqj7KLWV3BIhn5au4BJQbrTvNHx+mZXomYmcvBVFnyKc
	 b90+orGQVdC/J712Ak4LPOowuXKc+JFgE5gCjgmfpA7y5WWkO3Vi6xOgY88fqoDFs8
	 i3PmAHBwiz7QshaVRBkVJA98ONnldrzPY89YbrSO4jsUGk+sWwmRgnycqOzWEEnN3F
	 jjuV07iz+adXgCXXyErh5JdTWHsz3mVlEsx0XEbjydn/MZbyAaUg/3CqP3FpeiVZbF
	 5Cu45RA3UIGux1CaHMi+VZ6C/w+50xlWznpBfxpw0mmhaJR8t1TsxuVVaCf0gDqQV9
	 WJspjFBIo86sw==
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v4] arm64: defconfig: Enable QCOMTEE module for QTEE-enabled Qualcomm SoCs
Date: Wed, 11 Mar 2026 15:56:36 -0500
Message-ID: <177326259456.44574.8054796134208457144.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260114-qcom_qcomtee_defconfig-v4-1-ec676311171f@oss.qualcomm.com>
References: <20260114-qcom_qcomtee_defconfig-v4-1-ec676311171f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 14C3D43229
X-Spamd-Bar: --
Message-ID-Hash: I6JNMH7NWJUPQECEK6QK4P5OMIOPOXB3
X-Message-ID-Hash: I6JNMH7NWJUPQECEK6QK4P5OMIOPOXB3
X-MailFrom: andersson@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/I6JNMH7NWJUPQECEK6QK4P5OMIOPOXB3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Bjorn Andersson via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Bjorn Andersson <andersson@kernel.org>


On Wed, 14 Jan 2026 13:49:14 +0530, Harshal Dev wrote:
> All Qualcomm SoCs starting from SM8650 provide access to the Qualcomm
> Trusted Execution Environment (QTEE) through the SMCInvoke interface,
> implemented by the QCOMTEE driver. QTEE runs in the Secure World domain
> on ARM64 CPUs and exposes secure services to Linux running in the Normal
> World domain.
> 
> This change enables the QCOMTEE driver as a module to support
> communication with QTEE.
> 
> [...]

Applied, thanks!

[1/1] arm64: defconfig: Enable QCOMTEE module for QTEE-enabled Qualcomm SoCs
      commit: dccccbb739510a63cc62eb3cc1261392cc6045f7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
