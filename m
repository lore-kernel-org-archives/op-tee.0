Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B9EC5AC82
	for <op-tee@archiver.kernel.org>; Mon, 10 Aug 2026 07:07:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 223F845390
	for <op-tee@archiver.kernel.org>; Mon, 10 Aug 2026 07:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1786345638;
	bh=NIGH2awKS7UJRQ3fWRPCPF/2tWCZooz6JQ7qrm7/QuY=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=gdMoBbzP5iT79TU+na7DN8xc5evjd3iR0/lONSvSswAEIma99Y9kOD6m5DPwKZpCO
	 FC2pAP6fCwKwuz/nQaTlq2oFcAUiaEnrFB5VanPkIy+4yAP/1REbKbhho7qvcAFdIm
	 xG9iVMiTd16t8aJHTv6yP7V755FJqKpFIiY3m++XiISB9YApoW4gLEBOZjVi6656zQ
	 LOd90kzRSz77IqrW/soche+Pt8lOPJc1J4Hbses2RrO+Cf65YpEsnRRCYjsv69T4zX
	 FutAU3SFy7QOqu9HbDrWuZddBBmwamX8hKpbmn+RaJM3Tq0mQbI+NSjvSCzAGkvnB5
	 GJNqoUwBroYbg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6319644E26
	for <op-tee@lists.trustedfirmware.org>; Mon, 10 Aug 2026 07:07:11 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KBpb8i6Q;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cECONbiI;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A5pWPl697978
	for <op-tee@lists.trustedfirmware.org>; Mon, 10 Aug 2026 07:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Q4RNLbjHE/O9Vb/0e8rNRcAH
	pZYJIJ2LR+15s2rJjM0=; b=KBpb8i6QYaGzfLvMPOv7vN7bpBseTbbdxGJzYBk3
	gVqX74XbNGPPISvgXLExfN95XOwVtqv8BymswLmalM9NrUOjqCVV9MHh8slaPIoZ
	gOg98Ws5wiC8Ry2Ux4rvHC39XAHeaSkw9jd5j18w1QHl+SjV/vPEBby2fn9JG0wA
	m1cSodUcu1K7OfGnReuejSVRa+ICH1pR1FKMchOirIJvsEMRx68SP1W23+ec6Sou
	KSP0EytRBMl2kHqLhLZdi8sN1OtBZBqYApQGZu8jfRIK7lZpz0/v4L6HswTVyuSA
	V0jgIwsI0jr/thMUa4RpfA1tvLEqfFfx/NzaKhkZXBJfVg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8v2881y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 10 Aug 2026 07:07:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1d30035dso10852551cf.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 10 Aug 2026 00:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786345630; x=1786950430; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q4RNLbjHE/O9Vb/0e8rNRcAHpZYJIJ2LR+15s2rJjM0=;
        b=cECONbiIg89vgWei8BjYZPtU4/6vpBBp/XTLxnLQX351c8cTnEanWiD7AbNF0AvZtD
         gWWCBYmbwlfuzsytrVe00IMoMkvOcwZoQeLHvuXP+ywsUiuwHYDFxUEO3ENdmKQihIEP
         9USxDvrK2jr+MqU/3ceaxHxfJSYZmDYOXV+OzHoLagPBIWLZgxQOb1KzR+nMWrYZKDB2
         HuBqlE/BAauyRKXfW58/bQ4qi8UFPj2+w1k31pTy4wOfdZqlA0g26Img45OhVA3b/AmE
         l7EyM6wFfeSzwX2p0RWHokFG7nzaeJ0wm/J9xIInyzUIiiDuUKSj+rcVkaAGPnchRIga
         1kjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786345630; x=1786950430;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q4RNLbjHE/O9Vb/0e8rNRcAHpZYJIJ2LR+15s2rJjM0=;
        b=RrXl+hKRJyzhm2HQ1ltA0h/Hic9lh1GYLucQwoV3cT9KCCTNOjf7ndxOmBprI+3V0n
         7QoMNxXAvTdz9m9rES0Tu8DkBdEyUNrH7mZ7diU8tkN09Tva3f5ynhObrZT8fcqa9gZ9
         cNosG+LmjSFS3bxHbWE03K9o05sLk/UxGRDLWOFBWrdCKXWftHjyKAsv08cIm9QWQX4a
         cxBf32aseszOa2dktxpTQiWcsgHCtTfDPZgRu3hP64FNzcL0TMTpmv4WafC2A2ohPNTh
         QevtIiGRpkoEMiv7nl5WB36EhKjsO8gxRO9F9GS9GgvNoyjzMvHBkZKiJUjtIUfVdJ+L
         upUg==
