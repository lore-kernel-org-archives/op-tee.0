Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63180C61CE7
	for <op-tee@archiver.kernel.org>; Wed, 11 Jun 2025 13:03:13 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 91E16413F6
	for <op-tee@archiver.kernel.org>; Wed, 11 Jun 2025 13:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1749646992;
	bh=GWYTVxKC93YJVMhVzanm/CX1o4JT55CaAW87EgvJi2k=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=yjkdtM6mpLobSSFTJp5EH7cuYI8yNZrfXP7abFj/tr/30rKjsb/efUneJKQe4NYYq
	 iYlm4mWQ5xwYis+xF2MvpOeWk0n8aoJCJ8kwgRwuSHQOt88oRlbsuoGzSupOFphK1X
	 c75EYEdVjEoRgRbHK5PmU8AfFB3fm7fQkdAMSBNzfEIkmxRJ1ULJAooQrEAGfRqAng
	 A46kQjeokQbNsbFfSuvBnn0Rf1fMNEQAp7p9cvlaET77A3wRL/sqbSCooWIC53ITpv
	 c55BbYnO/yuPZPYs/6V7etWzEb/GhCGz59YYWebRHsQS87ZFiKxzQMvkGcldjmvRrj
	 AwzBCeGN2rFvg==
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CBE4B3F5BF
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Jun 2025 13:02:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hG2DfL5J;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A1B61A4E5E3;
	Wed, 11 Jun 2025 13:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C76C4CEEE;
	Wed, 11 Jun 2025 13:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749646972;
	bh=GWYTVxKC93YJVMhVzanm/CX1o4JT55CaAW87EgvJi2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hG2DfL5JR+8qDvnZmSLi/lKndMr1EnbHqsT75jBCcqxPrs46YBWQs78lBKvfIE+aC
	 Ft54mn2k1z/VL94FG/gGRpAFTrRaNC2WrIJddrIdSTxXBdhZ11poBFM5GyIKizdlje
	 XLei3+O+DuE8lYoCRgHIF7PTD81y3M8EX7/gvgRuJe7aWmOSpRkCP450dZW1rVp1Z+
	 271mRK0wm/Wxo+Pbymb6PpDzhp7/YZF5km8FQlnR2xbYKftcYV784uiCDkHso6pVrU
	 yVZ1Vy0MKOlQ4a+FR2WvVC+7/32bydLAzh0g3S0E3MX5pQZwhALd++Sh1U+r04u37P
	 Y8AgWtX7mANzQ==
Date: Wed, 11 Jun 2025 18:32:43 +0530
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: Re: [PATCH v5 05/12] tee: increase TEE_MAX_ARG_SIZE to 4096
Message-ID: <aEl-c-eoezGYKOpE@sumit-X1>
References: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com>
 <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-5-024e3221b0b9@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-5-024e3221b0b9@oss.qualcomm.com>
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:147.75.193.91];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	RCVD_IN_DNSWL_MED(-0.20)[147.75.193.91:from];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:54825, ipnet:147.75.192.0/21, country:US];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CBE4B3F5BF
Message-ID-Hash: S4X54JGUFCC25JMOIYQVS4JBSMS6PYRX
X-Message-ID-Hash: S4X54JGUFCC25JMOIYQVS4JBSMS6PYRX
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/S4X54JGUFCC25JMOIYQVS4JBSMS6PYRX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Mon, May 26, 2025 at 11:56:50PM -0700, Amirreza Zarrabi wrote:
> Increase TEE_MAX_ARG_SIZE to accommodate worst-case scenarios where
> additional buffer space is required to pass all arguments to TEE.
> This change is necessary for upcoming support for Qualcomm TEE, which
> requires a larger buffer for argument marshaling.
> 
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
>  include/uapi/linux/tee.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
> index 441d97add53f..71a365afb89b 100644
> --- a/include/uapi/linux/tee.h
> +++ b/include/uapi/linux/tee.h
> @@ -42,7 +42,7 @@
>  #define TEE_IOC_MAGIC	0xa4
>  #define TEE_IOC_BASE	0
>  
> -#define TEE_MAX_ARG_SIZE	1024
> +#define TEE_MAX_ARG_SIZE	4096
>  
>  #define TEE_GEN_CAP_GP		(1 << 0)/* GlobalPlatform compliant TEE */
>  #define TEE_GEN_CAP_PRIVILEGED	(1 << 1)/* Privileged device (for supplicant) */
> 
> -- 
> 2.34.1
> 
> 
