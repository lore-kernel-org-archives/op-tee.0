Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDD7CA5FCE
	for <op-tee@archiver.kernel.org>; Mon,  5 Oct 2026 07:24:59 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6ECBF4549F
	for <op-tee@archiver.kernel.org>; Mon,  5 Oct 2026 07:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791185098;
	bh=UYV+WsT7nWDf65SrpcjzcLryEAw+eQ2MfWVRTolVw4o=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=NvkmzkLXRa1rh1M9tu8dWqFc6AVqLhG/cznMAGfDyBY2CJRTrPODQniayyFaBUI2S
	 V3TJGrS+cnECc0tw52Uh1Pfms5O/rdYy/dVBd8CSP//I5stMKTBJjOhI1ei3tZJn7C
	 8hASLWA5FrbZZy874yddzq7y2gUrMgyuzUfsn6sAfM+GRgYhK9Lpvt7AMCD6FEWp1/
	 xZfoEldsoA2d/VAnG0a/bB6VOQQttXo5d9XpNj12gVaf5o4v2eKYce6ymCV5pvXEty
	 kJnvyHz2R9WFvwJ9te7RwHNQYMZgLH8VekzIEyB29ZZ0ITR/oCsmw/bq+4b9t/Rpue
	 3fqraVsQrSgdQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1A01F44358
	for <op-tee@lists.trustedfirmware.org>; Mon,  5 Oct 2026 07:24:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GVeAhzN7;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Goy4ucU9;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69510JsE931004
	for <op-tee@lists.trustedfirmware.org>; Mon, 5 Oct 2026 07:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pLJxv3YiFVgclmQBFAlLDhb4
	f78BVLt3FB8EajMmMNM=; b=GVeAhzN7wgouEuNYU6KsJZUb+Tqwxuew5juR5Ycx
	84LTz87YiYuaBBa7ft9B7BAtA8cp9rYwecIT7THwsI8CtkZ6ay/HJyAsMVv2Smev
	9hYeXqeOqY+FgEJBHJXVlez6jE/XABaiaxfSEnZubs17w/FJcN0IE/UoT3gHd3hX
	+Mu84FHjvEcSYasYfMhBvqAYlANMeUxjFjd4ZwH7TtMX5R9gn9pwEtPv+HcQ/gkE
	1kmr+Vd2qzwSr/fZFMxm2+7Rbi/wL2LQJjgZfs7uqO9uP9G6ga/ybmtI37ZrkocK
	hRB/6NU9mAZI+OLOwmGSUiI8dA1k0/R0+yaUDaZLooNy6Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sq8vvnk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 05 Oct 2026 07:24:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cc5f70c8dso144050885a.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 05 Oct 2026 00:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791185089; x=1791789889; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pLJxv3YiFVgclmQBFAlLDhb4f78BVLt3FB8EajMmMNM=;
        b=Goy4ucU9T/7ueHKPinWWf0ggNfe9ukpuL3f+hh3wjsyQ02uVMI60b9cT8Gu6qfKspL
         lp57M+CXqYlSo5q4sfjKl36aRLO/NWC7oCRjnosj3LP99WNhpF4uVgXtWxtGhtFbYne3
         cGmyWM82DV5vKxzjL/L04i4Z3kiFhW2lEwKrt4AvdPCbioLYKCvMXlbYGJnpi+dJr3Qk
         +yoeq7EX9v2Rh0yVwuzdsRVWVc/H4o+YQzH6a2R6+rTx9MhUn9GK1GNwwD4gemnXDhrm
         +nbvmw9YQirU/2ZLqcqXQL/BU2bHEuVJ0F0HIFHWE4uxXFMQrp8eeEpvYMZsAmS4mxmP
         uUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791185089; x=1791789889;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pLJxv3YiFVgclmQBFAlLDhb4f78BVLt3FB8EajMmMNM=;
        b=xGoIZU/98yZyk3wmEf9yeSYqZMJQAdOnC/P1vQ3mAM+W0v3ZMAGjpC58n8hi+CTQOH
         t2I7JI93C5b2cND5s73I6aOrGTvgef7WpIPI9t2HfSSlr3kRNBQMjHFwLpQFwy1YvEPw
         BcMMdSuKxuXx9e8Gqx7hjW8kFd190Sg+cWIkqJ10rzMBAmJhq9Cesy6KcXZz3UYY3Ocj
         esf95RhXLrKXldl0p7yEm1TCFGsSi1+CqNQOVNVZL2nkIPRznRmO9INn25gehoG9Vcpa
         jTbM366e6Tfha98bIzzdzp8BGfKYxU1ssmyNsNxj++tiaQfCla49SofIaMRRu2enoopP
         TM6Q==
