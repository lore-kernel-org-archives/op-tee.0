Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4D7CA5FE2
	for <op-tee@archiver.kernel.org>; Mon,  5 Oct 2026 06:57:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A40DB45458
	for <op-tee@archiver.kernel.org>; Mon,  5 Oct 2026 06:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791183476;
	bh=qbIdZAKoZiKIXm+V7iO8Tpd5L7KU17AoLK6Q9ugcdhU=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=rBnVXY2vwoG48qoQlU5qlHg2H0vHMymRKgSpe10z+bWo1i27tVlyP0QxVmGGpKt8N
	 zSBSdNH+IW52FjNKOjWdDWVF7TDCb4V2myalX3CEB9qbp9GQxTRUsMbZ6fh5wIbsOh
	 T7xpXDqvj9kuXseQK9oGKJUI89ebRa2ycyr/R6cF5/ecUQaMTGNs6nlmjtr8z3chWw
	 OUFyZKvzcltyLlSQttJM80jJWn076GuMPmAnQzJlIMoip1yWFZSsIABc5SEnVdEurg
	 ORg0m5/jVClolEhW/7sKD20WHYPSfNZC5ukiEkOe+PW6lX/g1YcjS3DRsU81GDfKry
	 /fiJKWb833g1w==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A4BFF44358
	for <op-tee@lists.trustedfirmware.org>; Mon,  5 Oct 2026 06:57:48 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xptj5nE1;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SF9/4moT;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695105PY470884
	for <op-tee@lists.trustedfirmware.org>; Mon, 5 Oct 2026 06:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+QESzrKoeisIYlJc8o6G7lAXpcW3BZJjUzWVIuPcsLo=; b=Xptj5nE19lKE7Uao
	lpJEc7rsV6Jk09upWLVCUdx0yv8u4fiGfUlNc1RBT/kux9OLGyOGUgZHbjM6uyPx
	4aOh/z6KTSvtSgAT0i8eIX26vHmz5/LsEtmdBiiW5I66cA6yJ6nFqQzNOxqCSFZT
	u0v8c0kQhaf0dVyPBDbptu9f9yuB/oF+gyx7PZkz0jRUpbh2d6Bj/cO4p0dvC9+P
	62xOIag0K1WKnwvWuZaI4tv3+7Ehj6YijOdFOlwmOokgxXvxwczHEhHv8YFq/p8q
	XYM0UbSfdV03qYyoo/SEPAF/etehdX9z7dUBAi8qpNmfG3QmqSofRsHg2j+p+bpt
	UuQ3VA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ssuctem-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 05 Oct 2026 06:57:47 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso1512539a91.2
        for <op-tee@lists.trustedfirmware.org>; Sun, 04 Oct 2026 23:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791183467; x=1791788267; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+QESzrKoeisIYlJc8o6G7lAXpcW3BZJjUzWVIuPcsLo=;
        b=SF9/4moTX16/pDEp10w4CoFSA/jrEEGcgCTcfyipcT/b907pdt6ZYwazLtKLXyqsmw
         OTLsmRo/qsuaCxRNsgpAJOY0Gia3qd7gREZJ/4fmVm4xKsSFGJTh+QfW1ocOjHHhtpdN
         qPcTQr+9y4wbHOUJ/tDFHzRlM97/wliRdUFi1FPqkZS0fG5wJ1j4MaxCupctg9lVXo3P
         celdtlqVO7/u9YLpDP9Wz+XXPeU2DKnpCkhXli0PIckgoHjCCCkskdjqFSxAeO1qgx6A
         uXbZ6EyIAt/RPEjWEHMzm+H0fwSDSW4YUWVIjYtrebPC1f7TJQCOgELuPnM5qxaiIIJs
         xfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791183467; x=1791788267;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+QESzrKoeisIYlJc8o6G7lAXpcW3BZJjUzWVIuPcsLo=;
        b=W8Uxe8UPb8zlKgBFHz39kQ54K3CT03pAeKS2kT68w9LfOEU+YiAKbw41J3q97MXldI
         W9W0ubZxhjQNGW7RF9B7ml1T3pQMAtaASYYRymmXI301chxTQGJgnE2WdKhqQLckMQvb
         qM3IutlsfKI5GnLJqTAcykg1nL7jKBOegowt1kE+QkAXniqmSYrKXhDpv2sWFKxd5uOd
         QPZuxwArb3dmWoUH+hFVdBnKMlsNrn1mChD1RvQvN9EBmuYMMhCPbnUsKRVQCs52VoMt
         mSiXfqLNjLfLiGiBA685l6I0dIF5cg0VCJS60p1s1dD9jYkA3Ikr/Zmuu0jS6mjf3LXx
         v5Fg==
