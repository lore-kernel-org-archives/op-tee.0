Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA48C61DD6
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 08:12:10 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E5CE944EBC
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 08:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788336730;
	bh=Ds0LNyk2kLdW1zY4EwHvIdNZaZ2aQXsfMDF+zzon42o=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=QePain3jT92rdyGAJCWqGavV2KMiID9ioxhDYiDlFqd1ncBj350PoLW902a7QNt1X
	 c35atbN9frvHVUlBkgIYgEPwUr9aaKBKhkxSAnFhTnMBJYHdLiO6cq2a3Dh1tPiBzk
	 5jG4J9i2M/cOEj0mU8+s0AEpfXO3WEGGlojpPAZqNZ3y6MkZ6jMbSLKlQJzuw+CVrA
	 QH0iYBpXGV6zchkecp+ETOpl2VG8ekzOjbZp+9mmrraJzis7GsA9KOXkbuf+xDFWoc
	 jcwbaPIztGrU7T+rr8r33CEScFndoxMPjeCfYDHRtro/zcsYis7qSAP5IGocKUdri5
	 SAcSfdSnRISnw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EC5E643814
	for <op-tee@lists.trustedfirmware.org>; Wed,  2 Sep 2026 08:12:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kl3N4ofW;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RR/M9MjD;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826VvKZ853818
	for <op-tee@lists.trustedfirmware.org>; Wed, 2 Sep 2026 08:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cHFrASzlHya0Vy464JYIlIOEK2tKZHkJVf+d9AaR8us=; b=kl3N4ofW0ORcUtvs
	idc2teoQYffI1lELidQ2t2k4yTwc9O9QrLmrE64LvHH8KLXXPXXxZLHQiZyET8un
	HK7WhTePTl4p0rqPlFTHshCTCO6j4cC33QGCKbCW28EICi904PI0tzIJ7JgCwTws
	h0S60OV+t6mqefzUmCGjQFWSFBmXA61tf9Ue9k7jYPyvaPSmQhMnmTSQ5ESoK26C
	nr0B0XprdI6R4Z6RFDqDMD4WEbLBpnAK7Fgk4DCTYwvofMB3Fk82IutBHMaBL/6P
	LEzLQeAkiGrnxxp7qnpRLi0kWiCUPTixuGu04PYHE5cEhh7C+x2Sjb5V/wFbdX9/
	N7i0LA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge38w2ut9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 02 Sep 2026 08:12:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d7443e0f0bso12364845ad.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 02 Sep 2026 01:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788336721; x=1788941521; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cHFrASzlHya0Vy464JYIlIOEK2tKZHkJVf+d9AaR8us=;
        b=RR/M9MjDooKOro0TgahPLVJOJ6zmvQUSj02WMn2zaMkK8YTxV4FSQ04f/CJp1MUMsy
         TSr87+AwWycBNTtrZll/uQjdsS8rpxnGT6kiaGjWK6YG7NiXijI9QdjIrWShA84GU3b2
         BAF1is/86tWALsMdrr0mZ/SkZV4Z0bOFTMPhzXJClWk2mxWxiWpTNfBSGyMNAN/nlbHa
         1Tg5Tc+H6CXhzdmzpZCt6w6JVkg0qWGNCweJqBnjGQJmaQcxsdCrH/jP/4hD+9shMdyG
         +74A7hR7Rci11yKS2b93xMrcNVYW/DFX9N4zczmDjd2ZUDeDorwUGlDE4hbdAqrQRK8+
         07yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788336721; x=1788941521;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cHFrASzlHya0Vy464JYIlIOEK2tKZHkJVf+d9AaR8us=;
        b=tAcnXtDbOnTTPqebRXxkyS+CSLRZfEhd5Zb+JIP1mKzfYIzNyc0Pobsm8OvffHvE36
         NHpjWYjHU/zWHs3U9e2H0GwzEuzPIDkffiEifGZBxCCBpEg4VN57UF8XTJuVlnRnvvlp
         z66Fn7OynJ4IAqcskLGV3mPsKlHhE6M1xkUd5a+XMLOX28KBcgwLWDN5/0fX5j9R2H1n
         gdphaqGpy0leDW+vwxYskDSGPku9KdwZaiIA50W0RgdfZyHuOTshiGj0KwNZBiuVB5OB
         q13EDxOmTiOdX7OllAgsI+cq4F9HYhFyDyjvNCi0Fcyz1QdG6ZMWMuXtc9KlKWsOUUW8
         sO5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwz4hyCIxgLA3P/+cbYZwEnkRzzvtVr05fNiAbH52UlevZKYb0WR2aRJDysKwfFyYJrIPKUn5Y=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++k+xYw4TRROd1/1Uum+4MsnVOCGjz6I9N5CyPz+tiETvc/e6dNW
	TroSsklz744XjqHo+jBKOa4b+LA9uYNbY67AUdhTNhbOFkueb+daTwqsn0Bx2sOHg7g0SihsESl
	mTnJLLH0mrFg/sWNe2P+d2SmXhZqwWnkGLICHKA5R3XJ2giOlN7d9ffDQL64psgOnBYSGcb8N
