Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0A4C88E5C
	for <op-tee@archiver.kernel.org>; Wed, 16 Sep 2026 13:18:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9933C452BB
	for <op-tee@archiver.kernel.org>; Wed, 16 Sep 2026 13:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789564684;
	bh=ZdzVUdKGuJbuUdoreohnBiST/+zqsZ7fJOFBCLD4adc=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=F/u4ybw5sACb2YqE61F6OPA3GVYB5jzAHTrCGxW8mFYNEOnKiIgVVH69XuxhMBAXB
	 SZvKHrF+U6ZomuenBHYHWTik4EtinsOkutj6D7TB+MDSW82gG0rU/2XQhn7CNrXZ3Y
	 lP+fQJdZxmF44AhjK5dBS7fiLkHqLI3VUEBoFmmmTjOnocSn+GTtkeqBak+8Cg2aAw
	 wO7i0kCGflw7zKsiUDoyPQG91TXk6JHSqvLFTzjfibNLu63BRRu5TmZpLr8RisYEqz
	 9hZmymhe4ZqLyOyDAJz0G+T2rUxTw9W1nhHRjFARk2ZWfCGP2HuVXpL0CaT1dD9JrL
	 AE4dqsPwAtAWw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6B60144438
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 13:17:57 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VAMPfih0;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RJU+IEcz;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GCYm5H2692066
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 13:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yHQkyirFPIu+CFaQpPRRHR+t
	zp1hZeQhJ1UaJsGSR1g=; b=VAMPfih0goi22Z0aWtSxuhw4Jyda+9mxnrrcdGZY
	vpMYK9aMthR0/PvazPIO0VNwwamHfBAlasf56SHfxpksZ4h/PHKWzmSpEOq9LagU
	Bo9azOVETATjKkpPmtmmof3F4FyF3KTrHEVXVuRmNMzI/v1ZtSmt1YoQXUuAjytj
	sA4FYrEW9hTmilr8AxBKcfedvNBIA2mBf4c6iMVY0vfxy+RjwnL6RUJk6L/Aa28w
	oqBfh/vX94TkJpYgzr4qredsXjtKcncjT6bHgolMXZiBNw4an403YOrY2TSJD1qh
	gBVs8T6cVaCRM/diwHj6OL7okotKrYFWNjP2T3Ci3qD3fw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqah9vfrt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 13:17:56 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7a10c3de1baso275707137.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789564676; x=1790169476; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yHQkyirFPIu+CFaQpPRRHR+tzp1hZeQhJ1UaJsGSR1g=;
        b=RJU+IEczBg4CSf5GMTU0rBmlC+5FMa8FIEK9cnKIUDTMkYj+9WL6n2TuTZjtOtAylk
         J9EQKwMQ7i0nsulrwgnwuMQnoldfizBYpiYF4uKo2VgA0Oei5LQcgor74JTrsk9+he6R
         dTgAlkvRdzXRZ7888t4vVEfCCxwhl99sQaMp2roRj5wG3UMcuL11QPewg46FufHS4pEK
         RwGX6WDmLhx18PI5QciKAnJ8qW8C5GwmJKAMwoZfRgTgEkfkDxP448XmFprAHabUm4GM
         i/2UjfT87IA3L7UzAZBjRuXpbxFuTKasVqozAeFyrwFDAXF70/+5XSRutoLuh+UHZ3Ck
         OrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789564676; x=1790169476;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHQkyirFPIu+CFaQpPRRHR+tzp1hZeQhJ1UaJsGSR1g=;
        b=x21ub/K8ldX4rwANzsKTSwTiQYvCYlF/aYSImnLUmvnZggg+HEeVeviIHyimZYwB24
         Wvi8TBIcjY0vvLIIDzkLP1kQr+hxZcRJeKFiFUFWlQdfOgp0mEK+YZyBXo+qp0Y7EJEM
         BOstFrtSSupM6SNZo84OSxzCwugflFuHJukeFT1uQYZKKLfuPKH/6GyWKzIgNmZqEIoi
         YHBTbdMaG/shpt5AoWWMmhGnxWMEmvpiPJwX76p2Uf7xk3XI0yLHsievk0oHsPADd7iM
         QFFtCJMU2p8dpFK94vJmEl2iywP3Qi7NGBTCmDRJ3k64jyUVEzre4CWiKrL4jamSx89x
         dHNg==