X-Forwarded-Encrypted: i=1; AKwUvBzaNFUGAlCDLU1Ans4ds++IZOct1utvBGlp+RmskC9ekpO47YkZ8xbJnwFc1a9LL4EC1EU0Rz0=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++m9qymBCAqOZ0neENmU9P7Z/1FndFkTzxt7kA9QJZ2DWj9U2CVo
	jSVKpzniSLfzq60nqe+4Klt8lnVRtnT+ZVc86etyMi6T9zwKXS9spJpxrpHEcoJW41fA+GflnrN
	pmbw0lMA7mE+GaA6j2cWlQOITeKx/KtHmAbB4zebrYaqunD/2pVwMa2+/IcirpWvD+0Zodh7f
X-Gm-Gg: AYBFou3ugAbpntS7LrGZTR4olXCWRIkYps0y9SnDUThhX+/EzeGwsnqMaFQBqBqygnQ
	JQkFtuNC7EJCe9meJJ6+xr9dCzxlRFUJrohtbf7/jNxTupcueseK7CnlIfUwaB1+nIExegQJayc
	m3iz7EqpmYnGlHSSIoygTvresqFE8+CEk3t9q8IewurkUYAhO9e3S8rsbVHpd9GOzu6ptLZHWV9
	5cOItJ7XMIRNc3G4br2pJtwaxF7Tj9dNrH5otmajNA2b58XwUfL9ad6KIpuypVZOZO+GuqZurI/
	c1NEQRIXl9QbL3aqNofSZezpasKO6NQVWFgj+8rV3nPRpSBQltQBHH/BPV0D0A/SVxnVMM9h1xr
	kHfyOaV0PTG72kovyLQ6aRGhG4OUgX7IYUvF5TP5+EUePekqJ5eHiupg+KXpW58wwvvmhmODaht
	0T/SiIyk4rAmNy
X-Received: by 2002:a05:620a:198d:b0:93e:50ac:b12b with SMTP id af79cd13be357-93e510f4604mr1169679985a.57.1791185089383;
        Mon, 05 Oct 2026 00:24:49 -0700 (PDT)
X-Received: by 2002:a05:620a:198d:b0:93e:50ac:b12b with SMTP id af79cd13be357-93e510f4604mr1169678185a.57.1791185088764;
        Mon, 05 Oct 2026 00:24:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c795bd0sm2961828e87.38.2026.10.05.00.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 00:24:47 -0700 (PDT)
Date: Mon, 5 Oct 2026 10:24:45 +0300
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Xilin Wu <sophon@radxa.com>
Subject: Re: [PATCH v2 0/3] Add TPM support via Qualcomm TEE TPM TA
Message-ID: <b2xdth3hkuypnvxlrgssnj4toffbceohhnh7w2ju46fzinflfd@qaq6ai5plolq>
References: <20261001055029.1960743-1-zeroknots@protonmail.com>
 <0c6d29ce-920a-4566-9a4f-a0687b0e5ddc@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c6d29ce-920a-4566-9a4f-a0687b0e5ddc@oss.qualcomm.com>
