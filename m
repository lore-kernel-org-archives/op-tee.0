Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB6BC531F9
	for <op-tee@archiver.kernel.org>; Fri, 24 Jul 2026 09:15:03 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7291844F27
	for <op-tee@archiver.kernel.org>; Fri, 24 Jul 2026 09:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784884502;
	bh=OLLscgq9M+ScYStpq6skqU/yJamc8Y0S5G+SyNkmjOw=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ttck6/6x6iBRzT3cdbWnPzafn4MvcZ0IjW77CzlwTEY1wo15SZBs2wxsLAtXQG+nd
	 FbJljMyXnptdXb2ZQgJ5c9h2Rj6slH9d6/gyHnGF/O5g3VxPZ0NXnd16/KqyiEf0Ae
	 Oe1Rp7Jp/2XzIxaAlx7szDCZxJ8JLna7w85n3EeMvVQagFu9gNGCNbdAwqiNfPXmdJ
	 XcFjJZ7kcdNBve3j9RwcU6vxq/g19UygAXF2QUyIS8cFpaTVwzuRHpaIJlJDjsTeU3
	 OWpLsCvxqkIVm2/0MxW2Zk2fqlzM4oiV5h7GSz8qFhuddnxgtCpAwWmoe+Dl5CxJws
	 V5xmFxeM4LpZA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0CA0243E5F
	for <op-tee@lists.trustedfirmware.org>; Fri, 24 Jul 2026 09:14:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jr8nwrSb;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XmI6DeoQ;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4lbu02125326
	for <op-tee@lists.trustedfirmware.org>; Fri, 24 Jul 2026 09:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	46OQ9kL92dqpYfcGuAIjuk9va1sgSP/j87qnZbsBqAw=; b=Jr8nwrSbn/glDoWi
	O+BxIpfwBCqp0ht950YqPiMHX/UF1GGeMGmQneCF1Dh+qNeo2BOVtb+7QwGz1uvz
	GDw9xpc/pAiT8PMRoshFVkuHl1WcMg7OAllBrKfh4Q+FYGN6Ddx7wh0fzbOEfNvs
	ViX7ggrMuQeeN/AgeEFhAGPl8HaSHpuFFa01bjokwxn6OD2c7AKRitOvA3vhojEM
	9czF7TzwGVKhdvELrx0/AoUzMzNMvHiKk7mcBfKNSb5WHur7uTFM3BJP8Q2NQwFh
	ml5n1jZXRbMAkB2cbf4qqNAdsKgsmlvmhmnAe1QlGKLRHZZL9K/RmcYm4yQ0qn/b
	JoDRlg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqamu06u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 24 Jul 2026 09:14:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f0fe57470so347806a91.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 24 Jul 2026 02:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784884494; x=1785489294; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=46OQ9kL92dqpYfcGuAIjuk9va1sgSP/j87qnZbsBqAw=;
        b=XmI6DeoQANOwuhslOI8OQPdvtXcwU37N/zaW2wbxi9oSnwVzlP1EWI4PNkxj7R+h5c
         0zhlm2tx/eJ2pAkgkmdUKvAbi9AxD4huMl/RS+89QAHKR63t8NfP33QOC/9ziFLXuyh7
         oAQoRiI7lKgOonAke6ocWs7X3l1Z3KFORBKcDaRlFc8F5A26smdjT/Z0iRdIVtyE3+JP
         92pE3+Gp/K+Db6uCWEByZHWYsPebRfgZWMgVvbP6q/n58Ibhs/3oxwz/AjmHgom1kKlt
         rBRUxm6TwrLEpVMfHDwkZazCFdm/e3ufBRRXhShZjCnZwoQ15ZS7WJ2QDOJ03UQggoEE
         VhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784884494; x=1785489294;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=46OQ9kL92dqpYfcGuAIjuk9va1sgSP/j87qnZbsBqAw=;
        b=TiP3d4poiUZvJPr7se0rEUlPjp6/DvwFPM/TDxXSF3AtryDsSj4QfP9+C9I01AmUfa
         iO9ifrE50BucnbqzUKmRw1xria/Jh2ZZ3o1UnlzdBQ38J6UHytghQP6jOnSwTaeuHRzc
         cdMBaqo6Pn5va748ENmr+2lj8TyDmyPxyjhFS6VoQSyjxATzAzkOCu1W1P35fDik21sN
         gNIJ1JUM/Cra4mGFSQexN22ZZNMO1rnV/PfCB2eBsd9rNTXmJpfbWXtTYvSKPjRG8YOp
         8gCuWpjCqfQ6Vh0i1ND3yFMhyjm46FbsCzDfQchw2u7P+5h/3Qpp7cLMJE49fAqHlTXM
         zMQw==
