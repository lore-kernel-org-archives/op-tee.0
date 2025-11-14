Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D8CCEACCC
	for <op-tee@archiver.kernel.org>; Fri, 14 Nov 2025 21:26:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2D2CB5000B
	for <op-tee@archiver.kernel.org>; Fri, 14 Nov 2025 21:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1763155612;
	bh=to7r/JLznATiSuCwafk6WbIxmXJeeJvn+hHjk8MoSGE=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=piFrZ9iO8OljX8sXfNSx4oUkXR9t2cIQHZDhwkgWTL/uu0j5sO3unZKrWgiEHemAB
	 oaxQW2wh6OtZjj7ypOGMI44tzdinTfQaDeuvss1GnKEH6zuK2pzY5vAQCdcP4qbCTt
	 WYqTTcDv8vNAbWbeolaK/fEU5/eDPb70oAmUYQePdNfiuqPcjqOZj1VGzhrMj6Fyqa
	 NJRvpgJkII85z4hearvX6pgGSs9UGkIYhmDbS+SXox67lHHnhP9EtT0x9pJ64sM5bt
	 XZlQdaF2GEkwXkEp5gPpgZC0x/tgyILe1RVq3oDg+le9VfS8IQbAAuKAsEESHF7j+z
	 0T2hhgpabJ1kw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A5E554312B
	for <op-tee@lists.trustedfirmware.org>; Fri, 14 Nov 2025 21:26:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JA83ryeo;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DhfZGWcS;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AEJLpQu4150713
	for <op-tee@lists.trustedfirmware.org>; Fri, 14 Nov 2025 21:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O/T87TDYoGrkVCJEeJItquAg//RgZZsYJELTi1c+nr0=; b=JA83ryeo8hTm4Cbb
	XP2/TGap4oCxBLKJfM4bb84hYWOD1rpUN8cdu2kmcvzDFWGPXRf8NNqcCFSKiPNh
	IIvNpbRSjleGHK1reKVvylDvssa00CQwYrHfA5w0OdjIP8kXzZc9KfFdAmoYzC8f
	b/ykmBxj/mSBAVKUc8A69Es06x4/kgrx0lduyl3BsdSfxLR+LnhVfLoxUZyxK8gX
	lA9kP8dEDIx66Vn2elLUtiDmONm36ZO44ouyzlSU6Ps1+7Bk+hrggv/dM/A1v56e
	wThoANQetYfD9iq8nsAG2xRcSPdCZaz4FLrzx7vgC9ZEXOOVADbcfLfZjJ+SzgfS
	yLz7Nw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aeagyrart-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 14 Nov 2025 21:26:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b227a71fc6so81243885a.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 14 Nov 2025 13:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763155599; x=1763760399; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O/T87TDYoGrkVCJEeJItquAg//RgZZsYJELTi1c+nr0=;
        b=DhfZGWcSfNk2qXlbuhzX3mamGqeQtFAjEhQjQvxu5rp0c5aODKBPSUJj1ttVzADfgO
         KHjK49817NN5Xd8rLP5G5EtUVb4jf/cLqEIIJYWaoe3RLLsncZE2dY56L1Zo6IJUCXdD
         Ac2kVqJFHM1krwncaZfqPzQ+iWPku2iHrpycdC/rtsvYhqrw90GUs3zqeQTdO7B/L/K6
         zf1+unt8pO4LLU4g9vICBunz8gXZrh4S1heaE3eW7p1XTHvQRbt6bG29xI/x48gnETZa
         +DTIZecENQbCaLo3vKurYKNfI4St0uzzCrMACqVZsKdpoxXW8Fnu/9H3u7ESUSzj8jcm
         QmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763155599; x=1763760399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/T87TDYoGrkVCJEeJItquAg//RgZZsYJELTi1c+nr0=;
        b=Q3o4dtRHccC8W3lUUJodlqrW2RCdPnSJlyhPOE3sj4mYWjq819so2Y/IPaPGh9rhO4
         j7Ch+iE1/bzU0pERPcC4jfNfBdYbxhsPv0ZF+Vwbwis8hWjFdAyrTt1wcdw1LjD9c8k8
         FzFEuHz2NqQ9U5+0ykkX7ldgAAweGfb7s3a0I20AbjLy924rx09BZ6oOHb/UH5i62F+0
         1VITrIBncD11Y5Rh894/sT07Vs3igenD0xBAdM7UVk1+B3ajd7ZUG3do9A3WztWvSDbU
         cYYO7F5ECODMP7TfugcK9EnPxWlGSdI62Pi7BuZK7mKRUrAV555F8IirDRh1HhzdYyEZ
         DtBg==
