Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7644C83F25
	for <op-tee@archiver.kernel.org>; Mon, 21 Jul 2025 10:42:15 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 430EC45987
	for <op-tee@archiver.kernel.org>; Mon, 21 Jul 2025 10:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1753094535;
	bh=32Ezd9NHPvzGB4MDFi30pMB3r9Wjp+fpFw2xP3JHvY8=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=NgudC4Zjgnplb5hUHVt81yrUUQQ5r6gwcjvktVSd8unrwIHPvCEV2sV+6WwaiRWaT
	 7BN521VIvZzCMIrqo8DQFJIua7UTdCDZhUuQMkKujdHXNNbRLNQC7FqXD9dnT1YCds
	 er0kIG2r3ix9oMKUah1NYWRWl8ZqXVjt0i+bVyksyFMRCn/9+f/V+sZzCRlXZHjAZI
	 0YUxwBVOJoBe2nN0g8PHPAs+z+CEItH1fOiMBTS/gwqvxgfdaJIdKkKqO7eZUwZVlq
	 yqK7TvHu6tDg4yOq6zghKX+RJoZQuwBtMLpXhqKx3qZWR1zKyy+qJuKN5zNTY7uMtL
	 H1c9u6tz9QJtw==
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C9B683F7D2
	for <op-tee@lists.trustedfirmware.org>; Mon, 21 Jul 2025 10:41:49 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LlmGrbRw;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 298FF5C44A1;
	Mon, 21 Jul 2025 10:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8605C4CEED;
	Mon, 21 Jul 2025 10:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753094508;
	bh=32Ezd9NHPvzGB4MDFi30pMB3r9Wjp+fpFw2xP3JHvY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LlmGrbRwMWzgGwcOoMjFfintV8khXNcvjHKwl4d5ba703ep1CUXoCSElSrZg41zJL
	 NiwpSBE1SpIFC8eashXR3B3/MbumZoqlqQpc1W6Panr7a+ba4Yuez589tTwZQGHs4G
	 WvaU5rDfW9uBKwQhe1dVtobUkiOnUzZ91ufbNvvUt5NPeM7Ebca4kMejSnmJNMpfgC
	 43/WqkAfQCU9EgY+NdsZ2u6gUszl+BLcTSY6Xu2E5sLMggIWdEYoJkTcLLEBy2uMsg
	 i7ICE/bBMUfhF4rUoaI+KQHN40j8JJvBRlNNpDm9mPb/rXSpf8v6wyeBZZwGDNMcad
	 n2ieNHuK0n9sQ==