X-Forwarded-Encrypted: i=1; AHgh+RrLtbaeEPBrcTbEF4FFVqUksef9FTmxHOXVuP/3lPDDuCBUikybl4T1iTwfeC4d8xmjY4cE6/8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxFYKfRBisH8VTxqVZRVgQV3f+IzjYSxV6W/iAnIfSk9IGfx47p
	ra2DWzx78PHz5ad489Gmy/rI2eO7W47N9EBj6JX2YLskof2wiqErHLQzgBB9enHk08yXrpZpbAJ
	h9juqbWGAZ3CYtvlkAHkGI4NFUWc/PO8w+Xjz0wa1fAQTLPdMIsUZa/Gv+m+r2i82Fsp+kcah
X-Gm-Gg: AR+sD13SQ9jX1Y+bRupe2dlERisbB8lmPtVaA1stE0UDwJlpvi7AK/Fy9pVVr2NYrSv
	htx1V4Li3247i6ad3ndBYxN5Pc2fUsVUkiI6a91DKaeaIK1qeC4CLj9x/GZk/jMDAtoSYJYqesb
	ekT0h7AYEsEBRVpX/qwLutt2SxmKa8qcrKt7VloEAnu5G8wrvdPgNqLAedgxo/5gcDNf0dL127U
	nI/XnbkJnS8p5LQXfFEnEjIlAeFtj2ny+66/k0EMq0OSbBRNP7hkItyeU0CjsA9KmZtYvIi7TAF
	0ksKGgYhIbyqx3o0c8yp6vyqxRCQNYJb2/qIK8H89D2pfeo95KX5Of78BEtMUkjxnIXBubBJygL
	HPp0n2rC0CO1OP08yIh7TdH6HV1gAmZADthr82ksIfgIWd2CLLSwpiVsdfeJN2kMhZVJXsSK+WJ
	VTPxh3EcenXnEKpw==
X-Received: by 2002:a05:622a:1792:b0:51c:1408:6c13 with SMTP id d75a77b69052e-52ce61f0ccdmr407198491cf.44.1786345629953;
        Mon, 10 Aug 2026 00:07:09 -0700 (PDT)
X-Received: by 2002:a05:622a:1792:b0:51c:1408:6c13 with SMTP id d75a77b69052e-52ce61f0ccdmr407197931cf.44.1786345629456;
        Mon, 10 Aug 2026 00:07:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b304fd1ce0sm1791508e87.17.2026.08.10.00.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 00:07:08 -0700 (PDT)
Date: Mon, 10 Aug 2026 10:07:06 +0300
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/6] Add TEE based client driver for UEFI Secure
 Application
Message-ID: <oicbypv7rpxmweclopi5xxpcfq5chnypp5tlqd4uix2pm5e72f@kd3bibeximjq>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
 <nfijwr2ptpxqvdw625yedep7tmakwvkeavyeobrmig5hbkw77w@rcqyp7h4y327>
 <db27820a-2b43-45e4-bc4a-0e9e81aacd93@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db27820a-2b43-45e4-bc4a-0e9e81aacd93@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=S9PpBosP c=1 sm=1 tr=0 ts=6a79789e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=P-IC7800AAAA:8
 a=NEAV23lmAAAA:8 a=IRZECcl-qLxfp-yAvsMA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: 5WxhUfCmAJZfapfdSNuGWnUfUY0U6qY2
X-Proofpoint-GUID: 5WxhUfCmAJZfapfdSNuGWnUfUY0U6qY2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA1OSBTYWx0ZWRfX6VHM+VrR0FZN
 A44kRfm8TTRUqB6RSdF1/OpCBrQeEzs2llyy5PeTvAOZzdo3vPhbcqrsbO5tEEbAHEWkvQnYXU5
 D9JQbACePoO4lCfEHM+6P37KWxfJRsCfCsRyc7IEjEs9hzjzPbD7XLzwvATHvnmUp1Ehqjbnizv
 Vyme+zDDeXyogYNRyjb6VM5hFS2ZrZ1CMjasPaV7xzi+VoCv6dYhFWZsHW+3DWNQp6mwVzlnXi3
 iyLK4PElnnZGZBmhidHmsil/AfQxnI+Agl1eqgW3qxc0dsBNNIyiGa+Q5gTLhS84ZfiRu+w2R/A
 TnUqry3khdEgBM8Hcy9p0vHCew/EX8wECtHZuTIIpda+cz4vQvJlSKw0xqT9w91cs1JWI912Mk0
 3qya3350gE9o/Hz4d804htEmxK++UPAcUbq98AI4OURHMQqnSSjrh0p51SFqxN3iQIT1lERMRR1
 gAtJNDklPohhnMlYp/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA1OSBTYWx0ZWRfX7YEC/tM6pMYR
 auP/O0EuVv8B4k4yQxds6MoDpPLJykyZcPY6l3sNXhpFFpkN3PoZQdiv6MIhekPxU7rKVKmJfGj
 DnrFizJPtpwkpgn0vQIZq5Yg+mSmYJk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_01,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100059
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.160.198:received,205.220.180.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6319644E26
X-Spamd-Bar: ---
Message-ID-Hash: G62LHSL3A5C5AITIHJW2EHJPF62RFRWA
X-Message-ID-Hash: G62LHSL3A5C5AITIHJW2EHJPF62RFRWA
X-MailFrom: dmitry.baryshkov@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/G62LHSL3A5C5AITIHJW2EHJPF62RFRWA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Dmitry Baryshkov via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

