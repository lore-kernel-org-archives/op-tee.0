Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04783C61DC2
	for <op-tee@archiver.kernel.org>; Wed, 26 Aug 2026 06:43:40 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2067F4502B
	for <op-tee@archiver.kernel.org>; Wed, 26 Aug 2026 06:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1787726620;
	bh=q403S9e+Sfi+3O/hpfdZnkJprnCtM+S0MgLho3vggfk=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=wKZMlIYdMrRhYLNdBxPusq26ptlvuTbqHIA4b5bUX965t+5BZpyhQ2+ZnS4P9gPCE
	 qsSTNPDBdu1jyLt3aTq/32B1kbmfm8zzm1bCcFFGv3ZRsppG1sU+O8HwOBPdGqLFgH
	 IsumDzXpFYIyASQ8DGj8pzxUJgMwgwuFo+jxpw6o/Zn8Asfj5yL7Rr/lrWVik3Zvpo
	 G9K3SU1EhH4myg+8HpARQtoyu+eTOGAXdmUtiVYr3UD1MNgh3/iCJfPLICMA3IvPPt
	 DVXHSE5sfydMAH9T+eMhMF6n5CGqS4HwTo7pQyP2aO8nyhY7X+xaHgEypOe8o44Ym5
	 iRJ21ELIkQoHQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C476144F84
	for <op-tee@lists.trustedfirmware.org>; Wed, 26 Aug 2026 06:43:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S9NNM1G4;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A/O1aSVk;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q6Rkuk3783810
	for <op-tee@lists.trustedfirmware.org>; Wed, 26 Aug 2026 06:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N8moZ+/M0nEerOY16IdmXKS/iPUqJXoq98V/IQ5O1dw=; b=S9NNM1G4EWd7yiLp
	0Ci740QgS7aYYxO0u0IGQamHqsWLYkh6VqYX8SaVTRtHo84n4+dXyCCBWJt30YDL
	PcHKJG8OomaL0n+C99ydrqtX2QuVjr91lBRcsk7+Gl9PPt1vuKc/N6OP9bMFkK+h
	lmc1zdc6sIMRQXIswAWeZ4wcYlZJL+CR2JD+lX5JS2w/53/HNQ9kbYfwR6/Ys15o
	i6ZvWqTHFX8UTx4JUudw9nSlinONdd8ZLEHq8ltS8dLLOpy8lXzRLe4xSQOG/k6t
	t9nWP0o9JXH4HhNQJ51QYLd4QIZf9aFWcdfW2EDWpzUdpjZaeEZjzSnT+3pw3PSM
	v033ag==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9s9g8e3n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 26 Aug 2026 06:43:32 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbee6bb8408so782267a12.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 25 Aug 2026 23:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787726611; x=1788331411; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N8moZ+/M0nEerOY16IdmXKS/iPUqJXoq98V/IQ5O1dw=;
        b=A/O1aSVkYgdN71mEVKqk3jZEbXNyoCaeksGTtH2mrnhZHbAvB/PmTlJv1JfcNxEl1i
         QpPlWYI5ZSpPgHzRUwQJOe226EChzV0CeOtBe746oUiG8sBSBSxRugwovf7Y6Jk3gH6B
         r+smULb2Yt2mbnX6v6wh7wJPvJ15SysyWL81er0IJ4Yt5nmBKgwDcXZKlCOCC/yT3rm0
         wmXifzjejz2Nl2AESi4Iffq2i3QVp3ZCIWjVOWs0w0Bfv57aGRO3mu3yif+vb6x5uItR
         5Z0HyS+/HkxfEcj+tVynWOoBp3np6AhsdIoWOT3/Wr1aLokf+ToO/coLfLnC77kDk1qg
         fCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787726611; x=1788331411;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N8moZ+/M0nEerOY16IdmXKS/iPUqJXoq98V/IQ5O1dw=;
        b=Cd8DOxnBS24CKK6iE+uwfJCv66khqK0c+rtwemKHjrdyicK45REq8VaNwncq43fFwj
         8k+tBp5ApRtK5wAnYuO3Aq5m7iatHfVujSaO2AVte3RHJ562c25AZ4Cqd9UGi49ZI1DQ
         kUlsrNw7dcoxlU/pWKTRfOvRY3Uar1T0GKJUCWtwITwr55HFP7m6/Pp2akf+U+gMsBoO
         ePro1hK2QiKjrOaeEt3cfBHg1v2LJhwm5F44A4BoMN71vPf3IngRtJtwOA35eidIrWLW
         SFVX6sySWANRn+EP4cysNQvgr/Zfy/o3eB9G0YPU3i38STgjSgeQUm5yb9Lv9p24o7M0
         6K8g==
