Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EABC61DE2
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 11:26:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E61AF4440E
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 11:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788175601;
	bh=SZXxCQIYWsUg4ahPxedyt07MQGWzfBccOL+3jDOGBDI=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=LCah5kLbtAeDT78pI7iRxfAcyQ4WK2d9WRJoa+AXOnqEGsGTCRly5zqSLrZ6RppOF
	 BKWkYIn1MKORUMmMpVh5lKMCozWjK/UEXusEfc6kqTfvhaHpFnWwGg7H9dY0KD5P3S
	 znhXtoCpjQmru4nLLSBZRWHG8nJFgximKSG2glMYUKkAT9/aDHGZjfRdCvzlycNx1k
	 TjHMiMFhhg1BSoIMnYX8hlegs7kWVssKGPLti8gPN8I26NKLUFdTThPYrdNbelCTrP
	 stecgbn5j7XRi9TgzZdk+64lHIOMm1LUlygoV0vok7QgueM8VDN9BJyfy3WWfrWLcI
	 W4d9tFuF+N7nw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id ED4CC4440E
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 11:26:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Bc03u2+N;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DTsiYGSF;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBAXXE3255896
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 11:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UWuFeN+BQaevlcj0WqFSPunVnUDxXUWFNKXnkxSodb4=; b=Bc03u2+NH7c4uu+s
	J1dZYgqF4br/6toJy6mLik8ITJ4t7A+mRmTgLL0X8kqvehy8o7bkag09Y4R2S9gd
	D3ycLojvfpHaJL6/VEb13SUY1HfG8unNch4qSA5qtfpTR3bGaHA13Im/4zAu6RlL
	Pcp+1AZqm7JebwGGcQmzLoDtcgDhzzrJ8kRDmHKyO5oLdN6TUDWoD1V3yFrmG8iC
	rpc8GdOAzV/2K+S7qUS8WIi6hczqPOuSbzA15q4178q+vcK6IFC/qmXtD0GoYPN1
	Vx+P71Mx2jDUWbx2Kld/LSiL0eRb7jKKepI3wQAXp1YJM6MyxIip5Rlw+LL35BqL
	u4EWhA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6yarecy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 11:26:33 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1b80835d5so5544559a12.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 04:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788175592; x=1788780392; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UWuFeN+BQaevlcj0WqFSPunVnUDxXUWFNKXnkxSodb4=;
        b=DTsiYGSF0zR07ANHGqKph2z62dtHdGIzSo46Hx4v9iB0/G37JyuJXSb2OWTWa63+YW
         dHhm3iZOZHTid8f8K+51AEg+20nst9OewbOtYEwekuRTVEFPhAJYVxW/81TKWOxMgbZz
         ZV6XPiJpbV/cHYp3tniUK3nP250auIEgHl4bRTdzADT1SKBTOLaYNFn56ftCYKsw5WWv
         CWUvA/WFPwcUNizAytn0knrWjWW+LWxCdd5Q+KL30AljW5mjFPKivGaPzjB1gbwzt4zY
         gK4JpM9tkjaf05Y6hi2l5irBAl37Raab4G/S+phYuxoSfVA6+kKFTVZtwL/wccycxKaD
         OEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788175592; x=1788780392;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UWuFeN+BQaevlcj0WqFSPunVnUDxXUWFNKXnkxSodb4=;
        b=De5/ruOwZlLt1Cbx6sukG6HcjlhuIK5Z0sjr228T/ztD27sKuC50Mpfg83ln2MdMvV
         vnRCN+8d0BqoSyMe5jktxJrLKFczjkSfZSsNTuYhF5HI263OXIz7okRAMUAZolpTaqhJ
         wn7BIB5/kqUXWOliw2W9D9Y7HGuTvGKduml7SeEgJmrBmUxhBM98K1mt18M+C5qdtpIU
         vUwKHkd4lP8WS7RKeW8ENa4vr9SGMdVxbStHbVV3w9/eZwsndvPmQq2nuX7dAzdKlPwM
         ONSEEtWzLPYLhNtf3973tX3kse3JYuD6g+ZXidKahgDVnWA2EkbOi4ukoExXuw8KuRva
         VYKg==
