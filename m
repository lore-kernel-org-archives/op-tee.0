Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12706CA5FF0
	for <op-tee@archiver.kernel.org>; Mon,  5 Oct 2026 12:00:53 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3D83745242
	for <op-tee@archiver.kernel.org>; Mon,  5 Oct 2026 12:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791201652;
	bh=J4f3p9npyqHrcIAJJeagZsStVI/MJ0U6TEfe6bpSb0E=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=eC/33oGo0p5jbVdyORKuQQ6Irw0/FlhaganFI5wlLcFhvfflpdEJGuc9rdCiEXaYy
	 BXKinjTB7BI1bYIqgoFiLF9N5D7lI1oZQPg/UtoTpOxdcBDpBX+mAK8FuMVMuW7+7A
	 UbbPVobkiLTr0ug9E/EUmj7lCx/ttU+ELM8Cw1jA5D7HyDqnd4EkiOn/po2d5aAxI6
	 WwO2PCWvh+jWBRHCYdBWHVMpB3FvDw3LmLdvNCGsOpMT8G/TY9G9NkoTqhXUf0kmj0
	 Oxa0Q5IeJU5cAYCHlhGX/I2CQjYSLgxfHF9Mcv2BxarE1jJvRRs5m8vzYczrRnNrXI
	 rKZjtz6fRK1ZA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 84E693E882
	for <op-tee@lists.trustedfirmware.org>; Mon,  5 Oct 2026 12:00:42 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=atC8/+GU;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kYrUA4Fl;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695BU3wJ2129308
	for <op-tee@lists.trustedfirmware.org>; Mon, 5 Oct 2026 12:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NjqrkeGFYtSDE4uh57Qyu5uwPPi7oB0ETinHFeakgL8=; b=atC8/+GUTPUwWVMT
	STecLuCaR8X/jeIAcvaelX0sxrJ2tEHRqQEXCaPKa8TyDKd0/V+vFJ8hLSNWBsP+
	LB1DqGTiYtnXMRMcGJ149UE6O8iQC/RsNxWuczKl8RUz8crNsbJgUun+XbXCTeJv
	hXnFNMW9YJizYijb6FCVtjjZUPLT35iJeBGe5jXL5U46IOywT7MngsgrqWeJp5lf
	B9STWTf/Q8NyXDTnju9F6sSRRarstjaLJ2gjGKZuz58BCH1OsXoFJ5XitnYIKbj1
	ZMJLiPlDAd+LeCRWOvSpmMmfAdQC0QzYqJNToF3aQy1k7Tq+pFnY64l1h8HbiOWf
	GV98xw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2spa5rp9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 05 Oct 2026 12:00:35 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a4f7eb79f2so1620016a91.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 05 Oct 2026 05:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791201634; x=1791806434; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NjqrkeGFYtSDE4uh57Qyu5uwPPi7oB0ETinHFeakgL8=;
        b=kYrUA4FlIKPDz4gNq7x95HxzeCZpa2fflUVEImxTnMTlg1k10KoE12HnKjgC9S9zMy
         ZyJmvJk8Em9xiOl2nsVK1EwnrwWgbj1UXMxKk2QTWbgwhs9SeGL6+nSiNJs98oqB1EE0
         Uxs43fDbU6UcQ03npfF3lYuKgg09PpUZd4ai2IVzM8zIYUlMarKvX6xhcf/eCMjaEOkJ
         0eHz8ZaCNO6OS2uVYVUU9HrvS2BCyRdSCYGP1ffYi1o74ZuQqY0pTTtKvaE7B2BpJKk7
         JK9kGqNMp+Mc+2mFzKY2A3RYHshX/Tw1cnq0NOSqcF7Zhhgj03dAhu+mHuxm+pibO1Hs
         tU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791201634; x=1791806434;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NjqrkeGFYtSDE4uh57Qyu5uwPPi7oB0ETinHFeakgL8=;
        b=ugZZwvOK5gZKlsHHN48dwT8U8HqTHXovFhuC9x3hBLoTWqD+10iBVoY4iqsciX74V8
         jD6ESqeYFg+ikx66e3ruzuxZb3kdhFDfvmhoCjWMNDvsYKR/2uc1J5BHixVPXJ0g3acD
         UD/EtHCLIVss/uJ0KYBfxsXJA6ZY1ad53kXsHbJmVHw1OpRuLJ7bD449ZLUPVGLa0ZmO
         MKA4koa+bgOvo61Ab9wj+UKT1MyOnr0XBrR4YzvpqASUOXGY8dzyOCjAqu7KtYTYNU4w
         u+SKZR82LENfE+u9ASFRoOwGOA0wBFnJpc5HCpo0K7hpUKiPQYOrsApq/G6P+yM7MVZ9
         RpQQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+5xyamIiksp9VXn+80JZRUp1lpO4kvaZDxapu9nwb2ktm5/9Z+4Nvr2fpstzHxDYo/t3OAJs=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLjbRoXTr8jqayBdsGKvnGu59pA2SHIHUv2NRZD9wISrk1GAD12
	To9p79g+m46o8bz74a15gPuWFk+L6azl3QeSuGUcJw1qqmzhmlWxOSMmxIXMNzOEwNks8TUEZLp
	kwOGjtVM0a5zjACNf7U8dE4d1yKiMmbSL8ODfR1XW3auI2rltXeo1wTWc+/nNvKlSS6cn5cWL
