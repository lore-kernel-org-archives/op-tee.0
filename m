Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0AAC43458
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:35:14 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B480944FA0
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782822913;
	bh=9TD884/1eNmXF43nG6KMGGmoxZbFnZmA8KC/ejMW04w=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Woc7dgr0RgY0iv4dQrMCMfic3z0wNZT+ZaVY0W9kvC0PE/mfAC93eH18L+7GUjNOI
	 3YSnb3Wf5H5JHDSgLMWEB244AkYnP9a9fQEK25a1Us1QuUp/T/qco8RMw8HJKqITQK
	 TMe3siB+xh4J0RFXPJsZACp09XJcyk6mf9s4MtG4itKxWLHuklsXdS90Mr6tIAcRj/
	 k/5EeQCsq58WjgHQIVGCeincEpO2anM2M6thlv9lMHl/OeHfVlpqE3lXmsetZ3xomU
	 ssIr6SFthBobq5VGw2CX2ii9+ImShjKqg+T0xqoEcnyqNMYleOsTlWBBms3Co5lzZK
	 cCRj8KW3UGxoQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4E86F44E68
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:35:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KKnkbgGq;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KKksQJDN;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9muNp1522306
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XbxXKmb6m1o+wu+br6lLzlt+6G9oYy2IEucIolB22Mg=; b=KKnkbgGqOr6Axbi5
	m8AFO+/Jphf+KutD3yzjJBOBGMRnZBe0xFfEDCpHsmiMPqrNjMgEqDLg5As+APA1
	d8qxQEA9OWFnuHHrcNzvJN31S1kOhgBbhvh5O/v/NANPH686ogZ+A6f0Jg11XSCu
	L6oDMxUpi66Stm8pQ73m5lflpH04VKTeKA0zFa1EGW2Iuhg6ljJv0qoye7xW45Dd
	HGtzYmxnVhiXD4HqcQrgDjuP53UqQiUinbMagr+sEQrcnIqU0lXA3SKbPhm8FgXS
	fJ6ZJJDxasvRRXyPxZS1CTAR6hpiohrzlxjtTBOBierePcL5Z5NKnDlfpBqAH/vm
	wze8qg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3yw93c4m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:35:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51bfe75b7dbso2952031cf.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 05:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782822905; x=1783427705; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XbxXKmb6m1o+wu+br6lLzlt+6G9oYy2IEucIolB22Mg=;
        b=KKksQJDNfqFUVvRJjEaFK5CnyOzERx+9YRzO8YaaR7R6r5aK677FY5cc4som5Kfqzu
         tKmcGyj7zRRTvrS1CRQM60+Bx1xVhAyE1fLA6bsqB7g11+lWOrPpwPp51CGWPbYkDj8o
         j0gG+UdpDsvTv2P+K1MsuvsEXAPibvwWAQVeaj98ONIdPoD+tM7LNkwHcWUMkhZ9VCVb
         51d5gAaMcQiKG/UJHyXKJoZqJi3zOB4+43K9i+NX43w2u0v41TGbrwcUy+yntiS9uR6Y
         JEknhRx6GYvy4MjHwDI826EOGPMVE7iZfTBDOt3JOLruxEfCYHCIGpCQSHofdkslGm1M
         uw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782822905; x=1783427705;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XbxXKmb6m1o+wu+br6lLzlt+6G9oYy2IEucIolB22Mg=;
        b=nOQD5vVuhl76/8s1QkSN1zAaT6y2ZXoleceydiC+FygDaaii+BxOCaxo7bqoVXd4AZ
         78jOHk3DVrA87VDJhQ/z84f3Zsl0tY0JXAwIBZT73Kkh3QtdsuD7UDqV1cCW9MjhYca9
         iEbUTOAbr1QzNlb5T1Rk8/o1ipmX1okiDTlNvNiR9IN5Ui0FR8F2aom764HmuHoGrmRw
         6y66YUXVghhG4jotFODYwY+JrL6dl1Bo+WdhLbjkJ2OwoR0s4i3B20ISCGthl+IXb1vN
         +1R7o3T11uRa+wJ/c9Hvw3B9iStVGbyU+hNB1F6X3GcqJ06GiXOMRkrW7Xmp5096u3i4
         qiuw==
X-Forwarded-Encrypted: i=1; AFNElJ+LM3YeLWvqckTlKYNPUU56G5ScJAQzBKRgqPX+w4q31dy21NmUoySnxCS5eNRDQ58umi8Vl5Y=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwHZ69C3SM+I4/1gZAOqrz2+iCxTg5qzg/gxuHjI54w1/pJCbEj
	vsnPOQdekmVLxUILdVaNWEqAIB3LqnNi342cY/aJy0a1/LpsC3bpsdiAQybRSj/aSlqmzoIvD3y
	EEO+6m+R13PCRp9JvJppji+TiCvwIrEF7NSjJdFFzgUie7Q6y8UWCkAB+T0myLDaAQZ5xaqIb
