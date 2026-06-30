Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A43C43458
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:26:39 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E2FDA44E59
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782822399;
	bh=NoqTc953wGUfCirDeH3SqH5nOnq9U+JWJtIMrbyMGAc=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=DcI/m7aNFTdWOOCrj+RHNwHwqfSCLHsUOzKgCvyAz7IhHBhOal/he2TXjhc4JPNFu
	 /m7HRQhHgZ0iHy4ppwtRHZ1fhi25vil1FaxuUqGFKeRAMmaQX9xpByZN03e8znFAQ+
	 rP1mvVUgP4Lhde8j68XXg35dYVZaLzSAPM0gVXJQoCpSCK4ix5W2yDg/MXogA0WIou
	 taWW6C2a0GwoFGoSevnzuW2/teuFbi63CxTqa5YK4ayIrvIL/u4WTPa/9QkpHElSBR
	 Pu0EL639fUfJFFdLE6NzyhlAOpMg+/sg/dsWGO7DLXx5nbKjjulC7pWvMoiMbLsCTT
	 OuVpuQkow7Y6w==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8DCB844DE5
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:26:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kEQp0xcl;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JW53j0q8;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n1KV1573393
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Em4j1rjfTFXHEN5Lun83H7ijLdbaGF+xPI/HxI4Nw7k=; b=kEQp0xcloYmwQX4c
	kvEzpYrN1l5EVudiD7/Ekt1BdyifNskaaBNsuAayUDPXO09VfiZH3G9rkoNG/8nF
	W4/BwOAxCCgx3DbwpAchJG4MMTgpLsVPEbFPIPRLs2Cd0Rnf6XipGK9EutlPEc6V
	JIHMdAD8LSjmwjJfDtDtObrtEv2erqSfEgSdt0e7alfCGwS+PKE35UXxWJRKTloH
	pPJCM0IvNj4byRf/eUq5bFvN9q4FlvKbOO7lvX2ExBviaM+TU1onx7PIrbIURsdZ
	8/7ws8eoOAKm+tTQvmWPQoxGjl8N+jV0zu4N7hNqI8EQbch0h2TQuauam303UYl5
	ZjQcig==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f468625pg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:26:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e566bae1bso41742885a.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 05:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782822391; x=1783427191; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Em4j1rjfTFXHEN5Lun83H7ijLdbaGF+xPI/HxI4Nw7k=;
        b=JW53j0q8+xUSmY59ip5sYDTGSdPO5iV7YJ5XqKlkaUXH7aXiTaILSZSU0KphB64lLa
         WQ92sGbN9iiWvz7Al1IbthauIxQlKA0KMvt2nzhx8e8/JspQxlp8eCB0GwOjKwB7dZHG
         rU+6KKGdTqktK1HvnxXTEUusy0JG40Lnr6G32JMkbdA4FkmvvdgA75a58TkosdWyK+C/
         mfD0yOAv+jlU1W7DUl1i+9at8H/rB9tEvMA0GS0OY0GegOsCYxtOi2xYJT9atBeBO/kQ
         JE5eaqsg461ihD5ZGVaHdbY31DMpXNH4B6P7oEtTBokL4ZDokuambkeEB9BBmEjcO4Pu
         BbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782822391; x=1783427191;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Em4j1rjfTFXHEN5Lun83H7ijLdbaGF+xPI/HxI4Nw7k=;
        b=Ggd5nKS3ZuwU4sCiZ3kA5W7Of9M3efjbk69sRxzYMvGFmodc5l5I1u58yiAODfuTBL
         aX/KQaSXL2JFflstgX0itGu6ehP3V7B74S44qZP2TNyFe2XgSVEhy8Zak2apC4oTqre6
         WfVA0geHjgE/TMCDgvZsE5E37J4Q8dfzs/WErISYOKVWrDKKvthRhOHXgA/Uj+7RMZGC
         4y+Fv4agIj9cihDtx+5RY8NhL207Fmkqjk77Q1BEE0JZLNdtiQTeUJWFpbHKrdz0/RTF
         vwGkIUH8z2lesMQqLeoFseZrJAEURF8BRZpgleDQYneY8XoNuYbDfumvJWu3dyxBNKxv
         U8YA==
X-Forwarded-Encrypted: i=1; AFNElJ9mOn1FkNA+rVDdL4Psk49SrLMrWZiZIRzNvSwju2Iwa6hsu69TR7lzeNFOr++Fa6TNn0XZdc0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxOiqKIABv3m8EzaIEY/pLNY1hgTRbLkPapnyx8AyVnvs8mH+/r
	WMkIz5ft3H3lcKcfvCFDaWYRL0ae3wG/yloKJ+BbkXBTL0zK6jFEOhkcxMZ7PsWZ4WLQY9Y/tLj
	+ebLm3Ac0FJ93+ytzLaMN1sO2xp8LTFLuJAQMoGtIHHRq758sCgAXTBLCJiS86LhEOcx3T0A/
