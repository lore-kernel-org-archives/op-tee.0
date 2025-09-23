Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2ADACAC5A5
	for <op-tee@archiver.kernel.org>; Tue, 23 Sep 2025 22:59:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0D97A409F8
	for <op-tee@archiver.kernel.org>; Tue, 23 Sep 2025 22:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1758668348;
	bh=jJCqJvo9Wg7KsNH+Nl6zXRZB5rkkcGtreL82+aY3PHI=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=uRmQFja+c5pWdSGFhXiex+ijHksqaP8swmqyTx2TpwVTrXSJaAJqx0SpIjYD6SGBi
	 pt8MsNJ01QBkLrQzudifoPGs3X79xt4fXdLp97uvDhIMgPAC3am4QvGoWzAbTGBKM2
	 ffE2sjhsNbnNJmUcuYdMy6HEAxGC/XT9cZv9GaGQ+hFs2r5a059lCG4CQmRzM5iTY6
	 AIiqNBEz+Oteeyg2H85/ODzvStFGnXUYz/yOgzCwP69c75ndWEeLS2mRafAXQaxh9I
	 VSgeK0H9vMGQlwfN/idif8dqdHrsWrTBJfmaVyMao2saHptl/Ayr3I23hJ5Vtr/jB8
	 TFXop2PWvKlNg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6F303409F8
	for <op-tee@lists.trustedfirmware.org>; Tue, 23 Sep 2025 22:58:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WcQai+j0;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NEpKea014298
	for <op-tee@lists.trustedfirmware.org>; Tue, 23 Sep 2025 22:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lmv3cG7vx0Ui6SQJVFVyi0/fmzwzzBeQW90PDkfU/OA=; b=WcQai+j0BCi8zFxi
	lUVpKNh8+whPNoxfUZKF6x6lfpg19BQSRbU+VGCMcLb9Iec0kDt6x0eIj3ahlrO6
	5OGA4AJ0dlpJ4ej5W3PUBYp+2z88ocBM8qvTuR34paxqWwilZPS/Wp+2La2o3EYT
	xKQ37A9vxiBACXVEazlnCy0+qr2Xh7NtSvk0Y76r2E1YXaQYYSyOmcdfgoDG24HD
	pXho47cy1yEI+m7ZYSERv3BgAb8sWOFD8g4/0qOI4e2t2WmDeAqzEdp+/E68pH+2
	hA80bK8SnWXSniCRgZLx6yi9QE2Cp574dc1yfFk0L5i5inHdQWS4vDKHhlg14XJ5
	YUnHiA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp09a35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 23 Sep 2025 22:58:52 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77f5e6a324fso1302354b3a.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 23 Sep 2025 15:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758668331; x=1759273131;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lmv3cG7vx0Ui6SQJVFVyi0/fmzwzzBeQW90PDkfU/OA=;
        b=OKilLk70G3bVPQ5MTxT5ZAsafcsuMjc0fNkziWdGnGFE/C2RO9hQrW+TSEbnLstJQL
         k6OX5W0RskvFHn9PGbbluTx1WbmdRrwj/9tkltmCHUwA+CGRdvpH7IgrIih7l4adPWEP
         xxY0EpwcKsSKF82YvQrfeYTx1tzwIY+5E/GkgWKrF8b+XYU3VoXJBJA9qXKkVKSkZwWs
         TrWukAB7nSTHptfvwZSbCSxaakSBu/Ac9jtuZr4YghoFrxPnH0iYaN/3Owb2MJWHxZVG
         rULdhciJjyX8rxli7Gr0tV5NYmTSBaq5TcpMJBCw8pXC9k3iNJUeQxyBm0w3xVhjfW+0
         ykTA==
X-Forwarded-Encrypted: i=1; AJvYcCXPzfQbPv+2kmzeg9HucXPGZqaous/tRzUp1fkyxxtSbe3zE7vgn8ivbdfZ/6nWSSSW2GkeCJU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxAA8qop7NP/X7cJ8P+s2OypsfbInWnAOygPrYKw7ztybUoSq0M
	opJAhqzxNf3kjKdKYDvMtc9nN9zFfSTKgd5xKmRiTT8Syp046Ca1ar3/OWaUoClUgntNSf/3Qjy
	UxHFbZYQH8tvcMTF+geE9qKpJa8RQ1f7RV8wcs0snhKMsN6ocAYEEly5TrYse+uycFzskH9xv6J
	72bpg=