X-Gm-Gg: AfdE7cmsO4p8X7aIhl2LFyRDdxEEOiZKRsmw9XLsuCGLGOP+83v5cL/ms2qeQhfcynR
	i2UyoLOC810IpeTXCH4I0jFxZIk1Vs/Q2sipisFH+bNTQLBCqU85YN4Z/51HpCy/4fV/qpDalYb
	fn5G1QGKdMaU+i/HVdUuLtGMu/AvxW2LPzhZCzoUM/EZ9+knQAG+2SlytEpdxsmeGGGgfuDwXuC
	sPsd0Mp9ohG3F8DFGmQF30HHl2sQANNFcdP8G/PvX18q0bpRsH6F5ClvsFPCYQmVmWt87ql0zj1
	UkS86bO+xPs3BMRdtSCxX6m4zSNp327yPePhqPWlp0vdYLyMHERu+F/UzRN22yPyybVcv1Om5rK
	q0v5L2yGNzIDQblBn8hEmnu8uP+WQqZmXq4s=
X-Received: by 2002:a05:622a:a1a:b0:51c:1744:edf0 with SMTP id d75a77b69052e-51c1744f08cmr12928961cf.9.1782822904805;
        Tue, 30 Jun 2026 05:35:04 -0700 (PDT)
X-Received: by 2002:a05:622a:a1a:b0:51c:1744:edf0 with SMTP id d75a77b69052e-51c1744f08cmr12928611cf.9.1782822904391;
        Tue, 30 Jun 2026 05:35:04 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f4c19esm117506266b.51.2026.06.30.05.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:35:03 -0700 (PDT)
Message-ID: <594cf827-819e-4262-9dff-a35c7f69f86b@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:34:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/14] remoteproc: qcom_q6v5_pas: Switch over to
 generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-5-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260626133440.692849-5-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfXzRGRgLY31IpV
 p2df5Oiq/ihAQ24czH2PKA5EG2EH9SfwWPEwEA8tm9K7hpZ8WTfVmrGiJif8SLAHfQrKgm2/0+m
 oWL1J30STDfnvOpCCeO06J8kJ2yRgII=
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a43b7f9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=JRhjOG_OB-XQkuSI_8oA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: uqvtzFsC0tk9MHnfpAP0QCt6Q5V0tLTa
X-Proofpoint-ORIG-GUID: uqvtzFsC0tk9MHnfpAP0QCt6Q5V0tLTa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX+8uTO2bqo1j8
 GfvZ6WpNisGWp0qSGWBsF+4R1zq/JFQgAggwmQgrcpEkRg/Bbj80eN1QLN7r4YOmz7NZ7ATbS1f
 9i5JtdpiBltGq6pPRTWJQuGyunEUlQodX1FFLjG0PH+AK36zKp5kjiQ82R7nOWLgZ+UVqmuQTxc
 d9agcnXdV4lw5CEIFZ9BkkfIb/TvS7z0aTFCnLuADiiwvYTrQ95RXSiBwuXkZiY4bwCOkWstOe3
 I7udQQhAN7+GTxgcdMdZqJtknyXgbqTugT2UWVPXeEK0CE/LJBaQQtKCGEj37E+F9ASGiZVOR6n
 fF/ruYfV2QO2iqUE84lIBCao2WDSJBaW4UFpDdRCOA/f7rle/rf4wCQg8OrZaKaFhywEYWjIH1+
 tlmPE6hUvN/3NfGILHYE0H9G1Rpyl/B1fPoTD8r5Crelh2Mx60R0NoUyb3OejfYP9AQGdH3TWSX
 gtt2CaOUQ4xdh/U8mNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[48];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DNSWL_BLOCKED(0.00)[178.235.128.140:received,205.220.180.131:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.197:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4E86F44E68
X-Spamd-Bar: ---
Message-ID-Hash: 62UWWKQNSOP3W7LTR7F3UK73IHDGMTGT
X-Message-ID-Hash: 62UWWKQNSOP3W7LTR7F3UK73IHDGMTGT
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.
 com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/62UWWKQNSOP3W7LTR7F3UK73IHDGMTGT/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Konrad Dybcio via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom_q6v5_pas client driver over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Since qcom_q6v5_pas depends on MDT loader for PAS firmware loading, it
> has to be switched over to generic PAS APIs in this commit to avoid any
> build issues.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

I assume that the leftover qcom_scm_assign_mem() will be handled
in a separate effort, presumably through something like FF-A lend
on the backend

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
