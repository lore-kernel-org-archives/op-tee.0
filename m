Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D03CCF2C3
	for <op-tee@archiver.kernel.org>; Fri, 16 Oct 2026 21:05:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C77C344DB9
	for <op-tee@archiver.kernel.org>; Fri, 16 Oct 2026 21:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792184741;
	bh=ks/of912DXGLZeNr2Rqj2o6KM4Mb2blY0/P0eNXimIw=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Olze/dLaDNpR0kpU7ebDiUJV7x3574o4xRllWNspFWo9IVzXCmJI4m2/tmTWhAZOk
	 3Ops6yxh3iRrfUyu7G6Uys6u621R4ghy/mLvmuh+ABT2CAuJeI1WcB+ZGDSaqW1XFP
	 3S8AiaylCaVAp8pStGH098XLfJZrCEiHWHpilBhYU5Pp7G7nr7tinOYR2E7RjGQnC3
	 ATFErJMXomV1tRj5ab9R/XH78hwFIglXr94XxfRPylEteVdIubHoBe5M34xLJ4oCdl
	 Y5mQcX/6StzxzDcJALkILpCFHkOnT6lCzytP3Cc+VMZ6gwTlp2mPsm9Y7jxnSBHkZn
	 uBd+SaZCVLEyA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with UTF8SMTPS id 1956B44DB9
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 21:05:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ep5qit5y;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 41F7F41910;
	Fri, 16 Oct 2026 21:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 929B41F000C4;
	Fri, 16 Oct 2026 21:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792184722;
	bh=FOYNtMSvDn7pBJVRwLvlkqM8Xp7WR/Z4rsPYrSx+TgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ep5qit5ytcUQGQs6HzQX5vZLEoPypglHqMJrXT6mbxVQbFUU2/IQCbzA297ANrbXR
	 QV1syvA42YuKiu4W8pZN1R/wZb6HcM0yU7ePPKUJrl1ZMudmE0Oo72IWxauSD+S5Ru
	 0A4/VQ8qapE7cKHvSEvmlhhkwpcp3b/7wgULchyioMPHv1UWnnhZiWbA9uq487d/9x
	 XbAB/s+WSkK2dVPwZAOoQGFte6HhqRnCiHawomo1mZ4RvZZnqwcp+iUgEcxiTlzfdS
	 y4NlIRtTdoE7DgxRQ2juEgOByUpnt59Z4UYtxvY8gGjTGAOEOr9vlEfsa0CFy8umBe
	 fByQk3JEGqgwg==
Date: Sat, 17 Oct 2026 00:05:18 +0300
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/3] Add TPM support via Qualcomm TEE TPM TA
Message-ID: <atKRjiZEMIx3hhxI@kernel.org>
References: <20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received,172.234.252.31:from];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1956B44DB9
X-Spamd-Bar: --------
Message-ID-Hash: BCCN37K3UO7QD4BVEP2P7BH26YLBXTPU
X-Message-ID-Hash: BCCN37K3UO7QD4BVEP2P7BH26YLBXTPU
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BCCN37K3UO7QD4BVEP2P7BH26YLBXTPU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>

On Thu, Oct 15, 2026 at 12:07:45PM +0530, Kuldeep Singh wrote:
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
> - https://lore.kernel.org/lkml/20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com/
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
> Changes in v3:
> - Merge tpm_qcom.h into tpm_qcom.c(Amir comments)
> - Update return values of functions and drop certain error prints.
> - Define locality_arg as default value.
> - Add Jarrko's tag on all but drop from 2/3 as significant changes done.

I get this because I have hard time to write "catppuccin" correctly ;-)

Br, Jarkko
