Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D327FCAC5A5
	for <op-tee@archiver.kernel.org>; Tue, 23 Sep 2025 22:48:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E969C43153
	for <op-tee@archiver.kernel.org>; Tue, 23 Sep 2025 22:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1758667732;
	bh=KGYrdccxkJWz/NWcgi56AxtyIRez9CZ3n9EqSfyRTOM=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=wA+4NvOewM/uowOg2/pGiYBywaTeVhlGPwhRmzouGRhWXWGTB6FiNrKGJtku51sNr
	 TF/E8cAwHQsdoTMoaOiol/zTvWPWGAbYNvkKhHwXR4iqT4hVDVukexHdaIZ35Op1ll
	 MLviC7zZ0QwxDp7VIW2CUJO5NThvpE3w4mtESe+qoLlA+OHYofHdoWHjrIpuiLE2Iz
	 IFKmgfAsw5p6HetoJ9nVEeI9u5fpwQYQF98zSISwHW56mLZU9HVmpH2+tvciLAX4nQ
	 c4M2ksTMyTrtWSN7MLY05C+nE4Nz4nfAvhM0gSi5wP92FarVnonpPrvx70PXFbljeh
	 +t7ckVxHRi7cw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4ACB3409F8
	for <op-tee@lists.trustedfirmware.org>; Tue, 23 Sep 2025 22:48:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XYjD5ssd;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NFEWbo023873
	for <op-tee@lists.trustedfirmware.org>; Tue, 23 Sep 2025 22:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QhTBs1uXxvVAGkh+Pb8xn+0DsTafgd8f9wM86mvWR0I=; b=XYjD5ssd2TIZMs4b
	KJOVFYCkUg9kb3Bser3VbMMsZsiZBfeTldoEOW3KslMmAg3wLdGmKJaY3J3wHiFG
	kdwytUulDNRhT9w0XqMg24YNnDTurVfRT1P1iyJqlwcsh1j9H/x/ehQLcklcWqjE
	YgYQY7SaBFWUHA0A53LGf0WhJXuZWiRZTIlhT8QmN/i3W7HMmYIo0VWTmfHz1Uv8
	pL6ttTnsUjcfRh9E9k9A7D0eE434QUlReDVv/l1AfenvIyQL9cMpvibRSy+U2wlU
	BSbd9EHSK/5LNTQrI6AtQQJOpvhRjnQPXjwaCphxq/ZhzQteZYZ32aKCqczu29dV
	d13xlA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nye2d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 23 Sep 2025 22:48:36 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-25d21fddb85so104275415ad.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 23 Sep 2025 15:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758667715; x=1759272515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QhTBs1uXxvVAGkh+Pb8xn+0DsTafgd8f9wM86mvWR0I=;
        b=koKtn2jIKkl7+sbGm5IKeKllkN6WmXbIt8HPTUtXUHBdxieJYhmOnjZTmeYNTbqV5H
         X9D7zyxiAeA5IkG65vMrc6sl/cIb5In8/slGrCYd/nYpiuG7q5YwaM7KRyPYAWSO0ye/
         k2W3K7di0s+WigYSdOvw3Lqosp0P8wc8XMgmD1I2u75vEM+HJ4mDw5yrSfxomW4Ps1K4
         1L3xI6fByBiDKl3O529/r0fvB/o7Lqn2anDDfrwwgXeQKd9xme1Lw/vgZQfpjCE2rMR/
         G3UUDb5wCdFX8GByxoViMrk32uI9v10/u0WfF2DANQEU8YXdtVJCPjV9D6fdLV1e6L2w
         KaBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiPgPDRGuaAY7lGlYUfBqqhjhntfcX/kggpomcEPYbejV3L0fdUR361eHlDVZfkYcqGBVd4Gs=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzGWfIUOp66ZzXB+pZQY2QlSWurJWvnX9PYPOqH26aQ/txmbBrc
	nKmE/CXHKTfrUwLUyYefPctppieaTmYdSJMECIu883Q9rNQtsujskDkt9AjxPySdXlM0+HDFtZi
	J+ZR1ydsxvK60Yxzjl1u9ViKcuNoeG4t2+hS2l2K5Hc654ey2b3+eAXhtsv50tSfRLOENodk=