X-Forwarded-Encrypted: i=1; AHgh+RqBB5YNATvcWupSZCWOGWzMTv0SB1DSvYvTRNKD8FXRbrg3ovgBSVAiAdfaJw39SRqLcjkvNPY=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++ma/ICuG5XjjxjacTJXmqKTgLqTBSHosoZ1+BYclcyF8N2RY0wh
	0cMBbfIIrQlSJXCWzaoK52QQDeLwI3mN1yLWaXCLX4NOmi6p1puc58lb201EipJcpT9entSSBBk
	u60+dz5YEoVndTIo1zaQ4HxQwZ3OszUMogG18/t9nxJdBLcwcdGiNYpYl5l+L/pnek8ks5ocrK3
	lgpYpt
X-Gm-Gg: AR+sD13gxuNGK+y7D9CRiTSHxACewFlhwxgjnJhf/W6qlIdM+DI0ubWZsVWLMDcsdPE
	HbhzrJKf+18quS1b7doFrkC1yIKvhfrTOQr7OhUowGalYPlZqm8lsSjLGJtoo1SVBLGixPeRXiI
	rQetVDnZkI37GDqfq1kNPC/KGsqcPx9lNGug+eMlmbXMlBswK54lB3OU+NWKwJzCRgj5Sv8ifAk
	vuuT1bo0+yox+R3OsdfqHk7Qpn3V7Gwp2fVh2rTM0nuwXvSzySes1mv7o/bg4wYahvESNKnIgCb
	VCzdAOoi0CEdGMrbxShY1gAS5rFW2MnsXw1+/pfPYp45JLbvHg4KOLCfmVDX4Wdut7oSvpfoJtZ
	hXcrc1yc4AQolVmnnwYe0/4b6Z2WoSgw=
X-Received: by 2002:a05:6a21:a0a:b0:3d0:abdb:de03 with SMTP id adf61e73a8af0-3d7ad788edbmr439189637.2.1788175592309;
        Mon, 31 Aug 2026 04:26:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:a0a:b0:3d0:abdb:de03 with SMTP id adf61e73a8af0-3d7ad788edbmr439110637.2.1788175591875;
        Mon, 31 Aug 2026 04:26:31 -0700 (PDT)
Received: from [10.92.160.219] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f99585csm28349834eec.21.2026.08.31.04.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 04:26:31 -0700 (PDT)
Message-ID: <8a61f8b5-bead-4114-8363-42b469738599@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:56:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] firmware: tpm: Introduce tpm-qcom driver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
 <20260831-tpm_qcom_driver-v1-2-6f16fa6924fa@oss.qualcomm.com>
 <e7f7f0ea-cb63-41f2-93c6-5d47fe4cca3b@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e7f7f0ea-cb63-41f2-93c6-5d47fe4cca3b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5OCBTYWx0ZWRfX0PDhwKADKSsU
 6jrcoDLWqUlVNjyknBlVBz9Uw3CWqzeA2eSMcb5406XxoeaDD2tKIBUItOYphI1568Tg7Sigzqw
 MDiHsacMWY3a++tGoHxLhanGZaSbAHg=
