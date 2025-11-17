Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE66CE8D6B
	for <op-tee@archiver.kernel.org>; Mon, 17 Nov 2025 05:29:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6275943125
	for <op-tee@archiver.kernel.org>; Mon, 17 Nov 2025 05:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1763357374;
	bh=D4C8s3ogFo2WH2UtGwrimNp5R/LGGPPXFVIRCGScgqA=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=FYIMHRsGLMlsz76KOJJ7zeKRC7QPq4GGzMuZHBYchsFAawOaEVHwvOcbQYCBGdQwh
	 BcQK6jiES9OZEsWFcdRGFHkjENRl/x0RXsVAv35tP54MM8oAGXQzaLPtLpBDkrYl7e
	 fXksKZqTXNGe0PrIzZvGnY/Yqztt3tNAgN3Ay7PMXgdCWbi44HLOR8BdqS5o+VfiFV
	 CuduaKtbP4qGmRSNoms5fLpECI5BZvONsRk+oYAN8ggm2peCN6nvSFlvSSnNq8RKFt
	 i6TWIMybtiNzU/aX5mMfYW87LifUC4ACnblkDFoxdwsmsMVLber/flqKYHgeC79VXT
	 S2Y/wZrcXWQhg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7257E43125
	for <op-tee@lists.trustedfirmware.org>; Mon, 17 Nov 2025 05:29:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E+TVnLiW;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E24F660153;
	Mon, 17 Nov 2025 05:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704B7C4CEF1;
	Mon, 17 Nov 2025 05:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763357361;
	bh=D4C8s3ogFo2WH2UtGwrimNp5R/LGGPPXFVIRCGScgqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+TVnLiWUjTx9G/xv9jPa/6wRSYN+RAE/E8U9ixzlmf5s0PWewG8StAl7iZaE2aNF
	 F7ZLExL4WPhQ3KHQ+11z/HA2wpHemvHL61Ey9sltk1PyayXF2aFHNZMy33Z5nrAxyx
	 YZCej09AWXAkWvoR8S0SHazkYNVhS7Rprmuy0O5xbIvHeP77UzhSpJxnQJkjLkGTRo
	 O4lHEGe2V/YGEQu5dBfEVEkARFoe1C0EXerpT5+UT2Ei4yOO8qBbpe3Wx83X/0Z2Vm
	 s3zpjZJ/Pd3Ka1x8+wfT+Pgwh91ee5SzfOhDqnwmPZ0RcDx39VKerkcHZaklLIGh4l
	 ss+JgwdHdPqqQ==
Date: Mon, 17 Nov 2025 10:59:16 +0530
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: Re: [PATCH v2] tee: qcomtee: initialize result before use in release
 worker
Message-ID: <aRqyrIxcWk8tYYOi@sumit-X1>
References: <20251113-qcom-tee-fix-warning-v2-1-915a460e7d21@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113-qcom-tee-fix-warning-v2-1-915a460e7d21@oss.qualcomm.com>
X-Spamd-Bar: ---
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7257E43125
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[kernel.org:+]
Message-ID-Hash: RI6XFBWKDLZOBEVXHQWHWXXQ56WSGOY4
X-Message-ID-Hash: RI6XFBWKDLZOBEVXHQWHWXXQ56WSGOY4
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RI6XFBWKDLZOBEVXHQWHWXXQ56WSGOY4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Nov 13, 2025 at 07:38:42PM -0800, Amirreza Zarrabi wrote:
> Initialize result to 0 so the error path doesn't read it
> uninitialized when the invoke fails. Fixes a Smatch warning.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/op-tee/7c1e0de2-7d42-4c6b-92fe-0e4fe5d650b5@oss.qualcomm.com/
> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
> Changes in v2:
> - Update subject to tee: qcomtee:.
> - Link to v1: https://lore.kernel.org/r/20251110-qcom-tee-fix-warning-v1-1-d962f99f385d@oss.qualcomm.com
> ---
>  drivers/tee/qcomtee/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
> index b6715ada7700..ecd04403591c 100644
> --- a/drivers/tee/qcomtee/core.c
> +++ b/drivers/tee/qcomtee/core.c
> @@ -82,7 +82,7 @@ static void qcomtee_do_release_qtee_object(struct work_struct *work)
>  {
>  	struct qcomtee_object *object;
>  	struct qcomtee *qcomtee;
> -	int ret, result;
> +	int ret, result = 0;
>  
>  	/* RELEASE does not require any argument. */
>  	struct qcomtee_arg args[] = { { .type = QCOMTEE_ARG_TYPE_INV } };
> 
> ---
> base-commit: ab40c92c74c6b0c611c89516794502b3a3173966
> change-id: 20251110-qcom-tee-fix-warning-3d58d74a22d8
> 
> Best regards,
> -- 
> Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> 
