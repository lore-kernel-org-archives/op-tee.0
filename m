Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4687C71155
	for <op-tee@archiver.kernel.org>; Tue, 17 Jun 2025 04:44:55 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 175E745EF1
	for <op-tee@archiver.kernel.org>; Tue, 17 Jun 2025 04:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1750135495;
	bh=H7GANlnHbRQ0PuyObSnaelRfAXM+A9g6rqgPH2m/yv0=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=xnLsvvZd9NSufzkKKhnSV/KwjCEa1Qe+fS3jwDkls9Xjk5pTdzVrbCS0WS4O1WzVu
	 ZstgupWeyFWaD2JUiASL3hAj6kPwJk78O1WFoJkA0AfaJPhxbnmu6da2GJIQS3U/zc
	 1jH4qvcrT2RHltcBWThD3dVOHeNXljhPvggvbJMZt/fE5dhzjHaTrJ9Mi4UfuLE8rQ
	 jzVKP4/hOKbvvY+nsOx0BfHgnCZqXEs8T+euEX8O0j7Kgu5WOIhZ0L2EikZn1ngWkL
	 b4pctih18Skgm4dXjzYU3bb/hv6HlGlmXN3ZJ1mtdQo00+Q/kUOCt6QiMkVO0U9Ya5
	 AKvAwpTEgHDDg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AF2153E96B
	for <op-tee@lists.trustedfirmware.org>; Tue, 17 Jun 2025 04:44:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MfLtu92n;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0941344935;
	Tue, 17 Jun 2025 04:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110A7C4CEE3;
	Tue, 17 Jun 2025 04:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750135472;
	bh=H7GANlnHbRQ0PuyObSnaelRfAXM+A9g6rqgPH2m/yv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MfLtu92nyNSb3F2sQDQ/ODu41QB2CvwMUBmPhR71EM1n1U7SKPkOGBJ78GcKamBEJ
	 gn7v6p6J4YacC+uhPooq9P7M/jmxtZR0h2aeH8+2V3+0enbewIa1JNmGYCtURoj3Dj
	 P1UFGOMjYvOfUKY3tMTnzh/Jqy4KB8dCjleIlK9z48MGCRVflAsAaFFrOZkaeK8uSr
	 NgxhVQ3rj/7a1ehnQ8kDQfNvNAktlshGRg/VmyOim4xHXHfiFVgqGWn4fkRDw4lpGZ
	 jeu2Zf4DO4MX4USmoLPUgjhq/zMmqoq9acyukuxynaTjuRfmUWU5vh31y7XwsP96Kn
	 25msb2rPXD4YQ==
Date: Mon, 16 Jun 2025 23:44:30 -0500
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: Re: [PATCH v18 3/6] remoteproc: Introduce release_fw optional
 operation
Message-ID: <6ekro2uytz7kguphtub54wivmclpnfkjobduhsom4kvxlmov2l@hgcjoposj3md>
References: <20250616075530.4106090-1-arnaud.pouliquen@foss.st.com>
 <20250616075530.4106090-4-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616075530.4106090-4-arnaud.pouliquen@foss.st.com>
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AF2153E96B
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[172.234.252.31:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
Message-ID-Hash: JR54NI3CE46PIABNFTTWCZQ552BHLQBV
X-Message-ID-Hash: JR54NI3CE46PIABNFTTWCZQ552BHLQBV
X-MailFrom: andersson@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JR54NI3CE46PIABNFTTWCZQ552BHLQBV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Bjorn Andersson via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Bjorn Andersson <andersson@kernel.org>

On Mon, Jun 16, 2025 at 09:55:27AM +0200, Arnaud Pouliquen wrote:
> The release_fw operation is the inverse operation of the load, responsible
> for releasing the remote processor resources configured from the loading
> of the remoteproc firmware (e.g., memories).
> 

I was under the impression that we agreed that this would unroll
rproc_parse_fw() not the "load" in general.

> The operation is called in the following cases:
>  - An error occurs on boot of the remote processor.
>  - An error occurs on recovery start of the remote processor.
>  - After stopping the remote processor.
> 
> This operation is needed for the remoteproc_tee implementation after stop
> and on error.

And if it's defined to unroll rproc_parse_fw() it can be used for other
things where some resources was allocated to set up the resource table.

> Indeed, as the remoteproc image is loaded when we parse the resource
> table, there are many situations where something can go wrong before
> the start of the remote processor(resource handling, carveout allocation,
> ...).

Unbalanced parenthesis? I think you can write this in less
conversational style.

> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c     | 6 ++++++
>  drivers/remoteproc/remoteproc_internal.h | 6 ++++++
>  include/linux/remoteproc.h               | 3 +++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index d06eef1fa424..4c1a4bc9e7b7 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1857,6 +1857,8 @@ static int rproc_boot_recovery(struct rproc *rproc)
>  
>  	/* boot the remote processor up again */
>  	ret = rproc_start(rproc, firmware_p);
> +	if (ret)
> +		rproc_release_fw(rproc);
>  
>  	release_firmware(firmware_p);
>  
> @@ -1998,6 +2000,8 @@ int rproc_boot(struct rproc *rproc)
>  		}
>  
>  		ret = rproc_fw_boot(rproc, firmware_p);
> +		if (ret)
> +			rproc_release_fw(rproc);
>  
>  		release_firmware(firmware_p);
>  	}
> @@ -2067,6 +2071,8 @@ int rproc_shutdown(struct rproc *rproc)
>  
>  	rproc_disable_iommu(rproc);
>  
> +	rproc_release_fw(rproc);
> +
>  	/* Free the copy of the resource table */
>  	kfree(rproc->cached_table);
>  	rproc->cached_table = NULL;

These are allocated in rproc_parse_fw(), would it not make sense to
clean them up in your newly introduced function?

> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 0cd09e67ac14..c7fb908f8652 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -221,4 +221,10 @@ bool rproc_u64_fit_in_size_t(u64 val)
>  	return (val <= (size_t) -1);
>  }
>  
> +static inline void rproc_release_fw(struct rproc *rproc)
> +{
> +	if (rproc->ops->release_fw)
> +		rproc->ops->release_fw(rproc);
> +}
> +
>  #endif /* REMOTEPROC_INTERNAL_H */
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 8fd0d7f63c8e..80128461972b 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -381,6 +381,8 @@ enum rsc_handling_status {
>   * @panic:	optional callback to react to system panic, core will delay
>   *		panic at least the returned number of milliseconds
>   * @coredump:	  collect firmware dump after the subsystem is shutdown
> + * @release_fw:	optional function to release the loaded firmware, called after
> + *              stopping the remote processor or in case of error

The struct firmware is released at the end of startup and the typical
carveout memory where the firmware is loaded into is released at
rproc_shutdown().

As such, this won't help anyone understand the purpose of the ops unless
they know your system design (and know you added it).

Regards,
Bjorn

>   */
>  struct rproc_ops {
>  	int (*prepare)(struct rproc *rproc);
> @@ -403,6 +405,7 @@ struct rproc_ops {
>  	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
>  	unsigned long (*panic)(struct rproc *rproc);
>  	void (*coredump)(struct rproc *rproc);
> +	void (*release_fw)(struct rproc *rproc);
>  };
>  
>  /**
> -- 
> 2.25.1
> 