On Fri, Jul 24, 2026 at 02:43:42PM +0530, Harshal Dev wrote:
> Hi Dmitry,
> 
> On 22-07-2026 01:56 pm, Dmitry Baryshkov wrote:
> > On Wed, Jul 22, 2026 at 12:29:11PM +0530, Harshal Dev wrote:
> >> On Qualcomm SoC based platforms, UEFI stores EFI variables within the
> >> Replay Protected Memory Block (RPMB) which is only accessible by the
> >> Qualcomm Trusted Execution Environment (QTEE).
> > 
> > Is it so? I think RPMB is accessible to Linux...
> 
> I should have been more descriptive here, RPMB is accessible by Linux but
> its frames can only be prepared by QTEE.
> 
> The RPMB key which is one-time programmed into the storage controller to allow
> authentication of the RPMB frames is generated by and only available to a TEE.
> So on Qualcomm platforms (and many others platforms with a TEE) Linux can only
> route the RPMB frames generated by QTEE to the storage, it cannot create and
> write the RPMB frames itself (it doesn't have access to the key).
> 
> While it is possible for Linux to generate/program/store this key, on Qualcomm
> platforms we do not want Linux to do so because we do not trust it. We trust
> QTEE.
> 
> I will re-phrase this and make it a bit more clear everywhere.

OK.

> 
> > 
> >> For Qualcomm platforms without emulated RPMB support, specifically
> > 
> > What is emulated RPMB support? Why is it mentioned here? Which platforms
> > use emulated RPMB?
> 
> Emulated RPMB refers to RPMB on a storage which doesn't have its own firmware.
> Primarily, NAND/NOR storage. Unlike UFS/eMMC storage, NAND/NOR storage does not
> have a storage controller where we can program the RPMB key to be used by the
> firmware. So we must 'emulate' RPMB by moving the storage driver within QTEE
> and making the driver hold/use the key.
> 
> Qualcomm compute SoCs (Glymur, Hamoa) have RPMB available on SPI-*NOR* storage,
> and a driver for communicating with it is also available in QTEE. And so, these
> have 'emulated' RPMB.

This needs to be explained in the cover letter.

> 
> I will add this detail in an updated cover letter.
> > 
> >> platforms where RPMB is not located within SPI-NOR storage and instead
> >> located on UFS/EMMC storage, non-volatile EFI variables can only be set via
> >> a callback request from the UEFI Secure Application to the RPMB service
> >> running in user-space (within the QTEE supplicant [1]).
> > 
> > Can it be moved to the kernel?
> 
> We have a plan to move the RPMB service to the kernel similar to OPTEE:
> https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/tee/optee/rpc.c#L449
> 
> It is a work in progress. Once this happens, we don't need QTEE supplicant available
> on the Linux distribution.

Ok.

> 
> > 
> >>
> >> Unlike the QCOM-TEE driver, the QSEECOM driver (used by the current
> >> QSEECOM based uefisecapp) does not support callback requests.
> > 
> > How did it work then? I think Windows has been perfectly using QSEECOM
> > rather than QTEE.
> 
> It works because Windows on Arm on Qualcomm has SPI-NOR storage. A driver for which

I have WoA devices without SPI NOR. Windows still can store UEFI
variables.

> is available within QTEE, and so QTEE does not need to make a callback request
> to Linux to request RPMB frame routing. However, in case of UFS/eMMC storage the
> driver only exists in the Linux kernel and so QTEE must make a callback request.
> 
> And so, if you try to use the QSEECOM driver to write EFI-variables to RPMB
> on a device with UFS/eMMC storage, it won't work.

Yep. It seems to work under Windows though.

> 
> > 
> >> And on
> >> certain Qualcomm platforms such as the RB3Gen2, attempts to access the
> >> QSEECOM interface fail due to lack of support within Qualcomm TEE.
> > 
> > So, I assume, on RB3 Gen2 the QSEECOM doesn't report uefisecapp as
> > supported. Does it?
> 
> It doesn't, this API returns -2 if I add RB3 Gen2 in the allow-list for QSEECOM:
> https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/firmware/qcom/qcom_qseecom.c#L46

Does it support QTEE-based uefi variable storage?

> >> On these platforms, a TEE based uefisecapp client driver is required to:
> >> 1. Access cached & volatile EFI variables stored in uefisecapp's memory.
> >> 2. Ensure persistence of non-volatile EFI variables via writes through
> >> the RPMB service hosted in the QTEE supplicant.
> >>
> >> This series introduces such a uefisecapp TEE client driver for the
> >> aforementioned Qualcomm platforms which installs efi-var operations _if_
> >> the QCOMTEE driver registers support for an object-IPC based uefisecapp
> >> service on the TEE bus during its probe. Only new QTEE firmware versions
> >> available at [2] provide this support.
> > 
> > What about existing WoA devices?
> 
> New Windows on Arm devices like Hamoa/Glymur work perfectly fine with existing
> QSEECOM based uefisecapp. But they will also work with this new QCOMTEE based
> uefisecapp once they upgrade their firmware.

Do extisting commercial devices suppot it? For example, does Lenovo T14s
support it? Will it continue to work with this patchset in place?

What about other existing devices? We have WoA devices starting with
MSM8998. The QSEECOM driver works on them, but, as you mentioned, it
can't flash updates to the backing storage.

> I need to double-check but this firmware release for Glymur on Qualcomm Linux
> is probably carrying the support for QCOMTEE based uefisecapp access:
> https://github.com/qualcomm-linux/meta-qcom/commit/728251fcbe5113980805ea6c571e33235062ee71
> If not, the next release will definitely have it since I have merged support for
> this in QTEE and talked to the boot firmware release team about this.

Does it work on the CRD?

> 
> The next planned firmware upgrade for Hamoa will also provide this support for
> Qualcomm Linux. And similarly, for all other targets being supported upstream.

So, we are forcing users to upgrade to the new firmware? That doesn't
sound nice.

> >> Thus, QCOMTEE now maintains a static list of always-available object-IPC
> >> based secure services exposed by QTEE. These services are implemented either
> >> within the QTEE kernel or within a pre-loaded Trusted Application (TA)
> >> usually loaded by the bootloader. The uefisecapp TA is an example of a
> >> preloaded TA loaded by UEFI. A static list is required since QTEE does not
> >> yet expose any way to dynamically query and enumerate the services exposed by
> >> it.
> > 
> > Can it be fixed instead of having static lists? In the end, we can't
> > guarantee that users update the firmware.
> >
> 
> Unfortunately, no existing QTEE release out there currently has this support.
> But support for this is currently being added by QTEE team last I checked with them.
> Once it is available, and a new QTEE firmware release is out there, we will add
> support for dynamically querying QTEE services in the QCOMTEE driver. 

It seems you are still rolling out QTEE-based support. In such a case,
please go back and implement dynamic detection of QTEE services.
Otherwise it would be a nightmare.

> >> To facilitate object-IPC interactions from the kernel-space, this
> >> series also introduces a tee_client_object_invoke_func() to allow
> >> invocation of TEE objects similar to the existing tee_client_invoke_func()
> >> API exported by the TEE subsystem which allows invocation of TEE functions.
> >> Some suporting changes are also introduced to track and handle operations
> >> for TEE contexts opened from the kernel-space in the back-end QCOM-TEE
> >> driver.
> >>
> >> Finally and as previously mentioned, access to the object-IPC based uefisecapp
> >> service is restricted on older QTEE firmware versions. A new QTEE firmware
> >> release must be picked up from QArtifactory [2] for all upstream supported
> >> Qualcomm SoCs to enable access to uefisecapp service via the TEE client
> >> driver.
> > 
> > What about fused devices?
> 
> The procedure for updating the firmware on fused devices is slightly different.
> The firmware images need to be signed by the OEM using the security profile
> of the chipset before flashing/upgrading them. Security profiles are now public:
> https://github.com/qualcomm/security-profiles

Will OEMs release new firmware images? What about the devices which are
already out of the support phase? This whole story rotates about the 'we
are releasing new firmware with new features' paradigm. However there
are existing devices in the field, which typically can't be upgraded,
From your cover letter it seems they can't support UEFI variables
properly. However they do so in Windows.

-- 
With best wishes
Dmitry
