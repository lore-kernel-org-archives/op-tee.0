Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F63D47CC3
	for <op-tee@archiver.kernel.org>; Fri, 16 Jan 2026 10:07:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 723BF434B3
	for <op-tee@archiver.kernel.org>; Fri, 16 Jan 2026 10:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1768558045;
	bh=LHbK9QjBXePfKKnVZnTRCPaR19G/K6FAbaEB3w8HFbA=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=WpOEVWBHLDAmpQyXfGRBTuV7QH6fadWNGxPFmgWQ31ki+2mxUGQafMY8DsbZF5QcD
	 xe/cVS2npPZj4osa5Uu+pZn7phf9sZuNqR1u/5dFnluxWPpf/UjaXnhDVGSXiOJ+gQ
	 d0ibEzje9nqzYmdDShbFNESsYR/s+hy95MmGcjjVY7+WPcEM+VbFjSfjyTzoe/ULQ3
	 3nBm2+uQBLY0KQk4SMsrWGAo/0EVJc0bn0ygirtcqKZVV/BaZIAa4FGupYsgkeevp7
	 Bv/yB7qSlhtQ0mcVJw668J/IqQ/IcTH0R6i32FKFFRRGPKuD9OIgdrFAZc0wyIK5U3
	 VqJdZR3faEUsg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B2E53430D6
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Jan 2026 10:06:59 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ToMto2U4;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 49B336016B;
	Fri, 16 Jan 2026 10:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BD9C116C6;
	Fri, 16 Jan 2026 10:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768558019;
	bh=LHbK9QjBXePfKKnVZnTRCPaR19G/K6FAbaEB3w8HFbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ToMto2U4347WHrBDD1IlokVELfBUbvcMtXdwsaYpkIq1iyMfS7pGQcIlSbRYbz0PB
	 2AI8WSjRh52OFYbrAlt9Sz7liTuY69PbNxSuIGqeOh+/afrrpgizAJq8uHf4psIqhg
	 qX2M/g3wgZfn6qMzE0EQDRl+ryVyi92kSZ4S6oJipPvNrNCaO3J/m4m2VWUvq41e8O
	 X3/i6FqiOo0phYpz5m4q4IWLGeAp5yKbuo6DG0rO+laAOm2+KuYRqTjYlWg5oiQFBi
	 i2McBf55MwqSiI6mP3X7ralBiKWvy6jayvsRgtTqGvgIpAOp1xiTA7xgr9v3ChhJvd
	 Xdep4C/eW7zMQ==
Date: Fri, 16 Jan 2026 15:36:50 +0530
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v4] arm64: defconfig: Enable QCOMTEE module for
 QTEE-enabled Qualcomm SoCs
Message-ID: <aWoNut1UzpL8Il9V@sumit-xelite>
References: <20260114-qcom_qcomtee_defconfig-v4-1-ec676311171f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114-qcom_qcomtee_defconfig-v4-1-ec676311171f@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	RCPT_COUNT_SEVEN(0.00)[11];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B2E53430D6
X-Spamd-Bar: -
Message-ID-Hash: CBXEA2VE4U5EER72BOJH35LC7565T4TI
X-Message-ID-Hash: CBXEA2VE4U5EER72BOJH35LC7565T4TI
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Krzysztof Kozlowski <krzk@kernel.org>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CBXEA2VE4U5EER72BOJH35LC7565T4TI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Wed, Jan 14, 2026 at 01:49:14PM +0530, Harshal Dev wrote:
> All Qualcomm SoCs starting from SM8650 provide access to the Qualcomm
> Trusted Execution Environment (QTEE) through the SMCInvoke interface,
> implemented by the QCOMTEE driver. QTEE runs in the Secure World domain
> on ARM64 CPUs and exposes secure services to Linux running in the Normal
> World domain.
> 
> This change enables the QCOMTEE driver as a module to support
> communication with QTEE.
> 
> QCOMTEE has been tested on a Qualcomm RB3Gen2 board by loading and
> executing a Trusted Application via tests hosted at
> github.com/qualcomm/minkipc.
> 
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> ---
> Changes in v4:
> - Updated the commit message as per discussion to clarify the following:
> - Why we are enabling QCOMTEE for all arm64 boards.
> - From which Qualcomm SoC onwards the driver is applicable.
> - What functionality the driver provides.
> - How the functionality has been tested and on which board.
> - Link to v3: https://lore.kernel.org/r/20251208-qcom_qcomtee_defconfig-v3-1-b50dcf8ab45e@oss.qualcomm.com

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> Changes in v3:
> - Updated the commit message to reflect the supported Qualcomm platforms.
> - Link to v2: https://lore.kernel.org/r/20251205-qcom_qcomtee_defconfig-v2-1-c92560b0346e@qti.qualcomm.com
> 
> Changes in v2:
> - Updated CONFIG_QCOMTEE flag to 'm' since QCOMTEE can be built as a module.
> - Link to v1: https://lore.kernel.org/r/20251202-qcom_qcomtee_defconfig-v1-1-11bfe40a8ea4@oss.qualcomm.com
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index cdb7d69e3b24..e952d24bef77 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1789,6 +1789,7 @@ CONFIG_FPGA_MGR_ZYNQMP_FPGA=m
>  CONFIG_FPGA_MGR_VERSAL_FPGA=m
>  CONFIG_TEE=y
>  CONFIG_OPTEE=y
> +CONFIG_QCOMTEE=m
>  CONFIG_MUX_GPIO=m
>  CONFIG_MUX_MMIO=y
>  CONFIG_SLIMBUS=m
> 
> ---
> base-commit: 47b7b5e32bb7264b51b89186043e1ada4090b558
> change-id: 20251202-qcom_qcomtee_defconfig-8dc0fed1411b
> 
> Best regards,
> -- 
> Harshal Dev <harshal.dev@oss.qualcomm.com>
> 
