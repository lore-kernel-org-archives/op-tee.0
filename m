Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D05CA0EE0
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 22:50:00 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 27BD446644
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 22:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755125400;
	bh=GwWQIqDRWNR8rlc3sYd61ddWtomTVhI1gZm1AYNVkd8=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=YF44L4ScS0tzrrD6A6rhDRw89vqZsKLG8ohKUMKQ+9ISsxSIKBBygelACfKxufVRM
	 Do2Sygd//PHNyin1GTzE2aoQOJcby8VF2+ufiQWDtucw6qTOFOBNL+n6ugmNG2FKIB
	 0NiTeY1pK4/XMQThrR3iMO2rgudQG4ko6XkmrA1aTzWUBFy2d0PTaedBuU0RHmN2aB
	 Cv+zYH/iTQgOW+gqib3y4WG2pNQ1wJPC+WXV3WdoiESUA4TfWqktrqTigH6FBHq0+V
	 +A08Mow7BgeixjGoeC55K0S1IcfmnRX2axB7XxON63xxLgHw1n752IPFfuoryLn/uU
	 cCqnos6e97H+g==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7F5CA42E12
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 22:49:46 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VE0ATn3B;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLfJP030090
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 22:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1y1eNmB//F61SipoixUPmWI3edeccgArIKxTM78/+/I=; b=VE0ATn3Bals0gSW4
	+bdtKCITDeGJTX4UJeqZJ6AqzNU2Y+CcP+0ZiRu0/e1mI62QExXllwlPJu2FPv24
	u001U4PpaGOEi9MXWbvM9oqU2EF60TrDYhD8JW1VZLcDI22vTB1dO52BVp5fpCmw
	81lkpE2ARNo8zlCNp25j4eIDzXrhUjVaVYI2vB1AFcL6sRAnwCYiRzU2v1TVjx5J
	iX1XFeFg60S126SjDVQg0Ei91wpRg6/jPEya2VzWUbUSM4qkdaYMapH0NPKxiGxi
	CScpMuJBBqJFdL9VUZ6SAtGJppSuQEkIZqQwRSzFKk/bSC/gin5fKyTxn89UIV28
	kxZAgQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vrcv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 22:49:45 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70b43c0001eso678876d6.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 15:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755125385; x=1755730185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1y1eNmB//F61SipoixUPmWI3edeccgArIKxTM78/+/I=;
        b=qDh8SJ5Jcimy+giUZNlDScj9JMTVkhcWiSVcAmHU863Ewnqfj3Xe/ddmaM6p0MUTeN
         j3GToMuB15jW0ajZr5/umuOWkd+aHN3zIali0Jqc4jUnP0abilDEeX10jsCT311bi5sa
         UJLuW/k9RIvN7cR2AArOIMnNd7Kxmoy9H8jzNgnT54ulv/enWcFp9DsbndRtWxmf/xZH
         sGK+ulUowTPOBjA1KmT33rmlYNqzW2JbMyp6jZaQ/VYDBfP+yySSWBvQ/jykN4nQaBXJ
         cDWbmRr5Z9FrvpUX9TurmZO1lefL2RS2FgpKN3GanJYemMkmpNnWLcyuMJRiGACFlgX4
         UyZw==
X-Forwarded-Encrypted: i=1; AJvYcCU36aOtg1tXK3Bb7IiBPpykWYteQjEztQ9bCMmNNROzDlmfql8N0hIbC2V5by5JZAFdi8m9+Dg=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxeeWBDfYDnpJrNMZaOx/AwinyRzfOTRXDcgM92ouBErZli/uMT
	6sSsMzaAJkM84QEURZzaesAjsL54mUJr/YXZ0ShCl+lMMZI/OCWW/1QaeWpmxCMJqV7VNRqJ7fc
	F4ISvxuTGH2GMKM94EU+rwjk/IQ8uMenGg17dcMb8Pb74B2yxfXIx+fEWV0JBd2LRYJXDgJCX
X-Gm-Gg: ASbGncv5Ie4d8kgR7UJ7u37+gNRD+H7jpU/BZq/OeX95GWoO60mc8PQyZ2jExSUKfLa
	14tTiPeoxtIz+lNYMZmN6krpEgJUIh8D0utbd3EUIB3WjcB7lZNiynSsE13pqWBSj5sTzRutIl0
	5ZUJU5hmLUnk6tT7DmaiERHtmhRKa310z+3HvSOQ9GBJCWOT/kJjcT0jb3/lZS0oKCpzFYTy5om
	RVvY+1SnvQqcoUM2BBj5PDtRG14oMij0DJxTqpWz1hKBQL2Ip0bebg0gVgIx/6yn/LIaP6Y+Hxh
	IK+E8cHe75ASj1gyEzt/teNY9ag3rNnWYytgnh2rsqRoR8SbM8bf366lvJmS0hRk35pnpvbhkQw
	j0nPwA08HY3Ebd+C0ww==
