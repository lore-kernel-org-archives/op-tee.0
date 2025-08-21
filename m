Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4BDCA0EEB
	for <op-tee@archiver.kernel.org>; Thu, 21 Aug 2025 03:23:12 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8F9AA4FB8E
	for <op-tee@archiver.kernel.org>; Thu, 21 Aug 2025 03:23:11 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yoGmijxh;
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9A28542DDF
	for <op-tee@lists.trustedfirmware.org>; Thu, 21 Aug 2025 03:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=VMXZvWdTxmpFtlVQ9jlbQoJIR5oaIbYtP1S8SHubNqQ=; b=yoGmijxhHu+wEGIhK6HrD097at
	6cMBFlz8C8WVswT3oLGSdlC5KkEc0GJEgqJwbV8yzsQpRCMqZWEH7cYmoXwKbA9+97QaXBfzNzVVA
	rPsxXlHDomjMQsPBHw57yLen1Wa6o9YiIhAGdncGVYxeRxwyKMeyaYqd6WJ23oX0YvMLIDlWDw6FH
	/c1Hx7P/HcqKDcDf068VRYtA+YALxUoTHnHjXbOkO+vJ3SrLCBi4CqU8nRMMKu5JCDwJxkgxnc3A3
	OhVJJo3UNzlzAs8juRI10/qO5MWvTRtl8REiq3Pt9PVi9WzraKdDI4GqpO3hfo8qqdOV9Qtl6U1qQ
	Qwr6krsQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uovt7-0000000FcTp-3v7h;
	Thu, 21 Aug 2025 03:22:53 +0000
Message-ID: <74ba8f4e-1ccd-4962-bb5e-48a9157da952@infradead.org>
Date: Wed, 20 Aug 2025 20:22:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/11] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
 <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-4-7066680f138a@oss.qualcomm.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-4-7066680f138a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9A28542DDF
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.10 / 15.00];
	DWL_DNSWL_MED(-2.00)[infradead.org:dkim];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	BAYES_HAM(-0.30)[75.02%];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	RCVD_IN_DNSWL_MED(-0.20)[198.137.202.133:from];
	ONCE_RECEIVED(0.20)[];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:7247, ipnet:198.137.202.0/24, country:US];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[infradead.org];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	R_SPF_NA(0.00)[no SPF record];
	DKIM_TRACE(0.00)[infradead.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: ANSIADYPAMUGOXCO5GAMZBVNXTOC6NAI
X-Message-ID-Hash: ANSIADYPAMUGOXCO5GAMZBVNXTOC6NAI
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ANSIADYPAMUGOXCO5GAMZBVNXTOC6NAI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>



On 8/20/25 4:38 PM, Amirreza Zarrabi wrote:
> +/**
> + * struct tee_ioctl_invoke_func_arg - Invokes an object in a Trusted Application
> + * @id:		[in] Object id
> + * @op:		[in] Object operation, specific to the object
> + * @ret:	[out] return value
> + * @num_params	[in] number of parameters following this struct

Missing colon (':') above:
    * @num_params:

> + */
> +struct tee_ioctl_object_invoke_arg {
> +	__u64 id;
> +	__u32 op;
> +	__u32 ret;
> +	__u32 num_params;
> +	/* num_params tells the actual number of element in params */
> +	struct tee_ioctl_param params[];
> +};

-- 
~Randy

