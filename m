Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDDDC87FCF
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 23:19:27 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 72C4B4FCD2
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 23:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755127166;
	bh=J7HPyC/viLo3ASlp4BEj2IzMnozhzIy4ActEhtCF/UE=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=s0FV/SUCTN0Vzp5wvQQen7X3v4f+/IymUnz2dyurmTkBvqpacQywV7Wi5sdyKLGaZ
	 m2bgmXT5Lh7oRh2V1ejQBG239JPcVouibGyK/RDHAO9C3prFUtcraDOuMh7ah70S/3
	 hAjEBbm9glqkfl9tSfydTtv2zBWiaf/Fx4rYVCVZXAblqt2mdpmdjIFGCJ98kv+NEV
	 epbVH3o4l/GVdQ9xk5hxUWFZ6PdRTmcWdHnO6oZZCEC59NetqfgylpGC8n/ToyUndY
	 c3c/p3erKdeMDY6t/S33LIs8VlsYRJ14+t3Ms7ENZDXagi9AsvZaSkM6WNRK8Q2hul
	 eRy/0CqtCUOTQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 03A0042E7A
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 23:19:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PvgKzPIT;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DLZIgQ012188
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 23:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2TfSABE608VzR8Ccb4ovCS90iSRhqxTosRl77AzoBvk=; b=PvgKzPITzN7s/w4F
	CWmDq3EBjBDvcHPTnE5J9fzFRBm5JuwXqpHyOD3UDwfrQm+CPO4qalH5ZusRrI5d
	syOJg9wfB711Q9ABtxbUE1ao4ffUbyTmicIEr2Q0OnL/Ukxm2p7Aat52rlpGqE9O
	OH7sCI1/xbp2CKdOGEQ0zs/t93Ayal4dCj8gPkwnxx62cdwGSwkKVxzcAjonFefc
	3eKld5Q5oOSdp/F74YRx0iyKCZyF4P3gZU+dxXES4M5zgTqoBQO7jMcD1HDhuRdH
	WAowXtuau2w5bYpTZ2zUbyq8qhOpQZUqju2QX72n3dcxOiReCJYZC89+HLB4aWwC
	jpjC/g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhxbpgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 23:19:12 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2e8ccecaso653650b3a.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 16:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755127151; x=1755731951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2TfSABE608VzR8Ccb4ovCS90iSRhqxTosRl77AzoBvk=;
        b=d+J85RQBm5pnn5d9VuP6RQynmZyjgicRqbcrBi9Qr/TeHoWO2Z0FEhOrfaOAbUVAqL
         swwkmcjROe32m0ZJLgp2MVQRu2g1KWaJb6aJH4eD7dGOHiHSNax/kbiCprFoUXOgzvWx
         p1YeHrWHqMFo8vSQkawTSRX0BQ7D5upkctiKcom2xr8Ppt2OLh9Kn0xyK+jjl3dOF37I
         rBGrfew3vjbW3lTq1VRgCLrsc3Jj7nHMj7OKKmHtHvUe9eAD/CXJtsaUMvcSzQY1j3x5
         sSEjEU6/cXGhB/kiVsGob8g7pEteZ6UcbBIOH3eo9HO/KG6s6WslTJ89ODCztn0W6hXT
         0TUA==
X-Forwarded-Encrypted: i=1; AJvYcCWoqoxezLNjtzltojkxUfEYKPH9+/08Yi9xuHlYgf13iGIukghjeclB6esbMsw6pmWHxAf8WgY=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwC3Bve5g0Bhpp0PGcbtD6dOP+FM7KvF090jMpdWSr6RRaRxR9D
	QsRLKg/+qgQovW9t1ZyH4y0qnEGHe1VF9D7LiEPp2TuBmEElvYrniA+2438PZvjE4MX3uKZzVcf
	4+y1CNp81eM3DOdGlTTq12FRROxni5QKKQPEZdakBDX+UZdvv1DMZWhfTanEFXrrF64qphes=
X-Gm-Gg: ASbGncvUrKHFN22if6xaNczEv3Brbbgi5zLenk022jhAipSg3kj4rTDWk4nuFMSgFL/
	lVKC0901I+nKqsdzsJfaL5sG5bSWrG+6Y22X8cejdXYHTEyhMjM2iiUpJzkyVjwB1kxjSiKHL9D
	ttPBbXcwmNk+xAak6iMANfGMwYfIWN2uft3EJESfwwsGZ+raMlPI3Y59BL8wDhzHi+vdtgfAd8E
	2Lt/YgiB25IeErWlzw5/PvCNxGJIBlIJ5+NACDL+xTu4cGkj44M+vohSe20WxpcPeNSCKo82JOA
	PTtMJVJJhA/OeaWrZeiIE6Gk+OKqI34fLT4zDRS5xByFZ4HLhC6CTIQfFCU6WnfVV6VmGY6CURS
	JcM1vywBlehEAdhwqqZpFawryBCNJoxZi2vab1g==