X-Forwarded-Encrypted: i=1; AHgh+Rrm2x+zdEl5lP7HWemvHpmUZkJGe5ejFNiC0kdnVOQymuBXKuZxSimwpVVtVIsp0Qy4Qw+0+y0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwNEwH083UF34GrHs9iY+VeswdrAm1zit0kxMTG1mPwjscZohUG
	gCtWFz1vujXvbfqBBxVk0/2811xXaFzvKTsFAx/rfXGj65Y7N1YXiPsf3pkMioKjs6b5NKN2Fve
	Cux0WnSLHtZg1eEzStU41MUpdSR86pd2y2poi6cYeWcem+O5ocW3nLoOa4eXraFtwO087SnAhZ/
	JQi+8V
X-Gm-Gg: AR+sD11u+/UsWAKB2loWNAcaqxnJAB2Zd+IEhG/MOZc1PV6sgnc+o5sd9F1Urwbd13r
	ifk7kw0QYsMHqztYQVyeu9U8z2siEKa+zAKd5ZjndxqiTQDyhyNo1Pps69Db2Rm3Qa7dyVENsJu
	F5d7buctamdEGbZUz1J1fB1zhDWWu+j4IveEJzC6CHygE6Ck9noJ0mfk4bK/09Andfr6gvx2HcM
	z+X5m+WIbqnOMuEiaDf7hLpXCVXb0vjmNaqnUC4aaRyysSFhjMLJd9O2CNyvdx22lUiNgR5VAeb
	EnZPsFS/y/nH/x3m70Hp6W1kKCCdIQrBo8sed7EhOnTHpPuOOPGkLyU6UpgXZ6IV0G2iywrtT3N
	0IQZx8kZlNmnnp1QWodx5MjScivg=
X-Received: by 2002:a17:90a:5895:b0:38f:a81:15b1 with SMTP id 98e67ed59e1d1-38f0a81287emr1835579a91.19.1784884494216;
        Fri, 24 Jul 2026 02:14:54 -0700 (PDT)
X-Received: by 2002:a17:90a:5895:b0:38f:a81:15b1 with SMTP id 98e67ed59e1d1-38f0a81287emr1835557a91.19.1784884493705;
        Fri, 24 Jul 2026 02:14:53 -0700 (PDT)
Received: from [10.92.203.75] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d2eb01aa0sm3272664c88.3.2026.07.24.02.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 02:14:53 -0700 (PDT)
Message-ID: <7c7ec8eb-d809-4e1b-9467-4c9105ab00e9@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 14:44:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] firmware: qcom: Add support for TEE based EFI-var
 client driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
 <20260722-qcom_uefisecapp_migrate_qcomtee-v2-6-b8a8fcbe4211@oss.qualcomm.com>
 <w3oebwhvheb6scbdv2dshhr6t4sx3nwalmlw4akqf4sj3n2nmm@s7e3xtr7cuev>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <w3oebwhvheb6scbdv2dshhr6t4sx3nwalmlw4akqf4sj3n2nmm@s7e3xtr7cuev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA4MyBTYWx0ZWRfX0recStnxxvBe
 aSFT2VuTwDJ7qUCY73gXMLGE7Yq95PkoFs8lESo88adf/pBoNlZWiYwNyWuYb4b9Vbbvz1CL3sv
 ns5c83vc8FQiTA0oca962+dMtLfvFAkKdT3CsbtBkLpMRvOQWkVlkkLm5Leg/Zr0RxgPo6amtCy
 VIdFZiUoe1IvUBEuaz0oG/AMKMnAGSGbHEhkENwtvOeXjosYx27BvNNbL5otfw7sGOz0bCiBRXx
 eEFfaDYqCgTn7CQ3oLNDYULINLWpSLpdzE4+o5aXYf2fzVA6KYla7cm6LvZUorvBPY4cBTZlHvv
 WEoBDjWAlnUZQdhn7R72SNPmFEhCdYNu8ZAK150SiI7SQHR8uHJQxtNn4susltj/X/gOFiBDw6V
 w8Rpglo/y84mE6c2/iQHZ0MzrqTLqv/m+AUKFgwk13x+kvOaoqKjA3SNT8MOEsa8kWbGbG9yafO
 P7oiU3Pj/ciWRsrPvpQ==