Date: Mon, 21 Jul 2025 16:11:34 +0530
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: Re: [PATCH v6 12/12] Documentation: tee: Add Qualcomm TEE driver
Message-ID: <aH4ZXmsKu08F5uPL@sumit-X1>
References: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
 <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-12-697fb7d41c36@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-12-697fb7d41c36@oss.qualcomm.com>
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C9B683F7D2
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-7.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	RCVD_IN_DNSWL_HI(-0.50)[139.178.84.217:from];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:139.178.84.217:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:15830, ipnet:139.178.80.0/21, country:NL];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
Message-ID-Hash: EXOCCK3YLJL24KYWPONL42LUNKC3UD5Y
X-Message-ID-Hash: EXOCCK3YLJL24KYWPONL42LUNKC3UD5Y
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EXOCCK3YLJL24KYWPONL42LUNKC3UD5Y/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Sun, Jul 13, 2025 at 05:49:24PM -0700, Amirreza Zarrabi wrote:
> Add documentation for the Qualcomm TEE driver.
> 
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
>  Documentation/tee/index.rst |  1 +
>  Documentation/tee/qtee.rst  | 96 +++++++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS                 |  1 +
>  3 files changed, 98 insertions(+)

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/Documentation/tee/index.rst b/Documentation/tee/index.rst
> index 4be6e69d7837..62afb7ee9b52 100644
> --- a/Documentation/tee/index.rst
> +++ b/Documentation/tee/index.rst
> @@ -11,6 +11,7 @@ TEE Subsystem
>     op-tee
>     amd-tee
>     ts-tee
> +   qtee
>  
>  .. only::  subproject and html
>  
> diff --git a/Documentation/tee/qtee.rst b/Documentation/tee/qtee.rst
> new file mode 100644
> index 000000000000..2fa2c1bf6384
> --- /dev/null
> +++ b/Documentation/tee/qtee.rst
> @@ -0,0 +1,96 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============================================
> +QTEE (Qualcomm Trusted Execution Environment)
> +=============================================
> +
> +The QTEE driver handles communication with Qualcomm TEE [1].
> +
> +The lowest level of communication with QTEE builds on the ARM SMC Calling
> +Convention (SMCCC) [2], which is the foundation for QTEE's Secure Channel
> +Manager (SCM) [3] used internally by the driver.
> +
> +In a QTEE-based system, services are represented as objects with a series of
> +operations that can be called to produce results, including other objects.
> +
> +When an object is hosted within QTEE, executing its operations is referred
> +to as "direct invocation". QTEE can also invoke objects hosted in the non-secure
> +world using a method known as "callback request".
> +
> +The SCM provides two functions to support direct invocation and callback requests:
> +
> +- QCOM_SCM_SMCINVOKE_INVOKE: Used for direct invocation. It can return either
> +  a result or initiate a callback request.
> +- QCOM_SCM_SMCINVOKE_CB_RSP: Used to submit a response to a callback request
> +  triggered by a previous direct invocation.
> +
> +The QTEE Transport Message [4] is stacked on top of the SCM driver functions.
> +
> +A message consists of two buffers shared with QTEE: inbound and outbound
> +buffers. The inbound buffer is used for direct invocation, and the outbound
> +buffer is used to make callback requests. This picture shows the contents of
> +a QTEE transport message::
> +
> +                                      +---------------------+
> +                                      |                     v
> +    +-----------------+-------+-------+------+--------------------------+
> +    | qcomtee_msg_    |object | buffer       |                          |
> +    |  object_invoke  |  id   | offset, size |                          | (inbound buffer)
> +    +-----------------+-------+--------------+--------------------------+
> +    <---- header -----><---- arguments ------><- in/out buffer payload ->
> +
> +                                      +-----------+
> +                                      |           v
> +    +-----------------+-------+-------+------+----------------------+
> +    | qcomtee_msg_    |object | buffer       |                      |
> +    |  callback       |  id   | offset, size |                      | (outbound buffer)
> +    +-----------------+-------+--------------+----------------------+
> +
> +Each buffer is started with a header and array of arguments.
> +
> +QTEE Transport Message supports four types of arguments:
> +
> +- Input Object (IO) is an object parameter to the current invocation
> +  or callback request.
> +- Output Object (OO) is an object parameter from the current invocation
> +  or callback request.
> +- Input Buffer (IB) is (offset, size) pair to the inbound or outbound region
> +  to store parameter to the current invocation or callback request.
> +- Output Buffer (OB) is (offset, size) pair to the inbound or outbound region
> +  to store parameter from the current invocation or callback request.
> +
> +Picture of the relationship between the different components in the QTEE
> +architecture::
> +
> +         User space               Kernel                     Secure world
> +         ~~~~~~~~~~               ~~~~~~                     ~~~~~~~~~~~~
> +   +--------+   +----------+                                +--------------+
> +   | Client |   |callback  |                                | Trusted      |
> +   +--------+   |server    |                                | Application  |
> +      /\        +----------+                                +--------------+
> +      ||  +----------+ /\                                          /\
> +      ||  |callback  | ||                                          ||
> +      ||  |server    | ||                                          \/
> +      ||  +----------+ ||                                   +--------------+
> +      ||       /\      ||                                   | TEE Internal |
> +      ||       ||      ||                                   | API          |
> +      \/       \/      \/   +--------+--------+             +--------------+
> +   +---------------------+  | TEE    | QTEE   |             | QTEE         |
> +   |   libqcomtee [5]    |  | subsys | driver |             | Trusted OS   |
> +   +-------+-------------+--+----+-------+----+-------------+--------------+
> +   |      Generic TEE API        |       |   QTEE MSG                      |
> +   |      IOCTL (TEE_IOC_*)      |       |   SMCCC (QCOM_SCM_SMCINVOKE_*)  |
> +   +-----------------------------+       +---------------------------------+
> +
> +References
> +==========
> +
> +[1] https://docs.qualcomm.com/bundle/publicresource/topics/80-70015-11/qualcomm-trusted-execution-environment.html
> +
> +[2] http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
> +
> +[3] drivers/firmware/qcom/qcom_scm.c
> +
> +[4] drivers/tee/qcomtee/qcomtee_msg.h
> +
> +[5] https://github.com/quic/quic-teec
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9fc58f48fa14..391fc6e6defc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20706,6 +20706,7 @@ QUALCOMM TEE (QCOMTEE) DRIVER
>  M:	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/tee/qtee.rst
>  F:	drivers/tee/qcomtee/
>  
>  QUALCOMM TRUST ZONE MEMORY ALLOCATOR
> 
> -- 
> 2.34.1
> 