X-Gm-Gg: AYBFou1y5nI8EAAnDiEXZMSNcMhL+fCcgrY22QMAqKJvCW7rn+sPz2jNr9y3c3+eGuQ
	C0Ji/7wVhOnJo6VYZfOFKgCSfVdMWYHUzp+QN0t2wbhn1adhfbg6HRDwRJCKTy8hT6CTbmDMfRI
	ZYTEJDXOvqadu2Lsiez/e25w/849FomdKCMS0aPPVR/5l2fHmZmBt4Q1/UemQpum7NcAzRKpwxw
	0Pkrns3xmOi77YtKFLgBKCsnbPXCyXuI8hxI6h2p3GmCX4nbpluo9ruHXtNm97n1I17oGfD2kBy
	ZfDrB4hOazSqR5WrHVG3x96rk4YbU6rhfd9yre1NIrAX9pvgAQ/DEgknFl9u+mMUydLoohH5UF8
	rqkOhM3ps4eIbIbVAkBSWmquna3o=
X-Received: by 2002:a17:902:d4ce:b0:2d8:d2bd:a111 with SMTP id d9443c01a7336-2daec626dbdmr37759555ad.6.1788336720803;
        Wed, 02 Sep 2026 01:12:00 -0700 (PDT)
X-Received: by 2002:a17:902:d4ce:b0:2d8:d2bd:a111 with SMTP id d9443c01a7336-2daec626dbdmr37758735ad.6.1788336720089;
        Wed, 02 Sep 2026 01:12:00 -0700 (PDT)
Received: from [10.218.26.96] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07c02203sm4808321eec.31.2026.09.02.01.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 01:11:59 -0700 (PDT)
Message-ID: <ab7b94aa-6d9a-41b2-97fd-601db1cab5e6@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 13:41:54 +0530
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
 <wjzuf7regh2rvrt3spkesp3qanooiqpkua6f7mgq6ulw5z3hvp@q2fkcu2bueow>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <wjzuf7regh2rvrt3spkesp3qanooiqpkua6f7mgq6ulw5z3hvp@q2fkcu2bueow>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 35y9CgGrw9flC9UYTSmeYtJcofgH07-4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA3MiBTYWx0ZWRfX2x33sZNHz2NF
 1Yju7ZkrCI1HELemTUDCSrdIISnkN3WfQzQhYVC2WazPMTA1Iy+4KilJqNSC/rvSZcfz2umImbq
 pQFkU1j0qHQga4OkmFaygf0iQb8bM4Y=
X-Authority-Analysis: v=2.4 cv=LOpWhpW9 c=1 sm=1 tr=0 ts=6a97da52 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=P-IC7800AAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=4FzIVqeRmK6rRimR4G8A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 35y9CgGrw9flC9UYTSmeYtJcofgH07-4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA3MiBTYWx0ZWRfX+lgVAl8UJUmA
 npVL0PKeqbopX0bY5VAWz2wE3A4dcR+pFcOU53W7bnpZ1UFQwBJPCadOKj9v01jsvHm7nn43Ss5
 LQ8feeGOhjg9QKrvLsnnVcnsGDMpqd2mu9aBL0TJtTantquVCorwuzmSJRWsHZ28vjmp9lkimo6
 zOH4GdMT4d4bwQoNFnttJNrviOLu+W+T2nlnJP8wTCBpyPtMpY1UAwu094wVvfrV+dSWBWRguXE
 zYzSBp7wr7NCqovoVYHo1L2VUeXEUNHtsIzwyLswogpTHUnMJ+VY5FtBhXEy1ETSoyRrmfU+cdb
 MCh+7FBW5mIVbGidXVml/N5xEXoY6OcrBoBwYthQO/BP/0Ej5gydnt2YeTf3bSfRYNzIf7DPlKh
 sauyCDLdEC0UmdB4Ka34tD4vWDj9HRf91SSeohL8oaKwYHeGrG3mVgov9d9E772bXk3f7epoCLo
 XowZMtUTm6MnDuhn/6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020072
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[12];
	HAS_ORG_HEADER(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.197:received];
	DNSWL_BLOCKED(0.00)[202.46.22.19:received];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EC5E643814
