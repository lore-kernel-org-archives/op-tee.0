Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DB3CA5FD4
	for <op-tee@archiver.kernel.org>; Fri,  2 Oct 2026 05:47:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B54C2454BA
	for <op-tee@archiver.kernel.org>; Fri,  2 Oct 2026 05:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790920023;
	bh=vDVWd7bUUp0fp3rbv49nOQMjeep8XZe6WI6j3JYM4xA=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=H31CL9U1N6lthYZXGZ5H42ajhPkpGs7ZU5nf04k6oIGnGM19Lwe3HQPKScMuu2+Te
	 DOOj6edKRqKYp9wlfxOTDDiMrELQ6CLj++kGFn8+T1VvJv4gASj5LE4vDE+9De7yMD
	 04g6qaMNylMfAAm3LzASSVQyB0tk2u5gfr+P8FCaiA6ewdLBtEZoBOip58g2VOigLs
	 bc+IOAUZNmPdpScxH/0j01B1c6CnlmqpG+J2b8jSwxZcylRnpsnyUgezdps0qI3hUg
	 Y1l/V8FCOzP0DY6pWCDzz8MrlLcTHISY/jCXPP4ILxR1iMTBSuQTj8UQgu7w7hz6ky
	 gAVUm2nrzzaqQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8F80943946
	for <op-tee@lists.trustedfirmware.org>; Fri,  2 Oct 2026 05:46:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cc6PWe0G;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 12EB86021E;
	Fri,  2 Oct 2026 05:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D921F000FF;
	Fri,  2 Oct 2026 05:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790920015;
	bh=BUM0jmk5ROcF9aF+uPw3K8HUOCn6qfcZXTKXnwJVx+c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Cc6PWe0GsMhqxXDv03deTBfCGuixJ7J08WmAuz7zhgNEmtZHErGN3y93JgkQqe8X7
	 FH/vUin/L/di1XjDhpjjLwuyLxIftyENGuBFymWwzXhYV+Bt8U5Tk1crqWT7fpEIkA
	 1Mbm1YXeRf2ubC+XVB1OqjwQCtmrVqkN1i0ydcMGVRYjbHWxa1woKJXiw7SL9ZKkBI
	 lpAbTnNyjnoyUHCxPY0RBeRXaVeGwTD35EYU0ie7ZUtRV15acqGWo3fkBIhtSXQ/qE
	 e7F4oS6bac6EWCUzPhnUjw8GobNNKMzsI3lH89U6qFsktUZm5WwohQ56vbqFjCuEmW
	 6kyRhTSEa2qDw==
Message-ID: <6aa0c698-509e-49d5-a229-7f756355b748@kernel.org>
Date: Fri, 2 Oct 2026 07:46:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] firmware: qcom: Add support for TEE based EFI-var
 client driver
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-0-13df5c20c2e3@oss.qualcomm.com>
 <20261001-qcom_uefisecapp_migrate_qcomtee-v3-6-13df5c20c2e3@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-6-13df5c20c2e3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8F80943946
X-Spamd-Bar: ---------
Message-ID-Hash: TIOFM7KP5WU7473XYROULYVPQMM72G4G
X-Message-ID-Hash: TIOFM7KP5WU7473XYROULYVPQMM72G4G
X-MailFrom: krzk@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TIOFM7KP5WU7473XYROULYVPQMM72G4G/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Krzysztof Kozlowski via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Krzysztof Kozlowski <krzk@kernel.org>

On 01/10/2026 13:02, Harshal Dev wrote:
> On Qualcomm SoC based platforms, UEFI stores EFI variables within the
> Replay Protected Memory Block (RPMB) located within either the UFS,
> eMMC or SPI-NOR storage. The RPMB key which is one-time programmed into
> the storage controller to allow authentication of the RPMB frames is
> generated by and only available to the Qualcomm Trusted Execution
> Environment (QTEE).
> 
> The legacy QSEECOM protocol used for communicating with the QTEE is
> deprecated and replaced with the use-case agnostic SMCInvoke protocol
> starting with the Qualcomm SM8x50 series. On platforms where the QSEECOM
> still driver probes, it does not support a listener interface with QTEE
> to enable writing of non-volatile EFI variables to the RPMB for UFS and
> eMMC storage.
> Therefore on such platforms, a TEE client driver which communicates with
> QTEE via the SMCInvoke protocol implemented by the QCOMTEE driver (and
> registered with the TEE subsystem) must be used to update such EFI
> variables.
> 
> Add support for a TEE based uefisecapp client driver which installs efivar
> operations after obtaining an object reference to the uefisecapp service.
> This enables the kernel/user-space to access or modify both volatile EFI
> variables stored by the Secure Application (in-memory) and non-volatile
> ones stored within RPMB.
> 
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> ---
>  MAINTAINERS                                 |   6 +
>  arch/arm64/configs/defconfig                |   1 +
>  drivers/firmware/qcom/Kconfig               |  31 ++
>  drivers/firmware/qcom/Makefile              |   1 +
>  drivers/firmware/qcom/qcom_tee_uefisecapp.c | 636 ++++++++++++++++++++++++++++
>  5 files changed, 675 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 30c1cdd0fb38..7ccedad8d388 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22981,6 +22981,12 @@ L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
>  
> +QUALCOMM TEE UEFISECAPP DRIVER
> +M:	Harshal Dev <harshal.dev@oss.qualcomm.com>
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/firmware/qcom/qcom_tee_uefisecapp.c
> +
>  QUALCOMM PINCTRL DRIVERS
>  M:	Bartosz Golaszewski <brgl@kernel.org>
>  L:	linux-arm-msm@vger.kernel.org
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index fce418fe6ff6..a8525878c679 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -277,6 +277,7 @@ CONFIG_IMX_SCU=y
>  CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y
>  CONFIG_QCOM_QSEECOM=y
>  CONFIG_QCOM_QSEECOM_UEFISECAPP=y
> +CONFIG_QCOM_TEE_UEFISECAPP=m

I do not see how this change is relevant here. Adding a driver has
nothing to do with defconfig. Drop or split.

Not mentioning that nowhere is explained why you actually need it.


Best regards,
Krzysztof
