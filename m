Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C389606A338
	for <op-tee@archiver.kernel.org>; Fri, 20 Nov 2026 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=07XEIfJL;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hs0nlq9C
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BFFE045530
	for <op-tee@archiver.kernel.org>; Fri, 20 Nov 2026 13:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795179722;
	bh=tqxcyjdSXE3TRpTJQ44qkFjUoSwvNz0/CL/cMLrjomg=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=07XEIfJLwK9vV0nUrZaezkCoV0Hb8ux8OModsoxs4DwGirIfCmLVxtViAXqncOoCE
	 0IW97LJZasH2bz0KzH4UP8LQ4ABIc2lLUAG4omDejhE65zumF6YIiOo/l3TuFCJaFt
	 FcX6XffswoQmDmSGFPpNQlIuAVG2vboJX7cPEIAmSG4lzb346T0a46Rk+ft2gzuf6Q
	 2AxosQn+3avDkqYvU8JFy3dBbt89KbcM5Q45UKlTuTpisEcxNYnB1W9eSEa5RpNtEc
	 ZgkUlN+TnfjLC6SxzZJEFP26+lX7XOP5PMv1HbGjHfT3Ebff8oFrqrG4ML9yAo1O1F
	 XI5n8CmxZ7Nrg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with UTF8SMTPS id E13A540ACE
	for <op-tee@lists.trustedfirmware.org>; Fri, 20 Nov 2026 13:01:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hs0nlq9C;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 1AFF461D73;
	Fri, 20 Nov 2026 13:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 472B21F000C6;
	Fri, 20 Nov 2026 13:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795179715;
	bh=cYsdqs4y232JPLuAEoAJ25nOUZJElAEMEA3xsIxpxkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hs0nlq9CX1tHPc6W09WRShiUTPcfyAvkwJlCfjKI7TYxn+t8Q/aP2TUoCYARmANMA
	 4BQ87lqlXVv2qruQ0wbMfzyX5DRzA/wACHorYkehbMxMX3vn6Yz7D+shJ0PSm16r7w
	 K20Wq7agCxBEt3jBRYG4WZmw2siy6zshIwcFZ1dSVeVpvf9d4ahXXeFQFLKMLLL2bH
	 BHTKa6kYB1e5j5I/FF/ndiR+kewDs/5n2GVda1zNzdPWCY4AXkg23p5al8zvLmZKbF
	 rGKW9dp15GAXjXGqvVQUJXu/+U7mGfRtYv7UBR0hAZb+HL7kEkMYbdMgVO4Ru3eufC
	 gSFBulHJbEefg==
Date: Fri, 20 Nov 2026 15:01:52 +0200
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/3] Add TPM support via Qualcomm TEE TPM TA
Message-ID: <awBEwJf3CIjTvtid@kernel.org>
References: <20261120-tpm_qcom_driver-v5-0-3d9321ace107@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-tpm_qcom_driver-v5-0-3d9321ace107@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.70 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	RCVD_IN_DNSWL_MED(-0.20)[172.105.4.254:from];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E13A540ACE
X-Spamd-Bar: --------
Message-ID-Hash: S4GSNVSUC7MRERGRH6JOBQ53KERZXOEB
X-Message-ID-Hash: S4GSNVSUC7MRERGRH6JOBQ53KERZXOEB
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/S4GSNVSUC7MRERGRH6JOBQ53KERZXOEB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 04:23:31PM +0530, Kuldeep Singh wrote:
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
> - https://lore.kernel.org/lkml/20261105-qcom_uefisecapp_migrate_qcomtee-v6-0-c7d68ce05c51@oss.qualcomm.com/
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
> Changes in v5:
> - Rebase on next-20261119.
> - Fix qcom_send_command resp_len computation(Amir)
> - Use dev_err_probe in _probe and return appropriate failures.
> - Propagate dtpm transfer/end error to callers.
> - Fix drv_data after tpmm_chip_alloc call.
> - Link to v4: https://patch.msgid.link/20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com
> 
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
>  drivers/char/tpm/tpm_qcom.c       | 410 ++++++++++++++++++++++++++++++++++++++
>  drivers/tee/qcomtee/call.c        |   4 +-
>  drivers/tee/qcomtee/qcomtee_msg.h |   2 +
>  6 files changed, 431 insertions(+), 1 deletion(-)
> ---
> base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
> change-id: 20260831-tpm_qcom_driver-d21c720e73b2
> prerequisite-change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014:v6
> prerequisite-patch-id: faf4520d818abf0d7533f71d9c8b9a8aade34626
> prerequisite-patch-id: b487dfe2fbc076f4815dc6c73b9e68b0b78c961f
> prerequisite-patch-id: 9f2c4ee37ba173bdc860f253d44974379f2cf125
> prerequisite-patch-id: e86905ac6289821db30fd9a17f73e276e0a88363
> prerequisite-patch-id: 09a86ee4de34e0c9cd2e4664c54a6473d7998299
> prerequisite-patch-id: a940a0624f1e130d1fe5213952965aa469bf9547
> prerequisite-patch-id: 7be993abea2ca36057d9352381a5890f50996dda
> 
> Best regards,
> --  
> Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