X-Gm-Gg: ASbGncsuMroDqSe6SuN0RQooWUNB4TODGq0gz5bjkJGXDjJFwktA1QaEQ8Z0kvDytQd
	gq4L6pEIjro5RPOjlD+1nSD6YN2yyE+T9OSSbRXaNtFUo8RQN2rKWl9YCjndtPz73mKAAdsfFOm
	nN2G3GFN780SgPJAUbiUVibIWADrCqWMALOqA379etOh5NdyS5oVcEUe1AppdvzgIMCFLPPGPJ2
	m6AYBr8GMdJQN8emE+8ZDUdty3crkiDtUf6pLjreI7Yxl+kLBCb5Lyhfo6C6S7ExlHDH0MaR2jY
	52gNe4BodcPhVXKwy1qAV1uL44vn68WcyPpnt1lzouVS0J0E68GQksmhjIUp9J8nRa3I9Jk2+Km
	LlPBkKwgOlHfWxhkEIOse0cgnw8kXGXyjI+azpA==
X-Received: by 2002:a17:903:32d1:b0:267:e097:7a9c with SMTP id d9443c01a7336-27cc92d6390mr39514795ad.53.1758667715277;
        Tue, 23 Sep 2025 15:48:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOe5Xvqff3pEzpF3RusBgGn/eeG6J9jfCttvo4aiBAfj9fCkj86Q7V5Xt8WKarN6JKSQIm7A==
X-Received: by 2002:a17:903:32d1:b0:267:e097:7a9c with SMTP id d9443c01a7336-27cc92d6390mr39514695ad.53.1758667714901;
        Tue, 23 Sep 2025 15:48:34 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c265sm171438685ad.49.2025.09.23.15.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 15:48:34 -0700 (PDT)
Message-ID: <adbccfc0-0f9c-4b71-9fb5-5582c8180ac7@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 08:48:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] tee: qcom: prevent potential off by one read
To: Dan Carpenter <dan.carpenter@linaro.org>
References: <aMvV4kK386Sni10i@stanley.mountain>
Content-Language: en-US
In-Reply-To: <aMvV4kK386Sni10i@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d323c4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=ok0EKaH7qlBqcbMr71AA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: kthnmxAnPvCiYNmSwVvRIaJPeaoZFpqO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfXy+9poZevV8rW
 cLMS5i49X0eEDLXBSA0q0d7fFTl5I/aNJhJ1PkhtVcfszYxLJhmEun+Vd4e1eUJHRHt2OilLU3q
 R4y2TUihT85hi7CV2z4A5Pt3iw17xiPTQ3if7qbrPfnXW1uV8rO7yDtYGAk9Ih1vQSZHRk0Kpg4
 6G5H5l2yrsMDG7IoE058T23PqCrIVhyhVNkMUBxuZd04ZOAXb6vlKbxNO5RdihRCAw1dd2bLnKI
 rWj0GdMDKO8bbzd17VZldsNkGPeCDynwLEskd6Q8c8kG4MoLrpFwL8ykNxCHrGhIIy58N3Zrmko
 vU/ucaLMhUSsfXeplaH/zkNVrJSQfA/sI1/HwHA+XdNNRXAXOw5wudeKvqw3OFZt0afmuQJSfLz
 fmz19DlW
X-Proofpoint-ORIG-GUID: kthnmxAnPvCiYNmSwVvRIaJPeaoZFpqO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_07,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090
X-Rspamd-Queue-Id: 4ACB3409F8
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.198:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[1.41.240.65:received,205.220.168.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: LY6DEZTOXV4LXRU4DMDSWYU34RNI44SQ
X-Message-ID-Hash: LY6DEZTOXV4LXRU4DMDSWYU34RNI44SQ
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LY6DEZTOXV4LXRU4DMDSWYU34RNI44SQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

On 9/18/2025 7:50 PM, Dan Carpenter wrote:
> Re-order these checks to check if "i" is a valid array index before using
> it.  This prevents a potential off by one read access.
> 
> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/tee/qcomtee/call.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> index cc17a48d0ab7..ac134452cc9c 100644
> --- a/drivers/tee/qcomtee/call.c
> +++ b/drivers/tee/qcomtee/call.c
> @@ -308,7 +308,7 @@ static int qcomtee_params_from_args(struct tee_param *params,
>  	}
>  
>  	/* Release any IO and OO objects not processed. */
> -	for (; u[i].type && i < num_params; i++) {
> +	for (; i < num_params && u[i].type; i++) {
>  		if (u[i].type == QCOMTEE_ARG_TYPE_OO ||
>  		    u[i].type == QCOMTEE_ARG_TYPE_IO)
>  			qcomtee_object_put(u[i].o);

This is not required, considering the sequence of clean up, this
would never happen. `i` at least have been accessed once in the
switch above.

Regards,
Amir