X-Spamd-Bar: ------
Message-ID-Hash: CFRYRDOKKIC5ZH6QNMEYWWSHVKPMYJ4Y
X-Message-ID-Hash: CFRYRDOKKIC5ZH6QNMEYWWSHVKPMYJ4Y
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CFRYRDOKKIC5ZH6QNMEYWWSHVKPMYJ4Y/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Dmitry,

On 29-08-2026 08:19 pm, Dmitry Baryshkov wrote:
> On Wed, Aug 12, 2026 at 05:00:27PM +0530, Harshal Dev via OP-TEE wrote:
>> Hi Dmitry,
> 
> Hi Harshal, please excuse the huge delay from my side, I was on vacation
> and then burried under the rest of the issues.
>

Ahh I was not aware, I hope you had a good vacation Dmitry.
>>
>> On 10-08-2026 12:37 pm, Dmitry Baryshkov wrote:
>>> On Fri, Jul 24, 2026 at 02:43:42PM +0530, Harshal Dev wrote:
>>>> Hi Dmitry,
>>>>
>>>> On 22-07-2026 01:56 pm, Dmitry Baryshkov wrote:
>>>>> On Wed, Jul 22, 2026 at 12:29:11PM +0530, Harshal Dev wrote:
>>>>>> On Qualcomm SoC based platforms, UEFI stores EFI variables within the
>>>>>> Replay Protected Memory Block (RPMB) which is only accessible by the
>>>>>> Qualcomm Trusted Execution Environment (QTEE).
>>>>>
>>>>> Is it so? I think RPMB is accessible to Linux...
>>>>
>>>> I should have been more descriptive here, RPMB is accessible by Linux but
>>>> its frames can only be prepared by QTEE.
>>>>
>>>> The RPMB key which is one-time programmed into the storage controller to allow
>>>> authentication of the RPMB frames is generated by and only available to a TEE.
>>>> So on Qualcomm platforms (and many others platforms with a TEE) Linux can only
>>>> route the RPMB frames generated by QTEE to the storage, it cannot create and
>>>> write the RPMB frames itself (it doesn't have access to the key).
>>>>
>>>> While it is possible for Linux to generate/program/store this key, on Qualcomm
>>>> platforms we do not want Linux to do so because we do not trust it. We trust
>>>> QTEE.
>>>>
>>>> I will re-phrase this and make it a bit more clear everywhere.
>>>
>>> OK.
>>>
>>>>
>>>>>
>>>>>> For Qualcomm platforms without emulated RPMB support, specifically
>>>>>
>>>>> What is emulated RPMB support? Why is it mentioned here? Which platforms
>>>>> use emulated RPMB?
>>>>
>>>> Emulated RPMB refers to RPMB on a storage which doesn't have its own firmware.
>>>> Primarily, NAND/NOR storage. Unlike UFS/eMMC storage, NAND/NOR storage does not
>>>> have a storage controller where we can program the RPMB key to be used by the
>>>> firmware. So we must 'emulate' RPMB by moving the storage driver within QTEE
>>>> and making the driver hold/use the key.
>>>>
>>>> Qualcomm compute SoCs (Glymur, Hamoa) have RPMB available on SPI-*NOR* storage,
>>>> and a driver for communicating with it is also available in QTEE. And so, these
>>>> have 'emulated' RPMB.
>>>
>>> This needs to be explained in the cover letter.
>>>
>>
>> Ack. 
>>>>
>>>> I will add this detail in an updated cover letter.
>>>>>
>>>>>> platforms where RPMB is not located within SPI-NOR storage and instead
>>>>>> located on UFS/EMMC storage, non-volatile EFI variables can only be set via
>>>>>> a callback request from the UEFI Secure Application to the RPMB service
>>>>>> running in user-space (within the QTEE supplicant [1]).
>>>>>
>>>>> Can it be moved to the kernel?
>>>>
>>>> We have a plan to move the RPMB service to the kernel similar to OPTEE:
>>>> https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/tee/optee/rpc.c#L449
>>>>
>>>> It is a work in progress. Once this happens, we don't need QTEE supplicant available
>>>> on the Linux distribution.
>>>
>>> Ok.
>>>
>>>>
>>>>>
>>>>>>
>>>>>> Unlike the QCOM-TEE driver, the QSEECOM driver (used by the current
>>>>>> QSEECOM based uefisecapp) does not support callback requests.
>>>>>
>>>>> How did it work then? I think Windows has been perfectly using QSEECOM
>>>>> rather than QTEE.
>>>>
>>>> It works because Windows on Arm on Qualcomm has SPI-NOR storage. A driver for which
>>>
>>> I have WoA devices without SPI NOR. Windows still can store UEFI
>>> variables.
>>>
>>
>> Ahh, the key point here is 'Windows'. Windows has a separate way of providing
>> RPMB access via a service in the TrEE driver within the OS:
>> https://github.com/microsoft/Windows-driver-samples/tree/main/TrEE
>>
>> However, the Linux QSEECOM driver we have here in upstream does not have that support.
>> And so without the QCOMTEE + QTEE supplicant combination, we cannot access EFI
>> variables on these Qualcomm WoA platforms when they boot with upstream Linux.
> 
> So, this must be fixed, I assume? What is the ETA?
>

I agree, it will have to be a separate effort. If new firmware QTEE releases are not
being rolled out for these existing WoA devices, and if their RPMB exists on UFS/eMMC
then the only way to support EFI variable is to:
1. Add support for callback requests in the upstream QSEECOM driver.
2. Add support for RPMB listener in kernel which routes the RPMB frames from QTEE to
   the RPMB device via the QSEECOM driver.

This is significant effort for supporting a protocol which is deprecated on the QTEE
side moving forward. That being said, I do not discourage this effort. We can think of
a plan if we really want to support these devices. I will be happy to engage.

>>
>>>> is available within QTEE, and so QTEE does not need to make a callback request
>>>> to Linux to request RPMB frame routing. However, in case of UFS/eMMC storage the
>>>> driver only exists in the Linux kernel and so QTEE must make a callback request.
>>>>
>>>> And so, if you try to use the QSEECOM driver to write EFI-variables to RPMB
>>>> on a device with UFS/eMMC storage, it won't work.
>>>
>>> Yep. It seems to work under Windows though.
>>>
>>
>> As explained above, the mechanism is different for Windows. A different driver
>> and a different protocol. :)
> 
> Let me be very explicit here. The path used by Windows is tested and
> verified to work on a plethora of the devices. Those devices must work
> with Linux too, so, in my opinion, we should use the same firmware path

