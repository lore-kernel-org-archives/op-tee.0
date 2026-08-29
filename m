Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769A3C61DBE
	for <op-tee@archiver.kernel.org>; Sat, 29 Aug 2026 14:49:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 798C04509D
	for <op-tee@archiver.kernel.org>; Sat, 29 Aug 2026 14:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788014972;
	bh=VGiHucK8egSUwm6QXTmg+zGK+Ml4G4Teru/fxAoHchY=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=lhB49QMWAJwgZNA0IXg/pJzFbBzrx0+EkOaf75WY5MN5mP9Nv1T7Z6p4U9F2j8EaY
	 dFqIV5hNGMPdTnaqNeAg3ACr2+3DqoQv4TcyvthqqUAQ7N6VkjifD7VHSgOfiIn8P7
	 nydEwplPUjgY8irrBmeptr+KpNQa95Qy5ZVPGS3meYoydRxwc8GHYBT2KfksigCJMw
	 xO6dc/6pctBFgQp1EzmtcX3E37FAyK6MXQkdh3OepIbex+6OhBkfejuwcCDxBUaaqg
	 sJVvGyB28uYbrlnPEY4ns7Q8sLcFFgFdB64NTZdQ1QQBPvNPem2uweX2ypl3E6uhmy
	 9S4iPTpC1NBgg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8A56144E43
	for <op-tee@lists.trustedfirmware.org>; Sat, 29 Aug 2026 14:49:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=of5W0owx;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GcmyPHLY;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67TE3jSS1942680
	for <op-tee@lists.trustedfirmware.org>; Sat, 29 Aug 2026 14:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mRcAWMWWAO4bmXUchW51Cpkq
	hE99CQQjsdP8CEiB6Gw=; b=of5W0owx5jbZyvu0zGbKi128qJrFB7E4uCdyG6G/
	FAvIZlHG7pn0Bd0ZT6JV+vDA+SHx+irMzjpKEUkdibA8AqhH1/gkuzDLqT2cTOiW
	R2TM3sk4yhB7aa3JEjbAl6bf0cYLLReVAFZWvOEXifSlHCjmOTDi3k/uq+x+pXQg
	A8AfOHheiFhBrpvVpDtm95d1gJ2cLhQ0QzXAsTOWRs8G3TuQVwd21Z6ztm5oVy7f
	2fkf5QLXbfuiCvco1UaAwqJdT00WRe41SLODly3ptEMtCtwe0JTaoZoNNczUzjAE
	tt9SDTUL27xaCbauEGyXLI7IK5vrc2LzzesxVFZPYuHA+g==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqfb16p6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Sat, 29 Aug 2026 14:49:22 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-78489ad6d69so1977842137.0
        for <op-tee@lists.trustedfirmware.org>; Sat, 29 Aug 2026 07:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788014962; x=1788619762; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mRcAWMWWAO4bmXUchW51CpkqhE99CQQjsdP8CEiB6Gw=;
        b=GcmyPHLYLHo3KaDl0wtvwaR6TUQ2KJoiw8Vj9DTOqWW1ITCCmKQcejcbri4hggCThk
         V0pw4gmyZ9WSGXZeWrvA2cE5XYTUpnGihfyf/OAaw4yP9X0skERoOGroCf57rThZdseg
         3p5hVIEYF+Ks4G4wCf+J0d/PWu7KFsBr8g9aaMSbb6+jldlkftml/B/iFd9d0inanee5
         Ub2/Syo290h70gVJ4TQt4Wuq6YB/jRQs3PUDB05sWu+DevHNO6KqZwzT7M7Giy6rs02U
         5pLBxRY/FbbRtYlhBqb0V4wsIomTALh1lLRMrYWh8YlpD9u60v33mgTIDzUr4B7fLS5w
         6nNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788014962; x=1788619762;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mRcAWMWWAO4bmXUchW51CpkqhE99CQQjsdP8CEiB6Gw=;
        b=itqhDlxL1W7yGOWl/VopwfgRX8HcI2HYBEiIY2oLyQ/zM8ieXxkDtvXhsPpb47oaka
         syQfSelfGk9w/6/Ld0PeNibct/bTBHbbVbso06xrBTup9P4goB7igOwerLKBkVW50INO
         vKEOWXQE6KBo5FVuRz3kn+LWTqJIG9lgQQlcYimGwCoP5e8qP78yLmZHpMOL/xII3W0R
         0Kp8SPvV86G3qnPfw8+W4lt7g6IuOEVPk80upyLxVvmIjp8U+qQN5xgj1SCKtHwVcOZ7
         SBkKhx4Qu0XwR0bkPqwZrO/Yei54DKIiGTi5GDHXivCdQ+rvKZgO9EM45TUbaBizGY6A
         DJBw==