X-Forwarded-Encrypted: i=1; AJvYcCUdOovb1GTxxeJjZt56xwweb0VNyfEanK3SJSbLM4F18TlmRf/mLKn5Bcr9QSaoZ/eQ6Z8xOWw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyXUqQdVR8+yB2KZmI8C10J/oav22B0JmJmkOoT7TaRiAYoJMq1
	GWvpRRG1nO8SeXOEusXQLTGggTHx8DpZLg7A8v79gBCvkilfDYuef6SJ7lIAMLVJD/HtlfLhOkT
	S5bCDOGTB53Yef81NS1r7vAQg/ZRGWgDC6AAOF8S8EEkGqmUk2Hcv/IUn3PG2zI/ArsoN+WECWu
	mZZ9T+
X-Gm-Gg: ASbGncuvuZjSXcL5qW30ktrDSA856EKw7WL3RUwvYTZ8nLnM1gYYwN0D4o1RLfRAab0
	S5ahphDTkqOBSiGGFkvBnJtrLQsMWV9CCrR0B0Z65q0R+kaD+ddesRn+KwNJBUHOFCANEru7KUu
	zPBu46dr8lDtUQRAv4mOvYzeUmcJpre2oZHEy6QORMbf4+NIfOmAO2pqu3UyXG2ju7qQf/j0Qaj
	lrRHirI7bYubCeUOhrB0FpsGZY37xxcdhILHQA9OC/Jm0NiYCzO/pA/pax3LvJpECHUa1DiY6nC
	X0SpviPG8hWknmgM0D3XSX40uGWg9uYAsNUvHUEoPWLVOAUajAa3A+fzCfOxnTZbjtUNe2amQ6b
	jgZ8tmendneUgGoQUVhlKLfq8tu//pFe4CHloLYCInS7uRFO3t2njSiCr
X-Received: by 2002:a05:622a:148e:b0:4ed:70bd:d9e2 with SMTP id d75a77b69052e-4edf1f2e42bmr51006361cf.0.1763155599256;
        Fri, 14 Nov 2025 13:26:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEukoq8dSiMiZ3oyN1wqbXQhwACBYXZclpv9NtieRkmXcS2fwGkP6a81CuMWAdpurpsl7K5Pg==
X-Received: by 2002:a05:622a:148e:b0:4ed:70bd:d9e2 with SMTP id d75a77b69052e-4edf1f2e42bmr51006141cf.0.1763155598824;
        Fri, 14 Nov 2025 13:26:38 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad45afsm467492766b.24.2025.11.14.13.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 13:26:38 -0800 (PST)
Message-ID: <4496bc29-b7a2-4e39-8a7a-5850b1ac2365@oss.qualcomm.com>
Date: Fri, 14 Nov 2025 22:26:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tee: qcomtee: initialize result before use in release
 worker
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>
References: <20251113-qcom-tee-fix-warning-v2-1-915a460e7d21@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251113-qcom-tee-fix-warning-v2-1-915a460e7d21@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XZetDTGzKvTnWyOtcoRMGI__0oBIxwfk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDE3NSBTYWx0ZWRfXzkElm+wqWjzU
 RwfOewH+YhG/vaO/6jpd5ExNKktaPaEOfEfYrgVxbX/IhtYLPtH0oJdtHS8U7bpAts9iaFZznYd
 UHHhtyZQEV09/PtLPds3X305gkIprmr0x7oupbnE+Gdl+sAdhVKmmMljnIgIjuFO1NjW+SKiijJ
 cc818Wd1MJ+qr1slXVaMziPqrt/NByFz73c1JHDBjYp+ApPAdla02LUyqFd0UBY2RRkyWutHLaE
 GDgN43ei9b4sqs12dpEwu1YSNtRXuGPCzvH0/GV0hkTEjBscQXNC7AYti+U6aGBrAO/hcJNuBbX
 0nAE7isGH6VEunhBQlMw74lJ4YqYki8EbzS8f6PwdcXFRDy8ouafTfZgj8KQmclG4hQqz+7UldR
 nxTqBrn6814x22i0s2kj3wUiC3Q3Nw==
X-Proofpoint-GUID: XZetDTGzKvTnWyOtcoRMGI__0oBIxwfk
X-Authority-Analysis: v=2.4 cv=Go1PO01C c=1 sm=1 tr=0 ts=69179e90 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=oOABJe4_B-9ENYzCjWEA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140175
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A5E554312B
X-Spamd-Result: default: False [-4.03 / 15.00];
	BAYES_HAM(-2.93)[99.71%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.222.199:received];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
Message-ID-Hash: UFQSJEFZN3L7CKJEUCO2KTJSMDQUBKZO
X-Message-ID-Hash: UFQSJEFZN3L7CKJEUCO2KTJSMDQUBKZO
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UFQSJEFZN3L7CKJEUCO2KTJSMDQUBKZO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Konrad Dybcio via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

On 11/14/25 4:38 AM, Amirreza Zarrabi wrote:
> Initialize result to 0 so the error path doesn't read it
> uninitialized when the invoke fails. Fixes a Smatch warning.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/op-tee/7c1e0de2-7d42-4c6b-92fe-0e4fe5d650b5@oss.qualcomm.com/
> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
