Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF79EC61DFD
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 09:22:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0C3F64539B
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 09:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788340953;
	bh=Ix9gy4iNaJC6TKz8JfDA7ApKhF58oPVDVuveegmoPss=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=OJbOcv1l+m/ciRRQXplSpN2MCGWig8vQ4riWAjlL3r8OGEW0QmFHsIWRBQQOlw8/C
	 8DyY2NiCerhu9SlkNSgasZwmm1Yb8RVA/2yVcLn6frFfcIQP2iVdEGIlO5Zh3O4cCF
	 Dirt8HSBPMiBmzbCp4mtZl9CTVDlhJi+dtaNy6TRAcBGO9fS47sl+k6ZdvkBESFuRo
	 H6nRn0RpWZAs49PBJ8RxRt3Hj9nvN8jN7fuOWZ+4iIG/XivRnqhxYvZalpwef6k99b
	 ir/tEz2geTpHihg9RaTgU6P6UyNK6KQRbN+vaB0QfOWxYrcqknYScJKasQljqFCSDq
	 sPBGJwAV6hiQQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D4BA74425E
	for <op-tee@lists.trustedfirmware.org>; Wed,  2 Sep 2026 09:22:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hz8QZcL1;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a6Zx4vgp;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682952IF1550884
	for <op-tee@lists.trustedfirmware.org>; Wed, 2 Sep 2026 09:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2B9311cIh3QhjI7jQVcMJXJqQDtRI7MudWJkahg+Q9M=; b=hz8QZcL1gUEAjyF4
	ifjO6XomZtCApAIVtzyZN5VGc/KBHr0C4BFQZGNxDWd/gjAePmX/FvTl1ac4XmCv
	JPaYtInDdPtRyXuAJ908ypIDApb9Dhhm40y80KMJiN5oSF8+YhwUkpHxp2UkbdPp
	IsuH1N6XJBOZCN4RnWMIyUqbFGwQfoEeOQkjqBNSbd6V2mabEUI++EJT6pE6EI/V
	fVmAC5tf5XmdF0ZH4fwMOzbjcCHiTKR3tq3ALApU5yHiQfsGTQ1ooRZMHo8wkO+c
	MdictcwhoVU42e5IceF9an6Vsq+1yehbhZmIfn1A5XwhMUk11r7Byr9bBoD6VgEB
	rKA67w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geguy021g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 02 Sep 2026 09:22:25 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso1914809a12.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 02 Sep 2026 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788340944; x=1788945744; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2B9311cIh3QhjI7jQVcMJXJqQDtRI7MudWJkahg+Q9M=;
        b=a6Zx4vgpLO8Sh4NSTJlRVktRJVgcp7qHmH/ikOMr610K9+yNXx6dC/Csm1ky4lws5T
         ojUsRYid51g+S0ND1ccTzkDmWsCMBSpCVM+911Hr7HkmXCsJrdUde9xVnJxUmH9PrhTP
         3RfXA4aTwsOPwRoHMsd3Ut3h+zfe+D39ip709C+rfojiF0xGLnnYAnnVocx5Od02VwDb
         q29DlhrtNnAvVex2VfobjgmPVMb+NOkBA+QDKUFfW4WDkLQq+PZn627P780EDecWVWkP
         tMSQ2OzNsJ78LiNqOw1JI6dpIw1u2NteLYCLl27hCdZ46QCqfklRZVGDJV/tGxxH+ORO
         NhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788340944; x=1788945744;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2B9311cIh3QhjI7jQVcMJXJqQDtRI7MudWJkahg+Q9M=;
        b=lGavf2eldHlYKW+6U+i6nPPN7kxa+ZRPJjH5N0sG9QMQyIdddsYnaohof+fg9AwqaB
         0heZg1SELqA+ycfanOzBX0X3ZXJTXLqAH/P1fbwE5B2evCJuvQUGCPm79jhX1gdXQ18m
         fGcACMiIAT9eW/PB6i6/hWGySXPvofZGTeHOfa2eMnTSXpW+bb4/Hsu1HzaTIHdI0hL3
         dAudEir8VurG+cEyo/v37EfwZWlgOq4XxitWIK+H3MoAFdDAGQft6CYlnpG4TTcUctdo
         a3J7VXO+BtF27FX4zRFbH6jtjHRajobepmgBL3hl/zwEHYu/q1YZtsAe+9BHW00589QB
         nypg==
