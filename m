Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD5DCAC5B0
	for <op-tee@archiver.kernel.org>; Fri,  3 Oct 2025 11:00:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 086F6431E3
	for <op-tee@archiver.kernel.org>; Fri,  3 Oct 2025 11:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1759489219;
	bh=tlBfIJ4kKHSYUsLvlHhOT3lJHNHmcihujd8G8HIpOeE=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=2ybh9DDa1LY55Rn1jLGzH5U0Ykmlzz5Zn2+Ht1e4qK9T5Hq2hjoDTYnQ8Jgmq9oXX
	 JIXq/9m8qfaF4t98CLsta04qUO1zKIw+P9ktawlUinW2b1PeXRA9wFM0OvuzYM/Dyu
	 zyEmwSrFDJZSAqLZ8PrM/8uUcWm2ZF4iMMZzWlJnbjEJH4aWvjtSK7Mbq3ywqK7gaa
	 EZAS3H/SSLtNOwA8J8NdXCuPtOFC0yF7PdfDSXDYNZZuQgFf50EGIW7SdodQNJVe6C
	 wb50Ews+mUD4FrWx7zT7pq6Z38NGod/RhLjvtV0jR05b3WbrM/KB0RAu7bGy/aBTuE
	 l05FSXT6EptPg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 812EA41835
	for <op-tee@lists.trustedfirmware.org>; Fri,  3 Oct 2025 11:00:03 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KC5VD2U6;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592Lm5YY000852
	for <op-tee@lists.trustedfirmware.org>; Fri, 3 Oct 2025 11:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IEL92hzHLBUavfnk9rk3tHYX29lhg6slFzQWbOYem5g=; b=KC5VD2U6j73RFZkz
	wVzeYFX+QcSxmEGxfkK0oxOotmKZmo8gPR2QlexVviUpDFwAPhN0VN3NMgv/uPlb
	pEI/wwyIyLqsPstadYdQZSH2melVuke0kE7bF5xZk9YCknnmkNnsLYlogK4/Pb9M
	e00jIwuK4cay3zPrltsE2OrlxLMR9yrC77glEHGOY7ivkIcJmxPks2FZwI8vqqI3
	eyAuRecEw43nN+fNTO/Gr4Vkh7X0VmvDaNVkhLO88IsGiluKsA6Q8Emi68AWN2Gz
	CVplbc3WWfhRZULcTs8FkofoKJrpsCpzb7ymCOYkxgjfCWDtJ1FYR0a1XrGdYYn/
	838hjA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x62r23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 03 Oct 2025 11:00:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-269880a7bd9so24299735ad.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 03 Oct 2025 04:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759489201; x=1760094001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IEL92hzHLBUavfnk9rk3tHYX29lhg6slFzQWbOYem5g=;
        b=gmTz4MAAHrLfACkvenMr9vtnqPM6Te61HPGPfVTbsJFPf47Y2USytjAyafZggxP05D
         fISL+TzMa1sE8EwraUy/eWXSnMKaev5jnfh+Q/6CgcYONaQ6MnFxy8dbRGMBY96Zke0j
         lWrbdgT1syjVUuklQlIiTMURzKDbOBpnOCSET9zBQhQcHmx8pZk0TRHhdYb/XjVIvSEp
         5jKWxrNuG6bedxOBnHt+C/AoXgq8oQlJqx8LrHKlZ24r97qPY5pHl1CiI3cZwXExzUHG
         52HKpy6THy8+4buN2t24qOVwkn1u4wOsTYnXBR4MANiQCx5UB80M0LGWgJ2GRtVVArRX
         DvTw==
X-Forwarded-Encrypted: i=1; AJvYcCXjirI95uVSoNCqwlet07arzt8HvBo9FaT/CkJCn2xAQ/dkt4Si2/QxIeuqFhGXi0yTjfz/sbA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzTY/wTnlJnYXT2cqgd3nstL9bmXtR+z1GiTq5ObXL29E3d/Jmt
	R8eYrdvIE3a2CYErcrpsy3GZ6em8nIzLWzCfjqNXnjv9CQFMuCpaCn4meWq5cfBNxeYX1dA6PeL
	ckKsi+PqZiOAZVmo4mTWttGO0TA9lcWG2OhOnzxX21kgrIOIp9W5hVgBRtUCt9tFhYjcPTZGI
