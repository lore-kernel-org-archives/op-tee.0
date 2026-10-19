Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D60CCF2DB
	for <op-tee@archiver.kernel.org>; Mon, 19 Oct 2026 13:21:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E743A45336
	for <op-tee@archiver.kernel.org>; Mon, 19 Oct 2026 13:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792416116;
	bh=t4RaAAhNDQW3GB2qxUGxvNCOVBzhA7WxA8Ad4wHd6Hk=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=VpCbx8qVq5NGUyuPqcK/U1EweGfVSEqTgN9qb6wb9xX2mJSamxcCY6HI/+aGfuVkD
	 7GIFcgILQSMba7U/wdpyMChDlwt/qublsLtil69IpapS++Gr0wH9/pqsZUBpeRxiKG
	 yQ2XHKaRJLJv/mktz7aBcAGg335P1+AQWRh616uCTp3q7b761CnxNMIeQOtmPLu2CK
	 ILqdNUnwE6BBhguWVfJ9mnp0XTTYmJ+oadhe+fNgT8zDGrGmYgzwH3ITWvwBafYSpI
	 c2PJihaemxqOAclW/3t8HO20iR/pEU9rvN+/oNWnm2zntB1OFwT3ChM1+tG+IxycOZ
	 TkUrY98De2NUg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with UTF8SMTPS id AA16744A8C
	for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 13:21:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=df9wefRH;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id F34A540959;
	Mon, 19 Oct 2026 13:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4F7201F000C4;
	Mon, 19 Oct 2026 13:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416096;
	bh=MXOM9p/pv64oF7UY6qVlVeA0Fpe+myj4kNdbvKDYSSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=df9wefRHKN7HcsxehaBfVkpCllAkofbk31C7StyYCzJCTtEvn+OEDvuskhLBPC3O8
	 mCeq5bIAvLJ6C32izh2R0tGtBKZStfA0M4T4pOR0F0nezQ7UjeZATLCA0ucyD0MnsH
	 M8oz5YIetuxAVGR33ZOWeq724veYJMzh+0EdpGZLnhb9MPBU62XjTfGBPVr7fMoulw
	 iU9Ho6lGYus8cNwtmQ9VhAxsNzmfNMAcOpGfDefWpScyna0kUHkReIdvC3EUfbezjI
	 98po9zaNuMCKNWlr3inxT0a3J6X0Z/OwhKCO7PgvT7qpESBbQ0FXEZ2ABUmn979mMY
	 HptIF3N6caM2Q==
Date: Mon, 19 Oct 2026 16:21:33 +0300
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/3] Add TPM support via Qualcomm TEE TPM TA
Message-ID: <atYZXRLf3YPZhiNB@kernel.org>
References: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AA16744A8C
X-Spamd-Bar: ------
Message-ID-Hash: URTTBH4DSOOOUWU4GZVKDKFXG7XY56YA
X-Message-ID-Hash: URTTBH4DSOOOUWU4GZVKDKFXG7XY56YA
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/URTTBH4DSOOOUWU4GZVKDKFXG7XY56YA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>