X-Forwarded-Encrypted: i=1; AKwUvBwn67YzzssIzzJkDkCon95kkUTMXex6rKbnR73LliQHsnhkklUT7rEeUeDLaj73oThE9BGVjlQ=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++nZTrU363DcoAwe/vv7MoGeQre7VO5FMzGBEXN87f3fE4ZAuwPZ
	CC0+cJFtd7Fdxc0IMKf+1bjoQOxdJ1r19XuTsHQB903jBBFn1dT5Y6pki8Ju8NDQfxj3DUkonaQ
	XaYtOulT8nbF0SUjfJMeEkQ9zUz4CYz58qFOAfFp8Y2KF4E/Lvggru0bgv3SBsMPUX9df3dbn
X-Gm-Gg: AYBFou235EsNiSypX4xC9Ju5bOR6MZEWfCT+MKmMazY6KoavLg0P0p5zRoWwzwkqPMc
	I72L5Igy1hUXP/mQFAvbZr9d8X8EP4iArHPP/bWwcriOMPDFuR6/BKyu7VToVV4rTN08NCXydCl
	JiTvYrUAGifh++pt5esUTVC5H9TX4tMcQTxVWPINmgMmp7N5tRCKeH10mP5bq68gQovF8TDhj0O
	7BYeYWEe04bx6JqGMtNCe31P3k/fqls8DOkgjoH9cf/4hm6kUMemWQojKCfHdOefwHImjKR1rqS
	W7cmjhn4tjLH2X6cBONORNo041HmCTIpuIBm0bpkH6gbEp7mGXtrBupOmeHSzhCcFkNuWc7JlaX
	8xhC7pQ3To6BBc5MR1MWdVQ4grw9Ec8RvHcSrG9LaZvG032U6aJ5v1ljkVT9L0KCUmLI3625v2A
	kDb0x87MZhqci3
X-Received: by 2002:a05:6102:161f:b0:79e:cc38:c40b with SMTP id ada2fe7eead31-7a0285a1f25mr2821897137.11.1789564670857;
        Wed, 16 Sep 2026 06:17:50 -0700 (PDT)
X-Received: by 2002:a05:6102:161f:b0:79e:cc38:c40b with SMTP id ada2fe7eead31-7a0285a1f25mr2821480137.11.1789564668396;
        Wed, 16 Sep 2026 06:17:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5daf0dbacsm5894961fa.4.2026.09.16.06.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 06:17:47 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:17:43 +0300
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/6] Add TEE based client driver for UEFI Secure
 Application
Message-ID: <lby2euy3igp6m5mnt5tdmn6njpmnpoebxiqwtcsmbfl4o25maj@o72kavh7vwyv>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
 <nfijwr2ptpxqvdw625yedep7tmakwvkeavyeobrmig5hbkw77w@rcqyp7h4y327>
 <db27820a-2b43-45e4-bc4a-0e9e81aacd93@oss.qualcomm.com>
 <oicbypv7rpxmweclopi5xxpcfq5chnypp5tlqd4uix2pm5e72f@kd3bibeximjq>
 <10a091a4-89a5-4a0c-820d-c5b91dd52529@oss.qualcomm.com>
 <wjzuf7regh2rvrt3spkesp3qanooiqpkua6f7mgq6ulw5z3hvp@q2fkcu2bueow>
 <ab7b94aa-6d9a-41b2-97fd-601db1cab5e6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab7b94aa-6d9a-41b2-97fd-601db1cab5e6@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=BtkIUoX5 c=1 sm=1 tr=0 ts=6aaa9704 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=P-IC7800AAAA:8
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7Qg-RMaVp9VtV8b7jR8A:9
 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: 4kIdQqxJ314zvTNVq1rkaPU5XN2F2T5e