X-Gm-Gg: AYBFou34KYpXpnE+cVZAmujEpJCM0KJrVZ8xCZRYE75Pn1RTGhYmek+0krmxUyNeyQE
	q4E8uNztI0KCb5IupnDxnhtrdZ9BjxkpdODI16v79SgoTEoXNKNg2Cb/5LRwS6HC/U8fRw6cZCk
	bEJd/FxCFB1vsnQ+A7rL5JL2apT/LMtPDo0JW/mKvttgGsqTBIl4OuFr61kQOu9ibKsgs3xb3CW
	TIaGwuheMfkheMKEJYnfm9uU1EuZyV9cZBLM5AHGb8hyIj8QK8uiAxhAuP1osQvoRhH+t68vwux
	oBAs2WyFYN7QLtJZ7cbKOxhBRfP1xzd0j+H7aUROknsEN5g2akG6ksnrxxzTDlXkWn066brH8DE
	qhac8M/0ZYehSZSLAMy8uhD56rg7u8g==
X-Received: by 2002:a17:90b:4c05:b0:3a4:ba6e:65c9 with SMTP id 98e67ed59e1d1-3a6ce963ad0mr4301166a91.59.1791201629661;
        Mon, 05 Oct 2026 05:00:29 -0700 (PDT)
X-Received: by 2002:a17:90b:4c05:b0:3a4:ba6e:65c9 with SMTP id 98e67ed59e1d1-3a6ce963ad0mr4301044a91.59.1791201626566;
        Mon, 05 Oct 2026 05:00:26 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d6b3ceasm11047079a91.10.2026.10.05.05.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 05:00:26 -0700 (PDT)
Message-ID: <e1ae7f91-0787-434d-9553-3ced487fac6f@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 17:30:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add TPM support via Qualcomm TEE TPM TA
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Xilin Wu <sophon@radxa.com>
References: <20261001055029.1960743-1-zeroknots@protonmail.com>
 <0c6d29ce-920a-4566-9a4f-a0687b0e5ddc@oss.qualcomm.com>
 <b2xdth3hkuypnvxlrgssnj4toffbceohhnh7w2ju46fzinflfd@qaq6ai5plolq>
Content-Language: en-US
In-Reply-To: <b2xdth3hkuypnvxlrgssnj4toffbceohhnh7w2ju46fzinflfd@qaq6ai5plolq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0NiBTYWx0ZWRfXxdEuMLz546zE
 pXQnkrVyFkBEuWgHtCzULdslYwC1uokLJqBAN7RZ0Z/+i8muHfL6P/IKc6RPY/9ShPWPDyv17nj
 zKviySqGMb6usLnDyq4Yfe9gCcRnyy0HKmKuboGbOjUR4nsNAA2GAh6lbNb7XebalAr/Krx75DH
 HDLIcTyxtF5osN6eVgfUe83SMDP5Zf4KEJ89KdCniOcxrLkrKSWcnDoEAMwH4xqtvt7FSTAUgs7
 kMYYxqg+/Z6hAj5EgsdvkbpYA+GoOuFLxRgC7qeFsPHb0rO5B+jnAdB2czs5+wQ2q+12cGLs34W
 nPDTWBDGlGD9kjrKWJGsE/VHozANLh9cUFr9BQdsl/7VaFmeSVp5t8ptGtN5FrrNPhLux4VX1lV
 Fn7wrVAMyPwx8daGw9Blf4EGgQPJczfVNz77kJyMvpEsvaN2E/K1TrrNII6nl+Xni8OKG7JwOyt
 Ytq2nQGyhd8qMsUBizA==
X-Authority-Analysis: v=2.4 cv=b7MncdGx c=1 sm=1 tr=0 ts=6ac39163 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=WzojQP8EweJUJc-V32sA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: MWv_T7W4Pw-bEOUeCQEDlT9vSWSODqxh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0NiBTYWx0ZWRfX9M8RC5rlcfil
 VGDJf0+d1xUknads79fxbKYqVbX+4zB9IEs5FIZj3IMYGlEJL31jvk1HSOa/tQgyyoxB4pxuCYh
 JAO4lY4R2fVwfJ/NPwHV8vKXu3wFFck=
X-Proofpoint-GUID: MWv_T7W4Pw-bEOUeCQEDlT9vSWSODqxh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050046
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.44 / 15.00];
	BAYES_HAM(-2.44)[97.43%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.70:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[protonmail.com,oss.qualcomm.com,kernel.org,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org,gmx.de];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[205.220.180.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 84E693E882
X-Spamd-Bar: -----
Message-ID-Hash: CRLLMKGPTBEZJK6CG4GD7H6UD5DGXE7S
X-Message-ID-Hash: CRLLMKGPTBEZJK6CG4GD7H6UD5DGXE7S
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: zeroknots <zeroknots@protonmail.com>, amirreza.zarrabi@oss.qualcomm.com, jarkko@kernel.org, jenswi@kernel.org, jgg@ziepe.ca, linux-arm-msm@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, peterhuewe@gmx.de, sumit.garg@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CRLLMKGPTBEZJK6CG4GD7H6UD5DGXE7S/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

>>> Two questions:
>>>
>>>  - Is service 81 expected to appear on retail firmware through an
>>>    update, or is it specific to the CRD firmware?
>>
>> Yes, there's spinor update(bootfw2.mbn) needed which is in progress to
>> publish as QTEE side changes were already merged long back.
>> Roughly it takes ~1month(ideal scenario) to get firmware changes
>> available but somehow it's taking more this time.
>>
>> I think i should have captured this dependency info in my series cover
>> letter to avoid any confusion.
>>
>> With the changes, service uid 81 will be available and won't see qcomtee
>> driver issue log there.
> 
> You are responding to the user who uses a COTS commercial device. Are
> you suggesting that the user can somehow update the firmware on that
> device?

Ahh, for COTS devices as one cannot replace firmware so it's better to
use qseecom path in that case.
For latest ones, one can switch to qcomtee based approach.

If Xilin already has qseecom interface written then it's best to have it
for the COTS devices.

-- 
Regards
Kuldeep