X-Gm-Gg: ASbGncun5xM92qwWExE5zvhz0o3GGyApoNs+xn07XkguqojtE1TXTGZ3xtfMGZ+Uk7s
	Mnbr9ENjEIVxoOMgsyEbC/Cd+QcpgiOMo7rKhdLvyGmp0fmSo1skkH5ZbMNm5E1EjnnnczyNGH2
	1Fs7m+x2NVZcQyQPewxjUMDw8/ljQnVBugWtHqo0eQvZzrebz55tQDTc/qF8Bkv47PeXfwzA1Er
	lMjcDe2rXnonR8NPuwPPSVwuCtcUCmGtwM1q5ElN23WtRCZJwzUnxSEDmtl8z1RCxLgcxJNBvJz
	kZKHvDMWNiaOG6RmztLlK2QYADdUHGVGHswxEjGy1HQHteIOCUMW7LBBk7vAOwZjWss24idxDnh
	z8+fJ053CJ90jTWsovHzjPqQWBwzYMv/S+2fB/g==
X-Received: by 2002:a05:6a00:2e1f:b0:77f:2de7:eef3 with SMTP id d2e1a72fcca58-77f53897e35mr4420495b3a.5.1758668331360;
        Tue, 23 Sep 2025 15:58:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjDeSBvGVZUvhY8zB60DnQEjp9FD0V/JdWnCIwcciYRqCGw1BY9RbrvCylUoL7xIUUp1UWmw==
X-Received: by 2002:a05:6a00:2e1f:b0:77f:2de7:eef3 with SMTP id d2e1a72fcca58-77f53897e35mr4420479b3a.5.1758668330964;
        Tue, 23 Sep 2025 15:58:50 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfec40263sm16712568b3a.80.2025.09.23.15.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 15:58:50 -0700 (PDT)
Message-ID: <bb776102-310b-4a84-943a-86d4138592d8@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 08:58:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] tee: qcom: prevent potential off by one read
To: Dan Carpenter <dan.carpenter@linaro.org>
References: <aMvV4kK386Sni10i@stanley.mountain>
 <adbccfc0-0f9c-4b71-9fb5-5582c8180ac7@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <adbccfc0-0f9c-4b71-9fb5-5582c8180ac7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d3262c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=mbIkYJv0h8CN-5O4jtMA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: aEOe1zpahGDBuZfBTNhJLo_TCLsqA4g4
X-Proofpoint-ORIG-GUID: aEOe1zpahGDBuZfBTNhJLo_TCLsqA4g4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX/vmqtLIkfhkP
 paMrfRJcFAr/l5dPv/PXu8vWWOmfGftNUahOeRfeeCQHclcZxNzolryMpAMLK3dCHSCp+WOd3WR
 TdEtojSzGvnaIp27wIZwGoWsR2OaiqS9G+DDvomj7XRZWIdR/acEtuJodo9LUB5LCJq4at80OqX
 CezVjpeS1f604bZLWjS7Uz7H7O2F/AUxvzTpx1sU3BU2Cl6KyzUKRJq7NYcQbxRlCTOn1B7pOip
 if5mDJYfSQxeVkUNAL0udZJHdrr3BratHYJzk5n17wdudTYzfwzrka5uvVBvy21hjrKHfrgnjdR
 iG0iBGT2Rq/ub/PHzTTlRXjE4huWvpmXl7+WcWuInOQ8clKfglOkf3xwqevip5Yhhu6R6FXphPW
 YmhfvZdX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_07,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138
X-Rspamd-Queue-Id: 6F303409F8
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: C4VOCMUHLP4WMOORZMRO4DHBKDWKTOBZ
X-Message-ID-Hash: C4VOCMUHLP4WMOORZMRO4DHBKDWKTOBZ
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/C4VOCMUHLP4WMOORZMRO4DHBKDWKTOBZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>



On 9/24/2025 8:48 AM, Amirreza Zarrabi wrote:
> On 9/18/2025 7:50 PM, Dan Carpenter wrote:
>> Re-order these checks to check if "i" is a valid array index before using
>> it.  This prevents a potential off by one read access.
>>
>> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>> ---
>>  drivers/tee/qcomtee/call.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
>> index cc17a48d0ab7..ac134452cc9c 100644
>> --- a/drivers/tee/qcomtee/call.c
>> +++ b/drivers/tee/qcomtee/call.c
>> @@ -308,7 +308,7 @@ static int qcomtee_params_from_args(struct tee_param *params,
>>  	}
>>  
>>  	/* Release any IO and OO objects not processed. */
>> -	for (; u[i].type && i < num_params; i++) {
>> +	for (; i < num_params && u[i].type; i++) {
>>  		if (u[i].type == QCOMTEE_ARG_TYPE_OO ||
>>  		    u[i].type == QCOMTEE_ARG_TYPE_IO)
>>  			qcomtee_object_put(u[i].o);
> 
> This is not required, considering the sequence of clean up, this
> would never happen. `i` at least have been accessed once in the
> switch above.
> 
> Regards,
> Amir
> 
>

Also, size of u is always num_params + 1 for the ending 0.
(basically means `i < num_params` can be removed).

Anyway, it does not hurt :).

Regards,
Amir