X-Forwarded-Encrypted: i=1; AKwUvBwwFQeUslU6vMF27ICtj7s2WVZPu/oaa4nlCJMgsvGlMAt3Kt1J552k6BKncafki2mgyeDD0LQ=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++lNNHW4S5lAUAF3GDqaQxemLevhHbNocudaWFMadLUZtp4LYgmo
	9FevYxybNnx0OeQKcEvCZKCIFVHsqZK/Bzx1uNJ/SLPu0wGIIFbG6ydZf8Gthhskomxlop1oYyg
	DcL18McteYw/IK03DGPFu5Z8IPG92Ol5JTRi/8BjoYuvKejkZSA5Caq9uVdmO6jg/NRAUne27
X-Gm-Gg: AYBFou0WQPE3sBKllLVJo4gAIPu8bqh+aGjIbQpioDK8qr12C0nN6BJ04KeF/VljrDG
	KHq9a+HMz7nU1SReA8KeU3Czll3NyzJJkGGsW/Dh3zVflbJplIIDz3ZYwMVOUlNnZhxEWNraiQF
	aCQcVgMaNwP4Oy9P0XfjBuu3yKWGChoEEJsgM3WDqoxTUx0R/Ttc9rRpN2wKkZLSIhaJoWFO8DQ
	UmRCr0vdSeOA7I7cUjXjwFvf53H+XEh93W4ztH1lRt6dZihUcgZY6iRRtYI7aiHzE+PofLHbHAN
	yG/Of0AMOQY4USAINurdKZUM0B7sAycM4XnIpBiro9vHrI411WZJ1gy4WVTl16Y4tooh2gmkZ7r
	IpgRiPI0sg+mIerxbK9X6vs/zTSfluyU=
X-Received: by 2002:a17:90b:54c3:b0:399:ecd:d68d with SMTP id 98e67ed59e1d1-39aee26286emr5767765a91.22.1788340943834;
        Wed, 02 Sep 2026 02:22:23 -0700 (PDT)
X-Received: by 2002:a17:90b:54c3:b0:399:ecd:d68d with SMTP id 98e67ed59e1d1-39aee26286emr5767708a91.22.1788340943425;
        Wed, 02 Sep 2026 02:22:23 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079f7d77sm4998797eec.12.2026.09.02.02.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 02:22:23 -0700 (PDT)
Message-ID: <38984608-4b5c-4355-ad85-8c5a1fb78cb2@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 14:52:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] firmware: tpm: Introduce tpm-qcom driver
To: Jarkko Sakkinen <jarkko@kernel.org>
References: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
 <20260831-tpm_qcom_driver-v1-2-6f16fa6924fa@oss.qualcomm.com>
 <apbXKZrjFdK1vrny@kernel.org>
Content-Language: en-US
In-Reply-To: <apbXKZrjFdK1vrny@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=UZthjqSN c=1 sm=1 tr=0 ts=6a97ead1 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=OCHYf-eeibxfj-F0XOcA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: Vz9TmYL5haE06aq2i0i87g3T_2kFamRK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA4MSBTYWx0ZWRfX6n08kAkEyoko
 7yeLga+EA1lND6qVMWven/oynqT/UU4YtQGp+ln+VOW2pwYCpRtpUbGAV61w3p/VhoxkcVmFDcZ
 Mz6lX1NHlMhkw3aFPyIcu8xh4aHR68Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA4MSBTYWx0ZWRfXwXEf/Sp4p48G
 08cbf0nJc7ljJcIypU8h1C2AyeYIPLfjoiMhQTTEiMxjx2RSvpiW0xvuZYxT+6YZWvHXTLSBWL9
 Pw1uG+HA9W/+yQ66C8I3OuBTx/h8hOsSAWfdMUVZKVyvSpWbFzLhPR6xMd40fe4Rb0LNFHvuuF3
 pL7TwE51wiFWEL5S822fLkzU6MrHkbdDJd/9c0wcllCozuX//jsN+0nBHlRc6Pgi36gNAsKYcrF
 nwtTHLqN0vDmPS11SobhibrFEyO/k/B0ZLu/CfsKdwtW44aMFNssytghI4Ej3A8l54JfC4TaVYX
 Np9DCtVQln/xaLa5R04I63+mKXdaVVawQJPSeTTToBZGwum7B7Dvdh6sr+zhOKqA1w6YNKF7MHD
 C3bs7tB78Wzhw90M+7Jcc/Lx9Z51uBIUKxFZA0vgzjm6w1GaRZpet6nWA1dJdgrukYGTWHOJSlY
 PCYkwwnLrn4U9V1bYVQ==
