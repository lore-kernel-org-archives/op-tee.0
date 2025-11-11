Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CE7CCFA18
	for <op-tee@archiver.kernel.org>; Tue, 11 Nov 2025 06:48:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5D3E64FFA7
	for <op-tee@archiver.kernel.org>; Tue, 11 Nov 2025 06:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1762843722;
	bh=4C+8EMRFGmXN/EmKCh7BiBdlTLO4aRcFjnZETh4+L/E=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=HUWPf/bzxWxG/x0hbCirVD2Q0pAtlIacdiutnS4pQOTP6zdia7Hbqz5MsAMt/t15b
	 +5rCTLNwmyVctnN3AmsOa/kYe/bXpLiwgoaxyLscw10yaXQMje1gwthWjiHXKWHopv
	 fKQidq3JyiGDszxd0BZNyLytfW4oVXVWpKdWET0/7YLvHtn43TmMWUU+FW294ID5TD
	 bafHJgUc06ZvQ2I9aWR2IDFKh0N1AXR4mMXRKSNlDT5l5flKUkpAbYelnnkknUy7ge
	 FtxqzjFv454o1ZLTtlR7b0c+f0BLfRq4Wd7Q2w+/LJLGo0na1W7Z1L+lId1oSYQBW0
	 jewxi4SNLBLdw==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 63F7141B95
	for <op-tee@lists.trustedfirmware.org>; Tue, 11 Nov 2025 06:48:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=c/9Z695/;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AB2E641A56;
	Tue, 11 Nov 2025 06:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC60C2BC86;
	Tue, 11 Nov 2025 06:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762843712;
	bh=4C+8EMRFGmXN/EmKCh7BiBdlTLO4aRcFjnZETh4+L/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/9Z695/h1Vh7gGYly5hPNWqg/W3FL8CFYgcouYTeOl1uNNVl88vpEKBfSqjy6JA4
	 HLLu3zJbFofCfhdBlWnQ+LOHdvbrt/dWdlHDyOkTyE4wQfiIHttCEzyn4xxiu53+9t
	 JrgveJWztbYbfuhf7EsHXzoAUXdVzsIAaCdnb3oU8SR8CyNj/RIitTSaCcXYzxJ48z
	 HlWh5VSu/Zn7bkpeCjcdtzFNgx1PbXxiRHxMmXPfP5aE+Wgk/H+Jz1PyYrBIDH4/d6
	 gIvFTx40CvpcJDlH2wXMGXtJeLbYj5oW0PeaUaIjEu3+ooHRAL5mVdm/CTPZtVzTy2
	 gzTky+hylRsUw==
Date: Tue, 11 Nov 2025 12:18:27 +0530
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: Re: [PATCH] tee: qcom: initialize result before use in release worker
Message-ID: <aRLcO7dveqChPNb0@sumit-X1>
References: <20251110-qcom-tee-fix-warning-v1-1-d962f99f385d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-qcom-tee-fix-warning-v1-1-d962f99f385d@oss.qualcomm.com>
X-Spamd-Bar: -----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 63F7141B95
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[kernel.org:+]
Message-ID-Hash: LSQ63N62K5DZ2R5SURA65YOAZ3HWQSDC
X-Message-ID-Hash: LSQ63N62K5DZ2R5SURA65YOAZ3HWQSDC
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LSQ63N62K5DZ2R5SURA65YOAZ3HWQSDC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Mon, Nov 10, 2025 at 01:28:32PM -0800, Amirreza Zarrabi wrote:

For the subject prefix lets try to follow the directory structure:

tee: qcomtee: ...

> Initialize result to 0 so the error path doesn't read it
> uninitialized when the invoke fails. Fixes a Smatch warning.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/op-tee/7c1e0de2-7d42-4c6b-92fe-0e4fe5d650b5@oss.qualcomm.com/
> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
>  drivers/tee/qcomtee/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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

The change looks fine to me.

-Sumit

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