X-Forwarded-Encrypted: i=1; AKwUvByRGO45FTFzPO2BwD7n8CGHQLjIHD7S9QgS7y3euN8DwK2q+wAkSjAZEFS4Sv1c+R5dnXgs6xU=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYIO9/fXd9pIVJHf21uF0fJhqwAqohEyUzANXOLH/avSbkrLTP01
	3KMA5dUbo93CFi0EFJdHrCbrVgIAbCargQxnyzpxIg3tSrp74fF6K2xc3RkrKGaR2ZfI6IO0ZI/
	xo4CIDelvWOpXezjAiSYps5STsf40Qn1UYyLYj3MBE2E8RdGNan6hwtTc5iOI9GRuym8OKqrP
X-Gm-Gg: AYBFou0pyfc1a7Ch+boqqyatJa5uz//yXBQYiqDVtnkn0otZRpMz8cWJZaYhjmIsyZ5
	9grBZBCG7/ZQH4ppG4qLAt3lPl1kWiRkQPCMWQjEawFyyTUr0L44PgefbRsLvnNtvILcLWLmAxp
	cL3nIkFcBY4ZVrvJHh2bUiLlUhFj2SqA1M6rbfdOiBP76LtyMFKEGD9uMNMxB5Y57WLpd1X3Yo9
	1W07xWC3bmgUuiNlmqVArKwPpUVrBAUFnHAxGRvguTbLB5A04hh+rGMVM54/Jf7yVtPfgXM8oI8
	0mzvdBL0LQ1ySsNIYRjrlA5fijnQG32UIcCZJWtruQrXiZB8EhiREZ10dPpUd5qQWdJQXf36McB
	6CwifyzFKQYTNlWi74/RLfOMVZyPMSw==
X-Received: by 2002:a17:90b:3b83:b0:39e:6c69:34d5 with SMTP id 98e67ed59e1d1-3a6ce95dedamr8429183a91.57.1791183466737;
        Sun, 04 Oct 2026 23:57:46 -0700 (PDT)
X-Received: by 2002:a17:90b:3b83:b0:39e:6c69:34d5 with SMTP id 98e67ed59e1d1-3a6ce95dedamr8429177a91.57.1791183466189;
        Sun, 04 Oct 2026 23:57:46 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d4a5150sm9834853a91.1.2026.10.04.23.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 23:57:45 -0700 (PDT)
Message-ID: <0c6d29ce-920a-4566-9a4f-a0687b0e5ddc@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 12:27:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add TPM support via Qualcomm TEE TPM TA
To: zeroknots <zeroknots@protonmail.com>
References: <20261001055029.1960743-1-zeroknots@protonmail.com>
Content-Language: en-US
In-Reply-To: <20261001055029.1960743-1-zeroknots@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfXx6DzcxzAb1bd
 IiSAz6A7drFuHgNI0Pf+g20fb+CitTK6xtabY8s3DQGtA7rP8JBEsTEP9d/RKAOjbiJvZCgf8X2
 XbzswN4W6cLvKnxdqVSF+q5n+hj8bsY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX5Rjqajjk72P4
 k858sikXc9Eo2D6+MvUrLa4gdGVuWGudDAT1DaBueVZJODsuS5TIkcORKzNMWXFaynIOEzZQBwU
 ng3GerxVqRGe0JC1B1C08kjhAxwKqVL02pgrQGDnoxTwtTq0sCzEGQldVCD8OVT1oZ64s7NQEs9
 LGcANYYWoI2BsqI1oHtrQGPvtnbhbUr1idUkDzPDtrkf5Pp+v20FvvfPx21vgzwP1M5n+EdjXbD
 USjz+NtzwX9Dd8Q7VVHREfpikiFcqkMvFBlPEm2nkEMHPj6vYTy0srWqP+k3BFliWKHeUgMp35F
 lLtzH9doECjwfOX29q+rXUAeYq/OG5uMcaWdebV+lybKNrYPb+Bf7zkfiwAs+Wt/+io9QqMSB+6
 VOtTs45N7sVu8Mlcx1f2dS22VvHsTUuPpngtQdT/VhO3j3AUMj5ML2es1H+CkEfLEeNg96K2hO6
 2A1FrGY+Nz8k1Sq0kPg==
