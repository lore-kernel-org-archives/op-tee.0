Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC0BD3569F
	for <op-tee@archiver.kernel.org>; Thu, 29 Jan 2026 05:34:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 36F62431DF
	for <op-tee@archiver.kernel.org>; Thu, 29 Jan 2026 05:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1769664875;
	bh=DdMZZiebD/cwhbIoTKIn0Nb3vjLVJ02J6FCr8fitSl0=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=yeyn5vvFNrZCU6rfJ3n4mvzruYhnCsUSpjeEDEEIHGcuXHgC0Ke/fK3joZhVbzEMP
	 QhhWkjPoGfOEpbdwi4XD46zTnUBnQVtwLZzgLbdNfrvCuEhhRhqdazjqR8sQOBhZYV
	 Efgaq+mNpOEtrr6DkPa7doQ5CJA+U1pOdEYt31lx01WUelahoRNAH436S/YkLSKzCK
	 1SpGmN0vyohwSgDbikhetDf4YvJ8tn0Dd2uSjfl7froAG5kwPF6nGrKaCvQ+GendLz
	 LlnJ1zXntU0tY571H7oek0NQoB23oe2gKCgIIOtiZYtWlglH3FvH2d+2gyl0uGDS9q
	 sBnJll4gr6TqQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1B76F431DF
	for <op-tee@lists.trustedfirmware.org>; Thu, 29 Jan 2026 05:34:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GHvj06Ko;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hs7Vd411;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T2pPDO3713391
	for <op-tee@lists.trustedfirmware.org>; Thu, 29 Jan 2026 05:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PgvY4CydFcPdXf59K70wxUykRGVzgC861i4hC9eyuzU=; b=GHvj06KolpYjYXUG
	qSIvYxPd6hOe1edCJG5PZWHCAtKgXvzhXv3gAb79yZTg3d02Byxm2x5t517DFGYD
	bnQAoEaI4urQJ0pttJ5TXXp6A4y8lkcOfLi8bGZYg0JAxgOobzNI6BecGSxAEd6c
	NXnTRw5H2FJbuYfX+tI/J+rGHfpf8xEDFky9FnPtQTrd/9JzMzNlLwrvFzwCmi29
	nfykuuKkhVD/n9acaSFQJC5JkNfVv18nHYLx9cxU4l8s2o+FYlJcBDa7s+ii7ZxH
	E6GU0gtMxxOLHqeVZkYKNcrqE955FvZhFlOX5TWTGTK+hnD23Dt0o2KjVFtkup9j
	80FZHw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byxcu8h9c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 29 Jan 2026 05:34:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ed2so517672a91.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 28 Jan 2026 21:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769664853; x=1770269653; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PgvY4CydFcPdXf59K70wxUykRGVzgC861i4hC9eyuzU=;
        b=Hs7Vd4112/i6mCmICkd0j3zAfLMnhcPPBJHJ8k7v0NEmFXm4pM6+I3DzfbWeXaJJ5c
         9tYcwcdZjCoi69kpIrVFu5zwNTs6U6AHGL2v8x+AKyYuczes2fIN4ezrFN8MmIga6wLM
         /ix7fuVuzTf3TEkdIY0u3HDAI8OLO8shdWB8oPMC9pZgwWwwLuFNh9j8xbULsPYCzmIM
         +XbJXj0EFIl6SbKfHHl33xqQLaJo58WK/rg3kNF3VQnnXivgEnuWryl7dRoOxXfV+adg
         QrvhBOrcOe5J5GxWHq8QoMUmBtE3qvuX/oeG1I1VB7euHS6iPXyWzNipUHds+Wc52YWt
         ePWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769664853; x=1770269653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgvY4CydFcPdXf59K70wxUykRGVzgC861i4hC9eyuzU=;
        b=B6olT4R2lFhEshmZg8gvB+dd5id2QlNcC2A73g8wBk3qf5KAD02oaJNkYvYOT6XeVj
         7oZD9ZxwBDltoRI12JQ3/1wvhnPWuW/P+Jp5OmeEI08QgMbUAxNavH+rUf1KfLBiNuqU
         qkmXyuj8dox0OXhFW/kPm4unqStd3/DR/fmzUCrVbviJUPGYiDg0tHsiJXpcizvFjHbA
         vKF0n52jWAgBrtAoBbILZKuQV/JdQkcdnWCexFMatJYRiCDTGcUIYQ11fcgmt+gS0fj2
         Z/0BJdgPFAQv59rzvy835HWlH8xst0rnvhQf1W9MP3K/YIVvhEoJgpyYPBDFqiBW/EIo
         Bu/A==
