Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3468C55822
	for <op-tee@archiver.kernel.org>; Tue,  4 Aug 2026 04:30:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1EC1E43ED1
	for <op-tee@archiver.kernel.org>; Tue,  4 Aug 2026 04:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1785817808;
	bh=qMoQOUd6RllASsHgB+CvzuymSNu1GngPZDEh2pZ29GM=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=wR0BWyRDTEvAR1VUZrGo60M2x8PF6r7mU7x6YXquQOdN+DT/CkA21fIgH7ayaWDEG
	 fL5EdSU4Oj9eZiZZtE/UTLETNEpVlwwpZFw0ffL0LuaqqjdYOG0D+ueKDngXn4GF2V
	 +3/bXXHMpsOVm9Fne2t7OauQqvrUH/D+2eEOlrVO8Mo9npkmfOpJyYgvYhJbkIs+px
	 i7fVtH+GlWOxHiLoiN651u5wU9uX0r4TNNXuaWJVjrjQAjHcTT/hENS25GdisEKWF7
	 mlZTJ3+iSNfWi+taRd4a3OJ/LeWuPAX5aNAbdzuUPNvFKJkV4MtU5OFOMu6qsKg2bF
	 7CXxCBaLB29hQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 949D143ED1
	for <op-tee@lists.trustedfirmware.org>; Tue,  4 Aug 2026 04:30:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bq+BQwCQ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=daOybwjk;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741853g2353369
	for <op-tee@lists.trustedfirmware.org>; Tue, 4 Aug 2026 04:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VfrYsc6RU2I/c+tuyid9lRUJCjOygwXHS3YpnCC4TT0=; b=bq+BQwCQtb3wiLtn
	eLEDQ7LnWkbMAswB/LGIszI2TBaxxKPCNsnc82yVRu6Bvjgget5SNIOIbTZKTo33
	aA+rhSfLX5lEbjXs+31Cki33NjmODHkG7Uy45bE73KTxSMCG0RLchBor2kRla9Ap
	Y0lIOHeBsAIk2Ql6LHjZ6xg6tG4Utf8/QuJpleSXFtvEe25awOKAzyJfpC8NjYWW
	unKWKfzUSAKxPRrGjqpGkoZ8LW9JGgy6GIsM3GuEcHU4z3ei9oxKzS5ryuMJwYvq
	5bDztdB0OFHcvdQNkaDNAG31VQs+mjlzKxUSYJm+uTQIY6tSjcRQqmH6w9OBphzd
	lILolQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu1p89pbq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 04 Aug 2026 04:30:01 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84a3514f912so7527159b3a.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 03 Aug 2026 21:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785817801; x=1786422601; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VfrYsc6RU2I/c+tuyid9lRUJCjOygwXHS3YpnCC4TT0=;
        b=daOybwjk3hWSwM6fQMJzwG6q6rL1SFLQyOWhjacEnWVz3ZBl1lYuAuuiyd+3olqs6T
         v6OODrYcEB0Cef1ZRyYTqqVfWDd3TzGnqbzxFC2B+qOK9PyXb1ALVptYDo9Ay4Bp0KCB
         sZTEm5a6+BUZcBZBGYo8S37/ClT/yTwK/+7AO06rIg1HXDO89jCqnzRcoBSQaEdXDYqe
         ll+lDwkhpTXN7aJWw4xwJ4Di4YZqYuU2+9BKbAxItiUUzFT46JGXW/4P0hOSbQXjKIa5
         jh+GxmGucGirUZ4/HSbZdNaK3lkyskW8oK9Grrj6CTWvrsSKbLxhBiGqjE1nsFKutIVj
         a5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785817801; x=1786422601;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VfrYsc6RU2I/c+tuyid9lRUJCjOygwXHS3YpnCC4TT0=;
        b=cjamMKLe34u9Hep2/QRpqLf1KG/mqAvD8BKyeN/F/0XkmRF5sLikuuAgDGRxqvZbhG
         +AxI8qGBNsLJf48ATRKcZhrN2Iyr856PAMFkByaPj9ghDhmCeZlGO675oIvHy9j4oa2o
         NmI46Ws5VD5vmx5EWgJHSvQAWnCJC0zcg9l1oauoZht2g7n5zZCkwwfgg/hqo50OtgZ8
         O6ig6MEvzqj9cZul9s0AzkEPtgzyaQCcN+OCJE7D1ab3oN0NZqYNY7qX7QSQkbJ8HkDE
         13kyoOA/pRftrsx/L1eNUGGwNYKBWvd66EajZTtlERqHOgQLUW6c18fd4Q+Q06yzQqPx
         O4ZQ==