X-Proofpoint-GUID: 5LJE0lhGOpxwVk_K7HA0PrQm5b-qiZZ0
X-Proofpoint-ORIG-GUID: 5LJE0lhGOpxwVk_K7HA0PrQm5b-qiZZ0
X-Authority-Analysis: v=2.4 cv=TKzQ2Fla c=1 sm=1 tr=0 ts=6ac350c2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=JPaWTS-FHKQWmHC25SUA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyOCBTYWx0ZWRfX/Rb6oRc+jikx
 VzHmaY0doCKGL/qEyiZAHe4zXFa6qcHIrjwrUlFoWx2h9F/Pac+8diFJlW2n2PUKRQiFMYqEojF
 +dQB/tsbyGz3JBzb8MkzUrKwxK0FOVU2YON6+ZftcayxziiJGDTQ0vhKu6x2CZ0sTTtC/nuQPCP
 q7gPZWNkAb1SI4DbWtKyW4/HByIlAUwH+sZKovZvnkac6zXt5cECbNp0efbd365Drc5jolsbGz4
 5ui6grfEzRW363khGWXZup+sHep1wI7WEIeWw0wZVh7NV7wZgCya1llB5aHGJz9o7rqXrYJ/X/D
 iVz522rH06XFlCxArPy2DdxqR85OsTJSpRwnbaq8ywbhhtNxaB9lJb6whnvqOI9Cn5LXvR6dWKA
 eSwlMW0ok4E4X5nBTZYtk1I47xix7tcm//WIhJ1IxzSf9d3n/r1xzVYx8zliuCaLPbgjsYcWCdK
 j5/NJ/E1UoiDffmyLGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyOCBTYWx0ZWRfXz5w+qXhSdQSm
 xM/OBjScbdwaA2+9MazOHUPcn6RO4X1xHA13ZDeQBVtuvAuyiJ03/Chfyr1E7cRbCYWGj3TnAHc
 9Y6IqqwKtm4p6yLgUnyH0q1RjMH48Ec=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050028
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[protonmail.com,oss.qualcomm.com,kernel.org,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org,gmx.de];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[2001:14ba:a073:af00:264b:feff:fe8b:be8a:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1A01F44358
X-Spamd-Bar: -----
Message-ID-Hash: F37URY6P66W5SRHP5GJVWYHI2HBC4WGH
X-Message-ID-Hash: F37URY6P66W5SRHP5GJVWYHI2HBC4WGH
X-MailFrom: dmitry.baryshkov@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: zeroknots <zeroknots@protonmail.com>, amirreza.zarrabi@oss.qualcomm.com, jarkko@kernel.org, jenswi@kernel.org, jgg@ziepe.ca, linux-arm-msm@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, peterhuewe@gmx.de, sumit.garg@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/F37URY6P66W5SRHP5GJVWYHI2HBC4WGH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Dmitry Baryshkov via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

On Mon, Oct 05, 2026 at 12:27:40PM +0530, Kuldeep Singh wrote:
> On 01-10-2026 11:20, zeroknots wrote:
> > Hi Kuldeep,
> > 
> > A data point from retail hardware, in case it is useful for this
> > series: on an ASUS Zenbook A14 UX3407NA (Glymur, X2E-88-100, BIOS
> > UX3407NA.315) the TPM TA is not reachable as QTEE service 81, but it
> > is present as the QSEECOM application "qcom.tz.tpm".
> 
> Thanks for reaching out, Kindly check below.
> 
> > With the qcomtee driver on a 7.3-rc3 based kernel, QTEE reports
> > version 5.2.0, and service discovery finds neither 81 (TPM) nor 413
> > (UEFI secure app). On the same boot, qseecom (version 0x1402000) works
> > and backs efivars through "qcom.tz.uefisecapp" (app id 7). An app-id
> > lookup for "qcom.tz.tpm" returns app id 1; a made-up name returns
> > -ENOENT.
> > 
> > The Windows driver for this machine agrees: QcTrEE8480.inf configures
> > the TPM service with AppName="qcom.tz.tpm", SecureApp=1, LoadApp=0
> > (preloaded by firmware). The EFI configuration table carries the
> > TPMEventLog and TPMFinalLog entries, so the firmware TPM is active.
> > 
> > Through that app, using a QSEECOM transport (based on Xilin Wu's
> > out-of-tree SC8280XP driver: QUERY_INFO_2 / SEND_COMMAND with a
> > CRB-style control area, here at 0x81d10000), /dev/tpm0 works: TPM 2.0,
> > manufacturer QCOM, vendor string "xCG fTPM", firmware 0x40000, real
> > PCR 0-7 values, GetRandom, ECC and RSA-2048 primaries, sign and
> > verify, and a sealed object that persists across reboots.
> > 
> > So, as far as I can tell, retail Glymur laptops may ship firmware on
> > which this driver finds no TPM, while the same TA is available over
> > QSEECOM.
> > 
> > The same applies to the prerequisite series that moves uefisecapp to
> > QCOMTEE [1]: on this firmware service 413 is absent and EFI variables
> > work only through the QSEECOM uefisecapp. If the QSEECOM path were
> > dropped for Glymur, efivars would stop working on this machine, so it
> > would be good to keep it as a fallback when the QTEE service is not
> > found.

No, the existing paths are not going to be stripped.

> > 
> > Two questions:
> > 
> >  - Is service 81 expected to appear on retail firmware through an
> >    update, or is it specific to the CRD firmware?
> 
> Yes, there's spinor update(bootfw2.mbn) needed which is in progress to
> publish as QTEE side changes were already merged long back.
> Roughly it takes ~1month(ideal scenario) to get firmware changes
> available but somehow it's taking more this time.
> 
> I think i should have captured this dependency info in my series cover
> letter to avoid any confusion.
> 
> With the changes, service uid 81 will be available and won't see qcomtee
> driver issue log there.

You are responding to the user who uses a COTS commercial device. Are
you suggesting that the user can somehow update the firmware on that
device?

> 
> >  - Would you consider a QSEECOM-based path for such firmware? I am
> >    happy to test this series, or any other service UID you would like
> >    checked, on this machine, and to share the transport code.
> > 
> 
> Qseecom-based firmware path is not recommend approach as it's not
> generic and less scalable leaving less room for expanding featuresets.
> qcomtee uses mink-ipc based model which does all interaction with TA
> with just 2 scm calls and is very much scalable compared to qseecom.
> 
> So, we are planning to use mink-ipc based qcomtee path only and I'll
> drop an update once QTEE firmware changes are available in meta builds.
> I'd be happy you to try it out and give any suggestions!

I feel it really sad that the team (again) ignores existing available
devices. Yes, QSEECOM is legacy, etc., etc. However we must make sure
that devices are being sold can be used.

I guess, at this point, the best course of action would be for Xilin Wu
to submit the QSEECOM driver upstream. Xiling, could you please do it?

-- 
With best wishes
Dmitry