X-Proofpoint-GUID: 4kIdQqxJ314zvTNVq1rkaPU5XN2F2T5e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE3NyBTYWx0ZWRfX/83WiXsFLO2R
 5o3O7axuRMlbQOfzCpnwLYmUFGWF8xpsQaAXGmG0qwSplvv6R7oG2KPhsXqBdE13foSODJe6Nz0
 gh4J7zzeEl78QPGyTxDoanWstExzE7vYJax1BpsF8K+9/zYk3P+Pl1uTv4zc8JW44IkG4odGB+k
 BJLKrVNM0JgO7Luh2DBidZ3fsqMBvo67cjzM7UZhc0uYcTv5tcLoFgRZRRJ3E1Q4W5kIw6yx6Io
 jng3LsYd7RSVottV0ZNzoPBeU7h/l3hNrVzcGQjd8CQOgEmlEqIzGL9dKu+ZRmOfxSqX4gOEKLE
 H1L7IwGtndIjZXgntRpY0p9L9L80kOHFojchTDVU2fC5KGEvjhLbG1+3Q3ft3mJ8vsK4tZqjsYN
 FPnlX9NZz62FuhEXRFKsXtVGt7RX4cqrMaIOyF2/86pbGznR8dDCRIjBwoswUInvS7ti7gx9hvG
 9llZ1bv7hTs1VxxGFxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE3NyBTYWx0ZWRfXwgYucClN52N+
 6E0vI0B9Uk8L1ytDzJE96/TgRfK283UGvGzEtg2snAorVMIZkmXIokr6u0t2j2mtnM6SGhYdgxz
 fCavQvKJk8C8CFi3SS8a+RhfH4+PeR0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160177
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.217.71:received];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6B60144438
X-Spamd-Bar: -----
Message-ID-Hash: UVCPQHICBBZJVMNQSU3GRCNQRZMQSNSP
X-Message-ID-Hash: UVCPQHICBBZJVMNQSU3GRCNQRZMQSNSP
X-MailFrom: dmitry.baryshkov@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UVCPQHICBBZJVMNQSU3GRCNQRZMQSNSP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Dmitry Baryshkov via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