X-Received: by 2002:a05:6a00:1489:b0:76b:f13e:f598 with SMTP id d2e1a72fcca58-76e2fa5dd6amr1713043b3a.8.1755127150823;
        Wed, 13 Aug 2025 16:19:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMWMipas6iUqagDKstR+TGWXPaYzE7u4u1viMcqd2w5yiGt/rETTcoLJmFUWDnm+dT5E5L7Q==
X-Received: by 2002:a05:6a00:1489:b0:76b:f13e:f598 with SMTP id d2e1a72fcca58-76e2fa5dd6amr1712998b3a.8.1755127150336;
        Wed, 13 Aug 2025 16:19:10 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bf067e310sm28124852b3a.25.2025.08.13.16.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 16:19:09 -0700 (PDT)
Message-ID: <87c884ed-0975-4ac2-a0fa-16e830a57c72@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 09:19:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/11] qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <d74404ec-44ad-412f-98ef-eed288ecf1bf@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d74404ec-44ad-412f-98ef-eed288ecf1bf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX+86KrT9zxOuS
 hUDUdNYYq4XvPBd2ZgHZC09VqYlU8BakusIeCakWO3QVhGu2PSMoLkZn/9cKXgH5F56nI41hYae
 9yy0sG+Yp3OWikfr1QhmdMDeQivv/BnW5rhFlSs9q5UpFmAjcrqAWFYeFbz9kTDHE1r5pD0X8RC
 SEk7TzB6BQDwSyuaxsue+8+boU3HhrjO6okQIYU2V7X4udBKuVekomQtakUKjtXe/Lvhki054wx
 gxJRLZ6rgCQ3o3i6nEcX3qZy64UaECPM1Fi+Sng1lrfnlUDPVglHm15D+N5gDmmE0anYQl/Qc6s
 pdiC0/5fWq8Chc3mNP1XHGYwIkbzoyzMvhsjt/OzgH0hsqCmpH1k6x3DN9FoVsyQgWvdDAyGC/J
 rLh6GJZO
X-Proofpoint-GUID: 8q32w86NYDBGHmr-ZD0rgpTmcF-1Wsf_
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689d1d70 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=AwBIn8DhAZiLWRgty54A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 8q32w86NYDBGHmr-ZD0rgpTmcF-1Wsf_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057
X-Rspamd-Queue-Id: 03A0042E7A
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.63 / 15.00];
	BAYES_HAM(-2.53)[97.91%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.210.198:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 6VD25DFGBBMNMSVANVM6WQZQZ3C6VIB5
X-Message-ID-Hash: 6VD25DFGBBMNMSVANVM6WQZQZ3C6VIB5
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6VD25DFGBBMNMSVANVM6WQZQZ3C6VIB5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>



On 8/14/2025 8:49 AM, Konrad Dybcio wrote:
> On 8/14/25 12:24 AM, Amirreza Zarrabi wrote:
>>
>>
>> On 8/13/2025 8:00 PM, Konrad Dybcio wrote:
>>> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>>>> Enable userspace to allocate shared memory with QTEE. Since
>>>> QTEE handles shared memory as object, a wrapper is implemented
>>>> to represent tee_shm as an object. The shared memory identifier,
>>>> obtained through TEE_IOC_SHM_ALLOC, is transferred to the driver using
>>>> TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT/OUTPUT.
>>>>
>>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>>> ---
>>>
>>> [...]
>>>
>>>> +/* Mapping information format as expected by QTEE. */
>>>> +struct qcomtee_mapping_info {
>>>> +	u64 paddr;
>>>> +	u64 len;
>>>> +	u32 perms;
>>>> +} __packed;
>>>
>>> Please use types with explicit endianness, e.g. __le32. I'm assuming
>>> TZ will always be little-endian, regardless of the host OS
>>>
>>
>> I'm not entirely sure how this point is relevant. As I understand it,
>> the core that populates this struct is the same one that accesses it in TZ.
>> Your argument would absolutely make sense if the host and TZ were operating
>> on different cores with distinct architectures -- such as one being
>> little-endian and the other big-endian, which is not the case.
> 
> CONFIG_CPU_BIG_ENDIAN=y exists on arm64
> 

Or, you are saying we may have a configuration where host is big-endian
but TZ is little-endian?

Amir

> Konrad