X-Proofpoint-GUID: 08hCZ4MBoQlXggpdi2n45wvO2arNvXUY
X-Authority-Analysis: v=2.4 cv=DfAnbPtW c=1 sm=1 tr=0 ts=6a632d0f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=iIHXuhr-o-_T8umTYlIA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA4MyBTYWx0ZWRfX2YrPJJ4UKX6J
 cxSbfDxpKM7qTJqdD98K7LO6aMYYCjElYgXTfn2uSqaH4O4Bc0v08JK1By5a43MVr9EKsoep0nT
 L4LLNKUbFMeEskNJNA9m5ZOUzpejyl4=
X-Proofpoint-ORIG-GUID: 08hCZ4MBoQlXggpdi2n45wvO2arNvXUY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240083
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[202.46.23.19:received,209.85.216.69:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0CA0243E5F
X-Spamd-Bar: ------
Message-ID-Hash: UDWA4NJNFECUQFIOYNN63OHDES56DMIP
X-Message-ID-Hash: UDWA4NJNFECUQFIOYNN63OHDES56DMIP
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UDWA4NJNFECUQFIOYNN63OHDES56DMIP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Dmitry,

On 22-07-2026 02:07 pm, Dmitry Baryshkov wrote:
> On Wed, Jul 22, 2026 at 12:29:17PM +0530, Harshal Dev wrote:
>> On Qualcomm SoC based platforms, UEFI stores EFI variables within the
>> Replay Protected Memory Block (RPMB) which is only accessible by the
>> Qualcomm Trusted Execution Environment (QTEE).
>>
>> For Qualcomm platforms without emulated RPMB support, specifically
>> platforms where RPMB is not located within SPI-NOR storage and instead
>> located on UFS/EMMC storage, non-volatile EFI variables can only be set via
>> a callback request from the UEFI Trusted Application (TA) to the RPMB
>> service running in user-space (within the QTEE supplicant).
>>
>> Unlike the QCOMTEE driver, the QSEECOM driver (used by the current
>> uefisecapp client driver) does not support callback requests. And on
>> certain Qualcomm platforms such as the RB3Gen2, attempts to access the
>> QSEECOM interface fail due to lack of support within QTEE.
>> On all such platforms, a TEE based uefisecapp client driver must be used to
>> access cached/volatile EFI variables within the uefisecapp TA and ensure
>> persistence of writes to non-volatile EFI variables through the RPMB
>> service hosted in the QTEE supplicant.
>>
>> Add support for a TEE based uefisecapp client driver which installs efivar
>> operations after obtaining an object reference to the uefisecapp service.
>> This enables the kernel/user-space to access/modify both volatile EFI vars
>> stored by the Secure Application (in-memory) and non-volatile ones stored
>> within RPMB.
>>
>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>> ---
>>  MAINTAINERS                                 |   7 +
>>  drivers/firmware/qcom/Kconfig               |  24 ++
>>  drivers/firmware/qcom/Makefile              |   1 +
>>  drivers/firmware/qcom/qcom_tee_uefisecapp.c | 525 ++++++++++++++++++++++++++++
>>  drivers/firmware/qcom/qcom_tee_uefisecapp.h | 120 +++++++
>>  5 files changed, 677 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 10d12b51b1f6..e8316007370f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -22018,6 +22018,13 @@ L:	linux-arm-msm@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
>>  
>> +QUALCOMM TEE UEFISECAPP DRIVER
>> +M:	Harshal Dev <harshal.dev@oss.qualcomm.com>
>> +L:	linux-arm-msm@vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/firmware/qcom/qcom_tee_uefisecapp.c
>> +F:	drivers/firmware/qcom/qcom_tee_uefisecapp.h
>> +
>>  QUALCOMM RMNET DRIVER
>>  M:	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
>>  M:	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
>> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
>> index b477d54b495a..20ce8b58e490 100644
>> --- a/drivers/firmware/qcom/Kconfig
>> +++ b/drivers/firmware/qcom/Kconfig
>> @@ -74,4 +74,28 @@ config QCOM_QSEECOM_UEFISECAPP
>>  	  Select Y here to provide access to EFI variables on the aforementioned
>>  	  platforms.
>>  
>> +config QCOM_TEE_UEFISECAPP
>> +	tristate "Qualcomm TEE UEFI Secure App client driver"
>> +	depends on QCOMTEE
>> +	depends on EFI
>> +	depends on !QCOM_QSEECOM_UEFISECAPP
> 
> Nope. The kernels can be built for multiple platforms. Implement a
> runtime selection, which uefisecapp client is to be used.
>

I agree. I reflected on this yesterday, and in hindsight it feels we do not
really need to add a !QCOM_QSEECOM_UEFISECAPP. Both of these drivers can co-exist.

Both drivers attempt to register to the efivar interface via efivar_register(),
but only one will ever succeed. Since both QCOM_QSEECOM_UEFISECAPP and QCOM_QSEECOM
are built into the kernel with 'y' the default path will be QSEECOM based when
both are supported.

I can drop this 'depends' in v3, and instead add a commit which enables this by
default with CONFIG_QCOM_TEE_UEFISECAPP=m. Let me know your thoughts. 
>> +	help
>> +	  On Qualcomm SoC based platforms without emulated RPMB support,
> 
> What is emulated RPMB support? How does a user (or a distro maintainer)
> understand if this needs to be enabled or not?

Ack. I will try to use simpler terms here to help distro maintainers. If device has
UFS/eMMC storage, this driver is the only way to access EFI variables within
RPMB. So it should be set to 'm'.

If device is SPI-NOR based, this driver will still work. User can decide
if they want to use this or continue with the old QSEECOM path.

Regards,
Harshal

> 
>> +	  specifically platforms where RPMB is not present within SPI-NOR storage
>> +	  and instead located on UFS/EMMC storage, non-volatile EFI variables can
>> +	  only be set via a callback request from the UEFI Secure Application to
>> +	  the RPMB service running in user-space (within the QTEE supplicant:
>> +	  github.com/qualcomm/minkipc). Unlike the QCOMTEE driver, the QSEECOM
>> +	  driver used by the QSEECOM based uefisecapp does not support callback
>> +	  requests. And so on these platforms, the TEE based uefisecapp client
>> +	  driver must be used to ensure persistence of non-volatile EFI variables
>> +	  via writes through the RPMB service hosted in the QTEE supplicant.
>> +
>> +	  This module provides a TEE client driver for uefisecapp, installing efivar
>> +	  operations to allow the kernel and user-space access to EFI variables.
>> +
>> +	  Select m here to provide access to EFI variables on the aforementioned
>> +	  platforms if your Linux distribution has QTEE supplicant installed and
>> +	  running.
>> +
>>  endmenu
>> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
>> index 0be40a1abc13..d780490b2865 100644
>> --- a/drivers/firmware/qcom/Makefile
>> +++ b/drivers/firmware/qcom/Makefile
>> @@ -8,3 +8,4 @@ qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
>>  obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
>>  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
>>  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
>> +obj-$(CONFIG_QCOM_TEE_UEFISECAPP) += qcom_tee_uefisecapp.o
>> diff --git a/drivers/firmware/qcom/qcom_tee_uefisecapp.c b/drivers/firmware/qcom/qcom_tee_uefisecapp.c
>> new file mode 100644
>> index 000000000000..9a5a6f145a9f
>> --- /dev/null
>> +++ b/drivers/firmware/qcom/qcom_tee_uefisecapp.c
>> @@ -0,0 +1,525 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/efi.h>
>> +#include <linux/tee.h>
>> +#include <linux/tee_drv.h>
>> +#include <linux/ucs2_string.h>
>> +#include "qcom_tee_uefisecapp.h"
> 
> You are the only user, inline the header here.
> 
>> +
>> +static struct qcomtee_uefisec_app uefisec_app;
> 
> Do you need global data? Can it be obtained from other context variables
> using container_of()?
> 
> 