X-Authority-Analysis: v=2.4 cv=CpaPtH4D c=1 sm=1 tr=0 ts=6a9564e9 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=I8atxffxcjRlebx0Ix8A:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5OCBTYWx0ZWRfXwRvQDzrow6a4
 5ytJh5Aq+H6QjDz8stXV5uVylGR5l01quZqSTeIanTicQnrARc4wKBO6yHBAK3AV04ClrCvlP+B
 V/NRn+qpGwhg87Wr2hJQr5rxr70DAdGmTx8RIq5FLHhlIdJk7576eaivOuc1adB3sxZns6B5UoY
 H88uzOQh7wdNSx64VFF6G8BlIvnnGef9WL0inXQqg0ZrImfYh95Y6yu9S/+jBe74ju2T+vdE8uy
 V0PVZDDBW384OVQxBmOEce6/Gd5J5gpil5VaSTdm9smdvpP05xjDoWZyldDMz55wn1DAfvSBqQl
 AnZDmQBSKqZybgcT6td48z4yr9KFtjU3QXiwId30xDTS6gx+SRQUwxKhqlvVqh95rqhvCLN2otX
 EgX7mS2/yDNlse75EXPIlMkPPiL59tkuvZjJV7guJvrovdNOK0nq9XIHgLIHu5NGwbSytcFFH9I
 5hDHuuZ9C5HUuOVJevA==
X-Proofpoint-ORIG-GUID: xYUAuE7N2VgR2RX5MQjQ2_vTToYqAYu9
X-Proofpoint-GUID: xYUAuE7N2VgR2RX5MQjQ2_vTToYqAYu9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310098
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.09 / 15.00];
	BAYES_HAM(-2.99)[99.96%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: ED4CC4440E
X-Spamd-Bar: ------
Message-ID-Hash: NLP7EAWK2M7UBYRL47GC6WK6UWLWQ24Z
X-Message-ID-Hash: NLP7EAWK2M7UBYRL47GC6WK6UWLWQ24Z
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NLP7EAWK2M7UBYRL47GC6WK6UWLWQ24Z/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

On 31-08-2026 16:45, Konrad Dybcio wrote:
> On 8/31/26 11:43 AM, Kuldeep Singh wrote:
>> Add a TPM chip driver for platforms where a TPM 2.0 instance is
>> implemented by a Trusted Application (TA) running in Qualcomm's Trusted
>> Execution Environment (QTEE), reachable over the QCOMTEE object-IPC
>> transport.
> 
> [...]
> 
>> +static int tpm_qcom_get_client_env_obj(struct tee_context *ctx,
>> +				       struct tee_param_objref *client_env_obj)
>> +{
>> +	int ret;
>> +	struct tee_ioctl_object_invoke_arg inv_arg;
>> +	struct tee_param param[2];
> 
> nit: Reverse-Christmas-tree would be preferred

Ok.

> 
>> +
>> +	memset(&inv_arg, 0, sizeof(inv_arg));
>> +	memset(&param, 0, sizeof(param));
> 
> You can zero-initialize local struct variables like this:
> 
> struct foo bar = { };
> 
> [...]
> 
>> +static int tpm_qcom_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>> +			 size_t cmd_len)
>> +{
>> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
>> +	size_t rsp_len = PAGE_ALIGN(MAX_RESPONSE_SIZE);
>> +	size_t copy_len;
>> +	int ret;
>> +
>> +	if (cmd_len > MAX_COMMAND_SIZE) {
>> +		dev_err(&chip->dev,
>> +			"%s: len=%zd exceeds MAX_COMMAND_SIZE\n",
>> +			__func__, cmd_len);
> 
> The name of the function isn't helpful here, this is the only time this
> message appears, so it's easy to grep

Sure.

> 
> [...]
> 
> 
>> +	err = tpm_chip_register(pvt_data->chip);
>> +	if (err) {
>> +		dev_err(dev, "%s: tpm_chip_register failed with rc=%d\n",
>> +			__func__, err);
> 
> Likewise

Since it's dev_err so dev name should be sufficient i think.
Let me drop function naming from log.

> 
> [...]
> 
>> +#define QCOMTEE_TPM_GET_TA_VERSION_ID		0x0001000
>> +#define QCOMTEE_TPM_TA_VERSION_GET_MAJOR(ver)	((u32)(ver) >> 16)
>> +#define QCOMTEE_TPM_TA_VERSION_GET_MINOR(ver)	((u32)(ver) & 0x0000ffffU)
> 
> That's FIELD_GET(mask, x)

Sounds good, Let me use FIELD_GET.

-- 
Regards
Kuldeep