On Wed, Sep 02, 2026 at 01:41:54PM +0530, Harshal Dev wrote:
> Hi Dmitry,
> 
> On 29-08-2026 08:19 pm, Dmitry Baryshkov wrote:
> > On Wed, Aug 12, 2026 at 05:00:27PM +0530, Harshal Dev via OP-TEE wrote:
> >> On 10-08-2026 12:37 pm, Dmitry Baryshkov wrote:
> >>> On Fri, Jul 24, 2026 at 02:43:42PM +0530, Harshal Dev wrote:
> >>>> Hi Dmitry,
> >>>>
> >>>> On 22-07-2026 01:56 pm, Dmitry Baryshkov wrote:
> >>>>> On Wed, Jul 22, 2026 at 12:29:11PM +0530, Harshal Dev wrote:
> >>>>>> On Qualcomm SoC based platforms, UEFI stores EFI variables within the
> >>>>>> Replay Protected Memory Block (RPMB) which is only accessible by the
> >>>>>> Qualcomm Trusted Execution Environment (QTEE).
> >>>>>
> >>>>> Is it so? I think RPMB is accessible to Linux...
> >>>>
> >>>> I should have been more descriptive here, RPMB is accessible by Linux but
> >>>> its frames can only be prepared by QTEE.
> >>>>
> >>>> The RPMB key which is one-time programmed into the storage controller to allow
> >>>> authentication of the RPMB frames is generated by and only available to a TEE.
> >>>> So on Qualcomm platforms (and many others platforms with a TEE) Linux can only
> >>>> route the RPMB frames generated by QTEE to the storage, it cannot create and
> >>>> write the RPMB frames itself (it doesn't have access to the key).
> >>>>
> >>>> While it is possible for Linux to generate/program/store this key, on Qualcomm
> >>>> platforms we do not want Linux to do so because we do not trust it. We trust
> >>>> QTEE.
> >>>>
> >>>> I will re-phrase this and make it a bit more clear everywhere.
> >>>
> >>> OK.
> >>>
> >>>>
> >>>>>
> >>>>>> For Qualcomm platforms without emulated RPMB support, specifically
> >>>>>
> >>>>> What is emulated RPMB support? Why is it mentioned here? Which platforms
> >>>>> use emulated RPMB?
> >>>>
> >>>> Emulated RPMB refers to RPMB on a storage which doesn't have its own firmware.
> >>>> Primarily, NAND/NOR storage. Unlike UFS/eMMC storage, NAND/NOR storage does not
> >>>> have a storage controller where we can program the RPMB key to be used by the
> >>>> firmware. So we must 'emulate' RPMB by moving the storage driver within QTEE
> >>>> and making the driver hold/use the key.
> >>>>
> >>>> Qualcomm compute SoCs (Glymur, Hamoa) have RPMB available on SPI-*NOR* storage,
> >>>> and a driver for communicating with it is also available in QTEE. And so, these
> >>>> have 'emulated' RPMB.
> >>>
> >>> This needs to be explained in the cover letter.
> >>>
> >>
> >> Ack. 
> >>>>
> >>>> I will add this detail in an updated cover letter.
> >>>>>
> >>>>>> platforms where RPMB is not located within SPI-NOR storage and instead
> >>>>>> located on UFS/EMMC storage, non-volatile EFI variables can only be set via
> >>>>>> a callback request from the UEFI Secure Application to the RPMB service
> >>>>>> running in user-space (within the QTEE supplicant [1]).
> >>>>>
> >>>>> Can it be moved to the kernel?
> >>>>
> >>>> We have a plan to move the RPMB service to the kernel similar to OPTEE:
> >>>> https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/tee/optee/rpc.c#L449
> >>>>
> >>>> It is a work in progress. Once this happens, we don't need QTEE supplicant available
> >>>> on the Linux distribution.
> >>>
> >>> Ok.
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Unlike the QCOM-TEE driver, the QSEECOM driver (used by the current
> >>>>>> QSEECOM based uefisecapp) does not support callback requests.
> >>>>>
> >>>>> How did it work then? I think Windows has been perfectly using QSEECOM
> >>>>> rather than QTEE.
> >>>>
> >>>> It works because Windows on Arm on Qualcomm has SPI-NOR storage. A driver for which
> >>>
> >>> I have WoA devices without SPI NOR. Windows still can store UEFI
> >>> variables.
> >>>
> >>
> >> Ahh, the key point here is 'Windows'. Windows has a separate way of providing
> >> RPMB access via a service in the TrEE driver within the OS:
> >> https://github.com/microsoft/Windows-driver-samples/tree/main/TrEE
> >>
> >> However, the Linux QSEECOM driver we have here in upstream does not have that support.
> >> And so without the QCOMTEE + QTEE supplicant combination, we cannot access EFI
> >> variables on these Qualcomm WoA platforms when they boot with upstream Linux.
> > 
> > So, this must be fixed, I assume? What is the ETA?
> >
> 
> I agree, it will have to be a separate effort. If new firmware QTEE releases are not
> being rolled out for these existing WoA devices, and if their RPMB exists on UFS/eMMC
> then the only way to support EFI variable is to:
> 1. Add support for callback requests in the upstream QSEECOM driver.
> 2. Add support for RPMB listener in kernel which routes the RPMB frames from QTEE to
>    the RPMB device via the QSEECOM driver.
> 
> This is significant effort for supporting a protocol which is deprecated on the QTEE
> side moving forward. That being said, I do not discourage this effort. We can think of
> a plan if we really want to support these devices. I will be happy to engage.

Why woudln't we want to support the existing devices on the market side?
I think this boils down to a few questions. See below (where we discuss
three kinds of platforms).

> 
> >>
> >>>> is available within QTEE, and so QTEE does not need to make a callback request
> >>>> to Linux to request RPMB frame routing. However, in case of UFS/eMMC storage the
> >>>> driver only exists in the Linux kernel and so QTEE must make a callback request.
> >>>>
> >>>> And so, if you try to use the QSEECOM driver to write EFI-variables to RPMB
> >>>> on a device with UFS/eMMC storage, it won't work.
> >>>
> >>> Yep. It seems to work under Windows though.
> >>>
> >>
> >> As explained above, the mechanism is different for Windows. A different driver
> >> and a different protocol. :)
> > 
> > Let me be very explicit here. The path used by Windows is tested and
> > verified to work on a plethora of the devices. Those devices must work
> > with Linux too, so, in my opinion, we should use the same firmware path
> 
> Agreed, as mentioned above, we can think of a plan to support these devices by extending
> the QSEECOM driver.
> 
> > and the same firmware interfaces as used by Windows.
> >
> 
> The interfaces used on Windows by the TrEE driver are different as per the information
> I obtained from Windows team. But we don't need to worry about that, we already have
> QSEECOM in upstream which we can extend.