X-Gm-Gg: AfdE7clnDmJBQK4ugIGqP2nbxda2QIOnWr8j0HXRC5B2/AIB9g2UOoclI8pYW/Je2Vb
	ojMuL7QHRGRCVbfYQFGXt2ZOASkBY2kdAHh1WURUijNTJi0XTEnJTwKRGuJGW7V59g6xjqoUUL+
	+lTOyDCC/qj4Fxa7i63qNKu2qkuN4D1CZcCqwIcG+ofoOyPUWm/ci5H5yVs/dod7bReJcGthC54
	n+1bTcn/Z/dUsT6WB/QvIFDAzMACzxT7Yjsdpz9lv5A5sOrZaQffsVSnkS9Ipq4VjaawYauUzNi
	YICTWCsfufN0khwdFpnnHftJjTZOmZtPQBW//bEyYFuQ/hED60iWzvL+K3TzUlf5Gk8DWFC+K4h
	ovRgVG2UWiJqiJ+d+fGGJ9W/eAO6GztnPcD0=
X-Received: by 2002:a05:620a:6018:b0:920:798b:e290 with SMTP id af79cd13be357-92e62873bb7mr367987185a.7.1782822391309;
        Tue, 30 Jun 2026 05:26:31 -0700 (PDT)
X-Received: by 2002:a05:620a:6018:b0:920:798b:e290 with SMTP id af79cd13be357-92e62873bb7mr367979785a.7.1782822390742;
        Tue, 30 Jun 2026 05:26:30 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f4c19esm116380066b.51.2026.06.30.05.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:26:29 -0700 (PDT)
Message-ID: <e372e66d-7df6-49f2-9530-0c61ad43a18e@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:26:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/14] firmware: qcom_scm: Migrate to generic PAS
 service
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-3-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260626133440.692849-3-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _mJvpT5asuag06Gl3xYAFxUh4b6bFpuV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNSBTYWx0ZWRfX4jc08l7agClJ
 llQUafCr+H88JG2vOmz8ZGWbcynlbpIRuabj/JdM8W/AJjjoHe0fkvVKYchRFp7LwGAIppcOOZd
 oW9Tj8U/ol/hYItMKCy5G3f18fbTMXE1zDqgNIWTotLG5RsuTBIfjNMjQhgXVjEGfXEEaX+GoBp
 vE2o9WIGX1F6DHB+rJfQrdnJNoJVKKDiABTc/zmdNFKgbnL+ZqxIxShIduGD71pGMLrIFXuG9c/
 SxxvgcO7T6PXWagFbGJS8cRWjgcYcg2SY8Bd64MfAulCK2OIXIxYInej8OfbWWFEXks4Wg/GIXC
 Xua6uESI42F/8gFRTfmIV2kl22A1Y6GVdws3M2V9ZS8/AXHSBfN/icLGaJvQiRkHqyfaiOdpm0L
 56Gx+6fqDrWVBnoNV07DYyjW3ark13B5qZWuI2+VRSL/hvANeRZ196mb8fRkdDf/cKWo8nxLpOx
 hM54HPTEcBBQn27kiPA==
X-Proofpoint-GUID: _mJvpT5asuag06Gl3xYAFxUh4b6bFpuV
X-Authority-Analysis: v=2.4 cv=FbcHAp+6 c=1 sm=1 tr=0 ts=6a43b5f7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=TJYwRQMSshrBWr6rMVAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNSBTYWx0ZWRfX1LuKSxSOt0CD
 n5tVWQu85cKpgUwANhQ5pSYP7RB+FvbCFUKxSWSmlozmQfliKKK9hNtBHZOcoNN51NhkKW64/9g
 vXiD75vgyqDlx1qjWZBk2v4MqdWwKDU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300115
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.222.199:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8DCB844DE5
X-Spamd-Bar: ---
Message-ID-Hash: O5W6SGLGLFV2CVHULFBTF4I4R36ZQXJQ
X-Message-ID-Hash: O5W6SGLGLFV2CVHULFBTF4I4R36ZQXJQ
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.
 com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/O5W6SGLGLFV2CVHULFBTF4I4R36ZQXJQ/>
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
> With the availability of generic PAS service, let's add SCM calls as
> a backend to keep supporting legacy QTEE interfaces. The exported
> qcom_scm* wrappers will get dropped once all the client drivers get
> migrated as part of future patches.
> 
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

[...]

>  struct qcom_scm_pas_context *devm_qcom_scm_pas_context_alloc(struct device *dev,
>  							     u32 pas_id,
>  							     phys_addr_t mem_phys,
>  							     size_t mem_size)
>  {
> -	struct qcom_scm_pas_context *ctx;
> +	struct qcom_pas_context *ctx;
>  
>  	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
> @@ -600,11 +569,12 @@ struct qcom_scm_pas_context *devm_qcom_scm_pas_context_alloc(struct device *dev,
>  	ctx->mem_phys = mem_phys;
>  	ctx->mem_size = mem_size;
>  
> -	return ctx;
> +	return (struct qcom_scm_pas_context *)ctx;

"please don't explode"

otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