X-Forwarded-Encrypted: i=1; AHgh+Rpj4X2Oc2R53J9w3JRA8jUvr4WuFMEFV3nAJymUE/InTaZ53cWTLkFTTeia2ht0KvFpAML2hUw=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++kYnUpwlTBJ//QLuDQwpVEi5iZ0zRtRhco4evH4ro8BS3eSktaQ
	OVtSke9fGU+PApHTPOBH7ZbffbS7l6FcR1CVSjV4JJKLjebn//9SfMI5ulMPnP0SNZ4JlsfINvr
	jfFVGLAFbhvt99l6J1y0omgwcpKgGPhi/5TX8Dzp/JK3KegXjxBiY1X2P6sWHQ071WeYy6pEe
X-Gm-Gg: AR+sD12OCnoCfOx71nwiyWpH/mAXklWe4AubNRyNlwtOQl2aikOFp326nd9Ejhbr5Eg
	KrK1ZUQqzTGqfYObDYJcfC4CsHMieL3Ux2lUyuxAKsmEH1PsUha92NfWu9ycQ4YZ3eLojOVyB5W
	TYwuDRrdEdpRKAcGzB2IFvArkATqwMcLkpVWENZGelueDkbfCrgDfQz9k8IB5mPWSfHrLdWwuA5
	8IMZc7jmqzy6ss3PD0Ld8FdRGupALJ/WjqGwCT1P00tVsdwArqLaU8BrLMBAQfmFtSjtcLMankK
	I8dUdWtrr5ZWijPZr9NtWosWLaoAOxVDWLRuULzgHiXoqSPFKLvKYmt6IpOvOzGiPC5MHz5CPA7
	anVZG3XNwRx+rT8FPUdmwqpYCIFg5
X-Received: by 2002:a05:6a21:6191:b0:3cc:ad3e:bd7e with SMTP id adf61e73a8af0-3cf8465a5cemr9447364637.14.1787726610905;
        Tue, 25 Aug 2026 23:43:30 -0700 (PDT)
X-Received: by 2002:a05:6a21:6191:b0:3cc:ad3e:bd7e with SMTP id adf61e73a8af0-3cf8465a5cemr9447238637.14.1787726610335;
        Tue, 25 Aug 2026 23:43:30 -0700 (PDT)
Received: from [10.92.208.189] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8f20095sm5110857c88.6.2026.08.25.23.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 23:43:29 -0700 (PDT)
Message-ID: <59181c97-87a2-47a1-91f6-558f4cd1416e@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 12:13:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Add TEE based client driver for UEFI Secure
 Application
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
 <nfijwr2ptpxqvdw625yedep7tmakwvkeavyeobrmig5hbkw77w@rcqyp7h4y327>
 <db27820a-2b43-45e4-bc4a-0e9e81aacd93@oss.qualcomm.com>
 <oicbypv7rpxmweclopi5xxpcfq5chnypp5tlqd4uix2pm5e72f@kd3bibeximjq>
 <10a091a4-89a5-4a0c-820d-c5b91dd52529@oss.qualcomm.com>
 <ebcfafdf-6cd3-49cc-8096-d1289af75fd5@oss.qualcomm.com>
 <57335851-3c04-4452-ac31-2020591ef816@oss.qualcomm.com>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <57335851-3c04-4452-ac31-2020591ef816@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -yFQHuAReB06o5MmzSv-dlbBAwGD79xc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA1NCBTYWx0ZWRfX8E/u/OMA3HiX
 c0tgi38Pv5lOyhrECyNFhLXfQcTSCdjCh4hacVPxAcfQ6ZlMrpVBCe4SAoJCvyZGkY8QD1fPH5u
 MDsossuNiSYZHxbNOucuxGVqgigQz8jcxJ7TBfSYIJuspmG6V0i2YIkB398BWudVSOxo4by6YLU
 qGsdlVKn/KCxkxQCAG3Ftm0bPkGHPqOkksTMDVAFcIH7iTS7Py/Q0h1A8vIG3lUgZ67jQSOsu6T
 NbRPYEJhYyy2tsJmqIwOaPP1+UkiuM+A85OcKYyw4/nhD96ZXom6P7mN8ULSYfI5KaynK/+XtZk
 6qaO9Up5cCCW9HcRGdK+tWogR0ImDhN9IPwnw+tPg+mMbrhHYTLeOofcm08cmSlLbrxcqEB8qdb
 ddDwG9C6NdQ0y3zsWO7aR6J8UCFctBUm2uQRBdxieWExHeiHK/77GjtKm6J7xzFXx/Ra+OMJ1pk
 nrbFHdOISAGRu/hMz8w==