Also added to the question below.

> 
> >>>>>> And on
> >>>>>> certain Qualcomm platforms such as the RB3Gen2, attempts to access the
> >>>>>> QSEECOM interface fail due to lack of support within Qualcomm TEE.
> >>>>>
> >>>>> So, I assume, on RB3 Gen2 the QSEECOM doesn't report uefisecapp as
> >>>>> supported. Does it?
> >>>>
> >>>> It doesn't, this API returns -2 if I add RB3 Gen2 in the allow-list for QSEECOM:
> >>>> https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/firmware/qcom/qcom_qseecom.c#L46
> >>>
> >>> Does it support QTEE-based uefi variable storage?
> >>>
> >>
> >> It does, the QTEE-based uefi variable storage app, i.e. uefisecapp is loaded by
> >> UEFI on RB3Gen2, however, the QSEECOM interface on RB3Gen2 is broken so it misreports
> >> it as 'not supported'. But the app is loaded and available, which is why if you apply
> >> this patch series, you can communicate with it. Just make sure you take the QTEE
> >> release mentioned in this cover letter.
> > 
> > Can't we fix the QSEECOM instead, if one needs to flash another release
> > anyways?
> >
> 
> QSEECOM is deprecated, requesting support for fixing it is an overhead at this point.
> Even if we take the time to fix it ourselves, it won't help, because the QSEECOM driver
> doesn't support callback requests and a path to the RPMB device within the Linux kernel.

Why is it deprecated? Maybe it would have been a good start for the
cover letter.

> 
> >>>>>> On these platforms, a TEE based uefisecapp client driver is required to:
> >>>>>> 1. Access cached & volatile EFI variables stored in uefisecapp's memory.
> >>>>>> 2. Ensure persistence of non-volatile EFI variables via writes through
> >>>>>> the RPMB service hosted in the QTEE supplicant.
> >>>>>>
> >>>>>> This series introduces such a uefisecapp TEE client driver for the
> >>>>>> aforementioned Qualcomm platforms which installs efi-var operations _if_
> >>>>>> the QCOMTEE driver registers support for an object-IPC based uefisecapp
> >>>>>> service on the TEE bus during its probe. Only new QTEE firmware versions
> >>>>>> available at [2] provide this support.
> >>>>>
> >>>>> What about existing WoA devices?
> >>>>
> >>>> New Windows on Arm devices like Hamoa/Glymur work perfectly fine with existing
> >>>> QSEECOM based uefisecapp. But they will also work with this new QCOMTEE based
> >>>> uefisecapp once they upgrade their firmware.
> >>>
> >>> Do extisting commercial devices suppot it? For example, does Lenovo T14s
> >>> support it? Will it continue to work with this patchset in place?
> >>
> >> Existing devices like the Lenovo T14s do not have mature QCOMTEE/SMCInvoke support
> >> on QTEE side and new QTEE versions for it are not being rolled out. However, this
> >> QCOMTEE based uefisecapp driver and the QSEECOM based uefisecapp driver can co-exist.
> >> It will not cause any breakage of existing working functionality since the QSEECOM
> >> path can probe and continue as usual.
> > 
> > My understanding was that QTEE path completely disables the QSEECOM
> > path, does it not?
> >
> 
> By 'QTEE path', I believe you mean the 'QCOMTEE/SMCInvoke' protocol path.
> 
> No, both SMCInvoke/QCOMTEE and QSEECOM paths can be supported simultaneously within QTEE.
> QTEE does not disable the QSEECOM path when it enables the SMCInvoke/QCOMTEE one.
> 
> You can have both QSEECOM and SMCInvoke clients running together on a Qualcomm platform.
> QTEE doesn't impose any restrictions. The control/data paths within QTEE for these
> two protocols are completely isolated from each other.