X-Received: by 2002:ac8:580b:0:b0:475:1c59:1748 with SMTP id d75a77b69052e-4b10ab40660mr6928281cf.11.1755125384970;
        Wed, 13 Aug 2025 15:49:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOa1EUACt46c/s0PUTGj00pPK/iWnH0SLzQKgyx6D5B8kmovv05Bwu05KhVWthG9YSv94PmA==
X-Received: by 2002:ac8:580b:0:b0:475:1c59:1748 with SMTP id d75a77b69052e-4b10ab40660mr6928091cf.11.1755125384448;
        Wed, 13 Aug 2025 15:49:44 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e82a5sm2475800966b.82.2025.08.13.15.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 15:49:43 -0700 (PDT)
Message-ID: <d74404ec-44ad-412f-98ef-eed288ecf1bf@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 00:49:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/11] qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-10-ce7a1a774803@oss.qualcomm.com>
 <3ec0a8d0-7900-45bd-b0d3-90ee8ca7730c@oss.qualcomm.com>
 <d81abdef-18fa-496d-8493-e8f336c43800@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d81abdef-18fa-496d-8493-e8f336c43800@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfXzTIKclHrZl9e
 gbAbSyiYpMgHCe1aj5qUWp/97mpvEJAZvwzPirApe9g+rIMNA1QdoC8hsa2ZvrJZx7PAT/qiGcc
 YSm/aIpFX4KHLyazjNI46z6S0+qzj1jXG8dFQtSSOQjOg+0jqSq54p6u2ATuaxbYyJ2CiRIjn1Z
 9bEz10yLBw366pycUBsKjE2tnFN0A9cGaRSXpJYfLjHfoxdIpSed6vBoGahUIXrx1KYJcyMZzm0
 hZRUXhG9RFMTZhaKtWFRUfYkzvuprZI7+RqY0BRn4rDsqautgHwbRJjUUbEBDO9SQq9YR+1I8qD
 vrOTyhMNMYeE3TAXRBiuTCAan1BYC55Oq3JtldyEQKUs61ie1DkVGxFp6XEusiupE82kMdnQT6p
 ERGCVY0f
X-Proofpoint-GUID: kA0wXfFLgLsWvKIIPokm94S4wqzTBiZ-
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689d168a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=YlTi__48JDlbgKAADYoA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: kA0wXfFLgLsWvKIIPokm94S4wqzTBiZ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107
X-Rspamd-Queue-Id: 7F5CA42E12
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.72 / 15.00];
	BAYES_HAM(-2.62)[98.31%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.219.72:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 6AMSDCTE5GNW5HR5FOTIASITGIVTZNMM
X-Message-ID-Hash: 6AMSDCTE5GNW5HR5FOTIASITGIVTZNMM
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6AMSDCTE5GNW5HR5FOTIASITGIVTZNMM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Konrad Dybcio via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

On 8/14/25 12:24 AM, Amirreza Zarrabi wrote:
> 
> 
> On 8/13/2025 8:00 PM, Konrad Dybcio wrote:
>> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>>> Enable userspace to allocate shared memory with QTEE. Since
>>> QTEE handles shared memory as object, a wrapper is implemented
>>> to represent tee_shm as an object. The shared memory identifier,
>>> obtained through TEE_IOC_SHM_ALLOC, is transferred to the driver using
>>> TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT/OUTPUT.
>>>
>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>> +/* Mapping information format as expected by QTEE. */
>>> +struct qcomtee_mapping_info {
>>> +	u64 paddr;
>>> +	u64 len;
>>> +	u32 perms;
>>> +} __packed;
>>
>> Please use types with explicit endianness, e.g. __le32. I'm assuming
>> TZ will always be little-endian, regardless of the host OS
>>
> 
> I'm not entirely sure how this point is relevant. As I understand it,
> the core that populates this struct is the same one that accesses it in TZ.
> Your argument would absolutely make sense if the host and TZ were operating
> on different cores with distinct architectures -- such as one being
> little-endian and the other big-endian, which is not the case.

CONFIG_CPU_BIG_ENDIAN=y exists on arm64

Konrad