X-Proofpoint-ORIG-GUID: Vz9TmYL5haE06aq2i0i87g3T_2kFamRK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020081
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.197:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D4BA74425E
X-Spamd-Bar: ------
Message-ID-Hash: CJFOK6MPCEYT4O3IR7DGVYTI52HMRA43
X-Message-ID-Hash: CJFOK6MPCEYT4O3IR7DGVYTI52HMRA43
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CJFOK6MPCEYT4O3IR7DGVYTI52HMRA43/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

On 01-09-2026 19:16, Jarkko Sakkinen wrote:
> Short summary has a different driver name that is implemented i.e.,
> it should has "tpm_qcom", not "tpm-qcom".

True, let me make more generic like "Introduce Qualcomm TPM driver"
instead of having driver filename in commit title for any confusion.

>>  MAINTAINERS                 |   7 +
>>  drivers/char/tpm/Kconfig    |   9 ++
>>  drivers/char/tpm/Makefile   |   1 +
>>  drivers/char/tpm/tpm_qcom.c | 371 ++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/char/tpm/tpm_qcom.h |  82 ++++++++++
> 
> Rename it as tpm_qcom_tee just to be aligned on how Microsoft's fTPM
> driver is named.

I'd say firstly microsoft ftpm driver should be renamed.
For example, MS ftpm is based on optee(session based context) whereas
Qcom tpm driver is based on qcomtee(part of same TEE subsystem but uses
completely different mink-ipc based sharing mechanism).
So, it's completely different driver compared to MS.

My suggestions:
 - Rename MS driver i.e tpm_ftpm_tee.c -> tpm_microsoft.c
 - Rename Qcom driver i.e tpm_qcom.c -> tpm_qcom.c

I see pattern like tpm_{loongson/atmel/ibm} etc. so better to follow
this convention?

If ever need optee/qtee to specify, more namings can be tpm_ftpm_optee.c
and tpm_qcom_qtee.c?
Personally, I don't prefer tpm_ftpm_tee.c as it's all generic name with
no optee specification.
 >
>>  5 files changed, 470 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 47b04968e79a..cfa5b66823c7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -22636,6 +22636,13 @@ S:	Maintained
>>  F:	Documentation/tee/qtee.rst
>>  F:	drivers/tee/qcomtee/
>>  
>> +QUALCOMM TPM DRIVER
>> +M:	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>> +L:	linux-arm-msm@vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/char/tpm/tpm_qcom.c
>> +F:	drivers/char/tpm/tpm_qcom.h
>> +
>>  QUALCOMM TRUST ZONE MEMORY ALLOCATOR
>>  M:	Bartosz Golaszewski <brgl@kernel.org>
>>  L:	linux-arm-msm@vger.kernel.org
> 
> this change should be a separate patch.

Ok, let me make MAINTAINERS entry as separate patch.
Also, i noticed none of other driver are being even compiled as 'M' like
atmel, ibm etc.
Any obvious reason behind this?
Should i enable tpm_qcom as Module in this patch only.

>> +	print_hex_dump_debug("tpm_qcom req: ", DUMP_PREFIX_OFFSET,
>> +			     16, 1, req, req_len, true);
> 
> Please don't do this. It can put production systems at risk.

Ok. I want to dump some contents on failures which makes debug easier.
Instead of dumping entire req/rsp buffer, dump tag, reqlen, rsplen etc?
>> +static struct tee_client_driver tpm_qcom_driver = {
>> +	.id_table	= tpm_qcom_id_table,
>> +	.probe		= tpm_qcom_probe,
>> +	.remove		= tpm_qcom_remove,
>> +	.driver		= {
>> +		.name	= "tpm-qcom",

Whatever naming we'll decide, I'll update same here too.

>> +
>> +/* dTPM SPI transfer optimization:
> 
> Block comments AFAIK should be
> 
> /*
>  * <TEXT>
> 

Let me fix it.

-- 
Regards
Kuldeep