Agreed, as mentioned above, we can think of a plan to support these devices by extending
the QSEECOM driver.

> and the same firmware interfaces as used by Windows.
>

The interfaces used on Windows by the TrEE driver are different as per the information
I obtained from Windows team. But we don't need to worry about that, we already have
QSEECOM in upstream which we can extend.

>>>>>> And on
>>>>>> certain Qualcomm platforms such as the RB3Gen2, attempts to access the
>>>>>> QSEECOM interface fail due to lack of support within Qualcomm TEE.
>>>>>
>>>>> So, I assume, on RB3 Gen2 the QSEECOM doesn't report uefisecapp as
>>>>> supported. Does it?
>>>>
>>>> It doesn't, this API returns -2 if I add RB3 Gen2 in the allow-list for QSEECOM:
>>>> https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/firmware/qcom/qcom_qseecom.c#L46
>>>
>>> Does it support QTEE-based uefi variable storage?
>>>
>>
>> It does, the QTEE-based uefi variable storage app, i.e. uefisecapp is loaded by
>> UEFI on RB3Gen2, however, the QSEECOM interface on RB3Gen2 is broken so it misreports
>> it as 'not supported'. But the app is loaded and available, which is why if you apply
>> this patch series, you can communicate with it. Just make sure you take the QTEE
>> release mentioned in this cover letter.
> 
> Can't we fix the QSEECOM instead, if one needs to flash another release
> anyways?
>