X-Forwarded-Encrypted: i=1; AHgh+Rp3cz9UgVBDnnP/e7+xr/KKmrFWsupA03kfWXkG9G6Ey+9HVDW7wGAx5k/UwRrCOmB7xuHhyP8=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++lHwGsJIQRBIcSE2anfL+UR+qSUtB2EviCNppauc5w0vrK+9fHR
	vWATTPEP1fl0osLS80451nmBdGEgQrkOBqSExdKPGBHYUVqCaIEvIuo6WVW2CNvsJdjCfeFd3ZV
	y++uZuPovoCtJniKwlfkpV2hxI4QX4EkXGvSFpzqEfoasialvCTTeQdUwCtIapTKxVdpWbGw5
X-Gm-Gg: AR+sD12BWU1tfoPAmBW9TjZwUuoNjBTG698hpQ6QoYdR3VithbithNJ1myYX4C9Hj7e
	VQE4WQ7JQNILoNBkRNhemcF+G6Quy8Rd/FP1cG7OERTOt4wdspfsHO/SKAPHgfHeLZTEgxdWD/c
	M2LNNrFpB7wF51ZNqXAeJXkNtfG21nCl/wqb/iAGsJ14aeh3bYnibxiFAx6EEcjLi/CYRa/FcXV
	AatLbp8m6SauVx+98UBHOocb5aYygUbUj6rQu0j8T1B5pAVQq/DpYYunh6t8L3r7oOugm7ywcvV
	kKjXdNZ06MqaxrFz+9IOzpwJL//l/nGSiEmANV7DosagXtKVUrrvJYDPyK7UJfZoNWGdulbPunr
	G/JYu0FwV6TFbCmpKfVJlTzm+z6OztkcUcUYPRZ/konGf7p6YMNy6g0PCE7XTEzbfE+g9TZtkMn
	6PQIhOABFqIpif
X-Received: by 2002:a05:6102:50a8:b0:786:4822:308f with SMTP id ada2fe7eead31-786482230fdmr3794762137.13.1788014961967;
        Sat, 29 Aug 2026 07:49:21 -0700 (PDT)
X-Received: by 2002:a05:6102:50a8:b0:786:4822:308f with SMTP id ada2fe7eead31-786482230fdmr3794740137.13.1788014961320;
        Sat, 29 Aug 2026 07:49:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b5e8a06a47sm1019648e87.49.2026.08.29.07.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 07:49:19 -0700 (PDT)
Date: Sat, 29 Aug 2026 17:49:17 +0300
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/6] Add TEE based client driver for UEFI Secure
 Application
Message-ID: <wjzuf7regh2rvrt3spkesp3qanooiqpkua6f7mgq6ulw5z3hvp@q2fkcu2bueow>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
 <nfijwr2ptpxqvdw625yedep7tmakwvkeavyeobrmig5hbkw77w@rcqyp7h4y327>
 <db27820a-2b43-45e4-bc4a-0e9e81aacd93@oss.qualcomm.com>
 <oicbypv7rpxmweclopi5xxpcfq5chnypp5tlqd4uix2pm5e72f@kd3bibeximjq>
 <10a091a4-89a5-4a0c-820d-c5b91dd52529@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10a091a4-89a5-4a0c-820d-c5b91dd52529@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDEyOCBTYWx0ZWRfX6xDyJrxGonrm
 PWDLFLvfLo6wnsrYfdU7mvalGDbh7z/xqxqmSuwUKvVVR2qRiLrTBiDvmcESgna7XFd5XSNKPQ+
 HT81kXp5jdQ9qCeua75UDhEC8cXtoSbtSS+ZTEg1p4Gan5DpkLVBbkjHJxq9hGkn8eMH7gOsYso
 4UkIcDdRFPbIReo9H2/5r7V9vRkC+HzhkkBE7lpxlqhsjDGMDlVhVq94pvh5pCss1bFin+YIG4w
 7d4xuZ7EIJyKbgKmbc90Hd96C3FTrbChFvfHMG0DHPGkTMcb2kES4fTDRg2DlahyCtCB8k2jHuw
 7vyFqOZrL9Fl3tDymxP4yOPRr/TOKL+oWQUqwlLYq01r+ICaZneQZxrOuBo+RJfMFnnKQr9ye7v
 x53uk7LH8EY2su06/P3VwmMliMJflnY2M0ez8+Fuo0JjmrdPfxWEvfrnisFIWpYIb8zgdnuXYRX
 Ws9mZhAbhhgSzbdFvxw==
