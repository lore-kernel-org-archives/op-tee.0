Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C876C43458
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:41:36 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id ABCE044F03
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782823295;
	bh=jQD23j2vf2XXCyCGAPYr1v149ZU5HdPGAyLFjjrpeEU=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=E5Qv+WQ8aAtsSn6bt2SDtA9/hhHw52choRVNLves6VBpxW6noN/hYivO24v0HAHkA
	 JB7ZUoV9hc6XySBsJzSjxx2OYrJiUq2b3TrnlBzQ9mdE5qJigy288aGqtP/jfX8Wua
	 IcQC/zOwEb6NyuJauVE1Sl3GCZgwwWtIUxqdV/7CgHv8fIbkRJ/TbesidVNTu8CPPh
	 t4z4cypGR+Aoqz+pOOViyHN7CpiSbXz/bPg6wlnMWWYs2Pd9N/YmpDxxHiF+vnWZ+2
	 t/0faUWQL6sOBu8y1Sa8jPSM79ghgHUXuD3lpQAXPsfsS9oouGclzQdUoSsqSXOAYz
	 aXJnzoudOTP9g==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D769944AFF
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:41:29 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PZsvIHOw;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ReoLZQLB;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mumD1604818
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	81yQnZbApfVfIiH8t8XJoiy0NXKJCRUaF/krfaGmans=; b=PZsvIHOwGcpw1Si8
	mjM5tSeCEW73QMW3pin7A9aNwjptzuikOdaZziRc9EWb+Lwj8nI/lcJb7cE6za6h
	cLx9tEcWyKYljPLsaJkqt1rhRwJpacz3La/f77wc05T8v2A9GTcBWr9dJtX341vN
	bUqEp5fLEOESTWBWc8CY8zeqUKgJqBiaG9dsmhBfd0CJHqYaEq/2IrW/rwR53imk
	STlC6MpL8J2CK4lIgUtWLqlG8+r4dS8XU1CHJMlU1ZY7OU5Cvf5uHI9dn6uDylJI
	C/7DwbOC/0Viob79NGAGUiYF4EqwK0c1g1SpktXNREopXQ82rQFYORYlJIwhpBe2
	jS7SEA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f43vfjpdc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:41:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e69a569ffso2749185a.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 05:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782823287; x=1783428087; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=81yQnZbApfVfIiH8t8XJoiy0NXKJCRUaF/krfaGmans=;
        b=ReoLZQLBHPySPW51KGoM/7RT1Vj0bsVV9GTXf5TzClcfkn3aodz34fxL63Sb3/PmTO
         LbFYKuOjjOHVLnNpyfKMSTLlhPgu1Sq28txeykZQUtaEiLSVRrDtWYadtxwLHGQjEfFv
         frxKCALbAevkmjIsM2D+7+togESeGjB4dLM/hRKt31SlXO7bg1Gy+ENVyTHlJ4y9x9xu
         FJSy22f4hJ0PSYXyd5qQKQiYgCkxWYpeKSHPia3xalGeAlruvhNBFiPYq2+pQRRendFs
         H0USr1m/KZNJQA1BDjC+b9c4tdA9/31G9rn86EivxfJCNx1GgP79I13tVh60dyouZWac
         mO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823287; x=1783428087;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=81yQnZbApfVfIiH8t8XJoiy0NXKJCRUaF/krfaGmans=;
        b=Ld7QBW2Zrp4QjDW3TygG4J1WPBM+1bgmQ7FfUAlabizi7VeuXqv9cyMhId2yHjYrrw
         iDj5nY4dPw7fV4ISGb+KnZk/SnKh0NB5hdYwi4a7VF6X8pWnYxoicdaRoKoxMbpdb5h/
         oN4w05xHms95cN99KOKleSqjT3QbaHvvqnjmYvO9OLJPS54elnK1hqRyavtaZ6F7C//q
         +KYBPzd7zP9CnrRIE63mJATXbaTYy1m10WM+IKKfmv98HJywvCfhXongt+NmjGc06KFz
         bgBK4RShsQXEKGa+BivI93QYoBJ8uExEvYY3ezsiVCUXRKOVk0j/244SACBDMG9osHAr
         oiig==
X-Forwarded-Encrypted: i=1; AFNElJ/2NmECB251QDYolsI93YaQ6jsTBLxmW7owZ6KHedyNtjXnR/wptvJ5BtKsgHCSHF6jWf18O8A=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxPHCvuNnr+uI61/SU+C3/T6kV7Oc/cqDkdef5bwdiRJd1zW7qK
	bUaBFquDwtWqVz4knKwl0REJYVg6K5oGxE1JX0rDRAtKwySLdfNjAPThzfVm6l+VCyyEwcpTTQh
	cQC+YPvwlkjEK32XCLRu+bBeSiq9RiiVldIvDgaHjH4xT6bK7IxCSxA7wcTLlgVeJ7C8NDdKk