Okay, that's nice. Thanks.

> 
> >>
> >> As per your comments on patch 6 of this series, I plan to enable the QCOMTEE based
> >> uefisecapp as default 'm'. That way we don't need to enable one over the other and
> >> will continue supporting all existing functionality while extending it for devices
> >> with UFS/eMMC storage and running upstream Linux.
> >>
> >> Do let me know your opinion on it.
> > 
> > My opinion is very obvious by now. Existing devices should work. _Must_
> > work. They provide the reference interface. Make them work first and
> > work good. Then explain, why the other interface is better (I fail to
> > see it from your cover letter or from any of the commit messages).
> > 
> > When I take a Glumur laptop from the market shelf, will it be QSEECOM or
> > QCOMTEE? If I take the next-generation-after-Glymur, will QTEE interface
> > for uefisecapp be supported there? Will it be used by Windows?
> > 
> > I think the series fails to answer, why do we need another mechanism, if
> > we already have one which has been working for the past N years and
> > which is supposed to work for another M years?
> >
> 
> At this point, we have the following categories of devices:
> 1. Devices with only QSEECOM support, but no support for callbacks/RPMB listener within
> Linux QSEECOM driver.
> Example, MSM8998 and older WoA laptops. These are very old devices (at least more than
> 6-7 years old).
> 
> 2. Devices with both QSEECOM and SMCInvoke/QCOMTEE support.
> Example, SM8650, *Glymur*. These are relatively new devices (2-5 years old).

Where do SC8280XP and Hamoa / Purwa devices fall into? Is it #1 or #2?
What about WoA laptops for the next platform after Glymur?

Also, the standard worry is that even if they implement QCOMTEE path in
addition to QSEECOM it might be less tested. That's why beforehand I
pointed out that it's imporant to use the same path as Windows do.

> 3. Devices with only SMCInvoke/QCOMTEE support.
> Example, RB3Gen2/Kodiak, IQ-9075/LeMans and newer devices which might not have
> QSEECOM support in the future since QTEE team has deprecated QSEECOM.
> 
> This patch series helps devices in category 2 and 3. Without the mechanism introduced
> by this series, we will end up in a situation where EFI variable based use-cases will
> become impossible on at least category 3 of devices. We must conform to the reality
> that QTEE firmware is transitioning to SMCInvoke as the protocol of choice with
> long-term committed support.
> 
> At the same time, I am aligned that we must think of a way to support devices in category 1
> which is what you really care about. The QCOMTEE and QSEECOM drivers can co-exist, and so
> by adding support for both this patch series and callback requests to the QSEECOM driver
> (at a later point of time via a separate series) we will be able to provide EFI variable
> support on all Qualcomm platforms under the sun. This will accomplish our common goal.

Ok. Let me take as an example the set of devices that (some of) my
colleagues and I use on a daily bases for our work: Lenovo X13s
(SC8280XP), Lenovo T14s (Hamoa), Lenovo Yoga Slim7x2 (Glymur). What will
be the effect of the series on those devices? If they switch to QCOMTEE
to provide EFI variables, how well tested is that path?

X13s were produced 3-4 years ago, T14s are even newer.

> I will add this information in the cover letter in a concise manner.
>  
> >>> What about other existing devices? We have WoA devices starting with
> >>> MSM8998. The QSEECOM driver works on them, but, as you mentioned, it
> >>> can't flash updates to the backing storage.
> >>>
> >>
> >> Unfortunately, unless we roll out new QTEE firmware versions for devices like MSM8998
> >> with QCOMTEE/SMCInvoke support + access to the Uefisecapp over SMCInvoke protocol,
> >> they cannot be helped with this series.
> > 
> > So, I'd say, the series is strange. We are proposing something which is
> > not rolled out, which is not supported by the exsiting commercial
> > devices, etc. On the other hand we have future gaps which are known.
> > This doesn't sound correctly.
> >
> 
> We are proposing a mechanism which supports the majority of Qualcomm devices in the market
> launched within the last 5 years and also the upcoming ones. The category of devices which
> are not helped by this series are extremely old (at least 6+ years). Regardless, I am not
> pushing the view that we do not care about those devices, just that the route to helping
> them is different and orthogonal to this series and I am happy to engage on it separately. 