X-Gm-Gg: ASbGncuOQQEVLsk/gDQ/VmQN+iBtSY0PavIfOodhZ5hYoXS7CL8jeuaT4E4gO3HeBjv
	u7Z8gtkuGBhTrw+aZh8iYcx8SatmqSizIveee3iGq0oC1gPFmu/9EMr8YhJcG51rgEWuCo5w8N/
	t+qT5eTgQlVl5oqFy4Bz5Rxim2VKRurtzDFgAiauMzKQaJdVEuYAlqacbgeMTUHj37kchGR8S1V
	6lf9Nayfn4QAvlQBeHawrm553+8cFWzFnrACFAMl1WKvJt42mONNZIXwh8shb60yeglKd0hCSBX
	e/tH2xs2x8yflAVG4dPq/NFJlN571JEinxvHPTueuCfpBWeB3cZw13EuoHaNFw+HXwI7RvSD81D
	6lH5we6et2gmP6A==
X-Received: by 2002:a17:902:f612:b0:280:4b60:5570 with SMTP id d9443c01a7336-28e9a65167emr31185875ad.52.1759489201571;
        Fri, 03 Oct 2025 04:00:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1uG5stT/umPWG9p81DrD4oxzCFHq3cshMjhhEawM6kFEF+8bxR0SNY1vqltyP5qOcBaXILA==
X-Received: by 2002:a17:902:f612:b0:280:4b60:5570 with SMTP id d9443c01a7336-28e9a65167emr31185685ad.52.1759489201138;
        Fri, 03 Oct 2025 04:00:01 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1280c9sm47348955ad.53.2025.10.03.03.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 04:00:00 -0700 (PDT)
Message-ID: <f31278b3-9f60-43c7-bfc4-027b24a49854@oss.qualcomm.com>
Date: Fri, 3 Oct 2025 16:29:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: qcom: depend on ARCH_QCOM
To: Peter Robinson <pbrobinson@gmail.com>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
References: <20251003104236.1813979-1-pbrobinson@gmail.com>
Content-Language: en-US
In-Reply-To: <20251003104236.1813979-1-pbrobinson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lJt_Cg1cdw4SLq5PtLEtRt80W_eZUhKt
X-Proofpoint-ORIG-GUID: lJt_Cg1cdw4SLq5PtLEtRt80W_eZUhKt
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68dfacb2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=4n8RpipySPzvTEEXDpEA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfX12lGKmUTiO2+
 rOnobQJ3H3cKaEEC+gVjozy/Z5Vw7mQzGZv9nablwFWBChmSVH6W7ylRadQ0VEgNcEZIgMsZc32
 ybg6OQSbyBS4l2omXVGnxbmG6RRZoF7fafLS3l/VqLERPX6YrQfgejaxwRl4SGzkfWM17QY9y7J
 N8ggcQH8f069sHPYsBdU59bMBgftp9mCeJmAlis8u09ClgCjsLKnsOZGo0oUA3235JxLq5y80Z1
 /9v8PeyGewMctpp0lLXK3luj39MPJzaI0TIobAExyM560rnvyv4sXXtol2l4ivXzN/5QK9WHGqh
 fzCEk3/TAUnhyYGIQko3vQ0JMesZWOmH89XG5KJaF0PoBVSUgWnYj4RwuUj46Whz84VBsQj6sPe
 WYkyfGKub0K0tXX7gxn1nEDe1FTbKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_02,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018
X-Rspamd-Queue-Id: 812EA41835
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.197:received];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,oss.qualcomm.com,linaro.org,kernel.org,vger.kernel.org,lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[202.46.23.19:received];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: OZDTYOHHFXVL7JNJ642DQC4MOBIHAM7M
X-Message-ID-Hash: OZDTYOHHFXVL7JNJ642DQC4MOBIHAM7M
X-MailFrom: kathiravan.thirumoorthy@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OZDTYOHHFXVL7JNJ642DQC4MOBIHAM7M/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kathiravan Thirumoorthy via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>


On 10/3/2025 4:12 PM, Peter Robinson wrote:
> Add a dependency on ARCH_QCOM, and compile test, as the driver
> depnds on QCom specific Trusted Applications (TAs) and it's
> only, currently at least, supported on QCom hardware.


Thanks, but this is already taken care. 
https://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git/commit/?h=next&id=3b63efa21bc6acc1a0fadd1dd0f0e1988a4c0177


>
> Fixes: d6e290837e50f ("tee: add Qualcomm TEE driver")
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>   drivers/tee/qcomtee/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tee/qcomtee/Kconfig b/drivers/tee/qcomtee/Kconfig
> index 927686abceb15..9f19dee08db49 100644
> --- a/drivers/tee/qcomtee/Kconfig
> +++ b/drivers/tee/qcomtee/Kconfig
> @@ -2,6 +2,7 @@
>   # Qualcomm Trusted Execution Environment Configuration
>   config QCOMTEE
>   	tristate "Qualcomm TEE Support"
> +	depends on ARCH_QCOM || COMPILE_TEST
>   	depends on !CPU_BIG_ENDIAN
>   	select QCOM_SCM
>   	select QCOM_TZMEM_MODE_SHMBRIDGE