X-Forwarded-Encrypted: i=1; AHgh+RoNKMY67tsDBLx4MvJ4Rv9woBBzcIeVcq/ITj0fOx/IUjAjEI9q8VyRkJWs7RrJSUImEYQJLJw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy4SAKC9pQgCw1a54b/a3LQ4F2pQjRSm6u5wAoI0vaSWTXlJWR2
	3gBPGG9Gk5n3s5sbIEI6ofhbnYJ8nWeiJ9PY5K+AMi5kV0aHzrHj+21JQGJYEsolPJAwbUkuVkB
	qDll48aThFVVammjkKlmmyBaKVCg0ap0tJmP//A7m3JN7h4hdYH8xxvWJVi/MfNV2FikVoAU=
X-Gm-Gg: AR+sD12zn2nRvx+1/u6x1f7xlwzqGvNAXJBsTMamc3hyt4JqxpdZNESdvsbbHsMV/mK
	rVfvPZZCEeOAeswujB7T6Beda1NVIXiKZ7ewLxI3Ie7vNz8z4D3/9mFliTLvWS7Ao/36+PdetCX
	rGJxEHNOoR2t+6thFt7TEZFQZ4Kyi0FmGF0s5bmppAX015/kM1S6An7f94V54UEW7NRstj51AXI
	rExnwzX8rwJhYiFZ48XxGhM0FCOmzvbtsaTN9Ze9tMhPCUcN8bzQ/f0ZI+gLZwoQYnTybEXIdUk
	8oOASE1fOtFVSBQxvf4k9ZdHXqnVsaEQj/LeW7S89AXfMquf2TQzUnS3fjnOzxP8i+ktVDalVrq
	O2yL73xYe1SOLC5vKB7OjaAu2zxHJioTxDQ==
X-Received: by 2002:a05:6a00:1906:b0:84e:5e0:9db6 with SMTP id d2e1a72fcca58-84ee48a4cf7mr10990824b3a.40.1785817800891;
        Mon, 03 Aug 2026 21:30:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:1906:b0:84e:5e0:9db6 with SMTP id d2e1a72fcca58-84ee48a4cf7mr10990797b3a.40.1785817800371;
        Mon, 03 Aug 2026 21:30:00 -0700 (PDT)