X-Proofpoint-GUID: q10O8KDUrx_1Fs0Zb-LpY4BlW2eVg_oz
X-Proofpoint-ORIG-GUID: q10O8KDUrx_1Fs0Zb-LpY4BlW2eVg_oz
X-Authority-Analysis: v=2.4 cv=FryQbGrq c=1 sm=1 tr=0 ts=6ac34a6b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=MGVvYQGpb7276ASQA-MA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050027
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.09 / 15.00];
	BAYES_HAM(-2.99)[99.96%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[protonmail.com];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org,gmx.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.216.69:received,202.46.22.19:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A4BFF44358
X-Spamd-Bar: ------
Message-ID-Hash: FJDLOOJAWUYD3THRMMIPAFBDTL4H53IK
X-Message-ID-Hash: FJDLOOJAWUYD3THRMMIPAFBDTL4H53IK
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: amirreza.zarrabi@oss.qualcomm.com, jarkko@kernel.org, jenswi@kernel.org, jgg@ziepe.ca, linux-arm-msm@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, peterhuewe@gmx.de, sumit.garg@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FJDLOOJAWUYD3THRMMIPAFBDTL4H53IK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

On 01-10-2026 11:20, zeroknots wrote:
> Hi Kuldeep,
> 
> A data point from retail hardware, in case it is useful for this
> series: on an ASUS Zenbook A14 UX3407NA (Glymur, X2E-88-100, BIOS
> UX3407NA.315) the TPM TA is not reachable as QTEE service 81, but it
> is present as the QSEECOM application "qcom.tz.tpm".

Thanks for reaching out, Kindly check below.

> With the qcomtee driver on a 7.3-rc3 based kernel, QTEE reports
> version 5.2.0, and service discovery finds neither 81 (TPM) nor 413
> (UEFI secure app). On the same boot, qseecom (version 0x1402000) works
> and backs efivars through "qcom.tz.uefisecapp" (app id 7). An app-id
> lookup for "qcom.tz.tpm" returns app id 1; a made-up name returns
> -ENOENT.
> 
> The Windows driver for this machine agrees: QcTrEE8480.inf configures
> the TPM service with AppName="qcom.tz.tpm", SecureApp=1, LoadApp=0
> (preloaded by firmware). The EFI configuration table carries the
> TPMEventLog and TPMFinalLog entries, so the firmware TPM is active.
> 
> Through that app, using a QSEECOM transport (based on Xilin Wu's
> out-of-tree SC8280XP driver: QUERY_INFO_2 / SEND_COMMAND with a
> CRB-style control area, here at 0x81d10000), /dev/tpm0 works: TPM 2.0,
> manufacturer QCOM, vendor string "xCG fTPM", firmware 0x40000, real
> PCR 0-7 values, GetRandom, ECC and RSA-2048 primaries, sign and
> verify, and a sealed object that persists across reboots.
> 
> So, as far as I can tell, retail Glymur laptops may ship firmware on
> which this driver finds no TPM, while the same TA is available over
> QSEECOM.
> 
> The same applies to the prerequisite series that moves uefisecapp to
> QCOMTEE [1]: on this firmware service 413 is absent and EFI variables
> work only through the QSEECOM uefisecapp. If the QSEECOM path were
> dropped for Glymur, efivars would stop working on this machine, so it
> would be good to keep it as a fallback when the QTEE service is not
> found.
> 
> Two questions:
> 
>  - Is service 81 expected to appear on retail firmware through an
>    update, or is it specific to the CRD firmware?

Yes, there's spinor update(bootfw2.mbn) needed which is in progress to
publish as QTEE side changes were already merged long back.
Roughly it takes ~1month(ideal scenario) to get firmware changes
available but somehow it's taking more this time.

I think i should have captured this dependency info in my series cover
letter to avoid any confusion.

With the changes, service uid 81 will be available and won't see qcomtee
driver issue log there.

>  - Would you consider a QSEECOM-based path for such firmware? I am
>    happy to test this series, or any other service UID you would like
>    checked, on this machine, and to share the transport code.
> 

Qseecom-based firmware path is not recommend approach as it's not
generic and less scalable leaving less room for expanding featuresets.
qcomtee uses mink-ipc based model which does all interaction with TA
with just 2 scm calls and is very much scalable compared to qseecom.

So, we are planning to use mink-ipc based qcomtee path only and I'll
drop an update once QTEE firmware changes are available in meta builds.
I'd be happy you to try it out and give any suggestions!

-- 
Regards
Kuldeep