On Mon, Oct 19, 2026 at 02:51:45PM +0530, Kuldeep Singh wrote:
> Qualcomm platforms with a discrete TPM (dTPM) talked to it directly over
> a non-secure SPI channel from the kernel. Arm's Base Boot Security
> Requirements (BBSR) v1.4 require that access to go through TrustZone
> instead, so on affected Qualcomm platforms the TPM 2.0 instance is now
> fronted by a Trusted Application (TA) running inside Qualcomm's Trusted
> Execution Environment (QTEE), which talks to the dTPM (or implements an
> fTPM) on the kernel's behalf.
> 
> This series adds a kernel driver for that TA, built on the QCOMTEE
> object-IPC transport (drivers/tee/qcomtee/) already used to reach other
> QTEE services.
> 
> This patch series functionally depends on below(first 5 changes specially)
> for qtee service discovery.
> - https://lore.kernel.org/lkml/20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com/
> 
> Tested on Glymur-crd target with tpm2-tools utility.
> 
> Validations:
> - Get capabilities
> - Random number generator
> - RSA key creation, encryption and decryption.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> ---
> Changes in v4:
> - Add new line before goto label(Jarkko).
> - Link to v3: https://patch.msgid.link/20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com
> 
> Changes in v3:
> - Merge tpm_qcom.h into tpm_qcom.c(Amir comments)
> - Update return values of functions and drop certain error prints.
> - Define locality_arg as default value.
> - Add Jarkko's tag on all but drop from 2/3 as significant changes done.
> - Link to v2: https://patch.msgid.link/20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com
> 
> Changes in v2:
> - Use QCOMTEE_TPM_UID as 81 for service discovery in patch 1.
> - Use FIELD_GET, zero initialised array and log improvement (Konrad)
> - Improve commit title and other fixes (Jarkko)
> - Split MAINTAINERS entry as separate patch.
> - Link to v1: https://patch.msgid.link/20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com
> 
> To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> To: Jens Wiklander <jenswi@kernel.org>
> To: Sumit Garg <sumit.garg@kernel.org>
> To: Peter Huewe <peterhuewe@gmx.de>
> To: Jarkko Sakkinen <jarkko@kernel.org>
> To: Jason Gunthorpe <jgg@ziepe.ca>
> To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: op-tee@lists.trustedfirmware.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> 
> ---
> Kuldeep Singh (3):
>       tee: qcomtee: Register qcom.tz.tpm service for discovery
>       tpm: Introduce Qualcomm TPM driver
>       MAINTAINERS: Add Qualcomm TPM driver entry
> 
>  MAINTAINERS                       |   6 +
>  drivers/char/tpm/Kconfig          |   9 +
>  drivers/char/tpm/Makefile         |   1 +
>  drivers/char/tpm/tpm_qcom.c       | 414 ++++++++++++++++++++++++++++++++++++++
>  drivers/tee/qcomtee/call.c        |   4 +-
>  drivers/tee/qcomtee/qcomtee_msg.h |   2 +
>  6 files changed, 435 insertions(+), 1 deletion(-)
> ---
> base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
> change-id: 20260831-tpm_qcom_driver-d21c720e73b2
> prerequisite-change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014:v5
> prerequisite-patch-id: faf4520d818abf0d7533f71d9c8b9a8aade34626
> prerequisite-patch-id: b487dfe2fbc076f4815dc6c73b9e68b0b78c961f
> prerequisite-patch-id: 9f2c4ee37ba173bdc860f253d44974379f2cf125
> prerequisite-patch-id: e86905ac6289821db30fd9a17f73e276e0a88363
> prerequisite-patch-id: 8777bfa2ef8344715bf972d049acb0a6ef49b136
> prerequisite-patch-id: 1c7f946e770a1cbc1599f9571282c9265a6af9cd
> prerequisite-patch-id: 7be993abea2ca36057d9352381a5890f50996dda
> 
> Best regards,
> --  
> Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> 

Applying this pulls tons of TEE patches:

Applying: tee: qcomtee: Track the object invocation context
Applying: tee: Add kernel client object invoke helper
Applying: tee: qcomtee: Allow object invokes from kernel clients
Applying: tee: Export uuidv5 generation for TEE backends
Applying: tee: qcomtee: Add support for registering QTEE services on TEE bus
Applying: firmware: qcom: Add support for TEE based EFI-var client driver
Applying: arm64: defconfig: Enable UefiSecApp TEE client driver for Qualcomm SoCs
Applying: tee: qcomtee: Register qcom.tz.tpm service for discovery
Applying: tpm: Introduce Qualcomm TPM driver
Applying: MAINTAINERS: Add Qualcomm TPM driver entry

Br, Jarkko
