Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245DFC982D0
	for <op-tee@archiver.kernel.org>; Fri, 18 Sep 2026 01:49:47 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 583064521F
	for <op-tee@archiver.kernel.org>; Fri, 18 Sep 2026 01:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789696186;
	bh=CaC1JZDiBUQGBz+v18RtejpXUNx5ZvC8M1PInZMKVEA=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ejTk7Y+SGfybMJOKiF8LxJHC+u+qrIcWopManeowpzlyrTPDiQfXztBQTR7DG8mP3
	 YZ2O1sivQF7aOJ/uysykK25b4XFbukQzuucsi5v4RpY8F1IobUUjid7bWpHmAWfLFw
	 9PUXYgnbhkfV9X4bH1E3jSCx5Lf+LqnReOogamHUwLRvea0APmKs0sURyyip/PueAK
	 3sWILjbelLHi8j9KtPPlwxYFo8lS0daJnANwl12CikLgUuXhZtTVaTAxtfD/6Jt/d/
	 ojSdtecsX5Op2z0PsgnLigZkiD3+adHi6+u29ciUpdy7aVTWc/stlKMIDclpGeBYjP
	 x3QSi4Ivgfn1Q==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with UTF8SMTPS id E3EFF44402
	for <op-tee@lists.trustedfirmware.org>; Fri, 18 Sep 2026 01:49:39 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dDxl1whZ;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 3AA10429F2;
	Fri, 18 Sep 2026 01:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 866E21F000FF;
	Fri, 18 Sep 2026 01:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789696179;
	bh=nFSTUGhm0bEabhyxlgtAtGNKFez8m79aroI8FqNsttA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dDxl1whZW6/aWkT6V4Vr8dHiSZCj8k4/nYuZ8Q0cKmDDXJzQqwVxgfgpQw8jxqXM/
	 8F6rfAOmCFVApjjwBiK3NEPIk1TxLP5gp6PaJ9pZX1j3ZGHovBGPOUTBAQhJ6IUqIL
	 FMIGE1KozNAaTWefStLaMR0/EnX1TJrIMjNuCFaiu3WToT5C55YuXcL/C8bl0dEuHJ
	 pym5Zdz9EkCmPIf+qqoblYMhWTzHHUqJ4kIAtlBdHlmLeX94xI9pfkMTMzG1D6CYJT
	 48CylJ0SJ2qf6ikObKk89G+LYCHYQEmiV1JKqqa5WFBtgEGkxztA1gOp7x6kuLSafj
	 1BlkqjElJNOpg==
Date: Fri, 18 Sep 2026 04:49:35 +0300
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Add Qualcomm TPM driver entry
Message-ID: <aqyYr6SCip8Xgpd3@kernel.org>
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
 <20260907-tpm_qcom_driver-v2-3-71a6b1752da8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-tpm_qcom_driver-v2-3-71a6b1752da8@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E3EFF44402
X-Spamd-Bar: --------
Message-ID-Hash: 4FFCJJZJX7URSKVCLQYLE7MF2KEHHORU
X-Message-ID-Hash: 4FFCJJZJX7URSKVCLQYLE7MF2KEHHORU
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4FFCJJZJX7URSKVCLQYLE7MF2KEHHORU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>

On Mon, Sep 07, 2026 at 02:58:43PM +0530, Kuldeep Singh wrote:
> Add a dedicated MAINTAINERS entry for the Qualcomm TPM driver, which
> uses the Qualcomm TEE interface (qcomtee) to communicate with a TPM
> Trusted Application running in TrustZone.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 47b04968e79a..cfa5b66823c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22636,6 +22636,13 @@ S:	Maintained
>  F:	Documentation/tee/qtee.rst
>  F:	drivers/tee/qcomtee/
>  
> +QUALCOMM TPM DRIVER
> +M:	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/char/tpm/tpm_qcom.c
> +F:	drivers/char/tpm/tpm_qcom.h
> +
>  QUALCOMM TRUST ZONE MEMORY ALLOCATOR
>  M:	Bartosz Golaszewski <brgl@kernel.org>
>  L:	linux-arm-msm@vger.kernel.org
> 
> -- 
> 2.34.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
