Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83E3CA0EFA
	for <op-tee@archiver.kernel.org>; Tue, 26 Aug 2025 15:52:45 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1DA9B4FC97
	for <op-tee@archiver.kernel.org>; Tue, 26 Aug 2025 15:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1756223565;
	bh=Xk1Dlrwmt/FVCoeY2SvxmUUDznt0F17TZQXVNjpXqaU=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=A0F8jMO6xu9g5rum3lwRLQOl6mA3oeyLBsZ28EeGj7NxzZQbzwTaO+5KpQOuzYfuQ
	 eOG5IxQhkJS5ctht3hx7rGiCjT8K+piojBXCzeKhilHmOvwbet9Y5KsPW85fBXpYAc
	 nLhndIypccgdTlH5BOnYaQfo3/kyRk/r3fIoNVSodYw9WBO9fllXwEo5ppaUqbuxS4
	 JaD5XagGkc4xvslQw7sLWU5KPDkSbZTiSXL09TNNMYB9gNfSDfwdnJq5rQ1gFYi3xl
	 UCE1SDPVMCxJy2Ets24VoxsbimMXhMlevpYEtsTeGyxFpyzogkNeHIlubBT9WYA5uU
	 et+hUzGBpLGIg==
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5AA4540AC8
	for <op-tee@lists.trustedfirmware.org>; Tue, 26 Aug 2025 15:52:29 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JGLVLMMH;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9E8BA5C63F2;
	Tue, 26 Aug 2025 15:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04CBC4CEF1;
	Tue, 26 Aug 2025 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756223543;
	bh=Xk1Dlrwmt/FVCoeY2SvxmUUDznt0F17TZQXVNjpXqaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGLVLMMH8ToLx3JZ3Wu5MMVqVpd3pqTHaNkGmbIW11w+Cctctg0L+EftbXxoqQp7M
	 BkEtZ5E7mvulvAYs7ZyNCxi4QPewhNjI7788w5UEasFD/bUZUSrQvA4VkUXawbNu+w
	 jw/ejM1zYsqaKpxR44FdQGFW+Iw/uooWovn1xpglrBqoYDv77E6VZS9AiMl3Ci0Pu4
	 HveOQ3TLXDTgMa83RV1/NKHhnV3pNYObIF3mvg4Yjm8LgdUCiBKnaiB9lG1oSPp/ff
	 JnjdXkx6QWQCDEAKFzgXuYKtH74rSfCeKSm611ugEfh6yZ2glKo//2Zj7Fk4iwEuUq
	 aXp5m/y0d4Zlw==
Date: Tue, 26 Aug 2025 10:52:20 -0500
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: Re: [PATCH v8 06/11] firmware: qcom: scm: add support for object
 invocation
Message-ID: <itpdolgmxp4ofdv3vf2ghulo7slj5wjby2tvawehihwvenbep2@ub5sdgf6gxeh>
References: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
 <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-6-7066680f138a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-6-7066680f138a@oss.qualcomm.com>
X-Rspamd-Queue-Id: 5AA4540AC8
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	RCVD_IN_DNSWL_HI(-0.50)[139.178.84.217:from];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:139.178.84.217];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:15830, ipnet:139.178.80.0/21, country:NL];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: D25JPS4SDSKYANH747RL7N3WC552JDVW
X-Message-ID-Hash: D25JPS4SDSKYANH747RL7N3WC552JDVW
X-MailFrom: andersson@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/D25JPS4SDSKYANH747RL7N3WC552JDVW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Bjorn Andersson via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Bjorn Andersson <andersson@kernel.org>

On Wed, Aug 20, 2025 at 04:38:53PM -0700, Amirreza Zarrabi wrote:
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
[..]
> +static void qcom_scm_qtee_free(void *data)
> +{
> +	struct platform_device *qtee_dev = data;
> +
> +	platform_device_unregister(qtee_dev);
> +}
> +
> +static int qcom_scm_qtee_init(struct qcom_scm *scm)
> +{
> +	struct platform_device *qtee_dev;
> +	u64 result, response_type;
> +	int ret;
> +
> +	/*
> +	 * Check if QTEE supports smcinvoke:
> +	 * This will fail due to invalid buffers, but first, it checks whether
> +	 * the call is supported in QTEE syscall handler.
> +	 * If not supported, -EIO is returned.
> +	 */
> +	ret = qcom_scm_qtee_invoke_smc(0, 0, 0, 0, &result, &response_type);
> +	if (ret == -EIO)
> +		return -EIO;
> +
> +	/* Setup QTEE interface device. */
> +	qtee_dev = platform_device_alloc("qcomtee", -1);
> +	if (!qtee_dev)
> +		return -ENOMEM;
> +
> +	qtee_dev->dev.parent = scm->dev;
> +
> +	ret = platform_device_add(qtee_dev);
> +	if (ret) {
> +		platform_device_put(qtee_dev);
> +		return ret;
> +	}

Wouldn't this work instead of the alloc + parent + add?

	qtee_dev = platform_device_alloc_data(scm->dev, "qcomtee", -1, NULL, 0);
	if (IS_ERR(qtee_dev))
		return PTR_ERR(qtee_dev);

> +
> +	return devm_add_action_or_reset(scm->dev, qcom_scm_qtee_free, qtee_dev);
> +}
> +
>  /**
>   * qcom_scm_is_available() - Checks if SCM is available
>   */
> @@ -2326,6 +2450,16 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  	ret = qcom_scm_qseecom_init(scm);
>  	WARN(ret < 0, "failed to initialize qseecom: %d\n", ret);
>  
> +	/*
> +	 * Initialize the QTEE object interface.
> +	 *
> +	 * This only represents the availability for QTEE object invocation
> +	 * and callback support. On failure, ignore the result. Any subsystem
> +	 * depending on it may fail if it tries to access this interface.
> +	 */
> +	ret = qcom_scm_qtee_init(scm);
> +	dev_warn_probe(scm->dev, ret, "Failed to initialize qcomtee\n");

A successful boot of db410c (APQ8016) now has the following in the log:

[    0.161437] qcom_scm firmware:scm: error -EIO: Failed to initialize qcomtee

If the target doesn't implement qtee, I'd expect that you tell me that -
or preferably stay silent.

Looking at the other error conditions, we find -ENOMEM, for which you
should also avoid printing. In fact, I believe all other error paths of
qcom_scm_qtee_init() will have printed an error already (if not, please
move the error print to the place(s) where it's needed).

As you're ignoring the return value, please then also change the return
type of the function to void.

Regards,
Bjorn

> +
>  	return 0;
>  }