Ok. So, I assume Glymur+1 will also use QCOMTEE on Windows side to
access EFI vars?

> >>>> I need to double-check but this firmware release for Glymur on Qualcomm Linux
> >>>> is probably carrying the support for QCOMTEE based uefisecapp access:
> >>>> https://github.com/qualcomm-linux/meta-qcom/commit/728251fcbe5113980805ea6c571e33235062ee71
> >>>> If not, the next release will definitely have it since I have merged support for
> >>>> this in QTEE and talked to the boot firmware release team about this.
> >>>
> >>> Does it work on the CRD?
> >>>
> >>
> >> Yes it does, I have validated on Glymur CRD by locally switching it from the current QSEECOM
> >> based uefisecapp to this new QCOMTEE based uefisecapp. This is the QTEE release which
> > 
> > Why do we need to switch the app? Why is the old one worth switching?
> >
> 
> You do not need to, Glymur supports both QSEECOM and QCOMTEE/SMCInvoke. I just used Glymur
> as an example to show that both work there and if a user wants he can chose one over the other
> (It really doesn't matter). Glymur sits in the middle of the old and the new, it is a category 2
> device as mentioned above. 
> >> needs to be consumed for it:
> >> https://github.com/qualcomm-linux/meta-qcom/commit/5590c1dc631827624c110df282965b85ef2a2e60 
> >>
> >>>>
> >>>> The next planned firmware upgrade for Hamoa will also provide this support for
> >>>> Qualcomm Linux. And similarly, for all other targets being supported upstream.
> >>>
> >>> So, we are forcing users to upgrade to the new firmware? That doesn't
> >>> sound nice.
> >>>
> >>
> >> We have an open ecosystem for all devices supported by the Qualcomm Linux distribution,
> >> users can easily consume new releases (and new QTEE versions) to access new features.
> >> Until now, developers/users of RB3Gen2 or IQ-9075 could not access EFI variables to
> > 
> > What stopped us from delivering the TZ apps compatible with the existing
> > interface?
> >
> 
> QSEECOM support is deprecated on IQ-9075 and broken on RB3Gen2.

That's not really an answer to 'what stopped us from delivering a
working solution' question. I think it boils down to the 'why was
QSEECOM' deprecated question.

> 
> >> develop use-cases such as secure-boot key revocation, but by taking this patch series
> >> as part of a subsequent Qualcomm Linux release, they will be able to.
> >>
> >>>>>> Thus, QCOMTEE now maintains a static list of always-available object-IPC
> >>>>>> based secure services exposed by QTEE. These services are implemented either
> >>>>>> within the QTEE kernel or within a pre-loaded Trusted Application (TA)
> >>>>>> usually loaded by the bootloader. The uefisecapp TA is an example of a
> >>>>>> preloaded TA loaded by UEFI. A static list is required since QTEE does not
> >>>>>> yet expose any way to dynamically query and enumerate the services exposed by
> >>>>>> it.
> >>>>>
> >>>>> Can it be fixed instead of having static lists? In the end, we can't
> >>>>> guarantee that users update the firmware.
> >>>>>
> >>>>
> >>>> Unfortunately, no existing QTEE release out there currently has this support.
> >>>> But support for this is currently being added by QTEE team last I checked with them.
> >>>> Once it is available, and a new QTEE firmware release is out there, we will add
> >>>> support for dynamically querying QTEE services in the QCOMTEE driver. 
> >>>
> >>> It seems you are still rolling out QTEE-based support. In such a case,
> >>> please go back and implement dynamic detection of QTEE services.
> >>> Otherwise it would be a nightmare.
> >>>
> >>
> >> We are working on it, but until then there is no overhead involved in maintaining
> >> this static list of services because we don't have to extend/modify this list when
> >> adding support for a new Qualcomm platform upstream. If a particular service from
> >> the list is not implemented/accessible from QTEE we log the event and silently avoid
> >> probing the TEE driver for the service. We also don't add platform specific services
> >> here. So the list doesn't need to be extended on a per-platform basis.
> >>
> >> So unlike the QSEECOM driver, we don't have to keep maintaining this list forever
> >> for all new platforms.
> > 
> > I don't see a difference. You are saying that the list implementation is
> > good, it silintly skips the unavailable services, etc., and then you say
> > that you don't have to keep maintaining the list.
> >
> 
> We only have to add services to this list when a client driver appears for it. For
> example, this TPM series by Kuldeep:
> https://lore.kernel.org/all/20260831-tpm_qcom_driver-v1-1-6f16fa6924fa@oss.qualcomm.com/
> 
> We don't need to maintain this list on a per-platform basis unlike QSEECOM:
> https://elixir.bootlin.com/linux/v7.2-rc7/source/drivers/firmware/qcom/qcom_scm.c#L2289
> 
> Support will arrive for dynamic detection, I have commitment from QTEE team for somewhere
> around end of the year. :)