X-Proofpoint-ORIG-GUID: UVfFauShNy3n0C-fv4xtv-WaG8FIc5iC
X-Proofpoint-GUID: UVfFauShNy3n0C-fv4xtv-WaG8FIc5iC
X-Authority-Analysis: v=2.4 cv=Q77iJY2a c=1 sm=1 tr=0 ts=6a92f172 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=P-IC7800AAAA:8
 a=NEAV23lmAAAA:8 a=BUJ8enzRhoikPvGbR6IA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDEyOCBTYWx0ZWRfX++ZVD/Bqk/eG
 408SdslT/OwYhhzVgQuLZN4EEj/araA8tUPTQWv800DmkPxtuhVpmuk8c0veGYvyN1SSc2PKBmN
 o3KUv1BxYXbTBpZbfcrbDrT9ZtNkhzg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608290128
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.217.69:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[205.220.180.131:from,2001:14ba:a073:af00:264b:feff:fe8b:be8a:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8A56144E43
X-Spamd-Bar: -----
Message-ID-Hash: MUTMBU32Y36QL4LE2T77JOSMAMCXQFNY
X-Message-ID-Hash: MUTMBU32Y36QL4LE2T77JOSMAMCXQFNY
X-MailFrom: dmitry.baryshkov@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MUTMBU32Y36QL4LE2T77JOSMAMCXQFNY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Dmitry Baryshkov via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

On Wed, Aug 12, 2026 at 05:00:27PM +0530, Harshal Dev via OP-TEE wrote:
> Hi Dmitry,

Hi Harshal, please excuse the huge delay from my side, I was on vacation
and then burried under the rest of the issues.

> 
> On 10-08-2026 12:37 pm, Dmitry Baryshkov wrote:
> > On Fri, Jul 24, 2026 at 02:43:42PM +0530, Harshal Dev wrote:
> >> Hi Dmitry,
> >>
> >> On 22-07-2026 01:56 pm, Dmitry Baryshkov wrote:
> >>> On Wed, Jul 22, 2026 at 12:29:11PM +0530, Harshal Dev wrote:
> >>>> On Qualcomm SoC based platforms, UEFI stores EFI variables within the
> >>>> Replay Protected Memory Block (RPMB) which is only accessible by the
> >>>> Qualcomm Trusted Execution Environment (QTEE).
> >>>
> >>> Is it so? I think RPMB is accessible to Linux...
> >>
> >> I should have been more descriptive here, RPMB is accessible by Linux but
> >> its frames can only be prepared by QTEE.
> >>
> >> The RPMB key which is one-time programmed into the storage controller to allow
> >> authentication of the RPMB frames is generated by and only available to a TEE.
> >> So on Qualcomm platforms (and many others platforms with a TEE) Linux can only
> >> route the RPMB frames generated by QTEE to the storage, it cannot create and
> >> write the RPMB frames itself (it doesn't have access to the key).
> >>
> >> While it is possible for Linux to generate/program/store this key, on Qualcomm
> >> platforms we do not want Linux to do so because we do not trust it. We trust
> >> QTEE.
> >>
> >> I will re-phrase this and make it a bit more clear everywhere.
> > 
> > OK.
> > 
> >>
> >>>
> >>>> For Qualcomm platforms without emulated RPMB support, specifically
> >>>
> >>> What is emulated RPMB support? Why is it mentioned here? Which platforms
> >>> use emulated RPMB?
> >>
> >> Emulated RPMB refers to RPMB on a storage which doesn't have its own firmware.
> >> Primarily, NAND/NOR storage. Unlike UFS/eMMC storage, NAND/NOR storage does not
> >> have a storage controller where we can program the RPMB key to be used by the
> >> firmware. So we must 'emulate' RPMB by moving the storage driver within QTEE
> >> and making the driver hold/use the key.
> >>
> >> Qualcomm compute SoCs (Glymur, Hamoa) have RPMB available on SPI-*NOR* storage,
> >> and a driver for communicating with it is also available in QTEE. And so, these
> >> have 'emulated' RPMB.
> > 
> > This needs to be explained in the cover letter.
> >
> 
> Ack. 
> >>
> >> I will add this detail in an updated cover letter.
> >>>
> >>>> platforms where RPMB is not located within SPI-NOR storage and instead
> >>>> located on UFS/EMMC storage, non-volatile EFI variables can only be set via
> >>>> a callback request from the UEFI Secure Application to the RPMB service
> >>>> running in user-space (within the QTEE supplicant [1]).
> >>>
> >>> Can it be moved to the kernel?
> >>
> >> We have a plan to move the RPMB service to the kernel similar to OPTEE:
> >> https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/tee/optee/rpc.c#L449
> >>
> >> It is a work in progress. Once this happens, we don't need QTEE supplicant available
> >> on the Linux distribution.
> > 
> > Ok.
> > 
> >>
> >>>
> >>>>
> >>>> Unlike the QCOM-TEE driver, the QSEECOM driver (used by the current
> >>>> QSEECOM based uefisecapp) does not support callback requests.
> >>>
> >>> How did it work then? I think Windows has been perfectly using QSEECOM
> >>> rather than QTEE.
> >>
> >> It works because Windows on Arm on Qualcomm has SPI-NOR storage. A driver for which
> > 
> > I have WoA devices without SPI NOR. Windows still can store UEFI
> > variables.
> >
> 
> Ahh, the key point here is 'Windows'. Windows has a separate way of providing
> RPMB access via a service in the TrEE driver within the OS:
> https://github.com/microsoft/Windows-driver-samples/tree/main/TrEE
> 
> However, the Linux QSEECOM driver we have here in upstream does not have that support.
> And so without the QCOMTEE + QTEE supplicant combination, we cannot access EFI
> variables on these Qualcomm WoA platforms when they boot with upstream Linux.

So, this must be fixed, I assume? What is the ETA?

> 
> >> is available within QTEE, and so QTEE does not need to make a callback request
> >> to Linux to request RPMB frame routing. However, in case of UFS/eMMC storage the
> >> driver only exists in the Linux kernel and so QTEE must make a callback request.
> >>
> >> And so, if you try to use the QSEECOM driver to write EFI-variables to RPMB
> >> on a device with UFS/eMMC storage, it won't work.
> > 
> > Yep. It seems to work under Windows though.
> >
> 
> As explained above, the mechanism is different for Windows. A different driver
> and a different protocol. :)

Let me be very explicit here. The path used by Windows is tested and
verified to work on a plethora of the devices. Those devices must work
with Linux too, so, in my opinion, we should use the same firmware path
and the same firmware interfaces as used by Windows.

> >>>> And on
> >>>> certain Qualcomm platforms such as the RB3Gen2, attempts to access the
> >>>> QSEECOM interface fail due to lack of support within Qualcomm TEE.
> >>>
> >>> So, I assume, on RB3 Gen2 the QSEECOM doesn't report uefisecapp as
> >>> supported. Does it?
> >>
> >> It doesn't, this API returns -2 if I add RB3 Gen2 in the allow-list for QSEECOM:
> >> https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/firmware/qcom/qcom_qseecom.c#L46
> > 
> > Does it support QTEE-based uefi variable storage?
> >
> 
> It does, the QTEE-based uefi variable storage app, i.e. uefisecapp is loaded by
> UEFI on RB3Gen2, however, the QSEECOM interface on RB3Gen2 is broken so it misreports
> it as 'not supported'. But the app is loaded and available, which is why if you apply
> this patch series, you can communicate with it. Just make sure you take the QTEE
> release mentioned in this cover letter.

Can't we fix the QSEECOM instead, if one needs to flash another release
anyways?

> >>>> On these platforms, a TEE based uefisecapp client driver is required to:
> >>>> 1. Access cached & volatile EFI variables stored in uefisecapp's memory.
> >>>> 2. Ensure persistence of non-volatile EFI variables via writes through
> >>>> the RPMB service hosted in the QTEE supplicant.
> >>>>
> >>>> This series introduces such a uefisecapp TEE client driver for the
> >>>> aforementioned Qualcomm platforms which installs efi-var operations _if_
> >>>> the QCOMTEE driver registers support for an object-IPC based uefisecapp
> >>>> service on the TEE bus during its probe. Only new QTEE firmware versions
> >>>> available at [2] provide this support.
> >>>
> >>> What about existing WoA devices?
> >>
> >> New Windows on Arm devices like Hamoa/Glymur work perfectly fine with existing
> >> QSEECOM based uefisecapp. But they will also work with this new QCOMTEE based
> >> uefisecapp once they upgrade their firmware.
> > 
> > Do extisting commercial devices suppot it? For example, does Lenovo T14s
> > support it? Will it continue to work with this patchset in place?
> 
> Existing devices like the Lenovo T14s do not have mature QCOMTEE/SMCInvoke support
> on QTEE side and new QTEE versions for it are not being rolled out. However, this
> QCOMTEE based uefisecapp driver and the QSEECOM based uefisecapp driver can co-exist.
> It will not cause any breakage of existing working functionality since the QSEECOM
> path can probe and continue as usual.

My understanding was that QTEE path completely disables the QSEECOM
path, does it not?

> 
> As per your comments on patch 6 of this series, I plan to enable the QCOMTEE based
> uefisecapp as default 'm'. That way we don't need to enable one over the other and
> will continue supporting all existing functionality while extending it for devices
> with UFS/eMMC storage and running upstream Linux.
> 
> Do let me know your opinion on it.

My opinion is very obvious by now. Existing devices should work. _Must_
work. They provide the reference interface. Make them work first and
work good. Then explain, why the other interface is better (I fail to
see it from your cover letter or from any of the commit messages).

When I take a Glumur laptop from the market shelf, will it be QSEECOM or
QCOMTEE? If I take the next-generation-after-Glymur, will QTEE interface
for uefisecapp be supported there? Will it be used by Windows?

I think the series fails to answer, why do we need another mechanism, if
we already have one which has been working for the past N years and
which is supposed to work for another M years?

> > What about other existing devices? We have WoA devices starting with
> > MSM8998. The QSEECOM driver works on them, but, as you mentioned, it
> > can't flash updates to the backing storage.
> >
> 
> Unfortunately, unless we roll out new QTEE firmware versions for devices like MSM8998
> with QCOMTEE/SMCInvoke support + access to the Uefisecapp over SMCInvoke protocol,
> they cannot be helped with this series.

So, I'd say, the series is strange. We are proposing something which is
not rolled out, which is not supported by the exsiting commercial
devices, etc. On the other hand we have future gaps which are known.
This doesn't sound correctly.

> >> I need to double-check but this firmware release for Glymur on Qualcomm Linux
> >> is probably carrying the support for QCOMTEE based uefisecapp access:
> >> https://github.com/qualcomm-linux/meta-qcom/commit/728251fcbe5113980805ea6c571e33235062ee71
> >> If not, the next release will definitely have it since I have merged support for
> >> this in QTEE and talked to the boot firmware release team about this.
> > 
> > Does it work on the CRD?
> >
> 
> Yes it does, I have validated on Glymur CRD by locally switching it from the current QSEECOM
> based uefisecapp to this new QCOMTEE based uefisecapp. This is the QTEE release which

Why do we need to switch the app? Why is the old one worth switching?

> needs to be consumed for it:
> https://github.com/qualcomm-linux/meta-qcom/commit/5590c1dc631827624c110df282965b85ef2a2e60 
> 
> >>
> >> The next planned firmware upgrade for Hamoa will also provide this support for
> >> Qualcomm Linux. And similarly, for all other targets being supported upstream.
> > 
> > So, we are forcing users to upgrade to the new firmware? That doesn't
> > sound nice.
> >
> 
> We have an open ecosystem for all devices supported by the Qualcomm Linux distribution,
> users can easily consume new releases (and new QTEE versions) to access new features.
> Until now, developers/users of RB3Gen2 or IQ-9075 could not access EFI variables to

What stopped us from delivering the TZ apps compatible with the existing
interface?

> develop use-cases such as secure-boot key revocation, but by taking this patch series
> as part of a subsequent Qualcomm Linux release, they will be able to.
> 
> >>>> Thus, QCOMTEE now maintains a static list of always-available object-IPC
> >>>> based secure services exposed by QTEE. These services are implemented either
> >>>> within the QTEE kernel or within a pre-loaded Trusted Application (TA)
> >>>> usually loaded by the bootloader. The uefisecapp TA is an example of a
> >>>> preloaded TA loaded by UEFI. A static list is required since QTEE does not
> >>>> yet expose any way to dynamically query and enumerate the services exposed by
> >>>> it.
> >>>
> >>> Can it be fixed instead of having static lists? In the end, we can't
> >>> guarantee that users update the firmware.
> >>>
> >>
> >> Unfortunately, no existing QTEE release out there currently has this support.
> >> But support for this is currently being added by QTEE team last I checked with them.
> >> Once it is available, and a new QTEE firmware release is out there, we will add
> >> support for dynamically querying QTEE services in the QCOMTEE driver. 
> > 
> > It seems you are still rolling out QTEE-based support. In such a case,
> > please go back and implement dynamic detection of QTEE services.
> > Otherwise it would be a nightmare.
> >
> 
> We are working on it, but until then there is no overhead involved in maintaining
> this static list of services because we don't have to extend/modify this list when
> adding support for a new Qualcomm platform upstream. If a particular service from
> the list is not implemented/accessible from QTEE we log the event and silently avoid
> probing the TEE driver for the service. We also don't add platform specific services
> here. So the list doesn't need to be extended on a per-platform basis.
> 
> So unlike the QSEECOM driver, we don't have to keep maintaining this list forever
> for all new platforms.

I don't see a difference. You are saying that the list implementation is
good, it silintly skips the unavailable services, etc., and then you say
that you don't have to keep maintaining the list.

> >>>> To facilitate object-IPC interactions from the kernel-space, this
> >>>> series also introduces a tee_client_object_invoke_func() to allow
> >>>> invocation of TEE objects similar to the existing tee_client_invoke_func()
> >>>> API exported by the TEE subsystem which allows invocation of TEE functions.
> >>>> Some suporting changes are also introduced to track and handle operations
> >>>> for TEE contexts opened from the kernel-space in the back-end QCOM-TEE
> >>>> driver.
> >>>>
> >>>> Finally and as previously mentioned, access to the object-IPC based uefisecapp
> >>>> service is restricted on older QTEE firmware versions. A new QTEE firmware
> >>>> release must be picked up from QArtifactory [2] for all upstream supported
> >>>> Qualcomm SoCs to enable access to uefisecapp service via the TEE client
> >>>> driver.
> >>>
> >>> What about fused devices?
> >>
> >> The procedure for updating the firmware on fused devices is slightly different.
> >> The firmware images need to be signed by the OEM using the security profile
> >> of the chipset before flashing/upgrading them. Security profiles are now public:
> >> https://github.com/qualcomm/security-profiles
> > 
> > Will OEMs release new firmware images? What about the devices which are
> > already out of the support phase? This whole story rotates about the 'we
> > are releasing new firmware with new features' paradigm. However there
> > are existing devices in the field, which typically can't be upgraded,
> > From your cover letter it seems they can't support UEFI variables
> > properly. However they do so in Windows.
> >
> 
> Yes Dmitry, this series is effectively forward looking. QSEECOM protocol/driver
> support is essentially deprecated on QTEE side, no new features added to QTEE support
> it, and it also doesn't work on many devices like the RB3Gen2.

To look forward, we need to have a good firm stand on the ground. We
have a half-baked implementation, based on reverse engineering. No RPMB
support, etc.

> For existing devices, if they boot with upstream Linux and have RPMB located on
> UFS/eMMC this patch series cannot help them. But the focus of this series is not on the
> past, it is on currently supported and future hardware. Every new Qualcomm platform
> whose support is being up-streamed or is planned to be up-streamed will have access to
> EFI variables via this series.
> 
> If someone wants to add support for older Qualcomm devices to access EFI variables
> via QSEECOM that patch series will not conflict with this one. Like I said, both
> QSEECOM and QCOMTEE based drivers can co-exist.

What will happen if I build both and boot the kernel on the existing
devices?

-- 
With best wishes
Dmitry