QSEECOM is deprecated, requesting support for fixing it is an overhead at this point.
Even if we take the time to fix it ourselves, it won't help, because the QSEECOM driver
doesn't support callback requests and a path to the RPMB device within the Linux kernel.

>>>>>> On these platforms, a TEE based uefisecapp client driver is required to:
>>>>>> 1. Access cached & volatile EFI variables stored in uefisecapp's memory.
>>>>>> 2. Ensure persistence of non-volatile EFI variables via writes through
>>>>>> the RPMB service hosted in the QTEE supplicant.
>>>>>>
>>>>>> This series introduces such a uefisecapp TEE client driver for the
>>>>>> aforementioned Qualcomm platforms which installs efi-var operations _if_
>>>>>> the QCOMTEE driver registers support for an object-IPC based uefisecapp
>>>>>> service on the TEE bus during its probe. Only new QTEE firmware versions
>>>>>> available at [2] provide this support.
>>>>>
>>>>> What about existing WoA devices?
>>>>
>>>> New Windows on Arm devices like Hamoa/Glymur work perfectly fine with existing
>>>> QSEECOM based uefisecapp. But they will also work with this new QCOMTEE based
>>>> uefisecapp once they upgrade their firmware.
>>>
>>> Do extisting commercial devices suppot it? For example, does Lenovo T14s
>>> support it? Will it continue to work with this patchset in place?
>>
>> Existing devices like the Lenovo T14s do not have mature QCOMTEE/SMCInvoke support
>> on QTEE side and new QTEE versions for it are not being rolled out. However, this
>> QCOMTEE based uefisecapp driver and the QSEECOM based uefisecapp driver can co-exist.
>> It will not cause any breakage of existing working functionality since the QSEECOM
>> path can probe and continue as usual.
> 
> My understanding was that QTEE path completely disables the QSEECOM
> path, does it not?
>

By 'QTEE path', I believe you mean the 'QCOMTEE/SMCInvoke' protocol path.

No, both SMCInvoke/QCOMTEE and QSEECOM paths can be supported simultaneously within QTEE.
QTEE does not disable the QSEECOM path when it enables the SMCInvoke/QCOMTEE one.

You can have both QSEECOM and SMCInvoke clients running together on a Qualcomm platform.
QTEE doesn't impose any restrictions. The control/data paths within QTEE for these
two protocols are completely isolated from each other.

>>
>> As per your comments on patch 6 of this series, I plan to enable the QCOMTEE based
>> uefisecapp as default 'm'. That way we don't need to enable one over the other and
>> will continue supporting all existing functionality while extending it for devices
>> with UFS/eMMC storage and running upstream Linux.
>>
>> Do let me know your opinion on it.
> 
> My opinion is very obvious by now. Existing devices should work. _Must_
> work. They provide the reference interface. Make them work first and
> work good. Then explain, why the other interface is better (I fail to
> see it from your cover letter or from any of the commit messages).
> 
> When I take a Glumur laptop from the market shelf, will it be QSEECOM or
> QCOMTEE? If I take the next-generation-after-Glymur, will QTEE interface
> for uefisecapp be supported there? Will it be used by Windows?
> 
> I think the series fails to answer, why do we need another mechanism, if
> we already have one which has been working for the past N years and
> which is supposed to work for another M years?
>

At this point, we have the following categories of devices:
1. Devices with only QSEECOM support, but no support for callbacks/RPMB listener within
Linux QSEECOM driver.
Example, MSM8998 and older WoA laptops. These are very old devices (at least more than
6-7 years old).

2. Devices with both QSEECOM and SMCInvoke/QCOMTEE support.
Example, SM8650, *Glymur*. These are relatively new devices (2-5 years old).

3. Devices with only SMCInvoke/QCOMTEE support.
Example, RB3Gen2/Kodiak, IQ-9075/LeMans and newer devices which might not have
QSEECOM support in the future since QTEE team has deprecated QSEECOM.

This patch series helps devices in category 2 and 3. Without the mechanism introduced
by this series, we will end up in a situation where EFI variable based use-cases will
become impossible on at least category 3 of devices. We must conform to the reality
that QTEE firmware is transitioning to SMCInvoke as the protocol of choice with
long-term committed support.