Received: from [192.168.1.86] ([206.83.118.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbd3159bsm4569664b3a.7.2026.08.03.21.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 21:29:59 -0700 (PDT)
Message-ID: <63cfff1e-359b-4db9-97a8-43d97abb0369@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 14:29:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tee: remove TZMEM_MODE_GENERIC
To: Julian Braha <julianbraha@gmail.com>, jenswi@kernel.org
References: <20260729203845.387239-1-julianbraha@gmail.com>
Content-Language: en-US
In-Reply-To: <20260729203845.387239-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=A5xc+aWG c=1 sm=1 tr=0 ts=6a716ac9 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=P7rZ2Udeej982rJtnmwBRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EZfUo5YVX42GmVgghzkA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDAzMiBTYWx0ZWRfXyZ6KLzPOIp2j
 C4oqSKfRK61Sids3J399ILQ1dlhoN5Hz0yx4IVDmilQU/3dPSq2hXh7dSQ0Zc1GrU1tJeGsjYjM
 ogWQnD1rYxC9Es4MWLvm1NwO+VzMvlI54SCW4bDUt7gYjBHEGnou5MDESNBsrLKrWgGfKcC/xu6
 5FBRi4n7udWtmLg6UimldD13J2zfElBjj9Or5e17Qd56SfeN4kG5v8PREwTRN2+H3xA5MaQBplm
 EQNnS8RQ8445FS0hIn83KBsYu+VWr8XGj/8sjNDytys47aW18oTz+GXgb3D9LPBVQ6aSrab8Rsj
 ptoDw1Mg42Y26onAp2oK+0RdXUJwuAeaccn4JBICjxcjcyY+tNnURKnVQDWI6Eys1M/jMN3f/PE
 GOhvUm4t0AKcnBZBC3DueXKrV66/Srr4v+7xFfPC0643m6/fwCb9pM3j3Rklr0i62UVy02uYMRM
 ZF1et3vCtv0u8t5zNjg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDAzMiBTYWx0ZWRfX65+dRGU6hbsG
 R74mSTmTOMawwrGLj0PToKeZh3XMQmklKFkz/7NVHvuOi04PeD2dWE6i8wuYhyVUxa9I8qMtDYz
 Fa+HvxaCnWD9iqb3EmIG+A5zsMVZ5+E=
X-Proofpoint-ORIG-GUID: 5c2uZPYZxDWPJyBzlwugpkW8_opfjl3V
X-Proofpoint-GUID: 5c2uZPYZxDWPJyBzlwugpkW8_opfjl3V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040032
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.200:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 949D143ED1
X-Spamd-Bar: ----
Message-ID-Hash: KYRX6V2LSBH7ISPONSR6E3J7VNLN6D56
X-Message-ID-Hash: KYRX6V2LSBH7ISPONSR6E3J7VNLN6D56
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: sumit.garg@kernel.org, arnd@arndb.de, geert+renesas@glider.be, amirreza.zarrabi@oss.qualcomm.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, quic_eberman@quicinc.com, andersson@kernel.org, brgl@kernel.org, harshal.dev@oss.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KYRX6V2LSBH7ISPONSR6E3J7VNLN6D56/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi Julian,

With this change, is QCOM_TZMEM_MODE_SHMBRIDGE still needed?

I think QCOM_TZMEM_MODE_SHMBRIDGE can therefore be removed entirely,
along with the conditional declarations and stubs in qcom_tzmem.h and
the corresponding select in the qcomtee Kconfig.

Regards,
Amir

On 7/30/2026 6:38 AM, Julian Braha wrote:
> 'select' does not work on config options in a 'choice', so currently it is
> possible to enable QCOMTEE without QCOM_TZMEM_MODE_SHMBRIDGE, even though
> this is needed at runtime.
> 
> There are no users of the generic allocator option,
> QCOM_TZMEM_MODE_GENERIC, so let's remove it. Then, we can remove the
> containing choice..endchoice, which allows the 'select' to work as
> intended.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
> Changes since v1:
> - remove TZMEM_MODE_GENERIC instead of removing the dead select
> 
> Link:
> https://lore.kernel.org/all/20260715092539.18384-1-julianbraha@gmail.com/
> ---
>  drivers/firmware/qcom/Kconfig      | 26 +++++---------------------
>  drivers/firmware/qcom/qcom_tzmem.c | 21 ---------------------
>  2 files changed, 5 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index c7f8413ab996..d99e09c5fa18 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -34,33 +34,17 @@ config QCOM_TZMEM
>  	tristate
>  	select GENERIC_ALLOCATOR
>  
> -choice
> -	prompt "TrustZone interface memory allocator mode"
> -	depends on QCOM_TZMEM
> -	default QCOM_TZMEM_MODE_GENERIC
> -	help
> -	  Selects the mode of the memory allocator providing memory buffers of
> -	  suitable format for sharing with the TrustZone. If in doubt, select
> -	  'Generic'.
> -
> -config QCOM_TZMEM_MODE_GENERIC
> -	bool "Generic"
> -	help
> -	  Use the generic allocator mode. The memory is page-aligned, non-cachable
> -	  and physically contiguous.
> -
>  config QCOM_TZMEM_MODE_SHMBRIDGE
> -	bool "SHM Bridge"
> +	bool "TrustZone interface memory allocator: SHM Bridge"
> +	depends on QCOM_TZMEM
>  	help
> -	  Use Qualcomm Shared Memory Bridge. The memory has the same alignment as
> -	  in the 'Generic' allocator but is also explicitly marked as an SHM Bridge
> -	  buffer.
> +	  Use Qualcomm Shared Memory Bridge as memory allocator. The memory has the
> +	  same alignment as in the 'Generic' allocator but is also explicitly marked
> +	  as an SHM Bridge buffer.
>  
>  	  With this selected, all buffers passed to the TrustZone must be allocated
>  	  using the TZMem allocator or else the TrustZone will refuse to use them.
>  
> -endchoice
> -
>  config QCOM_QSEECOM
>  	bool "Qualcomm QSEECOM interface driver"
>  	depends on QCOM_SCM=y
> diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
> index 0635cbeacfc8..5b3e5a3ad1ae 100644
> --- a/drivers/firmware/qcom/qcom_tzmem.c
> +++ b/drivers/firmware/qcom/qcom_tzmem.c
> @@ -49,25 +49,6 @@ static struct device *qcom_tzmem_dev;
>  static RADIX_TREE(qcom_tzmem_chunks, GFP_ATOMIC);
>  static DEFINE_SPINLOCK(qcom_tzmem_chunks_lock);
>  
> -#if IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_GENERIC)
> -
> -static int qcom_tzmem_init(void)
> -{
> -	return 0;
> -}
> -
> -static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
> -{
> -	return 0;
> -}
> -
> -static void qcom_tzmem_cleanup_area(struct qcom_tzmem_area *area)
> -{
> -
> -}
> -
> -#elif IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE)
> -
>  #include <linux/firmware/qcom/qcom_scm.h>
>  #include <linux/of.h>
>  
> @@ -189,8 +170,6 @@ static void qcom_tzmem_cleanup_area(struct qcom_tzmem_area *area)
>  	kfree(handle);
>  }
>  
> -#endif /* CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE */
> -
>  static int qcom_tzmem_pool_add_memory(struct qcom_tzmem_pool *pool,
>  				      size_t size, gfp_t gfp)
>  {