X-Forwarded-Encrypted: i=1; AJvYcCU2UtTmwr1WTpPx+XmPmf58FrWBEIQNFoADTvN7oa0P9QOyUDdoutnE4oSTgCWdbO7o6/rm8AM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzASxsBrHCa8TaF8XbuYsb5R1wJwhLb7p6BBjYJVqv3i3Q8oLcE
	dpGjED4CG1kig+vqeqk8QnqdJ8uvIV8rWJa1zvoZQfCMlikWQF6jBoA9594nJCTHhwEsNr5yuYT
	YtjEJAXDWxf95xSKDKwwWAW5aSrvAAsUzJGFe7lq79/oJKnuiADCQ1T+o0VjPc+PK8yTVWNk=
X-Gm-Gg: AZuq6aIORULBPNBRdMsMA6jXiL2dH/N+rEr/KZJ2yEm5c7uGcc030QzYXmoxBOF+hna
	Wuha8LFsoik6xoi01grtWzdw1B3ueMjkZUzoqe0kfj6uYAm4hncGSm2qSozljPfXEBJ3kL/ctOH
	ZOqnKaNBhhl5IaKufxFNEM75sfg2zzqs8DzmlRIdnO673yebReKc9w5gtFoefy8pIKl9m34vDwT
	3rt7GXDE8xpdMwhHlP8gg7FQzT3mvP7Q9rW0jc1JUJQa0GHmenvD5McwIGigwCzGlTtTLijUHC+
	fbojWOQzh5AXhQfpIl4pvD3tQK02zt4EsB5hcdDao1jomRnGnxyHAOzHq9Hu4B8Zv3Ni6GFK/E4
	V37M5Lp1iPgaRnQT5YJ3ySQRbqddqylplw7ZKmt5b2iAnEp1kERPHaYPcU3l8FlSLDqNw6lcYOU
	Lq7n4z9+k=
X-Received: by 2002:a17:90b:2789:b0:34c:a35d:de1b with SMTP id 98e67ed59e1d1-353fedba58fmr7109183a91.37.1769664852892;
        Wed, 28 Jan 2026 21:34:12 -0800 (PST)
X-Received: by 2002:a17:90b:2789:b0:34c:a35d:de1b with SMTP id 98e67ed59e1d1-353fedba58fmr7109166a91.37.1769664852368;
        Wed, 28 Jan 2026 21:34:12 -0800 (PST)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2cb0a7sm4109165a91.2.2026.01.28.21.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 21:34:11 -0800 (PST)
Message-ID: <5cede166-8527-4360-a87d-ba090ad420da@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 16:34:05 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: defconfig: Enable QCOMTEE module for
 QTEE-enabled Qualcomm SoCs
To: Sumit Garg <sumit.garg@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>
References: <20260114-qcom_qcomtee_defconfig-v4-1-ec676311171f@oss.qualcomm.com>
 <aWoNut1UzpL8Il9V@sumit-xelite>
Content-Language: en-US
In-Reply-To: <aWoNut1UzpL8Il9V@sumit-xelite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAzMyBTYWx0ZWRfXxk2ec/ewWkJQ
 Xqw799xRgD2mK43G+9nrhvo78Rb8WaTNTqaYgiGz/l6KJjE0KPGhk6HA5182m+UG5+o1HCn+tPV
 SjwEYfz28DoT23XesH196zOQa5jT8fkMVUZhTVrxwB0DgICqXZDhVgQryOoQfKiNwaJ9exKywi7
 1WzkyNk0i9MURB6XGmZaMGNDrwaVtEFrydiaX3zHZHOviBt0cSJtj51E1k1rUmyKe2naUlgIxI7
 IvWpkvcFQiNv6qrlb5svH46HhfcjbLDByYZZDkqTomm54AlFVv1z9PRAsFv6rcsNAy5AwHrMBpp
 WBEQg4z8s9YCJMg5vQrQ7Zq08MGyFJLg0yIn1smKcJa5WDnXhUGyxPdBgHqUDZ44DwNrfmeqodt
 aFXoqOannLOu3ovpEWohPGR2T9h49s+d+P11IzCA8SbfF5IpFTykDcme8ITbZAhsHg/G9B4IA1T
 qS141Y7y7xC9DLI6Riw==