At the same time, I am aligned that we must think of a way to support devices in category 1
which is what you really care about. The QCOMTEE and QSEECOM drivers can co-exist, and so
by adding support for both this patch series and callback requests to the QSEECOM driver
(at a later point of time via a separate series) we will be able to provide EFI variable
support on all Qualcomm platforms under the sun. This will accomplish our common goal.

I will add this information in the cover letter in a concise manner.
 
>>> What about other existing devices? We have WoA devices starting with
>>> MSM8998. The QSEECOM driver works on them, but, as you mentioned, it
>>> can't flash updates to the backing storage.
>>>
>>
>> Unfortunately, unless we roll out new QTEE firmware versions for devices like MSM8998
>> with QCOMTEE/SMCInvoke support + access to the Uefisecapp over SMCInvoke protocol,
>> they cannot be helped with this series.
> 
> So, I'd say, the series is strange. We are proposing something which is
> not rolled out, which is not supported by the exsiting commercial
> devices, etc. On the other hand we have future gaps which are known.
> This doesn't sound correctly.
>

We are proposing a mechanism which supports the majority of Qualcomm devices in the market
launched within the last 5 years and also the upcoming ones. The category of devices which
are not helped by this series are extremely old (at least 6+ years). Regardless, I am not
pushing the view that we do not care about those devices, just that the route to helping
them is different and orthogonal to this series and I am happy to engage on it separately. 
>>>> I need to double-check but this firmware release for Glymur on Qualcomm Linux
>>>> is probably carrying the support for QCOMTEE based uefisecapp access:
>>>> https://github.com/qualcomm-linux/meta-qcom/commit/728251fcbe5113980805ea6c571e33235062ee71
>>>> If not, the next release will definitely have it since I have merged support for
>>>> this in QTEE and talked to the boot firmware release team about this.
>>>
>>> Does it work on the CRD?
>>>
>>
>> Yes it does, I have validated on Glymur CRD by locally switching it from the current QSEECOM
>> based uefisecapp to this new QCOMTEE based uefisecapp. This is the QTEE release which
> 
> Why do we need to switch the app? Why is the old one worth switching?
>

You do not need to, Glymur supports both QSEECOM and QCOMTEE/SMCInvoke. I just used Glymur
as an example to show that both work there and if a user wants he can chose one over the other
(It really doesn't matter). Glymur sits in the middle of the old and the new, it is a category 2
device as mentioned above. 
>> needs to be consumed for it:
>> https://github.com/qualcomm-linux/meta-qcom/commit/5590c1dc631827624c110df282965b85ef2a2e60 
>>
>>>>
>>>> The next planned firmware upgrade for Hamoa will also provide this support for
>>>> Qualcomm Linux. And similarly, for all other targets being supported upstream.
>>>
>>> So, we are forcing users to upgrade to the new firmware? That doesn't
>>> sound nice.
>>>
>>
>> We have an open ecosystem for all devices supported by the Qualcomm Linux distribution,
>> users can easily consume new releases (and new QTEE versions) to access new features.
>> Until now, developers/users of RB3Gen2 or IQ-9075 could not access EFI variables to
> 
> What stopped us from delivering the TZ apps compatible with the existing
> interface?
>

QSEECOM support is deprecated on IQ-9075 and broken on RB3Gen2.

>> develop use-cases such as secure-boot key revocation, but by taking this patch series
>> as part of a subsequent Qualcomm Linux release, they will be able to.
>>
>>>>>> Thus, QCOMTEE now maintains a static list of always-available object-IPC
>>>>>> based secure services exposed by QTEE. These services are implemented either
>>>>>> within the QTEE kernel or within a pre-loaded Trusted Application (TA)
>>>>>> usually loaded by the bootloader. The uefisecapp TA is an example of a
>>>>>> preloaded TA loaded by UEFI. A static list is required since QTEE does not
>>>>>> yet expose any way to dynamically query and enumerate the services exposed by
>>>>>> it.
>>>>>
>>>>> Can it be fixed instead of having static lists? In the end, we can't
>>>>> guarantee that users update the firmware.
>>>>>
>>>>
>>>> Unfortunately, no existing QTEE release out there currently has this support.
>>>> But support for this is currently being added by QTEE team last I checked with them.
>>>> Once it is available, and a new QTEE firmware release is out there, we will add
>>>> support for dynamically querying QTEE services in the QCOMTEE driver. 
>>>
>>> It seems you are still rolling out QTEE-based support. In such a case,
>>> please go back and implement dynamic detection of QTEE services.
>>> Otherwise it would be a nightmare.
>>>
>>
>> We are working on it, but until then there is no overhead involved in maintaining
>> this static list of services because we don't have to extend/modify this list when
>> adding support for a new Qualcomm platform upstream. If a particular service from
>> the list is not implemented/accessible from QTEE we log the event and silently avoid
>> probing the TEE driver for the service. We also don't add platform specific services
>> here. So the list doesn't need to be extended on a per-platform basis.
>>
>> So unlike the QSEECOM driver, we don't have to keep maintaining this list forever
>> for all new platforms.
> 
> I don't see a difference. You are saying that the list implementation is
> good, it silintly skips the unavailable services, etc., and then you say
> that you don't have to keep maintaining the list.
>

We only have to add services to this list when a client driver appears for it. For
example, this TPM series by Kuldeep:
https://lore.kernel.org/all/20260831-tpm_qcom_driver-v1-1-6f16fa6924fa@oss.qualcomm.com/

We don't need to maintain this list on a per-platform basis unlike QSEECOM:
https://elixir.bootlin.com/linux/v7.2-rc7/source/drivers/firmware/qcom/qcom_scm.c#L2289

Support will arrive for dynamic detection, I have commitment from QTEE team for somewhere
around end of the year. :)