X-Authority-Analysis: v=2.4 cv=Xfq5Co55 c=1 sm=1 tr=0 ts=6a8e8b14 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=P-IC7800AAAA:8 a=NEAV23lmAAAA:8 a=FOMsayToMjXHAPHFNagA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA1NCBTYWx0ZWRfX4RmwF/Uv3A/E
 C86Nu+/s5ny5ljljJktqbl/itjOHhz9pFJAH9yFEDMmPrbikLNAeRqdSMlCz9a/jhTDT0gLPKXV
 Sq+RJxJP9a+IIi2yVvbQZRTyKgKg7y0=
X-Proofpoint-ORIG-GUID: -yFQHuAReB06o5MmzSv-dlbBAwGD79xc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260054
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.198:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C476144F84
X-Spamd-Bar: ----
Message-ID-Hash: KSLQ2TU7CZCMRENRTMNSOA5ELNDA6DQ6
X-Message-ID-Hash: KSLQ2TU7CZCMRENRTMNSOA5ELNDA6DQ6
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KSLQ2TU7CZCMRENRTMNSOA5ELNDA6DQ6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Dmitry,

Gentle Reminder.

Regards,
Harshal

On 21-08-2026 02:04 pm, Harshal Dev wrote:
> Hello Dmitry,
> 
> A gentle reminder. Hopefully we can align on below points and move to
> a v3 of this series.
> 
> Regards,
> Harshal
> 
> On 17-08-2026 11:54 am, Harshal Dev wrote:
>> Hi Dmitry,
>>
>> Many thanks for your engagement and review on this series. I am looking forward
>> to your opinions on below comments so we can align on a a v3 of this series.
>>
>> Best Regards,
>> Harshal
>>
>> On 12-08-2026 05:00 pm, Harshal Dev wrote:
>>> Hi Dmitry,
>>>
>>> On 10-08-2026 12:37 pm, Dmitry Baryshkov wrote:
>>>> On Fri, Jul 24, 2026 at 02:43:42PM +0530, Harshal Dev wrote:
>>>>> Hi Dmitry,
>>>>>
>>>>> On 22-07-2026 01:56 pm, Dmitry Baryshkov wrote:
>>>>>> On Wed, Jul 22, 2026 at 12:29:11PM +0530, Harshal Dev wrote:
>>>>>>> On Qualcomm SoC based platforms, UEFI stores EFI variables within the
>>>>>>> Replay Protected Memory Block (RPMB) which is only accessible by the
>>>>>>> Qualcomm Trusted Execution Environment (QTEE).
>>>>>>
>>>>>> Is it so? I think RPMB is accessible to Linux...
>>>>>
>>>>> I should have been more descriptive here, RPMB is accessible by Linux but
>>>>> its frames can only be prepared by QTEE.
>>>>>
>>>>> The RPMB key which is one-time programmed into the storage controller to allow
>>>>> authentication of the RPMB frames is generated by and only available to a TEE.
>>>>> So on Qualcomm platforms (and many others platforms with a TEE) Linux can only
>>>>> route the RPMB frames generated by QTEE to the storage, it cannot create and
>>>>> write the RPMB frames itself (it doesn't have access to the key).
>>>>>
>>>>> While it is possible for Linux to generate/program/store this key, on Qualcomm
>>>>> platforms we do not want Linux to do so because we do not trust it. We trust
>>>>> QTEE.
>>>>>
>>>>> I will re-phrase this and make it a bit more clear everywhere.
>>>>
>>>> OK.
>>>>
>>>>>
>>>>>>
>>>>>>> For Qualcomm platforms without emulated RPMB support, specifically
>>>>>>
>>>>>> What is emulated RPMB support? Why is it mentioned here? Which platforms
>>>>>> use emulated RPMB?
>>>>>
>>>>> Emulated RPMB refers to RPMB on a storage which doesn't have its own firmware.
>>>>> Primarily, NAND/NOR storage. Unlike UFS/eMMC storage, NAND/NOR storage does not
>>>>> have a storage controller where we can program the RPMB key to be used by the
>>>>> firmware. So we must 'emulate' RPMB by moving the storage driver within QTEE
>>>>> and making the driver hold/use the key.
>>>>>
>>>>> Qualcomm compute SoCs (Glymur, Hamoa) have RPMB available on SPI-*NOR* storage,
>>>>> and a driver for communicating with it is also available in QTEE. And so, these
>>>>> have 'emulated' RPMB.
>>>>
>>>> This needs to be explained in the cover letter.
>>>>
>>>
>>> Ack. 
>>>>>
>>>>> I will add this detail in an updated cover letter.
>>>>>>
>>>>>>> platforms where RPMB is not located within SPI-NOR storage and instead
>>>>>>> located on UFS/EMMC storage, non-volatile EFI variables can only be set via
>>>>>>> a callback request from the UEFI Secure Application to the RPMB service
>>>>>>> running in user-space (within the QTEE supplicant [1]).
>>>>>>
>>>>>> Can it be moved to the kernel?
>>>>>
>>>>> We have a plan to move the RPMB service to the kernel similar to OPTEE:
>>>>> https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/tee/optee/rpc.c#L449
>>>>>
>>>>> It is a work in progress. Once this happens, we don't need QTEE supplicant available
>>>>> on the Linux distribution.
>>>>
>>>> Ok.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Unlike the QCOM-TEE driver, the QSEECOM driver (used by the current
>>>>>>> QSEECOM based uefisecapp) does not support callback requests.
>>>>>>
>>>>>> How did it work then? I think Windows has been perfectly using QSEECOM
>>>>>> rather than QTEE.
>>>>>
>>>>> It works because Windows on Arm on Qualcomm has SPI-NOR storage. A driver for which
>>>>
>>>> I have WoA devices without SPI NOR. Windows still can store UEFI
>>>> variables.
>>>>
>>>
>>> Ahh, the key point here is 'Windows'. Windows has a separate way of providing
>>> RPMB access via a service in the TrEE driver within the OS:
>>> https://github.com/microsoft/Windows-driver-samples/tree/main/TrEE
>>>
>>> However, the Linux QSEECOM driver we have here in upstream does not have that support.
>>> And so without the QCOMTEE + QTEE supplicant combination, we cannot access EFI
>>> variables on these Qualcomm WoA platforms when they boot with upstream Linux.
>>>
>>>>> is available within QTEE, and so QTEE does not need to make a callback request
>>>>> to Linux to request RPMB frame routing. However, in case of UFS/eMMC storage the
>>>>> driver only exists in the Linux kernel and so QTEE must make a callback request.
>>>>>
>>>>> And so, if you try to use the QSEECOM driver to write EFI-variables to RPMB
>>>>> on a device with UFS/eMMC storage, it won't work.
>>>>
>>>> Yep. It seems to work under Windows though.
>>>>
>>>
>>> As explained above, the mechanism is different for Windows. A different driver
>>> and a different protocol. :)
>>>
>>>>>
>>>>>>
>>>>>>> And on
>>>>>>> certain Qualcomm platforms such as the RB3Gen2, attempts to access the
>>>>>>> QSEECOM interface fail due to lack of support within Qualcomm TEE.
>>>>>>
>>>>>> So, I assume, on RB3 Gen2 the QSEECOM doesn't report uefisecapp as
>>>>>> supported. Does it?
>>>>>
>>>>> It doesn't, this API returns -2 if I add RB3 Gen2 in the allow-list for QSEECOM:
>>>>> https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/firmware/qcom/qcom_qseecom.c#L46
>>>>
>>>> Does it support QTEE-based uefi variable storage?
>>>>
>>>
>>> It does, the QTEE-based uefi variable storage app, i.e. uefisecapp is loaded by
>>> UEFI on RB3Gen2, however, the QSEECOM interface on RB3Gen2 is broken so it misreports
>>> it as 'not supported'. But the app is loaded and available, which is why if you apply
>>> this patch series, you can communicate with it. Just make sure you take the QTEE
>>> release mentioned in this cover letter.
>>>
>>>>>>> On these platforms, a TEE based uefisecapp client driver is required to:
>>>>>>> 1. Access cached & volatile EFI variables stored in uefisecapp's memory.
>>>>>>> 2. Ensure persistence of non-volatile EFI variables via writes through
>>>>>>> the RPMB service hosted in the QTEE supplicant.
>>>>>>>
>>>>>>> This series introduces such a uefisecapp TEE client driver for the
>>>>>>> aforementioned Qualcomm platforms which installs efi-var operations _if_
>>>>>>> the QCOMTEE driver registers support for an object-IPC based uefisecapp
>>>>>>> service on the TEE bus during its probe. Only new QTEE firmware versions
>>>>>>> available at [2] provide this support.
>>>>>>
>>>>>> What about existing WoA devices?
>>>>>
>>>>> New Windows on Arm devices like Hamoa/Glymur work perfectly fine with existing
>>>>> QSEECOM based uefisecapp. But they will also work with this new QCOMTEE based
>>>>> uefisecapp once they upgrade their firmware.
>>>>
>>>> Do extisting commercial devices suppot it? For example, does Lenovo T14s
>>>> support it? Will it continue to work with this patchset in place?
>>>
>>> Existing devices like the Lenovo T14s do not have mature QCOMTEE/SMCInvoke support
>>> on QTEE side and new QTEE versions for it are not being rolled out. However, this
>>> QCOMTEE based uefisecapp driver and the QSEECOM based uefisecapp driver can co-exist.
>>> It will not cause any breakage of existing working functionality since the QSEECOM
>>> path can probe and continue as usual.
>>>
>>> As per your comments on patch 6 of this series, I plan to enable the QCOMTEE based
>>> uefisecapp as default 'm'. That way we don't need to enable one over the other and
>>> will continue supporting all existing functionality while extending it for devices
>>> with UFS/eMMC storage and running upstream Linux.
>>>
>>> Do let me know your opinion on it.
>>>
>>>>
>>>> What about other existing devices? We have WoA devices starting with
>>>> MSM8998. The QSEECOM driver works on them, but, as you mentioned, it
>>>> can't flash updates to the backing storage.
>>>>
>>>
>>> Unfortunately, unless we roll out new QTEE firmware versions for devices like MSM8998
>>> with QCOMTEE/SMCInvoke support + access to the Uefisecapp over SMCInvoke protocol,
>>> they cannot be helped with this series.
>>>
>>>>> I need to double-check but this firmware release for Glymur on Qualcomm Linux
>>>>> is probably carrying the support for QCOMTEE based uefisecapp access:
>>>>> https://github.com/qualcomm-linux/meta-qcom/commit/728251fcbe5113980805ea6c571e33235062ee71
>>>>> If not, the next release will definitely have it since I have merged support for
>>>>> this in QTEE and talked to the boot firmware release team about this.
>>>>
>>>> Does it work on the CRD?
>>>>
>>>
>>> Yes it does, I have validated on Glymur CRD by locally switching it from the current QSEECOM
>>> based uefisecapp to this new QCOMTEE based uefisecapp. This is the QTEE release which
>>> needs to be consumed for it:
>>> https://github.com/qualcomm-linux/meta-qcom/commit/5590c1dc631827624c110df282965b85ef2a2e60 
>>>
>>>>>
>>>>> The next planned firmware upgrade for Hamoa will also provide this support for
>>>>> Qualcomm Linux. And similarly, for all other targets being supported upstream.
>>>>
>>>> So, we are forcing users to upgrade to the new firmware? That doesn't
>>>> sound nice.
>>>>
>>>
>>> We have an open ecosystem for all devices supported by the Qualcomm Linux distribution,
>>> users can easily consume new releases (and new QTEE versions) to access new features.
>>> Until now, developers/users of RB3Gen2 or IQ-9075 could not access EFI variables to
>>> develop use-cases such as secure-boot key revocation, but by taking this patch series
>>> as part of a subsequent Qualcomm Linux release, they will be able to.
>>>
>>>>>>> Thus, QCOMTEE now maintains a static list of always-available object-IPC
>>>>>>> based secure services exposed by QTEE. These services are implemented either
>>>>>>> within the QTEE kernel or within a pre-loaded Trusted Application (TA)
>>>>>>> usually loaded by the bootloader. The uefisecapp TA is an example of a
>>>>>>> preloaded TA loaded by UEFI. A static list is required since QTEE does not
>>>>>>> yet expose any way to dynamically query and enumerate the services exposed by
>>>>>>> it.
>>>>>>
>>>>>> Can it be fixed instead of having static lists? In the end, we can't
>>>>>> guarantee that users update the firmware.
>>>>>>
>>>>>
>>>>> Unfortunately, no existing QTEE release out there currently has this support.
>>>>> But support for this is currently being added by QTEE team last I checked with them.
>>>>> Once it is available, and a new QTEE firmware release is out there, we will add
>>>>> support for dynamically querying QTEE services in the QCOMTEE driver. 
>>>>
>>>> It seems you are still rolling out QTEE-based support. In such a case,
>>>> please go back and implement dynamic detection of QTEE services.
>>>> Otherwise it would be a nightmare.
>>>>
>>>
>>> We are working on it, but until then there is no overhead involved in maintaining
>>> this static list of services because we don't have to extend/modify this list when
>>> adding support for a new Qualcomm platform upstream. If a particular service from
>>> the list is not implemented/accessible from QTEE we log the event and silently avoid
>>> probing the TEE driver for the service. We also don't add platform specific services
>>> here. So the list doesn't need to be extended on a per-platform basis.
>>>
>>> So unlike the QSEECOM driver, we don't have to keep maintaining this list forever
>>> for all new platforms.
>>>
>>>>>>> To facilitate object-IPC interactions from the kernel-space, this
>>>>>>> series also introduces a tee_client_object_invoke_func() to allow
>>>>>>> invocation of TEE objects similar to the existing tee_client_invoke_func()
>>>>>>> API exported by the TEE subsystem which allows invocation of TEE functions.
>>>>>>> Some suporting changes are also introduced to track and handle operations
>>>>>>> for TEE contexts opened from the kernel-space in the back-end QCOM-TEE
>>>>>>> driver.
>>>>>>>
>>>>>>> Finally and as previously mentioned, access to the object-IPC based uefisecapp
>>>>>>> service is restricted on older QTEE firmware versions. A new QTEE firmware
>>>>>>> release must be picked up from QArtifactory [2] for all upstream supported
>>>>>>> Qualcomm SoCs to enable access to uefisecapp service via the TEE client
>>>>>>> driver.
>>>>>>
>>>>>> What about fused devices?
>>>>>
>>>>> The procedure for updating the firmware on fused devices is slightly different.
>>>>> The firmware images need to be signed by the OEM using the security profile
>>>>> of the chipset before flashing/upgrading them. Security profiles are now public:
>>>>> https://github.com/qualcomm/security-profiles
>>>>
>>>> Will OEMs release new firmware images? What about the devices which are
>>>> already out of the support phase? This whole story rotates about the 'we
>>>> are releasing new firmware with new features' paradigm. However there
>>>> are existing devices in the field, which typically can't be upgraded,
>>>> From your cover letter it seems they can't support UEFI variables
>>>> properly. However they do so in Windows.
>>>>
>>>
>>> Yes Dmitry, this series is effectively forward looking. QSEECOM protocol/driver
>>> support is essentially deprecated on QTEE side, no new features added to QTEE support
>>> it, and it also doesn't work on many devices like the RB3Gen2.
>>>
>>> For existing devices, if they boot with upstream Linux and have RPMB located on
>>> UFS/eMMC this patch series cannot help them. But the focus of this series is not on the
>>> past, it is on currently supported and future hardware. Every new Qualcomm platform
>>> whose support is being up-streamed or is planned to be up-streamed will have access to
>>> EFI variables via this series.
>>>
>>> If someone wants to add support for older Qualcomm devices to access EFI variables
>>> via QSEECOM that patch series will not conflict with this one. Like I said, both
>>> QSEECOM and QCOMTEE based drivers can co-exist.
>>>
>>> Regards,
>>> Harshal
>>>
>>>
>>>  
>>>
>>
> 