X-Authority-Analysis: v=2.4 cv=QpRTHFyd c=1 sm=1 tr=0 ts=697af155 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8
 a=mpebLm1d4dY9ibj_iC8A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: VKiJH0N89eaH7ViQW3rdUvvGPEzZs2CC
X-Proofpoint-ORIG-GUID: VKiJH0N89eaH7ViQW3rdUvvGPEzZs2CC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290033
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from,209.85.216.71:received];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1B76F431DF
X-Spamd-Bar: ----
Message-ID-Hash: GAI4KS7H5QUYJP2RU4KV4GTF2KCKU3NC
X-Message-ID-Hash: GAI4KS7H5QUYJP2RU4KV4GTF2KCKU3NC
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Krzysztof Kozlowski <krzk@kernel.org>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GAI4KS7H5QUYJP2RU4KV4GTF2KCKU3NC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>



On 1/16/2026 9:06 PM, Sumit Garg wrote:
> On Wed, Jan 14, 2026 at 01:49:14PM +0530, Harshal Dev wrote:
>> All Qualcomm SoCs starting from SM8650 provide access to the Qualcomm
>> Trusted Execution Environment (QTEE) through the SMCInvoke interface,
>> implemented by the QCOMTEE driver. QTEE runs in the Secure World domain
>> on ARM64 CPUs and exposes secure services to Linux running in the Normal
>> World domain.
>>
>> This change enables the QCOMTEE driver as a module to support
>> communication with QTEE.
>>
>> QCOMTEE has been tested on a Qualcomm RB3Gen2 board by loading and
>> executing a Trusted Application via tests hosted at
>> github.com/qualcomm/minkipc.
>>
>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>> ---
>> Changes in v4:
>> - Updated the commit message as per discussion to clarify the following:
>> - Why we are enabling QCOMTEE for all arm64 boards.
>> - From which Qualcomm SoC onwards the driver is applicable.
>> - What functionality the driver provides.
>> - How the functionality has been tested and on which board.
>> - Link to v3: https://lore.kernel.org/r/20251208-qcom_qcomtee_defconfig-v3-1-b50dcf8ab45e@oss.qualcomm.com
> 
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> -Sumit
> 

Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

- Amir

>>
>> Changes in v3:
>> - Updated the commit message to reflect the supported Qualcomm platforms.
>> - Link to v2: https://lore.kernel.org/r/20251205-qcom_qcomtee_defconfig-v2-1-c92560b0346e@qti.qualcomm.com
>>
>> Changes in v2:
>> - Updated CONFIG_QCOMTEE flag to 'm' since QCOMTEE can be built as a module.
>> - Link to v1: https://lore.kernel.org/r/20251202-qcom_qcomtee_defconfig-v1-1-11bfe40a8ea4@oss.qualcomm.com
>> ---
>>  arch/arm64/configs/defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index cdb7d69e3b24..e952d24bef77 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -1789,6 +1789,7 @@ CONFIG_FPGA_MGR_ZYNQMP_FPGA=m
>>  CONFIG_FPGA_MGR_VERSAL_FPGA=m
>>  CONFIG_TEE=y
>>  CONFIG_OPTEE=y
>> +CONFIG_QCOMTEE=m
>>  CONFIG_MUX_GPIO=m
>>  CONFIG_MUX_MMIO=y
>>  CONFIG_SLIMBUS=m
>>
>> ---
>> base-commit: 47b7b5e32bb7264b51b89186043e1ada4090b558
>> change-id: 20251202-qcom_qcomtee_defconfig-8dc0fed1411b
>>
>> Best regards,
>> -- 
>> Harshal Dev <harshal.dev@oss.qualcomm.com>
>>