>>>>>> To facilitate object-IPC interactions from the kernel-space, this
>>>>>> series also introduces a tee_client_object_invoke_func() to allow
>>>>>> invocation of TEE objects similar to the existing tee_client_invoke_func()
>>>>>> API exported by the TEE subsystem which allows invocation of TEE functions.
>>>>>> Some suporting changes are also introduced to track and handle operations
>>>>>> for TEE contexts opened from the kernel-space in the back-end QCOM-TEE
>>>>>> driver.
>>>>>>
>>>>>> Finally and as previously mentioned, access to the object-IPC based uefisecapp
>>>>>> service is restricted on older QTEE firmware versions. A new QTEE firmware
>>>>>> release must be picked up from QArtifactory [2] for all upstream supported
>>>>>> Qualcomm SoCs to enable access to uefisecapp service via the TEE client
>>>>>> driver.
>>>>>
>>>>> What about fused devices?
>>>>
>>>> The procedure for updating the firmware on fused devices is slightly different.
>>>> The firmware images need to be signed by the OEM using the security profile
>>>> of the chipset before flashing/upgrading them. Security profiles are now public:
>>>> https://github.com/qualcomm/security-profiles
>>>
>>> Will OEMs release new firmware images? What about the devices which are
>>> already out of the support phase? This whole story rotates about the 'we
>>> are releasing new firmware with new features' paradigm. However there
>>> are existing devices in the field, which typically can't be upgraded,
>>> From your cover letter it seems they can't support UEFI variables
>>> properly. However they do so in Windows.
>>>
>>
>> Yes Dmitry, this series is effectively forward looking. QSEECOM protocol/driver
>> support is essentially deprecated on QTEE side, no new features added to QTEE support
>> it, and it also doesn't work on many devices like the RB3Gen2.
> 
> To look forward, we need to have a good firm stand on the ground. We
> have a half-baked implementation, based on reverse engineering. No RPMB
> support, etc.
>

Agreed. I am happy to engage on a separate series for adding callback support to QSEECOM
driver along with RPMB listener within the kernel.
 
>> For existing devices, if they boot with upstream Linux and have RPMB located on
>> UFS/eMMC this patch series cannot help them. But the focus of this series is not on the
>> past, it is on currently supported and future hardware. Every new Qualcomm platform
>> whose support is being up-streamed or is planned to be up-streamed will have access to
>> EFI variables via this series.
>>
>> If someone wants to add support for older Qualcomm devices to access EFI variables
>> via QSEECOM that patch series will not conflict with this one. Like I said, both
>> QSEECOM and QCOMTEE based drivers can co-exist.
> 
> What will happen if I build both and boot the kernel on the existing
> devices?
>

QSEECOM and its client driver probe first and establishes the path to uefisecapp for
providing EFI variables service. QCOMTEE and its client silently fail probe.

Regards,
Harshal

 