Ok, thanks for the explanation. For the reference, if listener interface
was implemented, we could have dropped the QSEECOM list too, only
keeping the broken entries there.

> >>>>>> To facilitate object-IPC interactions from the kernel-space, this
> >>>>>> series also introduces a tee_client_object_invoke_func() to allow
> >>>>>> invocation of TEE objects similar to the existing tee_client_invoke_func()
> >>>>>> API exported by the TEE subsystem which allows invocation of TEE functions.
> >>>>>> Some suporting changes are also introduced to track and handle operations
> >>>>>> for TEE contexts opened from the kernel-space in the back-end QCOM-TEE
> >>>>>> driver.
> >>>>>>
> >>>>>> Finally and as previously mentioned, access to the object-IPC based uefisecapp
> >>>>>> service is restricted on older QTEE firmware versions. A new QTEE firmware
> >>>>>> release must be picked up from QArtifactory [2] for all upstream supported
> >>>>>> Qualcomm SoCs to enable access to uefisecapp service via the TEE client
> >>>>>> driver.
> >>>>>
> >>>>> What about fused devices?
> >>>>
> >>>> The procedure for updating the firmware on fused devices is slightly different.
> >>>> The firmware images need to be signed by the OEM using the security profile
> >>>> of the chipset before flashing/upgrading them. Security profiles are now public:
> >>>> https://github.com/qualcomm/security-profiles
> >>>
> >>> Will OEMs release new firmware images? What about the devices which are
> >>> already out of the support phase? This whole story rotates about the 'we
> >>> are releasing new firmware with new features' paradigm. However there
> >>> are existing devices in the field, which typically can't be upgraded,
> >>> From your cover letter it seems they can't support UEFI variables
> >>> properly. However they do so in Windows.
> >>>
> >>
> >> Yes Dmitry, this series is effectively forward looking. QSEECOM protocol/driver
> >> support is essentially deprecated on QTEE side, no new features added to QTEE support
> >> it, and it also doesn't work on many devices like the RB3Gen2.
> > 
> > To look forward, we need to have a good firm stand on the ground. We
> > have a half-baked implementation, based on reverse engineering. No RPMB
> > support, etc.
> >
> 
> Agreed. I am happy to engage on a separate series for adding callback support to QSEECOM
> driver along with RPMB listener within the kernel.

Nice, let's continue in this direction while this series lands (we have
started the discussion internally some time ago, but I didn't have time
to finish the listener study).

>  
> >> For existing devices, if they boot with upstream Linux and have RPMB located on
> >> UFS/eMMC this patch series cannot help them. But the focus of this series is not on the
> >> past, it is on currently supported and future hardware. Every new Qualcomm platform
> >> whose support is being up-streamed or is planned to be up-streamed will have access to
> >> EFI variables via this series.
> >>
> >> If someone wants to add support for older Qualcomm devices to access EFI variables
> >> via QSEECOM that patch series will not conflict with this one. Like I said, both
> >> QSEECOM and QCOMTEE based drivers can co-exist.
> > 
> > What will happen if I build both and boot the kernel on the existing
> > devices?
> >
> 
> QSEECOM and its client driver probe first and establishes the path to uefisecapp for
> providing EFI variables service. QCOMTEE and its client silently fail probe.

I hope you mean here that UEFI variables client fails to probe.

-- 
With best wishes
Dmitry
