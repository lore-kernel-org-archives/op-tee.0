Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0E0C982D2
	for <op-tee@archiver.kernel.org>; Fri, 18 Sep 2026 01:54:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A9D9F4549E
	for <op-tee@archiver.kernel.org>; Fri, 18 Sep 2026 01:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789696447;
	bh=+GM0ZXBoL6s6IRT85tvqIGHYcZKvWd1OuJJsWsQfXCk=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=EbqOS0lao32B4udF4DQoXrCTnRHeKHD7n12Z8rP5mu5qKwr+6bmdyU/AspcM1KnW/
	 AMk1WwXGk5pwgop9LZfFMS2ljcCUwe/DQouY2OvRFBpNy3jL5OcOcTFMDzj6B+uf+K
	 82x/7hn9jZbJQ9Yy1gcxTpkinPxhNTJZVcbIMSJcKyo+sCjxJ+jeu6nSvO7F7/wbpw
	 Pt32zpJCpANTy42hkc9fCYXd8iwN1OXg8+Pq99V57DC4Zn/BbwkVXfwOiprFDXhfzv
	 7rxq3vT8c27mFnvT7x+Ck4/YRaNFp+opw21btCGWzU5YRXGlIJYQPP8IMPiWW/McOa
	 eUl15ag9ItLyQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with UTF8SMTPS id BEE5D43E89
	for <op-tee@lists.trustedfirmware.org>; Fri, 18 Sep 2026 01:54:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dIjAPzLw;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 37CF8600AA;
	Fri, 18 Sep 2026 01:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 55F4E1F000FF;
	Fri, 18 Sep 2026 01:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789696439;
	bh=obV/ac6ej+fVGQtRoYSjypa70vcPU57Q0Ik4AGQOcqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dIjAPzLwwEdoq3LpBwUIj8dKrNHe60hIpOlLugbcD1QtiP/dZdWyzgfun1xhVGEgt
	 dkQtOV//iQjkFZhF2NJl9nl5E/gEoFFUqJmH6/Ck09/wHhGHKi8lO65nMYlsHPo4oU
	 458D3fF2otwRwADTk/WYGMI5840gPCLyg5oNcAIPFsHz+3CQpvT+6FssuYq9Xj+7fT
	 yvgZMqVoG5mCVvyRI2c3nkLYs3RPXR7+FxhWU7Dc8vLtSNkSsShKwC3xbsvzZeMRE0
	 9NXcDFXyVfD+uwHaDXMWBZY5x81vsO1o2gU51WpfIytLPbJ4p7t0BgzC2EGiOew60I
	 cRmUGyyDsW3Xg==
Date: Fri, 18 Sep 2026 04:53:56 +0300
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/3] Add TPM support via Qualcomm TEE TPM TA
Message-ID: <aqyZtHynb2nuQT-P@kernel.org>
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BEE5D43E89
X-Spamd-Bar: ------
Message-ID-Hash: QTJI3GAGFD2GR6U276ITTEISEWXSVZQZ
X-Message-ID-Hash: QTJI3GAGFD2GR6U276ITTEISEWXSVZQZ
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QTJI3GAGFD2GR6U276ITTEISEWXSVZQZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>

On Mon, Sep 07, 2026 at 02:58:40PM +0530, Kuldeep Singh wrote:
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
> This patch series functionally depends on below(patch 5/6 specifically)
> for qtee service discovery.
> - https://lore.kernel.org/lkml/20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com/
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
>  MAINTAINERS                       |   7 +
>  drivers/char/tpm/Kconfig          |   9 +
>  drivers/char/tpm/Makefile         |   1 +
>  drivers/char/tpm/tpm_qcom.c       | 354 ++++++++++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm_qcom.h       |  83 +++++++++
>  drivers/tee/qcomtee/call.c        |   4 +-
>  drivers/tee/qcomtee/qcomtee_msg.h |   2 +
>  7 files changed, 459 insertions(+), 1 deletion(-)
> ---
> base-commit: f3e6330d7fe42b204af05a2dbc68b379e0ad179e
> change-id: 20260831-tpm_qcom_driver-d21c720e73b2
> prerequisite-change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014:v2
> prerequisite-patch-id: 4dc81445c9baf36f420da8c2e2bed96e71b31a5b
> prerequisite-patch-id: b487dfe2fbc076f4815dc6c73b9e68b0b78c961f
> prerequisite-patch-id: c5df2b3696520a96f95b2d3535ed84cdc21cc315
> prerequisite-patch-id: bbdd5327c15aeaa99ce9b74bab324a98f084ed48
> prerequisite-patch-id: 07d9c4e9fe9fd61f60e3f35b30b9d81716f0734c
> prerequisite-patch-id: 10ff88d87586f21f3cff3f72dbd21c27adbfbbcc
> 
> Best regards,
> --  
> Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> 

Causes merge conflicts with my tree when applied with git am (actually
b4 shazam).

BR, Jarkko