X-Gm-Gg: AfdE7cnQ1iz+RBeD79Sfq85laUqFGTAzVfQjasP8HIUtw5UaybFdqzzvfZAPzXPd5gx
	XRoiJNIexEuSeoDdb5Nw9cjp1DDwM3rB0v3KpeUAjVrF+q+hf7FSaln9r4olCzmr4t9upB5a/Lt
	DJkhxa7lCZ7BsudgDYn03+N1lZi+LWuib9U4+YZCdMqXN+1Rud4HGIZsMENWnyoGNBXROIpzFNk
	l5LpFTpZWq1fsy0XYdkkh8Nye+okCTGP7Z9Ut3mWZHtk2gqvKK5EGyGRuItoWg1F4tQEMBAd6ic
	ds70FUyNWTGMF9KX6ffujb42ojh5R9zp6eYmqJSXhpSlpVP28SpeDIGz2unBzCrhRVA2YqPQTFR
	TQpnS3yuBOCqnyI9fBY5yRV/Hwezl7nJmsKc=
X-Received: by 2002:a05:620a:8813:b0:915:4ca0:1210 with SMTP id af79cd13be357-92e62689c4amr349004085a.3.1782823287444;
        Tue, 30 Jun 2026 05:41:27 -0700 (PDT)
X-Received: by 2002:a05:620a:8813:b0:915:4ca0:1210 with SMTP id af79cd13be357-92e62689c4amr348998285a.3.1782823286896;
        Tue, 30 Jun 2026 05:41:26 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d18735sm121211466b.6.2026.06.30.05.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:41:25 -0700 (PDT)
Message-ID: <ba22eda5-bc7b-4ac3-92e8-c14c4dc13483@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:41:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/14] media: qcom: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-10-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260626133440.692849-10-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HhJAdG55rajmq3ZaAgWmlx8eaP6by2vx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX3SeiF7b4g6OM
 rAXov5SuSS13AufE5uGXQYJVyJqzkusRcrEiPtFJjB4HFIjsSzopImC/vXHF/zn4RRJRywODTZh
 GCDN5lWVFvIzgY8P3wOmxvMWY9mNzactn2vfX717mzy0CJ9+ALdvq0pc3bacXhd0tZLtcRPghcS
 bzva9HEC44f4Dpz+pkTG20ntvedTi5kAvjvLwaUvIB0QRrIz1ab0pgFEubzwF8c7qbPP+lk9uAK
 p1/nRUPkSlNWiceteytz3YqS7S5jxvCEbfB09Lq/qMbSesRSJntt4LpIsQ++xvozSQqBLfpNTuz
 SUl/Vr1MEwLcmBhy9ag5KrPhE0ONBi0O86V8LfKEvAIZrYOYJNwZ1sG7KYaitYQJ0XQ+XRpBvCu
 czAZwBIWWRTPPeF5fx92k0e8PrgfZ4IBSWuXcamvHu7BxrGro7cZcVOH9sEiwG1uRfEUAGKCNt2
 O2nLf4pTb2zR499IUNw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX26OaoeBbfmdm
 0zQPDTnp9EfDFHbazOHSlAbR/BX3Jj9WdaLzFQNTTAoVBZ1Mdsn9+4pnUNBv+zFVumbYV+a1Akm
 qnYIntxm4ypgBM66AQ6XG1P8U1Yrxh4=
X-Proofpoint-GUID: HhJAdG55rajmq3ZaAgWmlx8eaP6by2vx
X-Authority-Analysis: v=2.4 cv=PcXPQChd c=1 sm=1 tr=0 ts=6a43b978 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=GN6ll2GKXf5L_uNS5a4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.59 / 15.00];
	BAYES_HAM(-2.99)[99.97%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.222.200:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dt,netdev];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D769944AFF
X-Spamd-Bar: --
Message-ID-Hash: YWN7BIDEK3JGEKMJI3NFEDIBHKL4SRAK
X-Message-ID-Hash: YWN7BIDEK3JGEKMJI3NFEDIBHKL4SRAK
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.
 com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YWN7BIDEK3JGEKMJI3NFEDIBHKL4SRAK/>
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
> Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

[...]

>  config VIDEO_QCOM_IRIS
> -        tristate "Qualcomm iris V4L2 decoder driver"
> -        depends on VIDEO_DEV
> -        depends on ARCH_QCOM || COMPILE_TEST
> -        select V4L2_MEM2MEM_DEV
> -        select QCOM_MDT_LOADER
> -        select QCOM_SCM
> -        select QCOM_UBWC_CONFIG
> -        select VIDEOBUF2_DMA_CONTIG
> -        help
> -          This is a V4L2 driver for Qualcomm iris video accelerator
> -          hardware. It accelerates decoding operations on various
> -          Qualcomm SoCs.
> -          To compile this driver as a module choose m here.
> +	tristate "Qualcomm iris V4L2 decoder driver"
> +	depends on VIDEO_DEV
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	select V4L2_MEM2MEM_DEV
> +	select QCOM_MDT_LOADER
> +	select QCOM_SCM
> +	select QCOM_PAS

Hidden NOP addition

otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

